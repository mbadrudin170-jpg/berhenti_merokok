/// Kunci penyimpanan yang digunakan bersama oleh aplikasi.
///
/// Kunci-kunci ini dipakai untuk mengakses nilai pada penyimpanan lokal
/// (misalnya `SharedPreferences`) secara konsisten di seluruh fitur.
class SharedKeys {
  SharedKeys._();

  /// Kunci untuk menyimpan preferensi tema aplikasi.
  static const String tema = 'tema';

  /// Kunci untuk menyimpan preferensi tema visual metafora impian.
  static const String temaVisualImpian = 'tema_visual_impian';

  /// Kunci untuk menyimpan status aktif pengingat harian.
  static const String notifikasiHarian = 'notifikasi_harian';

  /// Kunci untuk menyimpan jam pengingat harian.
  static const String notifikasiJam = 'notifikasi_jam';

  /// Kunci untuk menyimpan menit pengingat harian.
  static const String notifikasiMenit = 'notifikasi_menit';

  /// Kunci untuk menyimpan status aktif check-in pagi.
  static const String notifikasiCheckinPagi = 'notifikasi_checkin_pagi';

  /// Kunci untuk menyimpan jam check-in pagi.
  static const String notifikasiCheckinPagiJam = 'notifikasi_checkin_pagi_jam';

  /// Kunci untuk menyimpan menit check-in pagi.
  static const String notifikasiCheckinPagiMenit = 'notifikasi_checkin_pagi_menit';

  /// Kunci untuk menyimpan status aktif pengingat pola craving.
  static const String notifikasiPolaCraving = 'notifikasi_pola_craving';
}
