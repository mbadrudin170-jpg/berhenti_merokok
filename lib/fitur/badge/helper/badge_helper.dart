import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Representasi satu badge/pencapaian pengguna.
class BadgePencapaian {
  const BadgePencapaian({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.icon,
    required this.tercapai,
  });

  final String id;
  final String nama;
  final String deskripsi;
  final IconData icon;
  final bool tercapai;
}

/// Nama key SharedPreferences untuk badge yang pernah tercapai.
///
/// Badge yang pernah tercapai **tidak pernah dicoret** dari pencapaian
/// pengguna hanya karena slip berikutnya; nilainya digabungkan kembali saat
/// daftar badge dihitung.
const String keyBadgeTercapaiHistoris = 'badge_tercapai_historis';

/// Menghitung daftar badge berdasarkan progres smoke-free pengguna.
///
/// Metrik **durasi** ([hariSmokeFree]) memakai baseline kumulatif dan tidak
/// direset slip. Metrik **rokok/uang** memakai aktual dari catatan konsumsi
/// ([rokokDihindariAktual]/[uangDihematAktual]) bila ada hari tercatat
/// ([hariTercatat] > 0), fallback ke baseline
/// ([rokokTidakDiHisapEstimasi]/[uangDihematEstimasi]) bila belum ada;
/// labelnya tercermin pada deskripsi badge ("dari catatan" / "estimasi").
///
/// Badge yang pernah tercapai tidak hilang dari daftar pencapaian, meskipun
/// metrik aktual turun karena slip berikutnya: [badgeTercapaiHistoris]
/// berisi id badge yang pernah tercapai (disimpan di SharedPreferences) dan
/// digabungkan ke status `tercapai` badge yang bersangkutan.
///
/// Badge baru bersifat **additif dan non-pemalukan**: streak bebas rokok
/// ([streakHariIni]), konsistensi pencatatan ([streakPencatatan]), dan
/// target tapering per minggu ([taperingTercapai]). Tidak ada badge
/// "gagal", "slip", atau "kembali ke nol".
///
/// [taperingTercapai] berisi 4 bool; elemen ke-`i` menyatakan tercapainya
/// target tapering minggu ke-`i + 1` (sudah melewati/berjalan di minggu
/// tersebut dan konsumsi hari ini ≤ target minggu tersebut).
List<BadgePencapaian> hitungBadge({
  required int hariSmokeFree,
  required int rokokDihindariAktual,
  required int rokokTidakDiHisapEstimasi,
  required double uangDihematAktual,
  required double uangDihematEstimasi,
  required int impianTercapai,
  required int streakHariIni,
  required int streakPencatatan,
  required int hariTercatat,
  required bool sedangTapering,
  required List<bool> taperingTercapai,
  Set<String> badgeTercapaiHistoris = const <String>{},
}) {
  final pakaiAktual = hariTercatat > 0;
  final rokokUntukBadge = pakaiAktual
      ? rokokDihindariAktual
      : rokokTidakDiHisapEstimasi;
  final uangUntukBadge = pakaiAktual ? uangDihematAktual : uangDihematEstimasi;
  final labelRokok = pakaiAktual ? 'dari catatan' : 'estimasi';
  final labelUang = pakaiAktual ? 'dari catatan' : 'estimasi';

  BadgePencapaian badge({
    required String id,
    required String nama,
    required String deskripsi,
    required IconData icon,
    required bool tercapai,
  }) {
    return BadgePencapaian(
      id: id,
      nama: nama,
      deskripsi: deskripsi,
      icon: icon,
      tercapai: tercapai || badgeTercapaiHistoris.contains(id),
    );
  }

  final List<BadgePencapaian> daftar = <BadgePencapaian>[
    // Badge berbasis durasi smoke-free (baseline kumulatif, tidak direset slip).
    badge(
      id: 'smoke_1',
      nama: 'Langkah Pertama',
      deskripsi: 'Berhasil berhenti merokok selama 1 hari.',
      icon: CupertinoIcons.flame,
      tercapai: hariSmokeFree >= 1,
    ),
    badge(
      id: 'smoke_3',
      nama: '3 Hari Kuat',
      deskripsi: 'Berhasil berhenti merokok selama 3 hari.',
      icon: CupertinoIcons.flame_fill,
      tercapai: hariSmokeFree >= 3,
    ),
    badge(
      id: 'smoke_7',
      nama: 'Satu Minggu',
      deskripsi: 'Berhasil berhenti merokok selama 7 hari.',
      icon: CupertinoIcons.star,
      tercapai: hariSmokeFree >= 7,
    ),
    badge(
      id: 'smoke_14',
      nama: 'Dua Minggu',
      deskripsi: 'Berhasil berhenti merokok selama 14 hari.',
      icon: CupertinoIcons.star_fill,
      tercapai: hariSmokeFree >= 14,
    ),
    badge(
      id: 'smoke_30',
      nama: 'Satu Bulan',
      deskripsi: 'Berhasil berhenti merokok selama 30 hari.',
      icon: Icons.workspace_premium,
      tercapai: hariSmokeFree >= 30,
    ),
    badge(
      id: 'smoke_90',
      nama: 'Tiga Bulan',
      deskripsi: 'Berhasil berhenti merokok selama 90 hari.',
      icon: CupertinoIcons.rosette,
      tercapai: hariSmokeFree >= 90,
    ),
    badge(
      id: 'smoke_180',
      nama: 'Enam Bulan',
      deskripsi: 'Berhasil berhenti merokok selama 180 hari.',
      icon: CupertinoIcons.rosette,
      tercapai: hariSmokeFree >= 180,
    ),
    badge(
      id: 'smoke_365',
      nama: 'Satu Tahun',
      deskripsi: 'Berhasil berhenti merokok selama 1 tahun.',
      icon: Icons.emoji_events,
      tercapai: hariSmokeFree >= 365,
    ),
    // Badge berbasis rokok terhindar (aktual bila ada catatan, fallback estimasi).
    badge(
      id: 'rokok_100',
      nama: '100 Batang Terhindar',
      deskripsi: 'Berhasil menghindari 100 batang rokok ($labelRokok).',
      icon: CupertinoIcons.nosign,
      tercapai: rokokUntukBadge >= 100,
    ),
    badge(
      id: 'rokok_500',
      nama: '500 Batang Terhindar',
      deskripsi: 'Berhasil menghindari 500 batang rokok ($labelRokok).',
      icon: CupertinoIcons.nosign,
      tercapai: rokokUntukBadge >= 500,
    ),
    badge(
      id: 'rokok_1000',
      nama: '1000 Batang Terhindar',
      deskripsi: 'Berhasil menghindari 1000 batang rokok ($labelRokok).',
      icon: CupertinoIcons.shield,
      tercapai: rokokUntukBadge >= 1000,
    ),
    // Badge berbasis uang dihemat (aktual bila ada catatan, fallback estimasi).
    badge(
      id: 'uang_100k',
      nama: 'Tabungan 100 Ribu',
      deskripsi: 'Berhasil menghemat Rp100.000 ($labelUang).',
      icon: CupertinoIcons.money_dollar,
      tercapai: uangUntukBadge >= 100000,
    ),
    badge(
      id: 'uang_500k',
      nama: 'Tabungan 500 Ribu',
      deskripsi: 'Berhasil menghemat Rp500.000 ($labelUang).',
      icon: CupertinoIcons.money_dollar,
      tercapai: uangUntukBadge >= 500000,
    ),
    badge(
      id: 'uang_1jt',
      nama: 'Tabungan 1 Juta',
      deskripsi: 'Berhasil menghemat Rp1.000.000 ($labelUang).',
      icon: CupertinoIcons.money_dollar_circle,
      tercapai: uangUntukBadge >= 1000000,
    ),
    // Badge berbasis impian tercapai.
    badge(
      id: 'impian_1',
      nama: 'Impian Pertama Tercapai',
      deskripsi: 'Berhasil mencapai 1 impian.',
      icon: CupertinoIcons.heart,
      tercapai: impianTercapai >= 1,
    ),
    badge(
      id: 'impian_3',
      nama: '3 Impian Tercapai',
      deskripsi: 'Berhasil mencapai 3 impian.',
      icon: CupertinoIcons.heart_fill,
      tercapai: impianTercapai >= 3,
    ),
    // BARU: Badge streak bebas rokok (dari catatan, reset saat slip).
    badge(
      id: 'streak_7',
      nama: 'Streak 7 Hari',
      deskripsi: '7 hari berturut-turut tanpa rokok (dari catatan).',
      icon: CupertinoIcons.flame_fill,
      tercapai: streakHariIni >= 7,
    ),
    badge(
      id: 'streak_30',
      nama: 'Streak 30 Hari',
      deskripsi: '30 hari berturut-turut tanpa rokok (dari catatan).',
      icon: CupertinoIcons.star_fill,
      tercapai: streakHariIni >= 30,
    ),
    badge(
      id: 'streak_90',
      nama: 'Streak 90 Hari',
      deskripsi: '90 hari berturut-turut tanpa rokok (dari catatan).',
      icon: CupertinoIcons.rosette,
      tercapai: streakHariIni >= 90,
    ),
    // BARU: Badge konsistensi pencatatan (menghargai kebiasaan mencatat).
    badge(
      id: 'catat_7',
      nama: 'Pencatat 7 Hari',
      deskripsi: 'Mencatat konsumsi 7 hari berturut-turut.',
      icon: CupertinoIcons.doc_on_clipboard,
      tercapai: streakPencatatan >= 7,
    ),
    badge(
      id: 'catat_30',
      nama: 'Pencatat 30 Hari',
      deskripsi: 'Mencatat konsumsi 30 hari berturut-turut.',
      icon: CupertinoIcons.doc_on_clipboard,
      tercapai: streakPencatatan >= 30,
    ),
    badge(
      id: 'catat_90',
      nama: 'Pencatat 90 Hari',
      deskripsi: 'Mencatat konsumsi 90 hari berturut-turut.',
      icon: CupertinoIcons.doc_on_clipboard_fill,
      tercapai: streakPencatatan >= 90,
    ),
    // BARU: Badge target tapering tercapai (additif, hanya mode bertahap;
    // tetap ditampilkan bila pernah tercapai agar historis tidak hilang).
    if (sedangTapering ||
        _adaBadgeTaperingHistoris(badgeTercapaiHistoris)) ...<BadgePencapaian>[
      badge(
        id: 'tapering_1',
        nama: 'Target Minggu 1 Tercapai',
        deskripsi: 'Konsumsi hari ini ≤ target tapering minggu pertama.',
        icon: CupertinoIcons.arrow_down_circle,
        tercapai: _taperingTercapaiKe(taperingTercapai, 0),
      ),
      badge(
        id: 'tapering_2',
        nama: 'Target Minggu 2 Tercapai',
        deskripsi: 'Konsumsi hari ini ≤ target tapering minggu kedua.',
        icon: CupertinoIcons.arrow_down_circle,
        tercapai: _taperingTercapaiKe(taperingTercapai, 1),
      ),
      badge(
        id: 'tapering_3',
        nama: 'Target Minggu 3 Tercapai',
        deskripsi: 'Konsumsi hari ini ≤ target tapering minggu ketiga.',
        icon: CupertinoIcons.arrow_down_circle,
        tercapai: _taperingTercapaiKe(taperingTercapai, 2),
      ),
      badge(
        id: 'tapering_4',
        nama: 'Target Minggu 4 Tercapai',
        deskripsi: 'Konsumsi hari ini ≤ target tapering minggu keempat.',
        icon: CupertinoIcons.arrow_down_circle_fill,
        tercapai: _taperingTercapaiKe(taperingTercapai, 3),
      ),
    ],
  ];
  return daftar;
}

/// Mengambil status tercapai target tapering minggu ke-[index] (0-based)
/// dari [taperingTercapai]. Indeks di luar daftar → false.
bool _taperingTercapaiKe(List<bool> taperingTercapai, int index) =>
    index >= 0 && index < taperingTercapai.length && taperingTercapai[index];

/// Apakah ada badge tapering ('tapering_1'..'tapering_4') yang pernah
/// tercapai dan tersimpan di [badgeTercapaiHistoris].
bool _adaBadgeTaperingHistoris(Set<String> badgeTercapaiHistoris) =>
    badgeTercapaiHistoris.any((id) => id.startsWith('tapering_'));
