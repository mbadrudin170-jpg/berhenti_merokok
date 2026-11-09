import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/helper/impian_progres_helper.dart';
import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
// Urutan paket alfabetis: notifier diurutkan sebelum screens, sesuai aturan import ordering.
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/screens/form_impian.dart';
import 'package:berhenti_merokok/fitur/impian/widget/visual_tabungan_impian.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class DetailImpianScreen extends ConsumerWidget {
  final String id;
  const DetailImpianScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final impianAsync = ref.watch(impianProvider);
    final biodataAsync = ref.watch(biodataProvider);

    if (impianAsync.isLoading || biodataAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (impianAsync.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Impian')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Gagal memuat data impian'),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      final _ = ref.refresh(impianProvider);
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (biodataAsync.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Impian')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Gagal memuat data biodata'),
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
          ),
        ),
      );
    }

    final impianState = impianAsync.requireValue;
    final ImpianModel? impian = impianState.listImpian.firstWhereOrNull(
      (item) => item.id == id,
    );

    if (impian == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Impian')),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text('Impian tidak ditemukan')),
          ),
        ),
      );
    }

    final uangDihemat = biodataAsync.requireValue?.uangDihemat ?? 0.0;
    final rasio = ImpianProgresHelper.rasio(uangDihemat, impian.jumlah);
    final sudahTercapai = ImpianProgresHelper.tercapai(
      uangDihemat,
      impian.jumlah,
    );
    final sisa = ImpianProgresHelper.sisa(uangDihemat, impian.jumlah);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Impian'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.pencil),
            onPressed: () =>
                unawaited(Nav.to(context, FormImpian(impian: impian))),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                VisualTabunganImpian(rasio: rasio, tercapai: sudahTercapai),
                _buildItem(context, 'Nama', impian.nama),
                _buildItem(
                  context,
                  'Jumlah',
                  FormatUang.formatRupiah(impian.jumlah),
                ),
                _buildItem(
                  context,
                  'Target tanggal',
                  FormatTanggal.formatDasar(impian.targetTanggal),
                ),
                _buildItem(
                  context,
                  'Dibuat',
                  FormatTanggal.formatDasar(impian.dibuat),
                ),
                _buildItem(
                  context,
                  'Status',
                  sudahTercapai ? 'Tercapai' : 'Belum tercapai',
                ),
                _buildItem(
                  context,
                  'Progres',
                  '${(rasio * 100).toStringAsFixed(0)}%',
                ),
                _buildItem(context, 'Sisa', FormatUang.formatRupiah(sisa)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String label, String nilai) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(nilai, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
