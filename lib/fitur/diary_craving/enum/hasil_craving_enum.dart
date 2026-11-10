/// Hasil akhir dari craving.
enum HasilCravingEnum {
  berhasil_menahan,
  tetap_merokok,
  belum_selesai,
}

/// Extension yang menyediakan label untuk [HasilCravingEnum].
extension HasilCravingEnumExtension on HasilCravingEnum {
  String get label {
    switch (this) {
      case HasilCravingEnum.berhasil_menahan:
        return 'Berhasil menahan';
      case HasilCravingEnum.tetap_merokok:
        return 'Tetap merokok';
      case HasilCravingEnum.belum_selesai:
        return 'Belum selesai';
    }
  }
}
