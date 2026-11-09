// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LayarSalah extends ConsumerWidget {
  const LayarSalah({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(provider);
    // SALAH: Layar kosong tanpa informasi atau CTA
    if (list.isEmpty) return const Scaffold(body: SizedBox.shrink());
    return ListView.builder(itemCount: list.length, itemBuilder: (_, i) => Text(list[i]));
  }
}

final provider = FutureProvider.autoDispose((ref) async => <String>[]);