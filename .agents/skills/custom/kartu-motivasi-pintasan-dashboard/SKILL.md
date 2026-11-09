---
name: kartu-motivasi-pintasan-dashboard
description: Panduan kartu motivasi dan pintasan aksi cepat dashboard/SOS Craving - unawaited Nav.to catchError, asData?.value untuk data opsional, log variabel UI, FilterChip logging, SizedBox.shrink untuk data kosong.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "e6595744b3840998d840e398ca1782e7be7d50b4"
  model: "kilo-auto/free"
---

# Kartu Motivasi dan Pintasan Aksi Cepat pada Dashboard dan SOS Craving

Pintasan Nav.to unawaited catchError, asData?.value untuk data opsional, log variabel UI, FilterChip logging, SizedBox.shrink data kosong.

## Aturan

1. Pintasan navigasi (SOS Craving, Alasan Berhenti) pada dashboard wajib `unawaited(Nav.to(...).catchError(...))` dengan `L.e`.
2. Akses data async opsional (jumlah alasan, daftar terbaru) pakai `alasanAsync.asData?.value ?? fallback`, bukan `requireValue`.
3. Variabel relevan di method UI wajib log `L.i`/`L.w` per aturan logging.
4. FilterChip pilihan cepat form alasan berhenti wajib log `L.i('snippet=$snippet, terpilih=$terpilih')` dan `L.i('snippet dipilih=$snippet, dipilih=$dipilih')`.
5. Data opsional kosong → `const SizedBox.shrink()` dengan `L.w`, bukan error/crash.

## Larangan

- Jangan `alasanAsync.requireValue` untuk data opsional.
- Jangan tampilkan kartu motivasi tanpa cek data kosong.
- Jangan navigasi pintasan tanpa `.catchError()` pada `unawaited()`.

## Sumber Evaluasi

- Commit: `e6595744b3840998d840e398ca1782e7be7d50b4`
- File: `lib/fitur/dashboard/screens/dashboard_screen.dart`, `lib/fitur/sos_craving/screens/sos_craving_screen.dart`, `lib/fitur/alasan_berhenti/screens/form_alasan_berhenti.dart`