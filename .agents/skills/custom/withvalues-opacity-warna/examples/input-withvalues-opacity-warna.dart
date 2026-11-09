// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:flutter/material.dart';

class ContohSalah extends StatelessWidget {
  const ContohSalah({super.key});
  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme.primary;
    // Menggunakan withOpacity yang deprecated
    return Container(
      color: warna.withOpacity(0.2),
      child: const Text('Contoh Salah'),
    );
  }
}