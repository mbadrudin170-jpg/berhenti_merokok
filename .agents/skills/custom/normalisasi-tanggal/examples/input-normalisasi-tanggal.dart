// commit: 6fd979fd9e8296bc7d9c40e9037870faef9c846a
import 'package:flutter/material.dart';

class ContohSalah extends StatelessWidget {
  const ContohSalah({super.key, required this.tanggalBerhenti});
  final DateTime tanggalBerhenti;

  @override
  Widget build(BuildContext context) {
    // SALAH: Membandingkan DateTime.now() (dengan waktu) langsung
    final totalHari = DateTime.now().difference(tanggalBerhenti).inDays + 1;
    // Bisa salah satu hari karena komponen waktu jam/menit/detik

    // SALAH: Tidak mengklamp nilai negatif
    final durasi = DateTime.now().difference(tanggalBerhenti);
    // durasi bisa negatif jika tanggalBerhenti di masa depan

    return Text('Hari smoke-free: $totalHari');
  }
}