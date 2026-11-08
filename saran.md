# Saran Perbaikan

## [2026-11-08] [a30b6b6e4377b55eadecb6b83b0e4c05faa985b5]

### Prioritas: Sedang

**File:**

- lib/fitur/pengaturan/screens/pengaturan_screen.dart:83-88, 128, 154-159, 190, 205-210, 220
- lib/shared/notifikasi/notifikasi_service.dart:88

**Masalah:**

Beberapa `unawaited(EasyLoading.show(...))` dan `unawaited(EasyLoading.dismiss())` dilepas tanpa penanganan error, padahal keduanya mengembalikan `Future<void>`. Hal yang sama berlaku pada `unawaited(Nav.pushAndRemoveUntil(...))` di atas.

**Bukti aturan atau SDK:**

- .agents/rules/proyek/aturan_khusus.md: (aturan notifikasi #14)
- .agents/rules/global/optimasi_bug_runtime.md: (bagian 10 — Penggunaan await dan unawaited)
- Source SDK: /home/mbadrudin170/.pub-cache/hosted/pub.dev/flutter_easyloading-4.0.2/lib/src/easy_loading.dart:124, 276 (mengembalikan Future<void>)

**Dampak:**

Kegagalan pada overlay loading dapat menjadi unhandled Future (meskipun jarang).

**Rekomendasi:**

Bungkus setiap Future yang dilepas dengan `catchError` yang mencatat error via `L.e`, atau jalankan dalam fungsi dengan try/catch sebelum dilepas.

**Status:** Belum diperbaiki.

---

## [2026-11-08] [a30b6b6e4377b55eadecb6b83b0e4c05faa985b5]

### Prioritas: Sedang

**File:**

- lib/shared/notifikasi/notifikasi_service.dart:122-187
- lib/fitur/pengaturan/screens/pengaturan_screen.dart:90-110

**Masalah:**

Ketika izin sistem dicabut pada saat `jadwalkanPengingatHarian()` berjalan, method tersebut memanggil `setAktif(false)` dan membatalkan jadwal, lalu melempar `Exception('Izin notifikasi tidak diberikan')`. Namun `_ubahNotifikasi()` telah menetapkan `_notifikasiAktif = true` sebelumnya dan pada jalur exception hanya menyetel `_notifikasiAktif = !value` (false), sehingga tampilan dan preferensi dapat tidak konsisten dengan jadwal sistem (aturan #12). Selain itu, pesan toast yang ditampilkan adalah "Gagal mengubah pengingat harian", bukan informasi izin.

**Bukti aturan atau SDK:**

- .agents/rules/proyek/aturan_khusus.md: (aturan notifikasi #12 dan #13)
- Source SDK: flutter_local_notifications 22.3.3 (permission handling)

**Dampak:**

State UI, SharedPreferences, dan jadwal sistem operasi dapat tidak sinkron setelah izin dicabut.

**Rekomendasi:**

Setelah `jadwalkanPengingatHarian` gagal karena izin, sinkronkan `_notifikasiAktif` dengan `NotifikasiService.aktif()` (atau set false) dan tampilkan pesan yang menjelaskan izin tidak tersedia; pertimbangkan memanggil `_muatPreferensiNotifikasi()` untuk menyegarkan tampilan.

**Status:** Belum diperbaiki.

---

## 2026-11-08 — Dukungan macOS pada penjadwalan notifikasi harian

- **Masalah:** Pada `lib/shared/notifikasi/notifikasi_service.dart`, method `jadwalkanPengingatHarian()` (baris 104-112) melempar `UnsupportedError` pada `TargetPlatform.macOS`, padahal plugin `flutter_local_notifications` v22.3.3 mendukung notifikasi terjadwal pada macOS melalui `zonedSchedule`. Aturan hanya melarang penjadwalan berulang pada Web dan Linux.
- **Prioritas:** Rendah
- **Path:** `lib/shared/notifikasi/notifikasi_service.dart:104-112`
- **Aturan terkait:** `.agents/rules/global/aturan_notifikasi.md` (bagian 1)
- **Referensi:** `flutter_local_notifications_plugin.dart:409-470` (zonedSchedule mendukung macOS).
- **Saran perbaikan:** Hapus `TargetPlatform.macOS` dari kondisi yang melempar `UnsupportedError`, atau pisahkan pengecekan berdasarkan kemampuan aktual platform.
- **Alasan:** Plugin mendukung notifikasi terjadwal pada macOS, sehingga pengecualian macOS tidak diperlukan dan membatasi fungsionalitas pada platform yang sebenarnya mendukung.

## 2026-11-08 — Penanganan notifikasi pada Web

- **Masalah:** `NotifikasiService.inisialisasi()` memanggil `mintaIzin()` saat aplikasi dibuka, termasuk pada Web. Dokumentasi plugin menyatakan izin Web harus diminta hanya sebagai respons interaksi pengguna. Selain itu, browser tidak mendukung notifikasi terjadwal atau berulang melalui plugin ini. `mintaIzin()` dan UI pengaturan belum memisahkan kemampuan berdasarkan platform, dan `catch (Exception)` tidak menangkap `UnsupportedError`.
- **Prioritas:** Tinggi
- **Path:** `lib/main.dart`; `lib/shared/notifikasi/notifikasi_service.dart`; `lib/fitur/pengaturan/screens/pengaturan_screen.dart`
- **Aturan terkait:** `.agents/rules/global/aturan_notifikasi.md` (bagian 4); `.agents/rules/global/optimasi_bug_runtime.md` (bagian 6)
- **Referensi:** README plugin v22.3.3, bagian Web limitations dan Web Setup: https://github.com/MaikuB/flutter_local_notifications/blob/flutter_local_notifications-v22.3.3/flutter_local_notifications/README.md
- **Saran perbaikan:** Jangan meminta izin Web saat aplikasi pertama dibuka; minta izin setelah pengguna mengaktifkan notifikasi. Pisahkan kemampuan notifikasi berdasarkan platform dan jangan tampilkan pengaturan pengingat terjadwal pada platform yang tidak mendukung. Tangani `UnsupportedError` secara eksplisit.
- **Alasan:** Permintaan izin otomatis pada Web dapat ditolak atau diblokir browser, dan fitur terjadwal tidak tersedia pada Web.
- **Status:** Sebagian diperbaiki pada perubahan terbaru (izin tidak lagi diminta saat inisialisasi, pengaturan disembunyikan pada Web/Linux/Windows/macOS, UnsupportedError ditangani). Masih perlu verifikasi perilaku pada Web.

## 2026-11-08 — Konsistensi perubahan waktu pengingat

- **Masalah:** `_pilihWaktu()` memperbarui `_jam` dan `_menit` sebelum proses penjadwalan selesai. Jika penjadwalan gagal, tampilan dapat berbeda dengan preferensi atau jadwal yang masih aktif.
- **Prioritas:** Sedang
- **Path:** `lib/fitur/pengaturan/screens/pengaturan_screen.dart`
- **Aturan terkait:** `.agents/rules/global/optimasi_bug_runtime.md` (bagian 6); `.agents/rules/global/optimasi_ux.md` (bagian 5 dan 6)
- **Referensi:** Aturan proyek UX; dokumentasi plugin tidak relevan langsung.
- **Saran perbaikan:** Simpan waktu sebelumnya sebelum perubahan. Terapkan waktu baru setelah penyimpanan atau penjadwalan berhasil. Jika gagal, pulihkan nilai sebelumnya dan tampilkan pesan kegagalan yang jelas.
- **Alasan:** Menjaga kesesuaian antara tampilan, preferensi, dan jadwal aktif.
- **Status:** Sebagian diperbaiki (pemeriksaan mounted ditambahkan pada `_ubahNotifikasi`). Masih perlu menyimpan waktu sebelumnya dan memulihkannya jika penjadwalan gagal.

## 2026-11-08 — Pemeriksaan mounted setelah operasi asynchronous pada pengaturan notifikasi

- **Masalah:** `_ubahNotifikasi()`, `_pilihWaktu()`, dan `_ujiNotifikasi()` menjalankan operasi asynchronous lalu menggunakan `setState()` atau `context`. Pemeriksaan `mounted` belum konsisten setelah setiap `await`.
- **Prioritas:** Sedang
- **Path:** `lib/fitur/pengaturan/screens/pengaturan_screen.dart`
- **Aturan terkait:** `.agents/rules/global/optimasi_bug_runtime.md` (bagian 4)
- **Referensi:** Aturan proyek runtime.
- **Saran perbaikan:** Periksa `mounted` setelah setiap operasi asynchronous sebelum menggunakan `setState()` atau `context`.
- **Alasan:** Mencegah penggunaan widget yang sudah tidak terpasang.
- **Status:** Sebagian diperbaiki (mounted check ditambahkan pada `_ubahNotifikasi`, `_pilihWaktu`, dan `_ujiNotifikasi`). Masih perlu verifikasi konsistensi pada seluruh await.

## 2026-11-08 — Implementasi ketika notifikasi harian ditekan

- **Masalah:** `_onTapNotifikasi()` membaca payload dan mendapatkan `navigatorKey.currentState`, tetapi belum melakukan navigasi meskipun komentar menyebutkan kembali ke beranda. Belum terlihat penanganan kondisi aplikasi diluncurkan dari keadaan tertutup melalui notifikasi.
- **Prioritas:** Sedang
- **Path:** `lib/shared/notifikasi/notifikasi_service.dart`
- **Aturan terkait:** `.agents/rules/global/aturan_notifikasi.md` (bagian 3)
- **Referensi:** README plugin v22.3.3, bagian handling notification tap dan `getNotificationAppLaunchDetails`: https://github.com/MaikuB/flutter_local_notifications/blob/flutter_local_notifications-v22.3.3/flutter_local_notifications/README.md
- **Saran perbaikan:** Tentukan perilaku ketika notifikasi ditekan, implementasikan navigasi sesuai tujuan, dan evaluasi penggunaan `getNotificationAppLaunchDetails()` untuk kondisi aplikasi diluncurkan melalui notifikasi ketika sebelumnya terminated. Pastikan penanganan bekerja untuk foreground, background, dan terminated.
- **Alasan:** Pengguna yang menekan notifikasi belum diarahkan ke tampilan yang diharapkan.

## 2026-11-08 — Penentuan zona waktu pengingat harian

- **Masalah:** Zona waktu ditetapkan permanen menggunakan `Asia/Jakarta` melalui `tz.setLocalLocation(tz.getLocation('Asia/Jakarta'))`.
- **Prioritas:** Sedang, bergantung pada cakupan pengguna
- **Path:** `lib/shared/notifikasi/notifikasi_service.dart`
- **Aturan terkait:** -
- **Referensi:** Package `timezone` 0.11.2; README plugin v22.3.3: https://github.com/MaikuB/flutter_local_notifications/blob/flutter_local_notifications-v22.3.3/flutter_local_notifications/README.md
- **Saran perbaikan:** Tentukan apakah waktu pengingat harus selalu mengikuti WIB atau mengikuti zona waktu perangkat. Jika aplikasi ditujukan untuk pengguna di seluruh Indonesia, pertimbangkan zona waktu lokal perangkat agar mendukung WIB, WITA, dan WIT. Periksa mekanisme platform atau package tambahan yang diperlukan karena package timezone tidak otomatis mendeteksi zona waktu perangkat.
- **Alasan:** Pengingat dapat muncul pada waktu yang tidak sesuai untuk pengguna di luar WIB.

## 2026-11-08 — Pengujian fitur notifikasi

- **Masalah:** Commit menambahkan layanan notifikasi dan interaksi pengaturan, tetapi tidak terlihat file pengujian baru dalam perubahan commit tersebut.
- **Prioritas:** Sedang
- **Path:** `lib/shared/notifikasi/notifikasi_service.dart`; `lib/fitur/pengaturan/screens/pengaturan_screen.dart`
- **Aturan terkait:** `.agents/rules/global/aturan_testing.md`
- **Referensi:** Aturan testing proyek.
- **Saran perbaikan:** Evaluasi pengujian untuk izin diberikan/ditolak, mengaktifkan/menonaktifkan pengingat, mengubah waktu, kegagalan penjadwalan dan penyimpanan preferensi, penjadwalan ulang saat aplikasi dibuka, platform yang tidak mendukung notifikasi terjadwal, dan pemulihan jadwal setelah perangkat restart. Gunakan mock atau fake pada batas plugin dan penyimpanan. Jangan menyimpulkan seluruh proyek belum memiliki pengujian hanya karena commit ini tidak menyertakan file pengujian.
- **Alasan:** Memastikan perilaku fitur notifikasi dapat diverifikasi tanpa bergantung pada notifikasi perangkat sebenarnya.

## 2026-11-08 — Parameter AppBar redundan (opsional) pada dashboard dan impian

- **Masalah:** `lib/fitur/dashboard/screens/dashboard_screen.dart` dan `lib/fitur/impian/screens/impian_screen.dart` menambahkan `backgroundColor: Theme.of(context).colorScheme.surface`, `elevation: 0`, dan `forceMaterialTransparency: false` pada `AppBar`. Nilai tersebut merupakan default pada Material 3 (Flutter 3.47.9): `backgroundColor` default ke `colorScheme.surface`, `elevation` default `0`, `forceMaterialTransparency` default `false`.
- **Path dan baris:** `lib/fitur/dashboard/screens/dashboard_screen.dart` (AppBar utama, baris 84-90); `lib/fitur/impian/screens/impian_screen.dart` (dua AppBar, baris 86-93 dan 98-105).
- **Aturan terkait:** -
- **Referensi SDK:** `/google/flutter/packages/flutter/lib/src/material/app_bar.dart` (konstruktor `AppBar`, baris 198-225; `forceMaterialTransparency = false` default baris 225).
- **Saran perbaikan:** Pertahankan jika ingin menegaskan opasitas app bar; atau hapus baris redundan untuk menyederhanakan. `scrolledUnderElevation: 2` tetap berguna sebagai pemisah visual saat scroll.
- **Alasan:** Menghindari duplikasi default SDK tanpa mengubah perilaku; menjaga kejelasan.

## 2026-11-08 — Kerapian import pada `dashboard_screen.dart`

- **Masalah:** `lib/fitur/dashboard/screens/dashboard_screen.dart:1-7` memiliki baris kosong ganda setelah import `badge_screen.dart`.
- **Path dan baris:** `lib/fitur/dashboard/screens/dashboard_screen.dart:1-7`
- **Aturan terkait:** `.agents/rules/global/aturan_lainnya.md` (bagian 31 — Aturan Import).
- **Saran perbaikan:** Rapikan baris kosong agar konsisten dengan gaya file lain.
- **Alasan:** Menjaga keterbacaan dan konsistensi import.

## 2026-11-08 — Warna hardcode `Colors.amber` pada kartu Pencapaian (dashboard_screen.dart)

- **Masalah:** `lib/fitur/dashboard/screens/dashboard_screen.dart` (method `_buildCardBadge`) menggunakan `Colors.amber` untuk ikon, bukan warna dari tema.
- **Path dan baris:** `lib/fitur/dashboard/screens/dashboard_screen.dart` (method `_buildCardBadge`)
- **Aturan terkait:** `.agents/rules/global/optimasi_ui.md` (bagian 2 — Penggunaan Warna dan Tema).
- **Saran perbaikan:** Pertimbangkan `Theme.of(context).colorScheme` (mis. `secondary`/`tertiary`) agar menyesuaikan tema, kecuali amber memang diinginkan tetap.
- **Alasan:** Menjaga konsistensi tema terang/gelap.

## 2026-11-07 — Logging di dalam metode `build()` pada `impian_screen.dart`

- **Masalah:** `L.i('uangDihemat=$uangDihemat')` ditambahkan di dalam `build()` pada `lib/fitur/impian/screens/impian_screen.dart:74`. Metode `build()` dapat dipanggil berulang kali (setiap rebuild), sehingga log ini akan muncul berulang dan menambah noise. Hal serupa juga berlaku pada log `L.i('impianAsync.isLoading=...')`, `L.i('listImpian.length=...')`, dan `L.i('item.id=...')` yang sudah ada sebelumnya.
- **Path dan baris:** `lib/fitur/impian/screens/impian_screen.dart:34`, `:67`, `:74`, `:116`
- **Aturan terkait:** `.agents/rules/global/optimasi_bug_runtime.md` (bagian 11 — Hindari penggunaan logger di dalam metode `build()`).
- **Saran perbaikan:** Pindahkan atau hapus log yang tidak memberikan nilai tambahan di luar alur rebuild, atau batasi logging pada titik yang tidak sering dipanggil. Jika dipertahankan, pastikan tidak berada di dalam loop item (`itemBuilder`).
- **Alasan:** Metode `build()` dapat dipanggil berulang oleh framework; logging berfrekuensi tinggi menambah noise dan mempersulit pelacakan.

## 2026-11-07 — Progress menampilkan 0 saat biodata masih loading

- **Masalah:** Pada `lib/fitur/impian/screens/impian_screen.dart:71-80`, `uangDihemat` dihitung sebagai 0 selama `biodataAsync` masih loading atau error. Akibatnya progress bar dan "Sisa" menampilkan 0 sementara, baru diperbarui setelah biodata selesai dimuat.
- **Path dan baris:** `lib/fitur/impian/screens/impian_screen.dart:71-80`, `:114`, `:116`
- **Saran perbaikan:** Pertimbangkan menampilkan indikator loading pada area "Saldo terkumpul" atau menunda perhitungan hingga biodata tersedia, agar pengguna tidak melihat nilai 0 yang menyesatkan.
- **Alasan:** Meningkatkan kejelasan status operasi (aturan UX) tanpa mengubah logika utama.
