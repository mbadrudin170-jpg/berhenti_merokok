/// Strategi yang dicoba untuk menahan craving.
enum StrategiCravingEnum {
  napas_478,
  minum_air,
  jalan,
  alih_aktivitas,
  tunda_5_menit,
  lainnya,
}

/// Extension yang menyediakan label untuk [StrategiCravingEnum].
extension StrategiCravingEnumExtension on StrategiCravingEnum {
  String get label {
    switch (this) {
      case StrategiCravingEnum.napas_478:
        return 'Napas 4-7-8';
      case StrategiCravingEnum.minum_air:
        return 'Minum air';
      case StrategiCravingEnum.jalan:
        return 'Jalan';
      case StrategiCravingEnum.alih_aktivitas:
        return 'Alih aktivitas';
      case StrategiCravingEnum.tunda_5_menit:
        return 'Tunda 5 menit';
      case StrategiCravingEnum.lainnya:
        return 'Lainnya';
    }
  }
}
