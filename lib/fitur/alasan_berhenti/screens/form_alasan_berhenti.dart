import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/alasan_berhenti/model/alasan_berhenti_model.dart';
import 'package:berhenti_merokok/fitur/alasan_berhenti/notifier/alasan_berhenti_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Daftar pilihan cepat alasan umum (snippet) yang dapat dipilih pengguna.
const List<String> _snippetAlasan = [
  'Menjaga kesehatan paru-paru dan jantung',
  'Menghemat uang untuk kebutuhan keluarga',
  'Memberi contoh baik bagi anak/keluarga',
  'Menghindari bau rokok dan gigi kuning',
  'Meningkatkan stamina dan kebugaran',
  'Menepati janji pada diri sendiri',
  'Mengurangi risiko penyakit serius',
  'Hidup lebih lama dan berkualitas',
];

class FormAlasanBerhenti extends ConsumerStatefulWidget {
  final AlasanBerhentiModel? alasan;
  const FormAlasanBerhenti({super.key, this.alasan});

  @override
  ConsumerState<FormAlasanBerhenti> createState() => _FormAlasanBerhentiState();
}

class _FormAlasanBerhentiState extends ConsumerState<FormAlasanBerhenti> {
  final _formKey = GlobalKey<FormState>();
  final _teksController = TextEditingController();
  final _teksFocusNode = FocusNode();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final alasan = widget.alasan;
    L.i('alasan=$alasan');
    if (alasan != null) {
      _teksController.text = alasan.teks;
      L.i('_teksController.text=${_teksController.text}');
    }
  }

  @override
  void dispose() {
    _teksController.dispose();
    _teksFocusNode.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (_isLoading) {
      L.w('Form alasan berhenti masih loading, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('validasi form gagal');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Simpan Alasan',
      message: 'Apakah Anda yakin ingin menyimpan alasan berhenti ini?',
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
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
        return null;
      }),
    );
    try {
      final teks = _teksController.text.trim();
      L.i('teks=$teks');
      if (widget.alasan == null) {
        L.i('alasan null, tambah');
        await ref.read(alasanBerhentiProvider.notifier).tambah(teks);
      } else {
        L.i('alasan tidak null, ubah');
        final model = AlasanBerhentiModel(
          id: widget.alasan!.id,
          teks: teks,
          dibuat: widget.alasan!.dibuat,
        );
        await ref.read(alasanBerhentiProvider.notifier).ubah(model);
      }
      if (!mounted) return;
      if (Navigator.of(context).canPop()) {
        Nav.pop(context);
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan alasan berhenti: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan alasan berhenti');
      }
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading: $e $s');
          return null;
        }),
      );
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
        title: Text(widget.alasan == null ? 'Tambah Alasan' : 'Ubah Alasan'),
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
                  'Pilihan cepat (opsional)',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _snippetAlasan.map((snippet) {
                    final terpilih = _teksController.text.trim() == snippet;
                    L.i('snippet=$snippet, terpilih=$terpilih');
                    return FilterChip(
                      label: Text(snippet),
                      selected: terpilih,
                      onSelected: (dipilih) {
                        L.i('snippet dipilih=$snippet, dipilih=$dipilih');
                        setState(() {
                          _teksController.text = dipilih ? snippet : '';
                        });
                      },
                    );
                  }).toList(),
                ),
                InputTeks(
                  controller: _teksController,
                  label: 'Alasan berhenti',
                  hintText: 'Tulis alasan Anda berhenti merokok',
                  focusNode: _teksFocusNode,
                  wajib: true,
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
