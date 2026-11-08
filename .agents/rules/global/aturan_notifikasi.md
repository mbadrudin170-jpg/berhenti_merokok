# Aturan Notifikasi Lokal

## 1. Library

- Gunakan package `flutter_local_notifications` untuk semua notifikasi lokal.
- Sebelum implementasi, baca dokumentasi versi yang terinstall di `pubspec.yaml` (cek README/CHANGELOG package) agar API sesuai dengan versi tersebut. Jangan mengasumsikan versi tertentu.

## 2. Inisialisasi

- Inisialisasi plugin di `main()` **sebelum** `runApp()`.
- Lakukan setup platform-specific (Android & iOS) saat inisialisasi:
  - Android: `AndroidInitializationSettings` dengan icon aplikasi.
  - iOS/macOS: `DarwinInitializationSettings` dengan permission request.
- Set `onDidReceiveNotificationResponse` untuk menangani tap notifikasi dan navigasi via payload.

## 3. Penjadwalan (Scheduling)

- Gunakan package `timezone` (`tz`) untuk semua jadwal notifikasi.
- Panggil `tz.initializeTimeZones()` dan set `tz.setLocalLocation(...)` saat inisialisasi.
- Gunakan `zonedSchedule(...)` (bukan `schedule`) agar timezone konsisten.

## 4. Payload

- Payload **wajib** berisi `kategori` + `id` untuk keperluan navigasi.
- Format payload: JSON string, contoh:
  ```json
  { "kategori": "transaksi", "id": "abc-123" }
  ```
