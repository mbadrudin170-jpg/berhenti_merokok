# Saran Perbaikan

## 2026-11-07 — Logging di dalam metode `build()` pada `impian_screen.dart`

- **Masalah:** `L.i('uangDihemat=$uangDihemat')` ditambahkan di dalam `build()` pada `lib/fitur/impian/screens/impian_screen.dart:74`. Metode `build()` dapat dipanggil berulang kali (setiap rebuild), sehingga log ini akan muncul berulang dan menambah noise. Hal serupa juga berlaku pada log `L.i('impianAsync.isLoading=...')`, `L.i('listImpian.length=...')`, dan `L.i('item.id=...')` yang sudah ada sebelumnya.
- **Path dan baris:** `lib/fitur/impian/screens/impian_screen.dart:34`, `:67`, `:74`, `:116`
- **Aturan terkait:** `.agents/rules/global/optimasi_bug_runtime.md` (bagian 11 — Hindari penggunaan logger di dalam metode `build()`).
- **Saran perbaikan:** Pindahkan atau hapus log yang tidak memberikan nilai tambahan di luar alur rebuild, atau batasi logging pada titik yang tidak sering dipanggil. Jika dipertahankan, pastikan tidak berada di dalam loop item (`itemBuilder`).
- **Alasan:** Metode `build()` dapat dipanggil berulang oleh framework; logging berfrekuensi tinggi menambah noise dan mempersulit pelacakan.

## 2026-11-07 — Duplikasi perhitungan uang yang dihemat (`_hitungUangDihemat`)

- **Masalah:** Perhitungan `uangDihemat` pada `lib/fitur/impian/screens/impian_screen.dart:152-170` menduplikasi logika yang sama dengan `_buildCardProgres` pada `lib/fitur/dashboard/screens/dashboard_screen.dart` (perhitungan `hariBerhenti`, `rokokTidakDiHisap`, dan `uangDihemat`). Duplikasi ini berisiko tidak konsisten jika salah satu diubah.
- **Path dan baris:** `lib/fitur/impian/screens/impian_screen.dart:152-170`, `lib/fitur/dashboard/screens/dashboard_screen.dart:120-145`
- **Aturan terkait:** `.agents/rules/global/optimasi_boilerplate.md` (bagian 3 — Penggunaan Kembali Fungsi).
- **Saran perbaikan:** Ekstrak perhitungan ke satu tempat yang dapat digunakan bersama (misalnya method pada `BiodataModel` atau helper di `core_shared`), lalu panggil dari dashboard dan impian.
- **Alasan:** Menghindari penulisan ulang kode dengan fungsi yang sama dan menjaga konsistensi perhitungan.

## 2026-11-07 — Progress menampilkan 0 saat biodata masih loading

- **Masalah:** Pada `lib/fitur/impian/screens/impian_screen.dart:71-80`, `uangDihemat` dihitung sebagai 0 selama `biodataAsync` masih loading atau error. Akibatnya progress bar dan "Sisa" menampilkan 0 sementara, baru diperbarui setelah biodata selesai dimuat.
- **Path dan baris:** `lib/fitur/impian/screens/impian_screen.dart:71-80`, `:114`, `:116`
- **Saran perbaikan:** Pertimbangkan menampilkan indikator loading pada area "Saldo terkumpul" atau menunda perhitungan hingga biodata tersedia, agar pengguna tidak melihat nilai 0 yang menyesatkan.
- **Alasan:** Meningkatkan kejelasan status operasi (aturan UX) tanpa mengubah logika utama.
