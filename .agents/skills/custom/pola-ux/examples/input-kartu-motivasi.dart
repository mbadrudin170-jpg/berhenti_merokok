// commit: e6595744b3840998d840e398ca1782e7be7d50b4
// Input: Kartu motivasi dengan akses data async tidak aman

Widget buildKartuMotivasiSalah(WidgetRef ref) {
  // SALAH: requireValue pada data opsional → crash saat loading/error
  final alasanAsync = ref.watch(alasanBerhentiProvider);
  final jumlah = alasanAsync.requireValue.jumlahAlasan;
  
  // SALAH: Navigasi tanpa catchError
  return TextButton(
    onPressed: () => unawaited(Nav.to(context, const AlasanBerhentiScreen())),
    child: Text('Kelola ($jumlah)'),
  );
}