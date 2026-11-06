import 'package:flutter/material.dart';

/// Enum mode tema aplikasi.
enum TemaEnum { sistem, terang, gelap }

/// Extension yang menyediakan label dan ikon untuk [TemaEnum].
extension TemaEnumExtension on TemaEnum {
  String get label {
    switch (this) {
      case TemaEnum.sistem:
        return 'Sistem';
      case TemaEnum.terang:
        return 'Terang';
      case TemaEnum.gelap:
        return 'Gelap';
    }
  }

  IconData get icon {
    switch (this) {
      case TemaEnum.sistem:
        return Icons.brightness_auto;
      case TemaEnum.terang:
        return Icons.light_mode;
      case TemaEnum.gelap:
        return Icons.dark_mode;
    }
  }
}
