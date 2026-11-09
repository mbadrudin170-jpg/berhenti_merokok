# Contoh Input: Hierarki Teks Card Info Impian

## Konteks
Card menampilkan info impian dengan 3 tingkat: Label (Total Pengeluaran), Sub-Label (Pengeluaran bulan ini), Nilai Utama (Rp500.000). Setiap tingkat harus beda visual jelas.

## Permintaan
Implementasikan hierarki teks dengan:
1. `textTheme` sebagai dasar.
2. `copyWith()` untuk variasi ukuran/weight/warna.
3. Minimal 1 properti beda per tingkat.
4. Bold hanya pada nilai utama.

## Batasan
- JANGAN manual `TextStyle(fontSize: ...)` tanpa `textTheme`.
- JANGAN gaya identik untuk tingkat berbeda.

## Informasi Tambahan
- Label: `bodySmall` (kecil, muted)
- Sub-Label: `bodyMedium` + warna secondary
- Nilai: `titleLarge` + bold