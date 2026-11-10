import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/helper/konsumsi_hitung_helper.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart';

/// Helper murni metrik berhenti: baseline (estimasi dari biodata) dan aktual
/// (dari catatan konsumsi).
///
/// Tidak bergantung pada `BuildContext` atau provider. Semua perhitungan
/// berbasis tanggal dinormalisasi ke komponen tanggal saja (tahun, bulan,
/// hari) dengan clamp nilai negatif ke nol dan guard pembagian nol.
///
/// Aturan hari tanpa catatan: hari kalender tanpa catatan konsumsi
/// **dikecualikan** dari perhitungan aktual; hari tersebut bukan bukti
/// pengguna tidak merokok. Metrik aktual wajib diberi label
/// "berdasarkan n hari tercatat" di UI.
class MetrikBerhentiHelper {
  const MetrikBerhentiHelper._();

  /// Hari sejak [BiodataModel.tanggalMulaiBerhentiMerokok], dinormalisasi
  /// ke komponen tanggal saja, clamp >= 0.
  ///
  /// Ini metrik **baseline** (kumulatif), bukan berbasis catatan konsumsi.
  static int hitungHariBerhenti(BiodataModel biodata) => biodata.hariBerhenti;

  /// Estimasi rokok yang tidak dihisap selama periode smoke-free.
  ///
  /// Baseline dari biodata (`jumlahRokokPerHari × hariBerhenti`), bukan dari
  /// catatan konsumsi. Beri label "estimasi" di UI.
  static int hitungRokokTidakDiHisapEstimasi(BiodataModel biodata) =>
      biodata.rokokTidakDiHisap;

  /// Estimasi uang yang tidak dibelanjakan selama periode smoke-free.
  ///
  /// Baseline dari biodata. Beri label "estimasi" di UI.
  static double hitungUangDihematEstimasi(BiodataModel biodata) =>
      biodata.uangDihemat;

  /// Rokok yang dihindari secara aktual.
  ///
  /// `Σ max(0, targetRokokHariIni − konsumsi)` per hari yang **punya
  /// catatan**, memakai target tapering (`targetRokokHariIni`) sebagai
  /// pembanding. Hari tanpa catatan dikecualikan.
  static int hitungRokokDihindariAktual(
    BiodataModel biodata,
    List<KonsumsiRokokModel> list,
  ) {
    if (list.isEmpty) return 0;
    final target = biodata.targetRokokHariIni;
    var total = 0;
    for (final jumlah in KonsumsiHitungHelper.ringkasanHarian(list).values) {
      final terhindar = target - jumlah;
      if (terhindar > 0) total += terhindar;
    }
    return total;
  }

  /// Uang yang tidak dibelanjakan secara aktual (dari catatan konsumsi).
  static double hitungUangDihematAktual(
    BiodataModel biodata,
    List<KonsumsiRokokModel> list,
  ) {
    if (biodata.batangPerBungkus == 0) return 0.0;
    final dihindari = hitungRokokDihindariAktual(biodata, list);
    return (dihindari / biodata.batangPerBungkus) *
        biodata.hargaRokokPerBungkus;
  }

  /// Jumlah hari unik yang punya catatan konsumsi (seluruh riwayat).
  static int hitungJumlahHariTercatat(List<KonsumsiRokokModel> list) =>
      KonsumsiHitungHelper.ringkasanHarian(list).length;

  /// Streak pencatatan: hari kalender berturut-turut yang punya catatan
  /// konsumsi, dihitung mundur dari hari ini. Bila hari ini belum punya
  /// catatan, perhitungan dimulai dari kemarin agar streak tidak putus hanya
  /// karena pengguna belum sempat mencatat hari ini. Belum ada catatan → 0.
  static int hitungStreakPencatatan(List<KonsumsiRokokModel> list) {
    final ringkasan = KonsumsiHitungHelper.ringkasanHarian(list);
    if (ringkasan.isEmpty) return 0;
    final sekarang = DateTime.now();
    var kursor = DateTime(sekarang.year, sekarang.month, sekarang.day);
    if (!ringkasan.containsKey(KonsumsiHitungHelper.kunciTanggal(kursor))) {
      kursor = kursor.subtract(const Duration(days: 1));
    }
    var streak = 0;
    while (ringkasan.containsKey(KonsumsiHitungHelper.kunciTanggal(kursor))) {
      streak += 1;
      kursor = kursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  /// Streak: hari kalender berturut-turut tanpa catatan konsumsi/slip sampai
  /// hari ini. Catatan konsumsi (termasuk slip) mereset streak; progres
  /// kumulatif tidak direset. Belum ada catatan → 0 (bukan bukti bebas rokok).
  static int hitungStreak(List<KonsumsiRokokModel> list) {
    DateTime? terakhir;
    for (final m in list) {
      final t = m.tanggal.toLocal();
      final d = DateTime(t.year, t.month, t.day);
      if (terakhir == null || d.isAfter(terakhir)) terakhir = d;
    }
    if (terakhir == null) return 0;

    final sekarang = DateTime.now();
    final hariIni = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final selisih = hariIni.difference(terakhir).inDays;
    return selisih < 0 ? 0 : selisih;
  }

  /// Minggu tapering berjalan untuk [biodata] (mode bertahap), 1-based dan
  /// minimal 1. Bukan mode bertahap atau tanggal mulai kosong → 1.
  ///
  /// Tanggal dinormalisasi ke komponen tanggal saja agar selisih hari tidak
  /// terpengaruh komponen waktu; hasil negatif klamp ke nol.
  static int hitungMingguTaperingBerjalan(BiodataModel biodata) {
    if (!biodata.sedangTapering) return 1;
    final mulai = biodata.tanggalMulaiTapering ?? DateTime.now();
    final sekarang = DateTime.now();
    final mulaiDate = DateTime(mulai.year, mulai.month, mulai.day);
    final sekarangDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final hariBerlalu = sekarangDate.difference(mulaiDate).inDays;
    final mingguBerlalu = hariBerlalu < 0 ? 0 : hariBerlalu ~/ 7;
    return mingguBerlalu + 1;
  }

  /// Target konsumsi rokok untuk minggu ke-[mingguKe] (1-based) mode tapering.
  ///
  /// Memakai formula yang sama dengan getter `targetRokokHariIni`
  /// (`jumlahRokokPerHari - penurunanPerMinggu * (mingguKe - 1)`) dengan
  /// clamp 0..jumlahRokokPerHari. Minggu sebelum tapering dimulai dianggap
  /// minggu pertama.
  static int hitungTargetTaperingMingguKe(BiodataModel biodata, int mingguKe) {
    final penurunan = biodata.penurunanPerMinggu * (mingguKe - 1);
    final target = biodata.jumlahRokokPerHari - penurunan;
    if (target < 0) return 0;
    if (target > biodata.jumlahRokokPerHari) return biodata.jumlahRokokPerHari;
    return target;
  }

  /// Rata-rata konsumsi per hari atas [hari] hari kalender terakhir.
  /// Hari tanpa catatan dihitung 0.
  static double hitungRataRataKalender(
    List<KonsumsiRokokModel> list, {
    int hari = 7,
  }) => KonsumsiHitungHelper.rataRataKalender(list, hari: hari);

  /// Jumlah hari yang punya catatan dalam [hari] hari kalender terakhir.
  static int hitungHariTercatatKalender(
    List<KonsumsiRokokModel> list, {
    int hari = 7,
  }) => KonsumsiHitungHelper.jumlahHariTercatat(list, hari: hari);
}
