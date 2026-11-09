// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
// Input: Dialog konfirmasi sebelum hapus data (tanpa validasi)

Future<void> hapusTanpaKonfirmasi(DiaryCravingModel craving) async {
  // SALAH: Langsung hapus tanpa konfirmasi user
  await ref.read(diaryCravingProvider.notifier).hapus(craving.id);
}