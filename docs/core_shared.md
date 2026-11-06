// ============================================================
// FILE: lib/shared/db/sqflite/db_sqflite.dart
// ============================================================

```dart
// lib/shared/db/db_sqflite.dart
import 'dart:async';

import 'package:myapp/shared/db/sqflite/tabel_sqflite.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

part 'db_sqflite.g.dart';
part 'sqflite_migration.dart';

/// Kelas untuk mengelola database Sqflite aplikasi.
class DbSqflite {
  /// Versi database saat ini.
  static const int version = 10;

  /// Buat instance DbSqflite.
  DbSqflite();

  Database? _db;
  Future<Database>? _initFuture;

  /// Mendapatkan instance database, membuatnya jika belum ada. Menggunakan gate agar inisialisasi tidak berjalan dua kali bersamaan. Refactor: hindari operator ! dengan pola jika dan variabel lokal.
  Future<Database> get database async {
    if (_db case final db?) return db;
    final future = _initFuture ??= _initDb();
    try {
      final dbResult = await future;
      _db = dbResult;
      _initFuture = null;
      return dbResult;
    } catch (e, st) {
      // Reset agar inisialisasi bisa diulang setelah error.
      _initFuture = null;
      L.e('Gagal inisialisasi database: $e $st');
      rethrow;
    }
  }

  Future<Database> _initDb() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'app.db');

      final db = await openDatabase(
        path,
        version: version,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
      );

      // Pastikan semua tabel ada (mis. DB lama / hasil restore dari versi lama
      // yang belum memiliki tabel baru). CREATE TABLE IF NOT EXISTS aman.
      for (final sql in TabelSqflite.semuaTabel) {
        await db.execute(sql);
      }

      return db;
    } catch (e, s) {
      L.e('Gagal inisialisasi _initDb: $e $s');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    for (final sql in TabelSqflite.semuaTabel) {
      await db.execute(sql);
    }
  }

  // ==================== METHOD UTILITY ====================

  /// Menutup koneksi database jika masih terbuka.
  Future<void> close() async {
    final db = _db;
    if (db != null) {
      await db.close();
      _db = null;
    }
  }

  /// Mengembalikan versi database saat ini.
  Future<int> getVersion() async {
    final db = await database;
    return await db.getVersion();
  }

  /// Mengecek apakah tabel [tableName] ada di database.
  Future<bool> tableExists(String tableName) async {
    final db = await database;
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName],
    );
    return result.isNotEmpty;
  }

  /// Membuat semua tabel di database.
  Future<void> createAllTables() async {
    final db = await database;
    try {
      L.i('🔄 Membuat semua tabel...');

      for (final sql in TabelSqflite.semuaTabel) {
        await db.execute(sql);
      }

      L.s('✅ Semua tabel berhasil dibuat');
    } catch (e, s) {
      L.e('❌ Gagal membuat tabel $e $s');
      rethrow;
    }
  }

  /// Mereset dan membuat ulang semua tabel di database.
  Future<void> resetDanBuatUlang() async {
    final db = await database;
    try {
      L.w('⚠️ RESET DATABASE: Menghapus semua tabel...');
      await db.transaction((txn) async {
        await txn.execute('PRAGMA foreign_keys = OFF');
        for (final sql in TabelSqflite.dropAllTables) {
          await txn.execute(sql);
        }
        for (final sql in TabelSqflite.semuaTabel) {
          await txn.execute(sql);
        }
        await txn.execute('PRAGMA foreign_keys = ON');
      });
      L.s('✅ Database berhasil direset dan dibuat ulang');
    } catch (e, s) {
      L.e('❌ Gagal reset dan buat ulang database $e $s');
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
/// Provider untuk instance [DbSqflite].
DbSqflite dbSqflite(Ref ref) {
  final db = DbSqflite();
  return db;
}
```


// ============================================================
// FILE: lib/shared/db/sqflite/sqflite_migration.dart
// ============================================================

```dart
// lib/shared/db/sqflite/sqflite_migration.dart
part of 'db_sqflite.dart';

/// Ekstensi untuk migrasi skema database Sqflite.
extension DbSqfliteMigration on DbSqflite {
  /// Menangani upgrade database dengan try/catch dan log error.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      // Versi 2: tambah kolom path_gambar.
      if (oldVersion < 2) {
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.kendaraan,
          NamaKolom.pathGambar,
          'TEXT',
        );
      }
      // Versi 4: tambah kolom tahun_keluar, model, jenis pada kendaraan.
      if (oldVersion < 4) {
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.kendaraan,
          NamaKolom.tahunKeluar,
          'TEXT',
        );
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.kendaraan,
          NamaKolom.model,
          'TEXT',
        );
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.kendaraan,
          NamaKolom.jenis,
          'TEXT',
        );
      }
      // Versi 5: tambah kolom diperbarui pada tabel pengingat.
      if (oldVersion < 5) {
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.pengingat,
          NamaKolom.diperbarui,
          'TEXT',
        );
      }
      // Versi 6: tambah kolom id_kendaraan pada tabel pengingat.
      if (oldVersion < 6) {
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.pengingat,
          NamaKolom.idKendaraan,
          'TEXT',
        );
      }
      // Versi 7: tambah tabel kategori_pengeluaran dan kolom kategori/struk pada transaksi.
      if (oldVersion < 7) {
        await db.execute(TabelSqflite.kategoriTransaksi);
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.transaksi,
          NamaKolom.idKategoriTransaksi,
          'TEXT',
        );
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.transaksi,
          NamaKolom.pathStruk,
          'TEXT',
        );
      }
      // Versi 8: tambah kolom tipe_transaksi pada tabel kategori_transaksi.
      if (oldVersion < 8) {
        await db.execute(TabelSqflite.kategoriTransaksi);
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.kategoriTransaksi,
          NamaKolom.tipeTransaksi,
          "TEXT NOT NULL DEFAULT 'pemasukan'",
        );
      }
      // Versi 9: rename tabel tabungan -> transaksi (dan kolom id_kategori_tabungan -> id_kategori_transaksi).
      if (oldVersion < 9) {
        try {
          await db.execute(
            'ALTER TABLE "tabungan" RENAME TO "${NamaTabel.transaksi}"',
          );
        } catch (e, s) {
          L.e('⚠️ Gagal rename tabel tabungan: $e $s');
        }
        try {
          await db.execute(
            'ALTER TABLE "kategori_tabungan" RENAME TO "${NamaTabel.kategoriTransaksi}"',
          );
        } catch (e, s) {
          L.e('⚠️ Gagal rename tabel kategori_tabungan: $e $s');
        }
        try {
          await db.execute(
            'ALTER TABLE "${NamaTabel.transaksi}" RENAME COLUMN "id_kategori_tabungan" TO "${NamaKolom.idKategoriTransaksi}"',
          );
        } catch (e, s) {
          L.e('⚠️ Gagal rename kolom id_kategori_tabungan: $e $s');
        }
      }
      // Versi 10: rename kolom pengingat camelCase -> snake_case.
      if (oldVersion < 10) {
        for (final kolomLamaBaru in [
          ['tanggalTampil', (NamaKolom.tanggalTampil)],
          ['kategoriPengingat', (NamaKolom.kategoriPengingat)],
          ['pageTujuan', (NamaKolom.pageTujuan)],
        ]) {
          try {
            await db.execute(
              'ALTER TABLE "${NamaTabel.pengingat}" RENAME COLUMN "${kolomLamaBaru[0]}" TO "${kolomLamaBaru[1]}"',
            );
          } catch (e, s) {
            L.e('⚠️ Gagal rename kolom ${kolomLamaBaru[0]}: $e $s');
          }
        }
      }
    } catch (e, s) {
      /// Log error migrasi dan lempar ulang agar tidak tersembunyi.
      L.e('❌ Gagal migrasi database $e $s');
      rethrow;
    }
  }

  Future<void> _tambahKolomJikaBelumAda(
    Database db,
    String tabel,
    String kolom,
    String tipe,
  ) async {
    try {
      /// Periksa apakah kolom sudah ada melalui PRAGMA.
      final kolomList = await db.rawQuery('PRAGMA table_info("$tabel")');
      final ada = kolomList.any((r) => r['name'] == kolom);
      if (!ada) {
        /// Tambah kolom jika belum ada.
        await db.execute('ALTER TABLE "$tabel" ADD COLUMN "$kolom" $tipe');
      }
    } catch (e, s) {
      /// Log error saat tambah kolom dan lempar ulang.
      L.e('❌ Gagal tambah kolom $kolom pada $tabel $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/shared/db/sqflite/tabel_sqflite.dart
// ============================================================

```dart
// lib/shared/db/sqflite/tabel_sqflite.dart
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';

/// Definisi skema SQL untuk semua tabel Sqflite.
class TabelSqflite {
  TabelSqflite._();

  /// DDL untuk tabel km.
  static String get km =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.km} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.km} TEXT NOT NULL,
  ${NamaKolom.tanggal} TEXT NOT NULL,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel komponen.
  static String get komponen =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.komponen} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.harga} REAL NOT NULL,
  ${NamaKolom.linkToko} TEXT,
  ${NamaKolom.idKendaraan} TEXT NOT NULL DEFAULT '',
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel jadwalService.
  static String get jadwalService =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.jadwalService} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.bulan} INTEGER NOT NULL,
  ${NamaKolom.km} INTEGER NOT NULL,
  ${NamaKolom.kmTerakhirService} REAL NOT NULL,
  ${NamaKolom.tanggalTerakhirService} TEXT NOT NULL,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel jadwalServiceKomponen.
  static String get jadwalServiceKomponen =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.jadwalServiceKomponen} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.jadwalServiceId} TEXT NOT NULL,
  ${NamaKolom.komponenId} TEXT NOT NULL,
  ${NamaKolom.idKendaraan} TEXT NOT NULL DEFAULT '',
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT,
  FOREIGN KEY (${NamaKolom.jadwalServiceId}) REFERENCES ${NamaTabel.jadwalService} (${NamaKolom.id}) ON DELETE CASCADE,
  FOREIGN KEY (${NamaKolom.komponenId}) REFERENCES ${NamaTabel.komponen} (${NamaKolom.id}) ON DELETE CASCADE
)
''';

  /// DDL untuk tabel riwayatJadwalService.
  static String get riwayatJadwalService =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.riwayatJadwalService} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.jadwalServiceId} TEXT NOT NULL,
  ${NamaKolom.idKendaraan} TEXT NOT NULL DEFAULT '',
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.tanggalService} TEXT NOT NULL,
  ${NamaKolom.km} REAL NOT NULL,
  ${NamaKolom.biaya} REAL NOT NULL,
  ${NamaKolom.catatan} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel kendaraan.
  static String get kendaraan =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.kendaraan} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.merk} TEXT NOT NULL,
  ${NamaKolom.platNomor} TEXT,
  ${NamaKolom.pathGambar} TEXT,
  ${NamaKolom.tahunKeluar} TEXT,
  ${NamaKolom.model} TEXT,
  ${NamaKolom.jenis} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel transaksi.
  static String get transaksi =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.transaksi} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.deskripsi} TEXT NOT NULL,
  ${NamaKolom.jumlah} REAL NOT NULL,
  ${NamaKolom.tanggal} TEXT NOT NULL,
   ${NamaKolom.tipeTransaksi} TEXT NOT NULL,
   ${NamaKolom.idKategoriTransaksi} TEXT,
   ${NamaKolom.pathStruk} TEXT,
   ${NamaKolom.riwayatJadwalServiceId} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel kategori transaksi.
  static String get kategoriTransaksi =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.kategoriTransaksi} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.tipeTransaksi} TEXT NOT NULL DEFAULT 'pemasukan',
  ${NamaKolom.ikon} TEXT,
  ${NamaKolom.warna} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel impian.
  static String get impian =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.impian} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.deskripsi} TEXT NOT NULL,
  ${NamaKolom.jumlah} REAL NOT NULL,
  ${NamaKolom.tanggalDibuat} TEXT NOT NULL,
  ${NamaKolom.tanggalTarget} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel pajak.
  static String get pajak =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.pajak} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.tanggal} TEXT NOT NULL,
  ${NamaKolom.biaya} REAL NOT NULL,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel pengingat.
  static String get pengingat =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.pengingat} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.idKendaraan} TEXT NOT NULL DEFAULT '',
  ${NamaKolom.pesan} TEXT NOT NULL,
  ${NamaKolom.tanggalTampil} TEXT NOT NULL,
  ${NamaKolom.kategoriPengingat} TEXT NOT NULL,
  ${NamaKolom.pageTujuan} TEXT NOT NULL,
  ${NamaKolom.diperbarui} TEXT NOT NULL
)
''';

  /// DDL untuk tabel bahan bakar.
  static String get bahanBakar =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.bahanBakar} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.tanggal} TEXT NOT NULL,
  ${NamaKolom.km} TEXT NOT NULL,
  ${NamaKolom.liter} REAL NOT NULL,
  ${NamaKolom.hargaPerLiter} REAL NOT NULL,
  ${NamaKolom.total} REAL NOT NULL,
  ${NamaKolom.catatan} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// Daftar semua DDL tabel.
  static List<String> get semuaTabel => [
    km,
    komponen,
    jadwalService,
    jadwalServiceKomponen,
    riwayatJadwalService,
    kendaraan,
    transaksi,
    kategoriTransaksi,
    impian,
    pajak,
    bahanBakar,
    pengingat,
  ];

  /// Daftar semua perintah DROP TABLE.
  static List<String> get dropAllTables => [
    'DROP TABLE IF EXISTS ${NamaTabel.km}',
    'DROP TABLE IF EXISTS ${NamaTabel.komponen}',
    'DROP TABLE IF EXISTS ${NamaTabel.jadwalService}',
    'DROP TABLE IF EXISTS ${NamaTabel.jadwalServiceKomponen}',
    'DROP TABLE IF EXISTS ${NamaTabel.riwayatJadwalService}',
    'DROP TABLE IF EXISTS ${NamaTabel.kendaraan}',
    'DROP TABLE IF EXISTS ${NamaTabel.transaksi}',
    'DROP TABLE IF EXISTS ${NamaTabel.kategoriTransaksi}',
    'DROP TABLE IF EXISTS ${NamaTabel.impian}',
    'DROP TABLE IF EXISTS ${NamaTabel.pajak}',
    'DROP TABLE IF EXISTS ${NamaTabel.bahanBakar}',
    'DROP TABLE IF EXISTS ${NamaTabel.pengingat}',
  ];
}
```


// ============================================================
// FILE: lib/shared/enum/page_enum.dart
// ============================================================

```dart
enum PageEnum {
  dashboard,
  km,
  transaksi
}```


// ============================================================
// FILE: lib/shared/konstanta/nama_kolom.dart
// ============================================================

```dart
// lib/shared/konstanta/nama_kolom.dart

/// Konstanta nama kolom yang digunakan dalam tabel database SQLite.
class NamaKolom {
  /// Kolom ID utama.
  static const String id = 'id';

  /// Kolom nama.
  static const String nama = 'nama';

  /// Kolom harga.
  static const String harga = 'harga';

  /// Kolom tanggal.
  static const String tanggal = 'tanggal';

  /// Kolom waktu terakhir diperbarui.
  static const String diperbarui = 'diperbarui';

  /// Kolom status diarsipkan.
  static const String diarsipkan = 'diarsipkan';

  /// Kolom ID kendaraan.
  static const String idKendaraan = 'id_kendaraan';

  /// Kolom bulan.
  static const String bulan = 'bulan';

  /// Kolom kilometer.
  static const String km = 'km';

  /// Kolom kilometer terakhir service.
  static const String kmTerakhirService = 'km_terakhir_service';

  /// Kolom tanggal terakhir service.
  static const String tanggalTerakhirService = 'tanggal_terakhir_service';

  /// Kolom tanggal service dilakukan.
  static const String tanggalService = 'tanggal_service';

  /// Kolom total biaya service.
  static const String biaya = 'biaya';

  /// Kolom catatan service.
  static const String catatan = 'catatan';

  /// Kolom ID jadwal service.
  static const String jadwalServiceId = 'jadwal_service_id';

  /// Kolom ID riwayat jadwal service (untuk sinkron transaksi).
  static const String riwayatJadwalServiceId = 'riwayat_jadwal_service_id';

  /// Kolom ID komponen.
  static const String komponenId = 'komponen_id';

  /// Kolom link pembelian.
  static const String linkPembelian = 'link_pembelian';

  /// Kolom jumlah.
  static const String jumlah = 'jumlah';

  /// Kolom tipe transaksi.
  static const String tipeTransaksi = 'tipe_transaksi';

  /// Kolom ID kategori transaksi (relasi ke kategori_transaksi).
  static const String idKategoriTransaksi = 'id_kategori_transaksi';

  /// Kolom path struk/lampiran pengeluaran.
  static const String pathStruk = 'path_struk';

  /// Kolom ikon kategori.
  static const String ikon = 'ikon';

  /// Kolom warna kategori.
  static const String warna = 'warna';

  /// Kolom deskripsi.
  static const String deskripsi = 'deskripsi';

  /// Kolom link toko.
  static const String linkToko = 'link_toko';

  /// Kolom tanggal dibuat.
  static const String tanggalDibuat = 'tanggal_dibuat';

  /// Kolom tanggal target impian.
  static const String tanggalTarget = 'tanggal_target';

  /// Kolom merk kendaraan.
  static const String merk = 'merk';

  /// Kolom plat nomor kendaraan.
  static const String platNomor = 'plat_nomor';

  /// Kolom path gambar kendaraan (lokal).
  static const String pathGambar = 'path_gambar';

  /// Kolom tahun keluar kendaraan.
  static const String tahunKeluar = 'tahun_keluar';

  /// Kolom model kendaraan.
  static const String model = 'model';

  /// Kolom jenis kendaraan.
  static const String jenis = 'jenis';

  /// Kolom tanggal jatuh tempo pajak kendaraan.
  static const String tanggalPajak = 'tanggal_pajak';

  /// Kolom jumlah liter bahan bakar.
  static const String liter = 'liter';

  /// Kolom harga per liter bahan bakar.
  static const String hargaPerLiter = 'harga_per_liter';

  /// Kolom total biaya bahan bakar.
  static const String total = 'total';

  /// Kolom pesan pengingat.
  static const String pesan = 'pesan';

  /// Kolom tanggal tampil pengingat.
  static const String tanggalTampil = 'tanggal_tampil';

  /// Kolom kategori pengingat.
  static const String kategoriPengingat = 'kategori_pengingat';

  /// Kolom tujuan halaman pengingat.
  static const String pageTujuan = 'page_tujuan';
}
```


// ============================================================
// FILE: lib/shared/konstanta/nama_tabel.dart
// ============================================================

```dart
// lib/shared/konstanta/nama_tabel.dart

/// Konstanta nama tabel yang digunakan dalam database SQLite.
// Diubah dari static String menjadi static const String agar nilai tabel tidak dapat diubah dan konsisten dengan konstanta lainnya (aturan string literal/konstanta).
class NamaTabel {
  /// Nama tabel km.
  static const String km = 'km';

  /// Nama tabel komponen.
  static const String komponen = 'komponen';

  /// Nama tabel jadwal service.
  static const String jadwalService = 'jadwal_service';

  /// Nama tabel jadwal service komponen.
  static const String jadwalServiceKomponen = 'jadwal_service_komponen';

  /// Nama tabel riwayat jadwal service.
  static const String riwayatJadwalService = 'riwayat_jadwal_service';

  /// Nama tabel kendaraan.
  static const String kendaraan = 'kendaraan';

  /// Nama tabel pajak.
  static const String pajak = 'pajak';

  /// Nama tabel transaksi.
  static const String transaksi = 'transaksi';

  /// Nama tabel kategori transaksi.
  static const String kategoriTransaksi = 'kategori_transaksi';

  /// Nama tabel impian.
  static const String impian = 'impian';

  /// Nama tabel bahan bakar.
  static const String bahanBakar = 'bahan_bakar';

  /// Nama tabel pengingat.
  static const String pengingat = 'pengingat';
}
```


// ============================================================
// FILE: lib/shared/konstanta/shared_keys.dart
// ============================================================

```dart
/// Kunci untuk menyimpan data pada SharedPreferences.
class KunciShared {
  const KunciShared._();

  /// Kunci waktu sinkronisasi.
  static const String waktuSinkronisasi = 'waktu_sinkronisasi';

  /// Kunci waktu sinkronisasi terakhir.
  static const String lastSinkronisasi = 'last_sinkronisasi';

  /// Kunci untuk mengaktifkan sinkronisasi otomatis.
  static const String aktifkanSinkronisasiOtomatis =
      'aktifkan_sinkronisasi_otomatis';

  /// Kunci email akun Google yang login.
  static const String emailGoogle = 'email_google';

  /// Kunci ID kendaraan yang sedang dipilih.
  static const String kendaraanTerpilih = 'kendaraan_key';

  /// Kunci preferensi tema aplikasi.
  static const String temaAplikasi = 'tema_aplikasi';

  /// Kunci status aktif kunci aplikasi.
  static const String kunciAplikasiAktif = 'kunci_aplikasi_aktif';

  /// Kunci metode kunci aplikasi (biometrik/pin/biometrikDanPin).
  static const String kunciAplikasiMetode = 'kunci_aplikasi_metode';

  /// Kunci durasi auto-lock dalam menit (0 = langsung).
  static const String kunciAplikasiDurasiAutoLock =
      'kunci_aplikasi_durasi_auto_lock';

  /// Kunci hash PIN aplikasi.
  static const String kunciAplikasiPinHash = 'kunci_aplikasi_pin_hash';

  /// Kunci salt untuk hash PIN.
  static const String kunciAplikasiSalt = 'kunci_aplikasi_salt';

  /// Kunci jumlah percobaan PIN gagal.
  static const String kunciAplikasiPercobaanGagal =
      'kunci_aplikasi_percobaan_gagal';

  /// Kunci waktu kunci (lockout) berakhir (epoch millis). 0 = tidak terkunci.
  static const String kunciAplikasiKunciSampai = 'kunci_aplikasi_kunci_sampai';

  /// Kunci mata uang yang dipilih.
  static const String mataUangTerpilih = 'mata_uang_terpilih';
}
```


// ============================================================
// FILE: lib/shared/notifikasi/notifikasi_service.dart
// ============================================================

```dart
// lib/shared/notifikasi/notifikasi_service.dart

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myapp/fitur/impian/page/impian_page.dart';
import 'package:myapp/fitur/jadwal_service/page/detail_jadwal_service.dart';
import 'package:myapp/fitur/jadwal_service/page/jadwal_service_page.dart';
import 'package:myapp/fitur/kendaraan/model/pajak_model.dart';
import 'package:myapp/fitur/kendaraan/page/kendaraan_page.dart';
import 'package:myapp/fitur/km/page/km_page.dart';
import 'package:myapp/fitur/komponen/page/komponen_page.dart';
import 'package:myapp/fitur/transaksi/page/transaksi_page.dart';
import 'package:myapp/home.dart';
import 'package:myapp/lainnya_page.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Kategori notifikasi untuk payload navigasi.
enum KategoriNotifikasi {
  /// Jadwal service.
  jadwalService('jadwal_service'),

  /// Kendaraan.
  kendaraan('kendaraan'),

  /// Kilometer.
  km('km'),

  /// Komponen.
  komponen('komponen'),

  /// Transaksi.
  transaksi('transaksi'),

  /// Impian.
  impian('impian'),

  /// Pengaturan.
  pengaturan('pengaturan');

  const KategoriNotifikasi(this.nilai);

  /// Nilai string untuk payload.
  final String nilai;
}

/// Service untuk notifikasi lokal jadwal service kendaraan; muncul ketika sisa KM <= 0 atau sisa waktu <= 0 dan hanya jika pengaturan notifikasi aktif.
class NotifikasiService {
  NotifikasiService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Membuat id notifikasi numerik konsisten dari [id].
  static int _notifId(String id) =>
      int.tryParse(id)?.abs() ?? id.hashCode.abs();

  static bool _terinisialisasi = false;

  /// Kunci navigator global untuk navigasi saat notifikasi ditekan.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Kunci pengaturan notifikasi service di SharedPreferences.
  static const String _kunciAktif = 'notifikasi_service_aktif';
  static const String _kunciPengingat = 'notifikasi_waktu_pengingat_hari';
  // Konstanta pesan error agar tidak memakai string literal di throw (optimasi_bug_runtime.md #9).
  static const String _pesanIzinNotifWeb =
      'Izin notifikasi web tidak diberikan';

  /// Apakah notifikasi service diaktifkan user.
  static Future<bool> get aktif async {
    final val = await SharedPrefService.getBool(_kunciAktif);
    return val ?? true;
  }

  /// Simpan aktif/nonaktif notifikasi.
  static Future<void> setAktif(bool value) async {
    await SharedPrefService.setBool(_kunciAktif, value);
  }

  /// Waktu pengingat sebelum target (hari): 1, 3, atau 7.
  static Future<int> get waktuPengingat async {
    final val = await SharedPrefService.getInt(_kunciPengingat);
    return val ?? 1;
  }

  /// Simpan waktu pengingat.
  static Future<void> setWaktuPengingat(int hari) async {
    await SharedPrefService.setInt(_kunciPengingat, hari);
  }

  /// Inisialisasi plugin notifikasi. Panggil sekali di `main()` sebelum `runApp`.
  static Future<void> inisialisasi() async {
    if (_terinisialisasi) return;

    const android = AndroidInitializationSettings('ic_notifikasi');
    const ios = DarwinInitializationSettings();
    const macos = DarwinInitializationSettings();
    LinuxInitializationSettings? linux;
    WebInitializationSettings? web;
    if (kIsWeb) {
      web = const WebInitializationSettings();
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      linux = const LinuxInitializationSettings(defaultActionName: 'Buka');
    }
    final settings = InitializationSettings(
      android: android,
      iOS: ios,
      macOS: macos,
      linux: linux,
      web: web,
    );

    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (detail) async {
        final payload = detail.payload;
        if (payload != null && payload.isNotEmpty) {
          await _navigasiKeHalaman(payload);
        }
      },
    );
    try {
      if (kIsWeb) {
        await _plugin
            .resolvePlatformSpecificImplementation<
              WebFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
      }
    } catch (e, s) {
      // Kegagalan izin notifikasi tidak fatal; app tetap berjalan.
      // Tidak rethrow agar inisialisasi app (main) tidak gagal (optimasi_bug_runtime poin 6).
      L.e('Gagal request permission notifikasi: $e $s');
    }
    _terinisialisasi = true;
    L.i('NotifikasiService diinisialisasi');
  }

  /// Meminta izin notifikasi (terutama web) dalam konteks aksi user.
  static Future<bool> mintaIzin() async {
    try {
      if (kIsWeb) {
        final plugin = _plugin
            .resolvePlatformSpecificImplementation<
              WebFlutterLocalNotificationsPlugin
            >();
        L.i('Izin notif web sebelum: ${plugin?.permissionStatus.name}');
        final perm = await plugin?.requestNotificationsPermission();
        L.i(
          'Izin notif web sesudah: ${plugin?.permissionStatus.name}, hasil: $perm',
        );
        return perm ?? false;
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        final perm = await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
        L.i('Izin notif android hasil: $perm');
        return perm ?? false;
      }
    } catch (e, s) {
      L.w('Gagal minta izin notifikasi: $e $s');
    }
    return false;
  }

  /// Menampilkan notifikasi.
  static Future<void> tampilkanNotifikasi({
    required String id,
    required String judul,
    required String isi,
    KategoriNotifikasi? kategori,
  }) async {
    final aktif = await NotifikasiService.aktif;
    L.i('tampilkanNotifikasi aktif: $aktif, id: $id');
    if (!aktif) {
      L.w('Notifikasi nonaktif, batal tampilkan');
      return;
    }
    const android = AndroidNotificationDetails(
      'jadwal_service',
      'Jadwal Service',
      channelDescription: 'Peringatan waktunya service kendaraan',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'ic_notifikasi',
    );
    const ios = DarwinNotificationDetails();
    const detail = NotificationDetails(android: android, iOS: ios);
    // Gunakan id numerik konsisten melalui helper agar unik dan sama saat batalkan.
    final notifId = _notifId(id);

    // Batalkan notifikasi lama dengan id sama lalu tampilkan ulang agar tidak duplikat.
    if (kIsWeb) {
      final plugin = _plugin
          .resolvePlatformSpecificImplementation<
            WebFlutterLocalNotificationsPlugin
          >();
      if (plugin?.permissionStatus != WebNotificationPermission.granted) {
        L.w(
          'Izin notifikasi web tidak diberikan: ${plugin?.permissionStatus.name}',
        );
        throw Exception(_pesanIzinNotifWeb); // gunakan konstanta, bukan string literal (optimasi_bug_runtime.md #9)
      }
    }
    await _plugin.cancel(id: notifId);
    await _plugin.show(
      id: notifId,
      title: judul,
      body: isi,
      notificationDetails: detail,
      payload: '${kategori?.nilai ?? ''}:$id',
    );
    L.i('Notifikasi ditampilkan: $judul');
  }

  /// Meminta izin exact alarm agar zonedSchedule tidak gagal pada Android 12+.
  static Future<AndroidScheduleMode> _cobaMintaIzinExactAlarm() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return AndroidScheduleMode.inexact;
    }

    // Minta izin exact alarm agar tidak gagal di Android 12+ (API 31+).
    try {
      final pluginAndroid = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final izin = await pluginAndroid?.requestExactAlarmsPermission();
      // Jika izin diberikan (atau aplikasi memenuhi syarat), pakai exactAllowWhileIdle.
      if (izin == true) {
        return AndroidScheduleMode.exactAllowWhileIdle;
      }
    } catch (e, s) {
      L.w('Gagal meminta izin exact alarm: $e $s');
    }

    // Default ke inexact jika izin tidak diberikan atau tidak tersedia.
    return AndroidScheduleMode.inexact;
  }

  /// Menjadwalkan notifikasi pada [waktu] tertentu (zonedSchedule).
  static Future<void> jadwalkanNotifikasi({
    required String id,
    required String judul,
    required String isi,
    required DateTime waktu,
    KategoriNotifikasi? kategori,
  }) async {
    final aktif = await NotifikasiService.aktif;
    if (!aktif) return;

    tz.initializeTimeZones();
    final offsetLokal = DateTime.now().timeZoneOffset;
    final lokasi =
        tz.timeZoneDatabase.locations.values.firstWhereOrNull(
          (l) => l.currentTimeZone.offset == offsetLokal,
        ) ??
        tz.UTC; // Menghindari firstWhere native sesuai AGENTS.md
    tz.setLocalLocation(lokasi);
    final waktuTz = tz.TZDateTime.from(waktu, tz.local);
    // Gunakan id numerik konsisten melalui helper agar unik dan sama saat batalkan.
    final notifId = _notifId(id);

    const android = AndroidNotificationDetails(
      'jadwal_service',
      'Jadwal Service',
      channelDescription: 'Peringatan waktunya service kendaraan',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'ic_notifikasi',
    );
    const ios = DarwinNotificationDetails();
    const detail = NotificationDetails(android: android, iOS: ios);

    // Batalkan jadwal lama dengan id sama agar tidak duplikat.
    try {
      await _plugin.cancel(id: notifId);
      final androidScheduleMode = await _cobaMintaIzinExactAlarm();
      await _plugin.zonedSchedule(
        id: notifId,
        title: judul,
        body: isi,
        scheduledDate: waktuTz,
        notificationDetails: detail,
        androidScheduleMode: androidScheduleMode,
        payload: '${kategori?.nilai ?? ''}:$id',
      );
      L.i('Notifikasi dijadwalkan: $judul pada $waktu');
    } catch (e, s) {
      L.e('Gagal menjadwalkan notifikasi: $e $s');
    }
  }

  /// Membatalkan notifikasi terjadwal berdasarkan [id].
  static Future<void> batalkanJadwal(String id) async {
    // Batalkan dengan id konsisten agar sesuai jadwal/notifikasi yang sama.
    await _plugin.cancel(id: _notifId(id));
  }

  /// Tampilkan notifikasi sekarang jika [waktu] <= sekarang, atau jadwalkan jika [waktu] di masa depan.
  static Future<void> tampilkanAtauJadwalkan({
    required String id,
    required String judul,
    required String isi,
    required DateTime waktu,
    KategoriNotifikasi? kategori,
  }) async {
    final now = DateTime.now();
    if (!waktu.isAfter(now)) {
      await tampilkanNotifikasi(
        id: id,
        judul: judul,
        isi: isi,
        kategori: kategori,
      );
    } else {
      await jadwalkanNotifikasi(
        id: id,
        judul: judul,
        isi: isi,
        waktu: waktu,
        kategori: kategori,
      );
    }
  }

  /// Batalkan notifikasi berdasarkan [id] (misalnya jadwal dihapus).
  static Future<void> batalkanNotifikasi(String id) async {
    // Batalkan dengan id konsisten agar sesuai notifikasi yang sama.
    await _plugin.cancel(id: _notifId(id));
  }

  /// Navigasi ke halaman sesuai payload notifikasi yang dipilih user.
  static Future<void> _navigasiKeHalaman(String payload) async {
    final parts = payload.split(':');
    final kategori = parts.isNotEmpty ? parts.first : '';
    final id = parts.length > 1 ? parts[1] : '';
    final navigator = navigatorKey.currentState;
    if (navigator == null) {
      L.w('navigatorKey.currentState null, navigasi notifikasi dibatalkan');
      return;
    }

    Widget halaman;
    switch (kategori) {
      case 'jadwal_service':
        halaman = id.isNotEmpty
            ? DetailJadwalService(id: id)
            : const JadwalServicePage();
        break;
      case 'kendaraan':
        halaman = const KendaraanPage();
        break;
      case 'km':
        halaman = const KmPage();
        break;
      case 'komponen':
        halaman = const KomponenPage();
        break;
      case 'transaksi':
        halaman = const TransaksiPage();
        break;
      case 'impian':
        halaman = const ImpianPage();
        break;
      case 'pengaturan':
        halaman = const LainnyaPage();
        break;
      default:
        halaman = const Home();
        break;
    }

    // Perbaikan: gunakan Nav.pushAndRemoveUntil sesuai konvensi navigasi proyek.
    await Nav.pushAndRemoveUntil(navigator.context, halaman);
    L.i('Navigasi ke halaman: $kategori');
  }

  /// Cek notifikasi jatuh tempo pajak (STNK/PKB) berdasarkan daftar [list].
  static Future<void> cekNotifikasiPajak(List<PajakModel> list) async {
    final aktif = await NotifikasiService.aktif;
    if (!aktif) return;
    final pengingat = await NotifikasiService.waktuPengingat;
    final now = DateTime.now();
    for (final p in list) {
      final selisih = p.tanggal.difference(now).inDays;
      if (selisih >= 0 && selisih <= pengingat) {
        await tampilkanNotifikasi(
          id: p.id,
          judul: 'Pajak ${p.nama} jatuh tempo',
          isi: 'Jatuh tempo ${FormatTanggal.formatDasar(p.tanggal)}',
          kategori: KategoriNotifikasi.kendaraan,
        );
      }
    }
  }

  /// Cek notifikasi yang mungkin tertunda/terpicu saat app dibuka, berjalan asinkron tanpa memblokir UI.
  static void cekNotifikasiSaatBuka() {
    // Fire-and-forget: UI tidak menunggu proses ini selesai.
    unawaited(
      Future(() async {
        try {
          final details = await _plugin.getNotificationAppLaunchDetails();
          if (details?.didNotificationLaunchApp == true) {
            final payload = details?.notificationResponse?.payload;
            if (payload != null && payload.isNotEmpty) {
              // Tunggu frame pertama agar navigatorKey sudah siap.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                unawaited(_navigasiKeHalaman(payload));
              });
            }
          }

          // Opsional: cek notifikasi aktif yang masih tertunda di notch bar.
        } catch (e, s) {
          L.e('Gagal cek notifikasi saat buka: $e $s');
        }
      }),
    );
  }
}
```


// ============================================================
// FILE: lib/shared/operasi/base_op_sqflite.dart
// ============================================================

```dart
// lib/shared/operasi/base_op_sqflite.dart

import 'package:myapp/shared/db/sqflite/db_sqflite.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:myapp/shared/operasi/database_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

part 'base_op_sqflite.g.dart';

/// Implementasi default operasi database Sqflite.
class BaseOpSqflite implements DatabaseService {
  final DbSqflite _db;

  /// Buat instance BaseOpSqflite.
  BaseOpSqflite(this._db);

  // Membuat salinan map agar map pemanggil tidak berubah (efek samping tersembunyi)
  Map<String, dynamic> _setTimestamp(Map<String, dynamic> data) {
    final salinan = Map<String, dynamic>.from(data);
    salinan[NamaKolom.diperbarui] = DateTime.now().toIso8601String();
    return salinan;
  }

  @override
  Future<List<Map<String, dynamic>>> ambilData(String tableName) async {
    L.i('baseOpSqflite ambilData $tableName mulai');
    try {
      final db = await _db.database;
      return await db.query(tableName);
    } catch (e, s) {
      L.e('Gagal mengambil data dari $tableName $e $s');
      rethrow;
    } finally {
      L.i('baseOpSqflite ambilData $tableName selesai');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> ambilDataDenganWhere(
    String tableName,
    String where,
    List<dynamic> whereArgs,
  ) async {
    try {
      final db = await _db.database;
      return await db.query(tableName, where: where, whereArgs: whereArgs);
    } catch (e, s) {
      L.e('Gagal mengambil data dari $tableName dengan where: $e $s');
      rethrow;
    }
  }

  @override
  Future<void> tambah(String tableName, Map<String, dynamic> data) async {
    try {
      final db = await _db.database;
      data = _setTimestamp(data); // Guard efek samping: salinan map
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        await txn.insert(
          tableName,
          data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
      L.s('Berhasil menambah data ke $tableName');
    } catch (e, s) {
      L.e('Gagal menambah data ke $tableName $e $s');
      rethrow;
    }
  }

  @override
  Future<void> perbarui(
    String tableName,
    Map<String, dynamic> data,
    String id,
  ) async {
    try {
      final db = await _db.database;
      data = _setTimestamp(data); // Guard efek samping: salinan map
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        await txn.update(
          tableName,
          data,
          where: '${NamaKolom.id} = ?',
          whereArgs: [id],
        );
      });
      L.s('Berhasil memperbarui data di $tableName (id: $id)');
    } catch (e, s) {
      L.e('Gagal memperbarui data di $tableName (id: $id) $e $s');
      rethrow;
    }
  }

  @override
  Future<void> hapus(String tableName, String id) async {
    try {
      final db = await _db.database;
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        await txn.delete(
          tableName,
          where: '${NamaKolom.id} = ?',
          whereArgs: [id],
        );
      });
      L.s('✅ Berhasil menghapus data di $tableName (id: $id)');
    } catch (e, s) {
      L.e('❌ Gagal menghapus data di $tableName (id: $id) $e $s');
      rethrow;
    }
  }

  @override
  Future<void> hapusDenganWhere(
    String tableName,
    String where,
    List<dynamic> whereArgs,
  ) async {
    try {
      final db = await _db.database;
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        await txn.delete(tableName, where: where, whereArgs: whereArgs);
      });
      L.s('✅ Berhasil menghapus data di $tableName (where: $where)');
    } catch (e, s) {
      L.e('❌ Gagal menghapus data di $tableName (where: $where) $e $s');
      rethrow;
    }
  }

  @override
  Future<void> hapusSemua(String tableName) async {
    try {
      final db = await _db.database;
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        await txn.delete(tableName);
      });
    } catch (e, s) {
      L.e('❌ Gagal menghapus semua data dari tabel $tableName $e $s');
      rethrow;
    }
  }

  @override
  Future<void> sisipkanAtauPerbaruiBatch(
    String tableName,
    List<Map<String, dynamic>> data,
  ) async {
    L.i('sisipkanAtauPerbaruiBatch $tableName mulai (${data.length} item)');
    try {
      final db = await _db.database;
      L.i('sisipkanAtauPerbaruiBatch $tableName db diperoleh');
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        L.i('sisipkanAtauPerbaruiBatch $tableName transaksi dimulai');
        final batch = txn.batch();
        for (final item in data) {
          final itemTs = _setTimestamp(item);
          batch.insert(
            tableName,
            itemTs,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          L.i('sisipkanAtauPerbaruiBatch $tableName item ditambahkan ke batch');
        }
        await batch.commit(noResult: true);
        L.i('sisipkanAtauPerbaruiBatch $tableName batch di-commit');
      });
      L.s(
        '✅ Berhasil melakukan batch insert ke $tableName (${data.length} item)',
      );
    } catch (e, s) {
      L.e('Gagal melakukan batch insert ke $tableName $e $s');
      rethrow;
    } finally {
      L.i('sisipkanAtauPerbaruiBatch $tableName selesai');
    }
  }
}

@Riverpod(keepAlive: true)
/// Provider untuk instance [BaseOpSqflite].
BaseOpSqflite baseOpSqflite(Ref ref) {
  L.i('baseOpSqflite provider dibuat');
  return BaseOpSqflite(ref.read(dbSqfliteProvider));
}
```


// ============================================================
// FILE: lib/shared/operasi/database_service.dart
// ============================================================

```dart
// lib/shared/operasi/database_service.dart

import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_service.g.dart';

/// Antarmuka abstraksi untuk operasi database.
abstract class DatabaseService {
  /// Mengambil semua data dari tabel.
  Future<List<Map<String, dynamic>>> ambilData(String table);

  /// Mengambil data dari tabel dengan klausa WHERE.
  Future<List<Map<String, dynamic>>> ambilDataDenganWhere(
    String table,
    String where,
    List<dynamic> whereArgs,
  );

  /// Menambahkan data baru ke tabel.
  Future<void> tambah(String table, Map<String, dynamic> data);

  /// Memperbarui data di tabel berdasarkan [id].
  Future<void> perbarui(String table, Map<String, dynamic> data, String id);

  /// Menghapus data dari tabel berdasarkan [id].
  Future<void> hapus(String table, String id);

  /// Menghapus data dari tabel berdasarkan klausa WHERE.
  Future<void> hapusDenganWhere(
    String table,
    String where,
    List<dynamic> whereArgs,
  );

  /// Menghapus semua data dari tabel.
  Future<void> hapusSemua(String table);

  /// Melakukan batch insert atau perbarui data ke tabel.
  Future<void> sisipkanAtauPerbaruiBatch(
    String tableName,
    List<Map<String, dynamic>> data,
  );
}

@Riverpod(keepAlive: true)
/// Provider untuk instance [DatabaseService].
DatabaseService databaseService(Ref ref) {
  return ref.read(baseOpSqfliteProvider);
}
```


// ============================================================
// FILE: lib/shared/provider/pemilih_kendaraan_provider.dart
// ============================================================

```dart
import 'package:myapp/shared/enum/page_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pemilih_kendaraan_provider.g.dart';

@Riverpod()
String? pemilihKendaraan(Ref ref, PageEnum page, String? value) {
  return value;
}
```


// ============================================================
// FILE: lib/shared/sinkronisasi/google_drive_helper.dart
// ============================================================

```dart
// lib/shared/sinkronisasi/google_drive_helper.dart

import 'dart:async';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:share_global_saya/core_shared.dart';

/// Helper login Google dan backup/restore database ke Google Drive (appDataFolder).
class GoogleDriveHelper {
  GoogleDriveHelper._();

  static final List<String> _scopes = <String>[
    drive.DriveApi.driveAppdataScope,
  ];

  static GoogleSignInAccount? _akun;

  /// Panggil sekali di main() sebelum runApp.
  static Future<void> initialize({required String serverClientId}) async {
    await GoogleSignIn.instance.initialize(serverClientId: serverClientId);
  }

  /// Status apakah user sudah login ke Google.
  static bool get sudahLogin => _akun != null;

  /// Email user yang login, boleh null.
  static String? get email => _akun?.email;

  /// Login + minta izin akses Drive.
  static Future<GoogleSignInAccount?> login() async {
    try {
      // authenticate() throw GoogleSignInException kalau user batal / gagal.
      final akun = await GoogleSignIn.instance.authenticate();

      // authorizeScopes() non-nullable, throw kalau gagal.
      await akun.authorizationClient.authorizeScopes(_scopes);

      _akun = akun;
      L.s('Login berhasil: ${akun.email}');
      return akun;
    } on GoogleSignInException catch (e) {
      L.w('login dibatalkan / gagal: ${e.code} - ${e.description}');
      rethrow;
    } catch (e, s) {
      L.e('login gagal: $e $s');
      rethrow;
    }
  }

  /// Coba login tanpa buka dialog. Return `true` kalau user sudah punya sesi sebelumnya + izin scope masih valid. Return `false` kalau butuh login interaktif atau platform tidak mendukung.
  static Future<bool> cobaLoginOtomatis() async {
    try {
      final future = GoogleSignIn.instance.attemptLightweightAuthentication();
      if (future == null) {
        L.i('Auto-login: tidak didukung platform ini');
        return false;
      }

      final akun = await future;
      if (akun == null) {
        L.i('Auto-login: tidak ada sesi tersimpan');
        return false;
      }

      final otorisasi = await akun.authorizationClient.authorizationForScopes(
        _scopes,
      );
      if (otorisasi == null) {
        L.i('Auto-login: butuh izin scope dari user (interaktif)');
        _akun = akun;
        return false;
      }

      _akun = akun;
      L.s('Auto-login berhasil: ${akun.email}');
      return true;
    } catch (e, s) {
      L.i('Auto-login dilewati: $e $s');
      return false;
    }
  }

  /// Keluar dari sesi Google login.
  static Future<void> logout() async {
    try {
      await GoogleSignIn.instance.signOut();
      _akun = null;
    } catch (e, s) {
      L.e('logout gagal: $e $s');
      rethrow;
    }
  }

  // Menyimpan HTTP client agar bisa ditutup setelah operasi Google Drive
  static http.Client? _client;

  /// Bangun DriveApi client terautentikasi. Otomatis minta ulang otorisasi kalau access token sudah tidak ada.
  static Future<drive.DriveApi?> _getDriveApi() async {
    final akun = _akun;
    if (akun == null) return null;

    var otorisasi = await akun.authorizationClient.authorizationForScopes(
      _scopes,
    );
    otorisasi ??= await akun.authorizationClient.authorizeScopes(_scopes);
    final token = otorisasi.accessToken;
    if (token.isEmpty) return null;
    // Bangun AccessCredentials manual.
    // Expiry 1 jam dari sekarang — Google access token default 1 jam.
    final credentials = auth.AccessCredentials(
      auth.AccessToken(
        'Bearer',
        token,
        DateTime.now().toUtc().add(const Duration(hours: 1)),
      ),
      null, // tidak ada refresh token di mobile flow
      _scopes,
    );

    final client = auth.authenticatedClient(http.Client(), credentials);
    _client = client;
    return drive.DriveApi(client);
  }

  /// Upload file ke appDataFolder. Kalau file dengan nama sama sudah ada, file lama dihapus dulu supaya tidak menumpuk.
  static Future<bool> uploadFile({
    required File file,
    required String namaFile,
  }) async {
    try {
      final driveApi = await _getDriveApi();
      if (driveApi == null) {
        L.w('upload: DriveApi null');
        return false;
      }

      // Cek file existing dengan nama sama di appDataFolder.
      final namaAman = namaFile.replaceAll("'", "\\'");
      final hasilList = await driveApi.files.list(
        spaces: 'appDataFolder',
        q: "name = '$namaAman' and trashed = false",
      );
      final fileLama = hasilList.files;

      final panjangFile = await file.length();
      final media = drive.Media(file.openRead(), panjangFile);
      final metadata = drive.File()
        ..name = namaFile
        ..parents = ['appDataFolder'];

      final fileBaru = await driveApi.files.create(
        metadata,
        uploadMedia: media,
      );
      L.s('Upload berhasil: $namaFile');

      // Hapus file lama setelah upload baru berhasil; kegagalan hapus tidak membatalkan upload
      try {
        if (fileLama != null && fileLama.isNotEmpty) {
          for (final lama in fileLama) {
            final idLama = lama.id;
            if (idLama != null && idLama != fileBaru.id) {
              await driveApi.files.delete(idLama);
              L.i('File lama dihapus: $idLama');
            }
          }
        }
      } catch (deleteErr) {
        L.w('Gagal hapus file lama (upload tetap berhasil): $deleteErr');
      }
      return true;
    } catch (e, s) {
      L.e('upload gagal: $e $s');
      return false;
    } finally {
      _client?.close();
    }
  }

  /// Download file dari appDataFolder ke path lokal.
  static Future<bool> downloadFile({
    required String namaFile,
    required String simpanKePath,
  }) async {
    try {
      final driveApi = await _getDriveApi();
      if (driveApi == null) {
        L.w('download: DriveApi null');
        return false;
      }

      final namaAman = namaFile.replaceAll("'", "\\'");
      final hasilList = await driveApi.files.list(
        spaces: 'appDataFolder',
        q: "name = '$namaAman' and trashed = false",
      );
      final files = hasilList.files;
      if (files == null || files.isEmpty) {
        L.w('File $namaFile tidak ditemukan di Drive');
        return false;
      }

      final idFile = files.first.id;
      if (idFile == null) {
        L.w('File $namaFile tidak memiliki id');
        return false;
      }

      final hasil = await driveApi.files.get(
        idFile,
        downloadOptions: drive.DownloadOptions.fullMedia,
      );
      if (hasil is! drive.Media) {
        L.w('Response download bukan Media');
        return false;
      }
      final media = hasil;

      final fileTujuan = File(simpanKePath);
      final fileSementara = File('$simpanKePath.tmp');
      try {
        await fileTujuan.parent.create(recursive: true);
        final sink = fileSementara.openWrite();
        try {
          await media.stream.pipe(sink);
        } finally {
          await sink.close();
        }
        // Rename file sementara ke target (replace atomically jika di filesystem yang sama).
        // Jika gagal karena file target sudah ada (Windows), hapus target lalu rename.
        try {
          await fileSementara.rename(simpanKePath);
        } on FileSystemException catch (_) {
          if (await fileTujuan.exists()) {
            await fileTujuan.delete();
          }
          await fileSementara.rename(simpanKePath);
        }
      } catch (e) {
        if (await fileSementara.exists()) {
          await fileSementara.delete();
        }
        rethrow;
      }
      L.s('Download berhasil: $simpanKePath');
      return true;
    } catch (e, s) {
      L.e('download gagal: $e $s');
      return false;
    } finally {
      // Bersihkan sisa file sementara agar tidak tertinggal setelah download/crash
      try {
        await File('$simpanKePath.tmp').delete();
      } catch (e, s) {
        // Pembersihan file sementara gagal tidak memengaruhi hasil download; catat untuk penelusuran.
        L.w('Gagal menghapus file sementara: $e $s');
      }
      _client?.close();
    }
  }
}
```


// ============================================================
// FILE: lib/shared/tema/enum/tema_aplikasi_enum.dart
// ============================================================

```dart
// lib/shared/tema/enum/tema_aplikasi_enum.dart

import 'package:flutter/material.dart';

/// Pilihan tema aplikasi.
enum TemaAplikasi {
  /// Mengikuti tema perangkat.
  sistem,

  /// Selalu tema terang.
  terang,

  /// Selalu tema gelap.
  gelap,
}

/// Extension untuk [TemaAplikasi] yang menyediakan label dan ikon tampilan.
extension TemaAplikasiExtension on TemaAplikasi {
  /// Label teks yang ditampilkan kepada pengguna.
  String get label {
    switch (this) {
      case TemaAplikasi.sistem:
        return 'Sistem';
      case TemaAplikasi.terang:
        return 'Terang';
      case TemaAplikasi.gelap:
        return 'Gelap';
    }
  }

  /// Ikon yang merepresentasikan pilihan tema.
  IconData get icon {
    switch (this) {
      case TemaAplikasi.sistem:
        return Icons.brightness_auto;
      case TemaAplikasi.terang:
        return Icons.light_mode;
      case TemaAplikasi.gelap:
        return Icons.dark_mode;
    }
  }
}
```


// ============================================================
// FILE: lib/shared/tema/font.dart
// ============================================================

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_global_saya/core_shared.dart';

/// Menerapkan font Inter ke seluruh style TextTheme tanpa konflik tipe antar package Material.
TextTheme terapkanFontInter(TextTheme base) {
  TextStyle? terapkan(TextStyle? style) {
    if (style == null) return null;
    try {
      return GoogleFonts.inter(textStyle: style);
    } catch (e, s) {
      // Jika font Inter gagal dimuat (mis. offline), gunakan style dasar agar UI tetap tampil.
      L.e('Gagal menerapkan font Inter: $e $s');
      return style;
    }
  }

  return base.copyWith(
    displayLarge: terapkan(base.displayLarge),
    displayMedium: terapkan(base.displayMedium),
    displaySmall: terapkan(base.displaySmall),
    headlineLarge: terapkan(base.headlineLarge),
    headlineMedium: terapkan(base.headlineMedium),
    headlineSmall: terapkan(base.headlineSmall),
    titleLarge: terapkan(base.titleLarge),
    titleMedium: terapkan(base.titleMedium),
    titleSmall: terapkan(base.titleSmall),
    bodyLarge: terapkan(base.bodyLarge),
    bodyMedium: terapkan(base.bodyMedium),
    bodySmall: terapkan(base.bodySmall),
    labelLarge: terapkan(base.labelLarge),
    labelMedium: terapkan(base.labelMedium),
    labelSmall: terapkan(base.labelSmall),
  );
}
```


// ============================================================
// FILE: lib/shared/tema/tema_provider.dart
// ============================================================

```dart
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:myapp/shared/konstanta/shared_keys.dart';
import 'package:myapp/shared/tema/enum/tema_aplikasi_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

export 'package:myapp/shared/tema/enum/tema_aplikasi_enum.dart';

part 'tema_provider.g.dart';

/// Provider untuk menyimpan dan mengambil preferensi tema aplikasi.
@Riverpod(keepAlive: true)
class TemaAplikasiNotifier extends _$TemaAplikasiNotifier {
  @override
  Future<TemaAplikasi> build() async {
    final nilai = await SharedPrefService.getString(KunciShared.temaAplikasi);
    // Menggunakan firstWhereOrNull dari package:collection sesuai AGENTS.md.
    return TemaAplikasi.values.firstWhereOrNull((e) => e.name == nilai) ??
        TemaAplikasi.terang;
  }

  /// Menyimpan preferensi tema aplikasi.
  Future<void> set(TemaAplikasi tema) async {
    try {
      await SharedPrefService.setString(KunciShared.temaAplikasi, tema.name);
      state = AsyncData(tema);
    } catch (e, s) {
      L.e('Gagal menyimpan tema aplikasi: $e $s');
      rethrow;
    }
  }
}

/// Provider yang mengonversi preferensi tema menjadi [ThemeMode].
@Riverpod(keepAlive: true)
ThemeMode temaMode(Ref ref) {
  final asyncTema = ref.watch(temaAplikasiProvider);
  // Saat loading/error gunakan tema sistem sebagai fallback (bukan menyembunyikan status).
  if (asyncTema.isLoading || asyncTema.hasError) {
    return ThemeMode.system;
  }
  final tema = asyncTema.requireValue;
  switch (tema) {
    case TemaAplikasi.terang:
      return ThemeMode.light;
    case TemaAplikasi.gelap:
      return ThemeMode.dark;
    case TemaAplikasi.sistem:
      return ThemeMode.system;
  }
}
```


// ============================================================
// FILE: lib/shared/widget/kendaraan_terpilih_list.dart
// ============================================================

```dart
// lib/shared/widget/kendaraan_terpilih_list.dart

import 'package:flutter/material.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';

/// Widget daftar chip kendaraan terpilih yang dapat digunakan ulang di beberapa halaman.
class KendaraanTerpilihList extends StatefulWidget {
  /// Daftar kendaraan yang akan ditampilkan sebagai chip.
  final List<KendaraanModel> listKendaraan;

  /// Id kendaraan yang sedang terpilih (null berarti "Semua").
  final String? selectedId;

  /// Callback saat chip kendaraan ditekan.
  final ValueChanged<KendaraanModel?> onSelected;

  /// Callback saat tombol reload ditekan.
  final VoidCallback? onReload;

  /// Tinggi area daftar chip.
  final double height;

  /// Buat daftar chip kendaraan terpilih.
  const KendaraanTerpilihList({
    super.key,
    required this.listKendaraan,
    required this.selectedId,
    required this.onSelected,
    this.onReload,
    this.height = 44,
  });

  @override
  State<KendaraanTerpilihList> createState() => _KendaraanTerpilihListState();
}

class _KendaraanTerpilihListState extends State<KendaraanTerpilihList> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _itemKeys = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollKeTerpilih();
    });
  }

  @override
  void didUpdateWidget(covariant KendaraanTerpilihList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedId != widget.selectedId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollKeTerpilih();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollKeTerpilih() {
    int index;
    if (widget.selectedId == null) {
      index = 0;
    } else {
      final ditemukan = widget.listKendaraan.indexWhere(
        (k) => k.id == widget.selectedId,
      );
      // Hindari scroll ke chip "Semua" (index 0) jika selectedId tidak ditemukan.
      if (ditemukan < 0) return;
      index = ditemukan + 1;
    }
    if (index < 0) return;
    final key = _itemKeys[index];
    final context = key?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        alignment: 0.5,
        duration: const Duration(milliseconds: 200),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        children: [
          const Text('Kendaraan:'),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: widget.listKendaraan.length + 1,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final key = _itemKeys.putIfAbsent(index, GlobalKey.new);
                if (index == 0) {
                  return _buildItem(null, key);
                }
                final item = widget.listKendaraan[index - 1];
                return _buildItem(item, key);
              },
            ),
          ),
          if (widget.onReload != null)
            IconButton(
              tooltip: 'Muat ulang',
              iconSize: 24,
              alignment: Alignment.center,
              icon: const Icon(Icons.replay),
              onPressed: widget.onReload,
            ),
        ],
      ),
    );
  }

  Widget _buildItem(KendaraanModel? kendaraan, GlobalKey key) {
    final terpilih = widget.selectedId == kendaraan?.id;
    return ChoiceChip(
      key: key,
      label: Text(kendaraan?.nama ?? 'Semua'),
      selected: terpilih,
      selectedColor: Theme.of(context).colorScheme.primary,
      onSelected: (_) => widget.onSelected(kendaraan),
      showCheckmark: false,
      labelStyle: TextStyle(
        color: terpilih
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/shared/widget/modal_loading_widget.dart
// ============================================================

```dart
// lib/shared/widget/modal_loading_widget.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_global_saya/core_shared.dart';

/// Widget konten modal loading yang dapat dipakai ulang. Tampilkan dengan [showDialog] dan tutup dengan [Nav.pop].
class ModalLoadingWidget extends StatelessWidget {
  /// Pesan yang ditampilkan di bawah spinner.
  final String pesan;

  /// Membuat [ModalLoadingWidget].
  const ModalLoadingWidget({super.key, this.pesan = 'Memuat...'});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(height: 16),
              FittedBox(
                child: Text(
                  pesan,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Menampilkan modal loading full-screen yang tidak bisa ditutup pengguna. Mengembalikan fungsi penutup yang idempotent (aman dipanggil berkali-kali).
VoidCallback tampilkanModalLoading(
  BuildContext context, {
  String pesan = 'Memuat...',
  bool barrierDismissible = false,
}) {
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Theme.of(context)
          .colorScheme
          .scrim, // Konsisten tema (DESAINS.md 5)
      builder: (context) => ModalLoadingWidget(pesan: pesan),
    ),
  );
  var ditutup = false;
  return () {
    if (ditutup) return;
    ditutup = true;
    if (context.mounted) {
      final navigator = Navigator.of(context);
      if (navigator.canPop()) {
        Nav.pop(context);
      }
    }
  };
}

/// Menutup modal loading jika sedang tampil (kurang aman; prefer closure).
void tutupModalLoading(BuildContext context) {
  if (!context.mounted) return;
  final navigator = Navigator.of(context);
  if (navigator.canPop()) {
    Nav.pop(context);
  }
}
```


// ============================================================
// FILE: lib/shared/widget/pemilih_kendaraan.dart
// ============================================================

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:universal_io/io.dart';

/// Widget pemilih kendaraan.
class PemilihKendaraan extends ConsumerStatefulWidget {
  /// Kendaraan yang sedang terpilih.
  final KendaraanModel kendaraanTerpilih;

  /// Daftar kendaraan yang tersedia.
  final List<KendaraanModel> listKendaraan;

  /// Callback saat kendaraan dipilih.
  final ValueChanged<KendaraanModel>? onSelected;

  /// Membuat [PemilihKendaraan].
  const PemilihKendaraan({
    super.key,
    required this.kendaraanTerpilih,
    required this.listKendaraan,
    this.onSelected,
  });

  @override
  ConsumerState<PemilihKendaraan> createState() => _PemilihKendaraanState();
}

class _PemilihKendaraanState extends ConsumerState<PemilihKendaraan> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _modalPilihKendaraan() async {
    final list = widget.listKendaraan;
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (ctx, idx) {
                final item = list[idx];
                final gambar = item.pathGambar;
                return Card(
                  child: ListTile(
                    leading: gambar == null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                            child: Icon(
                              Icons.directions_car,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          )
                        : Image.file(
                            File(gambar),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                const Icon(Icons.broken_image),
                          ),
                    title: Text(item.nama),
                    subtitle: Text(item.merk),
                    onTap: () {
                      widget.onSelected?.call(item);
                      // Perbaikan: gunakan Nav.pop sesuai konvensi navigasi proyek.
                      Nav.pop(context);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: widget.listKendaraan.length,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final kendaraan = widget.kendaraanTerpilih;
    final pathGambar = kendaraan.pathGambar;
    return Card(
      child: ListTile(
        leading: pathGambar == null
            ? const Icon(Icons.directions_car)
            : Image.file(
                File(pathGambar),
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
              ),
        title: Text(kendaraan.nama),
        subtitle: Text(kendaraan.merk),
        trailing: IconButton(
          icon: const Icon(Icons.swap_horiz),
          onPressed: _modalPilihKendaraan,
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/shared/widget/scroll_ke_atas.dart
// ============================================================

```dart
// lib/shared/widget/scroll_ke_atas.dart
// Interface untuk state halaman yang mendukung scroll ke atas.

/// Kontrak untuk state halaman yang menyediakan aksi scroll ke atas.
abstract class ScrollKeAtas {
  /// Menggulir tampilan ke posisi paling atas.
  void scrollToTop();
}
```


