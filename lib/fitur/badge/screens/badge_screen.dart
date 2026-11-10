import 'dart:async';

import 'package:berhenti_merokok/fitur/badge/helper/badge_helper.dart';
import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/helper/konsumsi_hitung_helper.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgeScreen extends ConsumerStatefulWidget {
  const BadgeScreen({super.key});

  @override
  ConsumerState<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends ConsumerState<BadgeScreen> {
  /// Id badge yang pernah tercapai (disimpan di SharedPreferences).
  /// Badge historis tidak pernah dicoret dari pencapaian pengguna karena slip.
  Set<String> _badgeHistoris = <String>{};
  bool _historisDimuat = false;

  @override
  void initState() {
    super.initState();
    L.i('BadgeScreen initState');
    unawaited(
      _muatBadgeHistoris().catchError((Object e, StackTrace s) {
        L.e('Gagal memuat badge historis: $e $s');
      }),
    );
  }

  @override
  void dispose() {
    L.i('BadgeScreen dispose');
    super.dispose();
  }

  Future<void> _muatBadgeHistoris() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final daftar =
          prefs.getStringList(keyBadgeTercapaiHistoris) ?? <String>[];
      if (mounted) {
        setState(() {
          _badgeHistoris = daftar.toSet();
          _historisDimuat = true;
        });
      }
    } catch (e, s) {
      L.e('Gagal memuat SharedPreferences $keyBadgeTercapaiHistoris: $e $s');
      if (mounted) {
        setState(() => _historisDimuat = true);
      }
    }
  }

  Future<void> _simpanBadgeHistoris(Set<String> baru) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(keyBadgeTercapaiHistoris, baru.toList());
      if (mounted) {
        setState(() => _badgeHistoris = baru);
      }
    } catch (e, s) {
      L.e('Gagal menyimpan badge historis: $e $s');
    }
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
    final hariTercatat = MetrikBerhentiHelper.hitungJumlahHariTercatat(
      konsumsiList,
    );
    final pakaiAktual = hariTercatat > 0;
    final rokokDihindariAktual =
        MetrikBerhentiHelper.hitungRokokDihindariAktual(biodata, konsumsiList);
    final rokokTidakDiHisapEstimasi =
        MetrikBerhentiHelper.hitungRokokTidakDiHisapEstimasi(biodata);
    final uangDihematAktual = MetrikBerhentiHelper.hitungUangDihematAktual(
      biodata,
      konsumsiList,
    );
    final uangDihematEstimasi = MetrikBerhentiHelper.hitungUangDihematEstimasi(
      biodata,
    );
    final streakHariIni = MetrikBerhentiHelper.hitungStreak(konsumsiList);
    final streakPencatatan = MetrikBerhentiHelper.hitungStreakPencatatan(
      konsumsiList,
    );
    final sedangTapering = biodata.sedangTapering;
    final mingguTaperingBerjalan =
        MetrikBerhentiHelper.hitungMingguTaperingBerjalan(biodata);
    final konsumsiHariIni = KonsumsiHitungHelper.konsumsiHariIni(konsumsiList);
    final taperingTercapai = sedangTapering
        ? List<bool>.generate(4, (index) {
            final mingguKe = index + 1;
            return mingguTaperingBerjalan >= mingguKe &&
                konsumsiHariIni <=
                    MetrikBerhentiHelper.hitungTargetTaperingMingguKe(
                      biodata,
                      mingguKe,
                    );
          })
        : const <bool>[false, false, false, false];
    L.i(
      'hariSmokeFree=$hariSmokeFree, hariTercatat=$hariTercatat, '
      'rokokDihindariAktual=$rokokDihindariAktual, '
      'rokokTidakDiHisapEstimasi=$rokokTidakDiHisapEstimasi, '
      'uangDihematAktual=$uangDihematAktual, '
      'uangDihematEstimasi=$uangDihematEstimasi, '
      'streakHariIni=$streakHariIni, streakPencatatan=$streakPencatatan, '
      'sedangTapering=$sedangTapering, '
      'mingguTaperingBerjalan=$mingguTaperingBerjalan, '
      'konsumsiHariIni=$konsumsiHariIni, taperingTercapai=$taperingTercapai',
    );

    // Saldo untuk menghitung impian tercapai: aktual bila ada catatan,
    // fallback estimasi bila belum ada catatan sama sekali.
    final saldoUntukImpian = pakaiAktual
        ? uangDihematAktual
        : uangDihematEstimasi;
    int impianTercapai = 0;
    for (final impian in impianState.listImpian) {
      if (saldoUntukImpian >= impian.jumlah) {
        impianTercapai++;
      }
    }

    final daftarBadge = hitungBadge(
      hariSmokeFree: hariSmokeFree,
      rokokDihindariAktual: rokokDihindariAktual,
      rokokTidakDiHisapEstimasi: rokokTidakDiHisapEstimasi,
      uangDihematAktual: uangDihematAktual,
      uangDihematEstimasi: uangDihematEstimasi,
      impianTercapai: impianTercapai,
      streakHariIni: streakHariIni,
      streakPencatatan: streakPencatatan,
      hariTercatat: hariTercatat,
      sedangTapering: sedangTapering,
      taperingTercapai: taperingTercapai,
      badgeTercapaiHistoris: _badgeHistoris,
    );
    final jumlahTercapai = daftarBadge.where((b) => b.tercapai).length;

    // Simpan badge yang baru tercapai ke SharedPreferences agar tidak hilang
    // dari tampilan pencapaian bila metrik aktual turun karena slip berikutnya.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_historisDimuat) return;
      final tercapaiSekarang = daftarBadge
          .where((b) => b.tercapai)
          .map((b) => b.id)
          .toSet();
      final kurang = tercapaiSekarang.difference(_badgeHistoris);
      if (kurang.isNotEmpty) {
        unawaited(
          _simpanBadgeHistoris({..._badgeHistoris, ...tercapaiSekarang})
              .catchError((Object e, StackTrace s) {
                L.e('Gagal menyimpan badge historis: $e $s');
              }),
        );
      }
    });

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
              Text(
                pakaiAktual
                    ? 'Badge rokok/uang dihitung dari $hariTercatat hari tercatat; badge lainnya dari baseline biodata. Badge yang pernah tercapai tetap tersimpan meskipun Anda slip.'
                    : 'Belum ada catatan konsumsi. Badge rokok/uang memakai estimasi dari biodata. Badge yang pernah tercapai tetap tersimpan meskipun Anda slip.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
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
