# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Draft

**Status Implementasi:** Belum Diimplementasikan

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

- Nama aplikasi: berhenti_merokok
- Deskripsi produk: Aplikasi Flutter untuk membantu pengguna berhenti merokok
- Platform: Flutter (Android, iOS, Web, Desktop)
- Versi: 1.0.0+1
- Status pengembangan: Sedang Diimplementasikan

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

Mendokumentasikan hasil diskusi tentang risiko dan rekomendasi koordinasi saat file `MEMORI.md` diubah secara bersamaan oleh pengguna, Kilo (model AI ini), dan model AI lain, sehingga konteks proyek tetap konsisten dan tidak ada data yang tertimpa.

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

| Fitur | Deskripsi | Prioritas |
| ----- | --------- | --------- |
| Mekanisme koordinasi edit `MEMORI.md` | Hanya satu pihak (pengguna atau model AI) yang mengedit `MEMORI.md` pada satu waktu; edit dilakukan secara berurutan, bukan bersamaan | Must Have |
| Deteksi dan resolusi konflik edit bersamaan | Jika edit bersamaan tidak sengaja terjadi, pengguna memutuskan versi mana yang dipertahankan; pertentangan diatasi melalui diskusi atau tool `question` | Must Have |
| Catatan riwayat perubahan `MEMORI.md` | Setiap edit dicatat di bagian "Riwayat Perubahan" dan "Catatan untuk Model Selanjutnya" dengan siapa, kapan, dan topik perubahan | Should Have |
| Pemberitahuan status edit sedang berlangsung | Pihak yang sedang mengedit `MEMORI.md` menginformasikan kepada participant lain sebelum dan setelah edit | Could Have |

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

1. Kondisi awal: file `MEMORI.md` berada di root proyek dan berisi konteks proyek (status, struktur layar, provider, enum, konfigurasi, skills, dll.).
2. Setiap model AI (termasuk Kilo) membaca `MEMORI.md` sebelum memulai interaksi apa pun, sesuai AGENTS.md aturan 5 dan 10.
3. Jika suatu pihak ingin mengubah isi `MEMORI.md`, pihak tersebut menginformasikan keputusan tersebut kepada pengguna dan participant lain terlebih dahulu.
4. Pengguna memberikan keputusan tentang edit yang diinginkan (jika diperlukan, melalui tool `question`).
5. Satu model melakukan perubahan pada `MEMORI.md` secara berurutan, bukan secara bersamaan dengan model lain.
6. Setelah selesai edit, model memperbarui bagian yang relevan (misalnya "Status Proyek", "Riwayat Perubahan", "Catatan untuk Model Selanjutnya") sesuai skill `memori-check`.
7. Percabangan: jika terdeteksi edit bersamaan (konflik), edit yang kedua ditangguhkan dan pengguna memilih versi mana yang dipertahankan atau melakukan merge manual.
8. Kondisi akhir yang diharapkan: `MEMORI.md` terupdate dengan konsisten, tidak ada data yang tertimpa, dan semua model memiliki konteks yang sama.

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

1. Baca `MEMORI.md` sebelum setiap interaksi (wajib per AGENTS.md aturan 5 dan 10).
2. Sinkronkan konteks dengan participant lain (periksa board dan riwayat perubahan terbaru).
3. Jika mengedit `MEMORI.md` diperlukan, ajukan keputusan ke pengguna melalui tool `question`.
4. Lakukan perubahan `MEMORI.md` satu per satu (secara berurutan), hindari edit bersamaan.
5. Perbarui bagian "Status Proyek", "Riwayat Perubahan", dan "Catatan untuk Model Selanjutnya" setelah edit.
6. Verifikasi tidak ada data yang tertimpa atau hilang setelah penyimpanan.

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

| Lokasi File | Status Perubahan | Deskripsi Perubahan |
| ----------- | ---------------- | ------------------- |
| MEMORI.md | Diubah | Catatan hasil diskusi dan rekomendasi koordinasi edit bersamaan akan disimpan di bagian yang relevan (status, riwayat perubahan, catatan untuk model selanjutnya) |
| prd/hasil_diskusi/diskusi_1.md | Dibuat | Dokumentasi hasil diskusi ini mengenai risiko dan rekomendasi pengeditan `MEMORI.md` secara bersamaan |
