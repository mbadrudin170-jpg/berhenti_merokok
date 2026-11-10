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
      final lokal = m.tanggal.toLocal();
      final key =
          '${lokal.year}-${lokal.month.toString().padLeft(2, '0')}-${lokal.day.toString().padLeft(2, '0')}';
      map[key] = (map[key] ?? 0) + m.jumlah;
    }
    return map;
  }

  /// Total seluruh konsumsi batang rokok.
  static int totalKonsumsi(List<KonsumsiRokokModel> list) {
    if (list.isEmpty) return 0;
    return list.fold(0, (sum, m) => sum + m.jumlah);
  }

  /// Rata-rata konsumsi per hari dalam [hari] hari terakhir.
  static double rataRataHarian(List<KonsumsiRokokModel> list, {int hari = 7}) {
    if (list.isEmpty) return 0.0;
    final ringkasan = ringkasanHarian(list);
    final keys = ringkasan.keys.toList()..sort();
    final relevantKeys = keys.take(hari).toList();
    if (relevantKeys.isEmpty) return 0.0;
    final total = relevantKeys.fold(0, (sum, k) => sum + (ringkasan[k] ?? 0));
    return total / relevantKeys.length;
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
  static int konsumsiHariIni(List<KonsumsiRokokModel> list) {
    final hariIni = DateTime.now();
    final key =
        '${hariIni.year}-${hariIni.month.toString().padLeft(2, '0')}-${hariIni.day.toString().padLeft(2, '0')}';
    return ringkasanHarian(list)[key] ?? 0;
  }

  /// Konsumsi pada [tanggal] tertentu berdasarkan waktu lokal.
  static int konsumsiTanggal(List<KonsumsiRokokModel> list, DateTime tanggal) {
    final lokal = tanggal.toLocal();
    final key =
        '${lokal.year}-${lokal.month.toString().padLeft(2, '0')}-${lokal.day.toString().padLeft(2, '0')}';
    return ringkasanHarian(list)[key] ?? 0;
  }
}
