# Contoh Input: Widget Custom VisualTabunganImpian

## Konteks
Butuh widget reusable menampilkan progress impian: progress bar visual, label terkumpul/sisa, warna berubah saat tercapai. Menggunakan komponen Flutter bawaan (no aset gambar).

## Permintaan
Buat `StatelessWidget` `VisualTabunganImpian` dengan:
1. Properti: `rasio` (0.0-1.0), `saldo`, `target`.
2. `Stack` + `FractionallySizedBox` untuk progress bar custom.
3. Warna: hijau jika tercapai, `ColorScheme.primary` jika belum.
4. Background opacity 0.2 dengan `withValues`.
5. `Column(spacing: 8)` untuk progress + label row.
6. `FontFeature.tabularFigures()` untuk angka uang.

## Batasan
- JANGAN `LinearProgressIndicator` langsung (butuh custom visual).
- JANGAN aset gambar/Lottie.
- JANGAN logika hitung rasio/tercapai di widget → gunakan `ImpianProgresHelper`.
- Widget pure: hanya render, logika di helper/provider.

## Informasi Tambahan
- Helper: `ImpianProgresHelper.rasio()`, `.tercapai()`, `.sisa()`
- Format uang: `FormatUang.format()`