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
  final ImpianModel? impian;
  const FormImpian({super.key, this.impian});

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
    final impian = widget.impian;
    L.i('impian=$impian');
    if (impian != null) {
      _namaController.text = impian.nama;
      _jumlahController.text = FormatUang.formatRupiah(impian.jumlah);
      _targetTanggal = impian.targetTanggal;
      L.i(
        '_namaController.text=${_namaController.text}, _jumlahController.text=${_jumlahController.text}, _targetTanggal=$_targetTanggal',
      );
    }
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
    L.i('awal=$awal, _targetTanggal=$_targetTanggal');
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    L.i('picked=$picked');
    if (picked != null && mounted) {
      setState(() => _targetTanggal = picked);
      L.i('_targetTanggal=$_targetTanggal');
    }
  }

  Future<void> _simpan() async {
    if (_isLoading) {
      L.w('Form impian masih loading, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('validasi form gagal');
      return;
    }
    if (_namaController.text.trim().isEmpty) {
      L.w('nama impian kosong');
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
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      L.w('konfirmasi bukan ok');
      return;
    }
    if (!mounted) return;
    setState(() => _isLoading = true);
    L.i('_isLoading=$_isLoading');
    unawaited(
      EasyLoading.show(
        status: 'Menyimpan...',
        maskType: EasyLoadingMaskType.black,
      ),
    );
    try {
      final jumlah = InputRupiah.parse(_jumlahController.text);
      L.i('jumlah=$jumlah');
      if (jumlah <= 0) {
        L.w('jumlah <= 0');
        if (mounted) {
          AppToast.gagal(context, 'Jumlah harus lebih dari 0');
        }
        return;
      }
      final model = ImpianModel(
        id: widget.impian?.id ?? const Uuid().v4(),
        nama: _namaController.text.trim(),
        targetTanggal: _targetTanggal ?? DateTime.now(),
        dibuat: widget.impian?.dibuat ?? DateTime.now(),
        jumlah: jumlah,
      );
      L.i('model=$model');
      if (widget.impian == null) {
        L.i('widget.impian null, tambah');
        await ref.read(impianProvider.notifier).tambah(model);
      } else {
        L.i('widget.impian tidak null, ubah');
        await ref.read(impianProvider.notifier).ubah(model);
      }
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
        L.i('_isLoading=$_isLoading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.impian == null ? 'Form Impian' : 'Ubah Impian'),
      ),

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
