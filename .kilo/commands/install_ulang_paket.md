# install_ulang_paket.md

## Tujuan

Menginstal ulang seluruh paket yang tercantum dalam `pubspec.yaml` menggunakan perintah `flutter pub add` secara berurutan, kemudian menyusun daftar paket berdasarkan urutan abjad (A–Z).

## Alur Kerja

1. Baca file `pubspec.yaml` untuk mengidentifikasi seluruh paket yang tercantum di dalamnya.
2. Catat seluruh nama paket beserta kelompok dependensinya, yaitu `dependencies` dan `dev_dependencies`.
3. Instal ulang seluruh paket menggunakan perintah `flutter pub add`.
4. Lakukan instalasi satu paket dalam satu waktu. Jangan menjalankan instalasi beberapa paket secara bersamaan.
5. Tunggu hingga proses instalasi paket yang sedang dikerjakan benar-benar selesai sebelum menjalankan perintah instalasi paket berikutnya.
6. Pastikan perintah instalasi paket sebelumnya berhasil sebelum melanjutkan ke paket berikutnya.
7. Sesuaikan perintah instalasi dengan kelompok dependensinya:
   - `dependencies`: gunakan `flutter pub add nama_paket`.
   - `dev_dependencies`: gunakan `flutter pub add --dev nama_paket`.
8. Ulangi proses tersebut sampai seluruh paket yang tercantum dalam `pubspec.yaml` selesai diproses.
9. Setelah seluruh paket berhasil diinstal, susun nama paket berdasarkan urutan abjad (A–Z) pada masing-masing kelompok dependensi.
10. Periksa kembali `pubspec.yaml` untuk memastikan seluruh paket tetap tercantum dan urutannya sudah benar.

## Larangan

1. Dilarang menghapus paket sebelum, selama, maupun sebagai bagian dari proses instalasi ulang.
2. Dilarang menggunakan `flutter pub remove` atau perintah lain yang bertujuan menghapus paket.
3. Dilarang melewatkan paket yang tercantum dalam `pubspec.yaml`.
4. Dilarang menjalankan perintah instalasi beberapa paket sekaligus.
5. Dilarang menjalankan instalasi paket berikutnya sebelum instalasi paket sebelumnya selesai.
6. Dilarang melanjutkan ke paket berikutnya apabila instalasi paket sebelumnya gagal.
7. Dilarang menambahkan paket baru yang tidak tercantum dalam `pubspec.yaml`.
8. Dilarang mengganti paket yang sudah digunakan dengan paket alternatif.
9. Dilarang melakukan refactoring atau perubahan kode yang tidak berkaitan langsung dengan tugas ini.

## Ketentuan

1. Setiap paket wajib diinstal ulang secara terpisah menggunakan `flutter pub add`.
2. Instalasi wajib dilakukan secara berurutan, bukan secara paralel.
3. Tunggu hingga proses instalasi setiap paket selesai dan periksa hasilnya sebelum melanjutkan.
4. Pertahankan kelompok dependensi asal setiap paket:
   - Paket `dependencies` harus tetap berada di kelompok `dependencies`.
   - Paket `dev_dependencies` harus tetap berada di kelompok `dev_dependencies`.
5. Pertahankan sumber paket yang sudah digunakan, termasuk `git`, `path`, dan hosted source.
6. Jangan mengubah versi atau konfigurasi dependensi secara sepihak.
7. Jika instalasi suatu paket gagal, identifikasi penyebabnya dan laporkan kegagalan tersebut. Jangan menganggap paket berhasil diinstal.
8. Jika kendala tidak dapat diselesaikan tanpa melanggar batasan tugas, hentikan proses dan laporkan kendalanya.
9. Penyusunan paket berdasarkan abjad hanya dilakukan setelah seluruh proses instalasi berhasil diselesaikan.
10. Susun urutan abjad secara terpisah untuk `dependencies` dan `dev_dependencies`.

## Batasan Ruang Lingkup

1. Tugas hanya mencakup instalasi ulang paket yang sudah tercantum dalam `pubspec.yaml` dan penyusunan urutannya berdasarkan abjad.
2. Perubahan hanya diperbolehkan pada konfigurasi dependensi di `pubspec.yaml` yang berkaitan langsung dengan tugas ini.
3. Jangan mengubah implementasi atau isi file Dart.
4. Jangan mengubah konfigurasi SDK, Flutter, maupun konfigurasi proyek lainnya.
5. Jangan menghapus, menambahkan, atau mengganti paket.
6. Jangan melakukan refactoring, optimasi, atau perbaikan masalah lain yang tidak berkaitan langsung dengan instalasi paket.
7. Jangan mengubah file lain yang tidak berkaitan langsung dengan proses instalasi paket.

## Hasil Akhir

Setelah pekerjaan selesai, berikan laporan yang mencakup:

1. Jumlah seluruh paket yang ditemukan dalam `pubspec.yaml`.
2. Jumlah paket yang berhasil diinstal ulang.
3. Daftar paket yang gagal diinstal, jika ada, beserta penyebabnya.
4. Konfirmasi bahwa instalasi dilakukan satu per satu dan setiap proses ditunggu hingga selesai sebelum melanjutkan.
5. Konfirmasi bahwa paket sudah disusun berdasarkan abjad pada masing-masing kelompok dependensi.
6. Konfirmasi bahwa tidak ada paket yang dihapus.
7. Daftar file yang mengalami perubahan.
