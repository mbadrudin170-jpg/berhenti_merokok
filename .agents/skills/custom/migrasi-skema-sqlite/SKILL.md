---
name: migrasi-skema-sqlite
description: Panduan migrasi skema database SQLite - naikkan versi, update onCreate dan onUpgrade dengan kondisi versi, gunakan konstanta nama tabel/kolom.
metadata:
  kategori: "custom"
  versi: "1.1.0"
  commit-terakhir: "50c1be708e595449fa2fd18e3491d4418943c565"
  model: "openrouter/thinkingmachines/inkling-2-small:free"
---

# Migrasi Skema Database SQLite

Setiap perubahan skema wajib menaikkan versi database, update `onCreate` dan `onUpgrade` dengan kondisi versi yang sesuai.

## Aturan

1. Setiap perubahan skema wajib menaikkan konstanta `_versiDatabase` (increment satu per migrasi).
2. Metode `onCreate` wajib membuat seluruh tabel yang dibutuhkan aplikasi, termasuk tabel baru, agar instalasi baru memiliki skema lengkap.
3. Metode `onUpgrade` wajib menangani setiap versi lama secara kondisional menggunakan `if (oldVersion < N)` untuk setiap versi yang ditambahkan.
4. Tabel baru pada versi tertentu wajib dibuat baik di `onCreate` maupun di `onUpgrade` (agar pengguna lama mendapatkan tabel baru).
5. Nama tabel dan kolom baru wajib didefinisikan di `NamaTabel` dan `NamaKolom`, bukan string literal di kode database.
6. Perubahan kolom pada tabel lama wajib menggunakan `ALTER TABLE ... ADD COLUMN` di `onUpgrade` dengan kondisi versi yang sesuai.
7. Setiap tabel wajib didefinisikan tepat sekali pada cabang `if (oldVersion < N)` yang seharusnya membuatnya. Dilarang menduplikasi DDL tabel yang sama di dua cabang versi (mis. `sos_intervensi` di cabang v9 dan v11 sekaligus); `onCreate` tetap membuat semua tabel, `onUpgrade` hanya membuat tabel milik versinya.
8. Perubahan penamaan nilai enum yang dipersistenkan ke kolom `TEXT` wajib disertai migrasi data pada cabang versi baru memakai `rawUpdate` dengan pola `UPDATE <tabel> SET <kolom> = ? WHERE <kolom> = ?` untuk setiap pemetaan nilai lama → baru (contoh v12: `napas_478` → `napas478` pada `diary_craving.strategi`, `diary_craving.hasil`, `sos_intervensi.jenis_intervensi`, `sos_intervensi.hasil_intervensi`). Tanpa migrasi ini nilai lama gagal diparse `safeParseEnum`.
9. Tambahkan komentar singkat di atas konstanta `_versiDatabase` yang menjelaskan isi setiap versi (mis. `// Versi 13: tabel rencana_darurat (if-then plan).`).
10. Ratakan indentasi blok `onUpgrade` agar konsisten dengan blok lain (spasi, bukan campuran tab/spasi).
11. Indeks (`CREATE INDEX IF NOT EXISTS ...`) pada tabel baru wajib dibuat di cabang versi yang sama dengan pembuatan tabelnya, bukan di cabang versi lain.

## Larangan

- Jangan menaikkan versi database tanpa memperbarui `onCreate` dan `onUpgrade`.
- Jangan membuat tabel baru hanya di `onCreate` tanpa menangani `onUpgrade` (pengguna lama tidak akan mendapatkan tabel).
- Jangan menduplikasi `CREATE TABLE` tabel yang sama di dua cabang `if (oldVersion < N)`; satu tabel tepat satu cabang versinya.
- Jangan mengubah nilai enum yang tersimpan di kolom database tanpa migrasi data pada cabang versi baru.
- Jangan menggunakan string literal untuk nama tabel/kolom baru.
- Jangan menghapus data pengguna saat migrasi kecuali memang diperlukan dan terdokumentasi.

## Contoh Benar

```dart
// Versi 12: migrasi nilai enum snake_case lama ke lowerCamelCase.
// Versi 13: tabel rencana_darurat (if-then plan).
static const int _versiDatabase = 13;

// onCreate: buat semua tabel (konsumsi_rokok, sos_intervensi, rencana_darurat, ...).
await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.rencanaDarurat}(...)');

// onUpgrade:
if (oldVersion < 9) {
  // HANYA konsumsi_rokok + indeks idx_konsumsi_tanggal.
  await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.konsumsiRokok}(...)');
  await db.execute('CREATE INDEX IF NOT EXISTS idx_konsumsi_tanggal ON ${NamaTabel.konsumsiRokok}(${NamaKolom.tanggal})');
}
if (oldVersion < 11) {
  // HANYA sos_intervensi (tepat sekali, bukan di cabang v9).
  await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.sosIntervensi}(...)');
}
if (oldVersion < 12) {
  // Migrasi data nilai enum lama ke baru.
  const pemetaan = <String, String>{'napas_478': 'napas478', 'belum_selesai': 'belumSelesai'};
  for (final entry in pemetaan.entries) {
    await db.rawUpdate(
      'UPDATE ${NamaTabel.diaryCraving} SET ${NamaKolom.strategi} = ? WHERE ${NamaKolom.strategi} = ?',
      [entry.value, entry.key],
    );
  }
}
if (oldVersion < 13) {
  // HANYA rencana_darurat.
  await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.rencanaDarurat}(...)');
}
```

## Contoh Salah

```dart
// Hanya membuat tabel di onCreate, lupa onUpgrade: pengguna lama tidak mendapatkan tabel.
static const int _versiDatabase = 5;
// onCreate: create table diary_craving
// onUpgrade: (kosong / tidak menangani v5)
```

## Sumber Evaluasi

- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`, `a15acd9603fe5d1251afa4acc3817e7e9c1607b1` (DDL ganda v9/v11), `a5beae01b86a4d9753963380818bc437c2b4741a` (migrasi enum v12), `db5dd32f28e92346b9a8d3467fa9b2838e013a02` (v13 rencana_darurat), `2462af81050e12b2933717f457a33a5b05d3719f` (hapus duplikasi v11), `50c1be708e595449fa2fd18e3491d4418943c565` (hapus DDL ganda dari v9)
- File: `lib/shared/db/sqflite/sqflite.dart`, `lib/shared/konstanta/nama_tabel.dart`, `lib/shared/konstanta/nama_kolom.dart`