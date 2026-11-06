---
description: Audit perubahan kode Dart sebelum commit berdasarkan AGENTS.md, aturan proyek, dan source SDK. Laporkan masalah beserta lokasi kode, lokasi aturan yang dilanggar, dan saran perbaikan tanpa mengubah apa pun.
agent: ask
---

# AUDIT PERUBAHAN KODE DART SEBELUM COMMIT

## 1. Tujuan

Lakukan audit terhadap seluruh perubahan kode Dart yang belum di-commit untuk memastikan implementasinya sesuai dengan:

1. `AGENTS.md`.
2. Seluruh aturan tambahan yang berlaku pada proyek.
3. Standar dan preferensi penulisan kode pengguna.
4. Dokumentasi dan source code Flutter SDK.
5. Dokumentasi dan source code Dart SDK.
6. Source code paket eksternal yang digunakan apabila perubahan berkaitan dengan API paket tersebut.
7. Prinsip kualitas kode, keamanan runtime, performa, dan maintainability.

Tujuan audit adalah menemukan ketidaksesuaian sebelum pengguna melakukan commit.

**Tugas Anda hanya membaca, menganalisis, menemukan masalah, dan menyampaikan laporan beserta saran perbaikan. Pengguna sendiri yang memutuskan apakah suatu temuan perlu diperbaiki.**

Jangan melakukan perubahan kode dalam kondisi apa pun.

## 2. Pemeriksaan Izin Tools

**WAJIB membaca file berikut sebelum menggunakan tools apa pun:**

`.kilo/commands/izin_kilo.md`

File tersebut merupakan sumber otorisasi penggunaan tools selama menjalankan command ini.

### 2.1. Ketentuan penggunaan tools

1. Baca seluruh isi `.kilo/commands/izin_kilo.md`.
2. Identifikasi tools yang secara eksplisit diizinkan.
3. Gunakan hanya tools yang tercantum dan diizinkan di dalam file tersebut.
4. Jangan menggunakan tools hanya karena tools tersebut tersedia di Kilo Code.
5. Jangan mengasumsikan suatu tool diizinkan apabila tidak disebutkan secara jelas.
6. Jika file mengatur batasan penggunaan command terminal, patuhi batasan tersebut.
7. Jika suatu tool tidak tercantum dalam daftar izin, jangan gunakan tool tersebut.
8. Jangan meminta atau menggunakan tools tambahan di luar daftar izin tanpa persetujuan pengguna.

### 2.2. Jika file izin tidak tersedia

Jika `.kilo/commands/izin_kilo.md`:

- Tidak ditemukan.
- Tidak dapat dibaca.
- Isinya kosong.
- Tidak menjelaskan daftar tools yang diizinkan.
- Mengandung ketentuan izin yang saling bertentangan.

Maka:

1. Jangan melanjutkan penggunaan tools.
2. Jangan menebak tools yang diperbolehkan.
3. Jangan menggunakan tools alternatif.
4. Laporkan masalah kepada pengguna.
5. Hentikan audit sampai izin dapat dipastikan.

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

**Jangan menerapkan saran perbaikan secara otomatis, meskipun Anda yakin bahwa perbaikan tersebut benar.**

Semua saran hanya boleh disampaikan dalam laporan.

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

Larangan berlaku untuk operasi Git lain yang mempunyai efek serupa.

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

Jangan menjalankan pemeriksaan otomatis apabila berpotensi menulis atau mengubah file proyek.

Audit harus dilakukan melalui pembacaan kode, perbandingan perubahan, dan pemeriksaan source SDK.

Jika suatu pemeriksaan membutuhkan proses yang berpotensi mengubah file, jangan jalankan. Jelaskan keterbatasannya dalam laporan.

## 4. Baca AGENTS.md dan Seluruh Aturan Proyek

Setelah izin tools dipastikan, baca seluruh isi:

`AGENTS.md`

Jangan hanya membaca bagian awal atau mengandalkan ingatan dari percakapan sebelumnya.

Jika `AGENTS.md` merujuk pada file aturan lain, baca seluruh aturan yang relevan.

Periksa lokasi aturan berikut apabila tersedia:

- `.agents/rules/global/`
- `.agents/rules/proyek/`
- `.agents/skills/`, apabila ada aturan yang mewajibkan penggunaan skill tertentu.
- `AGENTS.md` tambahan pada subdirektori proyek.

### 4.1. Identifikasi sumber aturan

Setiap aturan yang digunakan untuk menilai kode harus memiliki sumber yang jelas.

Identifikasi apakah aturan berasal dari:

- `AGENTS.md`.
- `.agents/rules/global/aturan_bersama.md`.
- `.agents/rules/proyek/aturan_khusus.md`.
- File `AGENTS.md` pada subdirektori.
- File aturan lain yang secara eksplisit berlaku.
- Skill yang diwajibkan oleh aturan proyek.

Jangan menjadikan rekomendasi pribadi AI sebagai aturan wajib.

### 4.2. Periksa konflik aturan

Jika terdapat aturan yang bertentangan:

1. Identifikasi kedua aturan.
2. Cantumkan path dan nomor baris masing-masing.
3. Periksa apakah ada ketentuan prioritas.
4. Jangan menebak aturan mana yang harus diikuti.
5. Laporkan konflik yang belum dapat dipastikan.

Jangan menyatakan kode melanggar aturan apabila dasar aturan yang digunakan masih bertentangan dan prioritasnya belum jelas.

## 5. Identifikasi Perubahan Git yang Belum Di-commit

Audit hanya mencakup file dengan ekstensi `.dart`.

Periksa tiga jenis perubahan berikut secara terpisah.

### 5.1. Staged Changes

Perubahan yang sudah masuk staging area tetapi belum di-commit.

Gunakan perintah berikut untuk melihat daftar file:

```bash
git diff --cached --name-status --find-renames -- '*.dart'
```

Untuk membaca detail perubahan:

```bash
git diff --cached --no-ext-diff --find-renames --unified=80 -- '*.dart'
```

Periksa:

- File Dart yang ditambahkan.
- File Dart yang diubah.
- File Dart yang dihapus.
- File Dart yang di-rename.

### 5.2. Unstaged Changes

Perubahan pada working tree yang belum masuk staging area.

Gunakan:

```bash
git diff --name-status --find-renames -- '*.dart'
```

Untuk membaca detail:

```bash
git diff --no-ext-diff --find-renames --unified=80 -- '*.dart'
```

Periksa seluruh perubahan, termasuk file yang sebelumnya sudah di-stage tetapi kemudian diedit kembali.

### 5.3. Untracked Dart Files

Periksa file Dart baru yang belum dilacak Git:

```bash
git ls-files --others --exclude-standard -- '*.dart'
```

Baca seluruh isi file Dart yang ditemukan karena belum memiliki versi pembanding dalam riwayat Git.

Jangan mengabaikan file Dart baru hanya karena belum masuk staging.

### 5.4. Ketentuan pemeriksaan Git

1. Periksa staged, unstaged, dan untracked secara terpisah.
2. Jangan mencampurkan ketiganya menjadi satu kesimpulan.
3. Jika satu file memiliki perubahan staged sekaligus unstaged, periksa keduanya secara terpisah.
4. Baca file Dart secara lengkap apabila diperlukan untuk memahami konteks.
5. Untuk file yang dihapus, periksa kode yang dihapus melalui diff.
6. Untuk file yang di-rename, periksa perubahan kode dan lokasi barunya.
7. Jangan hanya membaca ringkasan nama file.
8. Jangan hanya membaca sebagian perubahan.
9. Jangan melewatkan perubahan yang terlihat sederhana.

### 5.5. Periksa versi kode staged dan unstaged secara terpisah

Satu file dapat mempunyai dua versi perubahan yang berbeda:

- Versi yang sudah masuk staging.
- Versi terbaru pada working tree.

Jika diperlukan untuk membaca isi staged, gunakan:

```bash
git show :path/file.dart
```

Jangan menggunakan isi working tree sebagai pengganti isi staging karena keduanya bisa berbeda.

Untuk menentukan lokasi kode yang bermasalah, pastikan nomor baris sesuai dengan versi yang sedang diperiksa.

## 6. Batasan File yang Diperiksa

Fokus pemeriksaan hanya pada perubahan kode Dart.

File yang menjadi target:

- File `.dart` staged.
- File `.dart` unstaged.
- File `.dart` untracked.
- File `.dart` yang dihapus.
- File `.dart` yang di-rename.

Jangan melakukan audit terhadap perubahan pada:

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

Namun, file non-Dart boleh dibaca apabila diperlukan untuk memahami:

- Versi SDK.
- Lokasi dependensi.
- Struktur proyek.
- Konfigurasi pendukung implementasi.
- Informasi yang diperlukan untuk memahami kode Dart.

Pembacaan file pendukung bukan berarti Anda harus mengaudit perubahan di dalamnya.

### 6.1. File generated

Jangan langsung mengabaikan file Dart hasil generator.

Jika file generated berubah:

1. Identifikasi apakah file tersebut merupakan hasil generator.
2. Periksa apakah implementasi seharusnya dilakukan melalui file sumber generator.
3. Periksa aturan proyek mengenai generated files.
4. Laporkan apabila ada pelanggaran.

Jangan menjalankan generator atau mengubah file generated.

## 7. Evaluasi Kesesuaian dengan AGENTS.md

Evaluasi setiap perubahan kode berdasarkan aturan yang berlaku.

Periksa aspek berikut.

### A. Gaya dan standar penulisan kode

- Penamaan class, function, variable, dan file.
- Struktur class dan function.
- Konsistensi penulisan kode.
- Pemisahan tanggung jawab.
- Penggunaan abstraksi.
- Penggunaan komentar.
- Kerapian dan keterbacaan.
- Konsistensi pola implementasi.
- Kemudahan pemeliharaan kode.

### B. Bug dan keamanan runtime

- Potensi null error.
- Penggunaan operator `!`.
- Penggunaan `as`.
- Penggunaan `dynamic`.
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

Periksa aspek lain apabila perubahan kode memiliki risiko atau dampak teknis yang relevan.

**Prioritaskan ketentuan yang benar-benar tertulis dalam AGENTS.md dan aturan proyek.**

## 8. Wajib Membaca Source Code Flutter dan Dart SDK

Jangan hanya mengandalkan pengetahuan internal AI atau contoh kode yang pernah dipelajari.

**Periksa source code SDK yang benar-benar digunakan proyek.**

Tujuannya memastikan penggunaan API sesuai kontrak dan implementasi SDK.

### 8.1. Identifikasi SDK

Cari lokasi Flutter SDK:

```bash
command -v flutter
```

Periksa lokasi executable sebenarnya:

```bash
readlink -f "$(command -v flutter)"
```

Identifikasi versi Flutter dan Dart dengan membaca informasi versi yang tersedia.

Contoh lokasi:

```text
<FLUTTER_SDK>/version
<FLUTTER_SDK>/bin/cache/dart-sdk/version
```

Jangan mengganti SDK atau mengunduh versi baru.

### 8.2. Lokasi source Flutter SDK

Periksa source Flutter pada:

```text
<FLUTTER_SDK>/packages/flutter/lib/
```

Untuk implementasi internal framework:

```text
<FLUTTER_SDK>/packages/flutter/lib/src/
```

### 8.3. Lokasi source Dart SDK

Periksa source Dart pada:

```text
<FLUTTER_SDK>/bin/cache/dart-sdk/lib/
```

Sesuaikan subdirektori dengan API yang digunakan.

Contohnya:

- `dart:async`
- `dart:collection`
- `dart:core`
- `dart:convert`
- `dart:io`
- `dart:isolate`

Jangan membaca seluruh SDK tanpa tujuan. Cari source yang benar-benar berkaitan dengan perubahan kode.

### 8.4. Source code paket eksternal

Jika perubahan menggunakan API paket eksternal, periksa source code paket yang benar-benar digunakan proyek.

Gunakan informasi resolusi dependensi pada:

`.dart_tool/package_config.json`

Temukan lokasi package root berdasarkan konfigurasi tersebut.

Periksa deklarasi API dan implementasinya pada source paket yang tersedia.

Jangan menjalankan `flutter pub get` hanya untuk memperoleh source paket.

Jika source paket belum tersedia, laporkan keterbatasannya.

### 8.5. Hal yang wajib diperiksa

Untuk setiap API yang relevan, periksa:

1. Deklarasi class dan inheritance.
2. Constructor dan parameter.
3. Tipe data parameter dan nilai kembalian.
4. Generic type.
5. Nullability.
6. Callback signature.
7. Lifecycle method.
8. Kontrak pemanggilan method.
9. Perilaku asynchronous.
10. Penanganan error dan exception.
11. Pengelolaan resource.
12. Perilaku state dan notifikasi perubahan.
13. Default value.
14. API yang deprecated.
15. Ketentuan penggunaan berdasarkan platform.

Jangan menyimpulkan penggunaan API benar hanya karena kode dapat ditulis atau terlihat benar.

### 8.6. Hubungkan hasil pemeriksaan SDK dengan kode yang berubah

Untuk setiap ketidaksesuaian SDK:

- Sebutkan API yang diperiksa.
- Sebutkan path source SDK.
- Sebutkan nomor baris source SDK apabila tersedia.
- Jelaskan kontrak API yang relevan.
- Tunjukkan lokasi kode proyek yang tidak sesuai.
- Jelaskan risiko akibat ketidaksesuaian.
- Berikan saran implementasi yang sesuai.

Gunakan source SDK sesuai versi proyek, bukan source versi terbaru yang belum tentu digunakan.

Jika versi SDK atau source tidak dapat dipastikan, jangan membuat kesimpulan tanpa bukti.

## 9. Periksa Dampak Perubahan terhadap Kode Terkait

Jangan hanya menilai baris yang berubah secara terpisah.

Jika perubahan memiliki dampak terhadap kode lain, baca kode Dart yang berkaitan.

Contohnya:

- Perubahan provider yang digunakan beberapa widget.
- Perubahan Notifier yang memengaruhi aliran state.
- Perubahan model yang digunakan beberapa repository.
- Perubahan function yang dipanggil dari beberapa tempat.
- Perubahan parameter yang memengaruhi pemanggil.
- Perubahan pengelolaan cache yang memengaruhi tampilan data.
- Perubahan database yang memengaruhi transaksi.
- Perubahan lifecycle widget yang memengaruhi resource lain.

Tujuannya agar tidak terjadi penilaian yang hanya benar secara lokal tetapi salah secara keseluruhan.

Tetap fokus pada dampak langsung dari perubahan Dart yang belum di-commit.

Jangan memperluas audit menjadi pemeriksaan seluruh proyek tanpa alasan teknis.

## 10. Klasifikasi Hasil Pemeriksaan

Pisahkan seluruh temuan menjadi empat kategori.

### A. Pelanggaran Aturan

Kode tidak sesuai dengan ketentuan yang benar-benar tertulis dalam `AGENTS.md` atau aturan proyek.

Setiap pelanggaran wajib menunjukkan:

1. Lokasi kode yang bermasalah.
2. Nomor baris kode.
3. Nama atau judul aturan yang dilanggar.
4. Path file sumber aturan.
5. Nomor baris aturan.
6. Isi aturan yang dilanggar.
7. Penjelasan hubungan antara kode dan aturan.

### B. Ketidaksesuaian SDK

Penggunaan API tidak sesuai dengan kontrak source Flutter, Dart, atau paket yang digunakan.

### C. Potensi Bug

Perubahan berpotensi menyebabkan kesalahan runtime, kerusakan data, hasil yang tidak sesuai, atau masalah performa.

### D. Rekomendasi Perbaikan

Perubahan tidak selalu salah, tetapi terdapat pendekatan yang lebih baik berdasarkan standar proyek atau source SDK.

**Jangan menyamakan rekomendasi dengan pelanggaran aturan.**

Jika tidak ditemukan aturan eksplisit yang dilanggar, nyatakan:

`Aturan eksplisit yang dilanggar: Tidak ditemukan.`

Jangan membuat aturan baru berdasarkan asumsi pribadi.

### 10.1. Tingkat prioritas

Gunakan kategori berikut:

- **Critical:** berpotensi menyebabkan kerusakan data serius, masalah keamanan, atau kegagalan aplikasi yang sangat parah.
- **High:** berpotensi menyebabkan aplikasi crash, data tidak konsisten, atau fitur utama gagal.
- **Medium:** masalah implementasi yang dapat menimbulkan bug atau mengurangi kualitas secara signifikan.
- **Low:** masalah minor seperti konsistensi penulisan atau peningkatan maintainability.
- **Info:** catatan teknis atau rekomendasi yang tidak menunjukkan kesalahan.

Jangan memberikan prioritas secara berlebihan.

## 11. Wajib Menyertakan Path dan Nomor Baris Kode

**Setiap temuan yang menunjukkan masalah pada kode wajib mencantumkan path file dan nomor baris yang tepat.**

Contoh:

```text
lib/fitur/pengguna/provider.dart:42
```

Untuk rentang baris:

```text
lib/fitur/pengguna/provider.dart:42-48
```

Ketentuan:

1. Gunakan path relatif terhadap root proyek.
2. Cantumkan nomor baris yang sebenarnya.
3. Jangan hanya menyebut nama file.
4. Jangan memberikan nomor baris perkiraan.
5. Periksa kembali lokasi sebelum menyusun laporan.
6. Jika terdapat beberapa lokasi bermasalah, cantumkan seluruhnya.

**Jangan membuat link Markdown, link GitHub, URL, atau tautan editor. Pengguna hanya menginginkan path dan nomor baris.**

### 11.1. Nomor baris berdasarkan status perubahan

Perhatikan bahwa staged dan unstaged dapat memiliki isi berbeda.

- Untuk unstaged, gunakan nomor baris dari working tree.
- Untuk staged, gunakan nomor baris berdasarkan isi staging.
- Untuk file yang memiliki perubahan staged dan unstaged, gunakan nomor baris sesuai versi yang sedang diperiksa.
- Untuk file untracked, gunakan nomor baris dari isi file.
- Untuk kode yang dihapus, gunakan nomor baris lama berdasarkan diff dan jelaskan bahwa kode sudah dihapus.

Jika nomor baris tidak dapat dipastikan, jelaskan keterbatasannya.

Jangan mengarang nomor baris.

### 11.2. Pisahkan lokasi kode dan lokasi source SDK

Jika temuan berkaitan dengan SDK, cantumkan:

**Lokasi kode proyek:**

`lib/fitur/contoh.dart:42`

**Lokasi source SDK:**

`<FLUTTER_SDK>/packages/flutter/lib/src/widgets/framework.dart:nomor_baris`

Jangan mencampurkan lokasi kode proyek dengan source SDK.

## 12. Wajib Menunjukkan Path dan Nomor Baris Aturan yang Dilanggar

**Setiap temuan yang dikategorikan sebagai pelanggaran aturan wajib menunjukkan lokasi aturan yang dilanggar, bukan hanya lokasi kode yang bermasalah.**

Jangan hanya menulis:

- Tidak sesuai AGENTS.md.
- Melanggar aturan proyek.
- Tidak mengikuti standar.
- Tidak sesuai ketentuan global.

Pernyataan tersebut tidak cukup tanpa bukti lokasi aturan.

### 12.1. Format lokasi aturan

Gunakan salah satu format berikut sesuai sumber sebenarnya:

```text
AGENTS.md:125-129
```

```text
.agents/rules/global/aturan_bersama.md:18-23
```

```text
.agents/rules/proyek/aturan_khusus.md:42-47
```

Jika aturan terdapat dalam `AGENTS.md`, gunakan nomor baris dari `AGENTS.md`.

Jika aturan berasal dari file global atau khusus, gunakan nomor baris file sumber aturan tersebut.

Jika keduanya relevan, cantumkan kedua lokasi.

### 12.2. Cara menentukan nomor baris aturan

Baca isi file aturan menggunakan tools yang diizinkan.

Pastikan nomor baris berasal dari isi file yang sebenarnya.

Jika tools yang diizinkan mendukung pembacaan nomor baris, manfaatkan fitur tersebut.

Jangan menggunakan perkiraan nomor baris.

Jangan mengarang lokasi aturan.

### 12.3. Wajib mengutip isi aturan

Selain path dan nomor baris, tampilkan isi aturan yang benar-benar dilanggar.

Contoh format:

**Aturan yang dilanggar:**

`.agents/rules/global/aturan_bersama.md:18-22`

**Isi aturan:**

> Setelah menggunakan `await` dalam lifecycle widget, pastikan widget masih mounted sebelum melakukan pembaruan UI.

**Lokasi kode bermasalah:**

`lib/fitur/pengguna/page/pengguna_page.dart:84-87`

**Penjelasan:**

Kode melakukan pembaruan UI setelah operasi asynchronous tanpa memastikan widget masih mounted. Hal ini bertentangan dengan ketentuan pada aturan tersebut.

Contoh di atas hanya menunjukkan format laporan.

Isi aturan dan nomor baris yang sebenarnya harus diambil langsung dari file proyek.

### 12.4. Jangan mengarang pelanggaran aturan

Jika menemukan masalah teknis tetapi tidak ada aturan tertulis yang secara langsung mengaturnya:

1. Jangan mengklaim bahwa kode melanggar `AGENTS.md`.
2. Jangan menciptakan aturan yang sebenarnya tidak ada.
3. Klasifikasikan sebagai potensi bug atau rekomendasi.
4. Jelaskan bahwa aturan eksplisit yang dilanggar tidak ditemukan.
5. Tetap berikan saran perbaikan jika diperlukan.

**Pelanggaran aturan harus berdasarkan bukti ketentuan tertulis, bukan sekadar penilaian pribadi AI.**

## 13. Saran Perbaikan Wajib Disertakan

Jika menemukan ketidaksesuaian, berikan saran perbaikan yang spesifik.

Jangan hanya menulis:

- Kode ini kurang baik.
- Kode ini perlu diperbaiki.
- Sebaiknya gunakan cara lain.
- Implementasi tidak sesuai standar.

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

Pastikan contoh perbaikan sesuai dengan:

- Konteks implementasi sebenarnya.
- Aturan proyek.
- Kontrak SDK.
- Tipe data.
- Alur business logic.

**Contoh perbaikan hanya untuk ditampilkan kepada pengguna. Jangan menerapkannya ke file proyek.**

## 14. Jika Tidak Menemukan Masalah

Jika perubahan sudah sesuai:

- Jangan mengada-ada masalah.
- Jangan mencari kesalahan hanya untuk membuat laporan terlihat panjang.
- Jangan menyarankan perubahan yang tidak memberikan manfaat nyata.
- Jelaskan bahwa perubahan sudah diperiksa dan tidak ditemukan ketidaksesuaian berdasarkan pemeriksaan yang dilakukan.

Jika ada bagian yang tidak dapat diverifikasi karena source SDK tidak tersedia, nyatakan secara jujur.

Jangan menyatakan seluruh kode sudah benar apabila masih ada bagian penting yang belum diperiksa.

## 15. Format Laporan Akhir

Susun laporan secara terstruktur agar mudah dibaca.

# LAPORAN AUDIT PERUBAHAN KODE DART

## A. Ringkasan

| Keterangan                | Hasil  |
| ------------------------- | ------ |
| Total file Dart diperiksa | Jumlah |
| File staged               | Jumlah |
| File unstaged             | Jumlah |
| File untracked            | Jumlah |
| Pelanggaran aturan        | Jumlah |
| Ketidaksesuaian SDK       | Jumlah |
| Potensi bug               | Jumlah |
| Rekomendasi               | Jumlah |

## B. Daftar File yang Diperiksa

| No. | Path File           | Status    | Hasil             |
| --- | ------------------- | --------- | ----------------- |
| 1   | `lib/.../file.dart` | Staged    | Hasil pemeriksaan |
| 2   | `lib/.../file.dart` | Unstaged  | Hasil pemeriksaan |
| 3   | `lib/.../file.dart` | Untracked | Hasil pemeriksaan |

Pastikan semua file Dart yang menjadi target audit tercantum.

## C. Pelanggaran Aturan

Untuk setiap pelanggaran gunakan format berikut.

### [Prioritas] Judul Pelanggaran

<text color="secondary" weight="semibold">1. Lokasi kode bermasalah</text>

`lib/path/file.dart:42-45`

<text color="secondary" weight="semibold">2. Status perubahan</text>

Staged / Unstaged / Untracked

<text color="secondary" weight="semibold">3. Aturan yang dilanggar</text>

`.agents/rules/global/aturan_bersama.md:18-22`

<text color="secondary" weight="semibold">4. Isi aturan</text>

Kutip isi ketentuan yang benar-benar tertulis pada lokasi tersebut.

<text color="secondary" weight="semibold">5. Kode saat ini</text>

```dart
// Tampilkan potongan kode yang bermasalah.
```

<text color="secondary" weight="semibold">6. Alasan pelanggaran</text>

Jelaskan secara spesifik mengapa kode bertentangan dengan ketentuan tersebut.

<text color="secondary" weight="semibold">7. Dampak</text>

Jelaskan risiko atau akibatnya.

<text color="secondary" weight="semibold">8. Saran perbaikan</text>

Berikan pendekatan perbaikan beserta contoh kode apabila diperlukan.

Jika terdapat beberapa aturan yang dilanggar, tampilkan seluruh path dan nomor baris aturannya.

## D. Ketidaksesuaian SDK

Untuk setiap temuan:

### [Prioritas] Judul Temuan

**Lokasi kode proyek:**

`lib/path/file.dart:42`

**Status:**

Staged / Unstaged / Untracked

**API yang diperiksa:**

Nama API Flutter, Dart, atau paket.

**Lokasi source SDK:**

`<path-source-sdk>:nomor_baris`

**Kontrak API:**

Jelaskan ketentuan penggunaan API berdasarkan source yang dibaca.

**Ketidaksesuaian:**

Jelaskan implementasi yang tidak sesuai.

**Aturan proyek yang berkaitan:**

Cantumkan path dan nomor baris aturan jika ada.

**Saran perbaikan:**

Berikan pendekatan yang sesuai dengan API dan versi SDK proyek.

## E. Potensi Bug

Untuk setiap potensi bug cantumkan:

- Judul masalah dan prioritas.
- Path kode dan nomor baris.
- Status perubahan.
- Penjelasan kondisi penyebab.
- Dampak yang mungkin terjadi.
- Aturan terkait beserta path dan nomor baris jika ada.
- Saran perbaikan.

Jika tidak terdapat aturan eksplisit yang dilanggar, nyatakan demikian.

## F. Rekomendasi Perbaikan

Pisahkan rekomendasi yang sifatnya peningkatan kualitas tetapi bukan pelanggaran aturan.

Setiap rekomendasi yang menunjuk kode tertentu wajib mencantumkan:

- Path kode dan nomor baris.
- Alasan rekomendasi.
- Pendekatan yang disarankan.

Jangan memaksakan rekomendasi sebagai pelanggaran.

## G. Bagian yang Belum Dapat Diverifikasi

Cantumkan apabila terdapat:

- Source SDK yang tidak tersedia.
- Source paket yang tidak ditemukan.
- Kontrak API yang belum dapat dipastikan.
- Konteks kode yang belum cukup.
- Nomor baris yang tidak dapat dipastikan.
- Aturan yang tidak dapat ditemukan sumbernya.
- Konflik antaraturan yang belum dapat diselesaikan.
- Tools atau pemeriksaan yang tidak diizinkan.

Jelaskan alasan dan dampaknya terhadap kesimpulan audit.

## H. Kesimpulan

Gunakan salah satu status berikut:

- **Tidak ditemukan masalah:** tidak ada ketidaksesuaian yang ditemukan dari pemeriksaan yang berhasil dilakukan.
- **Ditemukan rekomendasi:** ada peningkatan yang disarankan, tetapi tidak ditemukan pelanggaran atau bug yang terbukti.
- **Perlu perhatian:** ditemukan pelanggaran aturan, potensi bug, atau ketidaksesuaian yang perlu dipertimbangkan sebelum commit.
- **Belum dapat diverifikasi sepenuhnya:** terdapat keterbatasan pemeriksaan yang memengaruhi kesimpulan.
- **Audit tidak dapat dimulai:** file izin tidak tersedia, tidak dapat dibaca, atau tidak memberikan izin tools yang diperlukan.

Jangan menyuruh pengguna langsung melakukan commit.

Jangan memperbaiki kode.

Akhiri dengan menegaskan bahwa seluruh temuan dan saran merupakan bahan pertimbangan pengguna.

## 16. Checklist Sebelum Menyelesaikan Audit

### Pemeriksaan izin

- [ ] `.kilo/commands/izin_kilo.md` sudah dibaca terlebih dahulu.
- [ ] Seluruh tools yang digunakan tercantum dalam izin.
- [ ] Tidak ada tools di luar daftar izin yang digunakan.

### Pemeriksaan aturan

- [ ] `AGENTS.md` sudah dibaca seluruhnya.
- [ ] Semua aturan yang relevan sudah dibaca.
- [ ] Konflik aturan sudah diperiksa.
- [ ] Sumber setiap aturan yang digunakan sudah diketahui.

### Pemeriksaan perubahan kode

- [ ] Seluruh perubahan Dart staged sudah diperiksa.
- [ ] Seluruh perubahan Dart unstaged sudah diperiksa.
- [ ] Seluruh file Dart untracked sudah diperiksa.
- [ ] Perubahan pada file yang sama sudah dibedakan berdasarkan statusnya.
- [ ] Seluruh perubahan sudah dievaluasi.
- [ ] Kode terkait sudah diperiksa apabila diperlukan.

### Pemeriksaan SDK

- [ ] Versi Flutter dan Dart sudah diketahui.
- [ ] Source SDK yang relevan sudah diperiksa.
- [ ] Source paket eksternal sudah diperiksa apabila relevan.
- [ ] Kontrak API sudah dibandingkan dengan kode proyek.

### Pemeriksaan laporan

- [ ] Setiap pelanggaran memiliki bukti.
- [ ] Setiap pelanggaran memiliki path dan nomor baris kode.
- [ ] Setiap pelanggaran memiliki path dan nomor baris aturan.
- [ ] Isi aturan yang dilanggar sudah dikutip.
- [ ] Hubungan antara kode dan aturan sudah dijelaskan.
- [ ] Setiap ketidaksesuaian memiliki saran perbaikan.
- [ ] Potensi bug dipisahkan dari pelanggaran aturan.
- [ ] Rekomendasi dipisahkan dari instruksi wajib.
- [ ] Keterbatasan pemeriksaan sudah dilaporkan.

### Keamanan

- [ ] Tidak ada file yang diubah.
- [ ] Tidak ada staging area yang diubah.
- [ ] Tidak ada branch yang diubah.
- [ ] Tidak ada riwayat commit yang diubah.
- [ ] Tidak ada operasi Git yang dilarang.
- [ ] Tidak ada tool di luar izin yang digunakan.

Jika ada bagian yang belum selesai, jangan menyatakan audit sudah selesai sepenuhnya.

---

# PRINSIP UTAMA

**AUDIT, BUKAN IMPLEMENTASI.**

Anda bertugas menjadi pemeriksa independen sebelum perubahan kode di-commit.

Baca perubahan Dart secara menyeluruh, cocokkan dengan `AGENTS.md` dan aturan proyek, serta periksa source SDK yang sebenarnya.

Setiap pelanggaran harus menunjukkan dua lokasi:

1. **Lokasi kode yang bermasalah.**
2. **Lokasi aturan yang dilanggar.**

Keduanya wajib mencantumkan path dan nomor baris yang tepat.

Tampilkan isi aturan yang dilanggar agar pengguna dapat memahami dasar penilaiannya.

Jangan mengarang aturan, isi ketentuan, atau nomor baris.

Jika tidak ada aturan tertulis yang dilanggar, klasifikasikan temuan sebagai potensi bug atau rekomendasi, bukan pelanggaran aturan.

Berikan saran perbaikan yang konkret, tetapi jangan menerapkannya.

**Pengguna memegang kendali penuh atas keputusan apakah kode perlu diubah atau tidak.**
