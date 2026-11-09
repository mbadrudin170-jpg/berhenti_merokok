# Contoh Input: Spacing Card Impian dengan Column.spacing

## Konteks
Card impian berisi: judul + chip status, progress bar visual, label info (terkumpul/sisa). Elemen-elemen ini butuh jarak konsisten.

## Permintaan
Gunakan `Column.spacing` untuk jarak seragam antar elemen card. `SizedBox` hanya untuk jarak khusus jika perlu.

## Batasan
- JANGAN `SizedBox` berulang.
- `spacing` nilai konsisten (mis. 12).
- Padding internal card 16 (standar komponen).

## Informasi Tambahan
- `Card` → `Padding(16)` → `Column(spacing: 12)`
- Elemen: Row(judul+chip), VisualTabunganImpian, Row(label info)