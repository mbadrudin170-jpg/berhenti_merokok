// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
// Output: Empty state informatif dengan ikon, judul, deskripsi, dan CTA

class _EmptyDiaryCraving extends StatelessWidget {
  const _EmptyDiaryCraving();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              const Icon(CupertinoIcons.book, size: 48),
              const Text(
                'Belum ada catatan craving',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'Tekan tombol + untuk mencatat craving pertama.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => unawaited(
                  Nav.to(context, const FormDiaryCraving()).catchError(
                    (e, s) => L.e('Gagal navigasi form craving: $e $s'),
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Tambah Craving'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Penggunaan di layar dengan early return pattern:
@override
Widget build(BuildContext context) {
  final stateAsync = ref.watch(diaryCravingProvider);

  if (stateAsync.isLoading) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
  if (stateAsync.hasError) {
    return _ErrorRetry(onRetry: () => ref.refresh(diaryCravingProvider));
  }

  final state = stateAsync.requireValue;
  if (state.listCraving.isEmpty) {
    return const Scaffold(body: _EmptyDiaryCraving());
  }

  return Scaffold(
    body: ListView.builder(...),
    floatingActionButton: FloatingActionButton(
      onPressed: () => unawaited(
        Nav.to(context, const FormDiaryCraving()).catchError(...),
      ),
      child: const Icon(Icons.add),
    ),
  );
}