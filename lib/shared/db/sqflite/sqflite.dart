import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Konfigurasi dan akses database SQLite untuk aplikasi berhenti_merokok.
///
/// Database menggunakan factory default sqflite yang didukung Android.
class AppDatabase {
  AppDatabase._();

  static Database? _database;

  /// Nama file database SQLite.
  static const String _namaDatabase = 'berhenti_merokok.db';

  /// Versi skema database.
  static const int _versiDatabase = 1;

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
    );
  }

  /// Membuat tabel-tabel saat database pertama kali dibuat.
  static Future<void> _buatTabel(Database db, int version) async {
    await db.execute('''
      CREATE TABLE biodata(
        id TEXT PRIMARY KEY,
        nama TEXT NOT NULL,
        tanggal_lahir TEXT,
        jumlah_rokok_per_hari INTEGER,
        harga_rokok_per_bungkus REAL,
        tanggal_mulai_merokok TEXT
      )
    ''');
  }

  /// Menutup database jika sedang terbuka.
  static Future<void> tutupDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
