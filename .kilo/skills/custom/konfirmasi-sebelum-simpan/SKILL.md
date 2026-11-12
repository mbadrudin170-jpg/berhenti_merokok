---
name: konfirmasi-sebelum-simpan
description: Panduan konfirmasi sebelum menyimpan pada form - tampilkan dialog konfirmasi, hanya simpan jika OK, flag loading + EasyLoading selama proses.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  diperbarui: "Thu Nov 12 06:27:35 WIB 2026"
  sumber-terakhir: "perintah pengguna: perbarui skill index"
  model: "kilo-auto/free"
---

# Konfirmasi sebelum Menyimpan pada Form

Sebelum menyimpan data, tampilkan dialog konfirmasi, hanya jalankan jika OK, flag loading + EasyLoading selama proses.

## Aturan

1. Sebelum menyimpan data, tampilkan dialog konfirmasi (`showOkCancelAlertDialog`) yang menjelaskan tindakan yang akan dilakukan.
2. Hanya jalankan penyimpanan jika pengguna menekan OK.
3. Selama proses penyimpanan, aktifkan flag `_isLoading` dan tampilkan loading overlay (`EasyLoading`).
4. Setelah selesai (berhasil/gagal), hentikan loading dan kembalikan flag.

## Larangan

- Jangan menyimpan data tanpa konfirmasi pengguna.
- Jangan membiarkan proses penyimpanan berjalan tanpa indikator loading.

## Contoh Benar

```dart
final konfirmasi = await showOkCancelAlertDialog(
  context: context,
  title: 'Simpan Craving',
  message: 'Apakah Anda yakin ingin menyimpan catatan craving ini?',
  okLabel: 'Simpan',
  cancelLabel: 'Batal',
);
if (konfirmasi != OkCancelResult.ok) return;
```

## Contoh Salah

```dart
// Menyimpan langsung tanpa konfirmasi.
await ref.read(diaryCravingProvider.notifier).tambah(model);
```

## Sumber Evaluasi

- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/diary_craving/screens/form_diary_craving.dart`
