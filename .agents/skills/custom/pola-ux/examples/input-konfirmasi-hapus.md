# Contoh Input: Dialog Konfirmasi Hapus Data

## Konteks
Pengguna menekan tombol hapus pada item daftar (diary craving, impian, alasan berhenti). Sebelum menghapus, aplikasi harus menampilkan dialog konfirmasi yang menjelaskan konsekuensi.

## Permintaan
Implementasikan dialog konfirmasi destruktif sebelum menghapus data.

## Batasan
- Gunakan `showOkCancelAlertDialog` dari `adaptive_dialog`.
- Sertakan `isDestructiveAction: true`.
- Pesan wajib menyebutkan data yang terpengaruh dan tidak bisa dikembalikan.
- Hanya hapus jika user menekan OK.

## Informasi Tambahan
- Provider: `diaryCravingProvider` (Riverpod)
- Method hapus: `ref.read(diaryCravingProvider.notifier).hapus(id)`