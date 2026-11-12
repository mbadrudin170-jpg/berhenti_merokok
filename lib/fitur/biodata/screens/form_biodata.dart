import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/biodata/enum/mode_berhenti.dart';
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
  final _penurunanPerMingguController = TextEditingController();
  final _targetSmokeFreeController = TextEditingController();

  final _namaFocusNode = FocusNode();
  final _jumlahRokokFocusNode = FocusNode();
  final _hargaRokokFocusNode = FocusNode();
  final _batangPerBungkusFocusNode = FocusNode();
  final _penurunanPerMingguFocusNode = FocusNode();
  final _targetSmokeFreeFocusNode = FocusNode();

  DateTime? _tanggalLahir;
  DateTime? _tanggalMulaiMerokok;
  DateTime? _tanggalMulaiBerhentiMerokok;
  DateTime? _tanggalMulaiTapering;

  ModeBerhenti _modeBerhenti = ModeBerhenti.seketika;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _sudahDiisi = false;

  ProviderSubscription<AsyncValue<BiodataModel?>>? _biodataSubscription;

  @override
  void initState() {
    super.initState();
    L.i('FormBiodata initState, buatPertama=${widget.buatPertama}');
    final modelAwal = widget.biodataModel;
    if (modelAwal != null) {
      _isiDariModel(modelAwal);
    }
    if (widget.buatPertama && _tanggalMulaiMerokok == null) {
      _tanggalMulaiMerokok = DateTime.now();
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
    _modeBerhenti = model.modeBerhenti;
    _penurunanPerMingguController.text = model.penurunanPerMinggu.toString();
    _targetSmokeFreeController.text = (model.targetSmokeFreeHari ?? '')
        .toString();
    _tanggalMulaiTapering = model.tanggalMulaiTapering;
    L.i(
      'modeBerhenti=$_modeBerhenti, '
      'penurunanPerMinggu=${_penurunanPerMingguController.text}, '
      'tanggalMulaiTapering=$_tanggalMulaiTapering, '
      'targetSmokeFreeHari=${_targetSmokeFreeController.text}',
    );
  }

  @override
  void dispose() {
    _biodataSubscription?.close();
    _namaController.dispose();
    _jumlahRokokController.dispose();
    _hargaRokokController.dispose();
    _batangPerBungkusController.dispose();
    _penurunanPerMingguController.dispose();
    _namaFocusNode.dispose();
    _jumlahRokokFocusNode.dispose();
    _hargaRokokFocusNode.dispose();
    _batangPerBungkusFocusNode.dispose();
    _penurunanPerMingguFocusNode.dispose();
    _targetSmokeFreeFocusNode.dispose();
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

  Future<void> _pilihTanggalMulaiTapering() async {
    final awal = _tanggalMulaiTapering ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && mounted) {
      L.i('tanggalMulaiTapering=$picked');
      setState(() => _tanggalMulaiTapering = picked);
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
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    if (_modeBerhenti == ModeBerhenti.bertahap &&
        _tanggalMulaiTapering == null) {
      AppToast.gagal(context, 'Tanggal mulai penurunan wajib dipilih');
      return;
    }
    final tanggalMulaiMerokok = _tanggalMulaiMerokok;
    final tanggalMulaiBerhenti = _tanggalMulaiBerhentiMerokok;
    if (tanggalMulaiMerokok != null && tanggalMulaiBerhenti != null) {
      final mulaiDate = DateTime(
        tanggalMulaiMerokok.year,
        tanggalMulaiMerokok.month,
        tanggalMulaiMerokok.day,
      );
      final berhentiDate = DateTime(
        tanggalMulaiBerhenti.year,
        tanggalMulaiBerhenti.month,
        tanggalMulaiBerhenti.day,
      );
      if (berhentiDate.isBefore(mulaiDate)) {
        AppToast.gagal(
          context,
          'Tanggal mulai berhenti merokok tidak boleh sebelum tanggal mulai merokok',
        );
        return;
      }
    }
    setState(() => _isLoading = true);
    unawaited(
      EasyLoading.show(
        status: 'Menyimpan...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
        return null;
      }),
    );
    try {
      final jumlahRokokPerHari = int.tryParse(
        _jumlahRokokController.text.trim(),
      );
      if (jumlahRokokPerHari == null || jumlahRokokPerHari <= 0) {
        AppToast.gagal(context, 'Jumlah rokok per hari tidak valid');
        return;
      }
      final batangPerBungkus = double.tryParse(
        _batangPerBungkusController.text.trim(),
      );
      if (batangPerBungkus == null || batangPerBungkus <= 0) {
        AppToast.gagal(context, 'Batang per bungkus tidak valid');
        return;
      }
      int penurunanPerMinggu = 0;
      if (_modeBerhenti == ModeBerhenti.bertahap) {
        final parsedPenurunan = int.tryParse(
          _penurunanPerMingguController.text.trim(),
        );
        if (parsedPenurunan == null || parsedPenurunan <= 0) {
          AppToast.gagal(context, 'Penurunan per minggu tidak valid');
          return;
        }
        penurunanPerMinggu = parsedPenurunan;
      }
      int? targetSmokeFreeHari;
      final targetText = _targetSmokeFreeController.text.trim();
      if (targetText.isNotEmpty) {
        final parsedTarget = int.tryParse(targetText);
        if (parsedTarget == null || parsedTarget <= 0) {
          AppToast.gagal(
            context,
            'Target smoke-free harus bilangan bulat lebih dari 0',
          );
          return;
        }
        targetSmokeFreeHari = parsedTarget;
      }
      final model = BiodataModel(
        id: widget.biodataModel?.id ?? '',
        nama: _namaController.text.trim(),
        tanggalLahir: _tanggalLahir,
        jumlahRokokPerHari: jumlahRokokPerHari,
        hargaRokokPerBungkus: _hargaRokokController.text.trim().isEmpty
            ? 0.0
            : InputRupiah.parse(_hargaRokokController.text),
        batangPerBungkus: batangPerBungkus,
        tanggalMulaiMerokok: _tanggalMulaiMerokok,
        tanggalMulaiBerhentiMerokok: _tanggalMulaiBerhentiMerokok,
        modeBerhenti: _modeBerhenti,
        penurunanPerMinggu: penurunanPerMinggu,
        tanggalMulaiTapering: _tanggalMulaiTapering,
        targetSmokeFreeHari: targetSmokeFreeHari,
      );
      L.i('model=$model, targetSmokeFreeHari=$targetSmokeFreeHari');
      await ref.read(biodataProvider.notifier).simpan(model);
      if (!mounted) return;
      if (widget.buatPertama) {
        unawaited(
          Nav.pushAndRemoveUntil(context, const Home()).catchError((
            Object e,
            StackTrace s,
          ) {
            L.e('Gagal navigasi ke Home: $e $s');
            return null;
          }),
        );
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
        unawaited(
          EasyLoading.dismiss().catchError((Object e, StackTrace s) {
            L.e('Gagal menutup loading: $e $s');
            return null;
          }),
        );
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
          child: Form(
            key: _formKey,
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
                  validator: (value) {
                    final cleaned = (value ?? '').replaceAll(
                      RegExp(r'[^0-9]'),
                      '',
                    );
                    final n = int.tryParse(cleaned);
                    if (n == null || n <= 0) {
                      return 'Wajib bilangan bulat positif';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    final cleaned = (value ?? '').replaceAll(
                      RegExp(r'[^0-9.]'),
                      '',
                    );
                    final n = double.tryParse(cleaned);
                    if (n == null || n <= 0) {
                      return 'Wajib bilangan positif';
                    }
                    return null;
                  },
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
                // Mode berhenti: seketika atau bertahap (tapering).
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Berhenti bertahap (tapering)'),
                  subtitle: const Text(
                    'Kurangi jumlah rokok per hari secara bertahap.',
                  ),
                  value: _modeBerhenti == ModeBerhenti.bertahap,
                  onChanged: (value) {
                    setState(() {
                      _modeBerhenti = value
                          ? ModeBerhenti.bertahap
                          : ModeBerhenti.seketika;
                      if (value && _tanggalMulaiTapering == null) {
                        _tanggalMulaiTapering = DateTime.now();
                      }
                    });
                  },
                ),
                if (_modeBerhenti == ModeBerhenti.bertahap) ...[
                  InputAngka(
                    controller: _penurunanPerMingguController,
                    label: 'Penurunan per minggu (batang)',
                    hintText: 'Masukkan jumlah penurunan per minggu',
                    focusNode: _penurunanPerMingguFocusNode,
                    validator: (value) {
                      final cleaned = (value ?? '').replaceAll(
                        RegExp(r'[^0-9]'),
                        '',
                      );
                      final n = int.tryParse(cleaned);
                      if (n == null || n <= 0) {
                        return 'Wajib bilangan bulat positif';
                      }
                      return null;
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today_outlined),
                    title: const Text('Tanggal mulai penurunan'),
                    subtitle: Text(
                      _tanggalMulaiTapering == null
                          ? 'Belum dipilih'
                          : FormatTanggal.formatDasar(_tanggalMulaiTapering!),
                    ),
                    trailing: TextButton(
                      onPressed: _pilihTanggalMulaiTapering,
                      child: const Text('Pilih'),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                InputAngka(
                  controller: _targetSmokeFreeController,
                  label: 'Target smoke-free (hari)',
                  hintText: 'Masukkan target hari bebas rokok',
                  focusNode: _targetSmokeFreeFocusNode,
                  validator: (value) {
                    final cleaned = (value ?? '').trim();
                    if (cleaned.isEmpty) return null;
                    final n = int.tryParse(cleaned);
                    if (n == null || n <= 0) {
                      return 'Wajib bilangan bulat lebih dari 0';
                    }
                    return null;
                  },
                ),
                OutlinedButton(onPressed: _simpan, child: const Text('Simpan')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
