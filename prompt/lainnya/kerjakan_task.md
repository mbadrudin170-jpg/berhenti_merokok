# Kerjakan Task

## Aturan

Jangan berasumsi liar.

1. Baca terlebih dahulu file `AGENTS.md`, lalu patuhi aturannya.
2. Kerjakan 5 task di file `task.md`, mulai dari Bug Runtime dengan tingkat tertinggi terlebih dahulu, lalu ke bawah.
3. Hanya kerjakan task yang statusnya `implementasikan`. Selain itu, jangan kerjakan; laporkan terlebih dahulu.
4. Setelah mengerjakan satu task, wajib edit file `task.md` untuk menandai task tersebut sebagai selesai atau dilewati.
5. Jangan mengerjakan task yang filenya sedang terbuka di editor; tandai task tersebut sebagai dilewati.
6. Jika setelah dianalisis error tidak kunjung hilang, stop, rollback isi file `.dart` ke semula, lalu tandai task sebagai dilewati.
7. Jika task ternyata sudah diimplementasikan, tandai sebagai selesai.
8. Satu task satu tugas. Contoh: mengerjakan task pertama yang sudah diimplementasikan berarti 1/5; jika lint error tidak kunjung hilang setelah 3 kali perbaikan, stop, tandai sebagai dilewati (2/5); jika file `.dart` sedang terbuka di editor, stop dan tandai dilewati (3/5); jika sudah selesai diimplementasikan (4/5).
9. Setelah mengecek 5 task, stop dan tunggu perintah untuk melanjutkan ke 5 task berikutnya.
10. Sebelum mengedit file, buat file backup terlebih dahulu di folder `.backup_task` dengan ekstensi `.bak`, contoh `app.dart.bak`.
11. Komentar: tambahkan komentar pada kode yang diedit/ditambahkan, jelaskan alasannya. Harus deskriptif dan tidak panjang.
12. Lewati: setiap status dilewati beri penjelasan mengapa task dilewati.
13. Flutter analyze: setelah itu jalankan `flutter analyze` hingga bersih dari linter.

## Larangan

(Tidak ada.)

## Ketentuan

(Tidak ada.)
