# Contoh Input: AsyncValue Handling & Unawaited Error Handling

## Konteks
Layar memuat multiple provider async (biodata + impian). Perlu handle loading gabungan, error terpisah, dan data tidak lengkap. Navigasi & loading pakai unawaited dengan catchError.

## Permintaan
1. Loading gabungan (salah satu loading → indicator).
2. Error terpisah per provider dengan retry.
3. requireValue setelah aman.
4. Data tidak lengkap (biodata null) → tampilan terpisah.
5. Navigasi unawaited + catchError + L.e.
6. EasyLoading show/dismiss unawaited + catchError.

## Batasan
- JANGAN requireValue sebelum cek loading/error.
- JANGAN gabungkan error handling multi-provider.
- JANGAN unawaited tanpa catchError.

## Informasi Tambahan
- Provider: `biodataProvider`, `impianProvider` (Riverpod AsyncValue)
- Nav: `Nav.to(context, Halaman())`
- Loading: `EasyLoading.show/dismiss`