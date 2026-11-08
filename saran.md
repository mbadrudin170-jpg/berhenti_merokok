# Saran Perbaikan

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
