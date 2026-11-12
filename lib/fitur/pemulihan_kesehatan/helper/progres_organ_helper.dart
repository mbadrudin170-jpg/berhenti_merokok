import 'package:berhenti_merokok/fitur/pemulihan_kesehatan/helper/progres_milestone_helper.dart';
import 'package:berhenti_merokok/shared/konstanta/milestone_kesehatan.dart';
import 'package:berhenti_merokok/shared/konstanta/organ_pemulihan.dart';

/// Helper murni untuk agregasi status pemulihan per organ.
///
/// Tidak bergantung pada [BuildContext] atau provider. Digunakan oleh layar
/// Pemulihan Kesehatan dan halaman detail organ untuk menampilkan ringkasan
/// per organ berdasarkan durasi smoke-free.
class ProgresOrganHelper {
  const ProgresOrganHelper._();

  /// Mengembalikan seluruh milestone milik [organ], urut kronologis.
  static List<MilestoneKesehatan> milestoneOrgan(OrganPemulihan organ) {
    return daftarMilestoneKesehatan.where((m) => m.organ == organ).toList();
  }

  /// Mengembalikan rasio pemulihan organ (0.0–1.0) berdasarkan milestone
  /// terakhir organ tersebut. Durasi negatif diperlakukan sebagai nol.
  static double rasioOrgan(Duration durasi, OrganPemulihan organ) {
    final list = milestoneOrgan(organ);
    if (list.isEmpty) return 0.0;
    final aman = durasi.isNegative ? Duration.zero : durasi;
    return ProgresMilestoneHelper.rasio(aman, list.last.target);
  }

  /// Mengembalikan persentase pemulihan organ (0–100) dibulatkan.
  static int persentaseOrgan(Duration durasi, OrganPemulihan organ) {
    return (rasioOrgan(durasi, organ) * 100).round().clamp(0, 100);
  }

  /// Mengembalikan `true` jika seluruh milestone [organ] tercapai.
  static bool organSelesai(Duration durasi, OrganPemulihan organ) {
    final list = milestoneOrgan(organ);
    if (list.isEmpty) return false;
    final aman = durasi.isNegative ? Duration.zero : durasi;
    return list.every((m) => aman >= m.target);
  }

  /// Mengembalikan milestone [organ] pertama yang belum tercapai, atau null
  /// jika seluruhnya sudah tercapai.
  static MilestoneKesehatan? milestoneBerikutnyaOrgan(
    Duration durasi,
    OrganPemulihan organ,
  ) {
    final aman = durasi.isNegative ? Duration.zero : durasi;
    for (final m in milestoneOrgan(organ)) {
      if (aman < m.target) return m;
    }
    return null;
  }

  /// Mengembalikan ringkasan status organ:
  /// `"Selesai"`, `"Berjalan"`, atau `"Belum dimulai"`.
  static String ringkasanStatus(Duration durasi, OrganPemulihan organ) {
    if (organSelesai(durasi, organ)) return 'Selesai';
    final list = milestoneOrgan(organ);
    if (list.isEmpty) return 'Belum dimulai';
    final aman = durasi.isNegative ? Duration.zero : durasi;
    if (aman < list.first.target) return 'Belum dimulai';
    return 'Berjalan';
  }

  /// Mengembalikan format durasi lengkap (mis. `2 hari 4 jam 30 menit`).
  static String formatDurasi(Duration d) {
    if (d.inDays > 0) {
      final hari = d.inDays;
      final jam = d.inHours % 24;
      final menit = d.inMinutes % 60;
      final bagian = <String>['$hari hari'];
      if (jam > 0) bagian.add('$jam jam');
      if (menit > 0) bagian.add('$menit menit');
      return bagian.join(' ');
    }
    if (d.inHours > 0) {
      final jam = d.inHours;
      final menit = d.inMinutes % 60;
      final detik = d.inSeconds % 60;
      final bagian = <String>['$jam jam'];
      if (menit > 0) bagian.add('$menit menit');
      bagian.add('$detik detik');
      return bagian.join(' ');
    }
    final menit = d.inMinutes;
    final detik = d.inSeconds % 60;
    if (menit > 0) return '$menit menit $detik detik';
    return '$detik detik';
  }

  /// Mengembalikan format singkat durasi target milestone (mis. `1 minggu`,
  /// `3 bulan`, `1 tahun`).
  static String formatTarget(Duration d) {
    if (d.inDays >= 365) {
      final tahun = (d.inDays / 365).round();
      if (tahun == 1) return '1 tahun';
      return '$tahun tahun';
    }
    if (d.inDays >= 30) {
      final bulan = (d.inDays / 30).round();
      if (bulan == 1) return '1 bulan';
      return '$bulan bulan';
    }
    if (d.inDays >= 7) {
      final minggu = (d.inDays / 7).round();
      if (minggu == 1) return '1 minggu';
      return '$minggu minggu';
    }
    if (d.inDays >= 1) {
      if (d.inDays == 1) return '1 hari';
      return '${d.inDays} hari';
    }
    if (d.inHours >= 1) {
      if (d.inHours == 1) return '1 jam';
      return '${d.inHours} jam';
    }
    return '${d.inMinutes} menit';
  }
}
