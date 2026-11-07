import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
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
    final tanggalBerhenti = biodata?.tanggalMulaiBerhentiMerokok;
    final nama = biodata?.nama;

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
                      if (nama != null && nama.isNotEmpty)
                        Text(
                          'Halo, $nama',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                ),
              ),
            ],
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
  if (jam > 0 || hari > 0) {
    bagian.add('$jam jam');
  }
  if (menit > 0 || jam > 0 || hari > 0) {
    bagian.add('$menit menit');
  }
  bagian.add('$detik detik');
  return bagian.join(' ');
}
