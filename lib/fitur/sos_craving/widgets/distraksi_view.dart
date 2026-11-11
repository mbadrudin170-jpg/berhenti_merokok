import 'dart:async';

import 'package:berhenti_merokok/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Daftar distraksi sederhana.
class DistraksiView extends ConsumerStatefulWidget {
  const DistraksiView({super.key});

  @override
  ConsumerState<DistraksiView> createState() => _DistraksiViewState();
}

class _DistraksiViewState extends ConsumerState<DistraksiView> {
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
        ref: ref,
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
