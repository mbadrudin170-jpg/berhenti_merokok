import 'package:berhenti_merokok/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart';
import 'package:berhenti_merokok/fitur/diary_craving/screens/diary_craving_screen.dart';
import 'package:berhenti_merokok/fitur/dummy/screens/dummy_screen.dart';
import 'package:berhenti_merokok/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart';
import 'package:berhenti_merokok/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart';
import 'package:berhenti_merokok/fitur/pengaturan/screens/pengaturan_screen.dart';
import 'package:berhenti_merokok/fitur/sos_craving/screens/sos_craving_screen.dart';
import 'package:berhenti_merokok/fitur/toxin_pelacakan/screens/toxin_pelacakan_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_global_saya/core_shared.dart';

class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Struktur grup statis; item baru masuk ke grup yang sesuai.
    // DummyScreen hanya tampil pada build debug/development.
    final grup = <_GrupLainnya>[
      _GrupLainnya(
        label: 'Dukungan',
        items: [
          _ItemLainnya(
            ikon: Icons.sos,
            label: 'SOS Craving',
            ontap: () => Nav.to(context, const SosCravingScreen()),
          ),
          _ItemLainnya(
            ikon: CupertinoIcons.heart,
            label: 'Alasan Berhenti',
            ontap: () => Nav.to(context, const AlasanBerhentiScreen()),
          ),
        ],
      ),
      _GrupLainnya(
        label: 'Riwayat & Data',
        items: [
          _ItemLainnya(
            ikon: CupertinoIcons.smoke,
            label: 'Konsumsi Rokok',
            ontap: () => Nav.to(context, const KonsumsiRokokScreen()),
          ),
          _ItemLainnya(
            ikon: CupertinoIcons.book,
            label: 'Diary Craving',
            ontap: () => Nav.to(context, const DiaryCravingScreen()),
          ),
          _ItemLainnya(
            ikon: CupertinoIcons.calendar,
            label: 'Kalender Smoke-Free',
            ontap: () => Nav.to(context, const KalenderSmokeFreeScreen()),
          ),
        ],
      ),
      _GrupLainnya(
        label: 'Alat',
        items: [
          _ItemLainnya(
            ikon: CupertinoIcons.bandage,
            label: 'Pemulihan Kesehatan',
            ontap: () => Nav.to(context, const PemulihanKesehatanScreen()),
          ),
          _ItemLainnya(
            ikon: CupertinoIcons.cloud,
            label: 'Pelacakan Toxin',
            ontap: () => Nav.to(context, const ToxinPelacakanScreen()),
          ),
        ],
      ),
      _GrupLainnya(
        label: 'Pengaturan',
        items: [
          _ItemLainnya(
            ikon: CupertinoIcons.gear,
            label: 'Pengaturan',
            ontap: () => Nav.to(context, const PengaturanScreen()),
          ),
          if (kDebugMode)
            _ItemLainnya(
              ikon: CupertinoIcons.wrench,
              label: 'Dummy',
              ontap: () => Nav.to(context, DummyScreen()),
            ),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lainnya')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final g in grup) ...[
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(
                  g.label,
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (final item in g.items)
                ListTile(
                  leading: Icon(item.ikon),
                  onTap: item.ontap,
                  title: Text(item.label),
                  trailing: const Icon(CupertinoIcons.chevron_right),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _GrupLainnya {
  const _GrupLainnya({required this.label, required this.items});

  final String label;
  final List<_ItemLainnya> items;
}

class _ItemLainnya {
  const _ItemLainnya({
    required this.ikon,
    required this.label,
    required this.ontap,
  });

  final IconData ikon;
  final String label;
  final VoidCallback ontap;
}
