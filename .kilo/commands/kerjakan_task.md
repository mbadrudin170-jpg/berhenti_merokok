# Perintah Kerjakan Task

Baca terlebih dahulu file `AGENTS.md` di root lalu patuhi semua aturannya, termasuk keterkaitan ke folder `agents/` dan `.agents/skills/`.

## Aturan utama (wajib dibaca)

JANGAN mengerjakan task selain yang statusnya `Kerjakan`. Kilo Code sering melakukan kesalahan ini. Hanya kerjakan task yang statusnya `Kerjakan` (case-insensitive).
Task dengan status lain (mis. `batal`, `Belum dikerjakan`, `selesai`, `dilewati`, atau kosong) dilarang dikerjakan — laporan dulu ke saya sebelum mengambil tindakan apa pun.

## Urutan pengerjaan

1. Kelompokkan task berdasarkan kelompok di `task.md`.
2. Selesaikan SEMUA task dengan status `Kerjakan` dalam satu kelompok terlebih dahulu.
3. Setelah tidak ada lagi task `Kerjakan` dalam kelompok tersebut, baru pindah ke kelompok berikutnya.

## Langkah pengerjaan setiap task

1. Edit file `task.md` terlebih dahulu untuk menandai task tersebut sebagai `selesai` atau `dilewati`.
2. Jika file yang akan diedit sedang terbuka di editor, jangan mengerjakannya — tandai task tersebut sebagai `dilewati` di `task.md` dengan penjelasan.
3. Sebelum mengedit file `.dart`, buat file backup di folder `.backup task` dengan ekstensi `.bak` (contoh: `app.dart.bak`).
4. Tambahkan komentar deskriptif (singkat, tidak panjang) pada kode yang diedit/ditambahkan, jelaskan alasannya kenapa diedit/ditambah.
5. Setelah selesai, jalankan `flutter analyze` dan pastikan hasilnya bersih dari linter.

## Penanganan error

- Jika setelah dianalisis error tak kunjung hilang, hentikan pengerjaan task tersebut, rollback isi file `.dart` ke semula, lalu tandai task sebagai `dilewati` di `task.md` dengan penjelasan.
- Jika task ternyata sudah dikerjakan sebelumnya, tandai dengan `selesai` di `task.md`.

## Lewati

Setiap task yang dilewati wajib diberi penjelasan kenapa task tersebut dilewati di `task.md`.
