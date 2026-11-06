---
description: Investigasi akar penyebab kegagalan AI dalam menemukan ketidaksesuaian kode terhadap aturan, perbaiki aturan atau command yang terbukti bermasalah, lalu verifikasi efektivitas perbaikannya.
---

# ANALISIS DAN PERBAIKAN KEGAGALAN AI DALAM MENEMUKAN KETIDAKSESUAIAN KODE

## 1. Tujuan utama

Saya memiliki keluhan bahwa ketika AI diminta menganalisis kode berdasarkan aturan proyek, AI sering tidak menemukan pelanggaran, padahal masih banyak kode yang tidak sesuai dengan aturan yang telah ditetapkan.

Tugas Anda adalah menyelidiki mengapa hal tersebut terjadi dan memperbaiki penyebabnya agar kejadian serupa tidak terus berulang.

Jangan hanya mengulang analisis kode. Anda harus menyelidiki keseluruhan proses yang menyebabkan AI gagal menemukan ketidaksesuaian.

Investigasi harus menjawab pertanyaan berikut:

1. Apakah aturan yang saya buat sudah benar dan lengkap?
2. Apakah ada aturan yang ambigu, kurang tegas, sulit diterapkan, atau memiliki lebih dari satu penafsiran?
3. Apakah ada aturan yang saling bertentangan atau duplikat?
4. Apakah seluruh aturan benar-benar dimuat dan tersedia bagi AI ketika menjalankan analisis?
5. Apakah command analisis sudah memberikan instruksi yang cukup jelas dan sistematis?
6. Apakah AI telah membaca seluruh file yang menjadi cakupan pemeriksaan?
7. Apakah AI benar-benar mencocokkan kode dengan setiap aturan, atau hanya melakukan pemeriksaan secara umum?
8. Apakah ada keterbatasan konteks, izin, alat, konfigurasi, atau kemampuan model yang menyebabkan pemeriksaan tidak menyeluruh?
9. Bagaimana cara memperbaiki penyebab tersebut agar kualitas analisis berikutnya meningkat?

**Hasil akhir yang diharapkan:** akar penyebab ditemukan berdasarkan bukti, file aturan atau command yang bermasalah diperbaiki, dan efektivitas perbaikan diuji.

## 2. Batasan pekerjaan

Selama menjalankan command ini, patuhi batasan berikut:

1. Fokus pada investigasi sistem aturan dan proses kerja AI.
2. Jangan mengubah kode aplikasi di dalam `lib/`, `test/`, atau direktori sumber lainnya.
3. Jangan melakukan refactor aplikasi.
4. Jangan menambahkan aturan baru hanya untuk memperbanyak jumlah aturan.
5. Jangan menghapus aturan hanya karena terlihat panjang atau sulit dipahami.
6. Jangan mengubah tujuan dan maksud aturan yang sudah ada.
7. Jangan mengarang penyebab tanpa bukti.
8. Jangan menyimpulkan bahwa aturan sudah dimuat hanya karena file tersebut ditemukan di dalam proyek.
9. Jangan menyimpulkan bahwa analisis berhasil hanya karena AI tidak menemukan pelanggaran.
10. Jangan mengubah konfigurasi global Kilo tanpa alasan yang terbukti dan persetujuan pengguna.
11. Jangan membaca atau menampilkan isi `.env`, token, API key, password, private key, maupun kredensial lainnya.
12. Jika suatu pemeriksaan tidak dapat dilakukan karena keterbatasan izin atau alat, laporkan keterbatasannya. Jangan berpura-pura telah melakukan pemeriksaan.

Anda diperbolehkan memperbaiki file aturan dan command yang terbukti menjadi penyebab masalah, dengan tetap mengikuti mekanisme izin Kilo Code.

## 3. Tahap pertama — Inventarisasi sistem aturan

Sebelum menyimpulkan penyebab, petakan seluruh sumber instruksi yang relevan.

Periksa keberadaan dan hubungan antara:

- `AGENTS.md`
- `.agents/rules/`
- `.kilo/rules/`
- `.kilo/commands/`
- `.kilo/agents/` atau `.kilo/agent/`
- `kilo.jsonc`
- `.kilo/kilo.jsonc`
- Konfigurasi Kilo global yang relevan
- `scripts/build_rules_context.sh`
- File hasil pembentukan konteks aturan, jika ada.
- File dokumentasi dan instruksi proyek lainnya yang memang digunakan AI.

Periksa juga konfigurasi yang menentukan:

- File instruksi mana yang dimuat.
- Pola glob yang digunakan.
- Cakupan masing-masing aturan.
- Urutan dan prioritas instruksi.
- Aturan khusus untuk agent atau mode tertentu.
- Apakah ada aturan yang hanya aktif pada kondisi tertentu.
- Apakah terdapat file yang tidak dimuat meskipun tersimpan di proyek.

Jangan menganggap seluruh direktori di atas otomatis dibaca Kilo. Verifikasi mekanisme pemuatannya berdasarkan konfigurasi aktual dan dokumentasi resmi Kilo.

Buat pemetaan yang membedakan:

1. File ditemukan.
2. File terdaftar dalam konfigurasi.
3. File memenuhi mekanisme pemuatan Kilo.
4. File benar-benar tersedia dalam konteks analisis, sejauh dapat diverifikasi.

Jika status pemuatan tidak dapat dibuktikan, nyatakan sebagai belum terverifikasi.

## 4. Tahap kedua — Audit kualitas aturan

Baca seluruh aturan yang relevan dan periksa satu per satu.

Evaluasi setiap aturan berdasarkan kriteria berikut:

### A. Kejelasan

- Apakah instruksinya memiliki maksud yang jelas?
- Apakah AI dapat memahami tindakan yang wajib dilakukan?
- Apakah terdapat kata-kata umum yang dapat ditafsirkan berbeda?
- Apakah aturan menjelaskan kondisi kapan aturan berlaku?
- Apakah cakupan file atau kode yang diperiksa sudah jelas?

### B. Kelengkapan

- Apakah aturan menjelaskan kondisi yang harus dipenuhi?
- Apakah aturan menjelaskan pola implementasi yang benar?
- Apakah aturan menjelaskan pola yang dilarang?
- Apakah aturan memberikan contoh ketika diperlukan?
- Apakah aturan cukup spesifik untuk dijadikan dasar pemeriksaan kode?

### C. Kemampuan untuk diverifikasi

- Apakah aturan dapat diperiksa secara konkret pada kode?
- Apakah terdapat indikator yang bisa digunakan untuk menemukan pelanggaran?
- Apakah AI dapat membedakan kode yang sesuai dan tidak sesuai?
- Apakah aturan membutuhkan pemeriksaan manual, static analysis, test, atau alat lain?

### D. Konsistensi

- Apakah ada aturan yang saling bertentangan?
- Apakah ada aturan yang mengulang instruksi sama?
- Apakah ada aturan yang memiliki pengecualian tetapi pengecualiannya tidak dijelaskan?
- Apakah aturan lama sudah tidak sesuai dengan keputusan proyek terbaru?
- Apakah ada perbedaan instruksi antara aturan global, aturan proyek, agent, dan command?

Jangan langsung menganggap aturan yang panjang sebagai aturan yang baik. Sebaliknya, jangan menganggap aturan singkat pasti tidak lengkap.

Nilai berdasarkan kejelasan, ketepatan, konsistensi, dan kemudahan penerapannya.

## 5. Tahap ketiga — Audit command analisis

Periksa seluruh command yang berkaitan dengan pemeriksaan, audit, review, scan, dan verifikasi kode.

Prioritaskan command yang biasa digunakan untuk menemukan ketidaksesuaian terhadap aturan.

Periksa apakah command tersebut:

1. Memerintahkan AI membaca aturan sebelum menganalisis kode.
2. Menjelaskan direktori dan file yang wajib diperiksa.
3. Menjelaskan file yang harus dikecualikan.
4. Memerintahkan AI mencocokkan kode dengan setiap aturan.
5. Meminta bukti konkret untuk setiap temuan.
6. Melarang kesimpulan berdasarkan sampel kecil.
7. Memiliki tahapan pemeriksaan yang sistematis.
8. Meminta AI memeriksa ulang temuan sebelum menyimpulkan.
9. Membedakan pelanggaran nyata, potensi masalah, dan kode yang sesuai.
10. Memiliki kriteria penyelesaian yang jelas.

Periksa juga apakah ada instruksi yang justru membuat AI melakukan pemeriksaan terlalu umum, melewatkan direktori tertentu, atau menyelesaikan analisis terlalu cepat.

## 6. Tahap keempat — Audit proses analisis AI

Jangan hanya memeriksa dokumen aturan. Periksa bagaimana AI seharusnya menerapkan aturan tersebut pada kode.

Gunakan alur pemeriksaan berikut:

1. Baca aturan yang berlaku.
2. Buat daftar seluruh kewajiban pemeriksaan berdasarkan aturan.
3. Tentukan file dan bagian kode yang relevan untuk setiap kewajiban.
4. Periksa implementasi secara langsung.
5. Bandingkan implementasi dengan aturan.
6. Catat bukti lokasi kode yang melanggar.
7. Periksa pengecualian yang mungkin berlaku.
8. Lakukan pemeriksaan ulang terhadap temuan.
9. Catat aturan yang sudah diperiksa tetapi tidak ditemukan pelanggaran.

Cari kemungkinan kegagalan seperti:

- AI hanya membaca sebagian file.
- AI hanya memeriksa beberapa contoh.
- AI terlalu bergantung pada pencarian teks sederhana.
- AI melewatkan pola pelanggaran yang menggunakan bentuk implementasi berbeda.
- AI tidak memeriksa konteks pemanggilan fungsi atau hubungan antarfile.
- AI tidak membaca dokumentasi SDK atau paket ketika aturan mengharuskannya.
- AI tidak melakukan pemeriksaan lanjutan setelah menemukan satu masalah.
- AI menyatakan selesai tanpa memastikan seluruh cakupan pemeriksaan telah diperiksa.
- AI menganggap kode yang berhasil dikompilasi pasti sesuai aturan.

Jika memungkinkan, bandingkan instruksi command dengan tindakan pemeriksaan yang benar-benar dilakukan AI. Jangan mengklaim mengetahui proses internal yang tidak dapat diamati.

## 7. Tahap kelima — Uji kemampuan menemukan pelanggaran

Lakukan pengujian menggunakan kode proyek yang sudah ada.

Untuk pengujian ini:

1. Identifikasi beberapa aturan yang memiliki indikator pelanggaran konkret.
2. Temukan bagian kode yang berpotensi melanggar aturan tersebut.
3. Periksa kode secara langsung untuk memastikan apakah pelanggaran benar-benar terjadi.
4. Catat aturan yang dilanggar beserta lokasi kode.
5. Uji apakah metode analisis yang digunakan sebelumnya mampu menemukan pelanggaran tersebut.
6. Jika tidak, identifikasi tahapan pemeriksaan yang menyebabkan pelanggaran terlewat.

Utamakan bukti nyata dari proyek, bukan contoh buatan.

Jangan mengubah kode hanya untuk membuat pengujian.

Jika tidak ditemukan contoh pelanggaran yang dapat dibuktikan, jangan membuat temuan palsu. Laporkan keterbatasan pengujian.

## 8. Tahap keenam — Tentukan akar penyebab

Kelompokkan setiap penyebab berdasarkan kategori berikut:

- **Masalah pemuatan aturan:** aturan tidak dimuat atau cakupannya tidak sesuai.
- **Masalah kualitas aturan:** aturan ambigu, tidak lengkap, bertentangan, atau sulit diverifikasi.
- **Masalah command:** instruksi analisis tidak cukup sistematis atau tidak memiliki kriteria penyelesaian.
- **Masalah proses AI:** pemeriksaan tidak dilakukan secara menyeluruh atau tidak mengikuti instruksi.
- **Masalah konfigurasi:** pengaturan agent, izin, atau sumber instruksi menghambat pekerjaan.
- **Masalah keterbatasan teknis:** konteks, alat, dokumentasi, atau kemampuan model membatasi pemeriksaan.
- **Belum diketahui:** bukti yang tersedia belum cukup untuk memastikan penyebab.

Setiap penyebab harus memiliki:

1. Penjelasan masalah.
2. Bukti yang ditemukan.
3. File dan lokasi yang berkaitan.
4. Dampak terhadap hasil analisis.
5. Tingkat kepastian.

Gunakan klasifikasi kepastian:

- **Terbukti:** didukung bukti langsung.
- **Kemungkinan besar:** didukung beberapa indikasi kuat, tetapi belum terbukti sepenuhnya.
- **Belum diketahui:** bukti belum mencukupi.

Jangan mencampur fakta dan dugaan.

## 9. Tahap ketujuh — Susun dan lakukan perbaikan

Setelah akar penyebab ditemukan, tentukan perbaikan yang paling tepat.

Prioritaskan urutan berikut:

1. Perbaiki konfigurasi pemuatan aturan jika sumber masalahnya adalah aturan tidak dimuat.
2. Perbaiki aturan yang ambigu, tidak lengkap, atau bertentangan.
3. Perbaiki command yang instruksinya tidak sistematis.
4. Perbaiki mekanisme pemeriksaan agar setiap aturan benar-benar diverifikasi terhadap kode.
5. Perbaiki dokumentasi atau konteks yang menyebabkan AI salah memahami instruksi.
6. Jika masalah berasal dari keterbatasan teknis, berikan solusi yang sesuai dengan kemampuan dan konfigurasi yang tersedia.

Ketentuan perbaikan:

- Pertahankan maksud asli aturan.
- Hindari duplikasi instruksi.
- Jangan menambahkan aturan yang tidak menyelesaikan akar masalah.
- Jangan mengubah aturan yang sebenarnya sudah benar.
- Jangan menghapus pengecualian yang masih diperlukan.
- Jangan mengubah kode aplikasi.
- Jangan mengganti seluruh isi file jika cukup memperbaiki bagian tertentu.
- Jangan menimpa konfigurasi yang sudah ada tanpa mempertahankan pengaturan lainnya.

Sebelum mengubah file, pastikan hubungan antara temuan dan perubahan yang akan dilakukan jelas.

Jika perubahan menyentuh `AGENTS.md` atau file yang dilindungi Kilo, ikuti mekanisme persetujuan yang berlaku. Jangan mencoba melewati perlindungan tersebut.

## 10. Tahap kedelapan — Verifikasi hasil perbaikan

Setelah perbaikan dilakukan, ulangi pengujian pada kasus yang sebelumnya gagal ditemukan.

Pastikan:

1. Sumber aturan yang diperlukan sudah dapat dimuat.
2. Instruksi tidak lagi ambigu atau bertentangan.
3. Command analisis sudah memiliki tahapan pemeriksaan yang jelas.
4. AI dapat mengidentifikasi pelanggaran yang sebelumnya terlewat.
5. Temuan memiliki bukti lokasi kode yang benar.
6. Kode yang sebenarnya sesuai tidak dinyatakan sebagai pelanggaran.
7. Tidak ada kode aplikasi yang berubah akibat pekerjaan ini.
8. Tidak ada konfigurasi atau aturan lain yang rusak akibat perbaikan.

Jika tersedia, gunakan kembali kasus pengujian yang sama sebelum dan sesudah perbaikan agar hasilnya dapat dibandingkan.

Jangan menyatakan masalah sudah selesai jika pengujian belum membuktikannya.

Jika ditemukan bahwa perbaikan hanya mengurangi risiko tetapi belum menyelesaikan seluruh penyebab, nyatakan dengan jelas.

## 11. Tahap kesembilan — Pembaruan konteks aturan

Jika ada aturan yang diubah:

1. Periksa apakah `scripts/build_rules_context.sh` tersedia.
2. Baca isi script sebelum menjalankannya.
3. Pastikan script memang digunakan untuk membangun konteks aturan.
4. Jika sesuai, jalankan script tersebut setelah perubahan aturan selesai.
5. Periksa hasil pembentukan konteks untuk memastikan perubahan tercermin dengan benar.
6. Jika script tidak tersedia atau gagal, laporkan tanpa mengarang keberhasilan.

Jangan menjalankan script yang belum dipahami atau berpotensi melakukan perubahan di luar cakupan pekerjaan.

## 12. Format laporan akhir

Buat laporan yang jelas dan terstruktur dengan bagian berikut:

### A. Ringkasan hasil
- Apakah penyebab kegagalan berhasil ditemukan?
- Apa penyebab utamanya?
- Apakah masalah sudah diperbaiki?
- Apakah perbaikannya berhasil diverifikasi?

### B. Hasil pemeriksaan pemuatan aturan
Buat tabel berisi:
- File aturan.
- Lokasi.
- Mekanisme pemuatan.
- Status pemuatan.
- Bukti atau keterbatasan verifikasi.

### C. Temuan masalah
Buat tabel berisi:
- Nomor.
- Kategori masalah.
- Penjelasan.
- Bukti.
- Tingkat kepastian.
- Dampak.

### D. Hasil pengujian
Buat tabel berisi:
- Aturan yang diuji.
- Lokasi kode.
- Pelanggaran yang ditemukan.
- Apakah analisis sebelumnya melewatkannya?
- Apakah metode baru berhasil menemukannya?

### E. Perubahan yang dilakukan
Buat tabel berisi:
- Path file.
- Masalah sebelumnya.
- Perubahan yang dilakukan.
- Alasan perubahan.

### F. Hasil verifikasi
Jelaskan hasil pengujian setelah perbaikan, termasuk masalah yang masih tersisa.

### G. Rekomendasi lanjutan
Pisahkan rekomendasi yang belum dikerjakan dari perubahan yang sudah selesai.

## 13. Kriteria penyelesaian

Pekerjaan hanya dapat dinyatakan selesai apabila:

- Akar penyebab telah diidentifikasi atau keterbatasan pembuktiannya telah dijelaskan.
- Sumber masalah yang dapat diperbaiki telah ditangani.
- Aturan dan command yang bermasalah telah diperbaiki jika memang diperlukan.
- Pengujian ulang telah dilakukan.
- Hasil pengujian disertai bukti.
- Tidak ada perubahan kode aplikasi di luar cakupan.
- Laporan akhir telah dibuat.

**Prinsip utama: jangan sekadar membuat aturan semakin banyak. Bangun sistem aturan dan proses analisis yang membuat AI mampu memahami, menerapkan, serta memverifikasi setiap aturan secara konsisten.**