import 'dart:async';

import 'package:berhenti_merokok/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Grounding 5-4-3-2-1: mengalihkan perhatian dari craving ke
/// sensasi tubuh/indra saat ini, langkah demi langkah.
class Grounding54321View extends ConsumerStatefulWidget {
  const Grounding54321View({super.key});

  @override
  ConsumerState<Grounding54321View> createState() => _Grounding54321ViewState();
}

class _Grounding54321ViewState extends ConsumerState<Grounding54321View> {
  int _langkah = 0; // 0..4

  static const List<({String indra, String instruksi, IconData ikon})> _langkahList = [
    (
      indra: '5 hal yang kamu LIHAT',
      instruksi: 'Sebutkan dalam hati 5 benda yang terlihat di sekitarmu '
          'saat ini, satu per satu.',
      ikon: Icons.visibility,
    ),
    (
      indra: '4 hal yang kamu SENTUH',
      instruksi: 'Rasakan 4 benda yang bisa kamu sentuh: tekstur meja, '
          'pakaian, atau kursi.',
      ikon: Icons.touch_app,
    ),
    (
      indra: '3 hal yang kamu DENGAR',
      instruksi: 'Dengarkan 3 suara di sekitarmu: kendaraan, kipas angin, '
          'atau suara napasmu sendiri.',
      ikon: Icons.hearing,
    ),
    (
      indra: '2 hal yang kamu CIUM',
      instruksi: 'Cium 2 aroma di sekitarmu: kopi, sabun, atau udara '
          'segar.',
      ikon: Icons.air,
    ),
    (
      indra: '1 hal yang kamu KECAP',
      instruksi: 'Rasakan 1 rasa di mulutmu: sisa makanan, air, atau '
          'permen mint.',
      ikon: Icons.restaurant,
    ),
  ];

  @override
  void initState() {
    super.initState();
    L.i('Grounding54321View initState');
  }

  @override
  void dispose() {
    L.i('Grounding54321View dispose');
    super.dispose();
  }

  void _selanjutnya() {
    L.i('grounding langkah ${_langkah + 1} selesai');
    if (_langkah >= _langkahList.length - 1) {
      _selesai();
      return;
    }
    setState(() {
      _langkah++;
    });
  }

  void _sebelumnya() {
    if (_langkah == 0) return;
    L.i('grounding kembali ke langkah $_langkah');
    setState(() {
      _langkah--;
    });
  }

  void _selesai() {
    L.i('grounding 5-4-3-2-1 selesai');
    AppToast.sukses(context, 'Grounding selesai. Pikiran lebih tenang!');
    unawaited(
      tampilkanDanSimpanHasilIntervensi(
        context: context,
        ref: ref,
        jenisIntervensi: JenisIntervensiSos.grounding54321,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan bottom sheet hasil intervensi grounding: $e $s');
        return null;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final langkah = _langkahList[_langkah];
    final progres = (_langkah + 1) / _langkahList.length;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Grounding 5-4-3-2-1',
            textAlign: TextAlign.center,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Langkah ${_langkah + 1} dari ${_langkahList.length}',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          LinearProgressIndicator(value: progres.clamp(0.0, 1.0)),
          const SizedBox(height: 8),
          Icon(
            langkah.ikon,
            size: 96,
            color: colorScheme.primary,
          ),
          Text(
            langkah.indra,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            langkah.instruksi,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_langkah > 0)
                OutlinedButton.icon(
                  onPressed: _sebelumnya,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Kembali'),
                ),
              FilledButton.icon(
                onPressed: _selanjutnya,
                icon: const Icon(Icons.check),
                label: const Text('Sudah'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
