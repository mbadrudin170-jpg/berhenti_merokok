import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/fitur/pemulihan_kesehatan/helper/progres_milestone_helper.dart';
import 'package:berhenti_merokok/shared/konstanta/milestone_kesehatan.dart';
import 'package:berhenti_merokok/shared/widget/empty_state_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman pemulihan kesehatan (milestone) berdasarkan durasi smoke-free.
///
/// Menampilkan daftar milestone kesehatan yang dicapai seiring waktu tanpa
/// rokok, beserta status tercapai/belum.
class PemulihanKesehatanScreen extends ConsumerStatefulWidget {
  const PemulihanKesehatanScreen({super.key});

  @override
  ConsumerState<PemulihanKesehatanScreen> createState() =>
      _PemulihanKesehatanScreenState();
}

class _PemulihanKesehatanScreenState
    extends ConsumerState<PemulihanKesehatanScreen> {
  @override
  void initState() {
    super.initState();
    L.i('PemulihanKesehatanScreen initState');
  }

  @override
  void dispose() {
    L.i('PemulihanKesehatanScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);

    if (biodataAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      L.e(
        'biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}',
      );
      return Scaffold(
        appBar: AppBar(title: const Text('Pemulihan Kesehatan')),
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
      return _buildBiodataNull();
    }

    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    if (tanggalBerhenti == null) {
      return _buildBelumBerhenti();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pemulihan Kesehatan')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderPemulihan(tanggalBerhenti: tanggalBerhenti),
              Expanded(
                child: ListView.separated(
                  itemCount: daftarMilestoneKesehatan.length,
                  itemBuilder: (context, index) {
                    final m = daftarMilestoneKesehatan[index];
                    final durasi = DateTime.now().difference(tanggalBerhenti);
                    final aman = durasi.isNegative ? Duration.zero : durasi;
                    final tercapai = ProgresMilestoneHelper.tercapai(
                      aman,
                      m.target,
                    );
                    final rasio = ProgresMilestoneHelper.rasio(aman, m.target);
                    final persen = ProgresMilestoneHelper.persentase(
                      aman,
                      m.target,
                    );
                    final sisa = ProgresMilestoneHelper.sisaWaktu(
                      aman,
                      m.target,
                    );
                    final labelProgres = tercapai
                        ? 'Tercapai · 100%'
                        : '$persen% · Tersisa ${_formatTarget(sisa)}';
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
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
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
                              'Target: ${_formatTarget(m.target)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            LinearProgressIndicator(
                              value: rasio,
                              minHeight: 6,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              color: tercapai ? Colors.green : null,
                            ),
                            Text(
                              labelProgres,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
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

  Widget _buildBiodataNull() {
    return Scaffold(
      appBar: AppBar(title: const Text('Pemulihan Kesehatan')),
      body: EmptyStateView(
        ikon: CupertinoIcons.person,
        judul: 'Belum ada data biodata',
        deskripsi:
            'Pemulihan kesehatan membutuhkan biodata untuk menghitung '
            'milestone berdasarkan kebiasaan merokokmu.',
        ctaLabel: 'Isi Biodata',
        onCta: _bukaFormBiodata,
      ),
    );
  }

  Widget _buildBelumBerhenti() {
    return Scaffold(
      appBar: AppBar(title: const Text('Pemulihan Kesehatan')),
      body: EmptyStateView(
        ikon: CupertinoIcons.heart,
        judul: 'Belum ada tanggal mulai berhenti',
        deskripsi:
            'Isi tanggal mulai berhenti pada biodata untuk melihat '
            'pemulihan kesehatan.',
        ctaLabel: 'Isi Biodata',
        onCta: _bukaFormBiodata,
      ),
    );
  }

  void _bukaFormBiodata() {
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

  static String _formatTarget(Duration d) {
    if (d.inDays >= 365) {
      final tahun = (d.inDays / 365).round();
      if (tahun == 1) return '1 tahun';
      return '$tahun tahun';
    }
    if (d.inDays >= 30) {
      final bulan = (d.inDays / 30).round();
      if (bulan == 1) return '1 bulan';
      return '$bulan bulan';
    }
    if (d.inDays >= 7) {
      final minggu = (d.inDays / 7).round();
      if (minggu == 1) return '1 minggu';
      return '$minggu minggu';
    }
    if (d.inDays >= 1) {
      if (d.inDays == 1) return '1 hari';
      return '${d.inDays} hari';
    }
    if (d.inHours >= 1) {
      if (d.inHours == 1) return '1 jam';
      return '${d.inHours} jam';
    }
    return '${d.inMinutes} menit';
  }
}

/// Widget header yang menampilkan durasi smoke-free dan milestone berikutnya.
///
/// Menggunakan [Timer] sendiri agar hanya widget ini yang rebuild setiap detik,
/// bukan seluruh halaman.
class _HeaderPemulihan extends StatefulWidget {
  const _HeaderPemulihan({required this.tanggalBerhenti});

  final DateTime tanggalBerhenti;

  @override
  State<_HeaderPemulihan> createState() => _HeaderPemulihanState();
}

class _HeaderPemulihanState extends State<_HeaderPemulihan> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    L.i('HeaderPemulihan initState');
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    L.i('HeaderPemulihan dispose');
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final durasiSmokeFree = DateTime.now().difference(widget.tanggalBerhenti);
    final durasi = durasiSmokeFree.isNegative ? Duration.zero : durasiSmokeFree;
    final berikutnya = milestoneBerikutnya(durasi);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Lama smoke-free',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _formatDurasi(durasi),
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Sejak ${FormatTanggal.formatDasar(widget.tanggalBerhenti)}',
              style: textTheme.bodySmall,
            ),
            if (berikutnya != null) ...[
              const SizedBox(height: 4),
              Text(
                'Milestone berikutnya: ${berikutnya.judul}',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Tersisa ${_formatDurasi(berikutnya.target - durasi)}',
                style: textTheme.bodySmall,
              ),
            ] else
              Text(
                'Semua milestone tercapai. Selamat!',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDurasi(Duration d) {
    if (d.inDays > 0) {
      final hari = d.inDays;
      final jam = d.inHours % 24;
      final menit = d.inMinutes % 60;
      final bagian = <String>['$hari hari'];
      if (jam > 0) bagian.add('$jam jam');
      if (menit > 0) bagian.add('$menit menit');
      return bagian.join(' ');
    }
    if (d.inHours > 0) {
      final jam = d.inHours;
      final menit = d.inMinutes % 60;
      final detik = d.inSeconds % 60;
      final bagian = <String>['$jam jam'];
      if (menit > 0) bagian.add('$menit menit');
      bagian.add('$detik detik');
      return bagian.join(' ');
    }
    final menit = d.inMinutes;
    final detik = d.inSeconds % 60;
    if (menit > 0) return '$menit menit $detik detik';
    return '$detik detik';
  }
}
