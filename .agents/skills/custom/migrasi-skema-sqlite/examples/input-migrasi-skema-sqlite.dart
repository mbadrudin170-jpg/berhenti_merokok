// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
class AppDatabaseSalah {
  static const int _versiDatabase = 5;

  // onCreate hanya membuat tabel lama, tidak ada tabel diary_craving
  static Future<void> onCreate(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS biodata(...)');
    await db.execute('CREATE TABLE IF NOT EXISTS impian(...)');
    // Tabel diary_craving TIDAK dibuat di sini
  }

  // onUpgrade tidak menangani v5
  static Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
      await db.execute('CREATE TABLE IF NOT EXISTS alasan_berhenti(...)');
    }
    // oldVersion < 5 TIDAK ditangani
  }
}