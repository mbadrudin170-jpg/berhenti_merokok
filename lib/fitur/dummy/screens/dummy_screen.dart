import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/dummy/helper/dummy_helper.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class DummyScreen extends ConsumerStatefulWidget {
  const DummyScreen({super.key});

  @override
  ConsumerState<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends ConsumerState<DummyScreen> {
  bool _sedangMemuat = false;

  Future<void> _masukkanDummy(BuildContext context) async {
    L.i('_masukkanDummy _sedangMemuat=$_sedangMemuat');
    if (_sedangMemuat) {
      L.w('Dummy masih diproses, aksi diabaikan');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Masukkan Dummy',
      message:
          'Apakah Anda yakin ingin memasukkan data dummy? '
          'Biodata yang ada akan diganti dengan data dummy.',
      okLabel: 'Masukkan',
      cancelLabel: 'Batal',
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!context.mounted) return;

    setState(() => _sedangMemuat = true);
    unawaited(
      EasyLoading.show(
        status: 'Menyimpan...',
        maskType: EasyLoadingMaskType.black,
      ),
    );
    try {
      await DummyHelper.insert();
      await _refreshProvider();
      if (context.mounted) {
        AppToast.sukses(context, 'Dummy berhasil dimasukkan');
      }
    } on Exception catch (e, s) {
      L.e('Gagal memasukkan dummy: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal memasukkan dummy');
      }
    } finally {
      if (mounted) {
        unawaited(EasyLoading.dismiss());
        setState(() => _sedangMemuat = false);
      }
    }
  }

  Future<void> _hapusDummy(BuildContext context) async {
    L.i('_hapusDummy _sedangMemuat=$_sedangMemuat');
    if (_sedangMemuat) {
      L.w('Dummy masih diproses, aksi diabaikan');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Dummy',
      message: 'Apakah Anda yakin ingin menghapus data dummy?',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!context.mounted) return;

    setState(() => _sedangMemuat = true);
    unawaited(
      EasyLoading.show(
        status: 'Menghapus...',
        maskType: EasyLoadingMaskType.black,
      ),
    );
    try {
      await DummyHelper.delete();
      await _refreshProvider();
      if (context.mounted) {
        AppToast.sukses(context, 'Dummy berhasil dihapus');
      }
    } on Exception catch (e, s) {
      L.e('Gagal menghapus dummy: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal menghapus dummy');
      }
    } finally {
      if (mounted) {
        unawaited(EasyLoading.dismiss());
        setState(() => _sedangMemuat = false);
      }
    }
  }

  Future<void> _reset(BuildContext context) async {
    L.i('_reset _sedangMemuat=$_sedangMemuat');
    if (_sedangMemuat) {
      L.w('Dummy masih diproses, aksi diabaikan');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Reset Dummy',
      message: 'Apakah Anda yakin ingin mereset data dummy? Data dummy akan dihapus lalu dimasukkan ulang.',
      okLabel: 'Reset',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!context.mounted) return;

    setState(() => _sedangMemuat = true);
    unawaited(
      EasyLoading.show(
        status: 'Memproses...',
        maskType: EasyLoadingMaskType.black,
      ),
    );
    try {
      await DummyHelper.delete();
      await DummyHelper.insert();
      await _refreshProvider();
      if (context.mounted) {
        AppToast.sukses(context, 'Dummy berhasil direset');
      }
    } on Exception catch (e, s) {
      L.e('Gagal mereset dummy: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal mereset dummy');
      }
    } finally {
      if (mounted) {
        unawaited(EasyLoading.dismiss());
        setState(() => _sedangMemuat = false);
      }
    }
  }

  Future<void> _refreshProvider() async {
    // Perbarui state agar UI memuat data dummy terbaru.
    L.i('_refreshProvider');
    final _ = ref.refresh(impianProvider);
    final _ = ref.refresh(biodataProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dummy')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            _buildTombolCustom(
              () => unawaited(_masukkanDummy(context)),
              'insert',
              Colors.green,
            ),
            _buildTombolCustom(
              () => unawaited(_hapusDummy(context)),
              'hapus',
              Colors.red,
            ),
            _buildTombolCustom(
              () => unawaited(_reset(context)),
              'reset',
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTombolCustom(
    void Function() onPressed,
    String value,
    Color backgroundColor,
  ) {
    L.i('value=$value, backgroundColor=$backgroundColor');
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(value),
      ),
    );
  }
}
