/// Strategi yang dicoba untuk menahan craving.
// Enum value di-lowerCamelCase sesuai konvensi penamaan proyek (sebelumnya
// snake_case yang ikut tersimpan ke kolom database).
enum StrategiCravingEnum {
  napas478,
  minumAir,
  jalan,
  alihAktivitas,
  tunda5Menit,
  lainnya,
}

/// Extension yang menyediakan label untuk [StrategiCravingEnum].
extension StrategiCravingEnumExtension on StrategiCravingEnum {
  String get label {
    switch (this) {
      case StrategiCravingEnum.napas478:
        return 'Napas 4-7-8';
      case StrategiCravingEnum.minumAir:
        return 'Minum air';
      case StrategiCravingEnum.jalan:
        return 'Jalan';
      case StrategiCravingEnum.alihAktivitas:
        return 'Alih aktivitas';
      case StrategiCravingEnum.tunda5Menit:
        return 'Tunda 5 menit';
      case StrategiCravingEnum.lainnya:
        return 'Lainnya';
    }
  }
}
