# Kelompok 1

## File Terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

#### Task 7

- Status: Belum
- Kategori: UI
- Masalah: `lib/fitur/dashboard/screens/dashboard_screen.dart` (method `_buildCardBadge`) menggunakan `Colors.amber` untuk ikon, bukan warna dari tema.
- Solusi: Pertimbangkan `Theme.of(context).colorScheme` (mis. `secondary`/`tertiary`) agar menyesuaikan tema, kecuali amber memang diinginkan tetap.
- Aturan Dilanggar: [optimasi_ui.md:2](.agents/rules/global/optimasi_ui.md#L2)
- File Bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)

---

# Kelompok 2

## File Terdampak

- [pengaturan_screen.dart](lib/fitur/pengaturan/screens/pengaturan_screen.dart)
- [main.dart](lib/main.dart)
- [notifikasi_service.dart](lib/shared/notifikasi/notifikasi_service.dart)

## Tinggi

## Sedang

#### Task 3

- Status: Belum
- Kategori: Bug Runtime
- Masalah: Commit menambahkan layanan notifikasi dan interaksi pengaturan, tetapi tidak terlihat file pengujian baru dalam perubahan commit tersebut. `test/` hanya berisi `widget_test.dart`; tidak ada pengujian untuk notifikasi. Implementasi pengujian ditangguhkan karena `NotifikasiService` menggunakan anggota statis dan bergantung pada plugin platform (`FlutterLocalNotificationsPlugin`) serta `SharedPreferences`, sehingga memerlukan refactor dependency injection dan mock/fake pada batas plugin/penyimpanan sebelum dapat diuji secara bermakna.
- Solusi: Evaluasi pengujian untuk izin diberikan/ditolak, mengaktifkan/menonaktifkan pengingat, mengubah waktu, kegagalan penjadwalan dan penyimpanan preferensi, penjadwalan ulang saat aplikasi dibuka, platform yang tidak mendukung notifikasi terjadwal, dan pemulihan jadwal setelah perangkat restart. Gunakan mock atau fake pada batas plugin dan penyimpanan. Jangan menyimpulkan seluruh proyek belum memiliki pengujian hanya karena commit ini tidak menyertakan file pengujian.
- Aturan Dilanggar: [aturan_testing.md](.agents/rules/global/aturan_testing.md)
- File Bermasalah: [notifikasi_service.dart](lib/shared/notifikasi/notifikasi_service.dart), [pengaturan_screen.dart](lib/fitur/pengaturan/screens/pengaturan_screen.dart)

## Rendah

#### Task 5

- Status: Belum
- Kategori: Bug Runtime
- Masalah: Pada `lib/shared/notifikasi/notifikasi_service.dart` (baris 34), `tz.initializeTimeZones()` dipanggil di luar `try`. Fallback `tz.getLocation('Asia/Jakarta')` pada baris 48 tidak dibungkus `try` secara langsung, dan `catch (e, s)` pada baris 50 hanya menangkap `Exception`, bukan `Error` seperti `ArgumentError` yang mungkin dilempar `FlutterTimezone.getLocalTimezone()`.
- Solusi: Bungkus `tz.initializeTimeZones()` dan fallback `tz.getLocation('Asia/Jakarta')` dalam `try/catch`, serta tangkap `UnsupportedError`/`Error` yang relevan atau validasi hasil sebelum penggunaan.
- Aturan Dilanggar: [aturan_pemanfaatan_sdk_dan_paket.md](.agents/rules/global/aturan_pemanfaatan_sdk_dan_paket.md) (bagian 4.3.C — Penanganan Kesalahan)
- File Bermasalah: [notifikasi_service.dart:33-59](lib/shared/notifikasi/notifikasi_service.dart#L33-L59)

---

# Kelompok 3

## File Terdampak

- [home.dart](lib/home.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status: Belum
- Kategori: UI
- Masalah: `lib/home.dart` membungkus `IndexedStack` (yang berisi layar lengkap dengan `Scaffold`, `SafeArea`, dan `Padding`) dengan `SafeArea` dan `Padding(const EdgeInsets.all(16))`. Hal ini menyebabkan `SafeArea` dan padding tepi layar diterapkan dua kali (di Home dan di tiap layar tab), sehingga konten (termasuk AppBar) mendapat inset ganda dan jarak tepi layar berlebih.
- Solusi: Pilih satu lapisan yang bertanggung jawab atas `SafeArea` dan padding tepi layar. Jika layar tab tetap mengelola `SafeArea` dan padding sendiri, hapus pembungkus `SafeArea` + `Padding` pada Home; atau sebaliknya konsolidasikan. Pastikan tidak ada padding ganda dan AppBar tetap edge-to-edge.
- Aturan Dilanggar: [optimasi_ux.md](.agents/rules/global/optimasi_ux.md) bagian 10 (Padding tepi layar) dan bagian 14 (SafeArea).
- File Bermasalah: [home.dart](lib/home.dart)

## Rendah

Tidak ada temuan.
