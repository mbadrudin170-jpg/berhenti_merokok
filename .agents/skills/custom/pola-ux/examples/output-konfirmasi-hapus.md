# Contoh Output: Dialog Konfirmasi Hapus Data

## Sumber
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File rujukan: `lib/fitur/diary_craving/screens/form_diary_craving.dart`

## Implementasi
```dart
Future<void> _hapus(DiaryCravingModel craving) async {
  final konfirmasi = await showOkCancelAlertDialog(
    context: context,
    title: 'Hapus Craving',
    message: 'Apakah Anda yakin ingin menghapus catatan craving ini? '
        'Data yang dihapus tidak dapat dikembalikan.',
    okLabel: 'Hapus',
    cancelLabel: 'Batal',
    isDestructiveAction: true,
  );

  if (konfirmasi != OkCancelResult.ok) return;

  try {
    await ref.read(diaryCravingProvider.notifier).hapus(craving.id);
    if (mounted) {
      AppToast.sukses(context, 'Catatan craving berhasil dihapus');
    }
  } on Exception catch (e, s) {
    L.e('Gagal menghapus craving: $e $s');
    if (mounted) {
      AppToast.gagal(context, 'Gagal menghapus catatan');
    }
  }
}
```

## Penjelasan
1. **Dialog konfirmasi** menggunakan `showOkCancelAlertDialog` dengan `isDestructiveAction: true` → menampilkan warna merah pada tombol OK di platform yang mendukung.
2. **Pesan jelas** menyebutkan "catatan craving" dan "tidak dapat dikembalikan" → user tahu konsekuensi.
3. **Early return** jika user batal → tidak ada operasi hapus.
4. **Error handling** dengan `try/catch` + `L.e` + `AppToast.gagal` → feedback ke user.
5. **Cek `mounted`** sebelum akses `context` setelah `await` → mencegah crash jika widget sudah dispose.