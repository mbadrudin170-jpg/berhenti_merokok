/// Hasil intervensi SOS Craving dari pertanyaan "Apakah dorongan merokok berkurang?".
// Enum value di-lowerCamelCase sesuai konvensi penamaan proyek (sebelumnya
// snake_case yang ikut tersimpan ke kolom database).
enum HasilIntervensiSos { berkurang, tetap, belumSelesai }

/// Extension yang menyediakan label untuk [HasilIntervensiSos].
extension HasilIntervensiSosExtension on HasilIntervensiSos {
  String get label {
    switch (this) {
      case HasilIntervensiSos.berkurang:
        return 'Berkurang';
      case HasilIntervensiSos.tetap:
        return 'Tetap';
      case HasilIntervensiSos.belumSelesai:
        return 'Belum selesai';
    }
  }
}
