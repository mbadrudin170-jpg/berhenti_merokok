import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class FormBiodata extends ConsumerStatefulWidget {
  final bool buatPertama;
  final BiodataModel? biodataModel;
  const FormBiodata({super.key, required this.buatPertama, this.biodataModel});

  @override
  ConsumerState<FormBiodata> createState() => _BiodataScreenState();
}

class _BiodataScreenState extends ConsumerState<FormBiodata> {
  final _namaController = TextEditingController();
  final _jumlahRokokController = TextEditingController();
  final _hargaRokokController = TextEditingController();
  final _batangPerBungkusController = TextEditingController();

  final _namaFocusNode = FocusNode();
  final _jumlahRokokFocusNode = FocusNode();
  final _hargaRokokFocusNode = FocusNode();
  final _batangPerBungkusFocusNode = FocusNode();

  DateTime? _tanggalLahir;
  DateTime? _tanggalMulaiMerokok;
  DateTime? _tanggalMulaiBerhentiMerokok;

  bool _isLoading = false;
  bool _sudahDiisi = false;

  ProviderSubscription<AsyncValue<BiodataModel?>>? _biodataSubscription;

  @override
  void initState() {
    super.initState();
    final modelAwal = widget.biodataModel;
    if (modelAwal != null) {
      _isiDariModel(modelAwal);
    }
    _biodataSubscription = ref.listenManual(biodataProvider, (previous, next) {
      next.whenData((biodata) {
        if (biodata != null && !_sudahDiisi && mounted) {
          _isiDariModel(biodata);
        }
      });
    });
  }

  void _isiDariModel(BiodataModel model) {
    _sudahDiisi = true;
    _namaController.text = model.nama;
    _jumlahRokokController.text = model.jumlahRokokPerHari.toString();
    _hargaRokokController.text = model.hargaRokokPerBungkus.toString();
    _batangPerBungkusController.text = model.batangPerBungkus.toString();
    _tanggalLahir = model.tanggalLahir;
    _tanggalMulaiMerokok = model.tanggalMulaiMerokok;
    _tanggalMulaiBerhentiMerokok = model.tanggalMulaiBerhentiMerokok;
  }

  @override
  void dispose() {
    _biodataSubscription?.close();
    _namaController.dispose();
    _jumlahRokokController.dispose();
    _hargaRokokController.dispose();
    _batangPerBungkusController.dispose();
    _namaFocusNode.dispose();
    _jumlahRokokFocusNode.dispose();
    _hargaRokokFocusNode.dispose();
    _batangPerBungkusFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggalLahir() async {
    final awal = _tanggalLahir ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() => _tanggalLahir = picked);
    }
  }

  Future<void> _pilihTanggalMulaiMerokok() async {
    final awal = _tanggalMulaiMerokok ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() => _tanggalMulaiMerokok = picked);
    }
  }

  Future<void> _pilihTanggalMulaiBerhentiMerokok() async {
    final awal = _tanggalMulaiBerhentiMerokok ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() => _tanggalMulaiBerhentiMerokok = picked);
    }
  }

  Future<void> _simpan() async {
    if (_isLoading) {
      L.w('Form biodata masih loading, simpan diabaikan');
      return;
    }
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Simpan Biodata',
      message: 'Apakah Anda yakin ingin menyimpan data biodata ini?',
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
      final model = BiodataModel(
        id: widget.biodataModel?.id ?? '',
        nama: _namaController.text.trim(),
        tanggalLahir: _tanggalLahir,
        jumlahRokokPerHari:
            int.tryParse(_jumlahRokokController.text.trim()) ?? 0,
        hargaRokokPerBungkus: _hargaRokokController.text.trim().isEmpty
            ? 0.0
            : InputRupiah.parse(_hargaRokokController.text),
        batangPerBungkus:
            double.tryParse(_batangPerBungkusController.text.trim()) ?? 20.0,
        tanggalMulaiMerokok: _tanggalMulaiMerokok,
        tanggalMulaiBerhentiMerokok: _tanggalMulaiBerhentiMerokok,
      );
      await ref.read(biodataProvider.notifier).simpan(model);
      if (!mounted) return;
      if (widget.buatPertama) {
        unawaited(Nav.pushAndRemoveUntil(context, const Home()));
      } else if (Navigator.of(context).canPop()) {
        Nav.pop(context);
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan biodata: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan biodata');
      }
    } finally {
      if (mounted) {
        unawaited(EasyLoading.dismiss());
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);

    if (biodataAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Biodata')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gagal memuat data'),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  final _ = ref.refresh(biodataProvider);
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Biodata')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              InputTeks(
                controller: _namaController,
                label: 'Nama',
                hintText: 'Masukkan nama',
                focusNode: _namaFocusNode,
                nextFocusNode: _jumlahRokokFocusNode,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              InputAngka(
                controller: _jumlahRokokController,
                label: 'Jumlah rokok per hari',
                hintText: 'Masukkan jumlah rokok per hari',
                focusNode: _jumlahRokokFocusNode,
                nextFocusNode: _hargaRokokFocusNode,
              ),
              InputRupiah(
                controller: _hargaRokokController,
                label: 'Harga rokok per bungkus',
                hintText: 'Masukkan harga rokok per bungkus',
                focusNode: _hargaRokokFocusNode,
              ),
              InputAngka(
                controller: _batangPerBungkusController,
                label: 'Batang per bungkus',
                hintText: 'Masukkan jumlah batang per bungkus',
                focusNode: _batangPerBungkusFocusNode,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.cake_outlined),
                title: const Text('Tanggal lahir'),
                subtitle: Text(
                  _tanggalLahir == null
                      ? 'Belum dipilih'
                      : FormatTanggal.formatDasar(_tanggalLahir!),
                ),
                trailing: TextButton(
                  onPressed: _pilihTanggalLahir,
                  child: const Text('Pilih'),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.smoking_rooms_outlined),
                title: const Text('Tanggal mulai merokok'),
                subtitle: Text(
                  _tanggalMulaiMerokok == null
                      ? 'Belum dipilih'
                      : FormatTanggal.formatDasar(_tanggalMulaiMerokok!),
                ),
                trailing: TextButton(
                  onPressed: _pilihTanggalMulaiMerokok,
                  child: const Text('Pilih'),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.event_available_outlined),
                title: const Text('Tanggal mulai berhenti merokok'),
                subtitle: Text(
                  _tanggalMulaiBerhentiMerokok == null
                      ? 'Belum dipilih'
                      : FormatTanggal.formatDasar(
                          _tanggalMulaiBerhentiMerokok!,
                        ),
                ),
                trailing: TextButton(
                  onPressed: _pilihTanggalMulaiBerhentiMerokok,
                  child: const Text('Pilih'),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(onPressed: _simpan, child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
