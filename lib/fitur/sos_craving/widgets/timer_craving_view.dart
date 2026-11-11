import 'dart:async';

import 'package:berhenti_merokok/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Timer craving dengan pilihan durasi 3 / 5 / 10 menit.
class TimerCravingView extends ConsumerStatefulWidget {
  const TimerCravingView({super.key});

  @override
  ConsumerState<TimerCravingView> createState() => _TimerCravingViewState();
}

class _TimerCravingViewState extends ConsumerState<TimerCravingView> {
  static const List<int> _pilihanDurasi = [3, 5, 10];

  int _menitTerpilih = 3;
  int get _durasiAwal => _menitTerpilih * 60;

  Timer? _timer;
  bool _berjalan = false;
  int _sisa = 3 * 60;

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

  void _pilihDurasi(int menit) {
    if (_berjalan) return;
    L.i('durasi timer dipilih: $menit menit');
    setState(() {
      _menitTerpilih = menit;
      _sisa = _durasiAwal;
    });
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
    L.i('timer craving selesai, durasi=$_menitTerpilih menit');
    AppToast.sukses(
      context,
      '$_menitTerpilih menit berlalu. Craving biasanya singkat. '
      'Anda berhasil!',
    );
    unawaited(
      tampilkanDanSimpanHasilIntervensi(
        context: context,
        ref: ref,
        jenisIntervensi: JenisIntervensiSos.timerCraving,
        detail: '$_menitTerpilih menit',
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
            'Craving biasanya berlangsung beberapa menit. '
            'Tahan dorongan hingga waktu habis.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (final menit in _pilihanDurasi)
                ChoiceChip(
                  label: Text('$menit menit'),
                  selected: _menitTerpilih == menit,
                  onSelected: _berjalan ? null : (_) => _pilihDurasi(menit),
                ),
            ],
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
                      fontFeatures: const [FontFeature.tabularFigures()],
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
