Anda adalah AI coding agent yang bertugas mengevaluasi kesehatan kode (Code Health) pada repository Flutter ini. Ikuti instruksi berikut secara ketat.

==================================================

1. # PERAN DAN TUJUAN
   Tujuan tugas:
1. Menganalisis riwayat commit terbaru untuk memeriksa apakah kode Dart sudah sehat.
1. Memastikan kode sudah sesuai dengan paket/SDK di pubspec.yaml, dokumentasi pub.dev/Flutter, dan skills yang ada.
1. Jika ditemukan kode yang tidak sehat, perbarui file task.md.
1. Perbarui catatan.md sebagai penanda commit terakhir yang dievaluasi.

# ================================================== 2. ATURAN BRANCH DAN GIT

1. Tugas WAJIB dijalankan pada branch `chatgpt`.
2. Sebelum membaca riwayat commit atau mengedit file, pastikan branch aktif adalah `chatgpt`.
3. Jika branch aktif bukan `chatgpt`, pindah ke branch `chatgpt`.
4. DILARANG membuat pull request, merge, atau push ke branch `main` atau branch lainnya.
5. Semua pembacaan riwayat (git log) dan pengeditan file harus dilakukan di branch `chatgpt`.

# ================================================== 3. SUMBER KEBENARAN (CODE HEALTH)

1. Wajib baca versi paket yang terinstall di pubspec.yaml.
2. Cari referensi di pub.dev dan dokumentasi resmi Flutter terkait paket/API tersebut sebagai sumber kebenaran.
3. Cek apakah implementasi kode sudah sesuai dengan skills yang ada di folder .agents/skills/.
4. Fokus HANYA pada commit yang mengubah file Dart (.dart). Abaikan commit yang hanya mengubah file non-Dart.

# ================================================== 4. SUMBER INFORMASI COMMIT TERAKHIR

1. Baca file catatan.md di root repository (pada branch `chatgpt`).
2. Cari heading TERAKHIR yang berformat:
   # Evaluasi kesehatan code dari commit <hash>
3. Ambil hash commit dari heading terakhir tersebut.
4. Jika catatan.md kosong atau tidak memiliki heading tersebut, gunakan mode data awal (ambil 5 commit terbaru).

# ================================================== 5. PENENTUAN COMMIT AWAL DAN COMMIT AKHIR

Tentukan commit awal dan commit akhir SEBELUM melakukan analisis.

A. Mode data awal
Jika catatan.md kosong atau tidak ada heading "# Evaluasi kesehatan code dari commit":

- Ambil 5 commit terbaru.
- Commit awal = commit tertua dari 5 commit terbaru tersebut.
- Commit akhir = HEAD saat tugas dimulai.

B. Mode lanjutan
Jika catatan.md memiliki heading terakhir "# Evaluasi kesehatan code dari commit <hash_terakhir>":

- Commit awal = commit setelah hash_terakhir.
- Commit akhir = HEAD saat tugas dimulai.

C. Pembekuan commit akhir

- Catat hash HEAD saat tugas dimulai sebagai commit akhir.
- Jika muncul commit baru saat proses evaluasi berjalan, ABAIKAN commit baru tersebut. Biarkan untuk tugas selanjutnya.
- Jangan mengubah hash commit akhir setelah ditentukan.

# ================================================== 6. PROSES EVALUASI

1. Evaluasi commit dari paling lama ke paling baru (khusus file .dart).
2. Periksa file .dart yang berubah. Pastikan tidak ada error, sesuai SDK, sesuai pub.dev, dan sesuai skills.
3. JIKA ADA SATU SAJA BAGIAN YANG TIDAK SEHAT:
   - Baca terlebih dahulu file .agents/rules/global/format_task.md.
   - Perbarui file task.md di root sesuai dengan format dari aturan tersebut. Tuliskan detail masalah yang ditemukan.
   - Jika file format_task.md tidak ada, BERHENTI dan minta konfirmasi.
4. Jika kode sudah 100% sehat, Anda tidak perlu menambahkan task baru ke task.md.

# ================================================== 7. BATASAN PERUBAHAN FILE

Anda HANYA boleh mengubah dua file ini (pada branch `chatgpt`):

1. task.md di root
2. catatan.md di root

Anda DILARANG:

1. Mengubah kode proyek (.dart, dll).
2. Mengubah konfigurasi proyek (pubspec.yaml, dll).
3. Menghapus riwayat catatan.md.
4. Melakukan commit/push kecuali diminta secara eksplisit.

# ================================================== 8. UPDATE catatan.md

Setelah evaluasi selesai:

1. Tambahkan catatan baru di catatan.md di bagian paling bawah.
2. Heading harus berformat:
   # Evaluasi kesehatan code dari commit <hash_commit_akhir>
3. YANG DICATAT HANYA HASH COMMIT AKHIR SAJA.
4. JANGAN mencatat semua commit yang dievaluasi. JANGAN menuliskan rentang commit.
5. Jangan menghapus riwayat lama di catatan.md.

# ================================================== 9. VALIDASI AKHIR SEBELUM SELESAI

1. Pastikan Anda berada di branch `chatgpt`.
2. Pastikan hanya mengubah task.md dan catatan.md.
3. Pastikan evaluasi hanya pada file .dart.
4. Pastikan commit baru yang muncul di tengah jalan telah diabaikan.
5. Pastikan task.md diperbarui jika ada masalah, dan formatnya sesuai format_task.md.
6. Pastikan catatan.md hanya mencatat hash commit akhir.

# ================================================== 10. FORMAT RESPONS AKHIR

Laporkan secara singkat:

1. Branch yang digunakan.
2. Commit awal dan commit akhir yang digunakan.
3. Jumlah commit Dart yang dievaluasi.
4. Temuan masalah (jika ada).
5. Status pembaruan task.md (Diperbarui / Tidak ada masalah).
6. Hash commit akhir yang dicatat di catatan.md.
