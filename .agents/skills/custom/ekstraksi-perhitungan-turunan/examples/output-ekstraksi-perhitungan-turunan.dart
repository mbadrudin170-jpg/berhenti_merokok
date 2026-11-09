// commit: 19f43e510b1478a43c5f0594efeef6f83b6c0299
import 'package:flutter/material.dart';

class BiodataModel {
  final int jumlahRokokPerHari;
  final int batangPerBungkus;
  final double hargaRokokPerBungkus;
  final DateTime? tanggalMulaiBerhentiMerokok;

  BiodataModel({
    required this.jumlahRokokPerHari,
    required this.batangPerBungkus,
    required this.hargaRokokPerBungkus,
    this.tanggalMulaiBerhentiMerokok,
  });
}

// BENAR: Ekstensi pada model - didefinisikan SEKALI
extension BiodataModelPerhitungan on BiodataModel {
  int get hariBerhenti {
    final tanggalBerhenti = tanggalMulaiBerhentiMerokok;
    if (tanggalBerhenti == null) return 0;
    final sekarang = DateTime.now();
    final hariIniDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final tanggalBerhentiDate = DateTime(
      tanggalBerhenti.year,
      tanggalBerhenti.month,
      tanggalBerhenti.day,
    );
    final hari = hariIniDate.difference(tanggalBerhentiDate).inDays;
    return hari < 0 ? 0 : hari;
  }

  int get rokokTidakDiHisap => jumlahRokokPerHari * hariBerhenti;

  double get uangDihemat {
    // Guard pembagian dengan nol
    if (batangPerBungkus == 0) return 0;
    return (rokokTidakDiHisap / batangPerBungkus) * hargaRokokPerBungkus;
  }
}

// BENAR: Helper murni tanpa BuildContext/provider
class BadgeHelper {
  const BadgeHelper._();
  static String hitungBadge(int hariBerhenti) {
    if (hariBerhenti >= 365) return 'Platinum';
    if (hariBerhenti >= 180) return 'Emas';
    if (hariBerhenti >= 90) return 'Perak';
    if (hariBerhenti >= 30) return 'Perunggu';
    return 'Belum dapat badge';
  }
}

class DashboardScreenBenar extends StatelessWidget {
  const DashboardScreenBenar({super.key, required this.biodata});
  final BiodataModel? biodata;

  @override
  Widget build(BuildContext context) {
    // BENAR: Konsumsi getter dari ekstensi
    final uangDihemat = biodata?.uangDihemat ?? 0;
    return Text('Uang dihemat: $uangDihemat');
  }
}

class ImpianScreenBenar extends StatelessWidget {
  const ImpianScreenBenar({super.key, required this.biodata});
  final BiodataModel? biodata;

  @override
  Widget build(BuildContext context) {
    // BENAR: Konsumsi getter dari ekstensi yang SAMA
    final uangDihemat = biodata?.uangDihemat ?? 0;
    return Text('Saldo terkumpul: $uangDihemat');
  }
}

class BadgeScreenBenar extends StatelessWidget {
  const BadgeScreenBenar({super.key, required this.biodata});
  final BiodataModel? biodata;

  @override
  Widget build(BuildContext context) {
    // BENAR: Konsumsi helper murni + getter ekstensi
    final hariBerhenti = biodata?.hariBerhenti ?? 0;
    final badge = BadgeHelper.hitungBadge(hariBerhenti);
    return Text('Badge: $badge');
  }
}