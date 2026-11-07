import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);

    if (biodataAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Dashboard')),
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
    final nama = biodata.nama;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        'Lama berhenti merokok',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      _DurasiBerhenti(tanggalBerhenti: tanggalBerhenti),
                      if (tanggalBerhenti != null)
                        Text(
                          'Sejak ${FormatTanggal.formatDasar(tanggalBerhenti)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      if (nama.isNotEmpty)
                        Text(
                          'Halo, $nama',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                ),
              ),
              _buildCardProgres(biodata),
              _buildInfoKerugian(biodata),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardProgres(BiodataModel biodata) {
    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    final jumlahRokokPerHari = biodata.jumlahRokokPerHari;
    final hargaPerBungkus = biodata.hargaRokokPerBungkus;

    int hariBerhenti = 0;
    if (tanggalBerhenti != null) {
      hariBerhenti = DateTime.now().difference(tanggalBerhenti).inDays;
      if (hariBerhenti < 0) {
        hariBerhenti = 0;
      }
    }

    final rokokTidakDiHisap = jumlahRokokPerHari * hariBerhenti;
    final uangDihemat =
        (rokokTidakDiHisap / biodata.batangPerBungkus) * hargaPerBungkus;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Uang dihemat',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              FormatUang.formatRupiah(uangDihemat),
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Rokok tidak dihisap',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              '$rokokTidakDiHisap batang',
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoKerugian(BiodataModel biodata) {
    final jumlahRokokPerHari = biodata.jumlahRokokPerHari;
    final hargaPerBungkus = biodata.hargaRokokPerBungkus;
    final tanggalMulaiMerokok = biodata.tanggalMulaiMerokok;
    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;

    int totalHariMerokok = 0;
    if (tanggalMulaiMerokok != null && tanggalBerhenti != null) {
      totalHariMerokok = tanggalBerhenti.difference(tanggalMulaiMerokok).inDays;
      if (totalHariMerokok < 0) {
        totalHariMerokok = 0;
      }
    }

    final rokokDihisap = jumlahRokokPerHari * totalHariMerokok;
    final uangTerbuang =
        (rokokDihisap / biodata.batangPerBungkus) * hargaPerBungkus;
    final menitHilang = (rokokDihisap * 11).round();
    final hariHilang = menitHilang / (24 * 60);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Kerugian saat merokok',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            _buildInfoKerugianKustom(
              CupertinoIcons.smoke,
              '$rokokDihisap batang',
              'rokok yang dihisap',
            ),
            _buildInfoKerugianKustom(
              CupertinoIcons.money_dollar,
              FormatUang.formatRupiah(uangTerbuang),
              'uang yang terbuang',
            ),
            _buildInfoKerugianKustom(
              CupertinoIcons.heart,
              '${hariHilang.toStringAsFixed(1)} hari',
              'hidup yang hilang',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoKerugianKustom(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildBiodataNull() {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                const Text('Belum ada data biodata'),
                OutlinedButton(
                  onPressed: () => unawaited(
                    Nav.to(context, const FormBiodata(buatPertama: false)),
                  ),
                  child: const Text('Isi Biodata'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget kecil yang menampilkan durasi berhenti merokok dan memperbarui tampilannya setiap detik tanpa memicu rebuild seluruh halaman.
class _DurasiBerhenti extends StatefulWidget {
  const _DurasiBerhenti({required this.tanggalBerhenti});

  final DateTime? tanggalBerhenti;

  @override
  State<_DurasiBerhenti> createState() => _DurasiBerhentiState();
}

class _DurasiBerhentiState extends State<_DurasiBerhenti> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatLamaBerhenti(widget.tanggalBerhenti),
      style: Theme.of(context).textTheme.headlineMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

/// Menghitung lama waktu (hari, jam, menit, detik) sejak [tanggalBerhenti] hingga saat ini.
String _formatLamaBerhenti(DateTime? tanggalBerhenti) {
  if (tanggalBerhenti == null) {
    return 'Belum ditentukan';
  }
  final selisih = DateTime.now().difference(tanggalBerhenti);
  if (selisih.isNegative) {
    return '0 detik';
  }

  final hari = selisih.inDays;
  final jam = selisih.inHours % 24;
  final menit = selisih.inMinutes % 60;
  final detik = selisih.inSeconds % 60;

  final bagian = <String>[];
  if (hari > 0) {
    bagian.add('$hari hari');
  }
  if (jam > 0) {
    bagian.add('$jam jam');
  }
  if (menit > 0) {
    bagian.add('$menit menit');
  }
  bagian.add('$detik detik');
  return bagian.join(' ');
}
