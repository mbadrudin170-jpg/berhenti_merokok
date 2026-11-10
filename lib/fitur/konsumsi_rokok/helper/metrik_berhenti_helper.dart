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
