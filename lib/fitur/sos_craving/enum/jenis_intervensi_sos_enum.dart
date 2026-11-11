/// Jenis intervensi yang tersedia pada SOS Craving.
enum JenisIntervensiSos {
  napas_478,
  timer_3_menit,
  distraksi,
  napas_box,
  napas_90_detik,
  grounding_54321,
  urge_surfing,
  timer_craving,
}

/// Extension yang menyediakan label untuk [JenisIntervensiSos].
extension JenisIntervensiSosExtension on JenisIntervensiSos {
  String get label {
    switch (this) {
      case JenisIntervensiSos.napas_478:
        return 'Napas 4-7-8';
      case JenisIntervensiSos.timer_3_menit:
        return 'Timer 3 Menit';
      case JenisIntervensiSos.distraksi:
        return 'Distraksi';
      case JenisIntervensiSos.napas_box:
        return 'Box Breathing';
      case JenisIntervensiSos.napas_90_detik:
        return 'Napas 90 Detik';
      case JenisIntervensiSos.grounding_54321:
        return 'Grounding 5-4-3-2-1';
      case JenisIntervensiSos.urge_surfing:
        return 'Urge Surfing';
      case JenisIntervensiSos.timer_craving:
        return 'Timer Craving';
    }
  }
}
