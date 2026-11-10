import 'package:flutter/material.dart';

/// Widget visual tabungan (piggy bank) menggunakan Stack inline.
/// Ikon tabungan dilapis di atas LinearProgressIndicator.
/// Menggunakan komponen Flutter bawaan tanpa Lottie/aset gambar baru.
class VisualTabunganImpian extends StatelessWidget {
  const VisualTabunganImpian({
    super.key,
    required this.rasio,
    required this.tercapai,
    this.pakaiAktual = false,
    this.labelSaldo,
  });

  /// Rasio progres (0.0 - 1.0).
  final double rasio;

  /// Apakah impian sudah tercapai.
  final bool tercapai;

  /// Apakah progres dihitung dari saldo aktual ("dari catatan"); false berarti
  /// dari estimasi baseline. Menentukan label aksesibilitas/tooltip.
  final bool pakaiAktual;

  /// Label sumber saldo untuk tooltip dan aksesibilitas. Bila kosong,
  /// diturunkan dari [pakaiAktual].
  final String? labelSaldo;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final aman = rasio.clamp(0.0, 1.0);
    final tooltip =
        labelSaldo ??
        (pakaiAktual
            ? 'Progres tabungan dari catatan konsumsi'
            : 'Progres tabungan estimasi dari biodata');
    return Tooltip(
      message: tooltip,
      child: Semantics(
        label: tooltip,
        container: true,
        child: SizedBox(
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
        ),
      ),
    );
  }
}
