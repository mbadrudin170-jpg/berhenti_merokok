---
name: flutter-local-notifications-22-3-3
description: Panduan standar flutter_local_notifications v22.3.3 - cek platform, receiver Android, core library desugaring, izin runtime, payload validation, lifecycle tap, exception khusus.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "774431dbf61bb330d548785e8d47597c5bdcd123"
  model: "kilo-auto/free"
---

# Standar flutter_local_notifications v22.3.3 pada Notifikasi Harian

Aturan khusus untuk plugin versi 22.3.3: cek platform, receiver Android, core library desugaring, izin runtime, payload, lifecycle tap.

## Aturan

1. Periksa dukungan fitur berdasarkan platform dan versi plugin sebelum menggunakan API penjadwalan.
2. Jangan gunakan penjadwalan berulang (`matchDateTimeComponents`, `zonedSchedule` dengan pengulangan) pada Web, Linux, Windows. macOS didukung via `zonedSchedule`.
3. Lengkapi receiver dan izin Android: `RECEIVE_BOOT_COMPLETED`, `ScheduledNotificationReceiver`, `ScheduledNotificationBootReceiver`. Gunakan `AndroidScheduleMode.inexactAllowWhileIdle`.
4. Aktifkan core library desugaring: `isCoreLibraryDesugaringEnabled = true`, dependency `desugar_jdk_libs:2.1.4`, `compileSdk` minimal 35, AGP minimal 8.11.1.
5. Jangan minta izin notifikasi otomatis saat startup (termasuk iOS Darwin default). Minta saat pengguna aktifkan fitur.
6. Periksa hasil izin sebelum simpan status aktif. Periksa kembali izin saat buka aplikasi.
7. Rollback state, tampilkan feedback, jangan simpan status aktif jika penjadwalan gagal.
8. Tangani gagal penjadwalan ulang saat buka aplikasi: log error, jangan biarkan unhandled.
9. Pisahkan ID notifikasi uji coba dari ID pengingat utama.
10. Handle tap notifikasi 3 kondisi lifecycle: foreground, background, terminated. Gunakan `getNotificationAppLaunchDetails()` untuk terminated.
11. Validasi payload: parse `kategori` dan `id`, hanya proses kategori dikenal, log warning jika tidak valid.
12. Izin dicabut → cancel jadwal, update preferensi, pastikan tidak ada jadwal tertinggal. Aktifkan kembali → minta izin dulu.
13. Konsistensi waktu: simpan nilai lama, terapkan baru setelah berhasil, gagal → pulihkan lama.
14. unawaited navigasi/loading wajib catchError dengan L.e.
15. Gunakan exception khusus (class implements Exception), deteksi via `is`, bukan string matching.

## Sumber Evaluasi

- Commit: `774431dbf61bb330d548785e8d47597c5bdcd123`, `0cb0e52f48f6d6f95f2bfc9e8b82a092bb5f9e4f`
- File: `lib/shared/notifikasi/notifikasi_service.dart`, `lib/main.dart`, `lib/app.dart`, `lib/fitur/pengaturan/screens/pengaturan_screen.dart`, `android/app/src/main/AndroidManifest.xml`, `saran.md`