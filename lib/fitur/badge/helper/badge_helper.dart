import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_global_saya/core_shared.dart';

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

/// Menghitung daftar badge berdasarkan progres smoke-free pengguna.
List<BadgePencapaian> hitungBadge({
  required int hariSmokeFree,
  required int rokokTidakDiHisap,
  required double uangDihemat,
  required int impianTercapai,
}) {
  L.i(
    'hariSmokeFree=$hariSmokeFree, rokokTidakDiHisap=$rokokTidakDiHisap, uangDihemat=$uangDihemat, impianTercapai=$impianTercapai',
  );
  final List<BadgePencapaian> daftar = <BadgePencapaian>[
    // Badge berbasis durasi smoke-free.
    BadgePencapaian(
      id: 'smoke_1',
      nama: 'Langkah Pertama',
      deskripsi: 'Berhasil berhenti merokok selama 1 hari.',
      icon: CupertinoIcons.flame,
      tercapai: hariSmokeFree >= 1,
    ),
    BadgePencapaian(
      id: 'smoke_3',
      nama: '3 Hari Kuat',
      deskripsi: 'Berhasil berhenti merokok selama 3 hari.',
      icon: CupertinoIcons.flame_fill,
      tercapai: hariSmokeFree >= 3,
    ),
    BadgePencapaian(
      id: 'smoke_7',
      nama: 'Satu Minggu',
      deskripsi: 'Berhasil berhenti merokok selama 7 hari.',
      icon: CupertinoIcons.star,
      tercapai: hariSmokeFree >= 7,
    ),
    BadgePencapaian(
      id: 'smoke_14',
      nama: 'Dua Minggu',
      deskripsi: 'Berhasil berhenti merokok selama 14 hari.',
      icon: CupertinoIcons.star_fill,
      tercapai: hariSmokeFree >= 14,
    ),
    BadgePencapaian(
      id: 'smoke_30',
      nama: 'Satu Bulan',
      deskripsi: 'Berhasil berhenti merokok selama 30 hari.',
      icon: Icons.workspace_premium,
      tercapai: hariSmokeFree >= 30,
    ),
    BadgePencapaian(
      id: 'smoke_90',
      nama: 'Tiga Bulan',
      deskripsi: 'Berhasil berhenti merokok selama 90 hari.',
      icon: CupertinoIcons.rosette,
      tercapai: hariSmokeFree >= 90,
    ),
    BadgePencapaian(
      id: 'smoke_180',
      nama: 'Enam Bulan',
      deskripsi: 'Berhasil berhenti merokok selama 180 hari.',
      icon: CupertinoIcons.rosette,
      tercapai: hariSmokeFree >= 180,
    ),
    BadgePencapaian(
      id: 'smoke_365',
      nama: 'Satu Tahun',
      deskripsi: 'Berhasil berhenti merokok selama 1 tahun.',
      icon: Icons.emoji_events,
      tercapai: hariSmokeFree >= 365,
    ),
    // Badge berbasis rokok tidak dihisap.
    BadgePencapaian(
      id: 'rokok_100',
      nama: '100 Batang Terhindar',
      deskripsi: 'Berhasil menghindari 100 batang rokok.',
      icon: CupertinoIcons.nosign,
      tercapai: rokokTidakDiHisap >= 100,
    ),
    BadgePencapaian(
      id: 'rokok_500',
      nama: '500 Batang Terhindar',
      deskripsi: 'Berhasil menghindari 500 batang rokok.',
      icon: CupertinoIcons.nosign,
      tercapai: rokokTidakDiHisap >= 500,
    ),
    BadgePencapaian(
      id: 'rokok_1000',
      nama: '1000 Batang Terhindar',
      deskripsi: 'Berhasil menghindari 1000 batang rokok.',
      icon: CupertinoIcons.shield,
      tercapai: rokokTidakDiHisap >= 1000,
    ),
    // Badge berbasis uang dihemat.
    BadgePencapaian(
      id: 'uang_100k',
      nama: 'Tabungan 100 Ribu',
      deskripsi: 'Berhasil menghemat Rp100.000 dari tidak merokok.',
      icon: CupertinoIcons.money_dollar,
      tercapai: uangDihemat >= 100000,
    ),
    BadgePencapaian(
      id: 'uang_500k',
      nama: 'Tabungan 500 Ribu',
      deskripsi: 'Berhasil menghemat Rp500.000 dari tidak merokok.',
      icon: CupertinoIcons.money_dollar,
      tercapai: uangDihemat >= 500000,
    ),
    BadgePencapaian(
      id: 'uang_1jt',
      nama: 'Tabungan 1 Juta',
      deskripsi: 'Berhasil menghemat Rp1.000.000 dari tidak merokok.',
      icon: CupertinoIcons.money_dollar_circle,
      tercapai: uangDihemat >= 1000000,
    ),
    // Badge berbasis impian tercapai.
    BadgePencapaian(
      id: 'impian_1',
      nama: 'Impian Pertama Tercapai',
      deskripsi: 'Berhasil mencapai 1 impian.',
      icon: CupertinoIcons.heart,
      tercapai: impianTercapai >= 1,
    ),
    BadgePencapaian(
      id: 'impian_3',
      nama: '3 Impian Tercapai',
      deskripsi: 'Berhasil mencapai 3 impian.',
      icon: CupertinoIcons.heart_fill,
      tercapai: impianTercapai >= 3,
    ),
  ];
  L.i('daftar.length=${daftar.length}');
  return daftar;
}
