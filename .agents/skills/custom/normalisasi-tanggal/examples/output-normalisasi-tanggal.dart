// commit: 6fd979fd9e8296bc7d9c40e9037870faef9c846a
import 'package:flutter/material.dart';

class ContohBenar extends StatelessWidget {
  const ContohBenar({super.key, required this.tanggalBerhenti});
  final DateTime tanggalBerhenti;

  @override
  Widget build(BuildContext context) {
    final hariIni = DateTime.now();
    
    // BENAR: Normalisasi ke komponen tanggal saja
    final hariIniDate = DateTime(hariIni.year, hariIni.month, hariIni.day);
    final tanggalBerhentiDate = DateTime(
      tanggalBerhenti.year,
      tanggalBerhenti.month,
      tanggalBerhenti.day,
    );
    
    // BENAR: Hitung selisih hari dengan operand yang sudah dinormalisasi
    final totalHari = hariIniDate.difference(tanggalBerhentiDate).inDays + 1;
    
    // BENAR: Klamp nilai negatif ke nol
    final totalAman = totalHari < 0 ? 0 : totalHari;

    // BENAR: Klamping durasi negatif ke Duration.zero
    final durasi = hariIni.difference(tanggalBerhenti);
    final aman = durasi.isNegative ? Duration.zero : durasi;

    return Text('Hari smoke-free: $totalAman');
  }
}

// Contoh penggunaan isBefore/isAfter pada tanggal yang dinormalisasi
bool _apakahSmokeFreeHariIni(DateTime hariIni, DateTime tanggalBerhenti) {
  final hariIniDate = DateTime(hariIni.year, hariIni.month, hariIni.day);
  final tanggalBerhentiDate = DateTime(
    tanggalBerhenti.year,
    tanggalBerhenti.month,
    tanggalBerhenti.day,
  );
  return !hariIniDate.isBefore(tanggalBerhentiDate);
}