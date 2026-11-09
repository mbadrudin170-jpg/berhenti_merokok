---
name: widget-custom
description: Indeks widget custom reusable - merujuk ke skill spesifik untuk VisualTabunganImpian, timer widgets terisolasi, empty state widgets, error retry, loading view.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "c7337d1519d495d0ccd022fb18d63f72d443866a"
  model: "kilo-auto/free"
---

# Indeks Widget Custom Reusable

Skill ini berfungsi sebagai **indeks/ringkasan** yang merujuk ke skill spesifik untuk setiap widget custom. **Jangan menduplikasi isi skill spesifik di sini.**

## Daftar Widget Custom & Skill Spesifik

| Widget | Skill Spesifik | Deskripsi Singkat |
|--------|----------------|-------------------|
| `VisualTabunganImpian` | `visualisasi-progres-impian` / `widget-custom` | Progress visual impian: Stack + FractionallySizedBox, rasio clamp 0-1, warna kondisional, tabular figures, pure widget |
| `_TimerCravingView` | `isolasi-widget-timer` | Timer craving terisolasi: StatefulWidget, Timer.periodic 1 detik, mounted check, cancel di dispose, tabular figures MM:SS |
| `_HeaderPemulihan` | `isolasi-widget-timer` | Header durasi smoke-free terisolasi: Timer.periodic 1 detik, normalisasi tanggal, klamp negatif, Card + Column.spacing |
| `_EmptyDiaryCraving` | `empty-state-daftar` | Empty state diary craving: SafeArea + Padding(16), Icon + Judul Bold + Deskripsi, FAB CTA dengan unawaited+catchError |
| `_PlaceholderAlasanBerhenti` | `kartu-motivasi-pintasan-dashboard` / `empty-state-daftar` | Placeholder alasan berhenti di SOS Craving: Card + Padding, Icon + Text grey, Row layout |
| `_ErrorRetry` | `penanganan-async-data-kosong` / `penanganan-asyncvalue-berkali` | Error state reusable: Icon + pesan + FilledButton retry, onRetry callback untuk ref.refresh(provider) |
| `_LoadingView` | `penanganan-async-data-kosong` | Loading state reusable: Scaffold + Center + CircularProgressIndicator |

## Prinsip Umum Widget Custom Reusable

| Prinsip | Implementasi |
|---------|--------------|
| **Single Responsibility** | Setiap widget handle 1 hal (timer, progress, empty, error, loading) |
| **Terisolasi Timer** | Timer di widget kecil sendiri, bukan halaman (lihat `isolasi-widget-timer`) |
| **Pure Widget** | Logika bisnis di helper/provider, widget hanya render (lihat `visualisasi-progres-impian`, `ekstraksi-perhitungan-turunan`) |
| **SafeArea + Padding** | Empty/Error/Loading state handle padding tepi sendiri (lihat `empty-state-daftar`, `spacing`) |
| **unawaited + catchError** | Navigasi non-blocking dengan error handling (lihat `penanganan-error-unawaited`, `kartu-motivasi-pintasan-dashboard`) |
| **textTheme + copyWith** | Styling konsisten via tema (lihat `tipografi`) |
| **Column.spacing** | Jarak konsisten tanpa `SizedBox` berulang (lihat `spacing`) |

## Larangan (Ringkasan)

- **DILARANG** timer di widget halaman penuh → isolasi ke widget kecil (lihat `isolasi-widget-timer`).
- **DILARANG** aset gambar/Lottie untuk progress visual → gunakan `Stack` + `LinearProgressIndicator` + `Icon` (lihat `visualisasi-progres-impian`).
- **DILARANG** widget reusable ambil tanggung jawab padding tepi layar (kecuali empty/error/loading yang dipakai langsung di `Scaffold.body`) (lihat `spacing`).
- **DILARANG** logika bisnis (hitung rasio, cek tercapai) di widget → gunakan helper murni (lihat `visualisasi-progres-impian`, `ekstraksi-perhitungan-turunan`).

## Referensi Aturan Sumber

- `aturan_bersama.md` — Isolasi Widget Timer, Visualisasi Progres, Ekstraksi Perhitungan
- `aturan_khusus.md` — Visualisasi Progres, Timer Terisolasi, Empty State, Kartu Motivasi

## Referensi Commit Terkait

- `c7337d1` — `VisualTabunganImpian`, `ImpianProgresHelper`, `DetailImpianScreen`
- `3b67d309` — `_TimerCravingView`, `_EmptyDiaryCraving`, `_ErrorRetry`, `_LoadingView`
- `02aa6b29` — `_HeaderPemulihan`
- `e659574` — `_PlaceholderAlasanBerhenti`