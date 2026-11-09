// commit: 19f43e510b1478a43c5f0594efeef6f83b6c0299
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerA = FutureProvider<String>((ref) async => 'A');
final providerB = FutureProvider<String>((ref) async => 'B');

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.onRetry});
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data'),
            OutlinedButton(onPressed: onRetry, child: const Text('Coba lagi')),
          ],
        ),
      ),
    );
  }
}

class LayarBenar extends ConsumerWidget {
  const LayarBenar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aAsync = ref.watch(providerA);
    final bAsync = ref.watch(providerB);

    // BENAR: Handle loading gabungan
    if (aAsync.isLoading || bAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // BENAR: Handle error terpisah per provider
    if (aAsync.hasError) {
      return _ErrorRetry(onRetry: () => ref.refresh(providerA));
    }
    if (bAsync.hasError) {
      return _ErrorRetry(onRetry: () => ref.refresh(providerB));
    }

    // BENAR: requireValue SETELAH loading/error ditangani
    final a = aAsync.requireValue;
    final b = bAsync.requireValue;

    return Text('$a $b');
  }
}