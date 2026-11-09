// commit: ceacc6a1c388b24b7647a37ccde411d6c85ee01c
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormTaperingBenar extends ConsumerStatefulWidget {
  const FormTaperingBenar({super.key});
  @override ConsumerState<FormTaperingBenar> createState() => _FormTaperingBenarState();
}

class _FormTaperingBenarState extends ConsumerState<FormTaperingBenar> {
  final _formKey = GlobalKey<FormState>();
  final _penurunanController = TextEditingController();
  ModeBerhenti _mode = ModeBerhenti.seketika;
  DateTime? _tanggalMulaiTapering;

  Future<void> _simpan() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    
    // BENAR: Tanggal mulai tapering diinisialisasi saat mode bertahap
    if (_mode == ModeBerhenti.bertahap && _tanggalMulaiTapering == null) {
      _tanggalMulaiTapering = DateTime.now();
    }
    
    final penurunan = int.parse(_penurunanController.text.trim());
    await ref.read(biodataProvider.notifier).simpan(BiodataModel(
      modeBerhenti: _mode,
      penurunanPerMinggu: penurunan,
      tanggalMulaiTapering: _tanggalMulaiTapering,
    ));
  }

  @override Widget build(BuildContext context) => Form(key: _formKey, child: Column(children: [
    DropdownButton<ModeBerhenti>(value: _mode, items: ModeBerhenti.values.map((e) => DropdownMenuItem(value: e, child: Text(e.label))).toList(), onChanged: (v) => setState(() => _mode = v!)),
    TextFormField(
      controller: _penurunanController,
      keyboardType: TextInputType.number,
      validator: (v) { final n = int.tryParse(v ?? ''); if (n == null || n <= 0) return 'Wajib bilangan bulat positif'; return null; },
    ),
    ElevatedButton(onPressed: _simpan, child: const Text('Simpan')),
  ]));
}

enum ModeBerhenti { seketika, bertahap }
extension ModeBerhentiExtension on ModeBerhenti { String get label => name; }

class BiodataModel { final ModeBerhenti modeBerhenti; final int penurunanPerMinggu; final DateTime? tanggalMulaiTapering; BiodataModel({required this.modeBerhenti, required this.penurunanPerMinggu, this.tanggalMulaiTapering}); }

// BENAR: Ekstensi dengan targetRokokHariIni
extension BiodataModelPerhitungan on BiodataModel {
  int get targetRokokHariIni {
    if (modeBerhenti != ModeBerhenti.bertahap || tanggalMulaiTapering == null) return jumlahRokokPerHari;
    final mulaiDate = DateTime(tanggalMulaiTapering!.year, tanggalMulaiTapering!.month, tanggalMulaiTapering!.day);
    final sekarangDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final mingguBerlalu = (sekarangDate.difference(mulaiDate).inDays < 0 ? 0 : sekarangDate.difference(mulaiDate).inDays ~/ 7);
    final target = jumlahRokokPerHari - (penurunanPerMinggu * mingguBerlalu);
    return target.clamp(0, jumlahRokokPerHari);
  }
}