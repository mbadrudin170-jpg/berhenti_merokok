# Contoh Input: Perayaan Pencapaian Impian (Toast Sekali)

## Konteks
Ketika impian tercapai (saldo terkumpul >= target), tampilkan toast perayaan. Toast harus hanya muncul **sekali per impian** (persist di SharedPreferences), tidak berulang setiap rebuild/restart aplikasi.

## Permintaan
Implementasikan:
1. Cek pencapaian menggunakan helper `ImpianProgresHelper.tercapai()`.
2. Cek apakah sudah diraikan via `SharedPreferences` (key: `impian_diraikan`).
3. Jika belum, tampilkan `AppToast.sukses` dan tandai sudah diraikan.
4. Penandaan dengan `unawaited()` non-blocking.

## Batasan
- JANGAN tampilkan toast berulang untuk impian yang sama.
- JANGAN simpan penandaan di memori saja (hilang saat restart).
- Gunakan `unawaited()` untuk toast dan penandaan.

## Informasi Tambahan
- Saldo terkumpul: `biodata?.uangDihemat ?? 0` (dari ekstensi BiodataModelPerhitungan)
- Target: `impian.jumlah`
- Helper: `ImpianProgresHelper.tercapai(saldo, target)`