import 'package:berhenti_merokok/fitur/diary_craving/model/diary_craving_model.dart';
import 'package:share_global_saya/core_shared.dart';

/// Helper murni untuk menghitung pola jam craving teratas dari data Diary Craving.
class PolaCravingHelper {
  const PolaCravingHelper._();

  /// Jumlah entri minimum sebelum jam teratas dapat ditentukan.
  static const int minimumEntri = 3;

  /// Mengembalikan jam lokal (0-23) yang paling sering muncul dalam [daftar],
  /// atau `null` jika jumlah entri kurang dari [minimumEntri].
  ///
  /// Perhitungan bersifat murni dan hanya membaca data; tidak menulis database.
  static int? jamTeratas(List<DiaryCravingModel> daftar) {
    L.i('daftar.length=${daftar.length}');
    if (daftar.length < minimumEntri) {
      return null;
    }

    final Map<int, int> freq = {};
    for (final c in daftar) {
      final jam = c.tanggal.hour;
      freq[jam] = (freq[jam] ?? 0) + 1;
    }

    int? jamTeratas;
    int jumlahTerbesar = 0;
    freq.forEach((jam, jumlah) {
      if (jumlah > jumlahTerbesar) {
        jumlahTerbesar = jumlah;
        jamTeratas = jam;
      }
    });

    L.i('jamTeratas=$jamTeratas, jumlah=$jumlahTerbesar');
    return jamTeratas;
  }
}
