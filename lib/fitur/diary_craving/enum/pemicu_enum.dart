import 'package:flutter/material.dart';

/// Kategori pemicu craving.
enum PemicuEnum {
  stres,
  kopi,
  alkohol,
  sosial,
  bauRokok,
  emosi,
  lapar,
  lelah,
  lainnya,
}

/// Extension yang menyediakan label dan ikon untuk [PemicuEnum].
extension PemicuEnumExtension on PemicuEnum {
  String get label {
    switch (this) {
      case PemicuEnum.stres:
        return 'Stres';
      case PemicuEnum.kopi:
        return 'Kopi';
      case PemicuEnum.alkohol:
        return 'Alkohol';
      case PemicuEnum.sosial:
        return 'Sosial';
      case PemicuEnum.bauRokok:
        return 'Bau rokok';
      case PemicuEnum.emosi:
        return 'Emosi';
      case PemicuEnum.lapar:
        return 'Lapar';
      case PemicuEnum.lelah:
        return 'Lelah';
      case PemicuEnum.lainnya:
        return 'Lainnya';
    }
  }

  IconData get icon {
    switch (this) {
      case PemicuEnum.stres:
        return Icons.psychology_alt_outlined;
      case PemicuEnum.kopi:
        return Icons.coffee_outlined;
      case PemicuEnum.alkohol:
        return Icons.local_bar_outlined;
      case PemicuEnum.sosial:
        return Icons.people_outline;
      case PemicuEnum.bauRokok:
        return Icons.smoking_rooms_outlined;
      case PemicuEnum.emosi:
        return Icons.mood_outlined;
      case PemicuEnum.lapar:
        return Icons.restaurant_outlined;
      case PemicuEnum.lelah:
        return Icons.bedtime_outlined;
      case PemicuEnum.lainnya:
        return Icons.more_horiz;
    }
  }
}
