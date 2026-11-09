---
name: pola-ux
description: Indeks pola UX standar - merujuk ke skill spesifik untuk dialog konfirmasi destruktif, empty state, kartu motivasi, perayaan pencapaian, validasi form, multiple async provider, async data handling.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "e6595744b3840998d840e398ca1782e7be7d50b4"
  model: "kilo-auto/free"
---

# Indeks Pola UX Standar

Skill ini berfungsi sebagai **indeks/ringkasan** yang merujuk ke skill spesifik untuk setiap pola UX. **Jangan menduplikasi isi skill spesifik di sini.**

## Daftar Skill Spesifik yang Relevan

| Topik | Skill Spesifik | Deskripsi Singkat |
|-------|----------------|-------------------|
| Dialog Konfirmasi Destruktif | `konfirmasi-sebelum-simpan` / `ekspor-pemulihan-cadangan` | `showOkCancelAlertDialog` dengan `isDestructiveAction: true`; pesan menjelaskan konsekuensi; hanya jalankan jika OK |
| Empty State Informatif | `empty-state-daftar` | Ikon, judul, deskripsi, CTA (FAB); `SafeArea` + padding tepi layar; jangan layar kosong tanpa info |
| Kartu Motivasi & Pintasan Aksi | `kartu-motivasi-pintasan-dashboard` | `unawaited(Nav.to(...).catchError(...))` navigasi; `asyncValue.asData?.value ?? fallback` untuk data opsional; log `L.i`/`L.w`; `SizedBox.shrink()` untuk data kosong |
| Perayaan Pencapaian (Toast Sekali) | `visualisasi-progres-impian` | `AppToast.sukses` untuk pencapaian baru; penandaan `SharedPreferences` (`impian_diraikan`, `badge_diraikan`); `unawaited()` non-blocking; jangan toast berulang |
| Validasi Form Sebelum Simpan | `validasi-form-sebelum-penyimpanan` | `Form` + `GlobalKey<FormState>` + `validate()`; validator aturan bisnis (positif, range); larang `?? 0` masking |
| Multiple AsyncValue Provider | `penanganan-asyncvalue-berkali` | Loading gabungan; error terpisah per provider + `ref.refresh()`; `requireValue` setelah aman; data tidak lengkap → tampilan terpisah + CTA |
| Penanganan State Async & Data Kosong | `penanganan-async-data-kosong` | Early return pattern: isLoading → hasError → requireValue → empty state → data tidak lengkap; `SizedBox.shrink()` kondisional; `mounted` check |

## Prinsip Umum Pola UX

1. **Konfirmasi Sebelum Aksi Destruktif**: Selalu minta konfirmasi dengan penjelasan konsekuensi.
2. **Empty State Informatif**: Ikon + judul + deskripsi + CTA, dibungkus `SafeArea` + padding.
3. **Navigasi Aman**: `unawaited(Nav.to(...).catchError(...))` untuk semua navigasi non-blocking.
4. **Akses Data Async Opsional**: Gunakan `asData?.value ?? fallback`, **BUKAN** `requireValue`.
5. **Logging Konsisten**: Log variabel UI dengan `L.i`/`L.w` per aturan logging.
6. **Toast Perayaan Sekali**: `AppToast.sukses` + `SharedPreferences` penandaan + `unawaited()`.
7. **Validasi Form Benar**: `Form` + `GlobalKey` + `validate()` + validator bisnis (bukan `?? 0`).
8. **Multiple Provider Handling**: Loading gabungan, error terpisah, `requireValue` terakhir.
9. **Early Return Pattern**: Setiap kondisi (loading, error, empty, incomplete) → early return.

## Larangan Umum (Ringkasan)

- **DILARANG** menyimpan data tanpa validasi form (lihat `validasi-form-sebelum-penyimpanan`).
- **DILARANG** `requireValue` pada data opsional/async tanpa cek loading/error (lihat `penanganan-async-data-kosong`, `penanganan-asyncvalue-berkali`, `kartu-motivasi-pintasan-dashboard`).
- **DILARANG** navigasi pintasan tanpa `.catchError()` pada `unawaited()` (lihat `kartu-motivasi-pintasan-dashboard`, `penanganan-error-unawaited`).
- **DILARANG** toast perayaan tanpa penandaan `SharedPreferences` (lihat `visualisasi-progres-impian`).
- **DILARANG** empty state tanpa ikon, judul, deskripsi, CTA (lihat `empty-state-daftar`).
- **DILARANG** konfirmasi destruktif tanpa `isDestructiveAction: true` dan penjelasan konsekuensi (lihat `konfirmasi-sebelum-simpan`, `ekspor-pemulihan-cadangan`).

## Pengecualian

- Jika proyek menggunakan mekanisme validasi lain yang **terbukti** menjalankan seluruh aturan sebelum simpan, `Form` tidak wajib (tetap validasi wajib dijalankan).
- Platform yang tidak mendukung fitur (Web notifikasi terjadwal) → jangan tampilkan kontrol, tangani graceful (lihat `validasi-platform-izin`, `flutter-local-notifications-22-3-3`).

## Referensi Aturan Sumber

- `aturan_bersama.md` — Validasi Form, Penanganan AsyncValue, Unawaited Error Handling
- `aturan_khusus.md` — Konfirmasi Simpan, Empty State, Kartu Motivasi, Visualisasi Progres, Perayaan Pencapaian

## Referensi Commit Terkait

- `3b67d309` — Konfirmasi simpan diary craving, Empty state diary craving
- `338a021` — Konfirmasi pemulihan cadangan (destruktif)
- `1e7b71e` — Konfirmasi masukkan data dummy (mengganti biodata)
- `e659574` — Kartu SOS Craving dan Alasan Berhenti di dashboard
- `c7337d1` — Perayaan pencapaian impian dengan SharedPreferences
- `ceacc6a` — Validasi penurunan mingguan mode tapering
- `19f43e5` — BadgeScreen multiple provider handling
- `02aa6b29` — DashboardScreen async data handling