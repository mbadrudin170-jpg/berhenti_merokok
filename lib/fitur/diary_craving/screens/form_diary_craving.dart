import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/model/diary_craving_model.dart';
import 'package:berhenti_merokok/fitur/diary_craving/notifier/diary_craving_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

class FormDiaryCraving extends ConsumerStatefulWidget {
  final DiaryCravingModel? craving;
  const FormDiaryCraving({super.key, this.craving});

  @override
  ConsumerState<FormDiaryCraving> createState() => _FormDiaryCravingState();
}

class _FormDiaryCravingState extends ConsumerState<FormDiaryCraving> {
  final _formKey = GlobalKey<FormState>();
  final _catatanController = TextEditingController();
  final _catatanFocusNode = FocusNode();

  PemicuEnum _pemicu = PemicuEnum.stres;
  int _intensitas = 3;
  DateTime _tanggal = DateTime.now();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final craving = widget.craving;
    L.i('craving=$craving');
    if (craving != null) {
      _pemicu = craving.pemicu;
      _intensitas = craving.intensitas;
      _tanggal = craving.tanggal;
      _catatanController.text = craving.catatan ?? '';
      L.i(
        '_pemicu=$_pemicu, _intensitas=$_intensitas, _tanggal=$_tanggal, _catatanController.text=${_catatanController.text}',
      );
    }
  }

  @override
  void dispose() {
    _catatanController.dispose();
    _catatanFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final awal = _tanggal;
    L.i('awal=$awal, _tanggal=$_tanggal');
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    L.i('picked=$picked');
    if (picked != null && mounted) {
      // Gabungkan tanggal yang dipilih dengan waktu saat ini.
      final now = DateTime.now();
      setState(() {
        _tanggal = DateTime(
          picked.year,
          picked.month,
          picked.day,
          now.hour,
          now.minute,
        );
      });
      L.i('_tanggal=$_tanggal');
    }
  }

  Future<void> _pilihWaktu() async {
    final awal = TimeOfDay.fromDateTime(_tanggal);
    L.i('awal=$awal');
    final picked = await showTimePicker(context: context, initialTime: awal);
    L.i('picked=$picked');
    if (picked != null && mounted) {
      setState(() {
        _tanggal = DateTime(
          _tanggal.year,
          _tanggal.month,
          _tanggal.day,
          picked.hour,
          picked.minute,
        );
      });
      L.i('_tanggal=$_tanggal');
    }
  }

  Future<void> _simpan() async {
    if (_isLoading) {
      L.w('Form diary craving masih loading, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('validasi form gagal');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Simpan Craving',
      message: 'Apakah Anda yakin ingin menyimpan catatan craving ini?',
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
      final model = DiaryCravingModel(
        id: widget.craving?.id ?? const Uuid().v4(),
        tanggal: _tanggal,
        pemicu: _pemicu,
        intensitas: _intensitas,
        catatan: _catatanController.text.trim().isEmpty
            ? null
            : _catatanController.text.trim(),
        dibuat: widget.craving?.dibuat ?? DateTime.now(),
      );
      L.i('model=$model');
      if (widget.craving == null) {
        L.i('widget.craving null, tambah');
        await ref.read(diaryCravingProvider.notifier).tambah(model);
      } else {
        L.i('widget.craving tidak null, ubah');
        await ref.read(diaryCravingProvider.notifier).ubah(model);
      }
      if (!mounted) return;
      if (Navigator.of(context).canPop()) {
        Nav.pop(context);
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan diary craving: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan catatan craving');
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
        title: Text(
          widget.craving == null ? 'Catat Craving' : 'Ubah Catatan Craving',
        ),
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
                InputDropdown<PemicuEnum>(
                  value: _pemicu,
                  label: 'Pemicu',
                  items: PemicuEnum.values,
                  displayString: (item) => item.label,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _pemicu = value);
                      L.i('_pemicu=$_pemicu');
                    }
                  },
                ),
                InputDropdown<int>(
                  value: _intensitas,
                  label: 'Intensitas (1-5)',
                  items: const [1, 2, 3, 4, 5],
                  displayString: (item) => '$item',
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _intensitas = value);
                      L.i('_intensitas=$_intensitas');
                    }
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_outlined),
                  title: const Text('Tanggal'),
                  subtitle: Text(FormatWaktuLengkap.formatSingkat(_tanggal)),
                  trailing: TextButton(
                    onPressed: _pilihTanggal,
                    child: const Text('Pilih'),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.access_time_outlined),
                  title: const Text('Waktu'),
                  subtitle: Text(FormatJam.formatJamMenit(_tanggal)),
                  trailing: TextButton(
                    onPressed: _pilihWaktu,
                    child: const Text('Pilih'),
                  ),
                ),
                InputTeks(
                  controller: _catatanController,
                  label: 'Catatan',
                  hintText: 'Catatan tambahan (opsional)',
                  focusNode: _catatanFocusNode,
                  wajib: false,
                  minLines: 2,
                  maxLines: 4,
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
