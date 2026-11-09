// commit: 19f43e510b1478a43c5f0594efeef6f83b6c0299
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerA = FutureProvider<String>((ref) async => 'A');
final providerB = FutureProvider<String>((ref) async => 'B');

class LayarSalah extends ConsumerWidget {
  const LayarSalah({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SALAH: requireValue tanpa handle loading/error
    final a = ref.watch(providerA).requireValue;
    final b = ref.watch(providerB).requireValue;
    return Text('$a $b');
  }
}