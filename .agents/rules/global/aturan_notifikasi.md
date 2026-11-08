# Aturan Implementasi Notifikasi Lokal

## 1. Library Notifikasi

- Wajib menggunakan package `flutter_local_notifications` untuk menangani notifikasi lokal.
- Inisialisasi `flutter_local_notifications` wajib dilakukan di dalam fungsi `main()` sebelum aplikasi dijalankan.
- Sebelum mengimplementasikan notifikasi, periksa versi `flutter_local_notifications` yang sudah terpasang di `pubspec.lock` dan baca dokumentasi atau API yang sesuai dengan versi tersebut.
- Jangan mengasumsikan API berdasarkan versi lain atau dokumentasi yang tidak sesuai dengan versi terpasang.

## 2. Penjadwalan Notifikasi

- Wajib menggunakan package `timezone` dengan alias `tz` untuk menangani waktu dan penjadwalan notifikasi.
- Gunakan API penjadwalan berbasis timezone agar waktu notifikasi sesuai dengan zona waktu perangkat atau zona waktu yang telah ditentukan aplikasi.
- Pastikan konfigurasi timezone dilakukan sebelum menjadwalkan notifikasi.
- Jangan menggunakan perhitungan waktu manual yang mengabaikan perbedaan zona waktu.

## 3. Payload dan Navigasi

- Setiap notifikasi wajib memiliki `payload`.
- Payload wajib memuat:
  - `kategori`: jenis atau kategori notifikasi.
  - `id`: identitas data atau item yang menjadi tujuan notifikasi.
- Gunakan payload tersebut untuk menentukan halaman tujuan dan mengambil data yang sesuai ketika pengguna mengetuk notifikasi.
- Tangani kondisi ketika kategori tidak dikenal, ID tidak valid, atau data tujuan sudah tidak tersedia. Jangan menyebabkan aplikasi mengalami crash.

## 4. Pengelolaan ID Notifikasi

- Setiap notifikasi wajib memiliki ID numerik yang unik dan stabil sesuai kebutuhan pengelolaannya.
- Gunakan salah satu pendekatan berikut:
  - ID yang dihasilkan dari UUID v4 dan dikonversi secara konsisten menjadi integer yang valid.
  - ID unik milik item atau data yang berkaitan dengan notifikasi, jika tersedia dan memenuhi ketentuan tipe ID yang dibutuhkan package.
- Jangan menggunakan tanggal, timestamp, atau gabungan tanggal dan waktu sebagai ID notifikasi.
- Pastikan ID yang sama digunakan ketika memperbarui atau membatalkan notifikasi yang sama.
- Pastikan notifikasi yang berbeda tidak menggunakan ID yang sama sehingga tidak saling menimpa secara tidak sengaja.

## 5. Pengelolaan Izin Notifikasi

- Wajib menangani permintaan dan pemeriksaan izin notifikasi sesuai platform.
- Perhatikan perbedaan mekanisme izin pada Android dan iOS.
- Pada Android, tangani izin notifikasi runtime sesuai versi Android yang digunakan.
- Pada iOS, tangani otorisasi notifikasi sesuai mekanisme yang disediakan platform.
- Jangan mengasumsikan izin selalu diberikan oleh pengguna.
- Jika izin ditolak, aplikasi harus menangani kondisi tersebut tanpa menyebabkan crash.
- Jangan menjadwalkan notifikasi yang membutuhkan izin ketika izin yang diperlukan belum tersedia.

## 6. Ikon Notifikasi

- Wajib menyediakan dan mengonfigurasi ikon khusus untuk notifikasi lokal.
- Gunakan ikon aplikasi yang sesuai dengan identitas visual aplikasi.
- Pastikan resource ikon tersedia pada lokasi yang sesuai dengan ketentuan Android.
- Konfigurasikan ikon tersebut pada pengaturan notifikasi Android (`AndroidInitializationSettings` dan/atau konfigurasi notifikasi yang relevan).
- Jangan menggunakan ikon launcher yang tidak sesuai format atau resource yang tidak tersedia.
- Pastikan ikon notifikasi dapat ditampilkan dengan benar pada perangkat Android.
