// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:flutter/material.dart';
import 'dart:async';

class _HeaderPemulihan extends StatefulWidget {
  const _HeaderPemulihan({required this.tanggalBerhenti});
  final DateTime tanggalBerhenti;

  @override
  State<_HeaderPemulihan> createState() => _HeaderPemulihanState();
}

class _HeaderPemulihanState extends State<_HeaderPemulihan> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {}); // Cek mounted sebelum setState
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Batalkan timer di dispose
    super.dispose();
  }

  int _hitungHari() {
    final hariIni = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final tanggalBerhenti = DateTime(widget.tanggalBerhenti.year, widget.tanggalBerhenti.month, widget.tanggalBerhenti.day);
    return hariIni.difference(tanggalBerhenti).inDays;
  }

  @override
  Widget build(BuildContext context) {
    // Hanya widget ini yang rebuild tiap detik
    return Text('Hari ke-${_hitungHari()}');
  }
}

class HalamanBenar extends StatelessWidget {
  const HalamanBenar({super.key, required this.tanggalBerhenti});
  final DateTime tanggalBerhenti;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Bagian statis - TIDAK rebuild tiap detik
          const Text('Informasi statis'),
          // Bagian dinamis - HANYA ini yang rebuild tiap detik
          _HeaderPemulihan(tanggalBerhenti: tanggalBerhenti),
          const Text('Informasi statis lainnya'),
        ],
      ),
    );
  }
}