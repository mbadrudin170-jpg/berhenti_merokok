---
description: Audit perubahan kode Dart yang belum di-commit terhadap AGENTS.md, aturan proyek, dan source SDK. Laporkan lokasi kode, aturan yang dilanggar beserta path dan baris aturannya, serta saran perbaikan tanpa mengubah apa pun.
agent: ask
---

# AUDIT PERUBAHAN KODE DART SEBELUM COMMIT

## 1. Tujuan Utama

Lakukan audit terhadap seluruh perubahan kode Dart yang belum di-commit untuk memastikan implementasinya sudah sesuai dengan:

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

## 2. Larangan Utama

### 2.1. Jangan mengubah apa pun

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
- Membuat file laporan di dalam proyek.
- Mengubah aturan AI.
- Mengubah `AGENTS.md`.
- Melakukan formatting otomatis.
- Menjalankan code generator.
- Memperbarui atau mengubah dependensi.
- Menjalankan migrasi database.
- Menjalankan perintah yang dapat mengubah file proyek.

Jangan menerapkan saran perbaikan secara otomatis, meskipun Anda yakin bahwa perbaikan tersebut benar.

**Semua saran hanya boleh disampaikan dalam laporan.**

### 2.2. Jangan mengubah kondisi Git

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

Larangan juga berlaku untuk operasi Git lainnya yang mempunyai efek serupa.

Anda hanya boleh menggunakan perintah Git yang bersifat baca-saja.

Jangan mengubah staging area, baik secara langsung maupun tidak langsung.

### 2.3. Jangan menjalankan pemeriksaan yang berpotensi mengubah proyek

Jangan menjalankan:

- `dart format`
- `flutter pub get`
- `flutter pub add`
- Code generator.
- Perintah migrasi.
- Test yang berpotensi menulis data atau file.
- Perintah yang memperbarui cache SDK atau dependensi.
- Perintah lain yang berpotensi mengubah file proyek.

Jangan menjalankan pemeriksaan otomatis apabila berpotensi menghasilkan perubahan file atau cache.

Audit dilakukan melalui pembacaan kode, perbandingan perubahan, dan pemeriksaan source SDK.

Jika pemeriksaan membutuhkan proses yang berpotensi mengubah file, jangan jalankan. Jelaskan keterbatasannya dalam laporan.

## 3. Baca AGENTS.md dan Seluruh Aturan Proyek

Sebelum menganalisis perubahan kode, baca seluruh isi:

`AGENTS.md`

Jika `AGENTS.md` merujuk ke file aturan lain, baca juga seluruh aturan yang relevan.

Periksa apakah terdapat `AGENTS.md` tambahan pada direktori tempat file Dart yang berubah berada.

Perhatikan juga aturan yang disimpan di:

- `.agents/rules/global/`
- `.agents/rules/proyek/`
- `.agents/skills/`, apabila suatu aturan merujuk ke skill tertentu.

Tujuannya:

1. Memahami seluruh standar yang berlaku.
2. Mengetahui larangan dan ketentuan implementasi.
3. Mengetahui standar penulisan kode.
4. Memahami arsitektur proyek.
5. Mengetahui preferensi pengembangan pengguna.
6. Menghindari penilaian berdasarkan asumsi pribadi.
7. Menemukan ketidaksesuaian terhadap aturan yang sudah ditetapkan.

Jangan hanya membaca sebagian aturan atau mengandalkan ingatan dari percakapan sebelumnya.

### 3.1. Identifikasi sumber aturan yang berlaku

Setiap aturan yang digunakan untuk menilai kode harus diketahui sumbernya.

Periksa:

- Apakah aturan berada langsung di `AGENTS.md`.
- Apakah aturan berasal dari file global.
- Apakah aturan berasal dari file khusus proyek.
- Apakah aturan berasal dari `AGENTS.md` pada subdirektori.
- Apakah aturan berasal dari skill yang secara eksplisit diwajibkan oleh aturan proyek.

Jangan menganggap suatu ketentuan sebagai aturan proyek apabila sebenarnya hanya merupakan rekomendasi AI.

### 3.2. Periksa konflik aturan

Jika terdapat dua aturan yang bertentangan:

1. Identifikasi kedua aturan.
2. Cantumkan path dan nomor baris masing-masing aturan.
3. Periksa ketentuan prioritas yang berlaku.
4. Jangan menebak aturan mana yang harus diikuti.
5. Laporkan konflik yang belum dapat dipastikan.

Jangan membuat kesimpulan bahwa kode melanggar aturan apabila sumber aturan yang digunakan masih bertentangan dan belum dapat dipastikan prioritasnya.

## 4. Identifikasi Perubahan Git yang Belum Di-commit

Audit hanya mencakup file dengan ekstensi `.dart`.

Periksa tiga jenis perubahan secara terpisah.

### 4.1. Staged Changes

Perubahan yang sudah masuk staging area tetapi belum di-commit.

Untuk melihat daftar file:

```bash
git diff --cached --name-status --find-renames -- '*.dart'
```

Untuk membaca seluruh detail perubahan:

```bash
git diff --cached --no-ext-diff --find-renames --unified=80 -- '*.dart'
```

Periksa:

- File Dart yang ditambahkan.
- File Dart yang diubah.
- File Dart yang dihapus.
- File Dart yang di-rename.

### 4.2. Unstaged Changes

Perubahan pada working tree yang belum masuk staging area.

Untuk melihat daftar file:

```bash
git diff --name-status --find-renames -- '*.dart'
```

Untuk membaca seluruh detail perubahan:

```bash
git diff --no-ext-diff --find-renames --unified=80 -- '*.dart'
```

Periksa seluruh perubahan, termasuk file yang sebelumnya sudah di-stage tetapi kemudian diedit kembali.

### 4.3. Untracked Dart Files

Periksa file Dart baru yang belum dilacak Git:

```bash
git ls-files --others --exclude-standard -- '*.dart'
```

Untuk file tersebut, baca seluruh isi karena belum memiliki versi pembanding.

Jangan mengabaikan file Dart baru hanya karena belum masuk staging.

### 4.4. Ketentuan pemeriksaan

1. Periksa staged, unstaged, dan untracked secara terpisah.
2. Jangan mencampurkan ketiganya menjadi satu kesimpulan.
3. Jika satu file mempunyai perubahan staged sekaligus unstaged, periksa keduanya secara terpisah.
4. Baca isi file Dart secara lengkap apabila diperlukan untuk memahami konteks.
5. Untuk file yang dihapus, periksa kode yang dihapus melalui diff.
6. Untuk file yang di-rename, periksa perubahan kode dan lokasi barunya.
7. Jangan hanya membaca ringkasan nama file.
8. Jangan hanya membaca sebagian perubahan.
9. Jangan melewatkan perubahan yang terlihat sederhana.

### 4.5. Baca isi file staged secara akurat

Jika perlu membaca versi file yang sudah berada di staging:

```bash
git show :path/file.dart
```

Perintah tersebut digunakan hanya untuk membaca isi staging.

Jangan menggunakan isi working tree sebagai pengganti isi staging karena keduanya mungkin berbeda.

### 4.6. Perubahan pada file yang sama

Satu file dapat memiliki dua kondisi berbeda:

- Perubahan pertama sudah masuk staging.
- Perubahan berikutnya masih berada di working tree.

Audit kedua perubahan tersebut secara terpisah.

Pastikan kesimpulan tidak mencampurkan implementasi versi staging dengan implementasi versi working tree.

## 5. Batasan File yang Diperiksa

Fokus audit hanya pada perubahan kode Dart.

File yang menjadi target:

- File `.dart` yang sudah staged.
- File `.dart` yang belum staged.
- File `.dart` baru yang belum dilacak Git.
- File `.dart` yang dihapus.
- File `.dart` yang di-rename.

Jangan melakukan audit terhadap perubahan pada:

- `pubspec.yaml`
- `pubspec.lock`
- `.yaml`
- `.json`
- `.md`
- `.xml`
- `.gradle`
- `.kt`
- `.java`
- `.swift`
- `.html`
- `.css`
- File konfigurasi lainnya.

Namun, file konfigurasi boleh dibaca apabila diperlukan untuk memahami versi SDK, lokasi dependensi, atau konteks implementasi.

Pembacaan file pendukung tersebut bukan berarti Anda harus mengaudit perubahan di dalamnya.

### 5.1. File generated

Jangan langsung mengabaikan file Dart hasil generator.

Jika file generated mengalami perubahan:

1. Identifikasi apakah file tersebut merupakan hasil generator.
2. Periksa apakah implementasinya seharusnya dilakukan melalui file sumber generator.
3. Periksa aturan proyek mengenai generated files.
4. Laporkan jika terdapat pelanggaran.

Jangan menjalankan generator atau mengubah file generated.

## 6. Evaluasi Kesesuaian dengan AGENTS.md

Evaluasi setiap perubahan kode terhadap seluruh aturan yang berlaku.

Periksa aspek berikut.

### A. Standar penulisan kode

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

Jangan membatasi evaluasi hanya pada daftar tersebut.

Periksa aspek lain apabila perubahan kode memiliki risiko atau dampak teknis yang relevan.

**Prioritaskan ketentuan yang benar-benar tertulis dalam AGENTS.md dan aturan proyek.**

Jangan menganggap preferensi pribadi AI sebagai aturan wajib.

## 7. Wajib Membaca Source Code Flutter dan Dart SDK

Jangan hanya mengandalkan pengetahuan internal AI atau contoh kode yang pernah dipelajari.

**Periksa source code SDK yang benar-benar digunakan proyek.**

Tujuannya memastikan penggunaan API sesuai kontrak dan implementasi SDK.

### 7.1. Identifikasi SDK

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

### 7.2. Lokasi source code Flutter SDK

Periksa source code Flutter pada:

```text
<FLUTTER_SDK>/packages/flutter/lib/
```

Untuk implementasi internal framework Flutter:

```text
<FLUTTER_SDK>/packages/flutter/lib/src/
```

### 7.3. Lokasi source code Dart SDK

Periksa source code Dart pada:

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

### 7.4. Source code paket eksternal

Jika perubahan menggunakan API paket eksternal, periksa source code paket yang benar-benar digunakan proyek.

Gunakan informasi resolusi dependensi pada:

`.dart_tool/package_config.json`

Temukan lokasi package root berdasarkan konfigurasi tersebut.

Periksa deklarasi API dan implementasinya pada source paket yang tersedia.

Jangan menjalankan `flutter pub get` hanya untuk mendapatkan source paket.

Jika source paket belum tersedia, laporkan keterbatasannya.

### 7.5. Hal yang wajib diperiksa dari source SDK

Untuk setiap API yang relevan dengan perubahan, periksa:

1. Deklarasi class dan inheritance.
2. Constructor dan parameter yang tersedia.
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
15. Ketentuan penggunaan pada platform tertentu.

Jangan menyimpulkan penggunaan API benar hanya karena kode dapat ditulis atau terlihat benar.

### 7.6. Hubungkan source SDK dengan kode yang berubah

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

## 8. Periksa Dampak Perubahan terhadap Kode di Sekitarnya

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

## 9. Klasifikasi Temuan

Pisahkan hasil pemeriksaan menjadi empat kategori.

### A. Pelanggaran Aturan

Kode tidak sesuai dengan ketentuan yang benar-benar tertulis dalam `AGENTS.md` atau aturan proyek.

Setiap pelanggaran wajib menunjukkan:

1. Path kode yang bermasalah.
2. Nomor baris kode yang bermasalah.
3. Nama aturan yang dilanggar.
4. Path file tempat aturan tersebut ditulis.
5. Nomor baris aturan tersebut.
6. Isi aturan yang dilanggar.
7. Penjelasan hubungan antara kode dan aturan.

### B. Ketidaksesuaian SDK

Penggunaan API tidak sesuai dengan kontrak source Flutter, Dart, atau paket yang digunakan.

Setiap temuan harus menunjukkan:

- Path kode proyek dan nomor baris.
- API yang diperiksa.
- Path source SDK dan nomor baris apabila tersedia.
- Kontrak API yang relevan.
- Penjelasan ketidaksesuaian.
- Saran perbaikan.

### C. Potensi Bug

Perubahan berpotensi menyebabkan kesalahan runtime, kerusakan data, hasil yang tidak sesuai, atau masalah performa.

Setiap temuan harus mempunyai bukti, lokasi kode, kondisi penyebab, dampak, dan saran perbaikan.

### D. Rekomendasi Perbaikan

Perubahan tidak selalu salah, tetapi terdapat pendekatan yang lebih baik berdasarkan standar proyek atau source SDK.

Jangan menyebut rekomendasi sebagai pelanggaran aturan apabila tidak ada ketentuan eksplisit yang dilanggar.

Apabila tidak ditemukan aturan yang berkaitan, nyatakan:

**Aturan eksplisit yang dilanggar: Tidak ditemukan.**

Jangan membuat aturan baru berdasarkan asumsi pribadi.

### 9.1. Tingkat prioritas

Gunakan kategori:

- **Critical:** berpotensi menyebabkan kerusakan data serius, masalah keamanan, atau kegagalan aplikasi yang sangat parah.
- **High:** berpotensi menyebabkan aplikasi crash, data tidak konsisten, atau fitur utama gagal.
- **Medium:** masalah implementasi yang dapat menimbulkan bug atau mengurangi kualitas secara signifikan.
- **Low:** masalah minor seperti konsistensi penulisan atau peningkatan maintainability.
- **Info:** catatan teknis atau rekomendasi yang tidak menunjukkan kesalahan.

Jangan memberikan prioritas secara berlebihan.

## 10. WAJIB Menyertakan Path dan Nomor Baris Kode yang Bermasalah

**Setiap temuan yang menunjukkan masalah pada kode wajib menyertakan path file dan nomor baris yang tepat.**

Gunakan format:

```text
lib/fitur/pengguna/provider.dart:42
```

Jika masalah mencakup beberapa baris:

```text
lib/fitur/pengguna/provider.dart:42-48
```

Ketentuan:

1. Gunakan path relatif terhadap root proyek.
2. Cantumkan nomor baris secara tepat.
3. Jangan hanya menyebut nama file.
4. Jangan memberikan nomor baris perkiraan.
5. Periksa kembali lokasi sebelum menyusun laporan.
6. Jika ada beberapa lokasi bermasalah, cantumkan seluruhnya.

**Jangan membuat link Markdown, link GitHub, URL, atau tautan editor. Pengguna hanya menginginkan path dan nomor baris.**

### 10.1. Sesuaikan nomor baris dengan status perubahan

Perhatikan bahwa staged dan unstaged dapat memiliki isi berbeda.

- Untuk unstaged, gunakan nomor baris dari working tree.
- Untuk staged, gunakan nomor baris dari isi staging.
- Untuk file yang memiliki perubahan staged dan unstaged, gunakan nomor baris sesuai versi yang sedang diperiksa.
- Untuk file untracked, gunakan nomor baris dari isi file.
- Untuk kode yang dihapus, gunakan nomor baris lama berdasarkan diff dan jelaskan bahwa kode tersebut telah dihapus.

Untuk staged, apabila perlu, baca isi staging dengan:

```bash
git show :path/file.dart | nl -ba
```

Untuk working tree, gunakan:

```bash
nl -ba path/file.dart
```

Jangan mencampur nomor baris dari versi kode yang berbeda.

Jika nomor baris tidak dapat dipastikan, jelaskan keterbatasannya. Jangan mengarang nomor baris.

## 11. WAJIB Menunjukkan Path dan Baris Aturan yang Dilanggar

**Setiap temuan yang dikategorikan sebagai pelanggaran aturan wajib menunjukkan lokasi aturan yang dilanggar, bukan hanya lokasi kode yang bermasalah.**

Jangan hanya menulis:

- Tidak sesuai AGENTS.md.
- Melanggar aturan proyek.
- Tidak mengikuti standar.
- Tidak sesuai ketentuan global.

Pernyataan seperti itu tidak cukup tanpa bukti lokasi aturan yang sebenarnya.

### 11.1. Format lokasi aturan

Gunakan format berikut:

```text
AGENTS.md:125-129
```

Atau:

```text
.agents/rules/global/aturan_bersama.md:18-23
```

Atau:

```text
.agents/rules/proyek/aturan_khusus.md:42-47
```

Sesuaikan dengan lokasi aturan yang benar-benar dilanggar.

Jika aturan berada pada `AGENTS.md`, gunakan path dan nomor baris dari file tersebut.

Jika aturan berasal dari file aturan global atau khusus, gunakan path file sumber aturan tersebut.

Jika aturan muncul dalam `AGENTS.md` sekaligus berasal dari file aturan lain, cantumkan kedua lokasi apabila keduanya relevan.

### 11.2. Cara menentukan nomor baris aturan

Baca file aturan secara lengkap dan hitung nomor baris yang sebenarnya.

Gunakan:

```bash
nl -ba AGENTS.md
```

Untuk aturan khusus:

```bash
nl -ba .agents/rules/proyek/aturan_khusus.md
```

Untuk aturan global:

```bash
nl -ba .agents/rules/global/aturan_bersama.md
```

Jika aturan berasal dari file lainnya, gunakan path file tersebut.

Ketentuan:

1. Jangan menebak nomor baris.
2. Jangan menggunakan nomor baris dari file yang berbeda.
3. Jangan mengutip aturan yang sebenarnya tidak ada.
4. Pastikan rentang baris mencakup ketentuan yang dilanggar.
5. Jika satu pelanggaran bertentangan dengan beberapa aturan, tampilkan semua aturan yang relevan.
6. Jangan menganggap nama judul aturan sebagai pengganti bukti isi aturan.

**Nomor baris harus menunjuk langsung pada ketentuan yang menjadi dasar penilaian.**

### 11.3. Wajib mengutip isi aturan

Selain path dan baris, tampilkan isi aturan yang benar-benar dilanggar.

Contoh:

**Aturan yang dilanggar:**

`.agents/rules/global/aturan_bersama.md:18-22`

**Isi aturan:**

> Setelah menggunakan `await` dalam lifecycle widget, pastikan widget masih mounted sebelum melakukan pembaruan UI.

**Lokasi kode bermasalah:**

`lib/fitur/pengguna/page/pengguna_page.dart:84-87`

**Penjelasan:**

Kode melakukan pembaruan UI setelah operasi asynchronous tanpa memastikan widget masih mounted. Hal ini bertentangan dengan ketentuan yang tercantum pada aturan tersebut.

Pastikan contoh di atas hanya digunakan sebagai format laporan. Isi aturan dan nomor baris sebenarnya harus diambil dari file proyek.

### 11.4. Jangan mengarang pelanggaran aturan

Jika menemukan masalah teknis tetapi tidak ada aturan tertulis yang secara langsung mengaturnya:

- Jangan mengklaim bahwa kode melanggar AGENTS.md.
- Jangan menciptakan aturan yang sebenarnya tidak ada.
- Klasifikasikan sebagai potensi bug atau rekomendasi.
- Jelaskan bahwa tidak ditemukan aturan eksplisit yang dilanggar.

**Pelanggaran aturan harus berdasarkan bukti ketentuan tertulis, bukan sekadar penilaian pribadi AI.**

## 12. Saran Perbaikan Wajib Disertakan

Jika menemukan ketidaksesuaian, berikan saran perbaikan secara spesifik.

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

**Alasan:**

Implementasi saat ini mengasumsikan bahwa nilai tidak mungkin null. Jika nilai ternyata null, kode dapat menyebabkan runtime error.

Pastikan contoh perbaikan sesuai dengan konteks implementasi, aturan proyek, dan kontrak SDK.

**Contoh kode perbaikan hanya untuk ditampilkan kepada pengguna. Jangan menerapkannya ke file proyek.**

## 13. Jika Tidak Menemukan Masalah

Jika perubahan sudah sesuai:

- Jangan mengada-ada masalah.
- Jangan mencari kesalahan hanya untuk membuat laporan terlihat panjang.
- Jangan menyarankan perubahan yang tidak memberikan manfaat nyata.
- Jelaskan bahwa perubahan telah diperiksa dan tidak ditemukan ketidaksesuaian berdasarkan pemeriksaan yang dilakukan.

Jika ada bagian yang tidak dapat diverifikasi karena source SDK tidak tersedia, nyatakan secara jujur.

Jangan menyatakan seluruh kode sudah benar apabila masih ada bagian penting yang belum diperiksa.

## 14. Format Laporan Akhir

Susun laporan menggunakan struktur berikut.

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

## C. Temuan Pelanggaran Aturan

Untuk setiap temuan, gunakan format berikut.

### [Prioritas] Judul Pelanggaran

**1. Lokasi kode bermasalah:**

`lib/path/file.dart:42-45`

**2. Status perubahan:**

Staged / Unstaged / Untracked

**3. Aturan yang dilanggar:**

`.agents/rules/global/aturan_bersama.md:18-22`

**4. Isi aturan:**

Kutip ketentuan yang benar-benar tertulis di lokasi tersebut.

**5. Kode saat ini:**

```dart
// Tampilkan potongan kode yang bermasalah.
```

**6. Alasan pelanggaran:**

Jelaskan secara spesifik mengapa kode bertentangan dengan ketentuan tersebut.

**7. Dampak:**

Jelaskan risiko yang ditimbulkan.

**8. Saran perbaikan:**

Berikan pendekatan yang tepat beserta contoh kode apabila diperlukan.

Jika terdapat beberapa aturan yang dilanggar, tampilkan seluruh path dan nomor baris aturannya.

## D. Temuan Ketidaksesuaian SDK

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

Jika ada, cantumkan path dan nomor baris aturan yang relevan.

**Saran perbaikan:**

Berikan pendekatan yang sesuai dengan API dan versi SDK proyek.

## E. Potensi Bug

Untuk setiap potensi bug, cantumkan:

- Judul masalah dan prioritas.
- Path kode dan nomor baris.
- Status perubahan.
- Penjelasan kondisi penyebab.
- Dampak yang mungkin terjadi.
- Aturan terkait beserta path dan nomor baris jika ada.
- Saran perbaikan.

Jika tidak ada aturan eksplisit yang dilanggar, nyatakan demikian.

## F. Rekomendasi Perbaikan

Pisahkan rekomendasi yang sifatnya peningkatan kualitas tetapi bukan pelanggaran aturan.

Setiap rekomendasi yang menunjuk kode tertentu wajib mencantumkan:

- Path kode dan nomor baris.
- Alasan rekomendasi.
- Pendekatan yang disarankan.

Jangan memaksakan rekomendasi sebagai pelanggaran aturan.

## G. Bagian yang Belum Dapat Diverifikasi

Cantumkan apabila terdapat:

- Source SDK yang tidak tersedia.
- Source paket yang tidak ditemukan.
- Kontrak API yang belum dapat dipastikan.
- Konteks kode yang belum cukup.
- Nomor baris yang tidak dapat dipastikan.
- Aturan yang tidak dapat ditemukan sumbernya.
- Konflik antaraturan yang belum dapat diselesaikan.

Jelaskan alasan dan dampaknya terhadap kesimpulan audit.

## H. Kesimpulan

Gunakan salah satu status berikut:

- **Tidak ditemukan masalah:** tidak ada ketidaksesuaian yang ditemukan dari pemeriksaan yang berhasil dilakukan.
- **Ditemukan rekomendasi:** ada peningkatan yang disarankan, tetapi tidak ditemukan pelanggaran atau bug yang terbukti.
- **Perlu perhatian:** ditemukan pelanggaran aturan, potensi bug, atau ketidaksesuaian yang perlu dipertimbangkan sebelum commit.
- **Belum dapat diverifikasi sepenuhnya:** terdapat keterbatasan pemeriksaan yang memengaruhi kesimpulan.

Jangan menyuruh pengguna langsung melakukan commit.

Jangan memperbaiki kode.

Akhiri dengan menegaskan bahwa seluruh temuan dan saran merupakan bahan pertimbangan pengguna.

## 15. Pemeriksaan Akhir Sebelum Menyampaikan Laporan

Pastikan:

- [ ] `AGENTS.md` telah dibaca seluruhnya.
- [ ] Semua aturan yang relevan telah dibaca.
- [ ] Staged changes Dart sudah diperiksa.
- [ ] Unstaged changes Dart sudah diperiksa.
- [ ] Untracked Dart files sudah diperiksa.
- [ ] Perubahan pada file yang sama sudah dibedakan berdasarkan statusnya.
- [ ] Seluruh perubahan sudah dievaluasi terhadap aturan proyek.
- [ ] Source SDK yang relevan sudah diperiksa.
- [ ] Dampak perubahan terhadap kode terkait sudah dievaluasi.
- [ ] Setiap pelanggaran mempunyai bukti.
- [ ] Setiap pelanggaran mempunyai path dan nomor baris kode.
- [ ] Setiap pelanggaran mempunyai path dan nomor baris aturan.
- [ ] Isi aturan yang dilanggar sudah dikutip.
- [ ] Hubungan antara kode dan aturan sudah dijelaskan.
- [ ] Setiap ketidaksesuaian memiliki saran perbaikan.
- [ ] Rekomendasi dipisahkan dari pelanggaran.
- [ ] Keterbatasan pemeriksaan sudah dilaporkan.
- [ ] Tidak ada file yang diubah.
- [ ] Tidak ada staging area atau kondisi Git yang diubah.

Jika ada bagian yang belum selesai, jangan menyatakan audit telah selesai sepenuhnya.

---

# PRINSIP UTAMA

**AUDIT, BUKAN IMPLEMENTASI.**

Anda bertugas menjadi pemeriksa independen sebelum perubahan kode di-commit.

Baca seluruh perubahan Dart, cocokkan dengan AGENTS.md dan aturan proyek, serta periksa source SDK yang sebenarnya.

Setiap pelanggaran harus menunjukkan dua lokasi:

1. Lokasi kode yang bermasalah.
2. Lokasi aturan yang dilanggar.

Keduanya wajib mencantumkan path dan nomor baris yang tepat.

Jangan mengarang aturan atau nomor baris.

Jika tidak ada aturan tertulis yang dilanggar, klasifikasikan temuan sebagai potensi bug atau rekomendasi, bukan pelanggaran aturan.

Berikan saran perbaikan yang konkret, tetapi jangan menerapkannya.

**Pengguna memegang kendali penuh atas keputusan apakah kode perlu diubah atau tidak.**
