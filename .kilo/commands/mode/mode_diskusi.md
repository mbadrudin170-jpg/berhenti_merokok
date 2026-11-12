# Mode Diskusi

## 1. Tujuan

Mode ini digunakan untuk mendampingi pengguna dalam diskusi terfokus dan mendokumentasikan hasil diskusi ke dalam file PRD yang terstruktur.

## 2. Aturan Diskusi

1. Fokus hanya pada diskusi. Jangan melakukan implementasi, perubahan kode, atau tindakan di luar kebutuhan diskusi, kecuali diminta secara eksplisit sesuai konteks diskusi.
2. Selalu fokus pada topik yang sedang dibicarakan. Hindari pembahasan yang tidak relevan.
3. Selama diskusi, model WAJIB menggunakan bahasa Indonesia.
4. Model WAJIB memberikan saran atau rekomendasi yang relevan kepada pengguna terkait topik yang dibicarakan, sebelum atau bersama-sama dengan menjawab pertanyaan pengguna.

## 3. Aturan File Hasil Diskusi

1. Setiap hasil diskusi WAJIB didokumentasikan dalam file baru di folder `prd/hasil_diskusi/`.
2. Semua file hasil diskusi WAJIB disimpan di folder `prd/hasil_diskusi/` (bukan di lokasi lain).
3. Nama file WAJIB menggunakan format `diskusi_N.md` dan disimpan sebagai `prd/hasil_diskusi/diskusi_N.md` (contoh: `prd/hasil_diskusi/diskusi_1.md`, `prd/hasil_diskusi/diskusi_2.md`).
4. Penentuan nomor file:
   - Jika folder `prd/hasil_diskusi/` kosong (belum ada file `diskusi_N.md`), buat `prd/hasil_diskusi/diskusi_1.md`.
   - Jika sudah ada file, cari nomor tertinggi dari semua file `diskusi_N.md` di folder `prd/hasil_diskusi/`, lalu buat file baru `prd/hasil_diskusi/diskusi_<tertinggi+1>.md` (contoh: tertinggi `diskusi_11.md` → buat `prd/hasil_diskusi/diskusi_12.md`).
   - Jika terdapat nomor yang terlewat (gap), tetap gunakan nomor `tertinggi + 1`. Jangan mengisi gap.

## 4. Struktur dan Isi File Hasil Diskusi

1. Isi file `diskusi_N.md` WAJIB mengikuti struktur dan aturan pengisian PRD lengkap sesuai `.agents/rules/global/format_PRD.md`.
2. File WAJIB mencakup seluruh bagian PRD dari **Bagian 1 sampai Bagian 21**, termasuk judul, metadata status, pemisah, konteks penggunaan, aturan pengisian, dan format tabel/isi pada setiap bagian sebagaimana ditetapkan di `format_PRD.md`.
3. Penyesuaian status untuk mode diskusi:
   - `**Status Dokumen:**` WAJIB diisi salah satu dari: `Draft`, `Batal`, atau `Final` sesuai status hasil diskusi.
   - `**Status Implementasi:**` diisi sesuai kondisi aktual; jika belum diketahui atau belum relevan, tandai secara jelas tanpa mengarang.
4. Seluruh isi PRD WAJIB didasarkan pada hasil diskusi dan informasi proyek yang diketahui. DILARANG mengarang informasi.
5. Jika suatu bagian belum dibahas, belum diputuskan, atau informasinya belum tersedia, isi bagian tersebut dengan keterangan yang jelas (misalnya "Belum dibahas" atau "Belum diketahui") sesuai konteks, dan jangan menebak.
6. Keputusan, tindak lanjut, dan poin penting dari diskusi WAJIB tercermin pada bagian PRD yang relevan (misalnya Latar Belakang, Tujuan Produk, Ruang Lingkup, Detail Persyaratan Fitur, Kriteria Penerimaan, Ketentuan Tambahan, dan/atau Riwayat Perubahan), agar hasil diskusi dapat dipetakan secara utuh.

## 5. Aturan Penggunaan Tool `question`

1. Ketika model perlu bertanya, meminta klarifikasi, atau meminta keputusan/input dari pengguna, model WAJIB menggunakan tool `question`.
2. Setiap pertanyaan yang dikirim melalui tool `question` WAJIB:
   - Memiliki `header` singkat (maksimal 30 karakter).
   - Menyediakan opsi jawaban yang jelas, masing-masing dengan deskripsi.
   - Menghindari pilihan yang ambigu atau membingungkan.
   - Meminta input secara langsung melalui format tool `question` (bukan sekadar pertanyaan di teks biasa).
3. Jika suatu jawaban atau keputusan bergantung pada input pengguna, model DILARANG memberikan jawaban final atau mengambil keputusan tersebut tanpa terlebih dahulu meminta input melalui tool `question`.
