// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:flutter/material.dart';
import 'dart:async';

class HalamanSalah extends StatefulWidget {
  const HalamanSalah({super.key, required this.tanggalBerhenti});
  final DateTime tanggalBerhenti;

  @override
  State<HalamanSalah> createState() => _HalamanSalahState();
}

class _HalamanSalahState extends State<HalamanSalah> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Timer di level halaman - seluruh halaman rebuild tiap detik
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {}); // Rebuild seluruh halaman
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int _hitungHari() {
    return DateTime.now().difference(widget.tanggalBerhenti).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Bagian lain yang TIDAK perlu update tiap detik
          const Text('Informasi statis'),
          // Bagian ini saja yang perlu update tiap detik
          Text('Hari ke-${_hitungHari()}'),
          const Text('Informasi statis lainnya'),
        ],
      ),
    );
  }
}