---
name: pola-ui
description: Indeks pola UI standar - merujuk ke skill spesifik untuk visualisasi progres impian, isolasi widget timer, withValues opacity, normalisasi tanggal UI, widget custom reusable.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "c7337d1519d495d0ccd022fb18d63f72d443866a"
  model: "kilo-auto/free"
---

# Indeks Pola UI Standar

Skill ini berfungsi sebagai **indeks/ringkasan** yang merujuk ke skill spesifik untuk setiap pola UI. **Jangan menduplikasi isi skill spesifik di sini.**

## Daftar Skill Spesifik yang Relevan

| Topik | Skill Spesifik | Deskripsi Singkat |
|-------|----------------|-------------------|
| Visualisasi Progres Impian | `visualisasi-progres-impian` | Helper murni `ImpianProgresHelper`, guard divisi nol, `VisualTabunganImpian` widget (Stack + LinearProgressIndicator), clamp rasio 0-1, SharedPreferences penandaan perayaan, AppToast sukses, saldo dari `biodata.uangDihemat` |
| Isolasi Widget Timer/Animasi | `isolasi-widget-timer` | Widget `StatefulWidget` terpisah untuk `Timer.periodic`; hanya widget itu rebuild; `cancel()` di `dispose()`; cek `mounted` di callback |
| Penggunaan `withValues` Opacity | `withvalues-opacity-warna` / `gaya` | `warna.withValues(alpha: ...)` wajib; `withOpacity()` deprecated; konsisten di seluruh widget |
| Normalisasi Tanggal untuk UI | `normalisasi-tanggal` | Normalisasi `DateTime` ke komponen tanggal sebelum tampilkan status hari/hitung total hari; klamp negatif ke 0 |
| Widget Custom Reusable | `widget-custom` | `VisualTabunganImpian`, `_TimerCravingView`, `_HeaderPemulihan`, `_EmptyDiaryCraving`, `_PlaceholderAlasanBerhenti`, `_ErrorRetry`, `_LoadingView` |

## Prinsip Umum Pola UI

1. **Single Responsibility**: Setiap widget handle 1 hal (timer, progress, empty, error, loading).
2. **Terisolasi Timer**: Timer di widget kecil sendiri, bukan halaman penuh.
3. **Pure Widget**: Logika bisnis di helper/provider, widget hanya render.
4. **SafeArea + Padding**: Empty/Error/Loading state handle padding tepi sendiri.
5. **unawaited + catchError**: Navigasi non-blocking dengan error handling.
6. **textTheme + copyWith**: Styling konsisten via tema.
7. **Column.spacing**: Jarak konsisten tanpa `SizedBox` berulang.

## Larangan Umum (Ringkasan)

- **DILARANG** `withOpacity()` → gunakan `withValues(alpha:)` (lihat `withvalues-opacity-warna` / `gaya`).
- **DILARANG** timer di widget halaman penuh → isolasi ke widget kecil (lihat `isolasi-widget-timer`).
- **DILARANG** lupa `cancel()` di `dispose()` untuk timer (lihat `isolasi-widget-timer`).
- **DILARANG** lupa cek `mounted` di callback timer (lihat `isolasi-widget-timer`).
- **DILARANG** aset gambar/Lottie untuk visual progres → gunakan `Stack` + `LinearProgressIndicator` + `Icon` (lihat `visualisasi-progres-impian` / `widget-custom`).
- **DILARANG** rasio progres tanpa clamp → `LinearProgressIndicator` error jika > 1.0 (lihat `visualisasi-progres-impian`).
- **DILARANG** perbandingan tanggal tanpa normalisasi → hasil bisa salah 1 hari (lihat `normalisasi-tanggal`).

## Pengecualian

- Animasi kompleks yang memerlukan `AnimationController` → gunakan pattern isolasi serupa (controller di widget terpisah, dispose di `dispose()`).

## Referensi Aturan Sumber

- `aturan_bersama.md` — Isolasi Widget Timer, withValues Opacity, Normalisasi Tanggal
- `aturan_khusus.md` — Visualisasi Progres Impian, Normalisasi Tanggal Kalender

## Referensi Commit Terkait

- `c7337d1` — `ImpianProgresHelper`, `VisualTabunganImpian`, `DetailImpianScreen`
- `3b67d309` — `_TimerCravingView` di `SosCravingScreen`, `warna.withValues(alpha: 0.2)`
- `02aa6b29` — `_HeaderPemulihan` di `PemulihanKesehatanScreen`
- `6fd979fd` — `_SelHari`, `_GridKalender` di `KalenderSmokeFreeScreen`