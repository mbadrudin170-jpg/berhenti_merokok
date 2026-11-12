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

- Nama aplikasi: `berhenti_merokok`
- Deskripsi produk: Aplikasi Flutter untuk membantu pengguna berhenti merokok (berdasarkan `MEMORI.md`).
- Platform: Flutter (Android, iOS, Web, Desktop) — target pengembangan spesifik per platform: Belum dibahas.
- Versi: 1.0.0+1 (berdasarkan `pubspec.yaml`/`MEMORI.md`).
- Status pengembangan: Sedang Diimplementasikan (berdasarkan `MEMORI.md`).

## 2. Tujuan PRD

**Konteks penggunaan:**
Digunakan untuk menentukan hasil yang ingin dicapai dari dokumen PRD ini. Tujuan harus berhubungan langsung dengan kebutuhan dokumen.

**Aturan pengisian:**

- Tuliskan hasil yang diharapkan dari PRD.
- Pastikan setiap tujuan memiliki hubungan dengan kebutuhan dokumen PRD.
- Gunakan tujuan yang jelas dan dapat dievaluasi.
- Jangan memasukkan tujuan yang berada di luar ruang lingkup PRD.

**Isi:**

Mendokumentasikan hasil diskusi mengenai kebutuhan dan rancangan "sistem alur kerja yang baik" untuk proses pengembangan proyek `berhenti_merokok`, sehingga:

- Masalah utama yang ingin diperbaiki teridentifikasi: **transisi dari diskusi ke pekerjaan** (ide/diskusi → artefak kerja yang jelas) terasa tidak jelas.
- Ruang lingkup alur kerja yang diinginkan terdokumentasi: **alur end-to-end ringan** yang mencakup tahapan ide/diskusi → PRD → task → implementasi → verifikasi → pembaruan dokumentasi/MEMORI.
- Keputusan, rekomendasi, dan tindak lanjut yang disepakati dalam diskusi dapat ditelusuri dan dijadikan dasar penyusunan/penyesuaian aturan, command, atau dokumen proses di kemudian hari (jika diputuskan).

Kriteria keberhasilan terukur dan batasan detail alur kerja: Belum dibahas/Belum diputuskan.

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
| Peta alur end-to-end ringan | Mendefinisikan tahapan ringkas ide/diskusi → PRD (`prd/hasil_diskusi/`) → task (`task.md`) → implementasi → verifikasi → pembaruan dokumentasi/`MEMORI.md`, dengan fokus memperjelas transisi diskusi ke pekerjaan. Rincian tiap tahap: Belum dibahas. | Belum diprioritaskan |
| Kriteria transisi diskusi → kerja | Menetapkan kapan hasil diskusi dianggap siap diterjemahkan menjadi task/pekerjaan (mis. status PRD, keputusan minimal, cara memecah ke `task.md` atau command `kerjakan_hasil_diskusi`). Rincian: Belum dibahas. | Belum diprioritaskan |
| Standarisasi artefak & tanggung jawab | Menetapkan artefak/dokumen per tahap dan siapa/apa yang memperbaruinya (PRD, `task.md`, `MEMORI.md`, `SKILLS_INDEX.md`) agar jejak kerja konsisten. Rincian: Belum dibahas. | Belum diprioritaskan |
| Checklist verifikasi ringan | Menetapkan langkah verifikasi minimal dalam alur (mis. analisis statis/format/tes/codegen bila relevan) dan kapan dijalankan. Rincian: Belum dibahas. | Belum diprioritaskan |
| Pemanfaatan command/mode yang ada | Memetakan command/mode yang sudah ada di `.kilo/commands/` (mis. `mode_diskusi`, `kerjakan_hasil_diskusi`, `kerjakan_task`, `cek_linter`, `perbarui_skills_index`) ke tiap tahap alur. Rincian: Belum dibahas. | Belum diprioritaskan |

Catatan: Daftar fitur di atas bersifat awal/hipotesis berdasarkan masukan pengguna (masalah: transisi diskusi→kerja; cakupan: end-to-end ringan) dan **belum disepakati** secara detail. Fitur, deskripsi, dan prioritas akan diperbarui sesuai hasil diskusi.

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

Konteks alur di sini adalah **alur kerja proses pengembangan (developer/maintainer)**, bukan alur pengguna akhir aplikasi.

**Kondisi awal:** Pengguna (developer) ingin alur kerja end-to-end yang ringan karena transisi dari diskusi ke pekerjaan saat ini terasa tidak jelas.

**Alur saat ini yang diketahui (berdasarkan aset proyek yang ada):**
1. Diskusi kebutuhan dapat didokumentasikan sebagai PRD di `prd/hasil_diskusi/diskusi_N.md` (sesuai `mode_diskusi`).
2. Hasil diskusi dapat ditindaklanjuti melalui command `kerjakan_hasil_diskusi` (tersedia di `.kilo/commands/`).
3. Pekerjaan berbasis task dapat mengikuti format `task.md` (`format_task.md`) dan command `kerjakan_task`.
4. Setiap interaksi wajib membaca `MEMORI.md` terlebih dahulu dan memperbarui bagian relevan setelah interaksi yang mengubah proyek (AGENTS.md/memori-check).
5. Skill dan rules relevan wajib dimuat sebelum bekerja; indeks skill tersedia di `SKILLS_INDEX.md`.

**Alur end-to-end ringan yang diinginkan (kerangka awal, detail belum disepakati):**
1. **Ide/Diskusi** → pengguna mendiskusikan kebutuhan; output: keputusan/konteks yang tercatat.
2. **PRD** → hasil diskusi didokumentasikan di `prd/hasil_diskusi/diskusi_N.md`; output: status dan ruang lingkup yang jelas (kriteria "siap lanjut": Belum dibahas).
3. **Task** → PRD/keputusan diterjemahkan menjadi pekerjaan terstruktur (mis. `task.md` atau mekanisme lain); output: Belum dibahas.
4. **Implementasi** → pekerjaan dilakukan mengikuti skill/rules relevan; output: perubahan yang sesuai ruang lingkup.
5. **Verifikasi** → langkah verifikasi ringan dijalankan bila relevan; output/kriteria: Belum dibahas.
6. **Dokumentasi/MEMORI** → artefak proyek diperbarui sesuai perubahan; output: konteks proyek konsisten.

**Percabangan/kondisi alternatif:** Belum dibahas (mis. ketika PRD batal, task diblokir, atau verifikasi gagal).

**Kondisi akhir yang diharapkan:** Setiap hasil diskusi yang disepakati dapat ditelusuri menjadi task/pekerjaan dan penyelesaiannya terdokumentasi dengan transisi yang jelas. Definisi operasional "selesai/jelas": Belum dibahas.

## 5. Steps

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan langkah-langkah kerja yang harus diikuti dalam mengisi atau menerapkan PRD.

**Aturan pengisian:**

- Buat langkah-langkah yang spesifik dan dapat diikuti.
- Gunakan numbered list untuk mempertahankan urutan.
- Setiap langkah harus tidak ambigu dan dapat dikerjakan.
- Jangan memasukkan langkah yang tidak relevan atau redundan.

**Isi:**

1. **Masalah & cakupan (teridentifikasi awal):** Masalah utama = transisi diskusi→kerja tidak jelas. Cakupan yang diinginkan = alur end-to-end ringan (diskusi → PRD → task → implementasi → verifikasi → pembaruan dokumentasi/MEMORI). Rincian gejala/penyebab masalah: Belum dibahas.
2. **Definisikan kriteria transisi diskusi → kerja:** Tetapkan syarat minimal agar PRD/hasil diskusi siap dipecah menjadi task (mis. status dokumen, keputusan wajib, format output). Belum dibahas.
3. **Definisikan pemecahan ke task:** Tentukan mekanisme dan format penerjemahan PRD ke pekerjaan (mis. `task.md` mengikuti `format_task.md`, penggunaan `kerjakan_hasil_diskusi`/`kerjakan_task`, atau lainnya). Belum dibahas.
4. **Rumuskan detail tiap tahap end-to-end:** Untuk setiap tahap, tetapkan pemicu masuk, aktivitas, artefak/output, kriteria selesai, dan pemanfaatan command/mode yang ada. Belum dibahas.
5. **Tentukan verifikasi ringan & pembaruan konteks:** Sepakati checklist verifikasi minimal (bila relevan) dan kewajiban pembaruan artefak (`MEMORI.md`, dll.) saat pekerjaan selesai. Belum dibahas.
6. **Sepakati prioritas, batasan, dan kriteria keberhasilan:** Belum dibahas.
7. **Tentukan tindak lanjut implementasi alur:** Identifikasi dokumen/command/rule/skill yang perlu dibuat atau diubah berdasarkan keputusan (jika ada). Belum dibahas.
8. **Finalisasi status dokumen PRD:** Ubah `Status Dokumen` menjadi `Final` atau `Batal` setelah keputusan utama disepakati; sesuaikan isi PRD agar mencerminkan keputusan akhir.

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
| `prd/hasil_diskusi/diskusi_2.md` | Dibuat | Mendokumentasikan hasil diskusi PRD alur kerja proses/dev (dokumen ini). |
| Belum diketahui | Belum diketahui | File proses/dev lain (command, rule, skill, `AGENTS.md`, `MEMORI.md`, `task.md`, dll.) yang mungkin terdampak belum dapat ditentukan sebelum cakupan dan keputusan alur disepakati. |
