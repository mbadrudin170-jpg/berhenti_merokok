import 'package:flutter/material.dart';

/// Widget visual tabungan (piggy bank) menggunakan Stack inline.
/// Ikon tabungan dilapis di atas LinearProgressIndicator.
/// Menggunakan komponen Flutter bawaan tanpa Lottie/aset gambar baru.
class VisualTabunganImpian extends StatelessWidget {
  const VisualTabunganImpian({
    super.key,
    required this.rasio,
    required this.tercapai,
  });

  /// Rasio progres (0.0 - 1.0).
  final double rasio;

  /// Apakah impian sudah tercapai.
  final bool tercapai;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final aman = rasio.clamp(0.0, 1.0);
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: aman,
              minHeight: 40,
              backgroundColor: cs.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                tercapai ? cs.primary : cs.secondary,
              ),
            ),
          ),
          Icon(
            tercapai ? Icons.savings : Icons.savings_outlined,
            color: tercapai ? cs.onPrimary : cs.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
