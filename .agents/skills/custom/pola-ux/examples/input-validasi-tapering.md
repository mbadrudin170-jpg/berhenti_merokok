# Contoh Input: Validasi Form Mode Tapering

## Konteks
Form biodata memiliki mode berhenti bertahap (tapering) dengan input `penurunanPerMinggu` (integer positif). Input ini wajib divalidasi: tidak kosong, bukan nol, bukan negatif. Jika validasi gagal, simpan dibatalkan.

## Permintaan
Implementasikan form dengan:
1. `Form` + `GlobalKey<FormState>` membungkus field.
2. `TextFormField` dengan `validator` memvalidasi aturan bisnis (positif).
3. Panggil `validate()` sebelum simpan.
4. JANGAN gunakan `int.tryParse(...) ?? 0`.

## Batasan
- Validasi format ≠ validasi bisnis.
- Parsing gagal → tampilkan error ke user, JANGAN ganti dengan 0.
- Mode tapering hanya valid jika `penurunanPerMinggu > 0` dan `tanggalMulaiTapering` valid.

## Informasi Tambahan
- Enum: `ModeBerhenti.seketika` | `ModeBerhenti.bertahap`
- Field: `_penurunanPerMingguController`, `_tanggalMulaiTapering`
- Penyimpanan: `ref.read(biodataProvider.notifier).simpan(model)`