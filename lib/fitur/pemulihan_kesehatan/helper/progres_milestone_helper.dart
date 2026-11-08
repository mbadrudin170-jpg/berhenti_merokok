/// Helper murni untuk perhitungan progres milestone pemulihan kesehatan.
///
/// Tidak bergantung pada [BuildContext] atau provider. Digunakan oleh layar
/// Pemulihan Kesehatan untuk menampilkan progres per milestone.
class ProgresMilestoneHelper {
  const ProgresMilestoneHelper._();

  /// Mengembalikan rasio progres durasi smoke-free terhadap [target] milestone.
  ///
  /// Nilai diklem ke rentang 0.0–1.0. Jika [target] bernilai nol detik atau
  /// lebih kecil, mengembalikan 1.0 (milestone dianggap tercapai). Durasi
  /// negatif diperlakukan sebagai nol.
  static double rasio(Duration durasi, Duration target) {
    if (target.inSeconds <= 0) return 1.0;
    final detikDurasi = durasi.isNegative ? 0 : durasi.inSeconds;
    final nilai = detikDurasi / target.inSeconds;
    return nilai.clamp(0.0, 1.0);
  }

  /// Mengembalikan persentase progres (0–100) yang dibulatkan ke bilangan bulat.
  static int persentase(Duration durasi, Duration target) {
    return (rasio(durasi, target) * 100).round().clamp(0, 100);
  }

  /// Mengembalikan `true` jika [durasi] sudah mencapai atau melampaui [target].
  static bool tercapai(Duration durasi, Duration target) {
    if (target.inSeconds <= 0) return true;
    final aman = durasi.isNegative ? Duration.zero : durasi;
    return aman >= target;
  }

  /// Mengembalikan sisa durasi menuju [target].
  ///
  /// Jika sudah tercapai atau sisa negatif, mengembalikan [Duration.zero].
  static Duration sisaWaktu(Duration durasi, Duration target) {
    final aman = durasi.isNegative ? Duration.zero : durasi;
    final sisa = target - aman;
    return sisa.isNegative ? Duration.zero : sisa;
  }
}
