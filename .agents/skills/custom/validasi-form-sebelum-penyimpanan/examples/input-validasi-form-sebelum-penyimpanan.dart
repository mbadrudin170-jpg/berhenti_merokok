// commit: ceacc6a1c388b24b7647a37ccde411d6c85ee01c
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormBiodataSalah extends ConsumerStatefulWidget {
  const FormBiodataSalah({super.key});
  @override
  ConsumerState<FormBiodataSalah> createState() => _FormBiodataSalahState();
}

class _FormBiodataSalahState extends ConsumerState<FormBiodataSalah> {
  final _penurunanPerMingguController = TextEditingController();

  Future<void> _simpan() async {
    // SALAH: Tidak ada Form/validate
    // SALAH: Parsing gagal diganti 0 - menyembunyikan input tidak valid
    final penurunan = int.tryParse(_penurunanPerMingguController.text.trim()) ?? 0;
    
    // SALAH: Menyimpan langsung tanpa validasi
    await ref.read(biodataProvider.notifier).simpan(BiodataModel(
      penurunanPerMinggu: penurunan,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _penurunanPerMingguController,
          keyboardType: TextInputType.number,
          // SALAH: Tidak ada validator
        ),
        ElevatedButton(onPressed: _simpan, child: const Text('Simpan')),
      ],
    );
  }
}

class BiodataModel {
  final int penurunanPerMinggu;
  BiodataModel({required this.penurunanPerMinggu});
}

final biodataProvider = FutureProvider.autoDispose((ref) async => BiodataModel(penurunanPerMinggu: 0));