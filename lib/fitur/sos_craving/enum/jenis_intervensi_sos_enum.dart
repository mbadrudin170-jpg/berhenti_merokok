/// Jenis intervensi yang tersedia pada SOS Craving.
// Enum value di-lowerCamelCase sesuai konvensi penamaan proyek (sebelumnya
// snake_case yang ikut tersimpan ke kolom database).
enum JenisIntervensiSos {
  napas478,
  timer3Menit,
  distraksi,
  napasBox,
  napas90Detik,
  grounding54321,
  urgeSurfing,
  timerCraving,
}

/// Extension yang menyediakan label untuk [JenisIntervensiSos].
extension JenisIntervensiSosExtension on JenisIntervensiSos {
  String get label {
    switch (this) {
      case JenisIntervensiSos.napas478:
        return 'Napas 4-7-8';
      case JenisIntervensiSos.timer3Menit:
        return 'Timer 3 Menit';
      case JenisIntervensiSos.distraksi:
        return 'Distraksi';
      case JenisIntervensiSos.napasBox:
        return 'Box Breathing';
      case JenisIntervensiSos.napas90Detik:
        return 'Napas 90 Detik';
      case JenisIntervensiSos.grounding54321:
        return 'Grounding 5-4-3-2-1';
      case JenisIntervensiSos.urgeSurfing:
        return 'Urge Surfing';
      case JenisIntervensiSos.timerCraving:
        return 'Timer Craving';
    }
  }
}
