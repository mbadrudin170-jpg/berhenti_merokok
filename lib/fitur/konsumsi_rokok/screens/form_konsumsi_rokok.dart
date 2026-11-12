import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Bottom sheet form untuk koreksi atau pencatatan konsumsi rokok harian.
class FormKonsumsiRokok extends ConsumerStatefulWidget {
  final KonsumsiRokokModel? konsumsi;
  const FormKonsumsiRokok({super.key, this.konsumsi});

  @override
  ConsumerState<FormKonsumsiRokok> createState() => _FormKonsumsiRokokState();
}

class _FormKonsumsiRokokState extends ConsumerState<FormKonsumsiRokok> {
  final _formKey = GlobalKey<FormState>();
  final _jumlahController = TextEditingController();
  final _catatanController = TextEditingController();

  DateTime _tanggal = DateTime.now();
  bool _isSlip = false;
  PemicuEnum? _pemicu;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final konsumsi = widget.konsumsi;
    L.i('konsumsi=$konsumsi');
    if (konsumsi != null) {
      _tanggal = konsumsi.tanggal;
      _isSlip = konsumsi.isSlip;
      _jumlahController.text = konsumsi.jumlah.toString();
      _catatanController.text = konsumsi.catatan ?? '';
      _pemicu = konsumsi.pemicu;
    }
  }

  @override
  void dispose() {
    _jumlahController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    L.i('picked=$picked');
    if (picked != null && mounted) {
      setState(() {
        _tanggal = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _tanggal.hour,
          _tanggal.minute,
        );
      });
      L.i('_tanggal=$_tanggal');
    }
  }

  int _jumlahDariController(String teks) {
    final bersih = teks.replaceAll(RegExp(r'[^0-9\-]'), '');
    return int.tryParse(bersih) ?? 0;
  }

  Future<void> _simpan() async {
    if (_isLoading) {
      L.w('Form konsumsi masih loading, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('validasi form gagal');
      return;
    }

    final jumlah = _jumlahDariController(_jumlahController.text);
    if (jumlah < 0) {
      L.w('jumlah negatif: $jumlah');
      return;
    }

    // U5: Konfirmasi khusus saat jumlah berubah (edit entri existing)
    if (widget.konsumsi != null && jumlah != widget.konsumsi!.jumlah) {
      final konfirmasi = await showOkCancelAlertDialog(
        context: context,
        title: 'Ubah Jumlah',
        message: 'Metrik uang dihemat, rokok tidak dihisap, dan target tapering akan ikut menyesuaikan. Lanjutkan simpan?',
        okLabel: 'Simpan',
        cancelLabel: 'Batal',
      );
      L.i('konfirmasi ubah jumlah=$konfirmasi');
      if (konfirmasi != OkCancelResult.ok) {
        L.w('konfirmasi ubah jumlah bukan ok');
        return;
      }
      if (!mounted) return;
    } else {
      // Konfirmasi generik untuk entri baru atau perubahan non-jumlah
      final konfirmasi = await showOkCancelAlertDialog(
        context: context,
        title: 'Simpan Konsumsi',
        message: 'Apakah Anda yakin ingin menyimpan catatan konsumsi ini?',
        okLabel: 'Simpan',
        cancelLabel: 'Batal',
      );
      L.i('konfirmasi=$konfirmasi');
      if (konfirmasi != OkCancelResult.ok) {
        L.w('konfirmasi bukan ok');
        return;
      }
      if (!mounted) return;
    }

    setState(() => _isLoading = true);
    unawaited(
      EasyLoading.show(
        status: 'Menyimpan...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((e, s) => L.e('Gagal menampilkan loading: $e $s')),
    );
    try {
      final model = KonsumsiRokokModel(
        id: widget.konsumsi?.id ?? const Uuid().v4(),
        tanggal: _tanggal,
        jumlah: jumlah,
        isSlip: _isSlip,
        catatan: _catatanController.text.trim().isEmpty
            ? null
            : _catatanController.text.trim(),
        pemicu: _pemicu,
        dibuat: widget.konsumsi?.dibuat ?? DateTime.now(),
      );
      L.i('model=$model');
      if (widget.konsumsi == null) {
        await ref.read(konsumsiRokokProvider.notifier).tambah(model);
      } else {
        await ref.read(konsumsiRokokProvider.notifier).ubah(model);
      }
      if (!mounted) return;
      if (Navigator.of(context).canPop()) {
        Nav.pop(context, true); // Kembalikan true untuk menandakan sukses
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan konsumsi: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan konsumsi');
      }
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError(
          (e, s) => L.e('Gagal menutup loading: $e $s'),
        ),
      );
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.konsumsi == null ? 'Catat Konsumsi' : 'Ubah Konsumsi',
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
                InputAngka(
                  controller: _jumlahController,
                  label: 'Jumlah Batang',
                  hintText: 'Masukkan jumlah batang',
                  wajib: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Jumlah wajib diisi';
                    }
                    final n = _jumlahDariController(value);
                    if (n < 0) {
                      return 'Jumlah tidak boleh negatif';
                    }
                    return null;
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
                SwitchListTile(
                  title: const Text('Ini slip/relapse?'),
                  subtitle: const Text(
                    'Tandai jika ini adalah relapse (slip). Streak smoke-free akan direset dari tanggal slip.',
                  ),
                  value: _isSlip,
                  onChanged: (value) {
                    setState(() => _isSlip = value);
                    L.i('_isSlip=$_isSlip');
                  },
                ),
                DropdownButtonFormField<PemicuEnum>(
                  decoration: const InputDecoration(
                    labelText: 'Pemicu',
                    hintText: 'Pilih pemicu (opsional)',
                    border: OutlineInputBorder(),
                  ),
                  // initialValue dipakai menggantikan `value` yang deprecated sejak Flutter 3.33 agar `flutter analyze` bersih.
                  initialValue: _pemicu,
                  items: PemicuEnum.values.map((pemicu) {
                    return DropdownMenuItem<PemicuEnum>(
                      value: pemicu,
                      child: Row(
                        children: [
                          Icon(pemicu.icon, size: 20),
                          const SizedBox(width: 8),
                          Text(pemicu.label),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _pemicu = value);
                    L.i('_pemicu=$value');
                  },
                ),
                InputTeks(
                  controller: _catatanController,
                  label: 'Catatan',
                  hintText: 'Catatan tambahan (opsional)',
                  wajib: false,
                  minLines: 2,
                  maxLines: 4,
                ),
                FilledButton(onPressed: _simpan, child: const Text('Simpan')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
