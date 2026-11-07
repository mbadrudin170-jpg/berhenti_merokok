---
description: Audit perubahan kode Dart sebelum commit terhadap AGENTS.md, aturan proyek, serta source Flutter, Dart, dan paket yang digunakan. Periksa setiap API termasuk widget sederhana, konstruktor, dan deprecated. Laporkan bukti serta saran tanpa mengubah kode.
agent: ask
---

# AUDIT PERUBAHAN KODE DART SEBELUM COMMIT

## 1. Tujuan

Lakukan audit terhadap seluruh perubahan kode Dart yang belum di-commit untuk memastikan implementasinya sesuai dengan:

1. `AGENTS.md`.
2. Seluruh aturan tambahan yang berlaku pada proyek.
3. Standar dan preferensi penulisan kode pengguna.
4. Source code Flutter SDK.
5. Source code Dart SDK.
6. Source code paket eksternal yang benar-benar digunakan proyek.
7. Kontrak API, konstruktor, parameter, dan lifecycle dari setiap API yang digunakan dalam perubahan.
8. Prinsip kualitas kode, keamanan runtime, performa, dan maintainability.

Tujuan audit adalah menemukan ketidaksesuaian sebelum pengguna melakukan commit.

**Tugas Anda hanya membaca, menganalisis, menemukan masalah, dan menyampaikan laporan beserta saran perbaikan. Pengguna sendiri yang menentukan apakah suatu temuan perlu diperbaiki.**

Jangan melakukan perubahan kode dalam kondisi apa pun.

## 2. Pemeriksaan Izin Tools

Sebelum menggunakan tools apa pun, WAJIB baca seluruh isi:

`.kilo/commands/izin_kilo.md`

File tersebut merupakan sumber otorisasi penggunaan tools selama menjalankan command ini.

### 2.1. Ketentuan izin

1. Baca seluruh isi file izin.
2. Identifikasi tools yang secara eksplisit diperbolehkan.
3. Gunakan hanya tools yang tercantum dalam file izin.
4. Jangan menggunakan tools hanya karena tersedia pada Kilo Code.
5. Jangan menganggap suatu tool diizinkan apabila tidak disebutkan dengan jelas.
6. Patuhi seluruh batasan penggunaan tools yang tercantum.
7. Jangan menggunakan MCP, browser, terminal, atau tools lainnya apabila tidak diizinkan.
8. Jangan menggunakan tool alternatif untuk melewati pembatasan.

Gunakan hanya tools yang sekaligus:

- Diizinkan dalam `.kilo/commands/izin_kilo.md`.
- Tersedia untuk agent `ask`.
- Tidak bertentangan dengan batasan audit baca-saja.

### 2.2. Jika izin tidak tersedia atau tidak jelas

Apabila file:

`.kilo/commands/izin_kilo.md`

tidak ditemukan, tidak dapat dibaca, kosong, atau memiliki ketentuan yang bertentangan, hentikan audit.

Jangan:

- Menebak izin.
- Menggunakan tools lain.
- Mengganti agent.
- Melanjutkan pemeriksaan dengan cara alternatif.
- Meminta tool tambahan di luar izin yang diberikan.

Laporkan masalah kepada pengguna.

**Pemeriksaan izin merupakan langkah pertama dan tidak boleh dilewati.**

## 3. Larangan Utama

### 3.1. Jangan mengubah apa pun

Anda hanya diperbolehkan membaca dan menganalisis.

Dilarang:

- Memperbaiki kode.
- Menambahkan kode.
- Menghapus kode.
- Memindahkan file.
- Melakukan refactoring.
- Mengubah struktur proyek.
- Mengubah konfigurasi.
- Memperbarui dokumentasi.
- Mengubah `AGENTS.md`.
- Mengubah file aturan.
- Melakukan formatting otomatis.
- Menjalankan code generator.
- Memperbarui dependensi.
- Menjalankan migrasi database.
- Membuat file laporan di dalam proyek.
- Menjalankan perintah yang dapat mengubah file proyek.

**Saran perbaikan hanya boleh ditampilkan dalam laporan. Jangan diterapkan ke file proyek.**

### 3.2. Jangan mengubah kondisi Git

Dilarang menjalankan operasi yang dapat mengubah:

- Working tree.
- Staging area.
- Branch.
- Riwayat commit.

Contoh perintah yang dilarang:

```bash
git add
git commit
git reset
git checkout
git restore
git clean
git stash
git merge
git rebase
git cherry-pick
git revert
git pull
git push
```

Jangan mengubah staging area, baik secara langsung maupun tidak langsung.

### 3.3. Jangan menjalankan pemeriksaan yang mengubah proyek

Jangan menjalankan:

- `dart format`.
- `flutter pub get`.
- `flutter pub add`.
- Code generator.
- Perintah migrasi.
- Test yang berpotensi menulis data atau file.
- Perintah yang memperbarui cache SDK atau dependensi.
- Perintah lain yang berpotensi mengubah file proyek.

Audit dilakukan melalui pembacaan kode, perbandingan perubahan, dan pemeriksaan source SDK.

Jika pemeriksaan membutuhkan proses yang berpotensi mengubah file, jangan jalankan. Laporkan keterbatasannya.

## 4. Baca AGENTS.md dan Seluruh Aturan Proyek

Setelah izin tools dipastikan, baca seluruh isi:

`AGENTS.md`

Jangan hanya membaca bagian awal atau mengandalkan ingatan dari percakapan sebelumnya.

Jika `AGENTS.md` merujuk ke file aturan lain, baca seluruh aturan yang relevan.

Periksa lokasi aturan berikut apabila tersedia:

- `.agents/rules/global/`
- `.agents/rules/proyek/`
- `.agents/skills/`, apabila terdapat aturan yang mewajibkan penggunaannya.
- `AGENTS.md` tambahan pada subdirektori proyek.

### 4.1. Identifikasi sumber aturan

Setiap aturan yang digunakan untuk menilai kode harus diketahui sumbernya.

Identifikasi apakah aturan berasal dari:

- `AGENTS.md`.
- `.agents/rules/global/aturan_bersama.md`.
- `.agents/rules/proyek/aturan_khusus.md`.
- `AGENTS.md` pada subdirektori.
- File aturan lainnya yang memang berlaku.
- Skill yang diwajibkan oleh aturan proyek.

Jangan menjadikan rekomendasi pribadi AI sebagai aturan wajib.

### 4.2. Periksa konflik aturan

Jika terdapat aturan yang bertentangan:

1. Identifikasi kedua aturan.
2. Cantumkan path dan nomor baris masing-masing.
3. Periksa apakah terdapat ketentuan prioritas.
4. Jangan menebak aturan mana yang harus diikuti.
5. Laporkan konflik yang belum dapat dipastikan.

Jangan menyatakan kode melanggar aturan apabila dasar aturan yang digunakan masih bertentangan dan prioritasnya belum jelas.

## 5. Identifikasi Perubahan Git yang Belum Di-commit

Audit hanya mencakup file dengan ekstensi `.dart`.

Periksa tiga jenis perubahan secara terpisah.

### 5.1. Staged Changes

Perubahan yang sudah masuk staging area tetapi belum di-commit.

Daftar file:

```bash
git diff --cached --name-status --find-renames -- '*.dart'
```

Detail perubahan:

```bash
git diff --cached --no-ext-diff --find-renames --unified=80 -- '*.dart'
```

Periksa:

- File Dart yang ditambahkan.
- File Dart yang diubah.
- File Dart yang dihapus.
- File Dart yang di-rename.

### 5.2. Unstaged Changes

Perubahan yang belum masuk staging area.

Daftar file:

```bash
git diff --name-status --find-renames -- '*.dart'
```

Detail perubahan:

```bash
git diff --no-ext-diff --find-renames --unified=80 -- '*.dart'
```

Periksa seluruh perubahan, termasuk file yang sebelumnya sudah di-stage tetapi kemudian diedit kembali.

### 5.3. Untracked Dart Files

Periksa file Dart baru yang belum dilacak Git:

```bash
git ls-files --others --exclude-standard -- '*.dart'
```

Baca seluruh isi file yang ditemukan.

Jangan mengabaikan file Dart baru hanya karena belum masuk staging.

### 5.4. Ketentuan pemeriksaan

1. Periksa staged, unstaged, dan untracked secara terpisah.
2. Jangan mencampurkan ketiganya menjadi satu kesimpulan.
3. Jika satu file memiliki perubahan staged sekaligus unstaged, periksa keduanya secara terpisah.
4. Baca isi file Dart secara lengkap jika diperlukan.
5. Untuk file yang dihapus, periksa kode yang dihapus melalui diff.
6. Untuk file yang di-rename, periksa perubahan kode dan lokasi barunya.
7. Jangan hanya membaca ringkasan nama file.
8. Jangan hanya membaca sebagian perubahan.
9. Jangan melewatkan perubahan yang terlihat sederhana.

Jika perlu membaca versi file staged:

```bash
git show :path/file.dart
```

Jangan menggunakan isi working tree sebagai pengganti isi staging karena keduanya mungkin berbeda.

### 5.5. Perhatikan versi kode

Satu file dapat memiliki dua versi perubahan:

- Versi yang sudah masuk staging.
- Versi terbaru pada working tree.

Periksa keduanya secara terpisah.

Nomor baris yang dilaporkan harus sesuai dengan versi kode yang sedang diperiksa.

## 6. Batasan File yang Diperiksa

Fokus pemeriksaan hanya pada perubahan kode Dart.

File yang menjadi target:

- File `.dart` staged.
- File `.dart` unstaged.
- File `.dart` untracked.
- File `.dart` yang dihapus.
- File `.dart` yang di-rename.

Jangan melakukan audit perubahan pada:

- `pubspec.yaml`.
- `pubspec.lock`.
- `.yaml`.
- `.json`.
- `.md`.
- `.xml`.
- `.gradle`.
- `.kt`.
- `.java`.
- `.swift`.
- `.html`.
- `.css`.
- File konfigurasi lainnya.

Namun, file pendukung non-Dart boleh dibaca apabila diperlukan untuk:

- Mengetahui versi SDK.
- Menemukan lokasi source paket.
- Memahami konfigurasi dependensi.
- Memahami konteks implementasi.

Pembacaan file pendukung tidak berarti Anda harus mengaudit perubahan di dalamnya.

### 6.1. File generated

Jangan langsung mengabaikan file Dart hasil generator.

Jika file generated berubah:

1. Identifikasi apakah file tersebut merupakan hasil generator.
2. Periksa apakah implementasi seharusnya dilakukan melalui file sumber generator.
3. Periksa aturan proyek mengenai generated files.
4. Laporkan jika terdapat pelanggaran.

Jangan menjalankan generator atau mengubah file tersebut.

## 7. Evaluasi Kesesuaian dengan AGENTS.md

Evaluasi setiap perubahan kode berdasarkan aturan yang berlaku.

Periksa aspek berikut.

### A. Gaya dan standar penulisan kode

- Penamaan class, function, variable, dan file.
- Struktur class dan function.
- Konsistensi penulisan.
- Pemisahan tanggung jawab.
- Penggunaan abstraksi.
- Penggunaan komentar.
- Kerapian dan keterbacaan.
- Konsistensi pola implementasi.
- Maintainability.

### B. Bug dan keamanan runtime

- Potensi null error.
- Penggunaan `!`, `as`, dan `dynamic`.
- Parsing data yang berisiko.
- Penanganan exception.
- Penggunaan `try/catch`.
- Penanganan Future dan asynchronous.
- Penggunaan `mounted` setelah `await`.
- Pengelolaan lifecycle.
- Pengelolaan resource.
- Pemanggilan `dispose`.
- Potensi memory leak.
- Potensi race condition.
- Penanganan transaksi database.
- Validasi input dan data.
- Potensi kehilangan atau kerusakan data.

### C. Arsitektur dan state management

- Penggunaan Provider dan Notifier.
- Penggunaan `ref.watch` dan `ref.read`.
- Penggunaan Riverpod Generator.
- Pengelolaan state.
- Penggunaan Freezed.
- Pemisahan UI dan business logic.
- Pengelolaan cache.
- Aliran data.
- Penggunaan dependency injection.
- Pemisahan tanggung jawab antar-layer.

### D. Performa

- Rebuild widget yang tidak diperlukan.
- Pemrosesan data yang tidak efisien.
- Query database yang tidak efisien.
- Penggunaan cache.
- Penggunaan resource.
- Operasi berat pada UI thread.
- Penggunaan Future dan Stream.
- Potensi penggunaan memori berlebihan.

### E. UX/UI

- Konsistensi desain.
- Keterbacaan teks.
- Ukuran dan jarak komponen.
- Kejelasan fungsi tombol.
- Loading dan feedback operasi.
- Penanganan error.
- Pencegahan interaksi ganda.
- Pengelolaan kondisi kosong.
- Pengalaman penggunaan yang membingungkan.
- Responsivitas tampilan.

### F. Pengujian

- Kesesuaian implementasi dengan standar testing proyek.
- Kualitas unit test.
- Penggunaan mock dan fake.
- Pengujian kondisi normal dan ekstrem.
- Potensi test yang tidak menguji perilaku sebenarnya.

Jangan membatasi pemeriksaan hanya pada daftar tersebut.

Periksa aspek lainnya apabila perubahan kode memiliki risiko atau dampak teknis yang relevan.

**Prioritaskan ketentuan yang benar-benar tertulis dalam AGENTS.md dan aturan proyek.**

## 8. WAJIB MEMBACA SOURCE SDK UNTUK SETIAP API YANG BERUBAH

Bagian ini merupakan ketentuan yang sangat penting.

**Jangan melewatkan pemeriksaan source SDK hanya karena suatu API terlihat sederhana, umum, atau sudah sering digunakan.**

Setiap API Flutter, Dart, maupun paket eksternal yang digunakan pada bagian kode Dart yang berubah wajib ditelusuri ke source code aslinya.

Hal ini berlaku untuk:

- Widget sederhana.
- Widget kompleks.
- Konstruktor widget.
- Method.
- Property.
- Callback.
- Enum.
- Class.
- Extension.
- API asynchronous.
- API collection.
- API lifecycle.
- API database atau paket eksternal.

**Tidak ada pengecualian hanya karena AI sudah merasa familiar dengan API tersebut.**

### 8.1. Jangan hanya memeriksa API yang rumit

Widget biasa juga wajib diperiksa.

Contoh widget yang tetap harus diperiksa konstruktornya ketika digunakan pada kode yang berubah:

- `Container`.
- `Padding`.
- `Row`.
- `Column`.
- `Text`.
- `Scaffold`.
- `AppBar`.
- `Center`.
- `SizedBox`.
- `ListView`.
- `ListTile`.
- `Stack`.
- `Expanded`.
- `Flexible`.
- `Align`.
- `Positioned`.
- `SingleChildScrollView`.
- `FutureBuilder`.
- `StreamBuilder`.

Daftar tersebut hanya contoh dan bukan batasan.

Jika perubahan menggunakan widget lainnya, periksa widget tersebut juga.

Jangan menganggap widget dasar tidak mungkin mengalami perubahan konstruktor, parameter, atau status deprecated.

### 8.2. Identifikasi SDK yang digunakan proyek

Cari lokasi Flutter SDK:

```bash
command -v flutter
```

Periksa lokasi executable:

```bash
readlink -f "$(command -v flutter)"
```

Identifikasi versi Flutter dan Dart berdasarkan informasi SDK yang benar-benar tersedia.

Lokasi informasi versi yang dapat diperiksa:

```text
<FLUTTER_SDK>/version
<FLUTTER_SDK>/bin/cache/dart-sdk/version
```

Jangan mengganti SDK.

Jangan mengunduh SDK baru.

Jangan menjalankan proses pembaruan SDK atau cache.

Jika tools yang diizinkan tidak dapat mengidentifikasi lokasi atau versi SDK, laporkan keterbatasannya. Jangan mengarang lokasi atau versi.

### 8.3. Lokasi source Flutter SDK

Periksa source Flutter pada:

```text
<FLUTTER_SDK>/packages/flutter/lib/
```

Untuk implementasi internal framework:

```text
<FLUTTER_SDK>/packages/flutter/lib/src/
```

Gunakan source yang benar-benar berasal dari versi Flutter proyek.

Untuk widget Material, periksa implementasi widget terkait pada source Material.

Untuk widget Widgets, periksa implementasi widget terkait pada source Widgets.

Untuk API Cupertino, periksa implementasi pada source Cupertino.

Jangan hanya membaca file export seperti `material.dart` atau `widgets.dart` apabila deklarasi dan konstruktor API berada dalam file implementasi lainnya.

Telusuri deklarasi class sampai menemukan definisi aslinya.

### 8.4. Lokasi source Dart SDK

Periksa source Dart pada:

```text
<FLUTTER_SDK>/bin/cache/dart-sdk/lib/
```

Sesuaikan subdirektori dengan API yang digunakan.

Contohnya:

- `dart:async`.
- `dart:collection`.
- `dart:core`.
- `dart:convert`.
- `dart:io`.
- `dart:isolate`.

Jika perubahan menggunakan API seperti `Future`, `Stream`, `List`, `Map`, `Iterable`, atau API bawaan Dart lainnya, periksa deklarasi dan kontrak API yang relevan pada source Dart SDK.

### 8.5. Periksa source paket eksternal

Jika kode menggunakan paket eksternal, periksa source paket yang benar-benar digunakan proyek.

Gunakan:

`.dart_tool/package_config.json`

untuk menemukan lokasi package root.

Periksa versi dan source paket yang telah di-resolve proyek.

Jangan mengganti source paket dengan dokumentasi dari versi terbaru apabila versi proyek berbeda.

Jangan menjalankan `flutter pub get` untuk memperoleh source paket.

Jika source paket belum tersedia, laporkan keterbatasannya.

### 8.6. Pemeriksaan wajib untuk setiap API

Untuk setiap API yang digunakan pada bagian kode yang berubah, lakukan pemeriksaan berikut apabila relevan.

**A. Identitas API**

- Nama class atau API.
- Library asal.
- Path file source.
- Versi SDK atau paket yang digunakan.

**B. Konstruktor**

- Deklarasi konstruktor sebenarnya.
- Parameter positional.
- Parameter named.
- Parameter wajib.
- Parameter opsional.
- Parameter nullable dan non-nullable.
- Nilai default.
- Generic type.
- Parameter yang diwariskan atau berasal dari class induk jika relevan.

**C. Kontrak API**

- Tipe parameter.
- Tipe nilai kembalian.
- Callback signature.
- Inheritance.
- Interface dan mixin yang relevan.
- Lifecycle.
- Perilaku asynchronous.
- Pengelolaan resource.
- Ketentuan pemanggilan API.

**D. Status API**

- Apakah API masih tersedia.
- Apakah konstruktor sudah deprecated.
- Apakah parameter sudah deprecated.
- Apakah method atau property sudah deprecated.
- Apakah terdapat API pengganti.
- Sejak versi berapa API tersebut deprecated apabila informasinya tersedia.
- Apakah terdapat perubahan API pada versi SDK yang digunakan.

**E. Perilaku API**

- Perilaku ketika nilai null.
- Default behavior.
- Efek samping.
- Notifikasi perubahan state.
- Penanganan error.
- Ketentuan penggunaan berdasarkan platform.

Jangan menyimpulkan bahwa API benar hanya karena kode terlihat valid.

### 8.7. Pemeriksaan konstruktor wajib dilakukan secara langsung

Jangan hanya memeriksa nama class.

Contohnya, jika kode menggunakan:

```dart
Container(
  margin: const EdgeInsets.all(8),
  child: const Text('Contoh'),
)
```

Jangan langsung menyimpulkan bahwa implementasi sudah benar karena widget tersebut umum digunakan.

Periksa:

1. Deklarasi class `Container`.
2. Konstruktor `Container`.
3. Ketersediaan parameter `margin`.
4. Tipe parameter `margin`.
5. Nilai default parameter yang relevan.
6. Konstruktor dan parameter `Text`.
7. Status deprecated apabila ada.
8. Kontrak penggunaan parameter tersebut.

Contoh tersebut hanya menggambarkan metode pemeriksaan. Terapkan pemeriksaan yang sama pada setiap widget atau konstruktor yang digunakan dalam perubahan kode.

### 8.8. Jangan melewatkan API yang terlihat biasa

Larangan berikut berlaku:

- Jangan melewatkan widget sederhana.
- Jangan hanya memeriksa API baru.
- Jangan hanya memeriksa API yang dianggap kompleks.
- Jangan mengandalkan pengetahuan internal AI.
- Jangan menganggap API lama masih berlaku tanpa memeriksa source.
- Jangan menganggap parameter masih tersedia tanpa memeriksa konstruktor.
- Jangan menganggap API tidak deprecated hanya karena kode masih dapat ditulis.
- Jangan menggunakan dokumentasi versi lain sebagai bukti utama.

**Source code merupakan dasar verifikasi. Pengetahuan internal AI hanya boleh membantu memahami source, bukan menggantikannya.**

### 8.9. Catat hasil pemeriksaan API

Untuk setiap kelompok API yang diperiksa, catat:

- Nama API.
- Konstruktor atau method yang digunakan.
- Path source.
- Nomor baris deklarasi atau konstruktor.
- Parameter yang digunakan.
- Status API.
- Hasil verifikasi.

Jika API sesuai, catat sebagai API yang telah diverifikasi.

Jika tidak sesuai, buat temuan dan berikan saran perbaikan.

Jika source tidak tersedia, catat sebagai belum dapat diverifikasi.

Jangan menyatakan semua API sudah sesuai apabila masih ada API yang belum diperiksa.

## 9. Periksa Dampak Perubahan terhadap Kode Terkait

Jangan hanya menilai baris yang berubah secara terpisah.

Jika perubahan memengaruhi kode Dart lainnya, baca bagian yang berkaitan.

Contohnya:

- Perubahan provider yang digunakan beberapa widget.
- Perubahan Notifier yang memengaruhi aliran state.
- Perubahan model yang digunakan beberapa repository.
- Perubahan function yang dipanggil dari beberapa tempat.
- Perubahan parameter yang memengaruhi pemanggil.
- Perubahan pengelolaan cache.
- Perubahan database.
- Perubahan lifecycle widget.

Tujuannya memastikan implementasi tidak hanya benar secara lokal, tetapi juga benar terhadap kode yang menggunakannya.

Tetap fokus pada dampak langsung perubahan Dart.

Jangan memperluas audit tanpa alasan teknis.

## 10. Klasifikasi Hasil Pemeriksaan

Pisahkan temuan menjadi empat kategori.

### A. Pelanggaran Aturan

Kode tidak sesuai dengan ketentuan yang benar-benar tertulis dalam `AGENTS.md` atau aturan proyek.

Setiap pelanggaran wajib menunjukkan:

1. Path kode yang bermasalah.
2. Nomor baris kode.
3. Nama atau judul aturan.
4. Path file sumber aturan.
5. Nomor baris aturan.
6. Isi aturan yang dilanggar.
7. Penjelasan hubungan antara kode dan aturan.

### B. Ketidaksesuaian SDK atau Paket

Penggunaan API tidak sesuai dengan deklarasi, konstruktor, kontrak, atau status API pada source SDK atau paket.

Contohnya:

- Parameter konstruktor tidak tersedia.
- Tipe parameter tidak sesuai.
- Parameter wajib tidak diberikan.
- API sudah deprecated.
- Konstruktor sudah deprecated.
- Method sudah diganti.
- Callback signature tidak sesuai.
- Penggunaan lifecycle tidak sesuai.
- API tidak tersedia pada versi SDK yang digunakan.

### C. Potensi Bug

Perubahan berpotensi menyebabkan:

- Runtime error.
- Null error.
- Kerusakan data.
- Race condition.
- Memory leak.
- Performa buruk.
- Hasil yang tidak sesuai.
- Kegagalan fitur.

### D. Rekomendasi Perbaikan

Perubahan tidak selalu salah, tetapi terdapat pendekatan yang lebih baik berdasarkan standar proyek atau source SDK.

**Jangan menyamakan rekomendasi dengan pelanggaran aturan.**

Jika tidak ada aturan tertulis yang secara langsung dilanggar, nyatakan:

`Aturan eksplisit yang dilanggar: Tidak ditemukan.`

### 10.1. Tingkat prioritas

Gunakan:

- **Critical:** berpotensi menyebabkan kerusakan data serius, masalah keamanan, atau kegagalan aplikasi yang sangat parah.
- **High:** berpotensi menyebabkan aplikasi crash, data tidak konsisten, atau fitur utama gagal.
- **Medium:** masalah implementasi yang dapat menimbulkan bug atau mengurangi kualitas secara signifikan.
- **Low:** masalah minor seperti konsistensi penulisan atau peningkatan maintainability.
- **Info:** catatan teknis atau rekomendasi yang tidak menunjukkan kesalahan.

Jangan memberikan prioritas secara berlebihan.

## 11. Wajib Menyertakan Path dan Nomor Baris

Setiap temuan yang menunjukkan masalah wajib menyertakan path file dan nomor baris yang tepat.

Format:

```text
lib/fitur/pengguna/provider.dart:42
```

Untuk rentang baris:

```text
lib/fitur/pengguna/provider.dart:42-48
```

Ketentuan:

1. Gunakan path relatif terhadap root proyek.
2. Cantumkan nomor baris sebenarnya.
3. Jangan hanya menyebut nama file.
4. Jangan memberikan nomor baris perkiraan.
5. Periksa kembali lokasi sebelum menyusun laporan.
6. Jika beberapa lokasi bermasalah, cantumkan semuanya.

**Jangan membuat link Markdown, link GitHub, URL, atau tautan editor. Pengguna hanya menginginkan path dan nomor baris.**

### 11.1. Sesuaikan nomor baris dengan versi perubahan

- Unstaged: gunakan nomor baris dari working tree.
- Staged: gunakan nomor baris dari isi staging.
- Untracked: gunakan nomor baris dari file tersebut.
- Kode yang dihapus: gunakan nomor baris lama berdasarkan diff dan jelaskan bahwa baris telah dihapus.

Jika satu file memiliki perubahan staged dan unstaged, jangan mencampurkan nomor baris kedua versi tersebut.

Jika nomor baris tidak dapat dipastikan, jelaskan keterbatasannya.

Jangan mengarang nomor baris.

### 11.2. Pisahkan lokasi kode proyek dan source SDK

Jika temuan berkaitan dengan SDK, tampilkan secara terpisah:

**Lokasi kode proyek:**

`lib/fitur/contoh.dart:42`

**Lokasi source SDK:**

`<FLUTTER_SDK>/packages/flutter/lib/src/widgets/container.dart:nomor_baris`

Jangan mencampurkan kedua lokasi tersebut.

## 12. Wajib Menunjukkan Path dan Nomor Baris Aturan yang Dilanggar

**Setiap pelanggaran aturan wajib menunjukkan lokasi aturan yang dilanggar.**

Jangan hanya menulis:

- Tidak sesuai AGENTS.md.
- Melanggar aturan proyek.
- Tidak mengikuti standar.
- Tidak sesuai ketentuan global.

Setiap pernyataan tersebut harus didukung sumber aturan.

### 12.1. Format lokasi aturan

Contoh:

```text
AGENTS.md:125-129
```

```text
.agents/rules/global/aturan_bersama.md:18-23
```

```text
.agents/rules/proyek/aturan_khusus.md:42-47
```

Gunakan path dan nomor baris dari file yang benar-benar menjadi sumber aturan.

Jika aturan muncul di beberapa file, cantumkan semua sumber yang relevan.

### 12.2. Wajib mengutip isi aturan

Contoh format:

**Aturan yang dilanggar:**

`.agents/rules/global/aturan_bersama.md:18-22`

**Isi aturan:**

> Setelah menggunakan `await` dalam lifecycle widget, pastikan widget masih mounted sebelum melakukan pembaruan UI.

**Lokasi kode bermasalah:**

`lib/fitur/pengguna/page/pengguna_page.dart:84-87`

**Penjelasan:**

Kode melakukan pembaruan UI setelah operasi asynchronous tanpa memastikan widget masih mounted. Hal ini bertentangan dengan aturan tersebut.

Isi dan nomor baris yang sebenarnya harus diambil langsung dari file proyek.

### 12.3. Jangan mengarang pelanggaran aturan

Jika menemukan masalah teknis tetapi tidak ada aturan tertulis yang mengaturnya:

1. Jangan mengklaim bahwa kode melanggar `AGENTS.md`.
2. Jangan menciptakan aturan yang sebenarnya tidak ada.
3. Klasifikasikan sebagai potensi bug atau rekomendasi.
4. Nyatakan bahwa aturan eksplisit yang dilanggar tidak ditemukan.
5. Tetap berikan saran perbaikan jika diperlukan.

## 13. Saran Perbaikan Wajib Disertakan

Jika menemukan ketidaksesuaian, berikan saran perbaikan yang spesifik.

Jelaskan:

1. Apa masalahnya?
2. Mengapa dianggap bermasalah?
3. Aturan mana yang tidak dipenuhi?
4. Di mana lokasi aturan tersebut?
5. Apa dampaknya jika dibiarkan?
6. Bagaimana cara memperbaikinya?
7. Mengapa pendekatan yang disarankan lebih tepat?

Jika diperlukan, berikan contoh kode perbaikan.

Contoh:

**Lokasi kode:**

`lib/fitur/pengguna/provider.dart:42`

**Kode saat ini:**

```dart
final user = state.value!;
```

**Saran perbaikan:**

```dart
final user = state.value;

if (user == null) {
  return;
}
```

Pastikan contoh sesuai dengan konteks implementasi, aturan proyek, tipe data, dan kontrak SDK.

**Contoh perbaikan hanya untuk ditampilkan kepada pengguna. Jangan menerapkannya ke file proyek.**

## 14. Jika Tidak Menemukan Masalah

Jika perubahan sudah sesuai:

- Jangan mengada-ada masalah.
- Jangan mencari kesalahan hanya untuk membuat laporan terlihat panjang.
- Jangan menyarankan perubahan yang tidak memberikan manfaat nyata.
- Jelaskan bahwa perubahan sudah diperiksa dan tidak ditemukan ketidaksesuaian berdasarkan pemeriksaan yang dilakukan.

Jika ada API yang source-nya belum tersedia, laporkan sebagai belum dapat diverifikasi.

Jangan menyatakan seluruh kode sudah sesuai SDK apabila masih ada API yang belum diperiksa.

## 15. Format Laporan Akhir

Susun laporan dengan format berikut agar mudah dibaca.

# LAPORAN AUDIT PERUBAHAN KODE DART

## A. Ringkasan

| Keterangan                     | Hasil  |
| ------------------------------ | ------ |
| Total file Dart diperiksa      | Jumlah |
| File staged                    | Jumlah |
| File unstaged                  | Jumlah |
| File untracked                 | Jumlah |
| Pelanggaran aturan             | Jumlah |
| Ketidaksesuaian SDK atau paket | Jumlah |
| Potensi bug                    | Jumlah |
| Rekomendasi                    | Jumlah |
| API yang diperiksa             | Jumlah |
| API belum dapat diverifikasi   | Jumlah |

## B. Daftar File yang Diperiksa

| No. | Path File           | Status    | Hasil             |
| --- | ------------------- | --------- | ----------------- |
| 1   | `lib/.../file.dart` | Staged    | Hasil pemeriksaan |
| 2   | `lib/.../file.dart` | Unstaged  | Hasil pemeriksaan |
| 3   | `lib/.../file.dart` | Untracked | Hasil pemeriksaan |

## C. Pelanggaran Aturan

### [Prioritas] Judul Pelanggaran

**1. Lokasi kode bermasalah**

`lib/path/file.dart:42-45`

**2. Status perubahan**

Staged / Unstaged / Untracked

**3. Aturan yang dilanggar**

`.agents/rules/global/aturan_bersama.md:18-22`

**4. Isi aturan**

Kutip ketentuan yang benar-benar tertulis di lokasi tersebut.

**5. Kode saat ini**

```dart
// Tampilkan potongan kode yang bermasalah.
```

**6. Alasan pelanggaran**

Jelaskan mengapa kode bertentangan dengan ketentuan.

**7. Dampak**

Jelaskan risiko atau akibatnya.

**8. Saran perbaikan**

Berikan pendekatan dan contoh kode apabila diperlukan.

## D. Ketidaksesuaian SDK dan Paket

Untuk setiap temuan:

### [Prioritas] Judul Temuan

**Lokasi kode proyek**

`lib/path/file.dart:42`

**Status**

Staged / Unstaged / Untracked

**API yang diperiksa**

Nama class, widget, konstruktor, method, atau parameter.

**Konstruktor atau deklarasi API**

Tampilkan signature yang ditemukan pada source sebenarnya.

**Lokasi source**

`<path-source-sdk>:nomor_baris`

**Hasil pemeriksaan**

Jelaskan parameter, nullability, default value, status deprecated, dan kontrak API yang relevan.

**Ketidaksesuaian**

Jelaskan bagian implementasi yang tidak sesuai.

**Saran perbaikan**

Berikan pendekatan yang sesuai dengan source dan versi SDK proyek.

## E. Ringkasan Pemeriksaan API

Tampilkan tabel agar pengguna dapat mengetahui API apa saja yang sudah diperiksa.

| No. | API         | Jenis              | Source      | Status              |
| --- | ----------- | ------------------ | ----------- | ------------------- |
| 1   | `Container` | Widget/konstruktor | Path source | Sesuai              |
| 2   | `Text`      | Widget/konstruktor | Path source | Sesuai              |
| 3   | `Future`    | Dart API           | Path source | Deprecated / Sesuai |

Status harus berdasarkan pemeriksaan source sebenarnya.

Gunakan kategori:

- Sesuai.
- Tidak sesuai.
- Deprecated.
- Belum dapat diverifikasi.

Jangan menampilkan status Sesuai apabila source belum dibaca.

## F. Potensi Bug

Untuk setiap temuan, cantumkan:

- Judul masalah dan prioritas.
- Path kode dan nomor baris.
- Status perubahan.
- Penjelasan kondisi penyebab.
- Dampak yang mungkin terjadi.
- Aturan terkait beserta path dan nomor baris jika ada.
- Saran perbaikan.

## G. Rekomendasi Perbaikan

Pisahkan rekomendasi yang merupakan peningkatan kualitas tetapi bukan pelanggaran aturan.

Setiap rekomendasi harus menyertakan:

- Path kode dan nomor baris jika menunjuk kode tertentu.
- Alasan rekomendasi.
- Pendekatan yang disarankan.

Jangan memaksakan rekomendasi sebagai pelanggaran.

## H. Bagian yang Belum Dapat Diverifikasi

Cantumkan:

- Source SDK yang tidak tersedia.
- Source paket yang tidak ditemukan.
- API yang tidak berhasil ditelusuri.
- Konstruktor yang belum dapat diverifikasi.
- Kontrak API yang belum dapat dipastikan.
- Nomor baris yang tidak dapat dipastikan.
- Aturan yang sumbernya belum ditemukan.
- Tools yang tidak diizinkan tetapi diperlukan untuk pemeriksaan tertentu.

Jelaskan alasan dan dampaknya terhadap kesimpulan.

## I. Kesimpulan

Gunakan salah satu status:

- **Tidak ditemukan masalah:** tidak ada ketidaksesuaian yang ditemukan dari pemeriksaan yang berhasil dilakukan.
- **Ditemukan rekomendasi:** ada peningkatan yang disarankan, tetapi tidak ditemukan pelanggaran atau bug yang terbukti.
- **Perlu perhatian:** ditemukan pelanggaran aturan, ketidaksesuaian SDK, atau potensi bug.
- **Belum dapat diverifikasi sepenuhnya:** terdapat API atau bagian kode yang belum berhasil diperiksa.
- **Audit tidak dapat dimulai:** file izin tidak tersedia atau tidak memberikan izin tools yang diperlukan.

Jangan menyuruh pengguna langsung melakukan commit.

Jangan memperbaiki kode.

Akhiri dengan menegaskan bahwa seluruh temuan dan saran merupakan bahan pertimbangan pengguna.

## 16. Checklist Pemeriksaan Akhir

### A. Izin

- [ ] `.kilo/commands/izin_kilo.md` sudah dibaca terlebih dahulu.
- [ ] Seluruh tools yang digunakan diizinkan.
- [ ] Tidak ada tools di luar daftar izin yang digunakan.

### B. Aturan

- [ ] `AGENTS.md` sudah dibaca seluruhnya.
- [ ] Semua aturan yang relevan sudah dibaca.
- [ ] Konflik aturan sudah diperiksa.
- [ ] Sumber setiap aturan yang digunakan sudah diketahui.

### C. Perubahan Dart

- [ ] Staged changes sudah diperiksa.
- [ ] Unstaged changes sudah diperiksa.
- [ ] Untracked Dart files sudah diperiksa.
- [ ] Perubahan pada file yang sama sudah dibedakan.
- [ ] Seluruh perubahan kode sudah dievaluasi.

### D. Source SDK

- [ ] Versi Flutter sudah diidentifikasi.
- [ ] Versi Dart sudah diidentifikasi.
- [ ] Setiap API yang digunakan pada bagian kode berubah sudah diidentifikasi.
- [ ] Widget sederhana juga sudah diperiksa.
- [ ] Konstruktor setiap widget yang relevan sudah diperiksa.
- [ ] Parameter dan tipe data sudah diperiksa.
- [ ] Nullability dan default value sudah diperiksa.
- [ ] Status deprecated sudah diperiksa.
- [ ] API pengganti sudah diidentifikasi jika diperlukan.
- [ ] Source paket eksternal sudah diperiksa apabila relevan.
- [ ] Tidak ada API yang dinyatakan sesuai tanpa pemeriksaan source.

### E. Laporan

- [ ] Setiap pelanggaran memiliki bukti.
- [ ] Setiap pelanggaran memiliki path dan nomor baris kode.
- [ ] Setiap pelanggaran memiliki path dan nomor baris aturan.
- [ ] Isi aturan yang dilanggar sudah dikutip.
- [ ] Hubungan antara kode dan aturan sudah dijelaskan.
- [ ] Setiap ketidaksesuaian memiliki saran perbaikan.
- [ ] Potensi bug dipisahkan dari pelanggaran aturan.
- [ ] Rekomendasi dipisahkan dari pelanggaran.
- [ ] API yang belum diverifikasi dilaporkan.

### F. Keamanan

- [ ] Tidak ada file yang diubah.
- [ ] Tidak ada staging area yang diubah.
- [ ] Tidak ada branch atau riwayat commit yang diubah.
- [ ] Tidak ada tools di luar izin yang digunakan.

Jika ada bagian yang belum selesai, jangan menyatakan audit sudah selesai sepenuhnya.

---

# PRINSIP UTAMA

**AUDIT, BUKAN IMPLEMENTASI.**

Anda bertugas menjadi pemeriksa independen sebelum perubahan kode di-commit.

Baca perubahan Dart secara menyeluruh, cocokkan dengan `AGENTS.md` dan seluruh aturan proyek, serta periksa source SDK yang sebenarnya.

**Jangan melewatkan pemeriksaan source hanya karena widget atau API terlihat sederhana.**

Setiap API yang digunakan dalam bagian kode berubah harus diperiksa deklarasi, konstruktor, parameter, kontrak, dan status deprecated-nya sesuai kebutuhan.

Setiap pelanggaran harus menunjukkan dua lokasi:

1. Lokasi kode yang bermasalah.
2. Lokasi aturan yang dilanggar.

Keduanya wajib mencantumkan path dan nomor baris yang tepat.

Jangan mengarang aturan, isi ketentuan, signature API, status deprecated, atau nomor baris.

Jika source belum berhasil diperiksa, nyatakan belum terverifikasi. Jangan membuat kesimpulan berdasarkan pengetahuan internal AI saja.

Berikan saran perbaikan yang konkret, tetapi jangan menerapkannya.

**Pengguna memegang kendali penuh atas keputusan apakah kode perlu diubah atau tidak.**
