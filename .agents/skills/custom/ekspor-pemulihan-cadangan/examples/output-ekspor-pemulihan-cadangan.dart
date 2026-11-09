// commit: 338a0216257bb9f75617f144fd2fae0d7faf63d2
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easyloading/easyloading.dart';

class BerkasCadanganTidakValidException implements Exception {
  const BerkasCadanganTidakValidException(this.pesan);
  final String pesan;
  @override String toString() => 'Berkas cadangan tidak valid: $pesan';
}

class CadanganBenar extends ConsumerStatefulWidget {
  const CadanganBenar({super.key});
  @override ConsumerState<CadanganBenar> createState() => _CadanganBenarState();
}

class _CadanganBenarState extends ConsumerState<CadanganBenar> {
  bool _sedangMemproses = false;

  Future<void> _pulihkan() async {
    if (_sedangMemproses) return;
    setState(() => _sedangMemproses = true);
    
    try {
      await EasyLoading.show(status: 'Memproses...', maskType: EasyLoadingMaskType.black).catchError((e, s) => L.e('Gagal loading: $e $s'));
      
      // BENAR: Konfirmasi destruktif
      final konfirmasi = await showOkCancelAlertDialog(
        context: context, title: 'Pulihkan Cadangan', 
        message: 'Data akan diganti. Lanjutkan?', okLabel: 'Pulihkan', cancelLabel: 'Batal', isDestructiveAction: true);
      if (konfirmasi != OkCancelResult.ok) return;

      // BENAR: Transaksi atomic
      final op = SqfliteOp();
      await op.transaksi((txn) async {
        for (final tabel in ['tabel1', 'tabel2']) {
          await txn.delete(tabel);
          L.i('Hapus data lama tabel $tabel');
        }
        for (final tabel in ['tabel1', 'tabel2']) {
          // insert data baru...
        }
      });

      // BENAR: Refresh provider
      for (final provider in [biodataProvider, impianProvider, diaryCravingProvider, alasanBerhentiProvider]) {
        try { await ref.refresh(provider.future); } catch (e, s) { L.e('Refresh gagal: $e $s'); }
      }

      AppToast.sukses(context, 'Cadangan berhasil dipulihkan');
    } on BerkasCadanganTidakValidException catch (e) {
      AppToast.gagal(context, e.toString());
    } finally {
      unawaited(EasyLoading.dismiss().catchError((e, s) => L.e('Gagal dismiss: $e $s')));
      if (mounted) setState(() => _sedangMemproses = false);
    }
  }

  @override Widget build(BuildContext context) => ElevatedButton(onPressed: _sedangMemproses ? null : _pulihkan, child: const Text('Pulihkan'));
}

class SqfliteOp { Future<void> transaksi(Future<void> Function(Transaction) action) async {} }
final biodataProvider = FutureProvider.autoDispose((ref) async => []);
final impianProvider = FutureProvider.autoDispose((ref) async => []);
final diaryCravingProvider = FutureProvider.autoDispose((ref) async => []);
final alasanBerhentiProvider = FutureProvider.autoDispose((ref) async => []);