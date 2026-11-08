import 'dart:async';

import 'package:berhenti_merokok/fitur/alasan_berhenti/notifier/alasan_berhenti_notifier.dart';
import 'package:berhenti_merokok/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart';
import 'package:berhenti_merokok/fitur/badge/screens/badge_screen.dart';
import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/fitur/impian/helper/impian_progres_helper.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/screens/impian_screen.dart';
import 'package:berhenti_merokok/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart';
import 'package:berhenti_merokok/fitur/sos_craving/screens/sos_craving_screen.dart';
import 'package:berhenti_merokok/shared/konstanta/milestone_kesehatan.dart';
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
    L.i('DashboardScreen initState');
  }

  @override
  void dispose() {
    L.i('DashboardScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    L.i('biodataAsync=$biodataAsync');

    if (biodataAsync.isLoading) {
      L.w('biodataAsync loading');
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      L.e(
        'biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}',
      );
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
    L.i('biodata=$biodata');
    if (biodata == null) {
      return _buildBiodataNull();
    }
    final impianAsync = ref.watch(impianProvider);
    L.i(
      'impianAsync.isLoading=${impianAsync.isLoading}, hasError=${impianAsync.hasError}',
    );
    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    final nama = biodata.nama;
    L.i('tanggalBerhenti=$tanggalBerhenti, nama=$nama');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        scrolledUnderElevation: 2,
        actions: [
          IconButton(
            tooltip: 'SOS Craving',
            icon: const Icon(Icons.sos),
            onPressed: () => unawaited(
              Nav.to(context, const SosCravingScreen()).catchError((
                Object e,
                StackTrace s,
              ) {
                L.e('Gagal navigasi ke SOS Craving: $e $s');
                return null;
              }),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              _CounterSmokeFreeBesar(biodata: biodata),
              const SizedBox(height: 16),
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
              _buildCardSosCraving(),
              _buildCardProgres(biodata),
              _buildCardTargetSmokeFree(biodata),
              _buildCardRingkasanImpian(biodata, impianAsync),
              _buildCardAlasanBerhenti(),
              _buildCardMilestone(biodata),
              _buildCardBadge(),
              _buildInfoKerugian(biodata),
            ],
          ),
        ),
      ),
    );
  }

  /// Kartu motivasi progres target smoke-free "X dari N hari".
  Widget _buildCardTargetSmokeFree(BiodataModel biodata) {
    final target = biodata.targetSmokeFreeHari;
    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    final hariBerhenti = biodata.hariBerhenti;

    if (target == null) return const SizedBox.shrink();

    String teksProgres;
    if (tanggalBerhenti == null) {
      teksProgres = 'Target: $target hari';
    } else if (hariBerhenti >= target) {
      teksProgres = '$target dari $target hari — Target tercapai';
    } else {
      teksProgres = '$hariBerhenti dari $target hari';
    }

    L.i(
      'targetSmokeFreeHari=$target, tanggalBerhenti=$tanggalBerhenti, hariBerhenti=$hariBerhenti, teksProgres=$teksProgres',
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Target Smoke-Free',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              teksProgres,
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  /// Membangun kartu ringkasan impian (jumlah total dan tercapai) untuk dashboard.
  Widget _buildCardRingkasanImpian(
    BiodataModel biodata,
    AsyncValue<dynamic> impianAsync,
  ) {
    final uangDihemat = biodata.uangDihemat;
    String subtitle;
    if (impianAsync.isLoading) {
      subtitle = 'Memuat data impian...';
      L.i('ringkasan impian: loading, uangDihemat=$uangDihemat');
    } else if (impianAsync.hasError) {
      subtitle = 'Gagal memuat data impian';
      L.w(
        'ringkasan impian error=${impianAsync.error}, uangDihemat=$uangDihemat',
      );
    } else {
      final impianState = impianAsync.requireValue;
      final listImpian = impianState.listImpian;
      final total = impianState.jumlahImpian;
      final tercapai = listImpian
          .where(
            (item) => ImpianProgresHelper.tercapai(uangDihemat, item.jumlah),
          )
          .length;
      L.i(
        'ringkasan impian: total=$total, tercapai=$tercapai, uangDihemat=$uangDihemat',
      );
      if (total == 0) {
        subtitle = 'Belum ada impian';
      } else {
        subtitle = '$tercapai dari $total impian tercapai';
      }
    }

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => unawaited(
          Nav.to(context, const ImpianScreen()).catchError((
            Object e,
            StackTrace s,
          ) {
            L.e('Gagal navigasi ke Impian: $e $s');
            return null;
          }),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              Icon(
                CupertinoIcons.star_fill,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      'Impian',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(CupertinoIcons.chevron_right),
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

    final hariBerhenti = biodata.hariBerhenti;
    final rokokTidakDiHisap = biodata.rokokTidakDiHisap;
    final uangDihemat = biodata.uangDihemat;
    L.i(
      'tanggalBerhenti=$tanggalBerhenti, jumlahRokokPerHari=$jumlahRokokPerHari, hargaPerBungkus=$hargaPerBungkus, hariBerhenti=$hariBerhenti, rokokTidakDiHisap=$rokokTidakDiHisap, uangDihemat=$uangDihemat',
    );

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

  Widget _buildCardSosCraving() {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => unawaited(
          Nav.to(context, const SosCravingScreen()).catchError((
            Object e,
            StackTrace s,
          ) {
            L.e('Gagal navigasi ke SOS Craving: $e $s');
            return null;
          }),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              Icon(
                Icons.sos,
                size: 32,
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      'SOS Craving',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                    Text(
                      'Butuh bantuan saat craving? Tekan untuk bantuan cepat.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardMilestone(BiodataModel biodata) {
    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    if (tanggalBerhenti == null) return const SizedBox.shrink();

    final durasi = DateTime.now().difference(tanggalBerhenti);
    final aman = durasi.isNegative ? Duration.zero : durasi;
    final berikutnya = milestoneBerikutnya(aman);
    L.i('milestoneBerikutnya=${berikutnya?.judul}');

    return Card(
      child: InkWell(
        onTap: () => unawaited(
          Nav.to(context, const PemulihanKesehatanScreen()).catchError((
            Object e,
            StackTrace s,
          ) {
            L.e('Gagal navigasi ke Pemulihan Kesehatan: $e $s');
            return null;
          }),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              const Icon(CupertinoIcons.heart, size: 32, color: Colors.green),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      'Pemulihan Kesehatan',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      berikutnya == null
                          ? 'Semua milestone tercapai'
                          : 'Berikutnya: ${berikutnya.judul}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (berikutnya != null)
                      Text(
                        'Tersisa ${_formatDurasiSingkat(berikutnya.target - aman)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
              const Icon(CupertinoIcons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  /// Membangun kartu pintasan alasan berhenti dengan jumlah alasan tersimpan.
  Widget _buildCardAlasanBerhenti() {
    return Consumer(
      builder: (context, ref, _) {
        final alasanAsync = ref.watch(alasanBerhentiProvider);
        final jumlah = alasanAsync.asData?.value.jumlahAlasan ?? 0;
        L.i('jumlahAlasan=$jumlah');
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => unawaited(
              Nav.to(context, const AlasanBerhentiScreen()).catchError((
                Object e,
                StackTrace s,
              ) {
                L.e('Gagal navigasi ke Alasan Berhenti: $e $s');
                return null;
              }),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                spacing: 12,
                children: [
                  const Icon(CupertinoIcons.heart_fill, size: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(
                          'Alasan Berhenti',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$jumlah alasan tersimpan',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const Icon(CupertinoIcons.chevron_right),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatHariHilang(double hariHilang) {
    if (hariHilang <= 365) {
      return '${hariHilang.toStringAsFixed(1)} hari';
    }
    final totalHari = hariHilang.round();
    final tahun = totalHari ~/ 365;
    final sisaTahun = totalHari % 365;
    final bulan = sisaTahun ~/ 30;
    final hari = sisaTahun % 30;
    return '$tahun'
        'T $bulan'
        'B $hari'
        'H';
  }

  String _formatDurasiSingkat(Duration d) {
    if (d.inDays > 0) {
      final hari = d.inDays;
      final jam = d.inHours % 24;
      if (jam > 0) return '$hari hari $jam jam';
      return '$hari hari';
    }
    if (d.inHours > 0) {
      final jam = d.inHours;
      final menit = d.inMinutes % 60;
      if (menit > 0) return '$jam jam $menit menit';
      return '$jam jam';
    }
    final menit = d.inMinutes;
    final detik = d.inSeconds % 60;
    if (menit > 0) return '$menit menit $detik detik';
    return '$detik detik';
  }

  Widget _buildCardBadge() {
    return Card(
      child: InkWell(
        onTap: () => unawaited(
          Nav.to(context, const BadgeScreen()).catchError((
            Object e,
            StackTrace s,
          ) {
            L.e('Gagal navigasi ke Badge: $e $s');
            return null;
          }),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              const Icon(CupertinoIcons.rosette, size: 32, color: Colors.amber),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      'Pencapaian',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lihat badge yang telah tercapai',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(CupertinoIcons.chevron_right),
            ],
          ),
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
      final mulaiDate = DateTime(
        tanggalMulaiMerokok.year,
        tanggalMulaiMerokok.month,
        tanggalMulaiMerokok.day,
      );
      final berhentiDate = DateTime(
        tanggalBerhenti.year,
        tanggalBerhenti.month,
        tanggalBerhenti.day,
      );
      totalHariMerokok = berhentiDate.difference(mulaiDate).inDays;
      if (totalHariMerokok < 0) {
        totalHariMerokok = 0;
      }
    }

    final rokokDihisap = jumlahRokokPerHari * totalHariMerokok;
    final uangTerbuang = biodata.batangPerBungkus == 0
        ? 0.0
        : (rokokDihisap / biodata.batangPerBungkus) * hargaPerBungkus;
    final menitHilang = (rokokDihisap * 11).round();
    final hariHilang = menitHilang / (24 * 60);
    L.i(
      'totalHariMerokok=$totalHariMerokok, rokokDihisap=$rokokDihisap, uangTerbuang=$uangTerbuang, menitHilang=$menitHilang, hariHilang=$hariHilang',
    );

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
              'Total rokok yang dihisap',
            ),
            _buildInfoKerugianKustom(
              CupertinoIcons.money_dollar,
              FormatUang.formatRupiah(uangTerbuang),
              'uang yang terbuang',
            ),
            _buildInfoKerugianKustom(
              CupertinoIcons.heart,
              _formatHariHilang(hariHilang),
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
    L.i('icon=$icon, title=$title, subtitle=$subtitle');
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
                    Nav.to(
                      context,
                      const FormBiodata(buatPertama: false),
                    ).catchError((Object e, StackTrace s) {
                      L.e('Gagal navigasi ke Form Biodata: $e $s');
                      return null;
                    }),
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
  L.i('tanggalBerhenti=$tanggalBerhenti, selisih=$selisih');
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

/// Widget terisolasi yang menampilkan counter smoke-free besar (hari + jam)
/// di bagian atas Dashboard. Timer per detik hanya membangun ulang widget
/// ini, bukan seluruh halaman.
class _CounterSmokeFreeBesar extends StatefulWidget {
  const _CounterSmokeFreeBesar({required this.biodata});

  final BiodataModel biodata;

  @override
  State<_CounterSmokeFreeBesar> createState() => _CounterSmokeFreeBesarState();
}

class _CounterSmokeFreeBesarState extends State<_CounterSmokeFreeBesar> {
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
    final teks = _formatCounterSmokeFreeBesar(widget.biodata);
    return Text(
      teks,
      style: Theme.of(context).textTheme.displayMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

/// Menghitung teks counter smoke-free besar "X hari Y jam" dari [biodata].
/// Menggunakan [BiodataModel.hariBerhenti] dari ekstensi perhitungan dan
/// menghitung sisa jam dari selisih waktu dengan normalisasi dan klamping.
String _formatCounterSmokeFreeBesar(BiodataModel biodata) {
  final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
  final hariBerhenti = biodata.hariBerhenti;

  int jamSisa = 0;
  if (tanggalBerhenti != null) {
    final selisih = DateTime.now().difference(tanggalBerhenti);
    final totalJam = selisih.inHours;
    jamSisa = totalJam < 0 ? 0 : totalJam % 24;
  }

  L.i('hariBerhenti=$hariBerhenti, jamSisa=$jamSisa');

  return '$hariBerhenti hari $jamSisa jam';
}
