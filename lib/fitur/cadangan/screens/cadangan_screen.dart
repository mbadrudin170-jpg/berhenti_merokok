import 'dart:async';
import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/alasan_berhenti/notifier/alasan_berhenti_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/cadangan/helper/cadangan_helper.dart';
import 'package:berhenti_merokok/fitur/diary_craving/notifier/diary_craving_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
// Provider refresh tambahan: tabel konsumsi_rokok, sos_intervensi, dan
// rencana_darurat ikut dipulihkan CadanganHelper, jadi providernya juga
// harus disegarkan agar UI tidak menampilkan data lama.
import 'package:berhenti_merokok/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart';
import 'package:berhenti_merokok/fitur/rencana_darurat/notifier/rencana_darurat_notifier.dart';
import 'package:berhenti_merokok/fitur/sos_craving/notifier/sos_intervensi_notifier.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_global_saya/core_shared.dart';

/// Layar khusus cadangan dan ekspor data lokal.
class CadanganScreen extends ConsumerStatefulWidget {
  /// Membuat layar cadangan.
  const CadanganScreen({super.key});

  @override
  ConsumerState<CadanganScreen> createState() => _CadanganScreenState();
}

class _CadanganScreenState extends ConsumerState<CadanganScreen> {
  bool _sedangMemproses = false;

  bool get _platformDidukung {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows;
  }

  Future<void> _eksporData() async {
    if (_sedangMemproses) return;
    L.i('CadanganScreen eksporData');
    if (!_platformDidukung) {
      L.w('Platform tidak mendukung cadangan berkas');
      if (!mounted) return;
      AppToast.gagal(context, 'Platform tidak mendukung ekspor berkas');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Ekspor Data',
      message:
          'Cadangan akan memuat biodata, impian, diary craving, dan alasan '
          'berhenti. Lanjutkan ekspor?',
      okLabel: 'Ekspor',
      cancelLabel: 'Batal',
    );
    if (!mounted) return;
    if (konfirmasi != OkCancelResult.ok) {
      L.w('Ekspor dibatalkan pengguna');
      return;
    }

    setState(() {
      _sedangMemproses = true;
    });
    unawaited(
      EasyLoading.show(
        status: 'Mengekspor data...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading ekspor: $e $s');
      }),
    );
    try {
      final json = await CadanganHelper.buatCadanganJson();
      final namaBerkas =
          'berhenti_merokok_cadangan_${DateTime.now().millisecondsSinceEpoch}.json';
      final bytes = Uint8List.fromList(utf8.encode(json));
      final mime = 'application/json';

      String? pathSimpan;
      if (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS) {
        final direktori = await getApplicationDocumentsDirectory();
        pathSimpan = '${direktori.path}/$namaBerkas';
        await CadanganHelper.tulisCadanganKeBerkas(pathSimpan, json);
      } else {
        final uri = await FilePicker.saveFile(
          dialogTitle: 'Simpan cadangan',
          fileName: namaBerkas,
          bytes: bytes,
          mimeType: mime,
          initialDirectory: (await getApplicationDocumentsDirectory()).path,
        );
        if (uri == null) {
          L.w('Pengguna membatalkan pemilihan lokasi simpan');
          if (!mounted) return;
          AppToast.info(context, 'Ekspor dibatalkan');
          return;
        }
        pathSimpan = uri.toFilePath();
        // saveFile menulis bytes pada sebagian platform; pastikan isi sama.
        try {
          await CadanganHelper.tulisCadanganKeBerkas(pathSimpan, json);
        } on Exception catch (e, s) {
          L.w('Tulis ulang cadangan ke path terpilih gagal: $e $s');
        }
      }
      L.i('pathSimpan=$pathSimpan');
      if (!mounted) return;
      AppToast.sukses(context, 'Cadangan berhasil disimpan');
    } on Exception catch (e, s) {
      L.e('Gagal mengekspor data: $e $s');
      if (!mounted) return;
      AppToast.gagal(context, 'Gagal mengekspor data');
    } on UnsupportedError catch (e, s) {
      L.e('Ekspor tidak didukung: $e $s');
      if (!mounted) return;
      AppToast.gagal(context, 'Platform tidak mendukung ekspor');
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading ekspor: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  Future<void> _eksporCsv() async {
    if (_sedangMemproses) return;
    L.i('CadanganScreen eksporCsv');
    if (!_platformDidukung) {
      L.w('Platform tidak mendukung cadangan berkas');
      if (!mounted) return;
      AppToast.gagal(context, 'Platform tidak mendukung ekspor berkas');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Ekspor CSV',
      message:
          'Ekspor ${tabelCadangan.length} berkas CSV (satu berkas per tabel). '
          'Lokasi penyimpanan dipilih satu per berkas. Lanjutkan ekspor?',
      okLabel: 'Ekspor',
      cancelLabel: 'Batal',
    );
    if (!mounted) return;
    if (konfirmasi != OkCancelResult.ok) {
      L.w('Ekspor CSV dibatalkan pengguna');
      return;
    }

    setState(() {
      _sedangMemproses = true;
    });
    unawaited(
      EasyLoading.show(
        status: 'Mengekspor CSV...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading ekspor CSV: $e $s');
      }),
    );
    try {
      var jumlahBerkas = 0;
      for (final tabel in tabelCadangan) {
        final csv = await CadanganHelper.buatCsvTabel(tabel);
        final namaBerkas = CadanganHelper.namaBerkasCsv(tabel);
        final bytes = Uint8List.fromList(utf8.encode(csv));

        final uri = await FilePicker.saveFile(
          dialogTitle: 'Simpan CSV $tabel',
          fileName: namaBerkas,
          bytes: bytes,
          mimeType: 'text/csv',
          initialDirectory: (await getApplicationDocumentsDirectory()).path,
        );
        if (uri == null) {
          L.w('Pengguna membatalkan penyimpanan CSV tabel $tabel');
          if (!mounted) return;
          AppToast.info(context, 'Ekspor CSV dibatalkan');
          return;
        }
        // saveFile sudah menulis bytes ke lokasi terpilih; tidak perlu
        // tulis ulang (mencegah berkas terhapus saat tulis ulang gagal).
        jumlahBerkas++;
        L.i('CSV tabel $tabel disimpan ke $uri');
      }
      if (!mounted) return;
      AppToast.sukses(context, 'Ekspor CSV berhasil ($jumlahBerkas berkas)');
    } on UnsupportedError catch (e, s) {
      L.e('Ekspor CSV tidak didukung: $e $s');
      if (!mounted) return;
      AppToast.gagal(context, 'Platform tidak mendukung ekspor CSV');
    } on Exception catch (e, s) {
      L.e('Gagal mengekspor CSV: $e $s');
      if (!mounted) return;
      AppToast.gagal(context, 'Gagal mengekspor CSV');
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading ekspor CSV: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  Future<void> _pulihkanData() async {
    if (_sedangMemproses) return;
    L.i('CadanganScreen pulihkanData');
    if (!_platformDidukung) {
      L.w('Platform tidak mendukung cadangan berkas');
      if (!mounted) return;
      AppToast.gagal(context, 'Platform tidak mendukung pemulihan berkas');
      return;
    }

    final konfirmasiPilih = await showOkCancelAlertDialog(
      context: context,
      title: 'Pulihkan Data',
      message:
          'Pilih berkas cadangan JSON. Data saat ini akan diganti dengan data '
          'dari cadangan.',
      okLabel: 'Pilih berkas',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (!mounted) return;
    if (konfirmasiPilih != OkCancelResult.ok) {
      L.w('Pemulihan dibatalkan pengguna');
      return;
    }

    setState(() {
      _sedangMemproses = true;
    });
    unawaited(
      EasyLoading.show(
        status: 'Memulihkan data...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading pulihkan: $e $s');
      }),
    );
    try {
      final files = await FilePicker.pickFiles(
        dialogTitle: 'Pilih cadangan',
        type: FileType.custom,
        allowedExtensions: const <String>['json'],
      );
      if (!mounted) return;
      if (files.isEmpty) {
        L.w('Pengguna tidak memilih berkas cadangan');
        AppToast.info(context, 'Pemulihan dibatalkan');
        return;
      }
      final picked = files.single;
      final path = picked.path;
      L.i('pathCadangan=$path, nama=${picked.name}');
      Map<String, dynamic> payload;
      if (path != null && path.isNotEmpty) {
        payload = await CadanganHelper.bacaDanValidasiBerkas(path);
      } else {
        final bytes = await picked.readAsBytes();
        payload = CadanganHelper.validasiPayload(utf8.decode(bytes));
      }
      if (!mounted) return;

      final konfirmasiRestore = await showOkCancelAlertDialog(
        context: context,
        title: 'Konfirmasi Pemulihan',
        message:
            'Data lama akan diganti. Tindakan ini tidak dapat dibatalkan. '
            'Lanjutkan pemulihan?',
        okLabel: 'Pulihkan',
        cancelLabel: 'Batal',
        isDestructiveAction: true,
      );
      if (!mounted) return;
      if (konfirmasiRestore != OkCancelResult.ok) {
        L.w('Konfirmasi pemulihan dibatalkan');
        AppToast.info(context, 'Pemulihan dibatalkan');
        return;
      }

      await CadanganHelper.pulihkanDariPayload(payload);
      _refreshProviderSetelahRestore();
      if (!mounted) return;
      AppToast.sukses(context, 'Data berhasil dipulihkan');
    } on BerkasCadanganTidakValidException catch (e, s) {
      L.e('Berkas cadangan tidak valid: $e $s');
      if (!mounted) return;
      AppToast.gagal(context, e.pesan);
    } on Exception catch (e, s) {
      L.e('Gagal memulihkan data: $e $s');
      if (!mounted) return;
      AppToast.gagal(context, 'Gagal memulihkan data');
    } on UnsupportedError catch (e, s) {
      L.e('Pemulihan tidak didukung: $e $s');
      if (!mounted) return;
      AppToast.gagal(context, 'Platform tidak mendukung pemulihan');
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading pulihkan: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  void _refreshProviderSetelahRestore() {
    L.i('Refresh provider setelah restore');
    try {
      final _ = ref.refresh(biodataProvider);
    } on Exception catch (e, s) {
      L.e('Gagal refresh biodataProvider: $e $s');
    }
    try {
      final _ = ref.refresh(impianProvider);
    } on Exception catch (e, s) {
      L.e('Gagal refresh impianProvider: $e $s');
    }
    try {
      final _ = ref.refresh(diaryCravingProvider);
    } on Exception catch (e, s) {
      L.e('Gagal refresh diaryCravingProvider: $e $s');
    }
    try {
      final _ = ref.refresh(alasanBerhentiProvider);
    } on Exception catch (e, s) {
      L.e('Gagal refresh alasanBerhentiProvider: $e $s');
    }
    // Tabel-tabel ini juga ikut dipulihkan dari cadangan, tetapi sebelumnya
    // providernya tidak disegarkan sehingga layar menampilkan data usang.
    try {
      final _ = ref.refresh(konsumsiRokokProvider);
    } on Exception catch (e, s) {
      L.e('Gagal refresh konsumsiRokokProvider: $e $s');
    }
    try {
      final _ = ref.refresh(sosIntervensiProvider);
    } on Exception catch (e, s) {
      L.e('Gagal refresh sosIntervensiProvider: $e $s');
    }
    try {
      final _ = ref.refresh(rencanaDaruratProvider);
    } on Exception catch (e, s) {
      L.e('Gagal refresh rencanaDaruratProvider: $e $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    L.i('CadanganScreen build _sedangMemproses=$_sedangMemproses');
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Cadangan & Ekspor Data')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: !_platformDidukung
              ? Center(
                  child: Text(
                    'Cadangan berkas tidak didukung pada platform ini.',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16,
                  children: [
                    Text(
                      'Lindungi data biodata, impian, diary craving, dan alasan '
                      'berhenti dengan cadangan lokal.',
                      style: textTheme.bodyMedium,
                    ),
                    FilledButton(
                      onPressed: _sedangMemproses
                          ? null
                          : () {
                              unawaited(_eksporData());
                            },
                      child: const Text('Ekspor data'),
                    ),
                    FilledButton(
                      onPressed: _sedangMemproses
                          ? null
                          : () {
                              unawaited(_eksporCsv());
                            },
                      child: const Text('Ekspor CSV'),
                    ),
                    OutlinedButton(
                      onPressed: _sedangMemproses
                          ? null
                          : () {
                              unawaited(_pulihkanData());
                            },
                      child: const Text('Pulihkan data'),
                    ),
                    Text(
                      'Pemulihan akan mengganti data saat ini dengan data dari '
                      'berkas cadangan.',
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
