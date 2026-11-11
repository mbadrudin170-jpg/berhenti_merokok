import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/helper/konsumsi_hitung_helper.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart';

/// Entri riwayat penghematan per hari (aktual dari catatan konsumsi).
class RiwayatTabunganEntry {
  const RiwayatTabunganEntry({
    required this.tanggal,
    required this.rokokDihindari,
    required this.nilai,
    required this.saldoSetelah,
  });

  /// Tanggal hari tersebut (komponen tanggal saja, waktu lokal).
  final DateTime tanggal;

  /// Jumlah rokok yang dihindari hari itu (clamp minimal 0).
  final int rokokDihindari;

  /// Nilai uang yang dihemat hari itu (rupiah).
  final double nilai;

  /// Saldo kumulatif dari hari terlama hingga hari entri ini (rupiah).
  final double saldoSetelah;
}

/// Helper murni untuk riwayat penghematan tabungan impian.
///
/// Tidak bergantung pada `BuildContext` atau provider. Rumus per hari
/// konsisten dengan `MetrikBerhentiHelper.hitungUangDihematAktual`:
/// `terhindar = max(0, targetRokokHariIni − konsumsiHarian)` dan
/// `nilai = terhindar / batangPerBungkus × hargaRokokPerBungkus`.
class RiwayatTabunganHelper {
  const RiwayatTabunganHelper._();

  /// Riwayat penghematan per hari yang **punya catatan** konsumsi,
  /// diurutkan dari tanggal terbaru dahulu.
  ///
  /// Hari tanpa catatan dikecualikan (bukan bukti pengguna tidak merokok).
  /// Mengembalikan daftar kosong bila tidak ada catatan atau
  /// `batangPerBungkus <= 0`.
  static List<RiwayatTabunganEntry> dariKonsumsi(
    BiodataModel biodata,
    List<KonsumsiRokokModel> list,
  ) {
    if (biodata.batangPerBungkus <= 0) return const [];
    final ringkasan = KonsumsiHitungHelper.ringkasanHarian(list);
    if (ringkasan.isEmpty) return const [];
    final target = biodata.targetRokokHariIni;
    final entriAscending = <RiwayatTabunganEntry>[];
    var saldo = 0.0;
    final kunciUrut = ringkasan.keys.toList()..sort();
    for (final kunci in kunciUrut) {
      final bagian = kunci.split('-');
      if (bagian.length != 3) continue;
      final tahun = int.tryParse(bagian[0]);
      final bulan = int.tryParse(bagian[1]);
      final hari = int.tryParse(bagian[2]);
      if (tahun == null || bulan == null || hari == null) continue;
      final terhindar = target - (ringkasan[kunci] ?? 0);
      final rokokDihindari = terhindar > 0 ? terhindar : 0;
      final nilai =
          (rokokDihindari / biodata.batangPerBungkus) *
          biodata.hargaRokokPerBungkus;
      saldo += nilai;
      entriAscending.add(
        RiwayatTabunganEntry(
          tanggal: DateTime(tahun, bulan, hari),
          rokokDihindari: rokokDihindari,
          nilai: nilai,
          saldoSetelah: saldo,
        ),
      );
    }
    return entriAscending.reversed.toList();
  }
}
