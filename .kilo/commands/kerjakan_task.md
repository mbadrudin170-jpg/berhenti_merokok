# Eksekusi Task Berdasarkan Kelompok

**Path file:** `prompt/lainnya/kerjakan_task.md`

## Tujuan

Mengerjakan seluruh task yang berstatus `Kerjakan` di dalam `task.md` berdasarkan urutan kelompok.

Pengerjaan wajib diselesaikan per kelompok. Jangan berpindah ke kelompok berikutnya sebelum seluruh task berstatus `Kerjakan` pada kelompok aktif selesai diproses.

Jangan berasumsi liar. Periksa kode aktual, patuhi aturan proyek, buat backup sebelum perubahan, dan verifikasi setiap implementasi.

# 1. Baca aturan proyek

1. Baca seluruh isi `.agents/rules/AGENTS.md` sebelum melakukan pekerjaan apa pun.
2. Patuhi seluruh aturan yang terdapat di dalamnya.
3. Baca aturan proyek lain yang relevan dengan task.
4. Baca seluruh isi `task.md` untuk memahami kelompok, prioritas, status, deskripsi, dan file terdampak.
5. Pahami urutan kelompok sebagaimana tertulis di `task.md`.
6. Jika `.agents/rules/AGENTS.md` tidak ditemukan atau tidak dapat dibaca, hentikan seluruh proses dan laporkan kepada pengguna.
7. Jangan melanjutkan pekerjaan berdasarkan asumsi jika aturan proyek belum dapat dipastikan.

# 2. ATURAN MUTLAK: HANYA BOLEH MENGERJAKAN TASK BERSTATUS `Kerjakan`

**PERHATIAN: INI ADALAH ATURAN PALING PENTING. KILO CODE HANYA BOLEH MENGERJAKAN TASK YANG STATUSNYA `Kerjakan`.**

Jangan mengerjakan task dengan status lain, apa pun alasannya.

Ketentuan wajib:

1. Periksa status setiap task sebelum melakukan pemeriksaan kode maupun implementasi.
2. Task hanya boleh diproses jika statusnya tertulis persis `Kerjakan`.
3. Task dengan status `Belum`, `Setengah`, `Selesai`, `Dilewati`, atau status lainnya tidak boleh dikerjakan.
4. Jangan menganggap menemukan bug, lint, masalah runtime, masalah UI, atau masalah UX sebagai izin untuk mengerjakan task yang statusnya bukan `Kerjakan`.
5. Jangan mengubah status task lain agar menjadi `Kerjakan`.
6. Jangan mengambil pekerjaan tambahan dari hasil pemeriksaan kode di luar task yang berstatus `Kerjakan`.
7. Jangan mengerjakan task yang tidak diminta hanya karena AI menganggapnya penting, mudah, mendesak, atau berkaitan dengan task yang sedang dikerjakan.
8. Jika menemukan task berstatus selain `Kerjakan` yang menurut AI perlu ditindaklanjuti, catat dan laporkan kepada pengguna. Jangan mengerjakannya.
9. Jangan mengubah status task yang tidak sedang diproses.

**Larangan keras:** Tidak ada pengecualian terhadap aturan status ini. Satu-satunya status yang memberikan izin implementasi adalah `Kerjakan`.

## Pemeriksaan wajib sebelum memproses task

Lakukan urutan berikut setiap kali akan memproses task:

1. Identifikasi kelompok task.
2. Identifikasi task di dalam kelompok tersebut.
3. Baca status task.
4. Pastikan statusnya persis `Kerjakan`.
5. Jika statusnya `Kerjakan`, task boleh dilanjutkan ke tahap pemeriksaan dan implementasi.
6. Jika statusnya bukan `Kerjakan`, jangan memproses atau mengubah task tersebut.

Jangan melewati pemeriksaan status ini, termasuk ketika berpindah ke task berikutnya dalam kelompok yang sama.

# 3. URUTAN PENGERJAAN WAJIB BERDASARKAN KELOMPOK

**Selesaikan seluruh task berstatus `Kerjakan` dalam satu kelompok sebelum berpindah ke kelompok berikutnya.**

Ketentuan:

1. Mulai dari kelompok pertama yang tercantum di `task.md`.
2. Periksa task dalam kelompok tersebut satu per satu.
3. Kerjakan hanya task yang berstatus `Kerjakan`.
4. Selesaikan seluruh task berstatus `Kerjakan` pada kelompok aktif sebelum berpindah.
5. Task yang berstatus selain `Kerjakan` harus dilewati tanpa implementasi dan tanpa perubahan status.
6. Setelah tidak ada lagi task berstatus `Kerjakan` dalam kelompok aktif, kelompok tersebut dianggap selesai diproses.
7. Barulah lanjutkan ke kelompok berikutnya sesuai urutan dalam `task.md`.
8. Ulangi proses tersebut sampai seluruh kelompok selesai diperiksa.
9. Jangan melompat ke kelompok lain hanya karena menemukan task yang dianggap lebih mudah atau lebih penting.
10. Jangan mencampur pengerjaan task dari dua kelompok berbeda sebelum kelompok sebelumnya selesai diproses.

### Contoh urutan pengerjaan

Misalnya `task.md` memiliki susunan berikut:

- Kelompok 1
  - Task A: `Kerjakan`
  - Task B: `Belum`
  - Task C: `Kerjakan`
- Kelompok 2
  - Task D: `Kerjakan`
  - Task E: `Kerjakan`
- Kelompok 3
  - Task F: `Kerjakan`

Urutan yang wajib dilakukan:

1. Kelompok 1: kerjakan Task A.
2. Kelompok 1: lewati Task B karena statusnya bukan `Kerjakan`.
3. Kelompok 1: kerjakan Task C.
4. Pastikan tidak ada lagi task berstatus `Kerjakan` di Kelompok 1.
5. Kelompok 2: kerjakan Task D.
6. Kelompok 2: kerjakan Task E.
7. Pastikan tidak ada lagi task berstatus `Kerjakan` di Kelompok 2.
8. Kelompok 3: kerjakan Task F.

**Dilarang mengerjakan Task D sebelum Task A dan Task C di Kelompok 1 selesai diproses.**

# 4. Pemeriksaan sebelum implementasi

Untuk setiap task berstatus `Kerjakan`:

1. Baca deskripsi masalah.
2. Baca solusi yang diusulkan.
3. Baca aturan yang dilanggar.
4. Periksa seluruh file yang disebutkan dalam task.
5. Periksa kode aktual, bukan hanya mengandalkan deskripsi task.
6. Periksa aturan proyek yang berkaitan dengan masalah tersebut.
7. Pastikan masalah masih terjadi.
8. Pastikan solusi sesuai dengan kondisi kode aktual.
9. Jika masalah ternyata sudah diperbaiki dan hasilnya sudah sesuai, jangan mengulangi implementasi. Tandai task sebagai `Selesai`.
10. Jika solusi tidak sesuai dengan kondisi kode aktual atau berpotensi merusak bagian lain, hentikan pengerjaan task dan laporkan kepada pengguna. Jangan mengarang solusi sendiri.

# 5. File yang sedang terbuka di editor

1. Sebelum mengedit file, pastikan file tersebut tidak sedang terbuka di editor.
2. Jika salah satu file yang harus diubah sedang terbuka di editor, jangan mengedit file tersebut.
3. Hentikan pengerjaan task yang bersangkutan.
4. Tandai task sebagai `Dilewati`.
5. Tuliskan alasan bahwa task dilewati karena file yang diperlukan sedang terbuka di editor.
6. Setelah status diperbarui, lanjutkan ke task `Kerjakan` berikutnya dalam kelompok yang sama.

Jika AI tidak dapat memastikan apakah file sedang terbuka melalui editor atau integrasi yang tersedia, jangan mengklaim bahwa file aman untuk diedit. Laporkan keterbatasan tersebut kepada pengguna dan jangan mengedit file yang status keterbukaannya belum dapat dipastikan.

# 6. Backup sebelum mengedit

**WAJIB membuat backup sebelum mengubah isi file apa pun. Tidak boleh ada pengecualian.**

Ketentuan:

1. Buat folder `.backup task` jika belum tersedia.
2. Simpan backup menggunakan ekstensi `.bak`.
3. Pertahankan struktur direktori asli agar lokasi file mudah dikenali.
4. Jangan menimpa backup sebelumnya.
5. Backup harus berisi kondisi file sebelum perubahan dilakukan.
6. Sebelum mengubah `task.md`, buat backup `task.md` terlebih dahulu.
7. Jika backup gagal dibuat, jangan lanjutkan pengeditan file tersebut. Laporkan kendalanya.

Contoh:

File asli:

`lib/fitur/home/app.dart`

Lokasi backup:

`.backup task/lib/fitur/home/app.dart.bak`

File task:

`task.md`

Lokasi backup:

`.backup task/task.md.bak`

# 7. Aturan implementasi

1. Kerjakan hanya masalah yang dijelaskan dalam task.
2. Jangan melakukan refactor yang tidak diperlukan.
3. Jangan menambahkan fitur di luar ruang lingkup task.
4. Jangan mengubah perilaku bagian aplikasi lain tanpa alasan yang berkaitan langsung dengan task.
5. Ikuti seluruh aturan proyek dan pola implementasi yang sudah digunakan.
6. Periksa dampak perubahan terhadap file atau fungsi yang berkaitan.
7. Jika menemukan masalah tambahan di luar ruang lingkup task, catat dan laporkan kepada pengguna.
8. Jangan langsung mengerjakan masalah tambahan tersebut.
9. Jangan mengambil task tambahan hanya karena file yang sedang dikerjakan memiliki masalah lain.

# 8. Aturan komentar kode

Setiap kode yang ditambahkan atau diubah wajib memiliki komentar yang menjelaskan alasan perubahan.

Ketentuan:

1. Gunakan bahasa Indonesia yang baik dan benar.
2. Komentar harus singkat, deskriptif, dan mudah dipahami.
3. Jelaskan alasan kode ditambahkan atau diubah.
4. Jangan hanya mengulang apa yang sudah jelas dari kode.
5. Jangan menambahkan komentar yang tidak memberikan informasi berguna.
6. Letakkan komentar pada bagian kode yang relevan.

# 9. Aturan `flutter analyze`

Setelah implementasi setiap task:

1. Jalankan `flutter analyze`.
2. Periksa seluruh hasil analisis.
3. Target akhir adalah tidak ada error maupun lint.
4. Jika ditemukan masalah yang disebabkan oleh perubahan task, lakukan perbaikan.
5. Maksimal 3 kali siklus perbaikan dan pemeriksaan ulang.
6. Jika setelah 3 kali percobaan masalah tetap belum terselesaikan:
   - Hentikan pengerjaan task.
   - Kembalikan seluruh file yang diubah oleh task tersebut ke kondisi sebelum implementasi menggunakan backup.
   - Pastikan perubahan lain yang bukan bagian dari task tidak ikut terhapus.
   - Tandai task sebagai `Dilewati`.
   - Tuliskan alasan bahwa task dilewati karena masalah analisis tidak berhasil diperbaiki setelah 3 kali percobaan.
7. Jangan menghapus atau menyembunyikan error hanya agar hasil analisis terlihat bersih.
8. Jika sebelum implementasi sudah terdapat error atau lint, catat kondisi awalnya.
9. Jangan menganggap masalah yang sudah ada sebelum implementasi sebagai akibat perubahan task.
10. Jangan memperbaiki error yang tidak berkaitan dengan task.

Jika diperlukan rollback, pastikan file yang dikembalikan benar-benar sesuai dengan backup dan tidak menimpa perubahan lain.

# 10. Pembaruan status `task.md`

**Setelah menyelesaikan atau melewati satu task, wajib perbarui `task.md` terlebih dahulu sebelum mengerjakan task berikutnya.**

Ketentuan:

1. Buat backup `task.md` sebelum mengubahnya.
2. Ubah hanya status task yang sedang diproses.
3. Jangan mengubah deskripsi, solusi, prioritas, kelompok, atau task lainnya tanpa alasan yang diperlukan.
4. Jika implementasi berhasil dan sudah diverifikasi, tandai `Selesai`.
5. Jika masalah ternyata sudah diperbaiki sebelumnya, tandai `Selesai`.
6. Jika task tidak dapat dikerjakan karena file terbuka, tandai `Dilewati`.
7. Jika implementasi gagal setelah tiga kali percobaan dan sudah di-rollback, tandai `Dilewati`.
8. Setiap status `Dilewati` wajib disertai alasan yang jelas.
9. Jangan menandai task `Selesai` sebelum implementasi atau pemeriksaan hasil benar-benar berhasil.
10. Jangan mengubah status task lain.
11. Setelah status diperbarui, verifikasi bahwa perubahan pada `task.md` sudah benar.

Setelah pembaruan status, periksa kembali kelompok aktif untuk memastikan masih ada atau tidak ada task berstatus `Kerjakan`.

# 11. Keamanan rollback

1. Gunakan backup sebagai sumber pemulihan.
2. Rollback hanya boleh menyentuh file yang diubah oleh task yang gagal.
3. Jangan menghapus perubahan pengguna yang sudah ada sebelum pengerjaan.
4. Jangan menghapus perubahan dari task lain.
5. Dilarang menggunakan perintah yang dapat membatalkan seluruh perubahan repositori, seperti:
   - `git reset --hard`
   - `git checkout -- .`
   - Perintah rollback massal yang tidak dibatasi pada file task.
6. Jika kondisi file sudah berubah karena pekerjaan lain, hentikan rollback dan laporkan kepada pengguna daripada menimpa perubahan tersebut.

# 12. Laporan hasil pengerjaan

Catat hasil setiap task yang diproses:

- Nama atau identitas task.
- Nama kelompok.
- Prioritas task.
- Status awal.
- Status akhir.
- Masalah yang ditemukan.
- File yang diperiksa.
- File yang diubah.
- Lokasi backup.
- Hasil implementasi.
- Hasil `flutter analyze`.
- Apakah dilakukan rollback.
- Alasan jika task dilewati.

Setelah seluruh kelompok selesai diproses, berikan laporan akhir yang berisi:

1. Jumlah seluruh task yang diproses.
2. Jumlah task yang berhasil diselesaikan.
3. Jumlah task yang dilewati.
4. Ringkasan hasil per kelompok.
5. Daftar task yang telah diproses.
6. Daftar task yang tidak dikerjakan karena statusnya bukan `Kerjakan`.
7. Masalah yang belum terselesaikan.
8. Hasil akhir `flutter analyze`.
9. Lokasi seluruh backup yang dibuat.

# 13. Kondisi wajib berhenti

Hentikan pengerjaan task yang bersangkutan jika:

- Task memiliki instruksi ambigu atau bertentangan yang tidak dapat diselesaikan berdasarkan aturan proyek.
- Backup gagal dibuat.
- File yang harus diedit sedang terbuka di editor.
- AI tidak dapat memastikan keamanan perubahan atau rollback.
- Masalah analisis tidak berhasil diperbaiki setelah tiga kali percobaan.

Untuk kondisi yang hanya memengaruhi satu task, tandai `Dilewati` jika memang sesuai dengan ketentuan, berikan alasan, lalu lanjutkan ke task `Kerjakan` berikutnya dalam kelompok yang sama.

Jika masalah memengaruhi keamanan seluruh proses atau aturan proyek tidak dapat dipastikan, hentikan seluruh proses dan laporkan kepada pengguna.

# 14. Pemeriksaan akhir

Setelah seluruh kelompok selesai diproses:

1. Periksa kembali `task.md`.
2. Pastikan seluruh task berstatus `Kerjakan` sudah diproses.
3. Pastikan tidak ada task yang dikerjakan dari kelompok yang salah urutan.
4. Pastikan task berstatus selain `Kerjakan` tidak mengalami perubahan.
5. Pastikan task yang diproses sudah memiliki status akhir yang benar.
6. Pastikan setiap task berstatus `Dilewati` memiliki alasan.
7. Pastikan backup tersedia untuk seluruh file yang diubah.
8. Laporkan hasil akhir `flutter analyze`.
9. Laporkan task yang tidak dikerjakan karena statusnya bukan `Kerjakan`.

**Setelah seluruh task berstatus `Kerjakan` di semua kelompok selesai diproses, hentikan proses dan tunggu instruksi pengguna berikutnya.**

---

# PRINSIP UTAMA

1. HANYA STATUS `Kerjakan` YANG BOLEH DIIMPLEMENTASIKAN.
2. STATUS SELAIN `Kerjakan` BUKAN IZIN IMPLEMENTASI.
3. KERJAKAN TASK BERDASARKAN KELOMPOK.
4. SELESAIKAN KELOMPOK AKTIF SEBELUM PINDAH KE KELOMPOK BERIKUTNYA.
5. JANGAN MELONCATI URUTAN KELOMPOK.
6. BACKUP WAJIB SEBELUM SETIAP PERUBAHAN.
7. PERBARUI `task.md` SETELAH SETIAP TASK.
8. JALANKAN `flutter analyze` SETELAH IMPLEMENTASI.
9. ROLLBACK HANYA PADA PERUBAHAN TASK YANG GAGAL.
10. SETIAP TASK YANG DILEWATI WAJIB MEMILIKI ALASAN.
11. JANGAN MENGERJAKAN PEKERJAAN DI LUAR TASK YANG DIIZINKAN.
12. UTAMAKAN KEPATUHAN TERHADAP STATUS TASK, URUTAN KELOMPOK, DAN KEAMANAN PERUBAHAN.
