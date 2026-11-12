import 'package:flutter/material.dart';

/// Sistem organ yang dipulihkan setelah berhenti merokok.
enum OrganPemulihan { jantung, paru, sirkulasi, saraf }

/// Extension label dan ikon untuk [OrganPemulihan].
extension OrganPemulihanExtension on OrganPemulihan {
  String get label {
    switch (this) {
      case OrganPemulihan.jantung:
        return 'Jantung';
      case OrganPemulihan.paru:
        return 'Paru-paru';
      case OrganPemulihan.sirkulasi:
        return 'Sirkulasi darah';
      case OrganPemulihan.saraf:
        return 'Saraf & indra';
    }
  }

  IconData get icon {
    switch (this) {
      case OrganPemulihan.jantung:
        return Icons.monitor_heart_outlined;
      case OrganPemulihan.paru:
        return Icons.air;
      case OrganPemulihan.sirkulasi:
        return Icons.water_drop_outlined;
      case OrganPemulihan.saraf:
        return Icons.psychology_alt_outlined;
    }
  }
}
