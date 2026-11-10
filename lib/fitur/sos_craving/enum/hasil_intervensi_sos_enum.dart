/// Hasil intervensi SOS Craving dari pertanyaan "Apakah dorongan merokok berkurang?".
enum HasilIntervensiSos {
  berkurang,
  tetap,
  belum_selesai,
}

/// Extension yang menyediakan label untuk [HasilIntervensiSos].
extension HasilIntervensiSosExtension on HasilIntervensiSos {
  String get label {
    switch (this) {
      case HasilIntervensiSos.berkurang:
        return 'Berkurang';
      case HasilIntervensiSos.tetap:
        return 'Tetap';
      case HasilIntervensiSos.belum_selesai:
        return 'Belum selesai';
    }
  }
}
