# Contoh Input: Type Promotion & Normalisasi Tanggal

## Konteks
BiodataScreen menampilkan field nullable dari BiodataModel (tanggalLahir, tanggalMulaiMerokok, tanggalMulaiBerhentiMerokok). Perlu type promotion aman dan normalisasi tanggal untuk hitung hari.

## Permintaan
1. Copy field nullable ke variabel lokal sebelum null-check.
2. Normalisasi tanggal ke DateTime(tahun, bulan, hari) sebelum difference().
3. Klamp hasil negatif ke 0.

## Batasan
- JANGAN pakai `biodata.field!`.
- JANGAN `DateTime.now().difference(tanggal)` tanpa normalisasi.

## Informasi Tambahan
- Model: `BiodataModel` (Freezed, field nullable)
- Helper: `FormatTanggal.formatDasar()`