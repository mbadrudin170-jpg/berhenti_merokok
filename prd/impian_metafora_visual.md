# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Draft

**Status Implementasi:** Belum Diimplementasikan

---

## 1. Informasi Produk

**Konteks penggunaan:**
Digunakan untuk mengidentifikasi produk dan memberikan gambaran umum proyek. Informasi ini menjadi identitas utama PRD.

**Aturan pengisian:**
- Isi informasi berdasarkan kondisi dan identitas proyek yang sebenarnya.
- Gunakan nama produk yang konsisten dengan proyek.
- Tuliskan platform dan versi yang menjadi target pengembangan.
- Bedakan status dokumen dengan status implementasi.
- Jangan mengarang informasi yang belum diketahui.

**Informasi:**
- Nama aplikasi: berhenti_merokok
- Deskripsi produk: Aplikasi Flutter untuk membantu pengguna berhenti merokok dengan pelacakan progres smoke-free, statistik penghematan, dan fitur impian/tabungan dengan metafora visual.
- Platform: Android (Flutter SDK ^3.13.7)
- Versi: draft
- Status pengembangan: Belum Diimplementasikan

---

## 2. Latar Belakang

**Konteks penggunaan:**
Digunakan untuk menjelaskan alasan produk dibuat. Tuliskan masalah nyata, kebutuhan pengguna, atau kendala yang ingin diselesaikan.

**Aturan pengisian:**
- Jelaskan kondisi atau permasalahan yang melatarbelakangi pengembangan.
- Hubungkan permasalahan dengan kebutuhan produk.
- Hindari penjelasan yang tidak berhubungan dengan produk.
- Bedakan fakta, asumsi, dan kebutuhan yang belum terverifikasi.
- Jangan langsung menjelaskan solusi teknis sebelum masalahnya jelas.

**Isi:**
Pengguna aplikasi berhenti merokok telah menghemat uang dari tidak membeli rokok, tetapi angka penghematan yang ditampilkan masih dalam bentuk numerik abstrak. Menurut analisis kompetitor di `refrensi_apk.md` Section C7, aplikasi serupa (Quitchi, RootedLife, PuffGone, Stosmok, ZenQuit) menggunakan objek visual yang tumbuh mengikuti progres untuk membuat tujuan abstrak terasa konkret. Tanpa metafora visual, pengguna sulit merasakan dampak nyata dari uang yang dihemat terhadap impian pribadi mereka.

---

## 3. Tujuan Produk

**Konteks penggunaan:**
Digunakan untuk menentukan hasil yang ingin dicapai. Tujuan harus berhubungan langsung dengan masalah pada bagian latar belakang.

**Aturan pengisian:**
- Tuliskan hasil yang diharapkan dari produk.
- Pastikan setiap tujuan memiliki hubungan dengan masalah yang ingin diselesaikan.
- Gunakan tujuan yang jelas dan dapat dievaluasi.
- Jangan memasukkan tujuan yang berada di luar ruang lingkup produk.

**Isi:**
1. Membuat target tabungan/impian terasa konkret melalui objek visual yang tumbuh mengikuti progres.
2. Memberikan opsi tema visual agar pengguna dapat memilih metafora yang paling memotivasi mereka.
3. Mempertahankan progress bar sebagai indikator utama tanpa mengganti data dengan dekorasi.
4. Memastikan transparansi dengan label "estimasi" pada nilai yang merupakan perhitungan turunan.

---

## 4. Target Pengguna

**Konteks penggunaan:**
Digunakan untuk menentukan siapa yang akan menggunakan produk. Informasi ini menjadi dasar dalam menentukan fitur, bahasa, navigasi, hak akses, dan pengalaman pengguna.

**Aturan pengisian:**
- Identifikasi kelompok pengguna yang benar-benar menjadi sasaran produk.
- Jelaskan kebutuhan dan tujuan masing-masing kelompok.
- Cantumkan karakteristik pengguna hanya jika berpengaruh terhadap desain atau fungsi produk.
- Jangan membuat jenis pengguna yang tidak memiliki kebutuhan atau fungsi jelas.

**Isi:**
| Kelompok Pengguna | Kebutuhan | Tujuan |
|---|---|---|
| Pengguna aplikasi berhenti merokok | Menabung uang hasil penghematan rokok untuk impian pribadi | Melihat progres tabungan secara visual dan terstruktur |
| Pengguna yang suka visualisasi | Memerlukan metafora visual untuk memahami progres abstrak | Memilih tema visual yang memotivasi (mis. toples, pohon, piggy bank) |

---

## 5. Ruang Lingkup

**Konteks penggunaan:**
Digunakan untuk membatasi pekerjaan agar pengembangan tidak melebar dan mencegah penambahan fitur di luar kebutuhan.

**Aturan pengisian:**
- Cantumkan kebutuhan dan fitur yang termasuk dalam pengembangan.
- Cantumkan fitur atau kemampuan yang secara sengaja tidak dikerjakan.
- Pastikan batasan sesuai tujuan produk.
- Jangan mencantumkan fitur yang saling bertentangan antara kedua kategori.
- Perbarui ruang lingkup jika terjadi perubahan keputusan produk.

### Termasuk
- Kartu impian dengan objek visual kecil di sisi progres
- Opsi tema visual minimal 2 (mis. "Toples", "Pohon") yang dapat dipilih pengguna
- Progress bar pada kartu impian
- Label "estimasi" pada nilai turunan (saldo aktual, estimasi target)
- Layar detail impian terpisah dari kartu ringkasan

### Tidak Termasuk
- Menggantikan data aktual dengan dekorasi visual
- Fitur sosial atau berbagi tabungan ke komunitas
- Integrasi pembayaran atau dompet digital eksternal
- Tema visual lebih dari 2 opsi di versi awal

---

## 6. Daftar Fitur

**Konteks penggunaan:**
Digunakan untuk melihat keseluruhan fitur produk dan menentukan tingkat kepentingannya.

**Aturan pengisian:**
- Setiap fitur harus memiliki nama dan deskripsi yang jelas.
- Satu baris mewakili satu fitur yang dapat diidentifikasi secara terpisah.
- Hindari menggabungkan beberapa fitur berbeda dalam satu baris.
- Pastikan fitur mendukung tujuan produk dan masuk dalam ruang lingkup.
- Gunakan prioritas berdasarkan kepentingan kebutuhan produk.
- Detail perilaku fitur dijelaskan pada bagian 7.

| Fitur | Deskripsi | Prioritas |
|---|---|---|
| Kartu impian dengan objek visual | Menampilkan kartu impian dengan objek visual kecil yang tumbuh mengikuti progres tabungan | Must Have |
| Opsi tema visual | Pengguna dapat memilih tema visual (mis. "Toples" atau "Pohon") untuk metafora impian | Should Have |
| Progress bar pada kartu impian | Menampilkan progress bar sebagai indikator utama pencapaian target impian | Must Have |
| Label estimasi | Memberi label "estimasi" pada nilai turunan seperti saldo aktual dan estimasi target | Must Have |
| Layar detail impian | Layar terpisah untuk detail impian, termasuk riwayat tabungan dan pengaturan tema | Should Have |

---

## 7. Detail Persyaratan Fitur

**Konteks penggunaan:**
Digunakan ketika suatu fitur membutuhkan penjelasan lebih terperinci. Bagian ini menjadi acuan utama implementasi dan pengujian agar developer tidak perlu menebak perilaku yang diinginkan.

**Aturan pengisian:**
- Buat penjelasan terpisah untuk setiap fitur.
- Jelaskan perilaku yang diharapkan, bukan sekadar nama atau gambaran umum fitur.
- Tuliskan proses secara berurutan dan logis.
- Jelaskan aturan bisnis serta kondisi yang memengaruhi hasil proses.
- Cantumkan validasi untuk setiap data masukan yang relevan.
- Jelaskan kondisi berhasil dan gagal beserta respons sistem.
- Buat kriteria penerimaan yang dapat diperiksa atau diuji.
- Jangan menetapkan perilaku yang bertentangan dengan tujuan produk atau aturan bisnis.

**Informasi setiap fitur:**

### Fitur 1: Kartu impian dengan objek visual

- **Nama fitur:** Kartu impian dengan objek visual
- **Tujuan:** Membuat target tabungan terasa konkret melalui representasi visual
- **Deskripsi:** Kartu impian menampilkan objek visual kecil di sisi progres tabungan. Objek tumbuh seiring dengan peningkatan saldo tabungan dari uang rokok yang dihemat.
- **Data masukan:** Target impian (nominal), saldo terkumpul saat ini, tema visual yang dipilih
- **Proses:**
  1. Hitung rasio progres = saldo terkumpul / target impian
  2. Clamp rasio progres ke rentang 0–1
  3. Render objek visual sesuai tema yang dipilih dengan ukuran proporsi rasio progres
  4. Tampilkan progress bar di bawah objek visual
- **Aturan bisnis:**
  - Objek visual tidak boleh menggantikan data numerik aktual
  - Label "estimasi" harus ditampilkan pada nilai turunan
  - Progress bar harus selalu tersedia sebagai indikator utama
- **Validasi:** Target impian harus > 0; saldo terkumpul tidak boleh negatif
- **Kondisi berhasil:** Objek visual ditampilkan dengan proporsi yang sesuai terhadap saldo terkumpul
- **Kondisi gagal:** Jika target impian = 0 atau null, tampilkan placeholder kosong dengan pesan "Atur target impian terlebih dahulu"
- **Respons sistem:** Kartu impian dirender dengan objek visual dan progress bar
- **Kriteria penerimaan:** Objek visual skalakan proporsional terhadap rasio progres 0–1; progress bar selalu terlihat; label estimasi muncul pada nilai turunan

### Fitur 2: Opsi tema visual

- **Nama fitur:** Opsi tema visual
- **Tujuan:** Memungkinkan pengguna memilih metafora visual yang paling memotivasi
- **Deskripsi:** Pengguna dapat memilih antara minimal 2 opsi tema visual (mis. "Toples" dan "Pohon") untuk metafora impian di kartu dan layar detail.
- **Data masukan:** Pilihan tema visual dari dropdown/pilihan radio
- **Proses:**
  1. Simpan preferensi tema visual ke lokal penyimpanan
  2. Render objek visual sesuai tema yang dipilih pada kartu impian dan layar detail
- **Aturan bisnis:**
  - Minimal 2 opsi tema tersedia di versi awal
  - Perubahan tema langsung diterapkan tanpa restart aplikasi
  - Tema tidak mengubah data numerik atau perhitungan
- **Validasi:** Pilihan tema harus salah satu dari opsi yang tersedia
- **Kondisi berhasil:** Objek visual berubah sesuai tema yang dipilih
- **Kondisi gagal:** Jika tema tidak valid, gunakan tema default pertama
- **Respons sistem:** UI diperbarui dengan objek visual dari tema baru
- **Kriteria penerimaan:** Pengguna dapat beralih antara minimal 2 tema; render objek sesuai tema; tidak ada perubahan pada data numerik

### Fitur 3: Progress bar pada kartu impian

- **Nama fitur:** Progress bar pada kartu impian
- **Tujuan:** Memberikan indikator utama pencapaian target impian
- **Deskripsi:** Progress bar ditampilkan pada kartu impian sebagai indikator utama, tidak hanya hiasan sekunder.
- **Data masukan:** Saldo terkumpul, target impian
- **Proses:**
  1. Hitung persentase = (saldo terkumpul / target impian) × 100
  2. Clamp ke 0–100%
  3. Render progress bar dengan persentase yang dihitung
- **Aturan bisnis:**
  - Progress bar harus selalu tersedia sebagai indikator utama
  - Progress bar tidak boleh hilang saat objek visual ditampilkan
- **Validasi:** Target impian > 0 untuk menghindari pembagian nol
- **Kondisi berhasil:** Progress bar menampilkan persentase progres yang akurat
- **Kondisi gagal:** Jika target impian = 0, progress bar ditampilkan 0% dengan pesan pengaturan target
- **Respons sistem:** Progress bar diperbarui setiap kali saldo terkumpul berubah
- **Kriteria penerimaan:** Progress bar akurat terhadap perhitungan (saldo/target); selalu terlihat pada kartu impian

### Fitur 4: Label estimasi

- **Nama fitur:** Label estimasi
- **Tujuan:** Memberi transparansi pada nilai turunan yang merupakan perhitungan
- **Deskripsi:** Setiap nilai yang merupakan estimasi (mis. saldo aktual sebagai fallback dari estimasi baseline) diberi label "estimasi" agar pengguna tidak salah paham.
- **Data masukan:** Nilai numerik yang merupakan hasil perhitungan turunan
- **Proses:**
  1. Deteksi apakah nilai adalah estimasi atau aktual
  2. Tambahkan label "estimasi" di samping nilai yang merupakan estimasi
- **Aturan bisnis:**
  - Nilai aktual tidak diberi label estimasi
  - Nilai turunan dari estimasi baseline harus diberi label estimasi
- **Validasi:** Tidak ada validasi khusus, hanya deteksi tipe nilai
- **Kondisi berhasil:** Label estimasi muncul hanya pada nilai yang merupakan estimasi
- **Kondisi gagal:** Tidak ada kondisi gagal untuk fitur ini
- **Respons sistem:** Teks ditampilkan dengan label estimasi di samping nilai
- **Kriteria penerimaan:** Label estimasi benar muncul pada nilai estimasi dan tidak pada nilai aktual

### Fitur 5: Layar detail impian

- **Nama fitur:** Layar detail impian
- **Tujuan:** Menyediakan detail lengkap impian terpisah dari kartu ringkasan
- **Deskripsi:** Layar terpisah untuk detail impian, termasuk riwayat tabungan, pengaturan tema visual, dan informasi target.
- **Data masukan:** Data impian (target, saldo, tema, riwayat)
- **Proses:**
  1. Ambil data impian dari penyimpanan lokal
  2. Tampilkan detail impian termasuk objek visual, progress bar, dan riwayat tabungan
  3. Sediakan opsi untuk mengubah tema visual dan target impian
- **Aturan bisnis:**
  - Layar detail terpisah dari kartu ringkasan pada dashboard
  - Perubahan pada layar detail langsung mempengaruhi kartu impian
- **Validasi:** Data impian harus dapat dimuat dari penyimpanan lokal
- **Kondisi berhasil:** Layar detail menampilkan semua informasi impian dengan benar
- **Kondisi gagal:** Jika data impian kosong, tampilkan layar kosong dengan opsi buat impian baru
- **Respons sistem:** Layar detail impian dirender dengan semua informasi terkait
- **Kriteria penerimaan:** Layar detail dapat diakses dari kartu impian; menampilkan objek visual, progress bar, riwayat; opsi ubah tema berfungsi

---

## 8. Alur Pengguna

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

**Alur Utama: Menetapkan Impian dan Melihat Progres Visual**

1. Pengguna membuka aplikasi berhenti merokok dan melihat dashboard dengan kartu impian.
2. Jika belum ada impian, penguana mengetuk tombol "Buat Impian" pada kartu kosong.
3. Pengguna memasukkan nama impian dan nominal target tabungan.
4. Pengguna memilih tema visual (mis. "Toples" atau "Pohon").
5. Sistem menyimpan impian dan menampilkan kartu impian dengan objek visual dan progress bar.
6. Setiap kali pengguna berhenti merokok (uang dihemat bertambah), saldo terkumpul bertambah dan objek visual tumbuh proporsional.
7. Pengguna dapat mengetuk kartu impian untuk membuka layar detail impian.
8. Pada layar detail, pengguna dapat mengubah tema visual atau nominal target.

**Percabangan: Pengguna Belum Menetapkan Target Impian**

- Kondisi: Pengguna membuka dashboard tanpa impian yang disetel.
- Respons: Kartu impian menampilkan placeholder dengan pesan "Atur target impian terlebih dahulu" dan tombol "Buat Impian".

**Kondisi Akhir:** Pengguna dapat melihat progres tabungan secara visual melalui objek visual dan progress bar pada kartu impian.

---

## 9. Persyaratan UI/UX

**Konteks penggunaan:**
Digunakan untuk menjelaskan kebutuhan tampilan dan interaksi yang berpengaruh terhadap kemudahan penggunaan.

**Aturan pengisian:**
- Cantumkan kebutuhan tampilan dan interaksi yang berkaitan dengan fitur.
- Jelaskan navigasi dan komponen yang diperlukan.
- Jelaskan informasi yang harus ditampilkan kepada pengguna.
- Cantumkan kondisi tampilan seperti loading, kosong, berhasil, dan gagal jika relevan.
- Utamakan kemudahan penggunaan dan kejelasan fungsi.
- Jangan mengulang seluruh standar desain yang sudah tersedia di dokumen desain proyek.
- Detail standar desain mengikuti dokumen desain proyek yang berlaku.

**Isi:**

**Navigasi:**
- Kartu impian pada dashboard dapat ditekan untuk membuka layar detail impian.
- Tombol "Buat Impian" pada kartu kosong membuka form pembuatan impian.

**Komponen:**
- Kartu impian: berisi nama impian, objek visual, progress bar, saldo terkumpul, dan target.
- Objek visual: ilustrasi kecil (toples/pohon) yang skalakan sesuai progres.
- Progress bar: indikator linear di bawah objek visual.
- Label estimasi: teks kecil di samping nilai yang merupakan estimasi.

**Informasi yang harus ditampilkan:**
- Nama impian
- Nominal target tabungan
- Saldo terkumpul saat ini
- Persentase progres (progress bar)
- Objek visual sesuai tema yang dipilih
- Label "estimasi" pada nilai turunan

**Kondisi tampilan:**
- **Loading:** Skeleton loader pada kartu impian saat data dimuat.
- **Kosong:** Placeholder dengan pesan "Atur target impian terlebih dahulu" dan tombol "Buat Impian".
- **Berhasil:** Objek visual dan progress bar ditampilkan dengan proporsi yang sesuai.
- **Gagal:** Pesan error singkat dengan opsi coba lagi.

**Interaksi:**
- Menekap kartu impian → buka layar detail.
- Mengubah tema visual → render ulang objek visual segera.
- Mengubah nominal target → progress bar dan objek visual disesuaikan.

---

## 10. Ringkasan Kode Contoh Singkat

**Konteks penggunaan:**
Digunakan apabila contoh kode dapat membantu menjelaskan aturan bisnis, logika, validasi, atau perilaku fitur yang sulit dijelaskan hanya dengan deskripsi.

**Aturan pengisian:**
- Cantumkan kode hanya jika benar-benar membantu memahami persyaratan produk.
- Pilih contoh yang singkat dan langsung berkaitan dengan fitur.
- Gunakan bahasa pemrograman yang sesuai dengan proyek.
- Pastikan contoh kode menggambarkan aturan yang sudah dijelaskan pada PRD.
- Sertakan penjelasan mengenai fungsi kode.
- Jangan memasukkan implementasi lengkap atau detail arsitektur teknis.
- Jangan menjadikan contoh kode sebagai kewajiban implementasi apabila tidak diperlukan.
- Jika tidak ada kode yang relevan, bagian ini boleh dikosongkan.

**Informasi:**
- Nama fitur: Perhitungan rasio progres impian
- Bahasa pemrograman: Dart
- Tujuan kode: Menghitung rasio progres yang di-clamp ke 0–1 untuk rendering objek visual

**Contoh kode:**

```dart
double hitungRasioProgres(double saldoTerkumpul, double targetImpian) {
  if (targetImpian <= 0) return 0.0;
  final rasio = saldoTerkumpul / targetImpian;
  return rasio.clamp(0.0, 1.0);
}
```

**Penjelasan:**

Kode tersebut menghitung rasio progres antara saldo terkumpul dan target impian, dengan clamp ke rentang 0–1 agar aman untuk rendering objek visual. Guard pembagian nol diterapkan saat target impian = 0.

**Catatan:** Kode hanya sebagai ilustrasi, bukan ketentuan implementasi atau kode produksi.

---

## 11. Hak Akses Pengguna

**Konteks penggunaan:**
Digunakan apabila aplikasi memiliki beberapa jenis pengguna atau pembatasan akses.

**Aturan pengisian:**
- Identifikasi setiap jenis pengguna yang memiliki hak akses berbeda.
- Jelaskan tindakan yang boleh dilakukan masing-masing pengguna.
- Jelaskan tindakan yang dibatasi atau tidak diperbolehkan.
- Pastikan hak akses konsisten dengan kebutuhan dan aturan bisnis.
- Jangan memberikan hak akses yang tidak diperlukan.
- Jika aplikasi hanya memiliki satu jenis pengguna tanpa pembatasan khusus, jelaskan kondisi tersebut.

| Jenis Pengguna | Hak Akses | Batasan |
|---|---|---|
| Pengguna aplikasi (satuan) | Membuat, mengubah, dan menghapus impian; memilih tema visual; melihat progres tabungan | Tidak dapat mengakses data pengguna lain; tidak ada fitur sosial atau sharing |

---

## 12. Persyaratan Data

**Konteks penggunaan:**
Digunakan untuk menjelaskan kebutuhan data yang berkaitan dengan fitur dan proses bisnis.

**Aturan pengisian:**
- Identifikasi data yang diperlukan oleh setiap proses.
- Jelaskan tujuan penggunaan masing-masing data.
- Cantumkan hubungan antar-data jika ada.
- Jelaskan aturan penyimpanan dan perubahan data.
- Jelaskan validasi serta integritas data.
- Cantumkan kebutuhan sinkronisasi jika aplikasi menggunakan lebih dari satu sumber penyimpanan.
- Bedakan kebutuhan data produk dari keputusan implementasi database.
- Jangan menetapkan data yang tidak memiliki kegunaan jelas.

**Informasi yang perlu dijelaskan:**

- **Jenis data yang digunakan:**
  - Data impian: nama impian, nominal target, saldo terkumpul, tema visual, tanggal dibuat, tanggal diperbarui
  - Riwayat tabungan: tanggal, jumlah yang ditambahkan, saldo setelah transaksi

- **Data yang harus disimpan:**
  - Entri impian tunggal per pengguna (satu target impian pada satu waktu)
  - Riwayat transaksi tabungan (setiap kali uang rokok dihemat ditambahkan ke saldo)

- **Hubungan antar-data:**
  - Satu entri impian memiliki banyak riwayat transaksi tabungan (one-to-many)
  - Saldo terkumpul adalah agregasi dari semua transaksi tabungan

- **Aturan tambah, baca, ubah, dan hapus data:**
  - Tambah: Buat entri impian dengan target dan tema visual default
  - Baca: Ambil data impian dan riwayat transaksi untuk ditampilkan pada kartu dan layar detail
  - Ubah: Update nominal target, tema visual, atau nama impian
  - Hapus: Hapus entri impian beserta semua riwayat transaksi terkait (operasi destruktif, perlu konfirmasi)

- **Validasi dan integritas data:**
  - Nominal target harus > 0
  - Saldo terkumpul tidak boleh negatif
  - Tema visual harus salah satu dari opsi yang tersedia
  - Setiap transaksi tabungan harus mencatat tanggal dan jumlah

- **Kebutuhan sinkronisasi data:**
  - Data disimpan lokal (offline-first); tidak ada sinkronisasi cloud di versi awal

---

## 13. Persyaratan Nonfungsional

**Konteks penggunaan:**
Digunakan untuk menetapkan standar kualitas dan batasan operasional produk yang tidak secara langsung menjelaskan fungsi fitur.

**Aturan pengisian:**
- Cantumkan persyaratan yang benar-benar relevan dengan produk.
- Gunakan ukuran atau kondisi yang dapat diuji jika memungkinkan.
- Jelaskan kondisi yang harus dipenuhi aplikasi.
- Bedakan kebutuhan wajib dengan kebutuhan tambahan.
- Jangan membuat target angka tanpa dasar atau kebutuhan yang jelas.
- Hindari mengulang persyaratan fungsional pada bagian ini.

**Aspek yang perlu dipertimbangkan:**

- **Performa:** Render objek visual dan progress bar tidak boleh menyebabkan jank pada layar dashboard.
- **Keamanan:** Data impian disimpan lokal tanpa enkripsi tambahan (data tidak sensitif).
- **Privasi:** Data impian tidak dikirim ke server eksternal; offline-first.
- **Keandalan:** Aplikasi harus tetap menampilkan data impian terakhir yang disimpan meskipun offline.
- **Kompatibilitas:** Kompatibel dengan Android SDK ^3.13.7, Material3, dan ukuran layar bervariasi.
- **Skalabilitas:** Mendukung satu entri impian per pengguna; tidak perlu skalabilitas multi-impian di versi awal.
- **Kemudahan pemeliharaan:** Kode rendering objek visual terpisah dari logika perhitungan progres.

---

## 14. Kriteria Penerimaan

**Konteks penggunaan:**
Digunakan sebagai dasar untuk menentukan apakah fitur sudah memenuhi persyaratan dan dapat dinyatakan selesai.

**Aturan pengisian:**
- Buat kriteria berdasarkan persyaratan fitur.
- Setiap kriteria harus jelas dan dapat diverifikasi.
- Gunakan kondisi yang menghasilkan keputusan lulus atau tidak lulus.
- Sertakan kondisi normal maupun kondisi gagal yang penting.
- Jangan menggunakan kriteria subjektif seperti "berjalan dengan baik" tanpa penjelasan.
- Jangan menyatakan fitur selesai hanya karena tampilannya sudah tersedia.
- Pastikan seluruh kriteria wajib terpenuhi sebelum fitur diterima.

**Isi:**

| Kriteria | Kondisi Lulus | Kondisi Tidak Lulus |
|---|---|---|
| Kartu impian ditampilkan pada dashboard | Kartu impian muncul dengan nama, objek visual, progress bar, dan saldo | Kartu impian tidak muncul atau komponen utama hilang |
| Objek visual skalakan proporsional | Ukuran objek visual proporsional terhadap rasio progres 0–1 | Objek visual tidak berubah atau skalakan tidak proporsional |
| Progress bar akurat | Progress bar menampilkan persentase (saldo/target) × 100 | Progress bar menunjukkan persentase yang salah |
| Opsi tema visual minimal 2 | Pengguna dapat beralih antara ≥2 tema dan render berubah | Hanya 1 tema tersedia atau render tidak berubah saat ganti tema |
| Label estimasi pada nilai turunan | Label "estimasi" muncul pada nilai yang merupakan estimasi | Label estimasi muncul pada nilai aktual atau hilang pada estimasi |
| Guard pembagian nol | Saat target = 0, progress bar = 0% dan placeholder ditampilkan | Aplikasi crash atau menampilkan Infinity/NaN |
| Layar detail impian dapat diakses | Menekap kartu impian buka layar detail dengan semua informasi | Layar detail tidak terbuka atau informasi tidak lengkap |

---

## 15. Prioritas Pengembangan

**Konteks penggunaan:**
Digunakan untuk menentukan tingkat kepentingan fitur ketika pengembangan dilakukan secara bertahap atau memiliki keterbatasan sumber daya.

**Aturan pengisian:**
- Tetapkan prioritas berdasarkan dampak terhadap tujuan utama produk.
- Pertimbangkan kebutuhan pengguna dan ketergantungan antarfitur.
- Jangan menentukan prioritas hanya berdasarkan kemudahan implementasi.
- Gunakan kategori secara konsisten.
- Fitur Won't Have tidak boleh dianggap sebagai bagian dari pengembangan versi saat ini.

**Kategori prioritas:**

| Fitur | Prioritas | Alasan |
|---|---|---|
| Kartu impian dengan objek visual | Must Have | Inti dari fitur metafora visual |
| Progress bar pada kartu impian | Must Have | Indikator utama pencapaian target |
| Label estimasi | Must Have | Transparansi nilai turunan |
| Opsi tema visual | Should Have | Pengalaman pengguna yang lebih baik, tidak mengubah inti fitur |
| Layar detail impian | Should Have | Akses ke detail lengkap, tidak blokir fungsi utama |

---

## 16. Risiko dan Ketergantungan

**Konteks penggunaan:**
Digunakan untuk mencatat hal-hal yang berpotensi menghambat pengembangan atau memengaruhi keberhasilan fitur.

**Aturan pengisian:**
- Cantumkan risiko yang memiliki dampak terhadap produk atau pengembangan.
- Jelaskan penyebab dan kemungkinan dampaknya.
- Identifikasi fitur, layanan, atau sumber daya yang menjadi ketergantungan.
- Tandai asumsi yang belum terverifikasi.
- Jelaskan cara mengurangi risiko jika sudah diketahui.
- Jangan memasukkan risiko yang tidak memiliki hubungan dengan proyek.

**Isi:**

| Risiko | Penyebab | Dampak | Mitigasi |
|---|---|---|---|
| Pengguna memilih tema visual yang tidak memotivasi | Opsi tema terbatas di versi awal | Pengurangan efektivitas metafora visual | Tambah opsi tema di versi mendatang berdasarkan feedback |
| Objek visual mengganggu pembacaan data | Objek terlalu besar atau ramai | Pengguna kesulitan membaca angka progres | Batasi ukuran objek visual; jangan ramai (sesuai Section C7) |
| Saldo terkumpul tidak sinkron dengan data konsumsi | Bug pada helper rumus bersama | Data impian tidak akurat | Verifikasi sinkronisasi dengan counter konsumsi aktual |
| Target impian = 0 menyebabkan pembagian nol | Input target tidak divalidasi | Aplikasi crash atau tampilkan NaN | Guard pembagian nol pada perhitungan rasio progres |

**Ketergantungan:**
- Helper rumus bersama untuk perhitungan saldo terkumpul (bergantung pada fitur konsumsi/penghematan)
- Sistem tema aplikasi (ColorScheme) untuk styling objek visual
- Penyimpanan lokal (SharedPreferences/Sqflite) untuk data impian

**Asumsi yang belum terverifikasi:**
- Pengguna menyukai metafora visual toples/pohon (belum divalidasi dengan user research)

---

## 17. Rencana Pengembangan

**Konteks penggunaan:**
Digunakan untuk membagi pengembangan menjadi beberapa tahap atau versi agar pekerjaan memiliki urutan dan target yang jelas.

**Aturan pengisian:**
- Kelompokkan fitur berdasarkan tahap pengembangan.
- Pertimbangkan prioritas dan ketergantungan antarfitur.
- Tentukan target yang realistis.
- Pastikan setiap tahap memiliki hasil yang dapat diperiksa.
- Jangan menetapkan jadwal atau target tanpa dasar yang jelas.
- Perbarui rencana jika terdapat perubahan ruang lingkup.

| Tahap | Fitur | Target |
|---|---|---|
| Tahap 1 | Kartu impian dengan objek visual, progress bar, label estimasi, guard pembagian nol | Fitur inti metafora visual dapat digunakan |
| Tahap 2 | Opsi tema visual (minimal 2 tema), layar detail impian | Pengalaman pengguna yang lebih baik |

---

## 18. Ketentuan Tambahan

**Konteks penggunaan:**
Digunakan untuk menampung keputusan atau persyaratan produk yang penting tetapi belum memiliki tempat khusus pada bagian sebelumnya.

**Aturan pengisian:**
- Masukkan hanya informasi yang belum tercakup pada bagian lain.
- Pastikan setiap ketentuan memiliki hubungan dengan produk.
- Gunakan penjelasan yang spesifik dan tidak ambigu.
- Jangan menggunakan bagian ini untuk menghindari pengisian bagian yang seharusnya.
- Hindari pengulangan informasi.

**Isi:**
- Objek visual tidak boleh menggantikan data numerik aktual (atasan Section C7: "jangan menggantikan data dengan dekorasi").
- Tema visual tidak boleh mengubah data atau perhitungan apapun.
- Semua nilai turunan harus diberi label "estimasi" untuk transparansi.
- Fitur ini memprioritaskan pendekatan offline-first sesuai filosofi proyek.

---

## 19. Riwayat Perubahan

**Konteks penggunaan:**
Digunakan untuk melacak perubahan isi PRD agar perubahan kebutuhan dan keputusan produk dapat diketahui.

**Aturan pengisian:**
- Catat setiap perubahan penting pada PRD.
- Gunakan tanggal perubahan yang sebenarnya.
- Jelaskan bagian yang berubah dan alasan perubahannya jika diketahui.
- Jangan menghapus riwayat perubahan sebelumnya.
- Perbarui catatan setiap kali ada revisi dokumen yang signifikan.

| Tanggal | Perubahan | Keterangan |
|---|---|---|
| 11 November 2026 | Pembuatan PRD awal | PRD dibuat berdasarkan Section C7 `refrensi_apk.md` (Impian/Tabungan dengan Metafora Visual Opposional) |

---

## 20. File-File Terdampak

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
|---|---|---|
| `lib/fitur/impian/widget/visual_tabungan_impian.dart` | Diubah | Implementasi piggy bank saat ini perlu diperluas untuk mendukung opsi tema visual dan objek visual lain |
| `lib/fitur/impian/` | Diubah | Tambah widget dan layar detail impian sesuai kebutuhan fitur |
| `lib/fitur/impian/model/` | Diubah | Tambah model data impian dan riwayat transaksi tabungan |
| `lib/fitur/impian/notifier/` | Diubah | Tambah notifier CRUD untuk data impian |

---

## 21. Referensi dari refrensi_apk.md

**Konteks penggunaan:**
Digunakan untuk memindahkan informasi relevan dari file `refrensi_apk.md` yang berada di root proyek ke dalam PRD. Tujuannya agar referensi yang berkaitan dengan kebutuhan produk terdokumentasi langsung di PRD tanpa membawa informasi yang tidak diperlukan.

**Aturan pengisian:**
- Baca seluruh isi `refrensi_apk.md` sebelum memilih referensi.
- Pindahkan hanya informasi yang memiliki hubungan langsung dengan kebutuhan produk.
- Pertahankan makna, konteks, dan detail penting dari referensi aslinya.
- Jangan sekadar mencantumkan nama atau lokasi referensi; pindahkan isi relevannya ke PRD.
- Jangan menyalin seluruh isi file sumber.
- Jangan mengarang atau menambahkan informasi yang tidak tersedia dalam referensi.
- Jangan mengubah referensi menjadi persyaratan wajib apabila sumbernya hanya memberikan inspirasi atau contoh.
- Bedakan antara referensi, keputusan produk, dan persyaratan yang sudah ditetapkan.
- Kelompokkan hasil pemindahan sesuai kategori di bawah.
- Jika tidak ada referensi yang relevan, biarkan kategori tersebut kosong.
- Jangan menghapus atau mengubah isi file sumber hanya karena kontennya sudah dipindahkan.

### 21.1 Referensi Fitur

**Konteks:** Menampung referensi mengenai fungsi, perilaku, dan gambaran fitur aplikasi.

**Aturan pengisian:**
- Pindahkan referensi fitur yang berkaitan dengan kebutuhan produk.
- Jelaskan bagian referensi yang dapat digunakan sebagai gambaran fitur.
- Jangan memasukkan fitur yang tidak direncanakan dalam ruang lingkup produk tanpa penjelasan.

- Aplikasi serupa: Quitchi (wishlist + tanaman virtual), RootedLife (hutan virtual tumbuh, toples piggy bank), PuffGone (virtual garden), Stosmok, ZenQuit, Quit Smoking Vaping & Nicotine (idle clicker), LungO (maskot katak)
- Pola UI: objek tumbuh mengikuti progres; wishlist; warna sejuk; tidak ramai
- Pola UX: tujuan abstrak terasa konkret; tetap transparan (label "estimasi")
- Pola layout: kartu impian + objek visual kecil; detail terpisah
- Saran: pertahankan progress bar; tambah opsi tema visual (mis. "Toples"/"Pohon"); jangan menggantikan data dengan dekorasi

### 21.2 Referensi UI/UX

**Konteks:** Menampung referensi mengenai tampilan, komponen antarmuka, navigasi, dan interaksi pengguna.

**Aturan pengisian:**
- Pindahkan referensi visual atau interaksi yang relevan.
- Pertahankan informasi mengenai fungsi dan tujuan elemen antarmuka.
- Jangan menganggap seluruh tampilan referensi harus disalin persis.
- Pastikan referensi tidak bertentangan dengan standar desain proyek.

- Objek visual kecil pada sisi progres (kartu impian + objek visual kecil)
- Warna sejuk untuk tema visual
- Tidak ramai (hindari terlalu banyak elemen dekorasi)
- Progress bar sebagai indikator utama

### 21.3 Referensi Alur Pengguna

**Konteks:** Menampung referensi mengenai proses dan tahapan interaksi pengguna.

**Aturan pengisian:**
- Pindahkan alur yang berkaitan dengan proses produk.
- Pertahankan urutan langkah dan hubungan antarproses.
- Jangan menambahkan tahapan yang tidak didukung oleh referensi.
- Sesuaikan penempatan hasilnya dengan kebutuhan alur pengguna pada bagian 8.

- Pengguna menetapkan impian → objek visual tumbuh mengikuti progres → lihat layar detail → ubah tema jika diperlukan

### 21.4 Referensi Lainnya

**Konteks:** Menampung informasi referensi lain yang relevan tetapi tidak termasuk kategori sebelumnya.

**Aturan pengisian:**
- Masukkan hanya informasi yang mendukung pemahaman atau kebutuhan produk.
- Jelaskan konteks dan kegunaan referensi.
- Jangan menjadikan bagian ini tempat menampung seluruh konten yang tidak terpilih.
- Pastikan tidak ada duplikasi informasi dengan kategori lain.

- Prioritas fitur: Rendah (berdasarkan Section C7 `refrensi_apk.md`)
- Referensi baris Section C7: baris 309–316 pada `refrensi_apk.md`