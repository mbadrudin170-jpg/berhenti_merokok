import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/hasil_craving_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/mood_craving_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/strategi_craving_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/helper/pola_craving_helper.dart';
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
              if (list.length >= PolaCravingHelper.minimumEntri)
                _RingkasanWawasan(list: list)
              else
                const _PlaceholderWawasan(),
              Expanded(
                child: ListView.separated(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    final mood = item.mood;
                    final hasil = item.hasil;
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
                            if (mood != null || hasil != null)
                              Row(
                                spacing: 8,
                                children: [
                                  if (mood != null)
                                    _PenandaDetail(
                                      icon: Icons.mood_outlined,
                                      label: mood.label,
                                    ),
                                  if (hasil != null)
                                    _PenandaDetail(
                                      icon: hasil ==
                                              HasilCravingEnum.berhasil_menahan
                                          ? Icons.check_circle_outline
                                          : Icons.radio_button_unchecked,
                                      label: hasil.label,
                                    ),
                                ],
                              ),
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

/// Ringkasan wawasan craving: rata-rata intensitas 7/30 hari, jam rawan,
/// dan strategi paling membantu (bila data memadai).
class _RingkasanWawasan extends StatelessWidget {
  const _RingkasanWawasan({required this.list});

  final List<DiaryCravingModel> list;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final sekarang = DateTime.now();
    L.i('list.length=${list.length}, sekarang=$sekarang');
    final rataRata7 = PolaCravingHelper.rataRataIntensitas(
      PolaCravingHelper.pola7Hari(list, sekarang: sekarang),
    );
    final rataRata30 = PolaCravingHelper.rataRataIntensitas(
      PolaCravingHelper.pola30Hari(list, sekarang: sekarang),
    );
    final jamRawan = PolaCravingHelper.jamTeratas(list);
    final strategi = PolaCravingHelper.strategiPalingMembantu(list);
    L.i(
      'rataRata7=$rataRata7, rataRata30=$rataRata30, jamRawan=$jamRawan, strategi=$strategi',
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Wawasan',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            _BarisWawasan(
              label: 'Rata-rata intensitas 7 hari',
              nilai: rataRata7 == null
                  ? '-'
                  : '${rataRata7.toStringAsFixed(1)}/5',
            ),
            _BarisWawasan(
              label: 'Rata-rata intensitas 30 hari',
              nilai: rataRata30 == null
                  ? '-'
                  : '${rataRata30.toStringAsFixed(1)}/5',
            ),
            _BarisWawasan(
              label: 'Jam rawan',
              nilai: jamRawan == null
                  ? '-'
                  : '${jamRawan.toString().padLeft(2, '0')}.00',
            ),
            if (strategi != null)
              _BarisWawasan(
                label: 'Strategi paling membantu',
                nilai: strategi.label,
              ),
          ],
        ),
      ),
    );
  }
}

/// Satu baris ringkasan wawasan: label dan nilai.
class _BarisWawasan extends StatelessWidget {
  const _BarisWawasan({required this.label, required this.nilai});

  final String label;
  final String nilai;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Text(
            label,
            style: textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          nilai,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

/// Placeholder kecil yang ditampilkan saat entri belum cukup untuk wawasan.
class _PlaceholderWawasan extends StatelessWidget {
  const _PlaceholderWawasan();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          spacing: 8,
          children: [
            Icon(
              CupertinoIcons.info_circle,
              size: 18,
              color: colorScheme.primary,
            ),
            Expanded(
              child: Text(
                'Catat minimal 3 craving untuk melihat wawasan',
                style: textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Penanda kecil untuk menampilkan mood/hasil pada item daftar craving.
class _PenandaDetail extends StatelessWidget {
  const _PenandaDetail({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Icon(icon, size: 14, color: colorScheme.primary),
        Flexible(
          child: Text(
            label,
            style: textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
