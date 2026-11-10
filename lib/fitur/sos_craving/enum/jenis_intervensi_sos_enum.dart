/// Jenis intervensi yang tersedia pada SOS Craving.
enum JenisIntervensiSos {
  napas_478,
  timer_3_menit,
  distraksi,
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
    }
  }
}
