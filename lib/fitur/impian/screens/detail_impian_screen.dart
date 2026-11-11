import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/enum/tema_visual_impian.dart';
import 'package:berhenti_merokok/fitur/impian/helper/impian_progres_helper.dart';
import 'package:berhenti_merokok/fitur/impian/helper/riwayat_tabungan_helper.dart';
import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
// Urutan paket alfabetis: notifier diurutkan sebelum screens, sesuai aturan import ordering.
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/tema_visual_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/screens/form_impian.dart';
import 'package:berhenti_merokok/fitur/impian/widget/visual_tabungan_impian.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart';
import 'package:berhenti_merokok/shared/widget/empty_state_view.dart';
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
    final konsumsiAsync = ref.watch(konsumsiRokokProvider);
    // Tema visual metafora impian: bila gagal dimuat/invalid, gunakan
    // tema default pertama.
    final temaVisualAsync = ref.watch(temaVisualProvider);
    final temaVisual = temaVisualAsync.asData?.value ?? TemaVisualImpian.toples;
    L.i('temaVisual=$temaVisual');

    if (impianAsync.isLoading ||
        biodataAsync.isLoading ||
        konsumsiAsync.isLoading) {
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
                spacing: 8,
                children: [
                  const Text('Gagal memuat data impian'),
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
                spacing: 8,
                children: [
                  const Text('Gagal memuat data biodata'),
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

    if (konsumsiAsync.hasError) {
      L.e('konsumsiAsync error: ${konsumsiAsync.error}');
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Impian')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const Text('Gagal memuat data konsumsi'),
                  OutlinedButton(
                    onPressed: () {
                      final _ = ref.refresh(konsumsiRokokProvider);
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
        body: EmptyStateView(
          ikon: CupertinoIcons.question_circle,
          judul: 'Impian tidak ditemukan',
          deskripsi:
              'Impian ini mungkin sudah dihapus atau tidak tersedia lagi.',
          ctaLabel: 'Kembali',
          onCta: () => Nav.pop(context),
        ),
      );
    }

    final BiodataModel? biodata = biodataAsync.requireValue;
    final konsumsiList = konsumsiAsync.requireValue.listKonsumsi;
    final uangEstimasi = biodata == null
        ? 0.0
        : MetrikBerhentiHelper.hitungUangDihematEstimasi(biodata);
    final uangAktual = biodata == null
        ? 0.0
        : MetrikBerhentiHelper.hitungUangDihematAktual(biodata, konsumsiList);
    final hariTercatat = MetrikBerhentiHelper.hitungJumlahHariTercatat(
      konsumsiList,
    );
    final pakaiAktual = hariTercatat > 0;
    // Progres impian: aktual bila ada catatan, fallback estimasi.
    final saldoUntukProgres = pakaiAktual ? uangAktual : uangEstimasi;
    // Riwayat penghematan per hari (aktual) dari catatan konsumsi.
    final riwayatEntries = biodata == null
        ? const <RiwayatTabunganEntry>[]
        : RiwayatTabunganHelper.dariKonsumsi(biodata, konsumsiList);
    L.i(
      'uangEstimasi=$uangEstimasi, uangAktual=$uangAktual, hariTercatat=$hariTercatat, pakaiAktual=$pakaiAktual, saldoUntukProgres=$saldoUntukProgres, riwayatEntries.length=${riwayatEntries.length}',
    );
    final rasio = ImpianProgresHelper.rasio(saldoUntukProgres, impian.jumlah);
    final sudahTercapai = ImpianProgresHelper.tercapai(
      saldoUntukProgres,
      impian.jumlah,
    );
    final sisa = ImpianProgresHelper.sisa(saldoUntukProgres, impian.jumlah);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Impian'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.pencil),
            onPressed: () => unawaited(
              Nav.to(context, FormImpian(impian: impian)).catchError((
                Object e,
                StackTrace s,
              ) {
                L.e('Gagal navigasi ke Form Impian: $e $s');
                return null;
              }),
            ),
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
                if (impian.jumlah <= 0)
                  Text(
                    'Atur target impian terlebih dahulu',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                VisualTabunganImpian(
                  rasio: rasio,
                  tercapai: sudahTercapai,
                  tema: temaVisual,
                  pakaiAktual: pakaiAktual,
                  labelSaldo: pakaiAktual
                      ? 'Progres dari catatan (berdasarkan $hariTercatat hari tercatat)'
                      : 'Progres estimasi dari biodata',
                ),
                Row(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildItem(
                        context,
                        'Estimasi',
                        FormatUang.formatRupiah(uangEstimasi),
                      ),
                    ),
                    Expanded(
                      child: _buildItem(
                        context,
                        'Dari catatan',
                        pakaiAktual
                            ? FormatUang.formatRupiah(uangAktual)
                            : 'Belum ada catatan',
                      ),
                    ),
                  ],
                ),
                Text(
                  pakaiAktual
                      ? 'Aktual berdasarkan $hariTercatat hari tercatat. Estimasi dari kebiasaan harian biodata.'
                      : 'Belum ada catatan konsumsi. Menampilkan estimasi dari kebiasaan harian biodata.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
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
                  pakaiAktual ? 'Progres' : 'Progres (estimasi)',
                  '${(rasio * 100).toStringAsFixed(0)}%',
                ),
                _buildItem(
                  context,
                  'Sumber progres',
                  pakaiAktual
                      ? 'Dari catatan ($hariTercatat hari tercatat)'
                      : 'Estimasi (belum ada catatan)',
                ),
                _buildItem(
                  context,
                  pakaiAktual ? 'Sisa' : 'Sisa (estimasi)',
                  FormatUang.formatRupiah(sisa),
                ),
                _buildSectionTitle(context, 'Tema visual'),
                RadioGroup<TemaVisualImpian>(
                  groupValue: temaVisual,
                  onChanged: (TemaVisualImpian? nilai) {
                    if (nilai == null) {
                      L.w('tema visual yang dipilih null');
                      return;
                    }
                    L.i('temaVisual dipilih=$nilai');
                    unawaited(
                      ref
                          .read(temaVisualProvider.notifier)
                          .set(nilai)
                          .catchError((Object e, StackTrace s) {
                            L.e('Gagal menyimpan tema visual impian: $e $s');
                          }),
                    );
                  },
                  child: Column(
                    spacing: 0,
                    children: [
                      for (final tema in TemaVisualImpian.values)
                        RadioListTile<TemaVisualImpian>(
                          value: tema,
                          title: Text(tema.label),
                          secondary: Icon(tema.icon),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                    ],
                  ),
                ),
                _buildSectionTitle(context, 'Riwayat penghematan (dari catatan)'),
                _buildRiwayat(context, riwayatEntries),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String teks) {
    return Text(
      teks,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRiwayat(BuildContext context, List<RiwayatTabunganEntry> entri) {
    if (entri.isEmpty) {
      return const EmptyStateView(
        ikon: CupertinoIcons.money_dollar_circle,
        judul: 'Belum ada riwayat',
        deskripsi:
            'Riwayat penghematan per hari akan muncul di sini setelah Anda '
            'mencatat konsumsi.',
      );
    }
    const tabular = <FontFeature>[FontFeature.tabularFigures()];
    return Column(
      spacing: 8,
      children: [
        for (var i = 0; i < entri.length; i++) ...[
          if (i > 0) const Divider(height: 1, thickness: 1),
          _buildRiwayatItem(context, entri[i], tabular),
        ],
      ],
    );
  }

  Widget _buildRiwayatItem(
    BuildContext context,
    RiwayatTabunganEntry entri,
    List<FontFeature> tabular,
  ) {
    final labelTanggal = FormatTanggal.formatDasar(entri.tanggal);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: Text(
                labelTanggal,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text(
              '+${FormatUang.formatRupiah(entri.nilai)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontFeatures: tabular,
              ),
            ),
          ],
        ),
        Text(
          '${entri.rokokDihindari} batang dihindari · Saldo ${FormatUang.formatRupiah(entri.saldoSetelah)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontFeatures: tabular,
          ),
        ),
      ],
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
