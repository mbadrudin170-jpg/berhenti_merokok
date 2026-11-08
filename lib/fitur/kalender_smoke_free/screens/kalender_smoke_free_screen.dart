import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman kalender smoke-free.
///
/// Menampilkan kalender bulanan yang menandai hari-hari smoke-free sejak
/// tanggal mulai berhenti merokok, beserta ringkasan progres.
class KalenderSmokeFreeScreen extends ConsumerStatefulWidget {
  const KalenderSmokeFreeScreen({super.key});

  @override
  ConsumerState<KalenderSmokeFreeScreen> createState() =>
      _KalenderSmokeFreeScreenState();
}

class _KalenderSmokeFreeScreenState
    extends ConsumerState<KalenderSmokeFreeScreen> {
  DateTime _bulanDitampilkan = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  );

  static const List<String> _namaHari = [
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min',
  ];

  @override
  void initState() {
    super.initState();
    L.i('KalenderSmokeFreeScreen initState');
  }

  @override
  void dispose() {
    L.i('KalenderSmokeFreeScreen dispose');
    super.dispose();
  }

  void _bulanSebelumnya() {
    setState(() {
      _bulanDitampilkan = DateTime(
        _bulanDitampilkan.year,
        _bulanDitampilkan.month - 1,
      );
    });
  }

  void _bulanBerikutnya() {
    setState(() {
      _bulanDitampilkan = DateTime(
        _bulanDitampilkan.year,
        _bulanDitampilkan.month + 1,
      );
    });
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
        appBar: AppBar(title: const Text('Kalender Smoke-Free')),
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

    final hariIni = DateTime.now();
    final hariIniDate = DateTime(hariIni.year, hariIni.month, hariIni.day);
    final tanggalBerhentiDate = DateTime(
      tanggalBerhenti.year,
      tanggalBerhenti.month,
      tanggalBerhenti.day,
    );

    final totalSmokeFree =
        hariIniDate.difference(tanggalBerhentiDate).inDays + 1;
    final totalSmokeFreeAman = totalSmokeFree < 0 ? 0 : totalSmokeFree;

    return Scaffold(
      appBar: AppBar(title: const Text('Kalender Smoke-Free')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RingkasanSmokeFree(
                tanggalBerhenti: tanggalBerhentiDate,
                totalSmokeFree: totalSmokeFreeAman,
              ),
              _NavigasiBulan(
                bulan: _bulanDitampilkan,
                onSebelumnya: _bulanSebelumnya,
                onBerikutnya: _bulanBerikutnya,
              ),
              _HeaderHari(namaHari: _namaHari),
              Expanded(
                child: _GridKalender(
                  bulan: _bulanDitampilkan,
                  tanggalBerhenti: tanggalBerhentiDate,
                  hariIni: hariIniDate,
                ),
              ),
              const _Legenda(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBiodataNull() {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalender Smoke-Free')),
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

  Widget _buildBelumBerhenti() {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalender Smoke-Free')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                const Icon(CupertinoIcons.calendar, size: 48),
                const Text(
                  'Belum ada tanggal mulai berhenti merokok.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Isi tanggal mulai berhenti pada biodata untuk melihat '
                  'kalender smoke-free.',
                  textAlign: TextAlign.center,
                ),
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

class _RingkasanSmokeFree extends StatelessWidget {
  const _RingkasanSmokeFree({
    required this.tanggalBerhenti,
    required this.totalSmokeFree,
  });

  final DateTime tanggalBerhenti;
  final int totalSmokeFree;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(
              'Total hari smoke-free',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$totalSmokeFree hari',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              'Sejak ${FormatTanggal.formatDasar(tanggalBerhenti)}',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigasiBulan extends StatelessWidget {
  const _NavigasiBulan({
    required this.bulan,
    required this.onSebelumnya,
    required this.onBerikutnya,
  });

  final DateTime bulan;
  final VoidCallback onSebelumnya;
  final VoidCallback onBerikutnya;

  static const List<String> _namaBulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onSebelumnya,
          icon: const Icon(CupertinoIcons.chevron_left),
          tooltip: 'Bulan sebelumnya',
        ),
        Text(
          '${_namaBulan[bulan.month - 1]} ${bulan.year}',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: onBerikutnya,
          icon: const Icon(CupertinoIcons.chevron_right),
          tooltip: 'Bulan berikutnya',
        ),
      ],
    );
  }
}

class _HeaderHari extends StatelessWidget {
  const _HeaderHari({required this.namaHari});

  final List<String> namaHari;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final h in namaHari)
          Expanded(
            child: Center(
              child: Text(
                h,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}

class _GridKalender extends StatelessWidget {
  const _GridKalender({
    required this.bulan,
    required this.tanggalBerhenti,
    required this.hariIni,
  });

  final DateTime bulan;
  final DateTime tanggalBerhenti;
  final DateTime hariIni;

  @override
  Widget build(BuildContext context) {
    final tahun = bulan.year;
    final bulanIndex = bulan.month;
    final hariPertama = DateTime(tahun, bulanIndex, 1);
    // Monday=1..Sunday=7. Grid Monday-first.
    final offset = (hariPertama.weekday - 1) % 7;
    final jumlahHari = DateTime(tahun, bulanIndex + 1, 0).day;

    final cells = <Widget>[];
    for (int i = 0; i < offset; i++) {
      cells.add(const SizedBox.shrink());
    }
    for (int hari = 1; hari <= jumlahHari; hari++) {
      final tanggal = DateTime(tahun, bulanIndex, hari);
      cells.add(
        _SelHari(
          tanggal: tanggal,
          tanggalBerhenti: tanggalBerhenti,
          hariIni: hariIni,
        ),
      );
    }
    // Pad to multiple of 7.
    while (cells.length % 7 != 0) {
      cells.add(const SizedBox.shrink());
    }

    return GridView.count(
      crossAxisCount: 7,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      physics: const NeverScrollableScrollPhysics(),
      children: cells,
    );
  }
}

class _SelHari extends StatelessWidget {
  const _SelHari({
    required this.tanggal,
    required this.tanggalBerhenti,
    required this.hariIni,
  });

  final DateTime tanggal;
  final DateTime tanggalBerhenti;
  final DateTime hariIni;

  @override
  Widget build(BuildContext context) {
    final sebelumBerhenti = tanggal.isBefore(tanggalBerhenti);
    final setelahHariIni = tanggal.isAfter(hariIni);
    final hariIniFlag = tanggal == hariIni;

    Color? warnaLatar;
    if (sebelumBerhenti) {
      warnaLatar = null;
    } else if (setelahHariIni) {
      warnaLatar = null;
    } else {
      warnaLatar = Colors.green.withValues(alpha: 0.25);
    }

    return Container(
      decoration: BoxDecoration(
        color: warnaLatar,
        borderRadius: BorderRadius.circular(8),
        border: hariIniFlag
            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '${tanggal.day}',
        style: TextStyle(
          fontWeight: hariIniFlag ? FontWeight.bold : FontWeight.normal,
          color: sebelumBerhenti
              ? Theme.of(context).disabledColor
              : (setelahHariIni
                    ? Theme.of(context).disabledColor
                    : Colors.green.shade800),
        ),
      ),
    );
  }
}

class _Legenda extends StatelessWidget {
  const _Legenda();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      spacing: 16,
      children: [
        _ItemLegenda(
          warna: Colors.green.withValues(alpha: 0.25),
          label: 'Smoke-free',
          textTheme: textTheme,
        ),
        _ItemLegenda(
          warna: null,
          label: 'Belum/Lainnya',
          textTheme: textTheme,
          border: true,
        ),
      ],
    );
  }
}

class _ItemLegenda extends StatelessWidget {
  const _ItemLegenda({
    required this.warna,
    required this.label,
    required this.textTheme,
    this.border = false,
  });

  final Color? warna;
  final String label;
  final TextTheme textTheme;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: warna,
            borderRadius: BorderRadius.circular(4),
            border: border
                ? Border.all(color: Theme.of(context).disabledColor)
                : null,
          ),
        ),
        Text(label, style: textTheme.bodySmall),
      ],
    );
  }
}
