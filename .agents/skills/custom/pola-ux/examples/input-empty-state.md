# Contoh Input: Empty State Daftar Kosong

## Konteks
Layar menampilkan daftar data (diary craving, impian, badge, dll). Ketika data kosong, perlu menampilkan empty state yang informatif dengan call-to-action.

## Permintaan
Buat widget empty state reusable yang menampilkan ikon, judul, deskripsi, dan FAB untuk menambah data.

## Batasan
- Wajib `SafeArea` + padding tepi layar.
- Ikon, judul, deskripsi singkat.
- FAB/Call-to-action untuk navigasi ke form tambah.
- Menggunakan `spacing` pada `Column` untuk jarak konsisten.

## Informasi Tambahan
- Navigasi: `Nav.to(context, const FormDiaryCraving())`
- Ikon: `CupertinoIcons.book` (sesuaikan per fitur)