# Contoh Input: Kartu Motivasi dan Pintasan Aksi Cepat

## Konteks
Dashboard menampilkan kartu motivasi (alasan berhenti terbaru) dan pintasan aksi cepat (SOS Craving, Kelola Alasan Berhenti). Data alasan bersifat opsional (async) dan tidak boleh memblokir rendering halaman.

## Permintaan
Implementasikan:
1. Akses data async opsional dengan `asData?.value ?? fallback`.
2. Navigasi pintasan dengan `unawaited(Nav.to(...).catchError(...))`.
3. Logging variabel relevan dengan `L.i`/`L.w`.
4. Handle data kosong dengan `SizedBox.shrink()` + `L.w`.

## Batasan
- JANGAN gunakan `requireValue` untuk data opsional.
- JANGAN navigasi tanpa `.catchError()`.
- FilterChip pada form alasan wajib log pilihan user.

## Informasi Tambahan
- Provider: `alasanBerhentiProvider` (AsyncValue<AlasanBerhentiState>)
- Snippet pilihan cepat: 8 item predefined