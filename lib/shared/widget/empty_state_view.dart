import 'package:flutter/material.dart';

/// Komponen empty state bersama: ikon + judul + deskripsi + CTA opsional.
///
/// Dipakai pada kondisi "belum ada data" di layar daftar maupun layar
/// non-daftar agar pola tampilan konsisten. Widget bersifat pure (tidak
/// membaca provider); pemanggil yang menyediakan teks dan aksi.
class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    required this.ikon,
    required this.judul,
    required this.deskripsi,
    this.ctaLabel,
    this.onCta,
  }) : assert(
         (ctaLabel == null) == (onCta == null),
         'ctaLabel dan onCta harus diisi berpasangan atau keduanya null',
       );

  final IconData ikon;
  final String judul;
  final String deskripsi;

  /// Label tombol CTA. Wajib berpasangan dengan [onCta].
  final String? ctaLabel;

  /// Aksi tombol CTA, misalnya navigasi ke form tambah atau pemulihan data.
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(
                ikon,
                size: 48,
                color: colorScheme.onSurfaceVariant,
              ),
              Text(
                judul,
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                deskripsi,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (ctaLabel != null && onCta != null)
                OutlinedButton(
                  onPressed: onCta,
                  child: Text(ctaLabel!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
