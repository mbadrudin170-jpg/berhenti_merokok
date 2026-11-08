import 'package:flutter/material.dart';

/// Opsi pengurutan daftar impian.
enum SortImpian {
  namaAz,
  namaZa,
  jumlahAz,
  jumlahZa,
  mendekatiTerkumpulAz,
  mendekatiTerkumpulZa,
}

/// Extension yang menyediakan label dan ikon untuk [SortImpian].
extension SortImpianExtension on SortImpian {
  String get label {
    switch (this) {
      case SortImpian.namaAz:
        return 'Nama A-Z';
      case SortImpian.namaZa:
        return 'Nama Z-A';
      case SortImpian.jumlahAz:
        return 'Jumlah terkecil';
      case SortImpian.jumlahZa:
        return 'Jumlah terbesar';
      case SortImpian.mendekatiTerkumpulAz:
        return 'Paling mendekati terkumpul (kecil)';
      case SortImpian.mendekatiTerkumpulZa:
        return 'Paling mendekati terkumpul (besar)';
    }
  }

  IconData get icon {
    switch (this) {
      case SortImpian.namaAz:
        return Icons.arrow_upward;
      case SortImpian.namaZa:
        return Icons.arrow_downward;
      case SortImpian.jumlahAz:
        return Icons.arrow_upward;
      case SortImpian.jumlahZa:
        return Icons.arrow_downward;
      case SortImpian.mendekatiTerkumpulAz:
        return Icons.arrow_upward;
      case SortImpian.mendekatiTerkumpulZa:
        return Icons.arrow_downward;
    }
  }
}
