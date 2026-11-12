# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Draft / Final

**Status Implementasi:** Sedang Diimplementasikan

---

## 1. Informasi Produk

**Konteks penggunaan:**
Digunakan untuk mengidentifikasi produk dan memberikan gambaran umum proyek. Informasi ini menjadi identitas utama PRD.

**Aturan pengisian:**

- Isi informasi berdasarkan kondisi dan identitas proyek yang sebenarnya.
- Gunakan nama yang konsisten dengan proyek.
- Tuliskan platform dan versi yang menjadi target pengembangan.
- Bedakan status dokumen dengan status implementasi.
- Jangan mengarang informasi yang belum diketahui.

**Informasi:**

- Nama aplikasi: Berhenti Merokok
- Deskripsi produk: Pembuatan skill baru untuk penggunaan `ripgrep` (`rg`) sebagai alat pencarian teks/kode di proyek Flutter "berhenti_merokok". Skill akan diletakkan di `.agents/skills/custom/<nama-skill>/SKILL.md` dengan format yang mengikuti aturan pembuatan skill.
- Platform: Flutter / Dart (repo-level skill)
- Versi: 1.0.0 (draft)
- Status pengembangan: Belum Diimplementasikan (ditunda sampai ada kejelasan sumber isi)

---

## 2. Tujuan PRD

**Konteks penggunaan:**
Digunakan untuk menentukan hasil yang ingin dicapai dari dokumen PRD ini. Tujuan harus berhubungan langsung dengan kebutuhan dokumen.

**Aturan pengisian:**

- Tuliskan hasil yang diharapkan dari PRD.
- Pastikan setiap tujuan memiliki hubungan dengan kebutuhan dokumen PRD.
- Gunakan tujuan yang jelas dan dapat dievaluasi.
- Jangan memasukkan tujuan yang berada di luar ruang lingkup PRD.

**Isi:**

1. Membuat skill baru untuk penggunaan `ripgrep` (`rg`) di proyek.
2. Skill ditempatkan di `.agents/skills/custom/<nama-skill>/SKILL.md` dengan nama folder kebab-case bahasa Indonesia yang deskriptif.
3. Skill memiliki front matter YAML lengkap sesuai aturan pembuatan skill.
4. Skill memiliki section wajib: Judul/Intro, Cakupan, Aturan, Larangan, Contoh Benar, Contoh Salah, Sumber Evaluasi.
5. Isi skill disusun dari riwayat commit yang berkaitan (hanya `git log`, `git show`, `git diff` pada commit), bukan dari working directory/staging/untracked.
6. Jika tidak ada commit yang berkaitan, AI dilarang mengarang pola/contoh dan wajib berhenti serta menanyakan kepada pengguna cara melanjutkan.

---

## 3. Daftar Fitur

**Konteks penggunaan:**
Digunakan untuk melihat keseluruhan fitur produk dan menentukan tingkat kepentingannya.

**Aturan pengisian:**

- Setiap fitur harus memiliki nama dan deskripsi yang jelas.
- Satu baris mewakili satu fitur yang dapat diidentifikasi secara terpisah.
- Hindari menggabungkan beberapa fitur berbeda dalam satu baris.
- Pastikan fitur mendukung tujuan produk dan masuk dalam ruang lingkup.
- Gunakan prioritas berdasarkan kepentingan kebutuhan produk.

| Fitur | Deskripsi | Prioritas   |
| ----- | --------- | ----------- |
| Lokasi skill | Skill diletakkan di `.agents/skills/custom/<nama-skill>/SKILL.md` dengan nama folder kebab-case bahasa Indonesia yang deskriptif. | Must Have |
| Front matter YAML lengkap | Skill memiliki front matter YAML dengan field `name`, `description`, `metadata.kategori`, `metadata.versi`, `metadata.commit-terakhir` (atau `belum-ada-commit`). | Must Have |
| Section wajib | Skill memiliki section: Judul/Intro, Cakupan yang Di-Cover, Aturan, Steps (opsional), Larangan, Contoh Benar, Contoh Salah, Sumber Evaluasi. | Must Have |
| Sumber isi dari commit | Isi skill disusun dari riwayat commit yang berkaitan (hanya `git log`, `git show`, `git diff`), bukan dari working directory/staging/untracked. | Must Have |
| Dilarang mengarang | Jika tidak ada commit yang berkaitan, AI dilarang mengarang pola/contoh dan wajib berhenti serta menanyakan kepada pengguna. | Must Have |
| Referensi skill topik non-UI | Skill topik non-UI dapat mengacu pada `bug-runtime/SKILL.md` sebagai referensi format. | Should Have |
| Checklist verifikasi | Skill memenuhi checklist sebelum menyelesaikan (lokasi file, nama folder kebab-case, front matter lengkap, semua section wajib, isi mengikuti riwayat commit, bahasa Indonesia, backtick untuk class/properti/method/package). | Must Have |

---

## 4. Alur Pengguna

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan interaksi pengguna dengan aplikasi dari awal hingga tujuan tercapai.

**Aturan pengisian:**

- Mulai dari kondisi awal pengguna.
- Jelaskan setiap langkah secara berurutan.
- Sebutkan tindakan pengguna dan respons aplikasi.
- Sertakan percabangan atau kondisi alternatif jika tersedia.
- Jelaskan kondisi akhir yang diharapkan.
- Pastikan alur sesuai dengan persyaratan fitur.
- Jangan memasukkan proses yang tidak didukung oleh kebutuhan produk.

**Isi:**

1. Pengguna menentukan nama folder skill (kebab-case, bahasa Indonesia, deskriptif). Rekomendasi kandidat: `pencarian-teks-ripgrep`, `penggunaan-ripgrep`, atau `pencarian-kode-dengan-ripgrep`.
2. Pengguna menentukan cakupan skill (misalnya: pola perintah `rg` dasar, filter file/glob/type, pencarian literal/regex, pencarian multiline/context, praktik aman di repo besar, atau integrasi dengan workflow proyek).
3. Pengguna memilih cara memenuhi aturan sumber isi (karena belum ada commit berkaitan dengan `ripgrep`/`rg`):
   - Membuat/menggunakan commit yang relevan terlebih dahulu, kemudian menyusun skill dari commit tersebut; atau
   - Memberi arahan eksplisit untuk menunda pembuatan skill sampai ada commit relevan; atau
   - Memberi instruksi khusus lain.
4. Jika commit relevan tersedia, AI menyusun isi skill dari commit tersebut menggunakan `git log`, `git show`, `git diff`.
5. AI membuat file `.agents/skills/custom/<nama-skill>/SKILL.md` dengan format lengkap sesuai aturan pembuatan skill.
6. AI memverifikasi checklist sebelum menyelesaikan skill.
7. Kondisi akhir: file `SKILL.md` skill ripgrep dibuat sesuai aturan, atau pembuatan ditunda sampai ada kejelasan sumber isi dari pengguna.

---

## 5. Steps

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan langkah-langkah kerja yang harus diikuti dalam mengisi atau menerapkan PRD.

**Aturan pengisian:**

- Buat langkah-langkah yang spesifik dan dapat diikuti.
- Gunakan numbered list untuk mempertahankan urutan.
- Setiap langkah harus tidak ambigu dan dapat dikerjakan.
- Jangan memasukkan langkah yang tidak relevan atau redundan.

**Isi:**

1. Konfirmasi nama folder skill dari pengguna (kebab-case, bahasa Indonesia, deskriptif).
2. Konfirmasi cakupan skill dari pengguna (pola perintah `rg`, filter, pencarian, praktik aman, integrasi workflow, dll.).
3. Konfirmasi cara memenuhi aturan sumber isi (commit relevan, atau menunda, atau instruksi khusus).
4. Jika commit relevan tersedia, ambil riwayat commit dengan `git log`, `git show`, `git diff` yang menyentuh file/folder terkait `ripgrep`/`rg`.
5. Susun isi `SKILL.md` dari commit yang berkaitan (pilih pola dari commit terbaru yang relevan jika ada beberapa dengan pola berbeda).
6. Buat file `.agents/skills/custom/<nama-skill>/SKILL.md` dengan front matter YAML lengkap dan semua section wajib.
7. Verifikasi checklist: lokasi file, nama folder kebab-case, front matter lengkap, semua section wajib, isi mengikuti riwayat commit, bahasa Indonesia, backtick untuk class/properti/method/package.
8. Jika tidak ada commit yang berkaitan, hentikan pembuatan dan tanyakan kepada pengguna bagaimana ingin melanjutkan (contoh: memberikan contoh dari SDK resmi, atau menunda pembuatan skill).
9. Kondisi akhir: skill ripgrep dibuat atau ditunda berdasarkan keputusan pengguna.

---

## 6. File-File Terdampak

**Konteks penggunaan:**
Digunakan untuk mengidentifikasi file proyek yang berkaitan dengan implementasi kebutuhan produk. Bagian ini menjadi gambaran awal cakupan perubahan kode.

**Aturan pengisian:**

- Periksa struktur proyek sebelum menentukan file terdampak.
- Cantumkan lokasi file secara spesifik berdasarkan struktur proyek sebenarnya.
- Tandai apakah file perlu dibuat, diubah, atau dihapus.
- Jelaskan alasan dan tujuan perubahan setiap file.
- Cantumkan hanya file yang memiliki hubungan dengan kebutuhan fitur.
- Jangan mengarang lokasi, nama, atau keberadaan file.
- Jika file belum dapat ditentukan, tandai sebagai belum diketahui dan jangan menebak.
- Perbarui daftar setelah analisis teknis atau implementasi apabila ditemukan file terdampak tambahan.

| Lokasi File | Status Perubahan          | Deskripsi Perubahan |
| ----------- | ------------------------- | ------------------- |
| `.agents/skills/custom/<nama-skill>/SKILL.md` | Dibuat (ditunda) | File skill baru untuk penggunaan `ripgrep` (`rg`); pembuatan ditunda sampai ada kejelasan sumber isi dari pengguna. |
