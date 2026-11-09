# Contoh Output: Validasi Form Mode Tapering

## Sumber
- Commit: `ceacc6a1c388b24b7647a37ccde411d6c85ee01c`
- File rujukan: `lib/fitur/biodata/screens/form_biodata.dart`

## Implementasi
```dart
class _FormBiodataState extends ConsumerState<FormBiodata> {
  final _formKey = GlobalKey<FormState>();
  final _penurunanPerMingguController = TextEditingController();
  DateTime? _tanggalMulaiTapering;
  ModeBerhenti _modeBerhenti = ModeBerhenti.seketika;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        children: [
          // ... field lain (nama, tanggal lahir, dll) ...
          
          // Mode berhenti
          DropdownButtonFormField<ModeBerhenti>(
            value: _modeBerhenti,
            decoration: const InputDecoration(labelText: 'Mode Berhenti'),
            items: ModeBerhenti.values.map((e) => DropdownMenuItem(
              value: e,
              child: Text(e.label),
            )).toList(),
            onChanged: (v) => setState(() => _modeBerhenti = v!),
          ),
          
          // Penurunan per minggu (hanya tampil jika mode bertahap)
          if (_modeBerhenti == ModeBerhenti.bertahap) ...[
            TextFormField(
              controller: _penurunanPerMingguController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Penurunan per Minggu',
                hintText: 'Contoh: 2',
              ),
              validator: (value) {
                final n = int.tryParse(value?.trim() ?? '');
                if (n == null) return 'Wajib diisi';
                if (n <= 0) return 'Wajib bilangan bulat positif (> 0)';
                return null;
              },
            ),
            // Tanggal mulai tapering
            ListTile(
              title: Text(_tanggalMulaiTapering == null
                  ? 'Pilih Tanggal Mulai Penurunan'
                  : 'Mulai: ${FormatTanggal.formatDasar(_tanggalMulaiTapering!)}'),
              trailing: const Icon(CupertinoIcons.calendar),
              onTap: _pilihTanggalMulaiTapering,
            ),
          ],
          
          // Tombol simpan
          FilledButton(
            onPressed: _simpan,
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Future<void> _simpan() async {
    // 1. Jalankan validasi form
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // 2. Validasi bisnis tambahan untuk mode tapering
    if (_modeBerhenti == ModeBerhenti.bertahap) {
      if (_tanggalMulaiTapering == null) {
        AppToast.peringatan(context, 'Tanggal mulai penurunan wajib dipilih');
        return;
      }
    }

    // 3. Parsing aman (sudah divalidasi, pasti valid)
    final penurunanPerMinggu = _modeBerhenti == ModeBerhenti.bertahap
        ? int.parse(_penurunanPerMingguController.text.trim())
        : 0;

    // 4. Buat model & simpan
    final model = BiodataModel(
      // ... field lain ...
      modeBerhenti: _modeBerhenti,
      penurunanPerMinggu: penurunanPerMinggu,
      tanggalMulaiTapering: _tanggalMulaiTapering,
    );

    try {
      await ref.read(biodataProvider.notifier).simpan(model);
      if (mounted) {
        AppToast.sukses(context, 'Biodata berhasil disimpan');
        Nav.pop(context);
      }
    } on Exception catch (e, s) {
      L.e('Gagal simpan biodata: $e $s');
      if (mounted) AppToast.gagal(context, 'Gagal menyimpan biodata');
    }
  }
}
```

## Penjelasan
1. **`Form` + `GlobalKey<FormState>`** → mekanisme validasi terpusat.
2. **`validator` pada `TextFormField`** → validasi aturan bisnis (positif > 0), bukan hanya format.
3. **`validate()` sebelum simpan** → early return jika gagal, tidak lanjut ke penyimpanan.
4. **Validasi tambahan mode tapering** → cek `tanggalMulaiTapering` tidak null.
5. **Parsing aman `int.parse()`** → karena sudah divalidasi `validator`, pasti valid, tidak perlu `tryParse ?? 0`.
6. **Error handling simpan** → `try/catch` + `L.e` + `AppToast.gagal`.
7. **Conditional field** → `penurunanPerMinggu` & `tanggalMulaiTapering` hanya tampil & divalidasi jika mode `bertahap`.

## Contoh Salah (Yang DILARANG)
```dart
// SALAH: Tidak ada Form/validate, parsing gagal diganti 0
penurunanPerMinggu: int.tryParse(_penurunanPerMingguController.text.trim()) ?? 0,
// Menyimpan langsung tanpa validasi
await ref.read(biodataProvider.notifier).simpan(model);
```