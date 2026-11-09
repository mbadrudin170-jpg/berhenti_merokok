---
name: bug-runtime
description: Indeks pencegahan bug runtime - merujuk ke skill spesifik untuk type promotion, normalisasi tanggal, AsyncValue handling, form validation, unawaited error, platform validation, custom exception, division guard.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "be04199e5b44537ee1052a3815f5af8518308148"
  model: "kilo-auto/free"
---

# Indeks Pencegahan Bug Runtime

Skill ini berfungsi sebagai **indeks/ringkasan** yang merujuk ke skill spesifik untuk setiap topik pencegahan bug runtime. **Jangan menduplikasi isi skill spesifik di sini.**

## Daftar Skill Spesifik yang Relevan

| Topik | Skill Spesifik | Deskripsi Singkat |
|-------|----------------|-------------------|
| Type Promotion Null Safety | `type-promotion-null-safety` | Salin field nullable ke variabel lokal sebelum null-check agar type promotion berlaku |
| Normalisasi Tanggal | `normalisasi-tanggal` | Normalisasi DateTime ke komponen tanggal saja sebelum perbandingan/perhitungan hari; klamp negatif ke 0 |
| Penanganan Beberapa AsyncValue | `penanganan-asyncvalue-berkali` | Loading gabungan, error terpisah per provider, requireValue setelah aman |
| Penanganan State Async & Data Kosong | `penanganan-async-data-kosong` | Early return pattern: isLoading → hasError → requireValue → empty state → data tidak lengkap |
| Validasi Form | `validasi-form-sebelum-penyimpanan` | Form + GlobalKey + validate(); validator aturan bisnis; larang `?? 0` masking |
| Error Handling Unawaited | `penanganan-error-unawaited` | unawaited() wajib catchError dengan L.e; navigasi & loading |
| Validasi Platform & Izin | `validasi-platform-izin` | Cek platform sebelum API; minta izin konteks fitur; cek hasil izin; handle UnsupportedError |
| Custom Exception Types | `exception-khusus-deteksi-error` | Class exception khusus implements Exception; deteksi via `is`, bukan string matching |
| Guard Pembagian Nol | `ekstraksi-perhitungan-turunan` (section Guard) / `visualisasi-progres-impian` | Setiap pembagian wajib guard `if (pembagi == 0) return 0/false` di helper murni/ekstensi |

## Prinsip Penggunaan

1. **Untuk implementasi detail**: Buka skill spesifik yang tercantum di tabel di atas.
2. **Untuk code review**: Periksa apakah kode mengikuti aturan dari skill spesifik yang relevan.
3. **Untuk onboarding**: Gunakan indeks ini untuk memahami lanskap pencegahan bug runtime, lalu pelajari setiap skill spesifik.

## Larangan

- **JANGAN** menyalin isi skill spesifik ke skill ini.
- **JANGAN** menambahkan contoh kode detail di skill ini (contoh ada di skill spesifik).
- **JANGAN** membuat aturan baru di skill ini yang seharusnya ada di skill spesifik.

## Referensi Aturan Sumber

- `aturan_bersama.md` — Type Promotion, Import Ordering, Normalisasi Tanggal, Ekstraksi Perhitungan, Validasi Platform, Custom Exception, AsyncValue Handling, Form Validation, Unawaited Error
- `aturan_khusus.md` — Type Promotion Biodata, Normalisasi Tanggal, AsyncValue Handling, Form Validasi Tapering, Notifikasi Platform, Custom Exception Cadangan

## Referensi Commit Terkait

- `1e7b71e` — Type promotion di `biodata_screen.dart`
- `6fd979fd` — Normalisasi tanggal di `KalenderSmokeFreeScreen`
- `02aa6b29` — Normalisasi tanggal di `PemulihanKesehatanScreen`, `DashboardScreen`
- `19f43e5` — Multiple AsyncValue di `BadgeScreen`, ekstraksi perhitungan
- `3b67d309` — Async data handling di `DiaryCravingScreen`, `PemulihanKesehatanScreen`
- `ceacc6a` — Form validation tapering di `form_biodata.dart`
- `fd6b45a` — Unawaited Nav.to di `dashboard_screen.dart`
- `d80e637` — Unawaited EasyLoading di `form_biodata.dart`
- `338a021` — Unawaited cadangan, custom exception cadangan
- `774431d` — Platform validation notifikasi
- `0cb0e52` — `saran.md` findings platform/izin
- `07fc8df` — `IzinNotifikasiTidakDiberikanException`
- `c7337d1` — Guard pembagian di `ImpianProgresHelper`