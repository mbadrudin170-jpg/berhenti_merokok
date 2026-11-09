---
name: ekspor-pemulihan-cadangan
description: Panduan ekspor dan pemulihan data cadangan lokal - transaksi atomic, exception khusus, cek platform, flag double submit, unawaited catchError, mounted check, refresh provider, konfirmasi destruktif, AppToast, hapus file parsial gagal.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "338a0216257bb9f75617f144fd2fae0d7faf63d2"
  model: "kilo-auto/free"
---

# Ekspor dan Pemulihan Data Cadangan Lokal

Pemulihan dalam transaksi atomic, exception khusus, cek platform, flag double submit, unawaited catchError, mounted check, refresh provider, konfirmasi destruktif, AppToast.

## Aturan

1. Pemulihan data wajib dalam satu transaksi DB (`op.transaksi`) hapus lama → masuk baru, atomik konsisten.
2. Berkas cadangan tidak valid → exception khusus (class implements Exception), bukan string matching.
3. Cek platform (`kIsWeb`, `defaultTargetPlatform`) sebelum operasi berkas. Platform tidak didukung → warning, tidak crash.
4. Operasi async berulang (ekspor/pemulihan) dilindungi flag `_sedangMemproses` dicek awal, dikembalikan `finally` termasuk error.
5. unawaited (EasyLoading show/dismiss, Nav.to) wajib `.catchError(...)` log via `L.e`.
6. Setelah `await` wajib cek `mounted` sebelum akses context/setState.
7. Setelah pemulihan berhasil, refresh semua provider (`biodataProvider`, `impianProvider`, `diaryCravingProvider`, `alasanBerhentiProvider`) via `ref.refresh()`, try/catch `L.e`.
8. Operasi destruktif (pemulihan ganti data) wajib dialog konfirmasi `showOkCancelAlertDialog` dengan `isDestructiveAction: true`.
9. Feedback pakai `AppToast` (sukses/gagal/info), bukan `Fluttertoast` langsung.
10. Berkas parsial gagal ditulis wajib dihapus.

## Larangan

- Jangan pemulihan tanpa transaksi DB.
- Jangan string literal untuk nama exception deteksi.
- Jangan tampilkan kontrol ekspor/pemulihan di platform tidak mendukung.
- Jangan unawaited EasyLoading tanpa catchError.
- Jangan abaikan mounted check setelah await.
- Jangan simpan status berhasil sebelum operasi benar-benar selesai.

## Sumber Evaluasi

- Commit: `338a0216257bb9f75617f144fd2fae0d7faf63d2`
- File: `lib/fitur/cadangan/helper/cadangan_helper.dart`, `lib/fitur/cadangan/screens/cadangan_screen.dart`, `lib/fitur/pengaturan/screens/pengaturan_screen.dart`