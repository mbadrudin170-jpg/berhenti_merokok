# Contoh Input: Styling Warna Progress Bar Kondisional

## Konteks
Progress bar impian berubah warna: hijau jika target tercapai, primary theme jika belum. Background progress bar menggunakan opacity 0.2 dari warna progress.

## Permintaan
Implementasikan styling progress bar dengan:
1. Warna kondisional (hijau/primary).
2. Background dengan `withValues(alpha: 0.2)`.
3. Menggunakan `ColorScheme` untuk warna primary, hardcode untuk semantic green.

## Batasan
- JANGAN gunakan `withOpacity()`.
- JANGAN hardcode warna primary theme.
- Hanya hardcode hijau semantic (status sukses).

## Informasi Tambahan
- `sudahTercapai` boolean dari `ImpianProgresHelper.tercapai()`.
- `Theme.of(context).colorScheme.primary` untuk warna tema.