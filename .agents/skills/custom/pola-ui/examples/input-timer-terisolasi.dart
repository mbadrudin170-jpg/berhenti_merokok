# Contoh Input: Widget Timer Terisolasi

## Konteks
Halaman SOS Craving menampilkan timer durasi craving yang update setiap detik. Halaman Pemulihan Kesehatan menampilkan durasi smoke-free yang update setiap detik. Hanya bagian timer yang harus rebuild, bukan seluruh halaman.

## Permintaan
Buat widget `StatefulWidget` terpisah untuk timer yang:
1. Menjalankan `Timer.periodic` setiap detik di `initState`.
2. Cek `mounted` sebelum `setState`.
3. `cancel()` timer di `dispose`.
4. Hanya widget ini yang rebuild.

## Batasan
- JANGAN taruh Timer di widget halaman (rebuild seluruh halaman).
- JANGAN lupa `mounted` check.
- JANGAN lupa `dispose` cancel timer.

## Informasi Tambahan
- SOS Craving: timer dari `_waktuMulaiCraving` (DateTime mulai craving)
- Pemulihan Kesehatan: timer dari `tanggalBerhenti` (DateTime berhenti merokok)