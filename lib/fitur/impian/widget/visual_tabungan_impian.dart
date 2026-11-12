import 'package:berhenti_merokok/fitur/impian/enum/tema_visual_impian.dart';
import 'package:flutter/material.dart';

/// Widget visual tabungan impian: objek visual (sesuai [tema]) yang tumbuh
/// proporsional terhadap rasio progres, dengan `LinearProgressIndicator`
/// di bawahnya sebagai indikator utama.
///
/// Menggunakan komponen Flutter bawaan tanpa Lottie/aset gambar baru.
/// Objek visual tidak menggantikan data numerik aktual; angka progres
/// tetap ditampilkan oleh pemanggil.
class VisualTabunganImpian extends StatelessWidget {
  const VisualTabunganImpian({
    super.key,
    required this.rasio,
    required this.tercapai,
    required this.tema,
    this.pakaiAktual = false,
    this.labelSaldo,
  });

  /// Rasio progres (0.0 - 1.0).
  final double rasio;

  /// Apakah impian sudah tercapai.
  final bool tercapai;

  /// Tema visual metafora impian (objek yang ditampilkan).
  final TemaVisualImpian tema;

  /// Apakah progres dihitung dari saldo aktual ("dari catatan"); false berarti
  /// dari estimasi baseline. Menentukan label aksesibilitas/tooltip.
  final bool pakaiAktual;

  /// Label sumber saldo untuk tooltip, aksesibilitas, dan caption di bawah
  /// progress bar. Bila kosong, diturunkan dari [pakaiAktual].
  final String? labelSaldo;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final aman = rasio.clamp(0.0, 1.0);
    // Objek visual tumbuh proporsional terhadap rasio progres (0-1).
    final ukuranIkon = 20.0 + (28.0 * aman);
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Icon(
              tema.icon,
              size: ukuranIkon,
              color: tercapai ? cs.primary : cs.secondary,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: aman,
                minHeight: 12,
                backgroundColor: cs.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                  tercapai ? cs.primary : cs.secondary,
                ),
              ),
            ),
            Text(
              tooltip,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
