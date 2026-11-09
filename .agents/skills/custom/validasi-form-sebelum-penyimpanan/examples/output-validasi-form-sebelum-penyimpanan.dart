// commit: ceacc6a1c388b24b7647a37ccde411d6c85ee01c
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormBiodataBenar extends ConsumerStatefulWidget {
  const FormBiodataBenar({super.key});
  @override
  ConsumerState<FormBiodataBenar> createState() => _FormBiodataBenarState();
}

class _FormBiodataBenarState extends ConsumerState<FormBiodataBenar> {
  final _formKey = GlobalKey<FormState>();
  final _penurunanPerMingguController = TextEditingController();

  Future<void> _simpan() async {
    // BENAR: Panggil validate() sebelum menyimpan
    if (!(_formKey.currentState?.validate() ?? false)) return;
    
    // BENAR: Parsing AMAN karena sudah divalidasi
    final penurunan = int.parse(_penurunanPerMingguController.text.trim());
    
    await ref.read(biodataProvider.notifier).simpan(BiodataModel(
      penurunanPerMinggu: penurunan,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _penurunanPerMingguController,
            keyboardType: TextInputType.number,
            // BENAR: Validator memeriksa aturan bisnis (positif)
            validator: (value) {
              final n = int.tryParse(value ?? '');
              if (n == null || n <= 0) return 'Wajib bilangan bulat positif';
              return null;
            },
          ),
          ElevatedButton(onPressed: _simpan, child: const Text('Simpan')),
        ],
      ),
    );
  }
}

class BiodataModel {
  final int penurunanPerMinggu;
  BiodataModel({required this.penurunanPerMinggu});
}

final biodataProvider = FutureProvider.autoDispose((ref) async => BiodataModel(penurunanPerMinggu: 0));