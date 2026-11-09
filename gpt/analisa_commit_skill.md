Kamu adalah asisten coding yang bertugas mengevaluasi riwayat commit Git pada proyek Flutter saya, lalu memperbarui atau menambahkan skill custom berdasarkan pola kode yang ditemukan.

Baca dan patuhi seluruh aturan berikut. Jangan menyimpang dari aturan ini.

==================================================
A. TUJUAN TUGAS
==================================================

1. Menganalisis riwayat commit terbaru setelah commit terakhir yang sudah dievaluasi.
2. Menentukan pola/code Flutter yang saya inginkan dari riwayat commit tersebut.
3. Memperbarui atau menambahkan skill custom di folder:
   .agents/skills/custom
4. Memperbarui file catatan.md di root agar tugas berikutnya tahu commit terakhir yang sudah dievaluasi.

==================================================
B. SUMBER ACUAN
==================================================

1. Baca file `.agents/rules/global/aturan_skill.md` terlebih dahulu.
   - Semua cara penulisan, struktur, format, dan aturan pembuatan skill harus mengikuti file ini.
   - Jangan menulis atau memperbarui skill sebelum membaca file tersebut.
2. Baca file `catatan.md` di root untuk mengetahui commit terakhir yang sudah dievaluasi.
3. Cari heading terakhir dengan judul:
   `# Evaluasi Skill dari commit`
   - Ambil hash commit hanya dari heading terakhir tersebut.
   - Jangan menggunakan semua riwayat evaluasi yang ada di catatan.md.
   - Jangan mengevaluasi semua file `.md`.
   - File `.md` yang boleh dibaca hanya `catatan.md` dan `.agents/rules/global/aturan_skill.md`.

==================================================
C. BRANCH KERJA
==================================================

1. Gunakan branch ChatGPT yang sudah saya buatkan.
2. Jangan pindah ke branch lain.
3. Jika branch yang dimaksud tidak ditemukan atau tidak jelas, berhenti dan laporkan. Jangan menebak.

==================================================
D. PENENTUAN COMMIT AWAL DAN COMMIT AKHIR
==================================================

1. Tentukan HEAD di awal tugas dan catat hash-nya sebagai commit akhir.
2. Commit akhir = HEAD saat tugas dimulai.
3. Commit awal = commit setelah hash yang tercatat pada heading terakhir `# Evaluasi Skill dari commit` di `catatan.md`.
4. Jika `catatan.md` masih kosong atau belum memiliki heading `# Evaluasi Skill dari commit`:
   - Ambil 5 commit terbaru sebagai data awal.
   - Commit awal = commit tertua di antara 5 commit terbaru tersebut.
   - Commit akhir = HEAD yang sudah dicatat di awal tugas.
5. Jika hash pada heading terakhir tidak ditemukan di riwayat Git, berhenti dan laporkan. Jangan menebak commit awal.
6. Jika tidak ada commit baru setelah hash yang tercatat:
   - Jangan mengevaluasi apa pun.
   - Laporkan bahwa tidak ada commit baru untuk dievaluasi.
7. Jika ada commit baru muncul saat evaluasi sedang berjalan:
   - Abaikan commit baru tersebut.
   - Commit baru itu hanya untuk tugas berikutnya.
8. Jika ada dua commit yang mengubah kode yang sama:
   - Jadikan commit terbaru sebagai sumber kebenaran.
9. Catat hanya hash commit akhir yang dievaluasi. Jangan mencatat semua commit yang dievaluasi.

==================================================
E. RUANG LINGKUP EVALUASI
==================================================

1. Evaluasi hanya commit dalam rentang commit awal sampai commit akhir yang sudah ditentukan.
2. Fokus pada pola kode Flutter, struktur, konvensi, dan implementasi yang relevan untuk dijadikan skill custom.
3. Kode yang saya commit sudah pasti sesuai dengan paket dan SDK Flutter.
4. Kode yang saya commit sudah pasti sudah saya analisis.
5. Karena itu, jangan meminta validasi ulang, jangan meragukan dependency, dan jangan menganggap kode perlu diperbaiki hanya karena belum diverifikasi.
6. Jangan mengevaluasi semua file `.md`.
7. Jangan mengubah file selain:
   - `.agents/skills/custom/**`
   - `catatan.md`
8. Jangan mengubah `.agents/rules/global/aturan_skill.md`.

==================================================
F. PROSES MEMPERBARUI SKILL
==================================================

1. Setelah membaca `.agents/rules/global/aturan_skill.md`, periksa isi folder `.agents/skills/custom`.
2. Jika sudah ada skill yang relevan:
   - Perbarui skill tersebut.
3. Jika belum ada skill yang relevan:
   - Tambahkan skill custom baru.
4. Pastikan penulisan skill mengikuti aturan di `aturan_skill.md`.
5. Jangan hanya memberikan saran. Lakukan pembaruan atau penambahan file skill jika pola sudah cukup ditemukan.
6. Jangan membuat perubahan di luar folder skill custom dan `catatan.md`.

==================================================
G. MEMPERBARUI catatan.md
==================================================

1. Setelah evaluasi selesai, perbarui `catatan.md`.
2. Catat hanya hash commit terakhir yang dievaluasi.
3. Jangan mencatat daftar semua commit.
4. Jangan menghapus riwayat catatan lama.
5. Tambahkan atau perbarui heading terakhir:
   `# Evaluasi Skill dari commit <hash_commit_akhir>`
6. Tujuan pembaruan ini adalah agar tugas berikutnya tahu titik lanjut evaluasi.

==================================================
H. URUTAN EKSEKUSI YANG WAJIB DIIKUTI
==================================================

1. Pastikan berada di branch ChatGPT yang sudah dibuat.
2. Catat hash HEAD saat tugas dimulai sebagai commit akhir.
3. Baca `.agents/rules/global/aturan_skill.md`.
4. Baca `catatan.md` dan cari heading terakhir `# Evaluasi Skill dari commit`.
5. Tentukan commit awal dan commit akhir.
6. Jika tidak ada commit baru, berhenti dan laporkan.
7. Evaluasi hanya commit dalam rentang tersebut.
8. Abaikan commit baru yang muncul setelah HEAD dicatat.
9. Jika ada konflik kode, gunakan commit terbaru sebagai sumber kebenaran.
10. Perbarui atau tambahkan skill di `.agents/skills/custom` sesuai `aturan_skill.md`.
11. Perbarui `catatan.md` hanya dengan hash commit akhir.
12. Laporkan hasilnya secara ringkas.

==================================================
I. FORMAT LAPORAN AKHIR
==================================================
Setelah selesai, laporkan:

1. Branch yang digunakan.
2. Hash commit akhir yang dicatat di awal tugas.
3. Commit awal dan commit akhir yang dievaluasi.
4. Jumlah commit yang dievaluasi.
5. Skill yang diperbarui atau ditambahkan.
6. File yang berubah.
7. Hash commit yang dicatat ke `catatan.md`.
8. Catatan jika ada commit baru yang diabaikan.

==================================================
J. LARANGAN
==================================================

1. Jangan mengevaluasi di luar rentang commit yang sudah ditentukan.
2. Jangan mengevaluasi semua file `.md`.
3. Jangan mengubah file selain folder skill custom dan `catatan.md`.
4. Jangan meminta validasi ulang terhadap kode yang sudah saya commit dan analisis.
5. Jangan mencatat semua commit ke `catatan.md`.
6. Jangan pindah branch.
7. Jangan menebak jika hash commit tidak ditemukan.
8. Jangan mengabaikan aturan penulisan skill di `.agents/rules/global/aturan_skill.md`.

Mulai tugas sekarang. Ikuti seluruh aturan di atas secara berurutan.
