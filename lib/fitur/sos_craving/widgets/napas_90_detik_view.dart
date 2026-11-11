import 'dart:async';

import 'package:berhenti_merokok/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Napas 90 detik: latihan napas singkat satu tarikan panjang,
/// diulang selama ±90 detik. Tarik 4 detik, hembuskan 6 detik.
class Napas90DetikView extends ConsumerStatefulWidget {
  const Napas90DetikView({super.key});

  @override
  ConsumerState<Napas90DetikView> createState() => _Napas90DetikViewState();
}

class _Napas90DetikViewState extends ConsumerState<Napas90DetikView> {
  static const int _durasiAwal = 90;

  Timer? _timer;
  bool _berjalan = false;
  int _sisa = _durasiAwal;
  int _faseNapas = 0; // 0 tarik (4 detik), 1 hembus (6 detik)
  int _sisaFase = 4;

  static const List<({String label, int durasi})> _fase = [
    (label: 'Tarik napas', durasi: 4),
    (label: 'Hembuskan', durasi: 6),
  ];

  @override
  void initState() {
    super.initState();
    L.i('Napas90DetikView initState');
  }

  @override
  void dispose() {
    L.i('Napas90DetikView dispose');
    _timer?.cancel();
    super.dispose();
  }

  void _mulai() {
    if (_berjalan) return;
    if (_sisa <= 0) {
      _sisa = _durasiAwal;
      _faseNapas = 0;
      _sisaFase = _fase[0].durasi;
    }
    L.i('napas 90 detik mulai, sisa=$_sisa');
    setState(() {
      _berjalan = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void _tick(Timer _) {
    if (!mounted) return;
    setState(() {
      _sisa--;
      _sisaFase--;
      if (_sisaFase <= 0) {
        _faseNapas = (_faseNapas + 1) % _fase.length;
        _sisaFase = _fase[_faseNapas].durasi;
      }
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
    L.i('napas 90 detik selesai');
    AppToast.sukses(context, '90 detik berlalu. Craving Anda melemah!');
    unawaited(
      tampilkanDanSimpanHasilIntervensi(
        context: context,
        ref: ref,
        jenisIntervensi: JenisIntervensiSos.napas90Detik,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan bottom sheet hasil intervensi napas 90 detik: $e $s');
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
    L.i('napas 90 detik dihentikan');
  }

  void _reset() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
      _sisa = _durasiAwal;
      _faseNapas = 0;
      _sisaFase = _fase[0].durasi;
    });
    L.i('napas 90 detik reset');
  }

  String get _teksSisa {
    final menit = (_sisa ~/ 60).toString().padLeft(2, '0');
    final detik = (_sisa % 60).toString().padLeft(2, '0');
    return '$menit:$detik';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final fase = _fase[_faseNapas];
    final progres = 1 - (_sisa / _durasiAwal);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Napas 90 Detik',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Tarik napas dalam 4 detik, hembuskan perlahan 6 detik. '
            'Ulangi hingga 90 detik berlalu.',
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
                        _teksSisa,
                        style: textTheme.headlineMedium?.copyWith(
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
