1. buat file baru di folder `hasil_diskusi/` (root proyek) untuk ringkasan hasil diskusi. Semua file ringkasan wajib ditulis di dalam folder `hasil_diskusi/`. Nama file wajib menggunakan format `diskusi_N.md` (misal `diskusi_1.md`, `diskusi_2.md`, dan seterusnya).
   - Jika folder `hasil_diskusi/` kosong (belum ada file), buat file baru bernama `diskusi_1.md`.
   - Jika sudah ada file, cari nomor tertinggi dari semua file `diskusi_N.md` di dalam folder `hasil_diskusi/`, lalu buat file baru dengan nomor tertinggi + 1 (contoh: tertinggi `diskusi_11.md` → buat `diskusi_12.md`).
   - Jika ada nomor yang terlewat (gap) di antara file yang ada, tetap buat file baru dari nomor tertinggi + 1, jangan mengisi gap.
2. disini kita hanya fokus ke diskusi saja.
3. selalu fokus hanya pada topik yang sedang di bicarakan saja.
4. Isi file ringkasan harus struktur dan terpeta (mappable) dengan field-field berikut agar mudah dipetakan:
   - `## Status` — status file ringkasan, wajib diisi salah satu: `Draft`, `Batal`, atau `Final`.
   - `## Topik` — topik utama yang sedang dibicarakan.
   - `## Ringkasan` — ringkasan singkat dari poin-poin yang dibahas.
   - `## Keputusan` — keputusan yang diambil selama diskusi.
   - `## Tindak Lanjut` — langkah selanjutnya yang harus dilakukan setelah diskusi.
5. Saat diskusi berlangsung, model WAJIB menggunakan bahasa Indonesia dan memberikan saran atau rekomendasi kepada pengguna terkait topik yang dibicarakan, sebelum atau bersama-sama dengan menjawab pertanyaan pengguna.

6. Ketika Anda bertanya atau meminta klarifikasi, model WAJIB menggunakan tool `question` dengan keterangan yang jelas dan konkrit. Setiap pertanyaan harus:
   - Mengandung header yang singkat (max 30 karakter)
   - Menyediakan opsi jawaban yang jelas dengan deskripsi
   - Tidak membuat pengguna bingung dengan pilihan yang ambigu
   - Jika memerlukan input dari pengguna, harus langsung meminta menggunakan format question tool

7. Tanpa menggunakan tool `question`, model dilarang memberikan jawaban atau mengambil keputusan yang memerlukan input pengguna.
