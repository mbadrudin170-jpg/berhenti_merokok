import 'dart:async';

import 'package:berhenti_merokok/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Urge surfing: "menunggangi" gelombang craving hingga mereda.
/// Timer 10 / 15 / 20 menit dengan fase gelombang naik → puncak → reda.
class UrgeSurfingView extends ConsumerStatefulWidget {
  const UrgeSurfingView({super.key});

  @override
  ConsumerState<UrgeSurfingView> createState() => _UrgeSurfingViewState();
}

class _UrgeSurfingViewState extends ConsumerState<UrgeSurfingView> {
  static const List<int> _pilihanDurasi = [10, 15, 20];

  int _menitTerpilih = 10;
  int get _durasiAwal => _menitTerpilih * 60;

  Timer? _timer;
  bool _berjalan = false;
  int _sisa = 10 * 60;

  @override
  void initState() {
    super.initState();
    L.i('UrgeSurfingView initState');
  }

  @override
  void dispose() {
    L.i('UrgeSurfingView dispose');
    _timer?.cancel();
    super.dispose();
  }

  void _pilihDurasi(int menit) {
    if (_berjalan) return;
    L.i('durasi urge surfing dipilih: $menit menit');
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
    L.i('urge surfing mulai, sisa=$_sisa');
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
    });
    L.i('urge surfing selesai, durasi=$_menitTerpilih menit');
    AppToast.sukses(context, 'Gelombang craving berhasil dilewati!');
    unawaited(
      tampilkanDanSimpanHasilIntervensi(
        context: context,
        ref: ref,
        jenisIntervensi: JenisIntervensiSos.urge_surfing,
        detail: '$_menitTerpilih menit',
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan bottom sheet hasil intervensi urge surfing: $e $s');
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
    L.i('urge surfing dijeda');
  }

  void _reset() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
      _sisa = _durasiAwal;
    });
    L.i('urge surfing reset');
  }

  /// Tiga fase gelombang craving: naik → puncak → reda.
  ({String fase, String afirmasi}) get _faseGelombang {
    final berlalu = _durasiAwal - _sisa;
    final pertiga = _durasiAwal / 3;
    if (berlalu < pertiga) {
      return (
        fase: 'Naik',
        afirmasi: 'Craving sedang naik. Rasakan tanpa dilawan — '
            'ini hanya gelombang, pasti berlalu.',
      );
    }
    if (berlalu < 2 * pertiga) {
      return (
        fase: 'Puncak',
        afirmasi: 'Kamu di puncak gelombang. Tetap di sini, perhatikan '
            'sensasinya tanpa bereaksi.',
      );
    }
    return (
      fase: 'Reda',
      afirmasi: 'Gelombang mulai reda. Kamu lebih kuat dari craving ini.',
    );
  }

  String get _teksWaktu {
    final menit = (_sisa ~/ 60).toString().padLeft(2, '0');
    final detik = (_sisa % 60).toString().padLeft(2, '0');
    return '$menit:$detik';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final progres = 1 - (_sisa / _durasiAwal);
    final fase = _faseGelombang;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Urge Surfing',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Tunggangi gelombang craving hingga reda, '
            'tanpa melawannya.',
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _berjalan ? 'Fase ${fase.fase}' : 'Siap',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _teksWaktu,
                        style: textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFeatures: const [
                            FontFeature.tabularFigures(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_berjalan)
            Text(
              fase.afirmasi,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall,
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
                onPressed: _selesai,
                icon: const Icon(Icons.done),
                label: const Text('Selesai'),
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
