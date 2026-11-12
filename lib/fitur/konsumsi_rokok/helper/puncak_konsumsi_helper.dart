import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart';
import 'package:share_global_saya/core_shared.dart';

/// Helper murni untuk analisis puncak konsumsi rokok.
///
/// Tidak bergantung pada [BuildContext] atau provider. Semua method
/// memegang guard pada list kosong dan mengembalikan nilai default.
class PuncakKonsumsiHelper {
  const PuncakKonsumsiHelper._();

  /// Jumlah total batang per jam (0-23) berdasarkan waktu lokal.
  static Map<int, int> distribusiJam(List<KonsumsiRokokModel> list) {
    L.i('list.length=${list.length}');
    if (list.isEmpty) return const {};
    final map = <int, int>{};
    for (final m in list) {
      final jam = m.tanggal.toLocal().hour;
      map[jam] = (map[jam] ?? 0) + m.jumlah;
    }
    return map;
  }

  /// Jumlah total batang per hari dalam seminggu (Minggu=0 .. Sabtu=6).
  static Map<int, int> distribusiHari(List<KonsumsiRokokModel> list) {
    L.i('list.length=${list.length}');
    if (list.isEmpty) return const {};
    final map = <int, int>{};
    for (final m in list) {
      final hari = m.tanggal.toLocal().weekday % 7; // Minggu=0, Senin=1, ..., Sabtu=6
      map[hari] = (map[hari] ?? 0) + m.jumlah;
    }
    return map;
  }

  /// Jumlah entri konsumsi per [PemicuEnum] (hanya entri yang punya pemicu).
  static Map<PemicuEnum, int> distribusiPemicu(List<KonsumsiRokokModel> list) {
    L.i('list.length=${list.length}');
    if (list.isEmpty) return const {};
    final map = <PemicuEnum, int>{};
    for (final m in list) {
      if (m.pemicu != null) {
        map[m.pemicu!] = (map[m.pemicu!] ?? 0) + 1;
      }
    }
    return map;
  }

  /// Jumlah hari distinct yang punya catatan konsumsi (berdasarkan waktu lokal).
  static int _jumlahHariTercatat(List<KonsumsiRokokModel> list) {
    final hariSet = <String>{};
    for (final m in list) {
      final lokal = m.tanggal.toLocal();
      hariSet.add(
        '${lokal.year}-${lokal.month.toString().padLeft(2, '0')}-${lokal.day.toString().padLeft(2, '0')}',
      );
    }
    return hariSet.length;
  }

  /// Ringkasan teks analisis puncak untuk ditampilkan di UI.
  ///
  /// Jika data < 7 hari, mengembalikan pesan data tidak cukup.
  static String ringkasanTeks(List<KonsumsiRokokModel> list) {
    if (list.isEmpty) {
      return 'Data belum cukup untuk analisis puncak. Catat konsumsi minimal 7 hari.';
    }
    final jumlahHari = _jumlahHariTercatat(list);
    if (jumlahHari < 7) {
      return 'Data belum cukup untuk analisis puncak. Catat konsumsi minimal 7 hari.';
    }

    final jamDist = distribusiJam(list);
    final hariDist = distribusiHari(list);
    final pemicuDist = distribusiPemicu(list);

    // Jam puncak
    String jamPuncak = '-';
    if (jamDist.isNotEmpty) {
      final jamTertinggi = jamDist.entries.reduce(
        (a, b) => a.value > b.value ? a : b,
      );
      final jam = jamTertinggi.key;
      final rataRata = (jamTertinggi.value / jumlahHari).round();
      jamPuncak =
          '${jam.toString().padLeft(2, '0')}:00–${(jam + 1).toString().padLeft(2, '0')}:00 (rata-rata $rataRata batang/hari)';
    }

    // Hari puncak
    const namaHari = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    String hariPuncak = '-';
    if (hariDist.isNotEmpty) {
      final hariTertinggi = hariDist.entries.reduce(
        (a, b) => a.value > b.value ? a : b,
      );
      final hariIdx = hariTertinggi.key;
      final minggu = (jumlahHari / 7).ceil();
      final rataRata = (hariTertinggi.value / minggu).round();
      hariPuncak = '${namaHari[hariIdx]} (rata-rata $rataRata batang/minggu)';
    }

    // Pemicu paling umum (top 3)
    String pemicuPalingUmum = '-';
    if (pemicuDist.isNotEmpty) {
      final totalPemicu = pemicuDist.values.fold(0, (a, b) => a + b);
      final urutan = pemicuDist.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      final top3 = urutan.take(3).map((e) {
        final pct = (e.value / totalPemicu * 100).round();
        return '${e.key.label} ($pct%)';
      }).join(', ');
      pemicuPalingUmum = top3;
    }

    return 'Jam puncak: $jamPuncak\nHari puncak: $hariPuncak\nPemicu paling umum: $pemicuPalingUmum';
  }
}
