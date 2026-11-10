import 'package:berhenti_merokok/fitur/badge/helper/badge_helper.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class BadgeScreen extends ConsumerStatefulWidget {
  const BadgeScreen({super.key});

  @override
  ConsumerState<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends ConsumerState<BadgeScreen> {
  @override
  void initState() {
    super.initState();
    L.i('BadgeScreen initState');
  }

  @override
  void dispose() {
    L.i('BadgeScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    final impianAsync = ref.watch(impianProvider);
    final konsumsiAsync = ref.watch(konsumsiRokokProvider);

    if (biodataAsync.isLoading ||
        impianAsync.isLoading ||
        konsumsiAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      L.e(
        'biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}',
      );
      return Scaffold(
        appBar: AppBar(title: const Text('Pencapaian')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const Text('Gagal memuat data'),
                  OutlinedButton(
                    onPressed: () {
                      final _ = ref.refresh(biodataProvider);
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (impianAsync.hasError) {
      L.e('impianAsync error: ${impianAsync.error} ${impianAsync.stackTrace}');
      return Scaffold(
        appBar: AppBar(title: const Text('Pencapaian')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const Text('Gagal memuat data impian'),
                  OutlinedButton(
                    onPressed: () {
                      final _ = ref.refresh(impianProvider);
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (konsumsiAsync.hasError) {
      L.e(
        'konsumsiAsync error: ${konsumsiAsync.error} ${konsumsiAsync.stackTrace}',
      );
      return Scaffold(
        appBar: AppBar(title: const Text('Pencapaian')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const Text('Gagal memuat data konsumsi'),
                  OutlinedButton(
                    onPressed: () {
                      final _ = ref.refresh(konsumsiRokokProvider);
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final biodata = biodataAsync.requireValue;
    final impianState = impianAsync.requireValue;
    final konsumsiList = konsumsiAsync.requireValue.listKonsumsi;

    if (biodata == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Pencapaian')),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Lengkapi biodata terlebih dahulu untuk melihat pencapaian.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }

    // Hitung progres smoke-free.
    // Badge berbasis hari tetap baseline; badge berbasis rokok/uang memakai
    // aktual bila ada catatan konsumsi, fallback ke baseline bila belum ada.
    final hariSmokeFree = MetrikBerhentiHelper.hitungHariBerhenti(biodata);
    final adaCatatan = konsumsiList.isNotEmpty;
    final rokokTidakDiHisap = adaCatatan
        ? MetrikBerhentiHelper.hitungRokokDihindariAktual(biodata, konsumsiList)
        : MetrikBerhentiHelper.hitungRokokTidakDiHisapEstimasi(biodata);
    final uangDihemat = adaCatatan
        ? MetrikBerhentiHelper.hitungUangDihematAktual(biodata, konsumsiList)
        : MetrikBerhentiHelper.hitungUangDihematEstimasi(biodata);
    L.i(
      'hariSmokeFree=$hariSmokeFree, adaCatatan=$adaCatatan, rokokTidakDiHisap=$rokokTidakDiHisap, uangDihemat=$uangDihemat',
    );

    // Hitung impian tercapai.
    int impianTercapai = 0;
    for (final impian in impianState.listImpian) {
      if (uangDihemat >= impian.jumlah) {
        impianTercapai++;
      }
    }

    final daftarBadge = hitungBadge(
      hariSmokeFree: hariSmokeFree,
      rokokTidakDiHisap: rokokTidakDiHisap,
      uangDihemat: uangDihemat,
      impianTercapai: impianTercapai,
    );
    final jumlahTercapai = daftarBadge.where((b) => b.tercapai).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Pencapaian')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                '$jumlahTercapai dari ${daftarBadge.length} badge tercapai',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: daftarBadge.length,
                  itemBuilder: (context, index) {
                    final badge = daftarBadge[index];
                    return _BadgeCard(key: ValueKey(badge.id), badge: badge);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({super.key, required this.badge});

  final BadgePencapaian badge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tercapai = badge.tercapai;
    return Card(
      color: tercapai
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Icon(
              badge.icon,
              size: 32,
              color: tercapai
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            Text(
              badge.nama,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: tercapai
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              badge.deskripsi,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: tercapai
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
