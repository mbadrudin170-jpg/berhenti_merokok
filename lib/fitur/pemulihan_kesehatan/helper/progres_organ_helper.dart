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
}
