import 'dart:async';

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
      if (!mounted) return;
      setState(() {
        _notifikasiAktif = aktif;
        _jam = jam;
        _menit = menit;
        _memuatNotifikasi = false;
      });
      L.i('aktif=$aktif, jam=$jam, menit=$menit');
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
          children: [_buildTema(), _buildNotifikasi()],
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
      ],
    );
  }
}
