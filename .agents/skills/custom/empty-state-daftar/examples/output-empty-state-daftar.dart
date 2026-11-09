// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    // BENAR: SafeArea + Padding + Ikon + Judul + Deskripsi + CTA (FAB)
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              const Icon(CupertinoIcons.book, size: 48),
              const Text('Belum ada data', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Tekan tombol + untuk menambah data pertama.', textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class LayarBenar extends ConsumerWidget {
  const LayarBenar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(provider);
    // BENAR: Empty state informatif dengan CTA
    if (list.isEmpty) return const Scaffold(body: _EmptyState(), floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)));
    return ListView.builder(itemCount: list.length, itemBuilder: (_, i) => Text(list[i]));
  }
}

final provider = FutureProvider.autoDispose((ref) async => <String>[]);