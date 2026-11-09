// commit: ceacc6a1c388b24b7647a37ccde411d6c85ee01c
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormTaperingSalah extends ConsumerStatefulWidget {
  const FormTaperingSalah({super.key});
  @override ConsumerState<FormTaperingSalah> createState() => _FormTaperingSalahState();
}

class _FormTaperingSalahState extends ConsumerState<FormTaperingSalah> {
  final _penurunanController = TextEditingController();
  ModeBerhenti _mode = ModeBerhenti.seketika;

  Future<void> _simpan() async {
    // SALAH: Parsing gagal diganti 0 tanpa validasi
    final penurunan = int.tryParse(_penurunanController.text.trim()) ?? 0;
    
    // SALAH: Simpan mode bertahap tanpa validasi penurunan > 0
    await ref.read(biodataProvider.notifier).simpan(BiodataModel(
      modeBerhenti: _mode,
      penurunanPerMinggu: penurunan,
    ));
  }

  @override Widget build(BuildContext context) => Column(children: [
    DropdownButton<ModeBerhenti>(value: _mode, items: ModeBerhenti.values.map((e) => DropdownMenuItem(value: e, child: Text(e.label))).toList(), onChanged: (v) => setState(() => _mode = v!)),
    TextFormField(controller: _penurunanController, keyboardType: TextInputType.number), // SALAH: no validator
    ElevatedButton(onPressed: _simpan, child: const Text('Simpan')),
  ]);
}

enum ModeBerhenti { seketika, bertahap }
extension ModeBerhentiExtension on ModeBerhenti { String get label => name; }

class BiodataModel { final ModeBerhenti modeBerhenti; final int penurunanPerMinggu; BiodataModel({required this.modeBerhenti, required this.penurunanPerMinggu}); }
final biodataProvider = FutureProvider.autoDispose((ref) async => BiodataModel(modeBerhenti: ModeBerhenti.seketika, penurunanPerMinggu: 0));