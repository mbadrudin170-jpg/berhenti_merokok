// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:flutter/material.dart';

class ContohBenar extends StatelessWidget {
  const ContohBenar({super.key});
  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme.primary;
    // Menggunakan withValues sesuai API Flutter terpasang
    return Container(
      color: warna.withValues(alpha: 0.2),
      child: const Text('Contoh Benar'),
    );
  }
}