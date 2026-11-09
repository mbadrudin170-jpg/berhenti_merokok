// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
// Output: Dialog konfirmasi destruktif sebelum hapus data

Future<void> hapusDenganKonfirmasi(DiaryCravingModel craving) async {
  // BENAR: Tampilkan dialog konfirmasi destruktif
  final konfirmasi = await showOkCancelAlertDialog(
    context: context,
    title: 'Hapus Craving',
    message: 'Apakah Anda yakin ingin menghapus catatan craving ini? '
        'Data yang dihapus tidak dapat dikembalikan.',
    okLabel: 'Hapus',
    cancelLabel: 'Batal',
    isDestructiveAction: true,
  );

  // Early return jika user batal
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