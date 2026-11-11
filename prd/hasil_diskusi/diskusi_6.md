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
- Deskripsi produk: Pembaruan file `MEMORI.md` di root proyek sebagai catatan proyek yang konsisten untuk semua model AI yang bekerja dengan proyek Flutter "berhenti_merokok". File ini berisi struktur proyek, state penting, conventions, dan referensi yang perlu dipelihara.
- Platform: Flutter / Dart (repo-level documentation)
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

1. Setiap model AI yang berinteraksi dengan proyek wajib memeriksa `MEMORI.md` untuk konteks terbaru sebelum menjalankan task.
2. Setiap model wajib memperbarui bagian "Status Proyek" jika ada perubahan versi/state.
3. Setiap model wajib memastikan kepatuhan terhadap rules yang tertera di `AGENTS.md`.
4. Setiap model wajib menggunakan skills yang relevan untuk task yang diberikan.
5. Setiap model wajib menyimpan keputusan penting dan state baru ke `MEMORI.md`.
6. Konten `MEMORI.md` mencakup informasi yang bermanfaat di masa mendatang: struktur proyek lengkap, state dan konfigurasi saat ini, konvensi coding dan aturan proyek, daftar skills yang aktif, dan referensi teknis vital.

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
| File MEMORI.md di root proyek | File comprehensive yang mencakup status proyek dan versi, struktur utama layar dan fitur, provider/Riverpod key, enum utama, file konfigurasi & penting, skills & rules utama, aturan teknis, referensi commit dan diskusi terstruktur, dan catatan untuk model selanjutnya. | Must Have |
| Pemeriksaan MEMORI.md sebelum task | Setiap model wajib memeriksa `MEMORI.md` untuk konteks terbaru sebelum menjalankan task. | Must Have |
| Pembaruan Status Proyek | Setiap model wajib memperbarui bagian "Status Proyek" jika ada perubahan versi/state. | Must Have |
| Kepatuhan rules AGENTS.md | Setiap model wajib memastikan kepatuhan terhadap rules yang tertera di `AGENTS.md`. | Must Have |
| Penggunaan skills yang relevan | Setiap model wajib menggunakan skills yang relevan untuk task yang diberikan. | Must Have |
| Penyimpanan keputusan dan state baru | Setiap model wajib menyimpan keputusan penting dan state baru ke `MEMORI.md`. | Must Have |
| Update berkala | File diperbarui secara berkala saat ada perubahan signifikan pada proyek. | Should Have |
| Cermin perubahan fitur | Semua perubahan atau penambahan fitur seharusnya mencerminkan pada bagian yang relevan di `MEMORI.md`. | Should Have |

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

1. Model AI mulai berinteraksi dengan proyek "berhenti_merokok".
2. Model membaca file `MEMORI.md` terlebih dahulu untuk mendapatkan konteks proyek yang konsisten.
3. Model memeriksa apakah ada perubahan versi/state yang perlu diperbarui di bagian "Status Proyek".
4. Model memastikan kepatuhan terhadap rules di `AGENTS.md` sebelum menjalankan task.
5. Model menggunakan skills yang relevan untuk task yang diberikan.
6. Setelah menyelesaikan task atau ada keputusan penting/state baru, model menyimpan informasi tersebut ke `MEMORI.md`.
7. Jika ada perubahan signifikan pada proyek, model memperbarui `MEMORI.md` secara berkala.
8. Kondisi akhir: `MEMORI.md` selalu terkini sebagai catatan proyek yang konsisten untuk semua model AI.

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

1. Buat file `MEMORI.md` di root proyek dengan isi comprehensive yang mencakup status proyek dan versi, struktur utama layar dan fitur, provider/Riverpod key, enum utama, file konfigurasi & penting, skills & rules utama, aturan teknis, referensi commit dan diskusi terstruktur, dan catatan untuk model selanjutnya.
2. Pastikan setiap model memeriksa `MEMORI.md` untuk konteks terbaru sebelum menjalankan task.
3. Pastikan setiap model memperbarui bagian "Status Proyek" jika ada perubahan versi/state.
4. Pastikan setiap model memastikan kepatuhan terhadap rules di `AGENTS.md`.
5. Pastikan setiap model menggunakan skills yang relevan untuk task yang diberikan.
6. Pastikan setiap model menyimpan keputusan penting dan state baru ke `MEMORI.md`.
7. Perbarui `MEMORI.md` secara berkala saat ada perubahan signifikan pada proyek.
8. Pastikan semua perubahan atau penambahan fitur tercermin pada bagian yang relevan di `MEMORI.md`.
9. Model selanjutnya memulai dengan membaca `MEMORI.md` untuk mendapatkan konteks proyek.

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
| `MEMORI.md` | Dibuat | File catatan proyek di root proyek yang mencakup struktur proyek, state penting, conventions, dan referensi untuk semua model AI. |
| `AGENTS.md` | Tidak diubah | Digunakan sebagai acuan rules yang harus dipatuhi (hanya dibaca, tidak ditulis dalam PRD ini). |
