---
name: zona-waktu-perangkat-pengingat
description: Panduan zona waktu perangkat untuk pengingat harian - deteksi via flutter_timezone, inisialisasi tz database, fallback Asia/Jakarta, handle error setiap tahap.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "d42422ba65a0f3c90b46a0736a197af572b62c33"
  model: "kilo-auto/free"
---

# Zona Waktu Perangkat untuk Pengingat Harian

Pengingat harian wajib ikuti zona waktu perangkat, bukan Asia/Jakarta permanen. Deteksi via flutter_timezone, fallback Asia/Jakarta.

## Aturan

1. Pengingat harian wajib mengikuti zona waktu lokal perangkat, bukan `Asia/Jakarta` permanen.
2. Inisialisasi database zona waktu via `tz.initializeTimeZones()` sebelum pencarian/penetapan lokasi.
3. Gunakan `FlutterTimezone.getLocalTimezone()` untuk dapatkan zona perangkat.
4. Gunakan properti `identifier` dari `TimezoneInfo` untuk `tz.getLocation(identifier)`.
5. Setelah lokasi ditemukan, set `tz.setLocalLocation(...)` sebelum buat/jadwalkan `TZDateTime`.
6. Jangan gunakan singkatan WIB/WITA/WIT sebagai identifier tanpa validasi. Utamakan identifier dari package.
7. `Asia/Jakarta` hanya fallback jika deteksi/pencarian gagal.
8. Handle error setiap tahap: inisialisasi DB, deteksi perangkat, pencarian lokasi, set lokasi, fallback.
9. Log identifier yang terdeteksi. Fallback → log warning/error.
10. Pastikan zona waktu berhasil diset sebelum lanjut penjadwalan.
11. Fallback Asia/Jakarta gagal → handle sebagai kegagalan inisialisasi.
12. Gunakan exception handling sesuai API package, jangan catch Exception terlalu luas.

## Sumber Evaluasi

- Commit: `19eece75351cd8deee5a2a01cf65464a8e2a1bc1`, `d42422ba65a0f3c90b46a0736a197af572b62c33`
- File: `pubspec.yaml`, `pubspec.lock`, `lib/shared/notifikasi/notifikasi_service.dart`, `saran.md`