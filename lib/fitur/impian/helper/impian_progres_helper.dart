/// Helper murni untuk perhitungan progres impian.
/// Tanpa ketergantungan pada BuildContext atau provider.
class ImpianProgresHelper {
  const ImpianProgresHelper._();

  /// Menghitung rasio progres (0.0 - 1.0).
  static double rasio(double saldo, double target) {
    if (target <= 0) return 0.0;
    return (saldo / target).clamp(0.0, 1.0);
  }

  /// Menghitung sisa dana untuk mencapai target.
  static double sisa(double saldo, double target) {
    final nilai = target - saldo;
    return nilai < 0 ? 0.0 : nilai;
  }

  /// Mengecek apakah impian sudah tercapai.
  static bool tercapai(double saldo, double target) {
    if (target <= 0) return false;
    return saldo >= target;
  }
}
