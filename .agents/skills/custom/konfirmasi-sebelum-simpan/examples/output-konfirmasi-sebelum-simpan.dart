// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easyloading/easyloading.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class FormBenar extends ConsumerStatefulWidget {
  const FormBenar({super.key});
  @override
  ConsumerState<FormBenar> createState() => _FormBenarState();
}

class _FormBenarState extends ConsumerState<FormBenar> {
  bool _isLoading = false;

  Future<void> _simpan() async {
    // BENAR: Dialog konfirmasi sebelum simpan
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Simpan Data',
      message: 'Apakah Anda yakin ingin menyimpan data ini?',
      okLabel: 'Simpan',
      cancelLabel: 'Batal',
    );
    if (konfirmasi != OkCancelResult.ok) return;

    // BENAR: Flag loading + EasyLoading
    setState(() => _isLoading = true);
    await EasyLoading.show(status: 'Menyimpan...', maskType: EasyLoadingMaskType.black);

    try {
      await ref.read(provider.notifier).tambah(Model());
    } finally {
      await EasyLoading.dismiss();
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _isLoading ? null : _simpan, child: const Text('Simpan'));
  }
}

class Model {}
final provider = FutureProvider.autoDispose((ref) async => []);