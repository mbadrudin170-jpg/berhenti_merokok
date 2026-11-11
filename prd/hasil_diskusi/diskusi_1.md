# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Draft / Final

**Status Implementasi:** Belum Diimplementasikan / Sedang Diimplementasikan / Sudah Diimplementasikan

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
- Deskripsi produk: Command `.kilo/commands/perbarui_skills_index.md` untuk memindai seluruh file `SKILL.md` di `.agents/skills/**/` dan menulis indeks ke `SKILLS_INDEX.md` (root proyek) berdasarkan path skill, trigger, dan status diperbarui dari metadata.
- Platform: Flutter / Dart (repo-level command, bukan aplikasi mobile)
- Versi: 1.0.0 (draft)
- Status pengembangan: Belum Diimplementasikan

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

1. Menghasilkan `SKILLS_INDEX.md` sebagai indeks bantu discovery skill berdasarkan trigger (kapan/untuk apa di-load).
2. Memastikan setiap entri indeks hanya berisi trigger dalam bahasa Indonesia, path skill, dan status diperbarui dari `metadata.diperbarui` pada `SKILL.md`.
3. Mengelompokkan entri per folder/kategori (`custom`, `bawaan`, dst.) dengan heading `## <folder>`, urut alfabetis sesuai path.
4. Menetapkan format waktu baku Asia/Jakarta (`TZ=Asia/Jakarta date`) untuk field `metadata.diperbarui` dan `installedAt` skill `bawaan`.
5. Menetapkan `metadata.diperbarui` sebagai field wajib di `SKILL.md` yang diperbarui setiap isi skill berubah, serta menaikkan `metadata.versi` (bump patch default `x.y.Z`).
6. Menetapkan `metadata.sumber-terakhir` sebagai pengganti `metadata.commit-terakhir` untuk mencatat sumber terakhir perubahan.
7. Memastikan `SKILLS_INDEX.md` hanya sebagai indeks bantu; `SKILL.md` tetap sumber kebenaran dan wajib di-load sebelum mengerjakan tugas.
8. Menetapkan sinkronisasi rutin indeks saat ada penambahan, perubahan, penghapusan, atau pemindahan `SKILL.md`.

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
| Scan SKILL.md | Memindai seluruh file `SKILL.md` di `.agents/skills/**/` untuk mengumpulkan path, trigger, dan metadata. | Must Have |
| Ekstraksi trigger | Mengekstrak trigger-only (kapan/untuk apa di-load) dari `description` ke bahasa Indonesia, tanpa mencampur cakupan/larangan/workflow. | Must Have |
| Format entri indeks | Setiap entri: `1. <path skill>`, `- Trigger : <isi trigger>`, `- Status : diperbarui : <tanggal dan waktu>`, urut alfabetis per folder. | Must Have |
| Kelompokan per kategori | Heading `## <folder>` (mis. `## custom`, `## bawaan`) untuk mengelompokkan entri. | Must Have |
| Format waktu baku Asia/Jakarta | Waktu menggunakan output `TZ=Asia/Jakarta date` untuk `metadata.diperbarui` dan konversi `installedAt` skill `bawaan` dari UTC ke Asia/Jakarta. | Must Have |
| Field metadata.diperbarui | Field wajib di frontmatter `SKILL.md`, diperbarui setiap isi skill berubah (luas: frontmatter dan body). | Must Have |
| Bump metadata.versi | Setiap isi skill berubah menaikkan `metadata.versi` (bump patch default `x.y.Z`). | Must Have |
| Field metadata.sumber-terakhir | Pengganti `metadata.commit-terakhir`, mencatat sumber terakhir perubahan (hash commit atau perintah/hasil eksplisit pengguna). | Must Have |
| SKILLS_INDEX.md sebagai indeks bantu | Indeks hanya untuk discovery/pemilihan; `SKILL.md` tetap sumber kebenaran dan wajib di-load sebelum mengerjakan. | Must Have |
| Sinkronisasi rutin | Menjalankan command indeks saat ada perubahan `SKILL.md` atau indeks diduga stale. | Must Have |
| Penanganan skill bawaan | Acuan waktu dari `installedAt` baris pertama `.config/dart_skills/skills_config.json`, dikonversi ke Asia/Jakarta; jika lebih baru, perbarui skill folder `bawaan` saja. | Should Have |
| Fallback trigger tidak jelas | Jika trigger tidak teridentifikasi, tulis penanda eksplisit (mis. "perlu dilengkapi trigger") dan/atau laporkan; jangan salin seluruh `description`. | Should Have |
| Hook ke AGENTS.md | `AGENTS.md` merujuk ke `SKILLS_INDEX.md` sebagai pintu masuk cepat untuk memilih skill. | Could Have |

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

1. Pengguna memutuskan untuk memilih skill yang relevan dengan tugas yang akan dikerjakan.
2. Pengguna membuka `SKILLS_INDEX.md` untuk mencari skill berdasarkan trigger (kapan/untuk apa di-load).
3. Pengguna memilih skill yang cocok dan menyalin path `SKILL.md` terkait.
4. Pengguna membaca/load `SKILL.md` pada path terkait sebelum mulai mengerjakan tugas (sumber kebenaran).
5. Jika `SKILLS_INDEX.md` diduga stale atau tidak sinkron, pengguna menjalankan command `.kilo/commands/perbarui_skills_index.md` untuk menyinkronkan indeks dengan `SKILL.md` terbaru.
6. Setelah skill selesai digunakan, pengembalian ke `SKILLS_INDEX.md` untuk pemilihan skill berikutnya jika diperlukan.
7. Kondisi akhir: tugas dikerjakan dengan panduan dari `SKILL.md` yang relevan, indeks terkini sebagai bantu discovery.

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

1. Buat command `.kilo/commands/perbarui_skills_index.md` dengan langkah scan, ekstraksi trigger, tulis indeks, sinkron referensi `AGENTS.md`, dan validasi.
2. Tambahkan field wajib `metadata.diperbarui` dan `metadata.sumber-terakhir` ke frontmatter `SKILL.md` sesuai `.agents/rules/global/aturan_skill.md`.
3. Perbarui `metadata.versi` (bump patch `x.y.Z`) setiap kali isi `SKILL.md` berubah.
4. Perbarui `.agents/skills/custom/aturan-pembuatan-skill/SKILL.md` agar diselaraskan dengan konvensi trigger dan field metadata baru.
5. Jalankan command indeks untuk menghasilkan `SKILLS_INDEX.md` awal dari seluruh 84 `SKILL.md` yang ada.
6. Tambahkan referensi `SKILLS_INDEX.md` ke `AGENTS.md` sebagai pintu masuk cepat untuk memilih skill.
7. Terapkan sinkronisasi rutin: jalankan command indeks saat ada penambahan, perubahan, penghapusan, atau pemindahan `SKILL.md`, atau saat indeks diduga stale.
8. Untuk skill folder `bawaan`, ambil `installedAt` baris pertama dari `.config/dart_skills/skills_config.json`, konversi ke Asia/Jakarta, dan bandingkan dengan waktu/status di indeks; jika lebih baru, perbarui skill `bawaan` saja dan sinkronkan indeks.
9. Verifikasi bahwa `SKILLS_INDEX.md` hanya memuat trigger (bukan cakupan/larangan/workflow) dan bahwa `SKILL.md` tetap menjadi sumber kebenaran.

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
| `.kilo/commands/perbarui_skills_index.md` | Dibuat | Command baru untuk menghasilkan `SKILLS_INDEX.md` dari seluruh `SKILL.md` di `.agents/skills/**/`. |
| `SKILLS_INDEX.md` | Dibuat | File indeks bantu di root proyek, dihasilkan oleh command perbarui skills index. |
| `.agents/rules/global/aturan_skill.md` | Diubah | Ditambahkan definisi trigger, konvensi format trigger, field `metadata.diperbarui` dan `metadata.sumber-terakhir`, relasi dengan `metadata.versi`. |
| `.agents/skills/custom/aturan-pembuatan-skill/SKILL.md` | Diubah | Diselaraskan dengan aturan trigger dan field metadata baru dari `aturan_skill.md`. |
| `AGENTS.md` | Diubah | Ditambahkan referensi ke `SKILLS_INDEX.md` sebagai pintu masuk cepat untuk memilih skill, serta kewajiban load `SKILL.md` sebelum mengerjakan. |
| `.agents/skills/**/SKILL.md` (84 file) | Diubah | Ditambahkan field `metadata.diperbarui` dan `metadata.sumber-terakhir` pada frontmatter; `metadata.versi` naik saat perubahan. |
| `.config/dart_skills/skills_config.json` | Tidak diubah | Digunakan sebagai acuan waktu `installedAt` untuk skill folder `bawaan` (hanya dibaca, tidak ditulis). |
