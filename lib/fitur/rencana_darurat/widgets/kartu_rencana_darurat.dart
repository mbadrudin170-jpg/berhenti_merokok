import 'dart:async';

import 'package:berhenti_merokok/fitur/rencana_darurat/notifier/rencana_darurat_notifier.dart';
import 'package:berhenti_merokok/fitur/rencana_darurat/screens/rencana_darurat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Kartu ringkas "Rencana Darurat Saya" untuk disematkan di SOS Craving.
///
/// Menampilkan daftar if-then plan tersimpan (maks 3 baris) atau empty
/// state bila belum ada. Widget hanya menampilkan teks rencana dan aksi
/// navigasi ke layar kelola; tidak memicu teknik SOS otomatis.
class KartuRencanaDarurat extends ConsumerWidget {
  const KartuRencanaDarurat({super.key});

  void _navigasiKeKelola(BuildContext context) {
    unawaited(
      Nav.to(context, const RencanaDaruratScreen()).catchError((
        Object e,
        StackTrace s,
      ) {
        L.e('Gagal navigasi ke Rencana Darurat: $e $s');
        return null;
      }),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rencanaAsync = ref.watch(rencanaDaruratProvider);
    L.i(
      'rencanaAsync.isLoading=${rencanaAsync.isLoading}, '
      'hasError=${rencanaAsync.hasError}',
    );
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (rencanaAsync.hasError) {
      L.w('rencanaDaruratProvider error=${rencanaAsync.error}');
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  'Gagal memuat rencana darurat',
                  style: textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () {
                    final _ = ref.refresh(rencanaDaruratProvider);
                  },
                  child: const Text('Coba lagi'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final list = rencanaAsync.asData?.value.listRencana;
    if (list == null) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
    L.i('list.length=${list.length}');

    if (list.isEmpty) {
      L.w('rencana darurat kosong, tampilkan empty state');
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Icon(
                      Icons.event_note_outlined,
                      color: colorScheme.primary,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Text(
                            'Belum ada rencana darurat',
                            style: textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Tulis rencana "Jika …, Maka …" di saat tenang '
                            'agar siap saat craving menyerang.',
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () => _navigasiKeKelola(context),
                  child: const Text('Buat rencana'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 12,
                children: [
                  Icon(
                    Icons.event_note,
                    color: colorScheme.primary,
                  ),
                  Expanded(
                    child: Text(
                      'Rencana Darurat Saya',
                      style: textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _navigasiKeKelola(context),
                    child: const Text('Kelola'),
                  ),
                ],
              ),
              for (final item in list)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text('•', style: textTheme.bodyMedium),
                    Expanded(
                      child: Text(
                        'Jika ${item.jika} → Maka ${item.maka}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
