import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/fitur/pemulihan_kesehatan/helper/progres_milestone_helper.dart';
import 'package:berhenti_merokok/fitur/pemulihan_kesehatan/helper/progres_organ_helper.dart';
import 'package:berhenti_merokok/shared/konstanta/organ_pemulihan.dart';
import 'package:berhenti_merokok/shared/widget/empty_state_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman detail pemulihan kesehatan untuk satu sistem organ.
///
/// Menampilkan nama organ, persentase pemulihan, milestone berikutnya beserta
/// sisa waktu, lalu seluruh milestone milik organ tersebut dengan status
/// tercapai/belum.
class DetailOrganPemulihanScreen extends ConsumerWidget {
  const DetailOrganPemulihanScreen({required this.organ, super.key});

  final OrganPemulihan organ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final biodataAsync = ref.watch(biodataProvider);
    final textTheme = Theme.of(context).textTheme;
    final judul = 'Pemulihan ${organ.label}';

    if (biodataAsync.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(judul)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (biodataAsync.hasError) {
      L.e(
        'biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}',
      );
      return Scaffold(
        appBar: AppBar(title: Text(judul)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const Text('Gagal memuat data'),
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

    final biodata = biodataAsync.requireValue;
    if (biodata == null) {
      return Scaffold(
        appBar: AppBar(title: Text(judul)),
        body: EmptyStateView(
          ikon: CupertinoIcons.person,
          judul: 'Belum ada data biodata',
          deskripsi:
              'Detail pemulihan per organ membutuhkan biodata untuk '
              'menghitung progres.',
          ctaLabel: 'Isi Biodata',
          onCta: () => _bukaFormBiodata(context),
        ),
      );
    }

    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    if (tanggalBerhenti == null) {
      return Scaffold(
        appBar: AppBar(title: Text(judul)),
        body: EmptyStateView(
          ikon: CupertinoIcons.heart,
          judul: 'Belum ada tanggal mulai berhenti',
          deskripsi:
              'Isi tanggal mulai berhenti pada biodata untuk melihat '
              'detail pemulihan organ.',
          ctaLabel: 'Isi Biodata',
          onCta: () => _bukaFormBiodata(context),
        ),
      );
    }

    final durasiKotor = DateTime.now().difference(tanggalBerhenti);
    final durasi = durasiKotor.isNegative ? Duration.zero : durasiKotor;
    final persen = ProgresOrganHelper.persentaseOrgan(durasi, organ);
    final selesai = ProgresOrganHelper.organSelesai(durasi, organ);
    final berikutnya = ProgresOrganHelper.milestoneBerikutnyaOrgan(
      durasi,
      organ,
    );
    final daftar = ProgresOrganHelper.milestoneOrgan(organ);

    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Row(
                spacing: 12,
                children: [
                  Icon(
                    organ.icon,
                    size: 40,
                    color: selesai ? Colors.green : null,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(
                          organ.label,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Pemulihan $persen%',
                          style: textTheme.bodyMedium?.copyWith(
                            color: selesai ? Colors.green : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: persen / 100,
                minHeight: 8,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                color: selesai ? Colors.green : null,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      if (berikutnya != null) ...[
                        Text(
                          'Milestone berikutnya: ${berikutnya.judul}',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Tersisa '
                          '${ProgresOrganHelper.formatDurasi(ProgresMilestoneHelper.sisaWaktu(durasi, berikutnya.target))}',
                          style: textTheme.bodySmall,
                        ),
                      ] else
                        Text(
                          'Semua milestone organ tercapai. Selamat!',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: daftar.length,
                  itemBuilder: (context, index) {
                    final m = daftar[index];
                    final tercapai = ProgresMilestoneHelper.tercapai(
                      durasi,
                      m.target,
                    );
                    final rasio = ProgresMilestoneHelper.rasio(
                      durasi,
                      m.target,
                    );
                    final persenItem = ProgresMilestoneHelper.persentase(
                      durasi,
                      m.target,
                    );
                    final sisa = ProgresMilestoneHelper.sisaWaktu(
                      durasi,
                      m.target,
                    );
                    final labelProgres = tercapai
                        ? 'Tercapai · 100%'
                        : '$persenItem% · Tersisa ${ProgresOrganHelper.formatDurasi(sisa)}';
                    return Card(
                      key: ValueKey(m.judul),
                      child: ListTile(
                        isThreeLine: true,
                        leading: Icon(
                          tercapai
                              ? CupertinoIcons.check_mark_circled_solid
                              : CupertinoIcons.clock,
                          color: tercapai ? Colors.green : null,
                        ),
                        title: Text(
                          m.judul,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: tercapai ? Colors.green : null,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(m.deskripsi),
                            Text(
                              'Target: ${ProgresOrganHelper.formatTarget(m.target)}',
                              style: textTheme.bodySmall,
                            ),
                            LinearProgressIndicator(
                              value: rasio,
                              minHeight: 6,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
                              color: tercapai ? Colors.green : null,
                            ),
                            Text(
                              labelProgres,
                              style: textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: tercapai ? Colors.green : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _bukaFormBiodata(BuildContext context) {
    unawaited(
      Nav.to(context, const FormBiodata(buatPertama: false)).catchError((
        Object e,
        StackTrace s,
      ) {
        L.e('Gagal navigasi ke Form Biodata: $e $s');
        return null;
      }),
    );
  }
}
