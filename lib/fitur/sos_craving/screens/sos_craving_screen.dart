import 'dart:async';

import 'package:berhenti_merokok/fitur/alasan_berhenti/notifier/alasan_berhenti_notifier.dart';
import 'package:berhenti_merokok/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart';
import 'package:berhenti_merokok/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/box_breathing_view.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/distraksi_view.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/grounding_54321_view.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/napas_478_view.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/napas_90_detik_view.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/timer_craving_view.dart';
import 'package:berhenti_merokok/fitur/sos_craving/widgets/urge_surfing_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman bantuan cepat saat craving (SOS Craving).
///
/// Menampilkan kartu "Ingat alasanmu" di atas menu kartu teknik.
/// Mengetuk kartu teknik membuka tampilan detail teknik; tombol kembali
/// pada AppBar mengembalikan ke menu kartu.
class SosCravingScreen extends ConsumerStatefulWidget {
  const SosCravingScreen({super.key});

  @override
  ConsumerState<SosCravingScreen> createState() => _SosCravingScreenState();
}

class _SosCravingScreenState extends ConsumerState<SosCravingScreen> {
  JenisIntervensiSos? _teknikTerpilih;

  /// Daftar kartu teknik sesuai urutan yang disepakati:
  /// Napas 4-7-8 → Timer Craving → Box Breathing → Napas 90 Detik →
  /// Grounding 5-4-3-2-1 → Distraksi → Urge Surfing.
  static const List<({JenisIntervensiSos jenis, IconData ikon, String nama, String deskripsi})>
      _kartuTeknik = [
    (
      jenis: JenisIntervensiSos.napas478,
      ikon: Icons.air,
      nama: 'Napas 4-7-8',
      deskripsi: 'Tarik 4, tahan 7, hembus 8',
    ),
    (
      jenis: JenisIntervensiSos.timerCraving,
      ikon: Icons.timer_outlined,
      nama: 'Timer Craving',
      deskripsi: 'Tahan 3, 5, atau 10 menit',
    ),
    (
      jenis: JenisIntervensiSos.napasBox,
      ikon: Icons.crop_square,
      nama: 'Box Breathing',
      deskripsi: 'Napas kotak 4-4-4-4',
    ),
    (
      jenis: JenisIntervensiSos.napas90Detik,
      ikon: Icons.hourglass_bottom,
      nama: 'Napas 90 Detik',
      deskripsi: '90 detik napas lega',
    ),
    (
      jenis: JenisIntervensiSos.grounding54321,
      ikon: Icons.touch_app,
      nama: 'Grounding 5-4-3-2-1',
      deskripsi: 'Sadar 5 indra sekitar',
    ),
    (
      jenis: JenisIntervensiSos.distraksi,
      ikon: Icons.gamepad_outlined,
      nama: 'Distraksi',
      deskripsi: 'Alihkan dengan aktivitas',
    ),
    (
      jenis: JenisIntervensiSos.urgeSurfing,
      ikon: Icons.waves,
      nama: 'Urge Surfing',
      deskripsi: 'Tunggangi gelombang craving',
    ),
  ];

  @override
  void initState() {
    super.initState();
    L.i('SosCravingScreen initState');
  }

  @override
  void dispose() {
    L.i('SosCravingScreen dispose');
    super.dispose();
  }

  void _pilihTeknik(JenisIntervensiSos jenis) {
    L.i('teknik dipilih: ${jenis.name}');
    setState(() {
      _teknikTerpilih = jenis;
    });
  }

  void _kembaliKeMenu() {
    L.i('kembali ke menu teknik');
    setState(() {
      _teknikTerpilih = null;
    });
  }

  /// Membangun kartu pengingat alasan berhenti terbaru (penguat motivasi).
  Widget _buildKartuAlasanBerhenti() {
    final alasanAsync = ref.watch(alasanBerhentiProvider);
    final listAlasan = alasanAsync.asData?.value.listAlasan;
    L.i('listAlasan.length=${listAlasan?.length}');
    if (listAlasan == null || listAlasan.isEmpty) {
      L.w('alasan kosong, tampilkan pesan + CTA');
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                      Icons.favorite_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Text(
                            'Belum ada alasan berhenti',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Catat alasan berhenti agar bisa menguatkanmu '
                            'saat craving.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () => unawaited(
                    Nav.to(context, const AlasanBerhentiScreen()).catchError((
                      Object e,
                      StackTrace s,
                    ) {
                      L.e('Gagal navigasi ke Alasan Berhenti: $e $s');
                      return null;
                    }),
                  ),
                  child: const Text('Tambah alasan'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    final terbaru = listAlasan.first;
    L.i('terbaru=$terbaru');
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.primary,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      'Ingat alasanmu',
                      style: Theme.of(context).textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      terbaru.teks,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKartuTeknik({
    required IconData ikon,
    required String nama,
    required String deskripsi,
    required VoidCallback onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Icon(
                ikon,
                size: 36,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                nama,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                deskripsi,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTeknik() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        _buildKartuAlasanBerhenti(),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            padding: const EdgeInsets.all(16),
            childAspectRatio: 1.05,
            children: [
              for (final kartu in _kartuTeknik)
                _buildKartuTeknik(
                  ikon: kartu.ikon,
                  nama: kartu.nama,
                  deskripsi: kartu.deskripsi,
                  onTap: () => _pilihTeknik(kartu.jenis),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Text(
            'Teknik ini bukan pengganti nasihat medis.',
            textAlign: TextAlign.center,
            style: textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailTeknik(JenisIntervensiSos jenis) {
    switch (jenis) {
      case JenisIntervensiSos.napas478:
        return const Napas478View();
      case JenisIntervensiSos.timerCraving:
      case JenisIntervensiSos.timer3Menit:
        return const TimerCravingView();
      case JenisIntervensiSos.napasBox:
        return const BoxBreathingView();
      case JenisIntervensiSos.napas90Detik:
        return const Napas90DetikView();
      case JenisIntervensiSos.grounding54321:
        return const Grounding54321View();
      case JenisIntervensiSos.distraksi:
        return const DistraksiView();
      case JenisIntervensiSos.urgeSurfing:
        return const UrgeSurfingView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final teknik = _teknikTerpilih;
    return Scaffold(
      appBar: AppBar(
        title: Text(teknik == null ? 'SOS Craving' : teknik.label),
        leading: teknik == null
            ? null
            : IconButton(
                tooltip: 'Kembali ke menu',
                icon: const Icon(Icons.arrow_back),
                onPressed: _kembaliKeMenu,
              ),
      ),
      body: SafeArea(
        child: teknik == null
            ? _buildMenuTeknik()
            : _buildDetailTeknik(teknik),
      ),
    );
  }
}
