---
name: migrasi-skema-sqlite
description: Panduan migrasi skema database SQLite - naikkan versi, update onCreate dan onUpgrade dengan kondisi versi, gunakan konstanta nama tabel/kolom.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "3b67d3095dacc4e5c7ea78d7eb251809e3e9d981"
  model: "kilo-auto/free"
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

## Larangan

- Jangan menaikkan versi database tanpa memperbarui `onCreate` dan `onUpgrade`.
- Jangan membuat tabel baru hanya di `onCreate` tanpa menangani `onUpgrade` (pengguna lama tidak akan mendapatkan tabel).
- Jangan menggunakan string literal untuk nama tabel/kolom baru.
- Jangan menghapus data pengguna saat migrasi kecuali memang diperlukan dan terdokumentasi.

## Contoh Benar

```dart
static const int _versiDatabase = 5;

// onCreate: buat semua tabel.
await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.diaryCraving}(...)');

// onUpgrade:
if (oldVersion < 5) {
  await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.diaryCraving}(...)');
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

- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/shared/db/sqflite/sqflite.dart`, `lib/shared/konstanta/nama_tabel.dart`, `lib/shared/konstanta/nama_kolom.dart`