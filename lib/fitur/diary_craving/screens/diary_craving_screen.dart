import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/model/diary_craving_model.dart';
import 'package:berhenti_merokok/fitur/diary_craving/notifier/diary_craving_notifier.dart';
import 'package:berhenti_merokok/fitur/diary_craving/screens/form_diary_craving.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class DiaryCravingScreen extends ConsumerStatefulWidget {
  const DiaryCravingScreen({super.key});

  @override
  ConsumerState<DiaryCravingScreen> createState() => _DiaryCravingScreenState();
}

class _DiaryCravingScreenState extends ConsumerState<DiaryCravingScreen> {
  @override
  void initState() {
    super.initState();
    L.i('DiaryCravingScreen initState');
  }

  @override
  void dispose() {
    L.i('DiaryCravingScreen dispose');
    super.dispose();
  }

  Future<void> _hapus(DiaryCravingModel item) async {
    L.i('item.id=${item.id}');
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Catatan',
      message:
          'Apakah Anda yakin ingin menghapus catatan craving ini '
          '(${item.pemicu.label})?',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!mounted) return;
    try {
      await ref.read(diaryCravingProvider.notifier).hapus(item.id);
      if (mounted) {
        AppToast.sukses(context, 'Catatan craving berhasil dihapus');
      }
    } on Exception catch (e, s) {
      L.e('Gagal menghapus diary craving: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menghapus catatan craving');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cravingAsync = ref.watch(diaryCravingProvider);

    if (cravingAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (cravingAsync.hasError) {
      L.w('diaryCravingProvider error=${cravingAsync.error}');
      return Scaffold(
        appBar: AppBar(title: const Text('Diary Craving')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              const Text('Gagal memuat data diary craving'),
              OutlinedButton(
                onPressed: () {
                  final _ = ref.refresh(diaryCravingProvider);
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final state = cravingAsync.requireValue;
    final list = state.listCraving;

    // Hitung frekuensi pemicu untuk ringkasan analisis pemicu.
    final Map<PemicuEnum, int> freqPemicu = {};
    for (final c in list) {
      freqPemicu[c.pemicu] = (freqPemicu[c.pemicu] ?? 0) + 1;
    }
    final entriPemicu = freqPemicu.entries.toList()
      ..sort((a, b) {
        final cmp = b.value.compareTo(a.value);
        if (cmp != 0) return cmp;
        // Tie-breaker deterministik: urutkan berdasarkan index enum saat jumlah sama,
        // agar topPemicu dan agregat konsisten di seluruh rebuild (List.sort tidak stabil).
        return a.key.index.compareTo(b.key.index);
      });
    final topPemicu = entriPemicu.take(3).toList();
    final jumlahLainnya = entriPemicu.skip(3).fold<int>(
      0,
      (total, e) => total + e.value,
    );

    if (list.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Diary Craving')),
        body: const _EmptyDiaryCraving(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => unawaited(
                    Nav.to(context, const FormDiaryCraving()).catchError((
                      Object e,
                      StackTrace s,
                    ) {
                      L.e('Gagal navigasi ke Form Diary Craving: $e $s');
                      return null;
                    }),
                  ),
          child: const Icon(CupertinoIcons.add),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Diary Craving')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              if (topPemicu.isNotEmpty)
                _RingkasanPemicu(
                  topPemicu: topPemicu,
                  jumlahLainnya: jumlahLainnya,
                ),
              Expanded(
                child: ListView.separated(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return Card(
                      key: ValueKey(item.id),
                      child: ListTile(
                        leading: Icon(item.pemicu.icon),
                        title: Text(item.pemicu.label),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              'Intensitas: ${item.intensitas}/5  •  ${FormatWaktuLengkap.formatSingkat(item.tanggal)}',
                            ),
                            if (item.catatan != null && item.catatan!.isNotEmpty)
                              Text(item.catatan!),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Hapus',
                          onPressed: () => unawaited(_hapus(item)),
                        ),
                        onTap: () => unawaited(
                          Nav.to(context, FormDiaryCraving(craving: item)).catchError((
                            Object e,
                            StackTrace s,
                          ) {
                            L.e('Gagal navigasi ke Form Diary Craving: $e $s');
                            return null;
                          }),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => unawaited(
          Nav.to(context, const FormDiaryCraving()).catchError((
            Object e,
            StackTrace s,
          ) {
            L.e('Gagal navigasi ke Form Diary Craving: $e $s');
            return null;
          }),
        ),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}

class _EmptyDiaryCraving extends StatelessWidget {
  const _EmptyDiaryCraving();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(CupertinoIcons.book, size: 48),
              Text(
                'Belum ada catatan craving',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Tekan tombol + untuk mencatat craving pertama.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ringkasan analisis pemicu: menampilkan 3 pemicu teratas beserta jumlahnya,
/// ditambah label "Lainnya" dengan jumlah sisa jika ada pemicu di luar top 3.
class _RingkasanPemicu extends StatelessWidget {
  const _RingkasanPemicu({
    required this.topPemicu,
    required this.jumlahLainnya,
  });

  final List<MapEntry<PemicuEnum, int>> topPemicu;
  final int jumlahLainnya;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Pemicu Teratas',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            ...topPemicu.map(
              (e) => _BarisPemicu(
                icon: e.key.icon,
                label: e.key.label,
                jumlah: e.value,
              ),
            ),
                if (jumlahLainnya > 0)
              _BarisPemicu(
                icon: Icons.more_horiz,
                label: 'Kategori lain',
                jumlah: jumlahLainnya,
              ),
          ],
        ),
      ),
    );
  }
}

/// Satu baris ringkasan pemicu: ikon, label, dan jumlah kemunculan.
class _BarisPemicu extends StatelessWidget {
  const _BarisPemicu({
    required this.icon,
    required this.label,
    required this.jumlah,
  });

  final IconData icon;
  final String label;
  final int jumlah;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      spacing: 8,
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        Expanded(
          child: Text(
            label,
            style: textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '$jumlah',
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
