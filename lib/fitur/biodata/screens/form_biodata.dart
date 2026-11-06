import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class FormBiodata extends ConsumerStatefulWidget {
  const FormBiodata({super.key});

  @override
  ConsumerState<FormBiodata> createState() => _BiodataScreenState();
}

class _BiodataScreenState extends ConsumerState<FormBiodata> {
  final _namaController = TextEditingController();
  final _namaFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _namaFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('data')),
      body: Column(
        children: [
          InputTeks(
            controller: _namaController,
            label: 'Label',
            hintText: 'Hint',
            validator: (value) {
              return null;
            },
            focusNode: null,
            nextFocusNode: null,
          ),
        ],
      ),
    );
  }
}
