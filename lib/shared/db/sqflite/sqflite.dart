import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Konfigurasi dan akses database SQLite untuk aplikasi berhenti_merokok.
///
/// Database menggunakan factory default sqflite yang didukung Android.
class AppDatabase {
  AppDatabase._();

  static Database? _database;

  /// Nama file database SQLite.
  static const String _namaDatabase = 'berhenti_merokok.db';

  /// Versi skema database.
  // Versi 12: migrasi nilai enum snake_case lama ke lowerCamelCase.
  // Versi 13: tabel rencana_darurat (if-then plan).
  // Versi 14: tambah kolom pemicu (TEXT, nullable) pada tabel konsumsi_rokok.
  // Versi 15: perbaikan bug — instalasi baru (onCreate) versi 14 tidak menyertakan
  // kolom pemicu; migrasi ini menambahkan kolom pemicu bila belum ada.
  static const int _versiDatabase = 15;

  /// Mengembalikan instance database, membuatnya jika belum tersedia.
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _inisialisasiDatabase();
    return _database!;
  }

  /// Membuka dan menginisialisasi database SQLite.
  static Future<Database> _inisialisasiDatabase() async {
    final pathDatabase = await getDatabasesPath();
    final path = join(pathDatabase, _namaDatabase);

    return await openDatabase(
      path,
      version: _versiDatabase,
      onCreate: _buatTabel,
      onUpgrade: _onUpgrade,
    );
  }

  /// Membuat tabel-tabel saat database pertama kali dibuat.
  static Future<void> _buatTabel(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${NamaTabel.biodata}(
        ${NamaKolom.id} TEXT PRIMARY KEY,
        ${NamaKolom.nama} TEXT NOT NULL,
        ${NamaKolom.tanggalLahir} TEXT,
        ${NamaKolom.jumlahRokokPerHari} INTEGER,
        ${NamaKolom.hargaRokokPerBungkus} REAL,
        ${NamaKolom.batangPerBungkus} REAL,
        ${NamaKolom.tanggalMulaiMerokok} TEXT,
        ${NamaKolom.tanggalMulaiBerhentiMerokok} TEXT,
        ${NamaKolom.modeBerhenti} TEXT,
        ${NamaKolom.penurunanPerMinggu} INTEGER,
        ${NamaKolom.tanggalMulaiTapering} TEXT,
        ${NamaKolom.targetSmokeFreeHari} INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${NamaTabel.impian}(
        ${NamaKolom.id} TEXT PRIMARY KEY,
        ${NamaKolom.nama} TEXT NOT NULL,
        ${NamaKolom.targetTanggal} TEXT,
        ${NamaKolom.dibuat} TEXT,
        ${NamaKolom.jumlah} REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${NamaTabel.diaryCraving}(
        ${NamaKolom.id} TEXT PRIMARY KEY,
        ${NamaKolom.tanggal} TEXT,
        ${NamaKolom.pemicu} TEXT NOT NULL,
        ${NamaKolom.intensitas} INTEGER,
        ${NamaKolom.catatan} TEXT,
        ${NamaKolom.durasiMenit} INTEGER,
        ${NamaKolom.mood} TEXT,
        ${NamaKolom.strategi} TEXT,
        ${NamaKolom.hasil} TEXT,
        ${NamaKolom.dibuat} TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${NamaTabel.alasanBerhenti}(
        ${NamaKolom.id} TEXT PRIMARY KEY,
        ${NamaKolom.teks} TEXT NOT NULL,
        ${NamaKolom.dibuat} TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${NamaTabel.konsumsiRokok}(
        ${NamaKolom.id} TEXT PRIMARY KEY,
        ${NamaKolom.tanggal} TEXT NOT NULL,
        ${NamaKolom.jumlah} INTEGER NOT NULL DEFAULT 1,
        ${NamaKolom.isSlip} INTEGER NOT NULL DEFAULT 0,
        ${NamaKolom.catatan} TEXT,
        ${NamaKolom.pemicu} TEXT,
        ${NamaKolom.dibuat} TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_konsumsi_tanggal
      ON ${NamaTabel.konsumsiRokok}(${NamaKolom.tanggal})
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${NamaTabel.sosIntervensi}(
        ${NamaKolom.id} TEXT PRIMARY KEY,
        ${NamaKolom.jenisIntervensi} TEXT NOT NULL,
        ${NamaKolom.detail} TEXT,
        ${NamaKolom.hasilIntervensi} TEXT,
        ${NamaKolom.diaryCravingId} TEXT,
        ${NamaKolom.dibuat} TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${NamaTabel.rencanaDarurat}(
        ${NamaKolom.id} TEXT PRIMARY KEY,
        ${NamaKolom.jika} TEXT NOT NULL,
        ${NamaKolom.maka} TEXT NOT NULL,
        ${NamaKolom.dibuat} TEXT NOT NULL
      )
    ''');
  }

  /// Memperbarui skema database saat versi meningkat.
  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (kDebugMode) {
      debugPrint('oldVersion=$oldVersion, newVersion=$newVersion');
    }
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${NamaTabel.impian}(
          ${NamaKolom.id} TEXT PRIMARY KEY,
          ${NamaKolom.nama} TEXT NOT NULL,
          ${NamaKolom.targetTanggal} TEXT,
          ${NamaKolom.dibuat} TEXT,
          ${NamaKolom.jumlah} REAL
        )
      ''');
    }
    if (oldVersion < 3) {
      await db.execute(
        'ALTER TABLE ${NamaTabel.biodata} '
        'ADD COLUMN ${NamaKolom.tanggalMulaiBerhentiMerokok} TEXT',
      );
    }
    if (oldVersion < 4) {
      await db.execute(
        'ALTER TABLE ${NamaTabel.biodata} '
        'ADD COLUMN ${NamaKolom.batangPerBungkus} REAL',
      );
    }
    if (oldVersion < 5) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${NamaTabel.diaryCraving}(
          ${NamaKolom.id} TEXT PRIMARY KEY,
          ${NamaKolom.tanggal} TEXT,
          ${NamaKolom.pemicu} TEXT NOT NULL,
          ${NamaKolom.intensitas} INTEGER,
          ${NamaKolom.catatan} TEXT,
          ${NamaKolom.dibuat} TEXT
        )
      ''');
    }
    if (oldVersion < 6) {
      await db.execute(
        'ALTER TABLE ${NamaTabel.biodata} '
        'ADD COLUMN ${NamaKolom.modeBerhenti} TEXT',
      );
      await db.execute(
        'ALTER TABLE ${NamaTabel.biodata} '
        'ADD COLUMN ${NamaKolom.penurunanPerMinggu} INTEGER',
      );
      await db.execute(
        'ALTER TABLE ${NamaTabel.biodata} '
        'ADD COLUMN ${NamaKolom.tanggalMulaiTapering} TEXT',
      );
    }
    if (oldVersion < 7) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${NamaTabel.alasanBerhenti}(
          ${NamaKolom.id} TEXT PRIMARY KEY,
          ${NamaKolom.teks} TEXT NOT NULL,
          ${NamaKolom.dibuat} TEXT
        )
      ''');
    }
    if (oldVersion < 8) {
      await db.execute(
        'ALTER TABLE ${NamaTabel.biodata} '
        'ADD COLUMN ${NamaKolom.targetSmokeFreeHari} INTEGER',
      );
    }
    // v9: tabel konsumsi_rokok. Tabel sos_intervensi dibuat di cabang v11 (lihat bawah)
    // agar setiap tabel didefinisikan tepat sekali pada kondisi versinya masing-masing.
    if (oldVersion < 9) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${NamaTabel.konsumsiRokok}(
          ${NamaKolom.id} TEXT PRIMARY KEY,
          ${NamaKolom.tanggal} TEXT NOT NULL,
          ${NamaKolom.jumlah} INTEGER NOT NULL DEFAULT 1,
          ${NamaKolom.isSlip} INTEGER NOT NULL DEFAULT 0,
          ${NamaKolom.catatan} TEXT,
          ${NamaKolom.dibuat} TEXT NOT NULL
        )
      ''');
      await db.execute('''
        CREATE INDEX IF NOT EXISTS idx_konsumsi_tanggal
        ON ${NamaTabel.konsumsiRokok}(${NamaKolom.tanggal})
      ''');
    }
    if (oldVersion < 10) {
      await db.execute(
        'ALTER TABLE ${NamaTabel.diaryCraving} '
        'ADD COLUMN ${NamaKolom.durasiMenit} INTEGER',
      );
      await db.execute(
        'ALTER TABLE ${NamaTabel.diaryCraving} '
        'ADD COLUMN ${NamaKolom.mood} TEXT',
      );
      await db.execute(
        'ALTER TABLE ${NamaTabel.diaryCraving} '
        'ADD COLUMN ${NamaKolom.strategi} TEXT',
      );
      await db.execute(
        'ALTER TABLE ${NamaTabel.diaryCraving} '
        'ADD COLUMN ${NamaKolom.hasil} TEXT',
      );
    }
    if (oldVersion < 11) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${NamaTabel.sosIntervensi}(
          ${NamaKolom.id} TEXT PRIMARY KEY,
          ${NamaKolom.jenisIntervensi} TEXT NOT NULL,
          ${NamaKolom.detail} TEXT,
          ${NamaKolom.hasilIntervensi} TEXT,
          ${NamaKolom.diaryCravingId} TEXT,
          ${NamaKolom.dibuat} TEXT NOT NULL
        )
      ''');
    }
    // v12: petakan nilai enum snake_case yang tersimpan ke lowerCamelCase.
    // Tanpa migrasi ini nilai lama tidak terparse oleh safeParseEnum.
    if (oldVersion < 12) {
      const pemetaanCraving = <String, String>{
        'napas_478': 'napas478',
        'minum_air': 'minumAir',
        'alih_aktivitas': 'alihAktivitas',
        'tunda_5_menit': 'tunda5Menit',
      };
      const pemetaanHasil = <String, String>{
        'berhasil_menahan': 'berhasilMenahan',
        'tetap_merokok': 'tetapMerokok',
        'belum_selesai': 'belumSelesai',
      };
      const pemetaanJenisIntervensi = <String, String>{
        'napas_478': 'napas478',
        'timer_3_menit': 'timer3Menit',
        'napas_box': 'napasBox',
        'napas_90_detik': 'napas90Detik',
        'grounding_54321': 'grounding54321',
        'urge_surfing': 'urgeSurfing',
        'timer_craving': 'timerCraving',
      };
      for (final entry in pemetaanCraving.entries) {
        await db.rawUpdate(
          'UPDATE ${NamaTabel.diaryCraving} '
          'SET ${NamaKolom.strategi} = ? '
          'WHERE ${NamaKolom.strategi} = ?',
          [entry.value, entry.key],
        );
      }
      for (final entry in pemetaanHasil.entries) {
        await db.rawUpdate(
          'UPDATE ${NamaTabel.diaryCraving} '
          'SET ${NamaKolom.hasil} = ? '
          'WHERE ${NamaKolom.hasil} = ?',
          [entry.value, entry.key],
        );
        await db.rawUpdate(
          'UPDATE ${NamaTabel.sosIntervensi} '
          'SET ${NamaKolom.hasilIntervensi} = ? '
          'WHERE ${NamaKolom.hasilIntervensi} = ?',
          [entry.value, entry.key],
        );
      }
      for (final entry in pemetaanJenisIntervensi.entries) {
        await db.rawUpdate(
          'UPDATE ${NamaTabel.sosIntervensi} '
          'SET ${NamaKolom.jenisIntervensi} = ? '
          'WHERE ${NamaKolom.jenisIntervensi} = ?',
          [entry.value, entry.key],
        );
      }
    }
    // v13: tabel rencana_darurat (if-then plan).
    if (oldVersion < 13) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${NamaTabel.rencanaDarurat}(
          ${NamaKolom.id} TEXT PRIMARY KEY,
          ${NamaKolom.jika} TEXT NOT NULL,
          ${NamaKolom.maka} TEXT NOT NULL,
          ${NamaKolom.dibuat} TEXT NOT NULL
        )
      ''');
    }
    // v14: tambah kolom pemicu (TEXT, nullable) pada tabel konsumsi_rokok.
    if (oldVersion < 14) {
      await db.execute(
        'ALTER TABLE ${NamaTabel.konsumsiRokok} '
        'ADD COLUMN ${NamaKolom.pemicu} TEXT',
      );
    }
    // v15: perbaikan bug — database versi 14 yang dibuat melalui onCreate tidak
    // menyertakan kolom pemicu (hanya migrasi v14 yang menambahkannya).
    // Pemeriksaan PRAGMA table_info membuat migrasi ini aman untuk database
    // yang sudah memiliki kolom pemicu (hasil upgrade v13 → v14).
    if (oldVersion < 15) {
      final info = await db.rawQuery(
        'PRAGMA table_info(${NamaTabel.konsumsiRokok})',
      );
      final sudahAda = info.any((kolom) => kolom['name'] == NamaKolom.pemicu);
      if (!sudahAda) {
        await db.execute(
          'ALTER TABLE ${NamaTabel.konsumsiRokok} '
          'ADD COLUMN ${NamaKolom.pemicu} TEXT',
        );
      }
    }
  }

  /// Menutup database jika sedang terbuka.
  static Future<void> tutupDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
