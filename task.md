# Kelompok 1

## File terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

#### Task 1

---

# Kelompok 2

## File terdampak

- [pengaturan_screen.dart](lib/fitur/pengaturan/screens/pengaturan_screen.dart)
- [main.dart](lib/main.dart)
- [notifikasi_service.dart](lib/shared/notifikasi/notifikasi_service.dart)

## Tinggi

## Sedang

#### Task 1

- Status: Selesai
- Masalah: Commit menambahkan layanan notifikasi dan interaksi pengaturan, tetapi tidak terlihat file pengujian baru dalam perubahan commit tersebut. `test/` hanya berisi `widget_test.dart`; tidak ada pengujian untuk notifikasi. Implementasi pengujian ditangguhkan karena `NotifikasiService` menggunakan anggota statis dan bergantung pada plugin platform (`FlutterLocalNotificationsPlugin`) serta `SharedPreferences`, sehingga memerlukan refactor dependency injection dan mock/fake pada batas plugin/penyimpanan sebelum dapat diuji secara bermakna.
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
