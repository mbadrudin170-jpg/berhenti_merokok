// commit: ceacc6a1c388b24b7647a37ccde411d6c85ee01c
// Input: Validasi form mode tapering (tanpa Form/validate, parsing gagal diganti 0)

class FormBiodataSalah extends ConsumerStatefulWidget {
  const FormBiodataSalah({super.key});
  @override ConsumerState<FormBiodataSalah> createState() => _FormBiodataSalahState();
}

class _FormBiodataSalahState extends ConsumerState<FormBiodataSalah> {
  final _penurunanPerMingguController = TextEditingController();
  ModeBerhenti _modeBerhenti = ModeBerhenti.seketika;

  Future<void> _simpanSalah() async {
    // SALAH: Tidak ada Form/validate; parsing gagal diganti 0
    final penurunanPerMinggu = int.tryParse(_penurunanPerMingguController.text.trim()) ?? 0;
    
    // SALAH: Menyimpan langsung tanpa validasi
    await ref.read(biodataProvider.notifier).simpan(BiodataModel(
      modeBerhenti: _modeBerhenti,
      penurunanPerMinggu: penurunanPerMinggu,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DropdownButtonFormField<ModeBerhenti>(
        value: _modeBerhenti,
        items: ModeBerhenti.values.map((e) => DropdownMenuItem(value: e, child: Text(e.label))).toList(),
        onChanged: (v) => setState(() => _modeBerhenti = v!),
      ),
      if (_modeBerhenti == ModeBerhenti.bertahap)
        TextFormField(
          controller: _penurunanPerMingguController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Penurunan per Minggu'),
          // TIDAK ADA validator!
        ),
      FilledButton(onPressed: _simpanSalah, child: const Text('Simpan')),
    ]);
  }
}