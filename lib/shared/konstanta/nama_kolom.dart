/// Nama-nama kolom database SQLite aplikasi.
class NamaKolom {
  NamaKolom._();

  /// Kolom id biodata.
  static const String id = 'id';

  /// Kolom nama biodata.
  static const String nama = 'nama';

  /// Kolom tanggal lahir biodata.
  static const String tanggalLahir = 'tanggal_lahir';

  /// Kolom jumlah rokok per hari biodata.
  static const String jumlahRokokPerHari = 'jumlah_rokok_per_hari';

  /// Kolom harga rokok per bungkus biodata.
  static const String hargaRokokPerBungkus = 'harga_rokok_per_bungkus';

  /// Kolom batang rokok per bungkus biodata.
  static const String batangPerBungkus = 'batang_per_bungkus';

  /// Kolom tanggal mulai merokok biodata.
  static const String tanggalMulaiMerokok = 'tanggal_mulai_merokok';

  /// Kolom tanggal mulai berhenti merokok biodata.
  static const String tanggalMulaiBerhentiMerokok =
      'tanggal_mulai_berhenti_merokok';

  /// Kolom mode berhenti biodata (seketika/bertahap).
  static const String modeBerhenti = 'mode_berhenti';

  /// Kolom penurunan rokok per minggu untuk mode bertahap.
  static const String penurunanPerMinggu = 'penurunan_per_minggu';

  /// Kolom tanggal mulai rencana penurunan (tapering).
  static const String tanggalMulaiTapering = 'tanggal_mulai_tapering';

  /// Kolom target smoke-free (hari) pada biodata.
  static const String targetSmokeFreeHari = 'target_smoke_free_hari';

  // Kolom tabel impian.
  /// Kolom target tanggal impian.
  static const String targetTanggal = 'target_tanggal';

  /// Kolom tanggal dibuat impian.
  static const String dibuat = 'dibuat';

  /// Kolom jumlah impian.
  static const String jumlah = 'jumlah';

  // Kolom tabel diary craving.
  /// Kolom tanggal kejadian craving.
  static const String tanggal = 'tanggal';

  /// Kolom kategori pemicu craving.
  static const String pemicu = 'pemicu';

  /// Kolom intensitas craving (1-5).
  static const String intensitas = 'intensitas';

  /// Kolom catatan craving.
  static const String catatan = 'catatan';

  /// Kolom durasi craving dalam menit.
  static const String durasiMenit = 'durasi_menit';

  /// Kolom suasana hati saat craving.
  static const String mood = 'mood';

  /// Kolom strategi yang dicoba saat craving.
  static const String strategi = 'strategi';

  /// Kolom hasil dari craving.
  static const String hasil = 'hasil';

  /// Kolom teks alasan berhenti.
  static const String teks = 'teks';

  // Kolom tabel konsumsi_rokok.
  /// Kolom flag slip/relapse konsumsi rokok.
  static const String isSlip = 'is_slip';

  // Kolom tabel sos_intervensi.
  /// Kolom jenis intervensi SOS (napas_478, timer_3_menit, distraksi).
  static const String jenisIntervensi = 'jenis_intervensi';

  /// Kolom nama aktivitas distraksi yang dipilih (nullable).
  static const String detail = 'detail';

  /// Kolom hasil intervensi (berkurang, tetap, belum_selesai; nullable).
  static const String hasilIntervensi = 'hasil_intervensi';

  /// Kolom referensi entri diary craving (FK logis, nullable).
  static const String diaryCravingId = 'diary_craving_id';
}
