import 'dart:async';

import 'package:berhenti_merokok/fitur/alasan_berhenti/notifier/alasan_berhenti_notifier.dart';
import 'package:berhenti_merokok/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman bantuan cepat saat craving (SOS Craving).
///
/// Menyediakan latihan napas 4-7-8, timer craving 3 menit, dan daftar
/// distraksi untuk membantu pengguna melewati dorongan merokok.
class SosCravingScreen extends ConsumerStatefulWidget {
  const SosCravingScreen({super.key});

  @override
  ConsumerState<SosCravingScreen> createState() => _SosCravingScreenState();
}

class _SosCravingScreenState extends ConsumerState<SosCravingScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    L.i('SosCravingScreen initState');
  }

  @override
  void dispose() {
    L.i('SosCravingScreen dispose');
    super.dispose();
  }

  /// Membangun kartu pengingat alasan berhenti terbaru (penguat motivasi).
  Widget _buildKartuAlasanBerhenti() {
    final alasanAsync = ref.watch(alasanBerhentiProvider);
    final listAlasan = alasanAsync.asData?.value.listAlasan;
    L.i('listAlasan.length=${listAlasan?.length}');
    if (listAlasan == null || listAlasan.isEmpty) {
      L.w('alasan kosong, kartu motivasi tidak ditampilkan');
      return const SizedBox.shrink();
    }
    final terbaru = listAlasan.first;
    L.i('terbaru=$terbaru');
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.primary,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      'Ingat alasanmu',
                      style: Theme.of(context).textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      terbaru.teks,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SOS Craving'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Napas 4-7-8'),
              Tab(text: 'Timer 3 Menit'),
              Tab(text: 'Distraksi'),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildKartuAlasanBerhenti(),
              Expanded(
                child: TabBarView(
                  children: [
                    _Napas478View(textTheme: textTheme, ref: ref),
                    _TimerCravingView(ref: ref),
                    _DistraksiView(ref: ref),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Latihan napas 4-7-8: tarik 4 detik, tahan 7 detik, hembuskan 8 detik.
class _Napas478View extends StatefulWidget {
  const _Napas478View({required this.textTheme, required this.ref});

  final TextTheme textTheme;
  final WidgetRef ref;

  @override
  State<_Napas478View> createState() => _Napas478ViewState();
}

class _Napas478ViewState extends State<_Napas478View> {
  Timer? _timer;
  bool _berjalan = false;
  int _faseIndex = 0; // 0 tarik, 1 tahan, 2 hembus
  int _sisaFase = 4;
  int _siklus = 0;

  static const List<({String label, int durasi})> _fase = [
    (label: 'Tarik napas', durasi: 4),
    (label: 'Tahan', durasi: 7),
    (label: 'Hembuskan', durasi: 8),
  ];

  static const int _targetSiklus = 4;

  @override
  void initState() {
    super.initState();
    L.i('Napas478View initState');
  }

  @override
  void dispose() {
    L.i('Napas478View dispose');
    _timer?.cancel();
    super.dispose();
  }

  void _mulai() {
    if (_berjalan) return;
    L.i('mulai napas 4-7-8');
    setState(() {
      _berjalan = true;
      _faseIndex = 0;
      _sisaFase = _fase[0].durasi;
      _siklus = 0;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void _tick(Timer _) {
    if (!mounted) return;
    setState(() {
      _sisaFase--;
      if (_sisaFase <= 0) {
        _faseIndex++;
        if (_faseIndex >= _fase.length) {
          _faseIndex = 0;
          _siklus++;
          if (_siklus >= _targetSiklus) {
            _selesai();
            return;
          }
        }
        _sisaFase = _fase[_faseIndex].durasi;
      }
    });
  }

  void _selesai() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
    });
    L.i('napas 4-7-8 selesai, siklus=$_siklus');
    AppToast.sukses(context, 'Latihan napas selesai. Anda hebat!');
    unawaited(
      tampilkanDanSimpanHasilIntervensi(
        context: context,
        ref: widget.ref,
        jenisIntervensi: JenisIntervensiSos.napas_478,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan bottom sheet hasil intervensi napas: $e $s');
        return null;
      }),
    );
  }

  void _henti() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
    });
    L.i('napas 4-7-8 dihentikan');
  }

  void _reset() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
      _faseIndex = 0;
      _sisaFase = _fase[0].durasi;
      _siklus = 0;
    });
    L.i('napas 4-7-8 reset');
  }

  double get _skalaLingkaran {
    if (!_berjalan) return 0.6;
    switch (_faseIndex) {
      case 0: // tarik: membesar
        final durasi = _fase[0].durasi;
        final progres = 1 - (_sisaFase / durasi);
        return 0.6 + (0.4 * progres);
      case 1: // tahan
        return 1.0;
      case 2: // hembus: mengecil
        final durasi = _fase[2].durasi;
        final progres = 1 - (_sisaFase / durasi);
        return 1.0 - (0.4 * progres);
      default:
        return 0.6;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fase = _fase[_faseIndex];
    final warna = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Latihan Napas 4-7-8',
            style: widget.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Tarik napas 4 detik, tahan 7 detik, hembuskan 8 detik. '
            'Ulangi $_targetSiklus kali.',
            textAlign: TextAlign.center,
            style: widget.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            width: 200 * _skalaLingkaran,
            height: 200 * _skalaLingkaran,
            decoration: BoxDecoration(
              color: warna.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: warna, width: 3),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _berjalan ? fase.label : 'Siap',
                  style: widget.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _berjalan ? '$_sisaFase' : '$_targetSiklus siklus',
                  style: widget.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (_berjalan)
            Text(
              'Siklus ${_siklus + 1} dari $_targetSiklus',
              style: widget.textTheme.bodyMedium,
            ),
          const SizedBox(height: 8),
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_berjalan)
                FilledButton.icon(
                  onPressed: _mulai,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Mulai'),
                )
              else
                FilledButton.icon(
                  onPressed: _henti,
                  icon: const Icon(Icons.pause),
                  label: const Text('Jeda'),
                ),
              OutlinedButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Timer craving 3 menit.
class _TimerCravingView extends StatefulWidget {
  const _TimerCravingView({required this.ref});

  final WidgetRef ref;

  @override
  State<_TimerCravingView> createState() => _TimerCravingViewState();
}

class _TimerCravingViewState extends State<_TimerCravingView> {
  static const int _durasiAwal = 3 * 60;
  Timer? _timer;
  bool _berjalan = false;
  int _sisa = _durasiAwal;

  @override
  void initState() {
    super.initState();
    L.i('TimerCravingView initState');
  }

  @override
  void dispose() {
    L.i('TimerCravingView dispose');
    _timer?.cancel();
    super.dispose();
  }

  void _mulai() {
    if (_berjalan) return;
    if (_sisa <= 0) {
      _sisa = _durasiAwal;
    }
    L.i('timer craving mulai, sisa=$_sisa');
    setState(() {
      _berjalan = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void _tick(Timer _) {
    if (!mounted) return;
    setState(() {
      _sisa--;
      if (_sisa <= 0) {
        _selesai();
      }
    });
  }

  void _selesai() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
      _sisa = 0;
    });
    L.i('timer craving selesai');
    AppToast.sukses(
      context,
      '3 menit berlalu. Craving biasanya singkat. Anda berhasil!',
    );
    unawaited(
      tampilkanDanSimpanHasilIntervensi(
        context: context,
        ref: widget.ref,
        jenisIntervensi: JenisIntervensiSos.timer_3_menit,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan bottom sheet hasil intervensi timer: $e $s');
        return null;
      }),
    );
  }

  void _jeda() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
    });
    L.i('timer craving dijeda');
  }

  void _reset() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
      _sisa = _durasiAwal;
    });
    L.i('timer craving reset');
  }

  String get _teksWaktu {
    final menit = (_sisa ~/ 60).toString().padLeft(2, '0');
    final detik = (_sisa % 60).toString().padLeft(2, '0');
    return '$menit:$detik';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final progres = 1 - (_sisa / _durasiAwal);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Timer Craving',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Craving biasanya berlangsung sekitar 3 menit. '
            'Tahan dorongan hingga waktu habis.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progres.clamp(0.0, 1.0),
                  strokeWidth: 12,
                ),
                Center(
                  child: Text(
                    _teksWaktu,
                    style: textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_berjalan)
                FilledButton.icon(
                  onPressed: _mulai,
                  icon: const Icon(Icons.play_arrow),
                  label: Text(_sisa == 0 ? 'Ulangi' : 'Mulai'),
                )
              else
                FilledButton.icon(
                  onPressed: _jeda,
                  icon: const Icon(Icons.pause),
                  label: const Text('Jeda'),
                ),
              OutlinedButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Daftar distraksi sederhana.
class _DistraksiView extends StatefulWidget {
  const _DistraksiView({required this.ref});

  final WidgetRef ref;

  @override
  State<_DistraksiView> createState() => _DistraksiViewState();
}

class _DistraksiViewState extends State<_DistraksiView> {
  int _berhasil = 0;
  String? _aktivitasTerpilih;

  static const List<String> _aktivitas = [
    'Minum segelas air putih',
    'Jalan kaki 5 menit',
    'Makan permen atau buah',
    'Cuci muka dengan air dingin',
    'Telepon teman atau keluarga',
    'Dengarkan musik favorit',
    'Lakukan 10 kali push-up ringan',
    'Baca 1 halaman buku',
  ];

  @override
  void initState() {
    super.initState();
    L.i('DistraksiView initState');
  }

  @override
  void dispose() {
    L.i('DistraksiView dispose, berhasil=$_berhasil');
    super.dispose();
  }

  void _tandaiBerhasil() {
    setState(() {
      _berhasil++;
    });
    L.i('distraksi berhasil, total=$_berhasil');
    AppToast.sukses(context, 'Craving berhasil dilewati!');
    unawaited(
      tampilkanDanSimpanHasilIntervensi(
        context: context,
        ref: widget.ref,
        jenisIntervensi: JenisIntervensiSos.distraksi,
        detail: _aktivitasTerpilih,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan bottom sheet hasil intervensi distraksi: $e $s');
        return null;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Distraksi',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Pilih aktivitas untuk mengalihkan perhatian dari craving.',
            style: textTheme.bodyMedium,
          ),
          if (_berhasil > 0)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Craving dilewati: $_berhasil kali',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Expanded(
            child: ListView.separated(
              itemCount: _aktivitas.length,
              itemBuilder: (context, index) {
                final aktivitas = _aktivitas[index];
                return ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(aktivitas),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    L.i('distraksi dipilih: $aktivitas');
                    setState(() {
                      _aktivitasTerpilih = aktivitas;
                    });
                    AppToast.info(context, aktivitas);
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 4),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _tandaiBerhasil,
              icon: const Icon(Icons.verified),
              label: const Text('Saya berhasil melewati craving'),
            ),
          ),
        ],
      ),
    );
  }
}
