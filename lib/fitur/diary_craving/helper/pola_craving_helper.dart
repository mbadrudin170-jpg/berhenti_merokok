import 'package:berhenti_merokok/fitur/diary_craving/enum/hasil_craving_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/strategi_craving_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/model/diary_craving_model.dart';
import 'package:share_global_saya/core_shared.dart';

/// Helper murni untuk menghitung pola dan wawasan dari data Diary Craving.
class PolaCravingHelper {
  const PolaCravingHelper._();

  /// Jumlah entri minimum sebelum wawasan dapat ditampilkan.
  static const int minimumEntri = 3;

  /// Jumlah entri minimum per strategi sebelum rasio berhasil dihitung.
  static const int minimumEntriStrategi = 3;

  /// Normalisasi [waktu] ke komponen tanggal saja (tahun, bulan, hari).
  static DateTime _tanggalSaja(DateTime waktu) {
    return DateTime(waktu.year, waktu.month, waktu.day);
  }

  /// Menyaring [daftar] menjadi entri yang terjadi dalam [jumlahHari] hari
  /// terakhir (termasuk hari ini). Perbandingan dilakukan pada komponen
  /// tanggal saja.
  static List<DiaryCravingModel> filterNHari(
    List<DiaryCravingModel> daftar,
    int jumlahHari, {
    DateTime? sekarang,
  }) {
    final hariIni = _tanggalSaja(sekarang ?? DateTime.now());
    final batasAwal = hariIni.subtract(Duration(days: jumlahHari - 1));
    L.i('jumlahHari=$jumlahHari, batasAwal=$batasAwal, hariIni=$hariIni');
    return daftar.where((c) {
      final tanggal = _tanggalSaja(c.tanggal);
      return !tanggal.isBefore(batasAwal) && !tanggal.isAfter(hariIni);
    }).toList();
  }

  /// Entri dalam 7 hari terakhir (termasuk hari ini).
  static List<DiaryCravingModel> pola7Hari(
    List<DiaryCravingModel> daftar, {
    DateTime? sekarang,
  }) {
    return filterNHari(daftar, 7, sekarang: sekarang);
  }

  /// Entri dalam 30 hari terakhir (termasuk hari ini).
  static List<DiaryCravingModel> pola30Hari(
    List<DiaryCravingModel> daftar, {
    DateTime? sekarang,
  }) {
    return filterNHari(daftar, 30, sekarang: sekarang);
  }

  /// Rata-rata intensitas dari [daftar], atau `null` bila daftar kosong.
  static double? rataRataIntensitas(List<DiaryCravingModel> daftar) {
    if (daftar.isEmpty) {
      return null;
    }
    final total = daftar.fold<int>(0, (acc, c) => acc + c.intensitas);
    final rataRata = total / daftar.length;
    L.i('daftar.length=${daftar.length}, rataRata=$rataRata');
    return rataRata;
  }

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

  /// Pemicu yang muncul minimal [minimumEntri] kali, diurutkan dari yang
  /// paling sering. Tie-breaker deterministik berdasarkan index enum.
  static List<MapEntry<PemicuEnum, int>> pemicuBerulang(
    List<DiaryCravingModel> daftar, {
    int minimumEntri = minimumEntri,
  }) {
    L.i('daftar.length=${daftar.length}, minimumEntri=$minimumEntri');
    final Map<PemicuEnum, int> freq = {};
    for (final c in daftar) {
      freq[c.pemicu] = (freq[c.pemicu] ?? 0) + 1;
    }

    final hasil = freq.entries
        .where((e) => e.value >= minimumEntri)
        .toList()
      ..sort((a, b) {
        final cmp = b.value.compareTo(a.value);
        if (cmp != 0) return cmp;
        return a.key.index.compareTo(b.key.index);
      });
    L.i('pemicuBerulang=$hasil');
    return hasil;
  }

  /// Strategi dengan rasio `berhasilMenahan` tertinggi, minimal
  /// [minimumEntri] entri per strategi. `null` bila tidak ada strategi
  /// yang memadai.
  static StrategiCravingEnum? strategiPalingMembantu(
    List<DiaryCravingModel> daftar, {
    int minimumEntri = minimumEntriStrategi,
  }) {
    L.i('daftar.length=${daftar.length}, minimumEntri=$minimumEntri');
    final Map<StrategiCravingEnum, List<DiaryCravingModel>> grup = {};
    for (final c in daftar) {
      final s = c.strategi;
      if (s != null) {
        grup.putIfAbsent(s, () => []).add(c);
      }
    }

    StrategiCravingEnum? terbaik;
    var rasioTerbaik = -1.0;
    grup.forEach((s, entries) {
      if (entries.length < minimumEntri) return;
      final sukses = entries
          .where((e) => e.hasil == HasilCravingEnum.berhasilMenahan)
          .length;
      final rasio = sukses / entries.length;
      if (rasio > rasioTerbaik) {
        rasioTerbaik = rasio;
        terbaik = s;
      }
    });

    L.i('strategiPalingMembantu=$terbaik, rasio=$rasioTerbaik');
    return terbaik;
  }
}
