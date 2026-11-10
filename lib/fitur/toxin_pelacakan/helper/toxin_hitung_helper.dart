import 'package:berhenti_merokok/fitur/toxin_pelacakan/model/toxin_model.dart';
import 'package:share_global_saya/core_shared.dart';

/// Helper murni untuk perhitungan kuantitas toxin yang dihindari tubuh.
///
/// Tidak bergantung pada [BuildContext] atau provider. Semua data referensi
/// bersifat statis dan ilustratif dengan catatan sumber umum (WHO / CDC /
/// AHA / ACS sebagai landasan referensi, bukan klaim medis aplikasi).
class ToxinHitungHelper {
  const ToxinHitungHelper._();

  /// Daftar referensi toxin statis. Faktor per batang adalah perkiraan
  /// ilustratif untuk tujuan visualisasi progres, bukan data klinis.
  static const List<ToxinModel> _daftarReferensi = <ToxinModel>[
    ToxinModel(
      nama: 'Tar',
      jenisZat: 'Zat terpangkal',
      faktorPerBatang: 12.0,
      efekSingkat: 'Menyumbat paru-paru dan mengganggu pertukaran oksigen.',
      sumberReferensi: 'WHO / CDC / AHA / ACS',
    ),
    ToxinModel(
      nama: 'Nikotin',
      jenisZat: 'Zat adiktif',
      faktorPerBatang: 1.2,
      efekSingkat: 'Mendorong ketergantungan dan meningkatkan detak jantung.',
      sumberReferensi: 'WHO / CDC / AHA / ACS',
    ),
    ToxinModel(
      nama: 'Karbon Monoksida',
      jenisZat: 'Gas beracun',
      faktorPerBatang: 18.0,
      efekSingkat: 'Menggantikan oksigen pada hemoglobin darah.',
      sumberReferensi: 'WHO / CDC / AHA / ACS',
    ),
    ToxinModel(
      nama: 'Formaldehida',
      jenisZat: 'Zat kimia industri',
      faktorPerBatang: 0.08,
      efekSingkat: 'Mengiritasi mata, hidung, dan tenggorokan.',
      sumberReferensi: 'WHO / CDC / AHA / ACS',
    ),
    ToxinModel(
      nama: 'Bensen',
      jenisZat: 'Zat karsinogen',
      faktorPerBatang: 0.15,
      efekSingkat: 'Berisiko merusak sumsum darah dan sistem imun.',
      sumberReferensi: 'WHO / CDC / AHA / ACS',
    ),
    ToxinModel(
      nama: 'Ammonia',
      jenisZat: 'Zat penguat nikotin',
      faktorPerBatang: 0.5,
      efekSingkat: 'Mempercepat penyerapan nikotin di paru-paru.',
      sumberReferensi: 'WHO / CDC / AHA / ACS',
    ),
    ToxinModel(
      nama: 'Arsen',
      jenisZat: 'Zat beracun berat',
      faktorPerBatang: 0.02,
      efekSingkat: 'Beracuk bagi jantung, paru-paru, dan kulit.',
      sumberReferensi: 'WHO / CDC / AHA / ACS',
    ),
  ];

  /// Menghitung daftar toxin yang dihindari berdasarkan jumlah rokok
  /// yang tidak dihisap.
  ///
  /// Mengembalikan list kosong jika [rokokTidakDiHisap] nol atau negatif
  /// (guard pembagian/nol dan nilai valid).
  static List<ToxinModel> hitung(int rokokTidakDiHisap) {
    L.i('rokokTidakDiHisap=$rokokTidakDiHisap');
    if (rokokTidakDiHisap <= 0) {
      return const [];
    }
    return _daftarReferensi.map((t) {
      return t.copyWith(
        kuantitasDiHindari: t.faktorPerBatang * rokokTidakDiHisap,
      );
    }).toList();
  }
}
