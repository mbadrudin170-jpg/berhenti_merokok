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

class DashboardScreenSalah extends StatelessWidget {
  const DashboardScreenSalah({super.key, required this.biodata});
  final BiodataModel? biodata;

  // SALAH: Duplikasi perhitungan inline di layar
  double _hitungUangDihemat(BiodataModel? biodata) {
    if (biodata == null) return 0;
    final hariBerhenti = DateTime.now().difference(biodata.tanggalMulaiBerhentiMerokok ?? DateTime.now()).inDays;
    if (hariBerhenti < 0) return 0;
    final rokokTidakDiHisap = biodata.jumlahRokokPerHari * hariBerhenti;
    if (biodata.batangPerBungkus == 0) return 0;
    return (rokokTidakDiHisap / biodata.batangPerBungkus) * biodata.hargaRokokPerBungkus;
  }

  @override
  Widget build(BuildContext context) {
    final uangDihemat = _hitungUangDihemat(biodata);
    return Text('Uang dihemat: $uangDihemat');
  }
}

class ImpianScreenSalah extends StatelessWidget {
  const ImpianScreenSalah({super.key, required this.biodata});
  final BiodataModel? biodata;

  // SALAH: Duplikasi perhitungan yang sama di layar lain
  double _hitungUangDihemat(BiodataModel? biodata) {
    if (biodata == null) return 0;
    final hariBerhenti = DateTime.now().difference(biodata.tanggalMulaiBerhentiMerokok ?? DateTime.now()).inDays;
    if (hariBerhenti < 0) return 0;
    final rokokTidakDiHisap = biodata.jumlahRokokPerHari * hariBerhenti;
    if (biodata.batangPerBungkus == 0) return 0;
    return (rokokTidakDiHisap / biodata.batangPerBungkus) * biodata.hargaRokokPerBungkus;
  }

  @override
  Widget build(BuildContext context) {
    final uangDihemat = _hitungUangDihemat(biodata);
    return Text('Saldo terkumpul: $uangDihemat');
  }
}