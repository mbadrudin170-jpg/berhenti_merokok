/// Hasil akhir dari craving.
// Enum value di-lowerCamelCase sesuai konvensi penamaan proyek (sebelumnya
// snake_case yang ikut tersimpan ke kolom database).
enum HasilCravingEnum {
  berhasilMenahan,
  tetapMerokok,
  belumSelesai,
}

/// Extension yang menyediakan label untuk [HasilCravingEnum].
extension HasilCravingEnumExtension on HasilCravingEnum {
  String get label {
    switch (this) {
      case HasilCravingEnum.berhasilMenahan:
        return 'Berhasil menahan';
      case HasilCravingEnum.tetapMerokok:
        return 'Tetap merokok';
      case HasilCravingEnum.belumSelesai:
        return 'Belum selesai';
    }
  }
}
