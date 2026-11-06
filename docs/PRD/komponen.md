# MASALAH

- User bisa memasukkan nama komponen, harga, link ke toko online.
- user bisa cari komponen yang terdaftar.
- user bisa sorting komponen berdasarkan namaAZ, namaZA, harga terendah harga tertinggi.
- user bisa mengisi beberapa link toko online misalnya shopee, tiktok, tokopedia, jadi di linknya kita ada info tokonya.
- saya ingin ada dummy-nya.
- saya ingin link toko nya dikelompokkan berdasarkan nama toko nya.

# SOLUSI

<!-- semua masalah diatas harus diberikan solusi -->

## Fitur yang Harus Dibuat

### Fitur 1: Input dan Manajemen Data Komponen

**Masalah yang diatasi:**

- User bisa memasukkan nama komponen, harga, link ke toko online.
- User bisa mengisi beberapa link toko online misalnya shopee, tiktok, tokopedia, jadi di link nya kita ada info tokonya.

**Solusi:**

- Buat model `LinkToko` yang berisi `namaToko` (contoh: Shopee, TikTok, Tokopedia) dan `url` untuk setiap link toko.
- Ubah `KomponenModel` sehingga menyimpan daftar `List<LinkToko> linkToko` (gantikan field `linkPembelian` tunggal yang hanya menyimpan satu URL tanpa info toko).
- Buat halaman form tambah/edit komponen dengan input nama, harga, dan daftar link toko yang dapat ditambah atau dihapus secara dinamis (nama toko + URL).
- Buat halaman detail komponen yang menampilkan nama, harga, dan daftar link toko dengan tombol buka link ke browser.
- Validasi input: nama wajib diisi, harga wajib diisi dan berupa angka, setiap link toko wajib memiliki nama toko dan URL yang valid.

### Fitur 2: Pencarian dan Pengurutan Komponen

**Masalah yang diatasi:**

- User bisa cari komponen yang terdaftar.
- User bisa sorting komponen berdasarkan namaAZ, namaZA, harga terendah harga tertinggi.

**Solusi:**

- Buat fitur pencarian komponen berdasarkan nama dengan filter case-insensitive.
- Buat enum `SortKomponenEnum` dengan opsi pengurutan: namaAZ, namaZA, hargaAZ, hargaZA.
- Buat UI pengurutan (sort) melalui bottom sheet atau dropdown opsi sorting.
- Terapkan sorting pada daftar komponen yang ditampilkan sesuai opsi yang dipilih user.

### Fitur 3: Data Dummy Komponen

**Masalah yang diatasi:**

- Saya ingin ada dummy nya.

**Solusi:**

- Buat file `dummy_komponen.dart` berisi data dummy komponen dengan id kendaraan, nama, harga, dan beberapa link toko (Shopee, TikTok, Tokopedia).
- Siapkan fungsi seed/insert dummy data ke database Sqflite untuk keperluan pengujian dan demonstrasi.

### Fitur 4: Pengelompokan Link Toko Berdasarkan Nama Toko

**Masalah yang diatasi:**

- Saya ingin grupkan link toko nya berdasarkan nama toko nya.

**Solusi:**

- Pada halaman detail komponen, kelompokkan daftar link toko berdasarkan `namaToko` (Shopee, TikTok, Tokopedia, dll.) menggunakan grouping (Map<String, List<LinkTokoModel>>).
- Tampilkan setiap grup dengan header nama toko dan daftar URL di bawahnya.
- Jika ada beberapa link dengan nama toko yang sama, tampilkan semua URL-nya dalam satu grup.
