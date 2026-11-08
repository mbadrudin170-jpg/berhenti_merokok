# Saran Perbaikan

## 2026-11-08 — Potensi overflow pada kartu impian saat menampilkan sisa dan target

- **Masalah:** Pada `lib/fitur/impian/screens/impian_screen.dart` (baris 139-147, kondisi HEAD), `Row` dengan `MainAxisAlignment.spaceBetween` menampilkan dua `Text` tanpa `Flexible`/`Expanded`. Pada layar sempit atau skala teks besar, total lebar teks dapat melebihi lebar kartu dan menyebabkan overflow. Nominal target juga ditampilkan tanpa label, sehingga maknanya kurang jelas dibanding "Sisa".
- **Prioritas:** Rendah
- **Path:** `lib/fitur/impian/screens/impian_screen.dart:139-147`
- **Aturan terkait:** `.agents/rules/global/optimasi_ui.md` (bagian 3 — Penanganan Text Overflow)
- **Referensi:** Flutter SDK `Row` (`packages/flutter/lib/src/widgets/basic.dart`) dan `Text` (`packages/flutter/lib/src/widgets/text.dart`); `MainAxisAlignment.spaceBetween` tidak membatasi lebar anak.
- **Saran perbaikan:** Bungkus salah satu atau kedua `Text` dengan `Flexible`/`Expanded`, atau gunakan `Wrap`/`FittedBox` sesuai kebutuhan. Tambahkan label singkat (mis. "Target") pada nominal kanan agar maknanya jelas.
- **Alasan:** Mencegah overflow horizontal dan menjaga kejelasan informasi pada berbagai ukuran layar dan skala teks.

## 2026-11-08 — Identifikasi kegagalan izin melalui pencocokan string

- **Masalah:** Pada `lib/fitur/pengaturan/screens/pengaturan_screen.dart` (baris 116), kegagalan izin dideteksi dengan `e.toString().contains('Izin notifikasi tidak diberikan')`. Pencocokan string bergantung pada teks exception yang sama persis, sehingga rentan jika pesan berubah.
- **Prioritas:** Rendah
- **Path:** `lib/fitur/pengaturan/screens/pengaturan_screen.dart:113-129`
- **Aturan terkait:** Tidak ditemukan pelanggaran aturan tertulis
- **Referensi:** `NotifikasiService.jadwalkanPengingatHarian()` melempar `Exception('Izin notifikasi tidak diberikan')`.
- **Saran perbaikan:** Gunakan tipe exception khusus atau hasil boolean dari operasi izin, bukan pencocokan string, agar deteksi kegagalan tidak bergantung pada teks.
- **Alasan:** Membuat penanganan error lebih stabil terhadap perubahan pesan.

## 2026-11-08 — Ketahanan inisialisasi zona waktu dan fallback

- **Masalah:** Pada `lib/shared/notifikasi/notifikasi_service.dart` (baris 34), `tz.initializeTimeZones()` dipanggil di luar `try`. Fallback `tz.getLocation('Asia/Jakarta')` pada baris 48 tidak dibungkus `try` secara langsung, dan `catch (e, s)` pada baris 50 hanya menangkap `Exception`, bukan `Error` seperti `ArgumentError` yang mungkin dilempar `FlutterTimezone.getLocalTimezone()`.
- **Prioritas:** Rendah
- **Path:** `lib/shared/notifikasi/notifikasi_service.dart:33-59`
- **Aturan terkait:** `.agents/rules/global/aturan_pemanfaatan_sdk_dan_paket.md` (bagian 4.3.C — Penanganan Kesalahan)
- **Referensi:** `timezone` 0.11.2 (`initializeTimeZones()`, `getLocation()`), `flutter_timezone` 5.1.1 (`getLocalTimezone()`).
- **Saran perbaikan:** Bungkus `tz.initializeTimeZones()` dan fallback `tz.getLocation('Asia/Jakarta')` dalam `try/catch`, serta tangkap `UnsupportedError`/`Error` yang relevan atau validasi hasil sebelum penggunaan.
- **Alasan:** Memastikan inisialisasi timezone tidak menjadi unhandled error pada platform yang tidak mendukung.

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

## 2026-11-08 — Pemeriksaan mounted setelah operasi asynchronous pada pengaturan notifikasi

- **Masalah:** `_ubahNotifikasi()`, `_pilihWaktu()`, dan `_ujiNotifikasi()` menjalankan operasi asynchronous lalu menggunakan `setState()` atau `context`. Pemeriksaan `mounted` belum konsisten setelah setiap `await`.
- **Prioritas:** Sedang
- **Path:** `lib/fitur/pengaturan/screens/pengaturan_screen.dart`
- **Aturan terkait:** `.agents/rules/global/optimasi_bug_runtime.md` (bagian 4)
- **Referensi:** Aturan proyek runtime.
- **Saran perbaikan:** Periksa `mounted` setelah setiap operasi asynchronous sebelum menggunakan `setState()` atau `context`.
- **Alasan:** Mencegah penggunaan widget yang sudah tidak terpasang.
- **Status:** Sebagian diperbaiki (mounted check ditambahkan pada `_ubahNotifikasi`, `_pilihWaktu`, dan `_ujiNotifikasi`). Masih perlu verifikasi konsistensi pada seluruh await.

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

## 2026-11-08 — Pengecekan platform dan penanganan error pada cekNotifikasiSaatBuka (commit 2a5a357)

- **Masalah:** `NotifikasiService.cekNotifikasiSaatBuka()` (lib/shared/notifikasi/notifikasi_service.dart) memanggil `getNotificationAppLaunchDetails()` tanpa membatasi platform terlebih dahulu. Pada Web/Linux, perilaku plugin berbeda dan method dapat mengembalikan null atau melempar. Penanganan menggunakan `catch (e, s)` (tanpa tipe) sehingga `UnsupportedError` tidak ditangani secara eksplisit, berpotensi tidak sesuai aturan #6 global bug runtime dan aturan #6 validasi platform. Selain itu, jika `navigatorKey.currentState` masih null saat `_navigasiDariPayload()` dipanggil, navigasi dilewati tanpa retry.
- **Prioritas:** Rendah
- **Path:** `lib/shared/notifikasi/notifikasi_service.dart` (method `cekNotifikasiSaatBuka`, `_navigasiDariPayload`)
- **Aturan terkait:** `.agents/rules/global/aturan_notifikasi.md` (bagian 4); `.agents/rules/global/optimasi_bug_runtime.md` (bagian 6); `.agents/rules/global/aturan_lainnya.md` (validasi platform)
- **Referensi:** `flutter_local_notifications` 22.3.3 (`getNotificationAppLaunchDetails`).
- **Saran perbaikan:** Tambahkan guard platform (mis. lewati pada Web/Linux atau tangani sesuai kemampuan), tangani `UnsupportedError` secara eksplisit sebelum `Exception`, dan pertimbangkan retry/penundaan navigasi apabila navigator belum siap. Variabel `id` hasil parsing payload saat ini tidak digunakan (tidak berdampak).
- **Alasan:** Menjaga konsistensi dengan aturan penanganan platform dan error Future.
- **Status:** Belum diperbaiki.

## 2026-11-08 — Panggilan asynchronous di dalam blok catch pada pengaturan notifikasi

- **Masalah:** Pada `lib/fitur/pengaturan/screens/pengaturan_screen.dart` (baris 117 dan 124), `_ubahNotifikasi()` memanggil `NotifikasiService.aktif()` dan `_muatPreferensiNotifikasi()` di dalam blok `on Exception catch` tanpa `try/catch`. Jika salah satu melempar, exception keluar dari method yang dipanggil via `unawaited` dan menjadi unhandled.
- **Prioritas:** Sedang
- **Path:** `lib/fitur/pengaturan/screens/pengaturan_screen.dart:113-129`
- **Aturan terkait:** `.agents/rules/global/optimasi_bug_runtime.md` (bagian 6 dan 10)
- **Referensi:** `NotifikasiService.aktif()`, `_muatPreferensiNotifikasi()`.
- **Saran perbaikan:** Bungkus kedua pemanggilan dalam `try/catch` terpisah dan catat dengan `L.e(...)`; pertahankan pemeriksaan `mounted`.
- **Alasan:** Mencegah unhandled Future dan menjaga konsistensi UI saat kegagalan izin.

## 2026-11-08 — Inkonsistensi preferensi waktu pengingat saat penyimpanan gagal

- **Masalah:** Pada `lib/shared/notifikasi/notifikasi_service.dart`, `jadwalkanPengingatHarian()` memanggil `setAktif(true)` lalu `setWaktu(jam, menit)`. Jika `setWaktu` gagal setelah `setAktif(true)` berhasil, status aktif tersimpan tetapi waktu tidak diperbarui.
- **Prioritas:** Rendah
- **Path:** `lib/shared/notifikasi/notifikasi_service.dart` (method `jadwalkanPengingatHarian`)
- **Aturan terkait:** `.agents/rules/proyek/aturan_khusus.md` (aturan notifikasi #7 dan #13)
- **Referensi:** `setAktif()`, `setWaktu()`.
- **Saran perbaikan:** Urutkan penyimpanan sehingga `setWaktu` sebelum `setAktif(true)`, atau bungkus keduanya dengan rollback saat gagal.
- **Alasan:** Menjaga konsistensi antara jadwal sistem, SharedPreferences, dan tampilan.

