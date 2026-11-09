# Contoh Input: Visualisasi Progres Impian

## Konteks
Impian memiliki target uang (jumlah) dan saldo terkumpul (uang dihemat dari biodata). Perlu menampilkan progress bar visual dengan rasio, status tercapai, dan sisa uang.

## Permintaan
Buat:
1. Helper murni `ImpianProgresHelper` (static methods, no BuildContext/provider) dengan guard pembagian nol.
2. Widget `VisualTabunganImpian` menggunakan `Stack` + `LinearProgressIndicator` + `Icon` (no aset gambar).
3. Rasio di-clamp 0.0-1.0 sebelum ke LinearProgressIndicator.
4. Warna progress: hijau jika tercapai, primary jika belum.

## Batasan
- Helper harus pure class (testable, reusable).
- JANGAN aset gambar/Lottie.
- JANGAN rasio > 1.0 ke LinearProgressIndicator.
- Guard `target <= 0` wajib di helper.

## Informasi Tambahan
- Saldo: `biodata?.uangDihemat ?? 0` (dari ekstensi BiodataModelPerhitungan)
- Target: `impian.jumlah`
- Warna background: `warnaProgres.withValues(alpha: 0.2)`