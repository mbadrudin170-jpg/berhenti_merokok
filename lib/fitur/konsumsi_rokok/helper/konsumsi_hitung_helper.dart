import 'package:berhenti_merokok/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart';
import 'package:share_global_saya/core_shared.dart';

/// Helper murni untuk perhitungan turunan konsumsi rokok.
///
/// Tidak bergantung pada [BuildContext] atau provider. Semua method
/// memegang guard pada list kosong dan mengembalikan nilai default.
class KonsumsiHitungHelper {
  const KonsumsiHitungHelper._();

  /// Mengelompokkan konsumsi per hari (key `yyyy-MM-dd`, waktu lokal).
  static Map<String, int> ringkasanHarian(List<KonsumsiRokokModel> list) {
    L.i('list.length=${list.length}');
    if (list.isEmpty) return const {};
    final map = <String, int>{};
    for (final m in list) {
      final key = _kunciTanggal(m.tanggal);
      map[key] = (map[key] ?? 0) + m.jumlah;
    }
    return map;
  }

  /// Kunci tanggal `yyyy-MM-dd` dari [tanggal] (waktu lokal).
  static String _kunciTanggal(DateTime tanggal) {
    final lokal = tanggal.toLocal();
    return '${lokal.year}-${lokal.month.toString().padLeft(2, '0')}-${lokal.day.toString().padLeft(2, '0')}';
  }

  /// Total seluruh konsumsi batang rokok.
  static int totalKonsumsi(List<KonsumsiRokokModel> list) {
    if (list.isEmpty) return 0;
    return list.fold(0, (sum, m) => sum + m.jumlah);
  }

  /// Rata-rata konsumsi per hari atas [hari] hari kalender terakhir.
  ///
  /// Hari tanpa catatan dihitung 0. Ini menggantikan perhitungan lama yang
  /// hanya merata-ratakan hari yang punya catatan.
  static double rataRataHarian(List<KonsumsiRokokModel> list, {int hari = 7}) =>
      rataRataKalender(list, hari: hari);

  /// Rata-rata konsumsi per hari atas [hari] hari kalender terakhir.
  ///
  /// Hari tanpa catatan dihitung 0. Mengembalikan 0.0 bila [hari] <= 0.
  static double rataRataKalender(
    List<KonsumsiRokokModel> list, {
    int hari = 7,
  }) {
    if (hari <= 0) return 0.0;
    final ringkasan = ringkasanHarian(list);
    final now = DateTime.now();
    final hariIni = DateTime(now.year, now.month, now.day);
    var total = 0;
    for (var i = 0; i < hari; i++) {
      final d = hariIni.subtract(Duration(days: i));
      total += ringkasan[_kunciTanggal(d)] ?? 0;
    }
    return total / hari;
  }

  /// Jumlah hari yang punya catatan dalam [hari] hari kalender terakhir.
  /// Mengembalikan 0 bila [hari] <= 0.
  static int jumlahHariTercatat(List<KonsumsiRokokModel> list, {int hari = 7}) {
    if (hari <= 0) return 0;
    final ringkasan = ringkasanHarian(list);
    final now = DateTime.now();
    final hariIni = DateTime(now.year, now.month, now.day);
    var jumlah = 0;
    for (var i = 0; i < hari; i++) {
      final d = hariIni.subtract(Duration(days: i));
      if (ringkasan.containsKey(_kunciTanggal(d))) jumlah += 1;
    }
    return jumlah;
  }

  /// Rentang UTC hari ini untuk query langsung ke database.
  static Map<String, Object?> rangeHariIniUtc() {
    final hariIni = DateTime.now();
    final awalHari = DateTime(hariIni.year, hariIni.month, hariIni.day).toUtc();
    final akhirHari = awalHari.add(const Duration(days: 1));
    return {
      'awal': awalHari.toIso8601String(),
      'akhir': akhirHari.toIso8601String(),
    };
  }

  /// Konsumsi hari ini berdasarkan waktu lokal perangkat.
  static int konsumsiHariIni(List<KonsumsiRokokModel> list) =>
      ringkasanHarian(list)[_kunciTanggal(DateTime.now())] ?? 0;

  /// Konsumsi pada [tanggal] tertentu berdasarkan waktu lokal.
  static int konsumsiTanggal(List<KonsumsiRokokModel> list, DateTime tanggal) =>
      ringkasanHarian(list)[_kunciTanggal(tanggal)] ?? 0;
}
