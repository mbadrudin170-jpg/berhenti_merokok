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

  bool _isLoading = false;
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

  void _simpan() {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      Nav.pop(context);
    } catch (e) {
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
          OutlinedButton(onPressed: () => _simpan(), child: Text('Simpan')),
        ],
      ),
    );
  }
}
