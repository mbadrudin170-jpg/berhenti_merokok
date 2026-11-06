# MASALAH

1. saya ingin fokus ke Android dulu.
2. di dalam notifikasi harus disertakan logo apk saya.
3. agar notifikasi bisa ditekan dan diarahkan ke halaman tertentu sesuai kategori notifikasi yang ditampilkan.
4. untuk sekarang saya masih hanya ingin menggunakan paket flutter_local_notifications.
5. setiap notifikasi harus muncul karena terkadang notifikasi baru suka tidak muncul jika notifikasi lama masih ada di notch bar HP user.
6. saya ingin ketika user membuka apk kita cek dulu notifikasi takutnya ada, tapi jangan blokir ui.
7. saat user menambahkan KM motornya yang terbaru kita cek notifikasi, apakah ada jadwal service yang KM nya sudah sama dengan KM terbaru.
8. ketika jadwal service tanggal terakhir service ditambah bulan, dan bertepatan dengan tanggal sekarang maka tampilkan notifikasi ke user.

# SOLUSI

<!-- semua masalah diatas harus diberikan solusi -->

## Masalah 1: Fokus ke Android dulu

### Solusi:

- Konfigurasi Android-specific: tambahkan `RECEIVE_BOOT_COMPLETED` permission, `ScheduledNotificationReceiver`, `ScheduledNotificationBootReceiver`, dan `ActionBroadcastReceiver` di `AndroidManifest.xml` untuk mendukung scheduled notification dan notification tap action.
- Aktifkan desugaring dan multiDex di `android/app/build.gradle.kts` (`coreLibraryDesugaringEnabled true`, `multiDexEnabled true`, dependency `coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:2.1.4'`).
- Pastikan `compileSdk` minimal 35 dan AGP minimal 8.11.1 (sudah terpenuhi: AGP 9.1.0, Java 17).
- Inisialisasi plugin prioritaskan `AndroidInitializationSettings` terlebih dahulu.

## Masalah 2: Di dalam notifikasi harus sertakan logo APK

### Solusi:

- Buat drawable resource custom untuk icon notifikasi di `android/app/src/main/res/drawable/` (contoh: `ic_notifikasi.png`) sebagai ganti `@mipmap/ic_launcher` bawaan Flutter.
- Ganti `AndroidInitializationSettings('@mipmap/ic_launcher')` menjadi `AndroidInitializationSettings('ic_notifikasi')` atau atur properti `icon` di `AndroidNotificationDetails`.
- Simpan file logo asli di `android/app/src/main/res/drawable/` dengan nama yang sesuai.

## Masalah 3: Notifikasi bisa ditekan dan diarahkan ke halaman tertentu sesuai kategori notifikasi yang ditampilkan

### Solusi:

- Terapkan `onDidReceiveNotificationResponse` callback di `NotifikasiService.inisialisasi()` untuk menangkap saat user menekan notifikasi.
- Parse `NotificationResponse.payload` untuk menentukan kategori notifikasi.
- Navigasi ke halaman yang sesuai berdasarkan kategori menggunakan `Navigator` dengan `GlobalKey<NavigatorState>` atau navigation service.
- Tambahkan `@pragma('vm:entry-point')` pada callback jika perlu dijalankan di background isolate.

## Masalah 4: Hanya menggunakan paket flutter_local_notifications

### Solusi:

- Batasi penggunaan paket notifikasi hanya pada `flutter_local_notifications`, jangan menambahkan paket notifikasi pihak lain yang redundan.
- Konfigurasi seluruh inisialisasi, jadwal, dan tampilan notifikasi melalui `flutter_local_notifications` agar konsisten dan tidak bentrok.

## Masalah 5: Notifikasi baru tidak muncul jika notifikasi lama masih ada di notch bar

### Solusi:

- Sebelum menampilkan notifikasi baru, panggil `flutterLocalNotificationsPlugin.cancelAll()` atau `cancel(idNotifikasiLama)` untuk menghapus notifikasi lama yang masih ada di notification bar/notch hp user.
- Atau gunakan `id` notifikasi yang sama saat menampilkan notifikasi baru sehingga notifikasi lama diganti (replace) oleh notifikasi baru dengan id yang sama.
- Pastikan setiap kategori notifikasi menggunakan id yang unik dan konsisten agar notifikasi baru dapat menggantikan yang lama dengan benar.

## Masalah 6: Cek notifikasi saat aplikasi dibuka tanpa blokir UI

### Solusi:

- Saat aplikasi dibuka (main/initState), panggil method cek notifikasi secara asinkron (tanpa await yang memblokir UI) untuk memeriksa notifikasi yang mungkin tertunda.
- Gunakan `flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails()` atau `getActiveNotifications()` untuk mengecek notifikasi aktif/tertunda.
- Proses berjalan di background; UI tetap responsif (tidak await blocking).
- Jika ada notifikasi yang memerlukan navigasi, tangani via payload setelah frame pertama render.

## Masalah 7: Cek notifikasi saat user menambahkan KM terbaru

### Solusi:

- Saat user menyimpan data KM terbaru (`KmPage._simpanForm` / `KmNotifier.tambah`), panggil pengecekan notifikasi secara asinkron (fire-and-forget) agar tidak memblokir UI.
- Ambil daftar jadwal service untuk kendaraan terpilih, lalu bandingkan KM terbaru dengan KM target/terakhir service masing-masing jadwal.
- Jika ada jadwal service yang sisa KM-nya <= 0 (KM terbaru sudah sama atau melewati KM target), tampilkan notifikasi via `NotifikasiService.tampilkanNotifikasi()` dengan kategori `jadwal_service` (atau `km`) dan payload yang sesuai.
- Gunakan id notifikasi yang konsisten (misalnya id jadwal service) sehingga notifikasi baru menggantikan yang lama, dan hindari notifikasi ganda dengan memeriksa status aktif notifikasi service.
- Tampilkan notifikasi hanya jika `NotifikasiService.aktif` true (sudah dihandle di `tampilkanNotifikasi`).

## Masalah 8: Notifikasi ketika jadwal service tanggal terakhir service ditambah bulan bertepatan dengan tanggal sekarang

### Solusi:

- Saat data jadwal service dimuat (`JadwalServiceNotifier._muatData`), jalankan pengecekan notifikasi secara asinkron (`_cekDanNotifikasi`).
- Untuk setiap jadwal service, hitung sisa bulan berdasarkan `tanggalTerakhirService` ditambah `interval bulan` (`jadwal.bulan`) dibandingkan dengan tanggal sekarang.
- Jika tanggal sekarang sudah sama atau melewati tanggal target (tanggal terakhir service + interval bulan), maka `sisaBulan <= 0`, tampilkan notifikasi via `NotifikasiService.tampilkanNotifikasi()` dengan kategori `jadwal_service` dan id notifikasi konsisten (id jadwal service) agar notifikasi baru menggantikan yang lama.
- Proses berjalan fire-and-forget saat pemuatan data, tidak memblokir UI; notifikasi hanya ditampilkan jika `NotifikasiService.aktif` true.

## Fitur yang Harus Dibuat

### Fitur 1: Inisialisasi plugin notifikasi Android

- Siapkan `NotifikasiService.inisialisasi()` dengan `AndroidInitializationSettings` dan `onDidReceiveNotificationResponse`.
- Konfigurasi AndroidManifest.xml dan build.gradle.kts untuk Android.

### Fitur 2: Tampilkan notifikasi dengan logo aplikasi

- `NotifikasiService.tampilkanNotifikasi()` menggunakan `AndroidNotificationDetails` dengan `icon` yang mengarah ke drawable custom.
- Notifikasi menyertakan `payload` yang berisi kategori/notifikasi ID.

### Fitur 3: Navigasi saat notifikasi ditekan

- `onDidReceiveNotificationResponse` membaca `payload` dan memicu navigasi ke halaman tujuan sesuai kategori.
- Menyediakan `GlobalKey<NavigatorState>` agar navigasi dapat dipanggil dari static method `NotifikasiService`.

### Fitur 4: Cek Notifikasi Saat App Dibuka (Non-blocking)

- Cek notifikasi tertunda/aktif saat aplikasi dibuka secara asinkron tanpa memblokir UI.
- Tangani navigasi berdasarkan payload notifikasi setelah UI siap.

### Fitur 5: Cek Notifikasi Saat Tambah KM

- Setelah user menambahkan KM terbaru, cek secara asinkron apakah ada jadwal service yang KM-nya sudah sama/melewati KM terbaru.
- Jika ada, tampilkan notifikasi peringatan service via `NotifikasiService` dengan kategori yang sesuai.
- Proses berjalan di background tanpa memblokir UI.

### Fitur 6: Batasi Penggunaan Paket Notifikasi Hanya flutter_local_notifications

- Masalah yang diatasi: untuk sekarang saya masih hanya ingin menggunakan paket flutter_local_notifications.
- Solusi: Batasi penggunaan paket notifikasi hanya pada `flutter_local_notifications`, jangan menambahkan paket notifikasi pihak lain yang redundan. Konfigurasi seluruh inisialisasi, jadwal, dan tampilan notifikasi melalui `flutter_local_notifications` agar konsisten dan tidak bentrok.

### Fitur 7: Penggantian Notifikasi Lama di Notch Bar

- Masalah yang diatasi: setiap notifikasi harus muncul karena terkadang notifikasi baru suka tidak muncul jika notifikasi lama masih ada di notch bar HP user.
- Solusi: Sebelum menampilkan notifikasi baru, panggil `cancel(idNotifikasiLama)` (atau gunakan `id` notifikasi yang sama) sehingga notifikasi lama diganti (replace) oleh notifikasi baru. Pastikan setiap kategori notifikasi menggunakan id yang unik dan konsisten.

### Fitur 8: Notifikasi Ketika Tanggal Service (Terakhir + Interval Bulan) Bertepatan dengan Hari Ini

- Masalah yang diatasi: ketika jadwal service tanggal terakhir service ditambah bulan, dan bertepatan dengan tanggal sekarang maka tampilkan notifikasi ke user.
- Solusi: Saat data jadwal service dimuat, cek secara asinkron setiap jadwal service; jika tanggal sekarang sudah sama atau melewati tanggal terakhir service + interval bulan (`sisaBulan <= 0`), tampilkan notifikasi peringatan service via `NotifikasiService` dengan kategori `jadwal_service` dan id konsisten (id jadwal service). Proses tidak memblokir UI dan hanya berjalan jika notifikasi aktif.
