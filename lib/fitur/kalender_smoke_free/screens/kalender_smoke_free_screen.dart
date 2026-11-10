import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Status kalender per tanggal, diturunkan dari log konsumsi yang ada.
///
/// Hari tanpa catatan tidak pernah dianggap bebas rokok; status di bawah
/// adalah cerminan apa adanya dari data konsumsi.
enum StatusKalender {
  adaKonsumsi,
  slip,
  tanpaCatatan,
  belumMulai,
  mendatang,
}

/// Kunci tanggal `yyyy-MM-dd` (waktu lokal).
///
/// Format sama dengan `KonsumsiHitungHelper.ringkasanHarian` agar konsisten.
String _keyTanggal(DateTime d) =>
    '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

/// Menentukan status kalender untuk satu [tanggal].
StatusKalender _statusTanggal({
  required DateTime tanggal,
  required DateTime tanggalBerhenti,
  required DateTime hariIni,
  required Map<String, int> ringkasan,
  required Map<String, int> slipPerTanggal,
}) {
  if (tanggal.isBefore(tanggalBerhenti)) return StatusKalender.belumMulai;
  if (tanggal.isAfter(hariIni)) return StatusKalender.mendatang;
  final key = _keyTanggal(tanggal);
  if (slipPerTanggal.containsKey(key)) return StatusKalender.slip;
  if ((ringkasan[key] ?? 0) > 0) return StatusKalender.adaKonsumsi;
  return StatusKalender.tanpaCatatan;
}

/// Streak saat ini: hari kalender berturut-turut tanpa catatan
/// konsumsi/slip sampai hari ini.
///
/// TODO(B.1): delegasikan ke `MetrikBerhentiHelper.hitungStreak`
/// (`lib/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart`) setelah
/// `prd/satukan_perhitungan_baseline_aktual.md` diimplementasikan.
int _streakSaatIni(List<KonsumsiRokokModel> list) {
  DateTime? terakhir;
  for (final m in list) {
    final lokal = m.tanggal.toLocal();
    final d = DateTime(lokal.year, lokal.month, lokal.day);
    if (terakhir == null || d.isAfter(terakhir)) {
      terakhir = d;
    }
  }
  if (terakhir == null) {
    return 0; // belum ada catatan: bukan bukti bebas rokok
  }
  final sekarang = DateTime.now();
  final hariIni = DateTime(sekarang.year, sekarang.month, sekarang.day);
  final selisih = hariIni.difference(terakhir).inDays;
  return selisih < 0 ? 0 : selisih;
}

/// Halaman kalender smoke-free.
///
/// Menampilkan kalender bulanan yang jujur terhadap log konsumsi: hari
/// tanpa catatan tampil netral (bukan bebas rokok), hari dengan catatan
/// konsumsi/slip diberi warna sesuai status, dan progres kumulatif
/// dipisahkan dari streak saat ini.
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
    final konsumsiAsync = ref.watch(konsumsiRokokProvider);

    if (biodataAsync.isLoading || konsumsiAsync.isLoading) {
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
    if (konsumsiAsync.hasError) {
      L.e(
        'konsumsiAsync error: ${konsumsiAsync.error} ${konsumsiAsync.stackTrace}',
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

    final biodata = biodataAsync.requireValue;
    final konsumsiState = konsumsiAsync.requireValue;
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

    // Kelompokkan catatan konsumsi per tanggal lokal, sekali untuk seluruh grid.
    final ringkasan = konsumsiState.ringkasanHarian;
    final catatanPerTanggal = <String, List<KonsumsiRokokModel>>{};
    final slipPerTanggal = <String, int>{};
    for (final m in konsumsiState.listKonsumsi) {
      final lokal = m.tanggal.toLocal();
      final key = _keyTanggal(lokal);
      catatanPerTanggal.putIfAbsent(key, () => []).add(m);
      if (m.isSlip) {
        slipPerTanggal[key] = (slipPerTanggal[key] ?? 0) + m.jumlah;
      }
    }

    final totalSmokeFree =
        hariIniDate.difference(tanggalBerhentiDate).inDays + 1;
    final totalSmokeFreeAman = totalSmokeFree < 0 ? 0 : totalSmokeFree;
    final streak = _streakSaatIni(konsumsiState.listKonsumsi);
    L.i(
      'streak=$streak, totalSmokeFree=$totalSmokeFreeAman, '
      'ringkasan.length=${ringkasan.length}',
    );

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
                streak: streak,
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
                  biodata: biodata,
                  ringkasan: ringkasan,
                  slipPerTanggal: slipPerTanggal,
                  catatanPerTanggal: catatanPerTanggal,
                ),
              ),
              const _Legenda(),
              Text(
                'Hari tanpa catatan tidak dihitung sebagai bebas rokok. '
                'Catat konsumsi agar kalender akurat.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
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
    required this.streak,
  });

  final DateTime tanggalBerhenti;
  final int totalSmokeFree;
  final int streak;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(
              'Streak saat ini',
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              '$streak hari',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            Text(
              'Hari berturut-turut tanpa catatan konsumsi/slip sampai hari ini',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const Divider(),
            Text(
              'Total hari sejak berhenti',
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              '$totalSmokeFree hari',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Sejak ${FormatTanggal.formatDasar(tanggalBerhenti)}',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
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
    required this.biodata,
    required this.ringkasan,
    required this.slipPerTanggal,
    required this.catatanPerTanggal,
  });

  final DateTime bulan;
  final DateTime tanggalBerhenti;
  final DateTime hariIni;
  final BiodataModel biodata;
  final Map<String, int> ringkasan;
  final Map<String, int> slipPerTanggal;
  final Map<String, List<KonsumsiRokokModel>> catatanPerTanggal;

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
          biodata: biodata,
          ringkasan: ringkasan,
          slipPerTanggal: slipPerTanggal,
          catatanPerTanggal: catatanPerTanggal,
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
    required this.biodata,
    required this.ringkasan,
    required this.slipPerTanggal,
    required this.catatanPerTanggal,
  });

  final DateTime tanggal;
  final DateTime tanggalBerhenti;
  final DateTime hariIni;
  final BiodataModel biodata;
  final Map<String, int> ringkasan;
  final Map<String, int> slipPerTanggal;
  final Map<String, List<KonsumsiRokokModel>> catatanPerTanggal;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final hariIniFlag = tanggal == hariIni;
    final key = _keyTanggal(tanggal);
    final status = _statusTanggal(
      tanggal: tanggal,
      tanggalBerhenti: tanggalBerhenti,
      hariIni: hariIni,
      ringkasan: ringkasan,
      slipPerTanggal: slipPerTanggal,
    );
    final slipBatang = slipPerTanggal[key] ?? 0;
    final catatan = catatanPerTanggal[key] ?? const <KonsumsiRokokModel>[];
    final sedangTapering =
        biodata.sedangTapering && biodata.targetRokokHariIni > 0;

    Color? warnaLatar;
    switch (status) {
      case StatusKalender.adaKonsumsi:
        warnaLatar = Colors.orange.withValues(alpha: 0.25);
      case StatusKalender.slip:
        warnaLatar = Colors.red.withValues(alpha: 0.25);
      case StatusKalender.tanpaCatatan:
        warnaLatar = colorScheme.surfaceContainerHighest;
      case StatusKalender.belumMulai:
      case StatusKalender.mendatang:
        warnaLatar = null;
    }

    Border? border;
    if (hariIniFlag) {
      border = Border.all(color: colorScheme.primary, width: 2);
    } else if (sedangTapering &&
        status != StatusKalender.belumMulai &&
        status != StatusKalender.mendatang) {
      border = Border.all(color: colorScheme.tertiary, width: 1.5);
    }

    final Color warnaTeks;
    switch (status) {
      case StatusKalender.adaKonsumsi:
        warnaTeks = Colors.orange.shade900;
      case StatusKalender.slip:
        warnaTeks = Colors.red.shade800;
      case StatusKalender.tanpaCatatan:
        warnaTeks = colorScheme.onSurface;
      case StatusKalender.belumMulai:
      case StatusKalender.mendatang:
        warnaTeks = Theme.of(context).disabledColor;
    }

    final sel = Container(
      decoration: BoxDecoration(
        color: warnaLatar,
        borderRadius: BorderRadius.circular(8),
        border: border,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${tanggal.day}',
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: hariIniFlag ? FontWeight.bold : FontWeight.normal,
              color: warnaTeks,
            ),
          ),
          if (status == StatusKalender.slip)
            Text(
              '$slipBatang btg',
              style: textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
        ],
      ),
    );

    final bisaKetuk = status != StatusKalender.belumMulai &&
        status != StatusKalender.mendatang;
    if (!bisaKetuk) {
      return sel;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () => unawaited(
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (_) => _DetailTanggal(
              tanggal: tanggal,
              status: status,
              catatan: catatan,
              biodata: biodata,
            ),
          ).catchError((Object e, StackTrace s) {
            L.e('Gagal membuka detail tanggal: $e $s');
            return null;
          }),
        ),
        child: sel,
      ),
    );
  }
}

class _DetailTanggal extends StatelessWidget {
  const _DetailTanggal({
    required this.tanggal,
    required this.status,
    required this.catatan,
    required this.biodata,
  });

  final DateTime tanggal;
  final StatusKalender status;
  final List<KonsumsiRokokModel> catatan;
  final BiodataModel biodata;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final (String statusLabel, Color statusWarna) = switch (status) {
      StatusKalender.adaKonsumsi => (
          'Ada konsumsi tercatat',
          Colors.orange.shade900,
        ),
      StatusKalender.slip => (
          'Slip (kekambuhan) tercatat',
          Colors.red.shade800,
        ),
      StatusKalender.tanpaCatatan => (
          'Tanpa catatan',
          colorScheme.onSurfaceVariant,
        ),
      StatusKalender.belumMulai => (
          'Belum mulai',
          colorScheme.onSurfaceVariant,
        ),
      StatusKalender.mendatang => (
          'Mendatang',
          colorScheme.onSurfaceVariant,
        ),
    };

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            Text(
              FormatTanggal.formatSingkat(tanggal),
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              spacing: 8,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: statusWarna,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  statusLabel,
                  style: textTheme.bodyMedium?.copyWith(
                    color: statusWarna,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (catatan.isEmpty)
              Text(
                'Tidak ada catatan konsumsi pada tanggal ini.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            else ...[
              Text(
                'Catatan (${catatan.length})',
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              for (final m in catatan) _BarisCatatan(konsumsi: m),
            ],
            if (biodata.sedangTapering)
              Text(
                'Target tapering saat ini: ${biodata.targetRokokHariIni} batang',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BarisCatatan extends StatelessWidget {
  const _BarisCatatan({required this.konsumsi});

  final KonsumsiRokokModel konsumsi;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isSlip = konsumsi.isSlip;
    final catatanTeks = konsumsi.catatan;

    return Row(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.smoking_rooms,
          size: 20,
          color: isSlip ? Colors.red.shade800 : colorScheme.onSurfaceVariant,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(
                '${konsumsi.jumlah} batang${isSlip ? '  •  SLIP' : ''}',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: isSlip ? FontWeight.bold : FontWeight.normal,
                  color: isSlip ? Colors.red.shade800 : null,
                ),
              ),
              if (catatanTeks != null && catatanTeks.isNotEmpty)
                Text(
                  catatanTeks,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              Text(
                FormatWaktuLengkap.formatSingkat(konsumsi.tanggal.toLocal()),
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Legenda extends StatelessWidget {
  const _Legenda();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        _ItemLegenda(
          warna: Colors.orange.withValues(alpha: 0.25),
          label: 'Ada konsumsi',
          textTheme: textTheme,
        ),
        _ItemLegenda(
          warna: Colors.red.withValues(alpha: 0.25),
          label: 'Slip',
          textTheme: textTheme,
        ),
        _ItemLegenda(
          warna: colorScheme.surfaceContainerHighest,
          label: 'Tanpa catatan',
          textTheme: textTheme,
          border: true,
        ),
        _ItemLegenda(
          warna: null,
          label: 'Tapering',
          textTheme: textTheme,
          borderColor: colorScheme.tertiary,
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
    this.borderColor,
  });

  final Color? warna;
  final String label;
  final TextTheme textTheme;
  final bool border;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final warnaBorder = borderColor ??
        (border ? Theme.of(context).disabledColor : null);
    return Row(
      spacing: 6,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: warna,
            borderRadius: BorderRadius.circular(4),
            border: warnaBorder != null
                ? Border.all(color: warnaBorder)
                : null,
          ),
        ),
        Text(label, style: textTheme.bodySmall),
      ],
    );
  }
}
