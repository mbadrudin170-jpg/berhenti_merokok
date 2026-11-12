import 'package:flutter/material.dart';

/// Tema visual metafora impian (objek yang tumbuh mengikuti progres tabungan).
///
/// Disimpan di penyimpanan lokal (`SharedPreferences`) dan langsung
/// diterapkan tanpa restart aplikasi. Tema tidak mengubah data numerik
/// maupun perhitungan progres.
enum TemaVisualImpian { toples, pohon }

/// Extension yang menyediakan label dan ikon untuk [TemaVisualImpian].
extension TemaVisualImpianExtension on TemaVisualImpian {
  String get label {
    switch (this) {
      case TemaVisualImpian.toples:
        return 'Toples';
      case TemaVisualImpian.pohon:
        return 'Pohon';
    }
  }

  IconData get icon {
    switch (this) {
      case TemaVisualImpian.toples:
        return Icons.cookie_outlined;
      case TemaVisualImpian.pohon:
        return Icons.park_outlined;
    }
  }
}
