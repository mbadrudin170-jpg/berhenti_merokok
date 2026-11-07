import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

class FormImpian extends ConsumerStatefulWidget {
  const FormImpian({super.key});

  @override
  ConsumerState<FormImpian> createState() => _FormImpianState();
}

class _FormImpianState extends ConsumerState<FormImpian> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();

  final _namaFocusNode = FocusNode();
  final _jumlahFocusNode = FocusNode();

  DateTime? _targetTanggal;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    _namaFocusNode.dispose();
    _jumlahFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pilihTargetTanggal() async {
    final awal = _targetTanggal ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (picked != null && mounted) {
      setState(() => _targetTanggal = picked);
    }
  }

  Future<void> _simpan() async {
    if (_isLoading) {
      L.w('Form impian masih loading, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    if (_namaController.text.trim().isEmpty) {
      if (mounted) {
        AppToast.gagal(context, 'Nama impian wajib diisi');
      }
      return;
    }
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Simpan Impian',
      message: 'Apakah Anda yakin ingin menyimpan data impian ini?',
      okLabel: 'Simpan',
      cancelLabel: 'Batal',
    );
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!mounted) return;
    setState(() => _isLoading = true);
    unawaited(
      EasyLoading.show(
        status: 'Menyimpan...',
        maskType: EasyLoadingMaskType.black,
      ),
    );
    try {
      final jumlah = InputRupiah.parse(_jumlahController.text);
      if (jumlah <= 0) {
        if (mounted) {
          AppToast.gagal(context, 'Jumlah harus lebih dari 0');
        }
        return;
      }
      final model = ImpianModel(
        id: const Uuid().v4(),
        nama: _namaController.text.trim(),
        targetTanggal: _targetTanggal ?? DateTime.now(),
        dibuat: DateTime.now(),
        jumlah: jumlah,
      );
      await ref.read(impianProvider.notifier).tambah(model);
      if (!mounted) return;
      if (Navigator.of(context).canPop()) {
        Nav.pop(context);
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan impian: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan impian');
      }
    } finally {
      unawaited(EasyLoading.dismiss());
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Impian')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                InputTeks(
                  controller: _namaController,
                  label: 'Nama Impian',
                  hintText: 'Masukkan nama impian',
                  focusNode: _namaFocusNode,
                  nextFocusNode: _jumlahFocusNode,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama impian wajib diisi';
                    }
                    return null;
                  },
                ),
                InputRupiah(
                  controller: _jumlahController,
                  label: 'Jumlah',
                  hintText: 'Masukkan jumlah',
                  focusNode: _jumlahFocusNode,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_outlined),
                  title: const Text('Target tanggal'),
                  subtitle: Text(
                    _targetTanggal == null
                        ? 'Belum dipilih'
                        : FormatTanggal.formatDasar(_targetTanggal!),
                  ),
                  trailing: TextButton(
                    onPressed: _pilihTargetTanggal,
                    child: const Text('Pilih'),
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton(onPressed: _simpan, child: const Text('Simpan')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
