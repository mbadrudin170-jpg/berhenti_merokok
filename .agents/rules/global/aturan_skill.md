# ATURAN INTI: PEMBUATAN DAN PEMBARUAN SKILL.md

## 1. TUJUAN

Aturan ini menjadi standar wajib bagi AI ketika membuat, memperbarui, memperbaiki, mengevaluasi, atau menyusun ulang file `SKILL.md` beserta seluruh berkas pendukungnya.

Tujuan utama:

1. Menghasilkan skill yang benar-benar berdasarkan pola implementasi dan pengalaman pengembangan yang terdapat dalam riwayat commit proyek.
2. Menghindari pembuatan panduan berdasarkan asumsi, kebiasaan AI, atau pola implementasi yang tidak pernah digunakan pengguna.
3. Menghasilkan skill yang dapat digunakan kembali pada berbagai proyek Flutter milik pengguna.
4. Menjaga konsistensi antara instruksi dalam `SKILL.md`, contoh implementasi, dan dokumen referensi.
5. Mencegah duplikasi, konflik, struktur yang tidak konsisten, dan perubahan yang tidak diperlukan.
6. Memastikan setiap skill memiliki dokumentasi yang cukup agar AI lain dapat memahami dan menerapkannya tanpa menebak maksud instruksi.

Aturan ini berlaku untuk seluruh kategori skill, baik skill Flutter maupun skill non-Flutter.

## 2. PRINSIP UTAMA

AI WAJIB mengikuti prinsip berikut:

### 2.1. Berdasarkan implementasi nyata

- Utamakan pola implementasi yang benar-benar terdapat dalam riwayat commit pengguna.
- Jangan menganggap praktik umum, dokumentasi eksternal, atau preferensi AI sebagai standar implementasi pengguna.
- Jangan mengubah pola implementasi pengguna hanya karena AI memiliki pendekatan lain.
- Jangan membuat aturan baru yang tidak memiliki dasar dari sumber yang diizinkan, kecuali dalam kondisi pembuatan skill baru yang belum memiliki commit rujukan.
- Jika ditemukan beberapa pendekatan yang berbeda, tentukan pendekatan berdasarkan ketentuan pemilihan commit dalam aturan ini.

### 2.2. Dapat digunakan lintas proyek

Skill Flutter harus dirancang agar dapat digunakan kembali pada berbagai proyek Flutter pengguna.

Ketentuannya:

- Hindari ketergantungan terhadap nama proyek tertentu.
- Hindari penggunaan path, nama class, nama fitur, atau nama variabel yang hanya berlaku pada satu proyek sebagai ketentuan universal.
- Gunakan istilah dan contoh yang mudah disesuaikan dengan struktur proyek berbeda.
- Jika suatu pola hanya berlaku pada kondisi tertentu, jelaskan kondisi penerapannya.
- Jika terdapat perbedaan implementasi antarproyek, jangan memaksakan satu pola sebagai standar universal.
- Pisahkan aturan universal dan aturan khusus proyek jika memang diperlukan.

### 2.3. Tidak membuat asumsi

Jika informasi tidak tersedia atau tidak cukup untuk menentukan suatu aturan:

- Jangan mengarang implementasi yang dianggap pernah digunakan pengguna.
- Jangan menyimpulkan pola hanya berdasarkan nama file atau nama folder.
- Jangan mengubah ketentuan yang belum jelas berdasarkan interpretasi pribadi.
- Identifikasi informasi yang belum tersedia.
- Laporkan ketidakpastian sebelum mengambil keputusan yang dapat mengubah maksud aturan.

## 3. LOKASI DAN STRUKTUR SKILL

### 3.1. Lokasi wajib

Seluruh skill harus disimpan dalam struktur berikut:

`.agents/skills/<kategori>/<nama-skill>/`

Gunakan nama direktori `skills` (jamak), bukan `skill` (tunggal).

Kategori default adalah `custom`, kecuali pengguna menentukan kategori lain atau repositori sudah memiliki ketentuan kategori yang berbeda dan telah disetujui pengguna.

Contoh:

`.agents/skills/custom/pola-ux/SKILL.md`

### 3.2. Struktur direktori wajib

Setiap skill wajib menggunakan struktur berikut:

```text
.agents/skills/<kategori>/<nama-skill>/
├── SKILL.md
├── examples/
│   ├── input-<varian>.md
│   └── output-<varian>.md
└── references/
    └── <topik>.md
```

Ketentuan:

1. `SKILL.md` wajib tersedia.
2. Folder `examples/` wajib tersedia.
3. Folder `examples/` wajib memiliki minimal satu pasang file input dan output.
4. Folder `references/` bersifat opsional.
5. Jangan membuat folder atau file yang tidak memiliki kegunaan nyata.
6. Jangan memindahkan atau mengganti nama skill lama tanpa terlebih dahulu memeriksa dampaknya terhadap referensi dan aturan yang sudah ada.

### 3.3. Kategori

Kategori merupakan pengelompokan skill, bukan nama skill.

Gunakan `custom` sebagai kategori default.

Jika pengguna telah menentukan kategori lain, gunakan kategori tersebut. Jangan membuat kategori baru apabila kategori yang tersedia sudah sesuai.

## 4. STANDAR KATALOG SKILL FLUTTER

Untuk pengembangan Flutter, gunakan delapan topik berikut sebagai standar katalog skill.

### 4.1. Skill UI/UX

1. `pola-ux`
2. `pola-ui`
3. `gaya`
4. `tipografi`
5. `spacing`
6. `widget-custom`

### 4.2. Skill non-UI

7. `bug-runtime`
8. `boilerplate`

Lokasi standar dengan kategori default:

```text
.agents/skills/custom/
├── pola-ux/
│   └── SKILL.md
├── pola-ui/
│   └── SKILL.md
├── gaya/
│   └── SKILL.md
├── tipografi/
│   └── SKILL.md
├── spacing/
│   └── SKILL.md
├── widget-custom/
│   └── SKILL.md
├── bug-runtime/
│   └── SKILL.md
└── boilerplate/
    └── SKILL.md
```

Ketentuan:

- Nama tersebut merupakan standar penamaan topik skill Flutter.
- Jangan membuat skill duplikat dengan nama berbeda tetapi memiliki tujuan dan cakupan yang sama.
- Sebelum membuat skill, periksa katalog yang sudah tersedia.
- Jika suatu topik sudah memiliki skill, prioritaskan memperbarui skill tersebut daripada membuat duplikat.
- Jangan membuat seluruh katalog secara otomatis ketika pengguna hanya meminta satu skill.
- Buat atau perbarui skill sesuai ruang lingkup pekerjaan yang diminta pengguna.

## 5. ATURAN PENAMAAN FOLDER SKILL

Nama folder skill wajib memenuhi seluruh ketentuan berikut:

1. Menggunakan bahasa Indonesia.
2. Menunjukkan isi atau fungsi skill secara deskriptif.
3. Menggunakan format `kebab-case`.
4. Menggunakan tanda hubung `-` sebagai pemisah kata.
5. Menggunakan huruf kecil.
6. Hanya menggunakan karakter `a-z`, angka `0-9`, dan tanda hubung `-`.
7. Tidak boleh diawali angka.
8. Tidak boleh menggunakan garis bawah `_`.
9. Tidak boleh menggunakan spasi.
10. Tidak boleh menggunakan huruf kapital.
11. Tidak boleh menggunakan karakter khusus selain tanda hubung.

Contoh yang benar:

- `pola-ux`
- `pola-ui`
- `bug-runtime`
- `widget-custom`
- `pengujian-integrasi`

Contoh yang salah:

- `Pola-UX`
- `pola_ux`
- `pola ux`
- `skill-ui`
- `01-pola-ux`

Nama folder harus mencerminkan isi skill, bukan sekadar nama umum yang tidak menjelaskan kegunaannya.

## 6. ATURAN FRONTMATTER SKILL.md

Setiap file `SKILL.md` WAJIB memiliki frontmatter YAML di bagian paling atas.

Frontmatter harus:

- Dimulai dengan `---` pada baris pertama.
- Diakhiri dengan `---` setelah seluruh field frontmatter.
- Menggunakan sintaks YAML yang valid.
- Memuat seluruh field wajib.
- Tidak menambahkan field wajib baru tanpa kebutuhan yang jelas.

### 6.1. Field wajib

| Field | Ketentuan |
|---|---|
| `name` | Harus sama persis dengan nama folder skill. |
| `description` | Ringkasan isi skill dalam satu kalimat yang jelas. |
| `kategori` | Harus sama dengan nama folder kategori. |
| `versi` | Harus menggunakan format semver. |
| `commit-terakhir` | Hash commit rujukan terakhir atau `belum-ada-commit`. |

### 6.2. Field opsional

`model` dapat digunakan untuk mencatat model AI yang digunakan ketika menyusun skill.

Jangan mengisi field opsional dengan informasi yang tidak diketahui.

### 6.3. Contoh frontmatter

```yaml
---
name: pengujian-integrasi-flutter
description: Panduan membuat pengujian integrasi Flutter dengan mengeksplorasi antarmuka dan mengotomasi alur pengguna.
kategori: custom
versi: 1.0.0
model: models/gemini-3.1-pro-preview
commit-terakhir: abc123456789
---
```

Jika belum memiliki commit rujukan:

```yaml
---
name: pengujian-integrasi-flutter
description: Panduan membuat pengujian integrasi Flutter dengan mengeksplorasi antarmuka dan mengotomasi alur pengguna.
kategori: custom
versi: 1.0.0
commit-terakhir: belum-ada-commit
---
```

### 6.4. Aturan versi

Gunakan format semver:

`MAJOR.MINOR.PATCH`

Ketentuan:

- `MAJOR`: perubahan besar yang mengubah kontrak atau cara penggunaan skill.
- `MINOR`: penambahan kemampuan, panduan, atau cakupan yang tetap kompatibel.
- `PATCH`: perbaikan redaksi, typo, penjelasan, dan koreksi kecil yang tidak mengubah perilaku instruksi.

Jangan menaikkan versi tanpa alasan yang sesuai dengan perubahan.

## 7. SUMBER DATA PENYUSUNAN SKILL

### 7.1. Sumber utama

Semua isi `SKILL.md` dan `examples/` wajib disusun berdasarkan riwayat commit kode pengguna apabila commit yang relevan tersedia.

AI hanya diperbolehkan menggunakan data dari commit yang sudah tercatat dalam Git.

Sumber yang diperbolehkan:

- `git log`
- `git show`
- `git diff <commit-awal> <commit-akhir>`
- `git show <hash-commit>:<path-file>`

Perintah tersebut hanya boleh digunakan dengan referensi commit yang sudah ada.

### 7.2. Sumber yang dilarang

AI DILARANG menggunakan isi atau perubahan dari:

1. Working directory yang belum di-commit.
2. Perubahan yang masih berada dalam staging area.
3. File untracked.
4. Perubahan lokal yang belum tercatat dalam riwayat commit.
5. Hasil implementasi sementara yang belum menjadi commit.
6. Potongan kode yang dibuat AI sendiri dan dianggap sebagai implementasi pengguna.

Larangan ini berlaku untuk penyusunan isi `SKILL.md` dan `examples/`.

AI boleh memeriksa status Git untuk mengetahui kondisi repositori, tetapi tidak boleh menggunakan isi perubahan yang belum di-commit sebagai sumber penyusunan skill.

### 7.3. Cara memeriksa riwayat commit

AI wajib:

1. Mengidentifikasi topik dan cakupan skill.
2. Menentukan file atau folder kode yang berkaitan dengan topik tersebut.
3. Memeriksa riwayat commit yang menyentuh file atau folder terkait.
4. Membaca implementasi pada commit yang relevan.
5. Membandingkan perubahan antarcommit apabila diperlukan.
6. Mengidentifikasi pola implementasi yang benar-benar digunakan.
7. Menentukan commit rujukan yang akan digunakan.

Contoh:

```bash
git log --all --oneline -- path/terkait
```

Membaca implementasi pada commit tertentu:

```bash
git show <hash-commit>:<path-file>
```

Membandingkan dua commit:

```bash
git diff <commit-awal> <commit-akhir> -- <path-terkait>
```

Jangan menggunakan perintah perbandingan yang melibatkan working directory sebagai sumber penyusunan skill.

### 7.4. Definisi commit yang berkaitan

Commit yang berkaitan adalah commit yang menyentuh file atau folder kode yang memiliki hubungan langsung dengan topik skill.

Contoh:

- Skill `spacing` menggunakan commit yang mengubah implementasi pengaturan jarak antarelemen.
- Skill `bug-runtime` menggunakan commit yang memperbaiki kesalahan runtime.
- Skill `tipografi` menggunakan commit yang mengubah implementasi teks, font, atau pengaturan tipografi.
- Skill `pola-ux` menggunakan commit yang mengubah alur interaksi atau perilaku antarmuka.

Jangan menganggap commit berkaitan hanya karena pesan commit mengandung kata yang mirip dengan nama skill.

Periksa perubahan kode yang sebenarnya.

## 8. ATURAN PEMILIHAN COMMIT RUJUKAN

### 8.1. Jika terdapat commit yang berkaitan

Apabila terdapat satu atau beberapa commit yang berkaitan:

1. Susun isi `SKILL.md` berdasarkan implementasi pada commit yang relevan.
2. Susun seluruh contoh berdasarkan implementasi yang benar-benar ditemukan.
3. Setiap pasangan contoh wajib mencantumkan hash commit rujukannya.
4. Jika terdapat beberapa commit dengan pola yang berbeda, gunakan pola dari commit terbaru yang relevan.
5. Jika commit terbaru hanya mengubah sebagian implementasi, periksa riwayat sebelumnya agar konteks implementasi tidak hilang.
6. Jangan menggabungkan pola lama dan baru apabila keduanya saling bertentangan.
7. Jika terdapat perubahan pola yang belum dapat dipastikan sebagai standar baru, laporkan kepada pengguna.

Pengecualian hanya berlaku jika pengguna secara eksplisit menentukan commit atau pola tertentu sebagai rujukan.

### 8.2. Jika tidak terdapat commit yang berkaitan

Jika tidak ditemukan commit yang berkaitan:

- Untuk pembuatan skill baru, AI WAJIB menyusun skill baru berdasarkan rancangan yang dibuat AI.
- Rancangan harus sesuai dengan tujuan skill dan dapat digunakan lintas proyek Flutter.
- `SKILL.md` dan `examples/` harus tetap dibuat secara lengkap.
- Field `commit-terakhir` wajib diisi `belum-ada-commit`.
- Setiap file contoh wajib menjelaskan bahwa contoh tersebut merupakan rancangan awal yang belum memiliki commit rujukan.
- Jangan menyatakan bahwa rancangan tersebut merupakan pola implementasi yang pernah digunakan pengguna.

Untuk pembaruan skill yang sudah ada tetapi tidak memiliki commit rujukan, AI wajib memeriksa isi skill dan melaporkan keterbatasan sumber sebelum mengganti atau mengubah substansi panduannya. Jangan menganggap rancangan lama sebagai implementasi yang sudah terbukti melalui commit.

### 8.3. Batasan pengecualian

Izin menyusun rancangan baru hanya berlaku ketika memang tidak ada commit yang berkaitan.

Di luar kondisi tersebut, AI DILARANG:

- Mengarang pola implementasi.
- Mengarang contoh kode.
- Menganggap praktik umum sebagai kebiasaan pengguna.
- Menggunakan kode dari working directory sebagai pengganti commit.
- Menggabungkan implementasi yang berbeda tanpa dasar.
- Mengubah implementasi pengguna berdasarkan preferensi pribadi AI.

## 9. ATURAN PEMBUATAN EXAMPLES

Folder `examples/` merupakan bagian wajib dari setiap skill.

### 9.1. Struktur pasangan file

Setiap skill wajib memiliki minimal satu pasangan file:

```text
examples/
├── input-contoh.md
└── output-contoh.md
```

Ketentuan:

1. Setiap `input-<varian>.md` wajib memiliki pasangan `output-<varian>.md`.
2. Nama `<varian>` pada kedua file harus sama persis.
3. Nama varian menggunakan bahasa Indonesia dan format `kebab-case`.
4. Folder `examples/` tidak boleh kosong.
5. Satu pasangan file harus menggambarkan satu skenario yang jelas.
6. Jangan membuat pasangan contoh yang tidak memiliki hubungan langsung dengan isi skill.

### 9.2. Isi input

File `input-<varian>.md` harus berisi kondisi awal atau instruksi yang menjadi masukan untuk penerapan skill.

Isi dapat mencakup:

- Konteks pekerjaan.
- Permintaan atau masalah.
- Kondisi awal.
- Batasan implementasi.
- Informasi yang diperlukan untuk memahami skenario.

Jangan memasukkan informasi yang tidak diperlukan untuk memahami contoh.

### 9.3. Isi output

File `output-<varian>.md` harus berisi hasil atau bentuk penerapan yang diharapkan berdasarkan input pasangannya.

Isi harus:

- Menunjukkan penerapan aturan skill.
- Konsisten dengan isi `SKILL.md`.
- Tidak bertentangan dengan pola implementasi yang dijadikan rujukan.
- Menjelaskan hasil secara cukup agar dapat dipahami AI lain.
- Tidak menambahkan persyaratan yang tidak terdapat dalam skill.

### 9.4. Rujukan commit dalam examples

Jika contoh bersumber dari commit yang berkaitan, setiap file contoh wajib mencantumkan hash commit sebagai rujukan.

Contoh:

```markdown
# Contoh: Pengaturan Spacing

## Sumber

- Commit: `abc123456789`
- File rujukan: `lib/widgets/contoh_widget.dart`

## Tujuan

Menunjukkan penerapan pengaturan jarak antarelemen.
```

Gunakan hash commit dan path file yang benar-benar ditemukan.

Jangan membuat hash, path, atau rujukan palsu.

Jika belum terdapat commit yang berkaitan, gunakan keterangan:

```markdown
## Status Rujukan

- Status: Belum memiliki commit rujukan.
- Jenis: Rancangan awal AI.
- Catatan: Contoh ini merupakan rancangan awal dan belum dapat dianggap sebagai pola implementasi yang pernah digunakan pengguna.
```

## 10. ATURAN REFERENCES

Folder `references/` bersifat opsional.

Buat folder ini hanya apabila skill memang membutuhkan dokumen pendukung untuk menjelaskan teori, pola, standar, atau informasi tambahan yang tidak perlu dimasukkan seluruhnya ke dalam `SKILL.md`.

Ketentuan:

1. Semua file referensi menggunakan format `.md`.
2. Nama file menggunakan bahasa Indonesia.
3. Nama file menggunakan `kebab-case`.
4. Setiap referensi harus berkaitan langsung dengan skill.
5. Hindari duplikasi penjelasan yang sudah lengkap di `SKILL.md`.
6. `SKILL.md` harus menjelaskan kapan dan bagaimana referensi digunakan.
7. Jangan membuat references hanya untuk memenuhi struktur direktori.

Contoh:

```text
references/
├── prinsip-desain.md
├── pola-interaksi.md
└── panduan-aksesibilitas.md
```

## 11. STANDAR PENULISAN SKILL.md

`SKILL.md` harus menjadi panduan operasional yang dapat langsung digunakan AI ketika mengerjakan tugas.

Ketentuan penulisan:

1. Gunakan bahasa Indonesia yang baik dan benar.
2. Gunakan kalimat instruksi yang tegas dan tidak ambigu.
3. Bedakan kewajiban, larangan, dan rekomendasi.
4. Jelaskan kondisi penerapan setiap aturan.
5. Jelaskan tindakan yang harus dilakukan AI.
6. Jelaskan tindakan yang dilarang.
7. Jelaskan pengecualian apabila memang ada.
8. Hindari pengulangan aturan yang tidak memberikan manfaat.
9. Hindari kalimat umum seperti "gunakan kode yang baik" tanpa penjelasan operasional.
10. Hindari instruksi yang mengharuskan AI menebak maksud pengguna.
11. Gunakan contoh seperlunya untuk menjelaskan aturan yang sulit dipahami.
12. Pastikan setiap instruksi dapat diterapkan dan diverifikasi.

### 11.1. Susunan isi yang dianjurkan

Susun isi `SKILL.md` dengan urutan berikut apabila sesuai dengan kebutuhan skill:

1. Tujuan skill.
2. Ruang lingkup.
3. Kondisi penggunaan.
4. Sumber informasi atau rujukan.
5. Aturan inti.
6. Langkah penerapan.
7. Ketentuan yang wajib dipatuhi.
8. Larangan.
9. Pengecualian.
10. Contoh atau referensi terkait.

Tidak semua skill harus memiliki seluruh bagian tersebut. Gunakan hanya bagian yang relevan.

### 11.2. Pemisahan kewajiban dan rekomendasi

Gunakan istilah secara konsisten:

- **WAJIB:** Ketentuan yang harus dilaksanakan.
- **DILARANG:** Tindakan yang tidak boleh dilakukan.
- **SEBAIKNYA:** Rekomendasi yang dapat diterapkan jika sesuai dengan kondisi.
- **OPSIONAL:** Ketentuan yang boleh diterapkan tetapi tidak wajib.
- **PENGECUALIAN:** Kondisi khusus yang mengubah penerapan aturan tertentu.

Jangan menggunakan istilah rekomendasi seolah-olah merupakan kewajiban.

## 12. SINKRONISASI SKILL DAN EXAMPLES

`SKILL.md` dan `examples/` merupakan satu kesatuan dokumentasi.

Perubahan pada salah satunya wajib diikuti pemeriksaan terhadap bagian lainnya.

### 12.1. Ketika memperbarui SKILL.md

AI WAJIB:

1. Memeriksa apakah perubahan memengaruhi input contoh.
2. Memeriksa apakah perubahan memengaruhi output contoh.
3. Memperbarui pasangan contoh yang sudah tidak sesuai.
4. Menambahkan contoh baru jika perubahan menghasilkan skenario baru yang perlu dijelaskan.
5. Menghapus contoh yang sudah tidak relevan hanya jika memang diperlukan.
6. Memastikan seluruh contoh tetap memiliki pasangan.
7. Memastikan rujukan commit tetap benar.
8. Memastikan nomor versi dan `commit-terakhir` sesuai dengan kondisi terbaru.

### 12.2. Ketika memperbarui examples

AI WAJIB:

1. Memeriksa apakah contoh masih sesuai dengan aturan `SKILL.md`.
2. Memastikan input dan output menggambarkan perilaku yang diperintahkan skill.
3. Memperbarui `SKILL.md` apabila contoh menunjukkan adanya aturan yang belum terdokumentasi.
4. Memastikan tidak ada contoh yang bertentangan dengan instruksi utama.
5. Memastikan rujukan commit benar dan dapat diverifikasi.

### 12.3. Konsistensi keseluruhan

Setelah perubahan, pastikan:

- Frontmatter valid.
- Nama skill sesuai nama folder.
- Kategori sesuai nama folder kategori.
- Struktur direktori sesuai aturan.
- Contoh memiliki pasangan.
- Referensi commit benar.
- Tidak ada aturan yang saling bertentangan.
- Tidak ada instruksi yang kehilangan konteks.
- Seluruh dokumentasi menggunakan istilah yang konsisten.

## 13. PENANGANAN SKILL LAMA YANG MELANGGAR ATURAN

Jika AI menemukan skill lama yang tidak sesuai dengan aturan ini, AI WAJIB melakukan pemeriksaan terlebih dahulu.

Contoh pelanggaran:

- Nama folder tidak sesuai.
- Tidak memiliki frontmatter.
- Tidak memiliki folder `examples/`.
- Contoh tidak memiliki pasangan.
- Referensi commit tidak tersedia atau tidak valid.
- Isi skill bertentangan dengan implementasi pada commit.
- Skill memiliki cakupan yang tumpang tindih dengan skill lain.
- Struktur direktori tidak sesuai.

Ketentuan penanganan:

1. Identifikasi seluruh pelanggaran.
2. Jelaskan path file yang bermasalah.
3. Jelaskan ketentuan yang dilanggar.
4. Jelaskan dampak terhadap penggunaan skill.
5. Usulkan perbaikan yang diperlukan.
6. Identifikasi file lain yang terdampak.
7. Jangan langsung melakukan rename, pemindahan folder, penghapusan, atau restrukturisasi secara diam-diam.
8. Jangan menganggap pelanggaran sebagai izin untuk mengubah struktur tanpa pemberitahuan.

Jika perbaikan memerlukan perubahan struktur atau keputusan yang dapat memengaruhi referensi skill lain, laporkan dan minta persetujuan pengguna terlebih dahulu.

## 14. LARANGAN UMUM

AI DILARANG:

1. Membuat skill tanpa memeriksa apakah skill sejenis sudah tersedia.
2. Membuat skill duplikat tanpa alasan yang jelas.
3. Menggunakan working directory sebagai sumber pola implementasi.
4. Menggunakan perubahan staging sebagai sumber.
5. Menggunakan file untracked sebagai sumber.
6. Mengarang riwayat commit.
7. Mengarang hash commit.
8. Mengarang path file rujukan.
9. Mengklaim rancangan AI sebagai implementasi nyata pengguna.
10. Mengubah tujuan skill tanpa alasan yang dapat dipertanggungjawabkan.
11. Menambahkan aturan yang tidak berkaitan dengan cakupan skill.
12. Mengubah nama atau struktur skill lama tanpa pemeriksaan dampak.
13. Menghapus contoh yang masih relevan tanpa alasan.
14. Membiarkan pasangan input dan output tidak lengkap.
15. Membiarkan `SKILL.md` dan `examples/` saling bertentangan.
16. Mengabaikan pelanggaran yang ditemukan.
17. Menyatakan pekerjaan sudah sesuai sebelum melakukan pemeriksaan.

## 15. PROSEDUR KERJA WAJIB

Setiap pekerjaan pembuatan atau pembaruan skill harus mengikuti urutan berikut.

### Tahap 1 — Identifikasi

1. Tentukan apakah pekerjaan merupakan pembuatan, pembaruan, evaluasi, atau restrukturisasi skill.
2. Identifikasi nama dan kategori skill.
3. Tentukan cakupan dan tujuan skill.
4. Periksa apakah skill sejenis sudah tersedia.
5. Periksa aturan repositori yang berkaitan.

### Tahap 2 — Pemeriksaan struktur

1. Periksa direktori `.agents/skills/`.
2. Identifikasi skill yang berkaitan.
3. Periksa `SKILL.md`.
4. Periksa folder `examples/`.
5. Periksa folder `references/` jika tersedia.
6. Identifikasi duplikasi dan ketidaksesuaian struktur.

### Tahap 3 — Penelusuran commit

1. Tentukan file dan folder yang berkaitan dengan topik.
2. Telusuri riwayat menggunakan Git.
3. Identifikasi commit yang relevan.
4. Periksa isi perubahan pada commit.
5. Tentukan pola yang benar-benar digunakan.
6. Pilih commit terbaru yang relevan jika terdapat perbedaan pola.
7. Jika tidak ada commit, ikuti ketentuan pembuatan rancangan baru.

### Tahap 4 — Penyusunan

1. Susun frontmatter.
2. Susun isi `SKILL.md`.
3. Buat folder `examples/`.
4. Buat minimal satu pasangan file input dan output.
5. Tambahkan hash commit jika tersedia.
6. Tambahkan keterangan belum memiliki commit rujukan jika tidak tersedia.
7. Buat `references/` hanya jika diperlukan.
8. Pastikan skill dapat digunakan lintas proyek.

### Tahap 5 — Sinkronisasi

1. Periksa hubungan antara `SKILL.md` dan examples.
2. Periksa konsistensi setiap contoh.
3. Periksa kesesuaian sumber commit.
4. Periksa seluruh nama file dan folder.
5. Periksa frontmatter dan versi.

### Tahap 6 — Validasi akhir

Sebelum menyatakan pekerjaan selesai, pastikan seluruh ketentuan wajib sudah terpenuhi.

Jika terdapat ketentuan yang belum dapat dipenuhi, jangan menyatakan bahwa pekerjaan sudah sepenuhnya sesuai.

Laporkan secara spesifik bagian yang belum terpenuhi beserta alasannya.

## 16. FORMAT LAPORAN HASIL

Setelah pekerjaan selesai, berikan laporan dengan susunan berikut:

### A. Ringkasan pekerjaan

Jelaskan skill yang dibuat atau diperbarui dan tujuan perubahannya.

### B. File yang dibuat atau diperbarui

Cantumkan path lengkap setiap file.

Contoh:

```text
.agents/skills/custom/pola-ux/SKILL.md
.agents/skills/custom/pola-ux/examples/input-konfirmasi-hapus.md
.agents/skills/custom/pola-ux/examples/output-konfirmasi-hapus.md
```

### C. Sumber commit

Cantumkan:

- Hash commit.
- Pesan commit jika tersedia.
- File yang dijadikan rujukan.
- Pola implementasi yang ditemukan.

Jika tidak ada commit, nyatakan bahwa skill merupakan rancangan baru AI.

### D. Validasi

Laporkan hasil pemeriksaan:

- Frontmatter.
- Struktur direktori.
- Penamaan.
- Kelengkapan examples.
- Rujukan commit.
- Konsistensi dokumentasi.
- Kesesuaian lintas proyek.

### E. Temuan dan rekomendasi

Pisahkan temuan yang wajib diperbaiki dari rekomendasi tambahan.

Jangan menyembunyikan pelanggaran atau keterbatasan yang ditemukan.

---

## 17. KETENTUAN PENUTUP

Aturan ini merupakan standar utama untuk pembuatan dan pembaruan seluruh skill pengguna.

Jika terdapat instruksi lain yang berkaitan dengan penyusunan skill:

1. Pertahankan tujuan dan maksud instruksi tersebut selama tidak bertentangan dengan aturan ini.
2. Identifikasi konflik sebelum mengambil keputusan.
3. Jangan mengabaikan konflik secara diam-diam.
4. Jangan membuat asumsi untuk menyelesaikan konflik yang memerlukan keputusan pengguna.
5. Laporkan konflik dan usulkan penyelesaian yang paling sedikit mengubah maksud aturan.

**Prioritas utama adalah menghasilkan skill yang akurat, konsisten, dapat diverifikasi, dan dapat digunakan kembali pada berbagai proyek Flutter pengguna.**