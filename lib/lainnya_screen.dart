import 'package:berhenti_merokok/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart';
import 'package:berhenti_merokok/fitur/diary_craving/screens/diary_craving_screen.dart';
import 'package:berhenti_merokok/fitur/dummy/screens/dummy_screen.dart';
import 'package:berhenti_merokok/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart';
import 'package:berhenti_merokok/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart';
import 'package:berhenti_merokok/fitur/pengaturan/screens/pengaturan_screen.dart';
import 'package:berhenti_merokok/fitur/sos_craving/screens/sos_craving_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_global_saya/core_shared.dart';

class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lainnya')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildTombolCustom(
              () => Nav.to(context, const PengaturanScreen()),
              'Pengaturan',
            ),
            _buildTombolCustom(() => Nav.to(context, DummyScreen()), 'Dummy'),
            _buildTombolCustom(
              () => Nav.to(context, const SosCravingScreen()),
              'SOS Craving',
            ),
            _buildTombolCustom(
              () => Nav.to(context, const PemulihanKesehatanScreen()),
              'Pemulihan Kesehatan',
            ),
            _buildTombolCustom(
              () => Nav.to(context, const DiaryCravingScreen()),
              'Diary Craving',
            ),
            _buildTombolCustom(
              () => Nav.to(context, const AlasanBerhentiScreen()),
              'Alasan Berhenti',
            ),
            _buildTombolCustom(
              () => Nav.to(context, const KalenderSmokeFreeScreen()),
              'Kalender Smoke-Free',
            ),
            _buildTombolCustom(
              () => Nav.to(context, const KonsumsiRokokScreen()),
              'Konsumsi Rokok',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTombolCustom(VoidCallback ontap, String title) {
    return ListTile(
      onTap: ontap,
      title: Text(title),
      trailing: Icon(CupertinoIcons.chevron_right),
    );
  }
}
