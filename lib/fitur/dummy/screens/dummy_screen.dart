import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/dummy/helper/dummy_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class DummyScreen extends ConsumerWidget {
  const DummyScreen({super.key});

  Future<void> _masukkanDummy(BuildContext context) async {
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Masukkan Dummy',
      message: 'Apakah Anda yakin ingin memasukkan data dummy?',
      okLabel: 'Masukkan',
      cancelLabel: 'Batal',
    );
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!context.mounted) return;
    unawaited(EasyLoading.show(status: 'Menyimpan...'));
    try {
      await DummyHelper.insert();
      if (context.mounted) {
        AppToast.sukses(context, 'Dummy berhasil dimasukkan');
      }
    } on Exception catch (e, s) {
      L.e('Gagal memasukkan dummy: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal memasukkan dummy');
      }
    } finally {
      unawaited(EasyLoading.dismiss());
    }
  }

  Future<void> _hapusDummy(BuildContext context) async {
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Dummy',
      message: 'Apakah Anda yakin ingin menghapus data dummy?',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!context.mounted) return;
    unawaited(EasyLoading.show(status: 'Menghapus...'));
    try {
      await DummyHelper.delete();
      if (context.mounted) {
        AppToast.sukses(context, 'Dummy berhasil dihapus');
      }
    } on Exception catch (e, s) {
      L.e('Gagal menghapus dummy: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal menghapus dummy');
      }
    } finally {
      unawaited(EasyLoading.dismiss());
    }
  }

  Future<void> _reset(BuildContext context) async {
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Reset Dummy',
      message: 'Apakah Anda yakin ingin mereset data dummy? Data dummy akan dihapus lalu dimasukkan ulang.',
      okLabel: 'Reset',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!context.mounted) return;
    unawaited(EasyLoading.show(status: 'Memproses...'));
    try {
      await DummyHelper.delete();
      await DummyHelper.insert();
      if (context.mounted) {
        AppToast.sukses(context, 'Dummy berhasil direset');
      }
    } on Exception catch (e, s) {
      L.e('Gagal mereset dummy: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal mereset dummy');
      }
    } finally {
      unawaited(EasyLoading.dismiss());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('data')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTombolCustom(
              () => unawaited(_masukkanDummy(context)),
              'insert',
            ),
            _buildTombolCustom(() => unawaited(_hapusDummy(context)), 'hapus'),
            _buildTombolCustom(() => unawaited(_reset(context)), 'reset'),
          ],
        ),
      ),
    );
  }

  Widget _buildTombolCustom(void Function() onPressed, String value) {
    return OutlinedButton(onPressed: onPressed, child: Text(value));
  }
}
