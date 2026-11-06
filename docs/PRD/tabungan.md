# MASALAH

- user bisa mencatat uang masuk dan keluar
- user bisa tahu total pemasukan, total pengeluaran dan total uang sekarang.
- user bisa lihat detail transaksi,
- user bisa menghapus transaksi tertentu.
- user bisa mencari transaksi tertentu.
- saya ingin ada dummy-nya jadi saya bisa menambahkan dummy ini ke Sqflite.
- user bisa melihat total pemasukan, pengeluaran, dan saldo saat ini.
- user bisa melihat list transaksi, jam, dan jumlah, lalu dikelompokkan berdasarkan tanggal.
- user bisa menghapus transaksi tertentu.

# SOLUSI

<!-- semua masalah diatas harus diberikan solusi -->

## Fitur yang Harus Dibuat

### Fitur 1: Input dan Catatan Transaksi Tabungan (Mencatat uang masuk dan keluar)

Solusi untuk masalah: user bisa mencatat uang masuk dan keluar.

- Buat halaman `form_tabungan.dart` dengan form input yang berisi field deskripsi, jumlah, tanggal, dan tipe transaksi (`TipeTransaksiEnum.pemasukan` / `TipeTransaksiEnum.pengeluaran`).
- Saat form disimpan, panggil `TabunganNotifier.tambah()` yang menyimpan data ke tabel `tabungan` di sqflite melalui `baseOpSqfliteProvider.tambah()` dengan optimistic update dan rollback jika gagal.
- Model `TabunganModel` sudah mendukung konversi sqflite via `fromSqflite()` dan `toSqflite()` menggunakan konstanta di `NamaKolom` dan `NamaTabel`.

### Fitur 2: Ringkasan Saldo dan Detail Transaksi (Total pemasukan, pengeluaran, dan saldo sekarang + lihat detail)

Solusi untuk masalah: user bisa tahu total pemasukan, total pengeluaran dan total uang sekarang; user bisa lihat detail transaksi; menampilkan list transaksi, jam, dan jumlah, lalu dikelompokkan berdasarkan tanggal.

- Di `TabunganState`, tambahkan getter perhitungan: `getTotalPemasukan(idKendaraan)`, `getTotalPengeluaran(idKendaraan)`, dan `getSaldo(idKendaraan)` yang sudah tersedia dan difilter berdasarkan `idKendaraan` yang terpilih.
- Tampilkan 3 angka ringkasan (total pemasukan, total pengeluaran, saldo) di halaman `tabungan_page.dart`.
- Buat halaman `detail_tabungan.dart` yang menampilkan detail lengkap satu transaksi berdasarkan `id` (deskripsi, jumlah, tipe, tanggal, diperbarui, diarsipkan).
- Tampilkan list transaksi dengan kolom jam dan jumlah di `tabungan_page.dart`, dikelompokkan berdasarkan tanggal agar user mudah melacak riwayat transaksi per hari.

### Fitur 3: Hapus, Cari, dan Dummy Data Transaksi

Solusi untuk masalah: user bisa menghapus transaksi tertentu; user bisa mencari transaksi tertentu; saya ingin ada dummy nya jadi saya bisa menambahkan dummy ini ke sqflite.

- Hapus transaksi: panggil `TabunganNotifier.hapus(id)` yang menghapus data dari state dulu (optimistic) baru ke sqflite via `baseOpSqfliteProvider.hapus()` dengan rollback jika gagal.
- Cari transaksi: tambahkan fitur pencarian/filter di `tabungan_page.dart` yang memfilter `listTabungan` berdasarkan deskripsi (dan optional tanggal/tipe transaksi) menggunakan query WHERE LIKE di sqflite atau filter di Dart pada state.
- Dummy data: buat data dummy tabungan di `lib/fitur/dummy/dummy_data/dummy_tabungan.dart` (sesuai pola dummy kendaraan/km/komponen yang ada) yang berisi daftar `TabunganModel` dengan `idKendaraan`, deskripsi, jumlah, tanggal, dan tipe transaksi varied.
- Tambahkan fungsi dummy di `lib/fitur/dummy/dummy_helper.dart` untuk memasukkan dummy tabungan ke sqflite melalui `baseOpSqfliteProvider.tambah()` satu per satu, sehingga user bisa mengisi data awal untuk pengujian.
