# Aturan Proyek

**Path:** `.agents/rules/proyek/aturan_proyek.md`

## Tujuan

Folder `.agents/rules/proyek/` digunakan untuk menyimpan seluruh aturan khusus yang hanya berlaku pada proyek ini.

File ini merupakan ringkasan yang menjelaskan alasan keberadaan folder tersebut, fungsi aturan di dalamnya, serta ketentuan penerapannya.

## Aturan

### 1. Kewajiban Mematuhi Aturan Proyek

1. AI wajib membaca, memahami, dan mematuhi seluruh file aturan yang terdapat di dalam folder `.agents/rules/proyek/`.
2. Seluruh aturan dalam folder tersebut wajib diterapkan pada setiap pekerjaan yang dilakukan di proyek ini.
3. AI tidak boleh mengabaikan, menghapus, mengubah, atau mengesampingkan aturan proyek atas inisiatif sendiri.

### 2. Prioritas Aturan Global dan Aturan Proyek

1. Jika terdapat konflik antara aturan dalam `.agents/rules/global/` dan `.agents/rules/proyek/`, aturan dalam folder `.agents/rules/proyek/` wajib diprioritaskan.
2. Seluruh aturan dalam folder `.agents/rules/proyek/` wajib dipertahankan dan dipatuhi, termasuk aturan yang bertentangan dengan aturan global.
3. Aturan global yang tidak bertentangan dengan aturan proyek tetap berlaku dan wajib dipatuhi.
4. Jika ditemukan konflik antara aturan global dan aturan proyek, AI wajib mengidentifikasi dan melaporkannya. Jangan mengubah atau mengabaikan aturan secara sepihak.

### 3. Cakupan Penerapan

1. Aturan dalam folder `.agents/rules/proyek/` hanya berlaku untuk proyek ini.
2. Aturan tersebut tidak otomatis menjadi ketentuan bagi proyek Flutter atau Dart lainnya.

## Aturan Khusus Proyek

### 1. Target Platform

1. Proyek ini dikembangkan sebagai aplikasi Android (APK) untuk tahap awal.
2. Seluruh kode, implementasi, konfigurasi, dan penggunaan paket wajib kompatibel dengan Android.
3. Jangan menerapkan implementasi yang tidak didukung atau tidak kompatibel dengan Android.

### 2. Keterbatasan Pengujian

1. Karena keterbatasan perangkat keras, saat ini pengujian aplikasi belum dapat dilakukan menggunakan emulator Android.
2. Pengujian hanya dapat dilakukan melalui Web Server.
3. AI wajib mempertimbangkan keterbatasan tersebut ketika menyusun implementasi, menjalankan pengujian, dan memverifikasi hasil pekerjaan.
4. Ketidakmampuan menjalankan emulator bukan alasan untuk mengabaikan kompatibilitas Android.
5. Pengujian melalui Web Server tidak boleh dianggap sebagai bukti bahwa seluruh implementasi sudah berjalan dengan benar di Android.

## Perbedaan Aturan Global dan Aturan Proyek

- **`.agents/rules/global/`**: berisi aturan umum yang berlaku untuk seluruh proyek Flutter dan Dart.
- **`.agents/rules/proyek/`**: berisi aturan khusus yang hanya berlaku untuk proyek ini dan wajib diprioritaskan apabila terjadi konflik dengan aturan global.
