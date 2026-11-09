// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.onRetry});
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Text('Gagal memuat data'), OutlinedButton(onPressed: onRetry, child: const Text('Coba lagi'))])));
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) => const SafeArea(child: Padding(padding: EdgeInsets.all(16), child: Center(child: Column(mainAxisSize: MainAxisSize.min, spacing: 8, children: [Icon(Icons.inbox, size: 48), Text('Belum ada data', style: TextStyle(fontWeight: FontWeight.bold)), Text('Tekan + untuk menambah data.', textAlign: TextAlign.center)]))));
}

class _DataTidakLengkap extends StatelessWidget {
  const _DataTidakLengkap();
  @override
  Widget build(BuildContext context) => const SafeArea(child: Padding(padding: EdgeInsets.all(16), child: Center(child: Column(mainAxisSize: MainAxisSize.min, spacing: 8, children: [Icon(Icons.warning, size: 48), Text('Data tidak lengkap', style: TextStyle(fontWeight: FontWeight.bold)), Text('Isi biodata terlebih dahulu.', textAlign: TextAlign.center)]))));
}

class LayarBenar extends ConsumerWidget {
  const LayarBenar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(provider);

    // BENAR: Handle isLoading
    if (dataAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    // BENAR: Handle hasError dengan retry
    if (dataAsync.hasError) {
      return _ErrorRetry(onRetry: () => ref.refresh(provider));
    }

    final state = dataAsync.requireValue;
    // BENAR: Handle empty state
    if (state.isEmpty) {
      return const Scaffold(body: _EmptyState(), floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)));
    }
    // BENAR: Handle data tidak lengkap (mis. biodata null)
    if (state.firstOrNull == null) {
      return const Scaffold(body: _DataTidakLengkap());
    }

    return Scaffold(body: ListView.builder(itemCount: state.length, itemBuilder: (_, i) => Text(state[i])));
  }
}

final provider = FutureProvider.autoDispose((ref) async => <String>[]);