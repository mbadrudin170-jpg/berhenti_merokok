---
description: Baca seluruh aturan repositori, evaluasi semua skill custom, lalu perbarui skill yang belum sesuai atau tambahkan skill baru berdasarkan aturan dan riwayat commit.
agent: code
---

# Command: Sinkronkan Skill dengan Seluruh Aturan

## 1. Tujuan

Lakukan audit dan sinkronisasi seluruh skill yang berada di:

`.agents/skills/custom/`

dengan seluruh aturan yang berada di:

`.agents/rules/`

Tugas utama:

1. Membaca seluruh isi `.agents/rules/global/aturan_skill.md` sebelum melakukan pekerjaan lainnya.
2. Membaca seluruh isi setiap file yang ada di dalam `.agents/rules/`, termasuk file di subfolder.
3. Membaca seluruh skill yang sudah tersedia di `.agents/skills/custom/`.
4. Membandingkan aturan dengan isi skill yang sudah tersedia.
5. Memperbarui skill yang sudah ada apabila isinya belum sesuai dengan aturan.
6. Membuat skill baru apabila ditemukan kebutuhan yang belum dicakup oleh skill yang tersedia.
7. Memastikan seluruh perubahan tetap mengikuti aturan pembuatan dan pembaruan skill.

**Hasil akhir:** skill di `.agents/skills/custom/` menjadi panduan yang konsisten, tidak saling bertentangan, relevan dengan seluruh aturan proyek, dan dapat digunakan kembali pada proyek Flutter lainnya.

---

## 2. Batasan Pekerjaan

### 2.1. Lokasi yang boleh diperiksa

AI wajib memeriksa:

- `.agents/rules/` beserta seluruh subfolder dan file di dalamnya.
- `.agents/skills/custom/` beserta seluruh subfolder dan file di dalamnya.
- Riwayat commit kode proyek yang relevan dengan topik skill yang sedang diperiksa.

### 2.2. Lokasi yang boleh diubah

AI hanya boleh membuat atau memperbarui file di:

`.agents/skills/custom/`

AI dilarang mengubah:

- `.agents/rules/`
- Kode aplikasi di `lib/`, `test/`, dan folder kode lainnya.
- Skill di kategori selain `custom`.
- File konfigurasi proyek yang tidak berkaitan langsung dengan pembuatan skill.

Jangan mengubah ruang lingkup pekerjaan menjadi refactoring kode aplikasi.

### 2.3. Larangan

- Jangan membuat skill duplikat.
- Jangan menghapus skill.
- Jangan memindahkan atau mengganti nama folder skill yang sudah ada tanpa persetujuan pengguna.
- Jangan mengubah aturan sumber untuk menyesuaikan isi skill.
- Jangan mengabaikan aturan yang sulit diterapkan.
- Jangan mengarang pola implementasi yang tidak didukung sumber yang diizinkan.
- Jangan menyatakan suatu skill sudah sesuai sebelum seluruh file yang berkaitan selesai diperiksa.

---

# 3. Tahap Pertama — Baca Aturan Skill Terlebih Dahulu

**Tahap ini wajib dikerjakan sebelum tahap lainnya.**

Baca seluruh isi file:

`.agents/rules/global/aturan_skill.md`

Ketentuan:

1. Baca dari baris pertama sampai baris terakhir.
2. Jangan hanya membaca judul, daftar isi, atau ringkasan.
3. Jangan melewati subbagian, contoh, catatan, maupun ketentuan di dalamnya.
4. Apabila file terlalu panjang untuk dibaca sekaligus, baca secara bertahap berdasarkan rentang baris sampai seluruh isi selesai dibaca.
5. Catat bahwa file tersebut sudah selesai dibaca.
6. Pahami seluruh ketentuan mengenai lokasi skill, struktur folder, penamaan, examples, references, sumber commit, frontmatter, versi, dan sinkronisasi.
7. Jadikan file ini sebagai pedoman utama untuk seluruh pekerjaan pembuatan dan pembaruan skill.

**Larangan:** Jangan membaca skill untuk menentukan perubahan, membuat skill, atau mengedit skill sebelum tahap ini selesai.

### Pemeriksaan kelengkapan aturan

Setelah membaca file, periksa apakah terdapat:

- Kalimat yang terpotong.
- Bagian yang belum selesai.
- Ketentuan yang tidak memiliki penjelasan memadai.
- Instruksi yang saling bertentangan.
- Contoh yang berbeda dari ketentuan tertulis.

Jangan melengkapi sendiri aturan yang tidak lengkap dengan asumsi.

Apabila ketidaklengkapan tersebut memengaruhi keputusan perubahan skill, catat masalahnya dan jangan mengerjakan bagian yang keputusannya belum jelas.

---

# 4. Tahap Kedua — Baca Seluruh Isi Folder `.agents/rules/`

Setelah Tahap 3 selesai, baca seluruh file yang berada di:

`.agents/rules/`

### 4.1. Inventarisasi file

Lakukan pencarian secara rekursif, termasuk seluruh subfolder.

Gunakan inventarisasi seperti:

```bash
find .agents/rules -type f -print | sort
```

Tujuannya agar tidak ada file aturan yang terlewat hanya karena berada di subfolder yang berbeda.

### 4.2. Baca semua file

Untuk setiap file yang ditemukan:

1. Baca seluruh isi file.
2. Jangan hanya membaca sebagian.
3. Jangan menganggap nama file sudah cukup untuk memahami isinya.
4. Jangan melewati aturan karena dianggap tidak berkaitan dengan UI atau Flutter.
5. Jangan hanya membaca file yang dianggap relevan oleh AI.
6. Catat path setiap file yang sudah selesai dibaca.

Baca semua file, termasuk file yang memiliki nama seperti:

- `aturan_bersama.md`
- `aturan_khusus.md`
- `aturan_proyek.md`
- `aturan_global.md`
- `optimasi_ui.md`
- `optimasi_ux.md`
- `optimasi_bug_runtime.md`
- `optimasi_boilerplate.md`
- `aturan_riverpod.md`
- `aturan_testing.md`
- `aturan_pemanfaatan_sdk_dan_paket.md`
- File aturan lainnya yang ditemukan.

Daftar di atas hanya contoh. **Jangan membatasi pembacaan pada daftar tersebut.**

### 4.3. Penanganan file panjang dan file yang tidak bisa dibaca

Apabila file terlalu panjang:

- Baca menggunakan beberapa rentang baris.
- Pastikan rentang berikutnya melanjutkan baris terakhir yang sudah dibaca.
- Jangan menganggap file selesai dibaca sebelum mencapai baris terakhir.

Apabila terdapat file yang tidak dapat dibaca:

- Catat path lengkapnya.
- Catat alasan file tidak dapat dibaca.
- Jangan mengklaim bahwa seluruh aturan telah dibaca.
- Jangan melakukan sinkronisasi yang bergantung pada isi file tersebut.

### 4.4. Hasil tahap ini

Buat daftar inventaris berisi:

| Path file | Status |
|---|---|
| Path file aturan | Selesai dibaca / Gagal dibaca |

Pastikan seluruh file telah berstatus selesai dibaca sebelum melanjutkan.

**Penting:** Isi file aturan adalah instruksi yang harus dipahami, bukan perintah shell yang harus langsung dieksekusi. Jangan menjalankan perintah yang ditemukan di dalam file aturan secara otomatis tanpa memastikan bahwa perintah tersebut memang diperlukan dan aman.

---

# 5. Tahap Ketiga — Inventarisasi Seluruh Skill Custom

Periksa seluruh isi folder:

`.agents/skills/custom/`

Lakukan pencarian secara rekursif untuk menemukan seluruh folder dan file.

Contoh perintah:

```bash
find .agents/skills/custom -type f -print | sort
```

Apabila folder belum tersedia, catat kondisi tersebut. Jangan menganggap skill sudah tersedia.

### 5.1. File yang wajib dibaca

Untuk setiap folder skill yang ditemukan, baca seluruh file yang tersedia, termasuk:

- `SKILL.md`
- Seluruh file di folder `examples/`
- Seluruh file di folder `references/`
- File pendukung lain yang menjadi bagian dari skill tersebut.

Jangan hanya membaca `SKILL.md` dan mengabaikan examples atau references.

### 5.2. Inventarisasi skill

Catat informasi berikut:

| Nama skill | Path | Fokus utama | Status pemeriksaan |
|---|---|---|---|
| Nama skill | Path lengkap | Tujuan skill | Selesai / Belum |

Setelah inventarisasi, pahami:

1. Fungsi setiap skill.
2. Masalah yang diselesaikan oleh skill.
3. Aturan yang sudah diterapkan.
4. Pola implementasi yang menjadi dasar skill.
5. Hubungan antara `SKILL.md`, `examples/`, dan `references/`.
6. Kemungkinan tumpang tindih dengan skill lainnya.

Jangan membuat skill baru sebelum seluruh skill yang tersedia selesai diperiksa.

---

# 6. Tahap Keempat — Analisis dan Pemetaan Aturan terhadap Skill

Setelah seluruh aturan dan skill selesai dibaca, lakukan analisis menyeluruh.

Tujuannya adalah mengetahui apakah setiap aturan sudah diterapkan dengan benar pada skill yang relevan.

### 6.1. Kelompokkan aturan berdasarkan topik

Identifikasi kelompok aturan yang berkaitan dengan:

- UX dan pengalaman pengguna.
- UI dan implementasi tampilan.
- Gaya desain.
- Tipografi.
- Spacing dan layout.
- Widget custom.
- Bug dan runtime.
- Boilerplate dan struktur kode.
- State management.
- Database dan transaksi.
- Logging dan debugging.
- Testing.
- Pemanfaatan SDK dan package.
- Keamanan.
- Performa.
- Notifikasi.
- Fitur atau kebutuhan teknis lainnya.

Daftar ini bukan pembatas. AI wajib menyesuaikannya dengan seluruh isi aturan yang ditemukan.

### 6.2. Cocokkan aturan dengan skill

Untuk setiap kelompok aturan, tentukan:

1. Apakah sudah terdapat skill yang membahas topik tersebut?
2. Apakah skill sudah mencakup semua ketentuan yang relevan?
3. Apakah isi skill masih sesuai dengan aturan terbaru?
4. Apakah terdapat ketentuan yang belum dimasukkan?
5. Apakah examples masih menggambarkan implementasi yang dijelaskan?
6. Apakah references masih relevan?
7. Apakah ada instruksi yang bertentangan dengan aturan lain?
8. Apakah terdapat beberapa skill yang membahas hal sama?

### 6.3. Buat matriks pemetaan

Gunakan format berikut:

| Aturan | Topik | Skill terkait | Temuan | Tindakan |
|---|---|---|---|---|
| Path aturan | Topik | Nama skill | Sudah sesuai / Kurang / Bertentangan / Belum tersedia | Pertahankan / Perbarui / Skill baru |

Jangan langsung mengedit sebelum pemetaan selesai.

### 6.4. Prinsip penilaian

- Skill dianggap sesuai apabila seluruh aturan yang relevan sudah tercermin secara benar.
- Skill dianggap kurang apabila sebagian aturan belum tercakup.
- Skill dianggap usang apabila isinya tidak lagi sesuai dengan aturan terbaru.
- Skill dianggap bertentangan apabila instruksinya berbeda atau melanggar aturan yang berlaku.
- Skill dianggap belum tersedia apabila tidak ada skill yang membahas kebutuhan tersebut.
- Skill dianggap tumpang tindih apabila beberapa skill memiliki cakupan dan tujuan yang terlalu mirip.

Jangan membuat satu skill untuk setiap file aturan secara otomatis. Kelompokkan aturan yang saling berkaitan ke dalam skill yang memiliki tujuan dan batas tanggung jawab jelas.

---

# 7. Tahap Kelima — Tentukan Skill yang Diperbarui atau Skill Baru

Gunakan keputusan berikut.

### A. Perbarui skill yang sudah ada

Apabila topik aturan sudah memiliki skill yang sesuai:

1. Gunakan skill tersebut sebagai lokasi pembaruan.
2. Perbarui isi `SKILL.md` agar sesuai dengan seluruh aturan terkait.
3. Pertahankan bagian yang masih benar dan relevan.
4. Perbaiki bagian yang kurang lengkap, usang, atau bertentangan.
5. Periksa kembali seluruh examples.
6. Periksa references apabila tersedia.
7. Jangan membuat skill baru hanya untuk menambahkan ketentuan kecil yang masih termasuk tanggung jawab skill tersebut.

### B. Tambahkan skill baru

Apabila ditemukan topik yang belum memiliki skill:

1. Pastikan kebutuhan tersebut merupakan topik yang jelas dan memiliki tujuan tersendiri.
2. Pastikan tidak ada skill yang sudah mencakup kebutuhan yang sama.
3. Pastikan topik tersebut layak menjadi panduan yang dapat digunakan kembali.
4. Buat skill baru di `.agents/skills/custom/`.
5. Gunakan nama folder bahasa Indonesia yang deskriptif dan kebab-case.
6. Buat seluruh struktur file berdasarkan `aturan_skill.md`.

### C. Hindari duplikasi dan tumpang tindih

Apabila ditemukan beberapa skill yang cakupannya mirip:

- Jangan langsung membuat skill tambahan.
- Tentukan skill yang paling tepat untuk diperbarui.
- Pertahankan batas tanggung jawab setiap skill.
- Jangan menggabungkan, menghapus, memindahkan, atau mengganti nama skill lama tanpa persetujuan pengguna.
- Laporkan apabila memang diperlukan penataan ulang struktur.

### D. Apabila tidak ditemukan commit terkait

Ikuti ketentuan sumber commit dalam `aturan_skill.md`.

Namun, terdapat kondisi yang harus ditangani secara khusus:

Apabila tidak ditemukan commit terkait tetapi sudah ada skill yang membahas topik yang sama, jangan langsung membuat skill baru dan jangan membuat duplikat.

Laporkan kondisi tersebut sebagai potensi konflik antara ketentuan penambahan skill tanpa commit dan prinsip menghindari skill duplikat. Jangan menebak keputusan yang harus diambil.

---

# 8. Tahap Keenam — Periksa Riwayat Commit sebagai Sumber Skill

**Tahap ini wajib mengikuti seluruh ketentuan sumber isi pada `aturan_skill.md`.**

Sebelum menyusun atau mengubah pola implementasi dalam `SKILL.md` dan `examples/`, periksa riwayat commit yang berkaitan dengan topik tersebut.

### 8.1. Cari commit terkait

Gunakan riwayat Git, misalnya:

```bash
git log --all --oneline -- <path-file-terkait>
```

Periksa perubahan commit:

```bash
git show <hash-commit> -- <path-file-terkait>
```

Untuk membandingkan dua commit:

```bash
git diff <hash-commit-lama> <hash-commit-baru> -- <path-file-terkait>
```

Gunakan hanya commit yang benar-benar berkaitan dengan topik skill.

### 8.2. Jika commit terkait ditemukan

- Gunakan implementasi dari commit yang relevan sebagai sumber.
- Pilih pola dari commit terbaru yang relevan apabila terdapat beberapa pola berbeda.
- Jangan menggunakan pola yang tidak pernah muncul pada riwayat commit.
- Cantumkan hash commit yang benar pada setiap file contoh.
- Sesuaikan isi `SKILL.md` dengan pola yang benar-benar ditemukan.

### 8.3. Jika tidak ada commit terkait

Ikuti ketentuan `aturan_skill.md` mengenai pembuatan skill tanpa commit rujukan.

Gunakan:

```dart
// commit: belum-ada-commit
```

Jangan membuat hash commit palsu atau mencantumkan commit yang tidak berkaitan.

### 8.4. Larangan sumber

Jangan menggunakan:

- Perubahan yang belum di-commit.
- Isi working directory sebagai sumber pola implementasi.
- Perubahan staging.
- File untracked.

File skill yang sudah ada boleh dibaca sebagai kondisi awal dan target pembaruan, tetapi bukan sebagai pengganti sumber riwayat commit untuk membuktikan pola implementasi.

---

# 9. Tahap Ketujuh — Terapkan Pembaruan Skill

Setelah analisis selesai dan keputusan perubahan sudah jelas, lakukan pembaruan.

### 9.1. Lokasi skill

Semua skill baru wajib berada di:

`.agents/skills/custom/<nama-skill>/`

Struktur wajib:

```text
.agents/skills/custom/<nama-skill>/
├── SKILL.md
├── examples/
│   ├── input-<varian>.dart
│   └── output-<varian>.dart
└── references/          (opsional)
    └── <topik>.md
```

### 9.2. Pembaruan SKILL.md

Pastikan:

- Frontmatter mengikuti `aturan_skill.md`.
- `name` sesuai nama folder.
- `description` menjelaskan fungsi dan kondisi penggunaan skill secara spesifik.
- `metadata.kategori` sesuai dengan kategori folder.
- `metadata.versi` menggunakan SemVer dan meningkat setiap kali skill diubah.
- `metadata.commit-terakhir` sesuai sumber commit atau `belum-ada-commit`.
- `metadata.model` diperbarui apabila field tersebut digunakan, berdasarkan identitas model yang benar-benar sedang mengedit.
- Instruksi dapat dipahami tanpa bergantung pada percakapan sebelumnya.
- Isi skill tidak bertentangan dengan aturan proyek.
- Isi skill sebisa mungkin dapat digunakan kembali pada proyek Flutter lainnya.

Jangan menebak identitas model. Apabila model aktual tidak dapat dipastikan, laporkan dan jangan mengisi nilai palsu.

### 9.3. Pembaruan examples

Setiap skill wajib mempunyai folder `examples/`.

Minimal terdapat satu pasangan:

```text
examples/
├── input-<varian>.dart
└── output-<varian>.dart
```

Ketentuan:

- Isi folder `examples/` hanya file `.dart`.
- Setiap file `input` wajib memiliki pasangan `output` dengan nama varian sama.
- Nama varian menggunakan bahasa Indonesia dan kebab-case.
- File `input` menunjukkan kasus atau kode awal.
- File `output` menunjukkan hasil implementasi sesuai skill.
- Baris pertama setiap contoh harus mencantumkan komentar commit yang sesuai.
- Contoh harus menggambarkan instruksi dalam `SKILL.md`.
- File contoh tidak wajib dapat dikompilasi secara mandiri.
- File contoh tidak boleh di-import oleh `lib/` maupun `test/`.

Jangan hanya memperbarui `SKILL.md` tanpa memeriksa apakah examples masih sesuai.

### 9.4. Pembaruan references

Folder `references/` bersifat opsional.

Apabila references tersedia:

- Periksa relevansinya dengan isi skill terbaru.
- Perbarui apabila materi sudah usang atau tidak konsisten.
- Gunakan nama file `.md` dengan kebab-case.
- Jangan membuat references yang hanya mengulang isi `SKILL.md` tanpa memberikan manfaat tambahan.

### 9.5. Sinkronisasi antarfile

Setiap perubahan harus menjaga konsistensi:

- `SKILL.md` harus sesuai dengan examples.
- Examples harus menggambarkan langkah yang dijelaskan di `SKILL.md`.
- References harus mendukung instruksi skill.
- Frontmatter harus sesuai dengan lokasi dan identitas skill.
- Satu skill tidak boleh memberikan instruksi yang bertentangan dengan skill lain untuk masalah yang sama.

---

# 10. Tahap Kedelapan — Verifikasi Hasil

Setelah pembaruan selesai, lakukan pemeriksaan ulang.

### 10.1. Pemeriksaan struktur

Periksa seluruh file pada skill yang diubah atau dibuat.

Pastikan:

- Lokasi folder benar.
- Nama folder sesuai aturan.
- `SKILL.md` tersedia.
- Folder `examples/` tersedia dan tidak kosong.
- Minimal satu pasangan input-output tersedia.
- Tidak ada file selain `.dart` di `examples/`.
- Folder `references/`, apabila ada, memiliki file `.md` yang sesuai.
- Tidak ada file yang tertinggal atau tidak memiliki pasangan.

### 10.2. Pemeriksaan isi

Pastikan:

- Isi `SKILL.md` mengikuti seluruh aturan yang relevan.
- Tidak ada instruksi yang saling bertentangan.
- Tidak ada instruksi ambigu.
- Tidak ada pola implementasi yang dibuat tanpa dasar yang diizinkan.
- Setiap examples memiliki komentar commit yang benar.
- Versi meningkat apabila skill berubah.
- Model diperbarui apabila metadata model digunakan.
- Hash commit sesuai sumber yang digunakan.
- Tidak ada duplikasi fungsi dengan skill lain.

### 10.3. Pemeriksaan konsistensi seluruh skill

Periksa kembali hubungan antara skill yang diperbarui, skill baru, dan skill lain yang sudah ada.

Pastikan:

1. Tidak terdapat instruksi yang saling bertentangan.
2. Tidak terdapat dua skill dengan tujuan yang sama tanpa alasan yang jelas.
3. Tidak ada aturan penting yang hilang dari skill terkait.
4. Tidak ada perubahan yang keluar dari ruang lingkup.
5. Skill yang tidak perlu diubah tetap dipertahankan.

### 10.4. Pemeriksaan perubahan

Gunakan:

```bash
git diff --check -- .agents/skills/custom/
```

Periksa daftar perubahan untuk memastikan tidak ada file di luar lokasi yang diizinkan.

Jangan mengubah file aturan atau kode aplikasi hanya untuk membuat hasil pemeriksaan terlihat bersih.

---

# 11. Laporan Hasil

Setelah seluruh pekerjaan selesai, berikan laporan terstruktur.

## A. Ringkasan pembacaan

Tampilkan:

- Jumlah file di `.agents/rules/`.
- Jumlah file aturan yang berhasil dibaca.
- Jumlah file aturan yang gagal dibaca, jika ada.
- Jumlah skill yang diperiksa.
- Daftar path yang belum dapat diperiksa, jika ada.

Jangan menyatakan seluruh file sudah dibaca apabila masih ada file yang terlewat atau gagal dibaca.

## B. Skill diperbarui

| Nama skill | Path | Perubahan |
|---|---|---|
| Nama skill | Path lengkap | Ringkasan perubahan |

## C. Skill baru

| Nama skill | Path | Tujuan |
|---|---|---|
| Nama skill | Path lengkap | Alasan penambahan |

## D. Skill tidak berubah

Tampilkan nama skill yang sudah sesuai dengan aturan sehingga tidak memerlukan perubahan.

## E. Temuan aturan

Tampilkan:

- Aturan yang belum tercakup oleh skill.
- Aturan yang saling bertentangan.
- Skill yang memiliki cakupan tumpang tindih.
- Aturan yang belum lengkap atau ambigu.
- Kondisi yang membutuhkan keputusan pengguna.

Cantumkan path file dan bagian aturan yang berkaitan agar mudah diperiksa.

## F. Verifikasi

Laporkan hasil pemeriksaan:

- Struktur folder.
- Frontmatter.
- Examples.
- References.
- Versi dan metadata.
- Sumber commit.
- Konsistensi antar-skill.
- Pemeriksaan `git diff --check`.

Gunakan status yang jelas: **Lulus**, **Gagal**, atau **Belum dapat diverifikasi**.

---

# 12. Ketentuan Akhir

1. Prioritaskan kesesuaian dengan seluruh aturan, bukan banyaknya skill yang berhasil dibuat.
2. Perbarui skill yang sudah ada apabila topiknya memang sudah tercakup.
3. Tambahkan skill baru hanya apabila terdapat kebutuhan yang belum memiliki cakupan memadai.
4. Jangan membuat duplikasi hanya untuk memisahkan aturan yang sebenarnya masih satu tanggung jawab.
5. Jangan mengubah file aturan.
6. Jangan mengubah kode aplikasi.
7. Jangan menghapus atau memindahkan skill tanpa persetujuan.
8. Jangan mengarang keputusan apabila aturan tidak lengkap atau saling bertentangan.
9. Seluruh perubahan harus dapat ditelusuri berdasarkan path file dan sumber commit yang digunakan.
10. Pastikan laporan akhir mencerminkan kondisi repositori yang benar-benar sudah diperiksa dan dikerjakan.

**Mulai dari Tahap 3 dan kerjakan secara berurutan. Jangan melewati tahapan.**