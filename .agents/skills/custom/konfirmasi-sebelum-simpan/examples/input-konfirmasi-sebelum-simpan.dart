// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormSalah extends ConsumerStatefulWidget {
  const FormSalah({super.key});
  @override
  ConsumerState<FormSalah> createState() => _FormSalahState();
}

class _FormSalahState extends ConsumerState<FormSalah> {
  Future<void> _simpan() async {
    // SALAH: Simpan langsung tanpa konfirmasi
    await ref.read(provider.notifier).tambah(Model());
    // SALAH: Tidak ada loading indicator
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _simpan, child: const Text('Simpan'));
  }
}

class Model {}
final provider = FutureProvider.autoDispose((ref) async => []);