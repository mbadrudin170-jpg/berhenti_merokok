import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/rencana_darurat/model/rencana_darurat_model.dart';
import 'package:berhenti_merokok/fitur/rencana_darurat/notifier/rencana_darurat_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Form tambah/ubah rencana darurat if-then.
class FormRencanaDarurat extends ConsumerStatefulWidget {
  const FormRencanaDarurat({super.key, this.rencana});

  /// Rencana yang diubah; `null` untuk mode tambah.
  final RencanaDaruratModel? rencana;

  @override
  ConsumerState<FormRencanaDarurat> createState() => _FormRencanaDaruratState();
}

class _FormRencanaDaruratState extends ConsumerState<FormRencanaDarurat> {
  final _formKey = GlobalKey<FormState>();
  final _jikaController = TextEditingController();
  final _makaController = TextEditingController();
  final _jikaFocusNode = FocusNode();
  final _makaFocusNode = FocusNode();

  bool _sedangMemproses = false;

  @override
  void initState() {
    super.initState();
    final rencana = widget.rencana;
    L.i('rencana=$rencana');
    if (rencana != null) {
      _jikaController.text = rencana.jika;
      _makaController.text = rencana.maka;
    }
  }

  @override
  void dispose() {
    _jikaController.dispose();
    _makaController.dispose();
    _jikaFocusNode.dispose();
    _makaFocusNode.dispose();
    super.dispose();
  }

  String? _validasi(String? value) {
    final teks = value?.trim() ?? '';
    if (teks.isEmpty) {
      return 'Wajib diisi';
    }
    if (teks.length > panjangMaksRencanaDarurat) {
      return 'Maksimal $panjangMaksRencanaDarurat karakter';
    }
    return null;
  }

  Future<void> _simpan() async {
    if (_sedangMemproses) {
      L.w('Form rencana darurat masih memproses, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('validasi form gagal');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Simpan Rencana',
      message: 'Apakah Anda yakin ingin menyimpan rencana darurat ini?',
      okLabel: 'Simpan',
      cancelLabel: 'Batal',
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      L.w('konfirmasi bukan ok');
      return;
    }
    if (!mounted) return;

    setState(() => _sedangMemproses = true);
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
      final jika = _jikaController.text.trim();
      final maka = _makaController.text.trim();
      if (!rencanaDaruratValid(jika, maka)) {
        L.w('rencana tidak valid setelah trim');
        if (mounted) {
          AppToast.gagal(context, 'Rencana tidak valid');
        }
        return;
      }
      final notifier = ref.read(rencanaDaruratProvider.notifier);
      if (widget.rencana == null) {
        await notifier.tambah(jika: jika, maka: maka);
      } else {
        final model = widget.rencana!.copyWith(jika: jika, maka: maka);
        await notifier.ubah(model);
      }
      if (!mounted) return;
      if (Navigator.of(context).canPop()) {
        Nav.pop(context);
      }
    } on RencanaPenuhException catch (e, s) {
      L.e('Gagal menyimpan rencana darurat (penuh): $e $s');
      if (mounted) {
        AppToast.gagal(
          context,
          'Maksimal $batasMaksRencanaDarurat rencana tersimpan',
        );
      }
    } on RencanaDuplikatException catch (e, s) {
      L.e('Gagal menyimpan rencana darurat (duplikat): $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Rencana untuk situasi ini sudah ada');
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan rencana darurat: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan rencana darurat');
      }
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading: $e $s');
          return null;
        }),
      );
      if (mounted) {
        setState(() => _sedangMemproses = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.rencana == null ? 'Tambah Rencana' : 'Ubah Rencana',
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
                Text(
                  'Rencana "Jika …, Maka …" dipakai saat craving datang. '
                  'Pilih tindakan yang bisa langsung dilakukan.',
                  style: textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                InputTeks(
                  controller: _jikaController,
                  label: 'Jika …',
                  hintText: 'mis. habis makan',
                  focusNode: _jikaFocusNode,
                  nextFocusNode: _makaFocusNode,
                  wajib: true,
                  maxLength: panjangMaksRencanaDarurat,
                  validator: _validasi,
                ),
                InputTeks(
                  controller: _makaController,
                  label: 'Maka …',
                  hintText: 'mis. sikat gigi',
                  helperText: 'Pilih tindakan yang bisa langsung dilakukan',
                  focusNode: _makaFocusNode,
                  textInputAction: TextInputAction.done,
                  wajib: true,
                  maxLength: panjangMaksRencanaDarurat,
                  validator: _validasi,
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: _sedangMemproses ? null : () => unawaited(_simpan()),
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
