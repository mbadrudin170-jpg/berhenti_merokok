# Saran Perbaikan

## 2026-11-08 — Konfigurasi receiver dan pemulihan jadwal Android pada notifikasi harian

- **Masalah:** `android/app/src/main/AndroidManifest.xml` hanya menambahkan `POST_NOTIFICATIONS`. Untuk notifikasi terjadwal dengan `flutter_local_notifications` 22.3.3, pemulihan jadwal setelah reboot memerlukan `RECEIVE_BOOT_COMPLETED` serta deklarasi `ScheduledNotificationReceiver` dan `ScheduledNotificationBootReceiver`. Konfigurasi tersebut belum terlihat pada commit.
- **Prioritas:** Tinggi
- **Path:** `android/app/src/main/AndroidManifest.xml`
- **Aturan terkait:** `.agents/rules/global/aturan_notifikasi.md` (bagian 1 dan 5)
- **Referensi:** README plugin v22.3.3, bagian AndroidManifest.xml setup: https://github.com/MaikuB/flutter_local_notifications/blob/flutter_local_notifications-v22.3.3/flutter_local_notifications/README.md
- **Saran perbaikan:** Tambahkan `RECEIVE_BOOT_COMPLETED` dan deklarasi receiver sesuai dokumentasi. Jangan menambahkan izin exact alarm karena implementasi menggunakan `AndroidScheduleMode.inexactAllowWhileIdle`.
- **Alasan:** Tanpa konfigurasi ini, jadwal pengingat harian berpotensi tidak dipulihkan setelah perangkat dinyalakan ulang.

## 2026-11-08 — Pengaktifan core library desugaring Android untuk notifikasi terjadwal

- **Masalah:** `android/app/build.gradle.kts` sudah menggunakan Java 17, tetapi belum mengaktifkan `isCoreLibraryDesugaringEnabled` dan dependency `coreLibraryDesugaring`. Plugin v22.3.3 memerlukan desugaring untuk notifikasi terjadwal dengan kompatibilitas mundur. `compileSdk` masih diatur melalui `flutter.compileSdkVersion`, sehingga nilai efektifnya perlu diverifikasi minimal 35. AGP yang digunakan adalah 9.1.0, sudah memenuhi batas minimum dokumentasi (8.11.1).
- **Prioritas:** Tinggi
- **Path:** `android/app/build.gradle.kts`; `android/settings.gradle.kts`
- **Aturan terkait:** `.agents/rules/global/aturan_notifikasi.md` (bagian 1)
- **Referensi:** README plugin v22.3.3, bagian Gradle setup: https://github.com/MaikuB/flutter_local_notifications/blob/flutter_local_notifications-v22.3.3/flutter_local_notifications/README.md
- **Saran perbaikan:** Evaluasi penambahan `isCoreLibraryDesugaringEnabled = true`, dependency `com.android.tools:desugar_jdk_libs:2.1.4`, dan verifikasi `compileSdk` minimal 35. Pertahankan AGP 9.1.0; jangan menurunkannya.
- **Alasan:** Tanpa desugaring, notifikasi terjadwal dapat gagal pada versi Android yang lebih lama.

## 2026-11-08 — Penanganan notifikasi pada Web

- **Masalah:** `NotifikasiService.inisialisasi()` memanggil `mintaIzin()` saat aplikasi dibuka, termasuk pada Web. Dokumentasi plugin menyatakan izin Web harus diminta hanya sebagai respons interaksi pengguna. Selain itu, browser tidak mendukung notifikasi terjadwal atau berulang melalui plugin ini. `mintaIzin()` dan UI pengaturan belum memisahkan kemampuan berdasarkan platform, dan `catch (Exception)` tidak menangkap `UnsupportedError`.
- **Prioritas:** Tinggi
- **Path:** `lib/main.dart`; `lib/shared/notifikasi/notifikasi_service.dart`; `lib/fitur/pengaturan/screens/pengaturan_screen.dart`
- **Aturan terkait:** `.agents/rules/global/aturan_notifikasi.md` (bagian 4); `.agents/rules/global/optimasi_bug_runtime.md` (bagian 6)
- **Referensi:** README plugin v22.3.3, bagian Web limitations dan Web Setup: https://github.com/MaikuB/flutter_local_notifications/blob/flutter_local_notifications-v22.3.3/flutter_local_notifications/README.md
- **Saran perbaikan:** Jangan meminta izin Web saat aplikasi pertama dibuka; minta izin setelah pengguna mengaktifkan notifikasi. Pisahkan kemampuan notifikasi berdasarkan platform dan jangan tampilkan pengaturan pengingat terjadwal pada platform yang tidak mendukung. Tangani `UnsupportedError` secara eksplisit.
- **Alasan:** Permintaan izin otomatis pada Web dapat ditolak atau diblokir browser, dan fitur terjadwal tidak tersedia pada Web.

## 2026-11-08 — Waktu permintaan izin notifikasi iOS

- **Masalah:** `DarwinInitializationSettings()` menggunakan nilai default `requestAlertPermission`, `requestSoundPermission`, dan `requestBadgePermission` bernilai `true`. Karena inisialisasi dilakukan saat aplikasi dibuka, dialog izin dapat muncul sebelum pengguna mengaktifkan fitur notifikasi.
- **Prioritas:** Sedang
- **Path:** `lib/main.dart`; `lib/shared/notifikasi/notifikasi_service.dart`
- **Aturan terkait:** `.agents/rules/global/aturan_notifikasi.md` (bagian 1 dan 4)
- **Referensi:** README/source plugin v22.3.3, `DarwinInitializationSettings`: https://github.com/MaikuB/flutter_local_notifications/blob/flutter_local_notifications-v22.3.3/flutter_local_notifications/README.md
- **Saran perbaikan:** Pertimbangkan menonaktifkan permintaan izin otomatis saat inisialisasi dan minta izin ketika pengguna secara sadar mengaktifkan pengingat. Periksa hasil permintaan izin sebelum menyimpan status pengingat sebagai aktif.
- **Alasan:** Dialog izin yang muncul terlalu awal dapat menurunkan pengalaman pengguna dan tidak sesuai dengan tujuan fitur.

## 2026-11-08 — Pemeriksaan status izin sebelum mengaktifkan pengingat

- **Masalah:** `mintaIzin()` tidak meneruskan hasil izin kepada proses aktivasi. `jadwalkanPengingatHarian()` memanggil `setAktif(true)` setelah penjadwalan, sehingga status preferensi dapat menjadi aktif meskipun izin sistem belum tersedia.
- **Prioritas:** Tinggi
- **Path:** `lib/shared/notifikasi/notifikasi_service.dart`
- **Aturan terkait:** `.agents/rules/global/aturan_notifikasi.md` (bagian 4 dan 5); `.agents/rules/global/optimasi_bug_runtime.md` (bagian 6)
- **Referensi:** README plugin v22.3.3, bagian requesting permissions: https://github.com/MaikuB/flutter_local_notifications/blob/flutter_local_notifications-v22.3.3/flutter_local_notifications/README.md
- **Saran perbaikan:** Periksa status izin sesuai platform sebelum menyimpan status aktif. Jangan menyimpan status aktif jika izin sistem belum tersedia. Periksa kembali izin ketika aplikasi dibuka karena pengguna dapat mengubahnya melalui pengaturan sistem.
- **Alasan:** Status preferensi aplikasi dapat tidak sesuai dengan status izin sistem.

## 2026-11-08 — Konsistensi perubahan waktu pengingat

- **Masalah:** `_pilihWaktu()` memperbarui `_jam` dan `_menit` sebelum proses penjadwalan selesai. Jika penjadwalan gagal, tampilan dapat berbeda dengan preferensi atau jadwal yang masih aktif.
- **Prioritas:** Sedang
- **Path:** `lib/fitur/pengaturan/screens/pengaturan_screen.dart`
- **Aturan terkait:** `.agents/rules/global/optimasi_bug_runtime.md` (bagian 6); `.agents/rules/global/optimasi_ux.md` (bagian 5 dan 6)
- **Referensi:** Aturan proyek UX; dokumentasi plugin tidak relevan langsung.
- **Saran perbaikan:** Simpan waktu sebelumnya sebelum perubahan. Terapkan waktu baru setelah penyimpanan atau penjadwalan berhasil. Jika gagal, pulihkan nilai sebelumnya dan tampilkan pesan kegagalan yang jelas.
- **Alasan:** Menjaga kesesuaian antara tampilan, preferensi, dan jadwal aktif.

## 2026-11-08 — Pemeriksaan mounted setelah operasi asynchronous pada pengaturan notifikasi

- **Masalah:** `_ubahNotifikasi()`, `_pilihWaktu()`, dan `_ujiNotifikasi()` menjalankan operasi asynchronous lalu menggunakan `setState()` atau `context`. Pemeriksaan `mounted` belum konsisten setelah setiap `await`.
- **Prioritas:** Sedang
- **Path:** `lib/fitur/pengaturan/screens/pengaturan_screen.dart`
- **Aturan terkait:** `.agents/rules/global/optimasi_bug_runtime.md` (bagian 4)
- **Referensi:** Aturan proyek runtime.
- **Saran perbaikan:** Periksa `mounted` setelah setiap operasi asynchronous sebelum menggunakan `setState()` atau `context`.
- **Alasan:** Mencegah penggunaan widget yang sudah tidak terpasang.

## 2026-11-08 — Penanganan error Future saat penjadwalan ulang notifikasi

- **Masalah:** `jadwalkanUlangJikaAktif()` dipanggil menggunakan `unawaited()` dari `initState()` pada `app.dart`. Pemanggil tidak menangani error. `main.dart` tetap menjalankan aplikasi ketika inisialisasi notifikasi gagal, sehingga status kegagalan inisialisasi tidak diketahui sebelum penjadwalan ulang dijalankan.
- **Prioritas:** Sedang
- **Path:** `lib/main.dart`; `lib/app.dart`; `lib/shared/notifikasi/notifikasi_service.dart`
- **Aturan terkait:** `.agents/rules/global/optimasi_bug_runtime.md` (bagian 6, 10, dan 15)
- **Referensi:** Aturan proyek runtime.
- **Saran perbaikan:** Pastikan status inisialisasi layanan diketahui sebelum penjadwalan ulang dijalankan. Tangani kegagalan Future yang dilepas secara eksplisit dan catat melalui logger proyek. Pastikan kegagalan fitur notifikasi tidak mengganggu fitur utama aplikasi.
- **Alasan:** Error dapat menjadi unhandled atau tidak tercatat, dan penjadwalan ulang dapat dijalankan pada layanan yang belum siap.

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

## 2026-11-08 — Pemisahan ID notifikasi uji coba dan pengingat harian

- **Masalah:** `tampilkanSekarang()` dan `jadwalkanPengingatHarian()` menggunakan ID notifikasi yang sama, yaitu `1001`. Notifikasi uji coba dapat memperbarui atau menggantikan notifikasi pengingat utama.
- **Prioritas:** Rendah
- **Path:** `lib/shared/notifikasi/notifikasi_service.dart`
- **Aturan terkait:** `.agents/rules/global/aturan_notifikasi.md` (bagian 5)
- **Referensi:** Aturan ID notifikasi proyek; perilaku plugin perlu diverifikasi.
- **Saran perbaikan:** Evaluasi penggunaan ID terpisah untuk notifikasi uji coba dan pengingat harian. Pastikan notifikasi uji coba tidak memperbarui atau menggantikan jadwal utama. Verifikasi perilaku berdasarkan cara plugin menggunakan ID notifikasi sebelum menyatakan adanya kerusakan jadwal.
- **Alasan:** Menghindari efek samping pada jadwal pengingat utama.

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
