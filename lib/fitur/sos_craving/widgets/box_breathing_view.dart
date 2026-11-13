import 'dart:async';

import 'package:berhenti_merokok/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Box breathing 4-4-4-4: tarik 4 detik, tahan 4 detik,
/// hembuskan 4 detik, tahan 4 detik. Default 4 siklus.
class BoxBreathingView extends ConsumerStatefulWidget {
  const BoxBreathingView({super.key});

  @override
  ConsumerState<BoxBreathingView> createState() => _BoxBreathingViewState();
}

class _BoxBreathingViewState extends ConsumerState<BoxBreathingView> {
  Timer? _timer;
  bool _berjalan = false;
  int _faseIndex = 0; // 0 tarik, 1 tahan, 2 hembus, 3 tahan
  int _sisaFase = 4;
  int _siklus = 0;

  static const List<({String label, int durasi})> _fase = [
    (label: 'Tarik napas', durasi: 4),
    (label: 'Tahan', durasi: 4),
    (label: 'Hembuskan', durasi: 4),
    (label: 'Tahan', durasi: 4),
  ];

  static const int _targetSiklus = 4;

  @override
  void initState() {
    super.initState();
    L.i('BoxBreathingView initState');
  }

  @override
  void dispose() {
    L.i('BoxBreathingView dispose');
    _timer?.cancel();
    super.dispose();
  }

  void _mulai() {
    if (_berjalan) return;
    L.i('mulai box breathing');
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
    L.i('box breathing selesai, siklus=$_siklus');
    AppToast.sukses(context, 'Box breathing selesai. Anda hebat!');
    unawaited(
      tampilkanDanSimpanHasilIntervensi(
        context: context,
        ref: ref,
        jenisIntervensi: JenisIntervensiSos.napasBox,
      ).catchError((Object e, StackTrace s) {
        L.e(
          'Gagal menampilkan bottom sheet hasil intervensi box breathing: $e $s',
        );
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
    L.i('box breathing dihentikan');
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
    L.i('box breathing reset');
  }

  double get _skalaLingkaran {
    if (!_berjalan) return 0.6;
    const durasi = 4;
    final progres = 1 - (_sisaFase / durasi);
    switch (_faseIndex) {
      case 0: // tarik: membesar
        return 0.6 + (0.4 * progres);
      case 1: // tahan setelah tarik
        return 1.0;
      case 2: // hembus: mengecil
        return 1.0 - (0.4 * progres);
      case 3: // tahan setelah hembus
        return 0.6;
      default:
        return 0.6;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final fase = _fase[_faseIndex];
    final warna = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Box Breathing',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Tarik 4 detik, tahan 4 detik, hembuskan 4 detik, tahan 4 detik. '
            'Ulangi $_targetSiklus kali.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
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
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _berjalan ? '$_sisaFase' : '$_targetSiklus siklus',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          if (_berjalan)
            Text(
              'Siklus ${_siklus + 1} dari $_targetSiklus',
              style: textTheme.bodyMedium,
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
