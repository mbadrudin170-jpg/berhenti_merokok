import 'package:berhenti_merokok/shared/konstanta/organ_pemulihan.dart';

/// Data satu milestone pemulihan kesehatan berdasarkan durasi smoke-free.
class MilestoneKesehatan {
  const MilestoneKesehatan({
    required this.target,
    required this.judul,
    required this.deskripsi,
    required this.organ,
  });

  final Duration target;
  final String judul;
  final String deskripsi;
  final OrganPemulihan organ;
}

/// Daftar milestone pemulihan kesehatan berdasarkan durasi smoke-free.
const List<MilestoneKesehatan> daftarMilestoneKesehatan = [
  MilestoneKesehatan(
    target: Duration(minutes: 20),
    judul: '20 Menit',
    deskripsi:
        'Tekanan darah dan denyut jantung mulai kembali ke tingkat normal.',
    organ: OrganPemulihan.jantung,
  ),
  MilestoneKesehatan(
    target: Duration(hours: 8),
    judul: '8 Jam',
    deskripsi:
        'Kadar karbon monoksida dalam darah turun ke tingkat normal, '
        'oksigen dalam darah meningkat.',
    organ: OrganPemulihan.sirkulasi,
  ),
  MilestoneKesehatan(
    target: Duration(hours: 24),
    judul: '24 Jam',
    deskripsi: 'Risiko serangan jantung mulai menurun.',
    organ: OrganPemulihan.jantung,
  ),
  MilestoneKesehatan(
    target: Duration(hours: 48),
    judul: '48 Jam',
    deskripsi:
        'Ujung saraf mulai tumbuh kembali, indra pengecapan dan '
        'penciuman membaik.',
    organ: OrganPemulihan.saraf,
  ),
  MilestoneKesehatan(
    target: Duration(hours: 72),
    judul: '72 Jam',
    deskripsi:
        'Bronkus rileks, kapasitas paru meningkat, energi tubuh bertambah.',
    organ: OrganPemulihan.paru,
  ),
  MilestoneKesehatan(
    target: Duration(days: 14),
    judul: '2 Minggu',
    deskripsi:
        'Sirkulasi darah membaik, fungsi paru meningkat, berjalan kaki '
        'menjadi lebih mudah.',
    organ: OrganPemulihan.sirkulasi,
  ),
  MilestoneKesehatan(
    target: Duration(days: 90),
    judul: '3 Bulan',
    deskripsi: 'Batuk dan sesak napas berkurang, paru-paru mulai pulih.',
    organ: OrganPemulihan.paru,
  ),
  MilestoneKesehatan(
    target: Duration(days: 270),
    judul: '9 Bulan',
    deskripsi:
        'Paru-paru telah pulih secara signifikan, energi dan stamina '
        'meningkat.',
    organ: OrganPemulihan.paru,
  ),
  MilestoneKesehatan(
    target: Duration(days: 365),
    judul: '1 Tahun',
    deskripsi:
        'Risiko penyakit jantung koroner turun setengah dibanding perokok.',
    organ: OrganPemulihan.jantung,
  ),
  MilestoneKesehatan(
    target: Duration(days: 1825),
    judul: '5 Tahun',
    deskripsi: 'Risiko stroke setara dengan orang yang tidak merokok.',
    organ: OrganPemulihan.sirkulasi,
  ),
  MilestoneKesehatan(
    target: Duration(days: 3650),
    judul: '10 Tahun',
    deskripsi: 'Risiko kanker paru turun setengah dibanding perokok aktif.',
    organ: OrganPemulihan.paru,
  ),
  MilestoneKesehatan(
    target: Duration(days: 5475),
    judul: '15 Tahun',
    deskripsi:
        'Risiko penyakit jantung koroner setara dengan orang yang tidak '
        'merokok.',
    organ: OrganPemulihan.jantung,
  ),
];

/// Mengembalikan milestone berikutnya yang belum tercapai berdasarkan durasi
/// smoke-free. Mengembalikan null jika semua milestone sudah tercapai.
MilestoneKesehatan? milestoneBerikutnya(Duration durasi) {
  for (final m in daftarMilestoneKesehatan) {
    if (durasi < m.target) return m;
  }
  return null;
}
