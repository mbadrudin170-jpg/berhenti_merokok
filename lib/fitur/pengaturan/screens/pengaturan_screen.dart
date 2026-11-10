import 'dart:async';

import 'package:berhenti_merokok/fitur/cadangan/screens/cadangan_screen.dart';
import 'package:berhenti_merokok/fitur/diary_craving/helper/pola_craving_helper.dart';
import 'package:berhenti_merokok/fitur/diary_craving/model/diary_craving_model.dart';
import 'package:berhenti_merokok/fitur/diary_craving/notifier/diary_craving_notifier.dart';
import 'package:berhenti_merokok/fitur/tema/enum/tema_enum.dart';
import 'package:berhenti_merokok/fitur/tema/notifier/tema_notifier.dart';
import 'package:berhenti_merokok/shared/notifikasi/notifikasi_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman pengaturan aplikasi, termasuk pilihan tema dan notifikasi.
class PengaturanScreen extends ConsumerStatefulWidget {
  const PengaturanScreen({super.key});

  @override
  ConsumerState<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends ConsumerState<PengaturanScreen> {
  bool _notifikasiAktif = false;
  int _jam = 8;
  int _menit = 0;
  bool _memuatNotifikasi = true;
  bool _sedangMemproses = false;

  // Check-in pagi.
  bool _checkinPagiAktif = false;
  int _checkinPagiJam = 7;
  int _checkinPagiMenit = 0;

  // Pengingat pola craving.
  bool _polaCravingAktif = false;

  @override
  void initState() {
    super.initState();
    unawaited(
      Future.microtask(_muatPreferensiNotifikasi)
          .catchError((Object e, StackTrace s) {
            L.e('Gagal memuat preferensi notifikasi: $e $s');
          }),
    );
  }

  Future<void> _muatPreferensiNotifikasi() async {
    L.i('PengaturanScreen initState notifikasi');
    try {
      final aktif = await NotifikasiService.aktif();
      final jam = await NotifikasiService.jam();
      final menit = await NotifikasiService.menit();
      final checkinPagiAktif = await NotifikasiService.aktifCheckinPagi();
      final checkinPagiJam = await NotifikasiService.jamCheckinPagi();
      final checkinPagiMenit = await NotifikasiService.menitCheckinPagi();
      final polaCravingAktif = await NotifikasiService.aktifPolaCraving();
      if (!mounted) return;
      setState(() {
        _notifikasiAktif = aktif;
        _jam = jam;
        _menit = menit;
        _checkinPagiAktif = checkinPagiAktif;
        _checkinPagiJam = checkinPagiJam;
        _checkinPagiMenit = checkinPagiMenit;
        _polaCravingAktif = polaCravingAktif;
        _memuatNotifikasi = false;
      });
      L.i(
        'aktif=$aktif, jam=$jam, menit=$menit, checkinPagi=$checkinPagiAktif, polaCraving=$polaCravingAktif',
      );
    } on Exception catch (e, s) {
      L.e('Gagal memuat preferensi notifikasi: $e $s');
      if (mounted) {
        setState(() {
          _memuatNotifikasi = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _ubahTema(TemaEnum tema) async {
    L.i('tema=$tema');
    try {
      await ref.read(temaProvider.notifier).set(tema);
    } on Exception catch (e, s) {
      L.e('Gagal mengubah tema: $e $s');
    }
  }

  Future<void> _ubahNotifikasi(bool value) async {
    if (_sedangMemproses) return;
    L.i('value=$value');
    setState(() {
      _sedangMemproses = true;
      _notifikasiAktif = value;
    });
    unawaited(
      EasyLoading.show(
        status: 'Memproses...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
      }),
    );
    try {
      if (value) {
        final izin = await NotifikasiService.mintaIzin();
        if (!mounted) return;
        if (!izin) {
          setState(() {
            _notifikasiAktif = false;
          });
          AppToast.gagal(context, 'Izin notifikasi tidak diberikan');
          return;
        }
        await NotifikasiService.jadwalkanPengingatHarian(
          jam: _jam,
          menit: _menit,
        );
        if (!mounted) return;
        AppToast.sukses(context, 'Pengingat harian diaktifkan');
      } else {
        await NotifikasiService.batalkanPengingatHarian();
        if (!mounted) return;
        AppToast.info(context, 'Pengingat harian dinonaktifkan');
      }
    } on Exception catch (e, s) {
      L.e('Gagal mengubah notifikasi: $e $s');
      if (mounted) {
        final isIzin = e is IzinNotifikasiTidakDiberikanException;
        try {
          final aktifSekarang = await NotifikasiService.aktif();
          if (!mounted) return;
          setState(() {
            _notifikasiAktif = aktifSekarang;
          });
        } on Exception catch (e2, s2) {
          L.e('Gagal membaca status aktif notifikasi: $e2 $s2');
        }
        if (isIzin) {
          if (mounted) {
            AppToast.gagal(context, 'Izin notifikasi tidak tersedia');
          }
          try {
            await _muatPreferensiNotifikasi();
          } on Exception catch (e2, s2) {
            L.e('Gagal memuat preferensi notifikasi: $e2 $s2');
          }
          if (!mounted) return;
        } else if (mounted) {
          AppToast.gagal(context, 'Gagal mengubah pengingat harian');
        }
      }
    } on UnsupportedError catch (e, s) {
      L.e('Platform tidak mendukung notifikasi: $e $s');
      if (mounted) {
        setState(() {
          _notifikasiAktif = false;
        });
        AppToast.gagal(context, 'Platform tidak mendukung pengingat harian');
      }
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  Future<void> _pilihWaktu() async {
    if (_sedangMemproses) return;
    L.i('jam=$_jam, menit=$_menit');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _jam, minute: _menit),
    );
    if (!mounted) return;
    if (picked == null) return;
    L.i('picked=${picked.hour}:${picked.minute}');
    final jamLama = _jam;
    final menitLama = _menit;
    final jamBaru = picked.hour;
    final menitBaru = picked.minute;
    setState(() {
      _sedangMemproses = true;
    });
    unawaited(
      EasyLoading.show(
        status: 'Memproses...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
      }),
    );
    try {
      if (_notifikasiAktif) {
        await NotifikasiService.jadwalkanPengingatHarian(
          jam: jamBaru,
          menit: menitBaru,
        );
        if (!mounted) return;
        setState(() {
          _jam = jamBaru;
          _menit = menitBaru;
        });
        AppToast.sukses(context, 'Waktu pengingat diperbarui');
      } else {
        await NotifikasiService.setWaktu(jamBaru, menitBaru);
        if (!mounted) return;
        setState(() {
          _jam = jamBaru;
          _menit = menitBaru;
        });
      }
    } on Exception catch (e, s) {
      L.e('Gagal memperbarui waktu pengingat: $e $s');
      if (mounted) {
        setState(() {
          _jam = jamLama;
          _menit = menitLama;
        });
        AppToast.gagal(context, 'Gagal memperbarui waktu pengingat');
      }
    } on UnsupportedError catch (e, s) {
      L.e('Platform tidak mendukung notifikasi: $e $s');
      if (mounted) {
        setState(() {
          _jam = jamLama;
          _menit = menitLama;
        });
        AppToast.gagal(context, 'Platform tidak mendukung pengingat harian');
      }
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  Future<void> _ubahCheckinPagi(bool value) async {
    if (_sedangMemproses) return;
    L.i('checkinPagi value=$value');
    setState(() {
      _sedangMemproses = true;
      _checkinPagiAktif = value;
    });
    unawaited(
      EasyLoading.show(
        status: 'Memproses...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
      }),
    );
    try {
      if (value) {
        final izin = await NotifikasiService.mintaIzin();
        if (!mounted) return;
        if (!izin) {
          setState(() {
            _checkinPagiAktif = false;
          });
          AppToast.gagal(context, 'Izin notifikasi tidak diberikan');
          return;
        }
        await NotifikasiService.jadwalkanCheckinPagi(
          jam: _checkinPagiJam,
          menit: _checkinPagiMenit,
        );
        if (!mounted) return;
        AppToast.sukses(context, 'Check-in pagi diaktifkan');
      } else {
        await NotifikasiService.batalkanCheckinPagi();
        if (!mounted) return;
        AppToast.info(context, 'Check-in pagi dinonaktifkan');
      }
    } on Exception catch (e, s) {
      L.e('Gagal mengubah check-in pagi: $e $s');
      if (mounted) {
        final isIzin = e is IzinNotifikasiTidakDiberikanException;
        try {
          final aktifSekarang = await NotifikasiService.aktifCheckinPagi();
          if (!mounted) return;
          setState(() {
            _checkinPagiAktif = aktifSekarang;
          });
        } on Exception catch (e2, s2) {
          L.e('Gagal membaca status aktif check-in pagi: $e2 $s2');
        }
        if (isIzin) {
          if (mounted) {
            AppToast.gagal(context, 'Izin notifikasi tidak tersedia');
          }
          try {
            await _muatPreferensiNotifikasi();
          } on Exception catch (e2, s2) {
            L.e('Gagal memuat preferensi notifikasi: $e2 $s2');
          }
          if (!mounted) return;
        } else if (mounted) {
          AppToast.gagal(context, 'Gagal mengubah check-in pagi');
        }
      }
    } on UnsupportedError catch (e, s) {
      L.e('Platform tidak mendukung notifikasi: $e $s');
      if (mounted) {
        setState(() {
          _checkinPagiAktif = false;
        });
        AppToast.gagal(context, 'Platform tidak mendukung check-in pagi');
      }
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  Future<void> _pilihWaktuCheckinPagi() async {
    if (_sedangMemproses) return;
    L.i('checkinPagi jam=$_checkinPagiJam, menit=$_checkinPagiMenit');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _checkinPagiJam, minute: _checkinPagiMenit),
    );
    if (!mounted) return;
    if (picked == null) return;
    L.i('picked=${picked.hour}:${picked.minute}');
    final jamLama = _checkinPagiJam;
    final menitLama = _checkinPagiMenit;
    final jamBaru = picked.hour;
    final menitBaru = picked.minute;
    setState(() {
      _sedangMemproses = true;
    });
    unawaited(
      EasyLoading.show(
        status: 'Memproses...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
      }),
    );
    try {
      if (_checkinPagiAktif) {
        await NotifikasiService.jadwalkanCheckinPagi(
          jam: jamBaru,
          menit: menitBaru,
        );
        if (!mounted) return;
        setState(() {
          _checkinPagiJam = jamBaru;
          _checkinPagiMenit = menitBaru;
        });
        AppToast.sukses(context, 'Waktu check-in pagi diperbarui');
      } else {
        await NotifikasiService.setWaktuCheckinPagi(jamBaru, menitBaru);
        if (!mounted) return;
        setState(() {
          _checkinPagiJam = jamBaru;
          _checkinPagiMenit = menitBaru;
        });
      }
    } on Exception catch (e, s) {
      L.e('Gagal memperbarui waktu check-in pagi: $e $s');
      if (mounted) {
        setState(() {
          _checkinPagiJam = jamLama;
          _checkinPagiMenit = menitLama;
        });
        AppToast.gagal(context, 'Gagal memperbarui waktu check-in pagi');
      }
    } on UnsupportedError catch (e, s) {
      L.e('Platform tidak mendukung notifikasi: $e $s');
      if (mounted) {
        setState(() {
          _checkinPagiJam = jamLama;
          _checkinPagiMenit = menitLama;
        });
        AppToast.gagal(context, 'Platform tidak mendukung check-in pagi');
      }
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  Future<void> _ubahPolaCraving(bool value) async {
    if (_sedangMemproses) return;
    L.i('polaCraving value=$value');
    setState(() {
      _sedangMemproses = true;
      _polaCravingAktif = value;
    });
    unawaited(
      EasyLoading.show(
        status: 'Memproses...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
      }),
    );
    try {
      if (value) {
        final izin = await NotifikasiService.mintaIzin();
        if (!mounted) return;
        if (!izin) {
          setState(() {
            _polaCravingAktif = false;
          });
          AppToast.gagal(context, 'Izin notifikasi tidak diberikan');
          return;
        }
        // Baca data diary craving untuk menghitung jam teratas.
        final diaryAsync = ref.read(diaryCravingProvider);
        final daftar = diaryAsync.asData?.value.listCraving ?? <DiaryCravingModel>[];
        final jam = PolaCravingHelper.jamTeratas(daftar);
        if (jam == null) {
          // Data belum cukup, simpan preferensi aktif tanpa jadwal.
          await NotifikasiService.setAktifPolaCraving(true);
          if (!mounted) return;
          AppToast.info(context, 'Pengingat pola craving aktif (data craving belum cukup)');
        } else {
          await NotifikasiService.jadwalkanPolaCraving(jam);
          if (!mounted) return;
          AppToast.sukses(context, 'Pengingat pola craving diaktifkan (jam $jam:00)');
        }
      } else {
        await NotifikasiService.batalkanPolaCraving();
        if (!mounted) return;
        AppToast.info(context, 'Pengingat pola craving dinonaktifkan');
      }
    } on Exception catch (e, s) {
      L.e('Gagal mengubah pola craving: $e $s');
      if (mounted) {
        final isIzin = e is IzinNotifikasiTidakDiberikanException;
        try {
          final aktifSekarang = await NotifikasiService.aktifPolaCraving();
          if (!mounted) return;
          setState(() {
            _polaCravingAktif = aktifSekarang;
          });
        } on Exception catch (e2, s2) {
          L.e('Gagal membaca status aktif pola craving: $e2 $s2');
        }
        if (isIzin) {
          if (mounted) {
            AppToast.gagal(context, 'Izin notifikasi tidak tersedia');
          }
          try {
            await _muatPreferensiNotifikasi();
          } on Exception catch (e2, s2) {
            L.e('Gagal memuat preferensi notifikasi: $e2 $s2');
          }
          if (!mounted) return;
        } else if (mounted) {
          AppToast.gagal(context, 'Gagal mengubah pola craving');
        }
      }
    } on UnsupportedError catch (e, s) {
      L.e('Platform tidak mendukung notifikasi: $e $s');
      if (mounted) {
        setState(() {
          _polaCravingAktif = false;
        });
        AppToast.gagal(context, 'Platform tidak mendukung pola craving');
      }
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  Future<void> _ujiNotifikasi() async {
    if (_sedangMemproses) return;
    L.i('uji notifikasi');
    setState(() {
      _sedangMemproses = true;
    });
    unawaited(
      EasyLoading.show(
        status: 'Memproses...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
      }),
    );
    try {
      await NotifikasiService.tampilkanSekarang();
      if (!mounted) return;
      AppToast.info(context, 'Notifikasi uji coba ditampilkan');
    } on Exception catch (e, s) {
      L.e('Gagal menampilkan notifikasi uji coba: $e $s');
      if (!mounted) return;
      AppToast.gagal(context, 'Gagal menampilkan notifikasi');
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [_buildTema(), _buildNotifikasi(), _buildCadangan()],
        ),
      ),
    );
  }

  Widget _buildTema() {
    final temaAsync = ref.watch(temaProvider);
    L.i('temaAsync=$temaAsync');
    if (temaAsync.isLoading) {
      L.w('tema loading');
      return const SizedBox.shrink();
    }
    if (temaAsync.hasError) {
      L.w('tema error');
      return const SizedBox.shrink();
    }
    final temaSaatIni = temaAsync.requireValue;
    L.i('temaSaatIni=$temaSaatIni');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Tema', style: Theme.of(context).textTheme.bodyMedium),
        PopupMenuButton<TemaEnum>(
          initialValue: temaSaatIni,
          onSelected: (tema) {
            unawaited(_ubahTema(tema));
          },
          itemBuilder: (context) => TemaEnum.values
              .map(
                (tema) => PopupMenuItem<TemaEnum>(
                  value: tema,
                  child: Row(
                    spacing: 8,
                    children: [Icon(tema.icon), Text(tema.label)],
                  ),
                ),
              )
              .toList(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(temaSaatIni.icon),
              Text(temaSaatIni.label),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotifikasi() {
    if (_memuatNotifikasi) {
      return const Center(child: CircularProgressIndicator());
    }
    // Platform yang tidak mendukung notifikasi terjadwal (Web, Linux, Windows).
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows) {
      return const SizedBox.shrink();
    }
    final waktu =
        '${_jam.toString().padLeft(2, '0')}:${_menit.toString().padLeft(2, '0')}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pengingat harian',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Switch(
              value: _notifikasiAktif,
              onChanged: _sedangMemproses
                  ? null
                  : (value) {
                      unawaited(_ubahNotifikasi(value));
                    },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Waktu: $waktu', style: Theme.of(context).textTheme.bodySmall),
            OutlinedButton(
              onPressed: _sedangMemproses
                  ? null
                  : () {
                      unawaited(_pilihWaktu());
                    },
              child: const Text('Ubah waktu'),
            ),
          ],
        ),
        OutlinedButton(
          onPressed: _sedangMemproses
              ? null
              : () {
                  unawaited(_ujiNotifikasi());
                },
          child: const Text('Uji coba notifikasi'),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Check-in Pagi',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Switch(
              value: _checkinPagiAktif,
              onChanged: _sedangMemproses
                  ? null
                  : (value) {
                      unawaited(_ubahCheckinPagi(value));
                    },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Waktu: ${_checkinPagiJam.toString().padLeft(2, '0')}:${_checkinPagiMenit.toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            OutlinedButton(
              onPressed: _sedangMemproses
                  ? null
                  : () {
                      unawaited(_pilihWaktuCheckinPagi());
                    },
              child: const Text('Ubah waktu'),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pengingat Pola Craving',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Switch(
              value: _polaCravingAktif,
              onChanged: _sedangMemproses
                  ? null
                  : (value) {
                      unawaited(_ubahPolaCraving(value));
                    },
            ),
          ],
        ),
        if (_polaCravingAktif)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Jadwal otomatis pada jam craving teratas (min. 3 entri diary).',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }

  Widget _buildCadangan() {
    L.i('PengaturanScreen build cadangan');
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        'Cadangan & Ekspor Data',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        unawaited(
          Nav.to(context, const CadanganScreen()).catchError((
            Object e,
            StackTrace s,
          ) {
            L.e('Gagal navigasi ke Cadangan: $e $s');
            return null;
          }),
        );
      },
    );
  }
}
