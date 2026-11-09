// commit: e6595744b3840998d840e398ca1782e7be7d50b4
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardSalah extends ConsumerWidget {
  const DashboardSalah({super.key});
  @override Widget build(BuildContext context, WidgetRef ref) {
    final alasanAsync = ref.watch(alasanBerhentiProvider);
    
    // SALAH: requireValue untuk data opsional
    final jumlah = alasanAsync.requireValue.jumlahAlasan;
    
    // SALAH: Navigasi tanpa catchError
    return Column(children: [
      Text('Alasan: $jumlah'),
      ElevatedButton(onPressed: () => unawaited(Nav.to(context, const SosCravingScreen())), child: const Text('SOS')),
    ]);
  }
}