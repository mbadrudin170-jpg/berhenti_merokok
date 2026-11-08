# Kelompok 1

## File terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

# Kelompok 2

## File terdampak

- [pengaturan_screen.dart](lib/fitur/pengaturan/screens/pengaturan_screen.dart)
- [main.dart](lib/main.dart)
- [notifikasi_service.dart](lib/shared/notifikasi/notifikasi_service.dart)
- [notifikasi_service_test.dart](test/notifikasi_service_test.dart)

## Tinggi

## Sedang

#### Task 1

- Status: Selesai
- Masalah: Audit pengujian notifikasi (2026-11-08) menunjukkan file pengujian preferensi `test/notifikasi_service_test.dart` telah tersedia dan lulus (`flutter test test/notifikasi_service_test.dart`: 7 pengujian lulus). Cakupan yang sudah teruji: nilai default aktif/jam/menit, penyimpanan `setAktif` dan `setWaktu`, serta persistensi ke `SharedPreferences`. Namun skenario yang lebih luas (izin diberikan/ditolak, aktivasi/nonaktif pengingat, perubahan waktu, kegagalan penjadwalan dan penyimpanan preferensi, penjadwalan ulang saat aplikasi dibuka, platform yang tidak mendukung notifikasi terjadwal, pemulihan jadwal setelah restart) belum tercakup. `NotifikasiService` menggunakan anggota statis dan bergantung pada plugin platform (`FlutterLocalNotificationsPlugin`) serta `SharedPreferences`, sehingga memerlukan mock/fake pada batas plugin/penyimpanan sebelum dapat diuji secara bermakna. `flutter analyze` bersih (No issues found).
- Solusi: Evaluasi pengujian untuk izin diberikan/ditolak, mengaktifkan/menonaktifkan pengingat, mengubah waktu, kegagalan penjadwalan dan penyimpanan preferensi, penjadwalan ulang saat aplikasi dibuka, platform yang tidak mendukung notifikasi terjadwal, dan pemulihan jadwal setelah perangkat restart. Gunakan mock atau fake pada batas plugin dan penyimpanan. Jangan menyimpulkan seluruh proyek belum memiliki pengujian hanya karena commit ini tidak menyertakan file pengujian.
- Aturan dilanggar: [aturan_testing.md](.agents/rules/global/aturan_testing.md)
- File bermasalah: [notifikasi_service.dart](lib/shared/notifikasi/notifikasi_service.dart), [pengaturan_screen.dart](lib/fitur/pengaturan/screens/pengaturan_screen.dart)
- Prompt: buatkan file test nya

## Rendah

---

# Kelompok 3

## File terdampak

- [home.dart](lib/home.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

Tidak ada temuan.
