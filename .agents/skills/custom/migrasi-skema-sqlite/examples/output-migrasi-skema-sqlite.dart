// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseBenar {
  static const int _versiDatabase = 5;

  // onCreate: buat SEMUA tabel termasuk yang baru
  static Future<void> onCreate(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.biodata}(...)');
    await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.impian}(...)');
    await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.diaryCraving}(...)');
    await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.alasanBerhenti}(...)');
  }

  // onUpgrade: handle setiap versi secara kondisional
  static Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
      await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.alasanBerhenti}(...)');
    }
    if (oldVersion < 5) {
      // Tabel baru di v5 dibuat di sini untuk pengguna lama
      await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.diaryCraving}('
          '${NamaKolom.id} TEXT PRIMARY KEY, '
          '${NamaKolom.tanggal} TEXT NOT NULL, '
          '${NamaKolom.level} INTEGER NOT NULL, '
          '${NamaKolom.catatan} TEXT, '
          '${NamaKolom.dibuatPada} TEXT NOT NULL'
          ')');
    }
  }
}