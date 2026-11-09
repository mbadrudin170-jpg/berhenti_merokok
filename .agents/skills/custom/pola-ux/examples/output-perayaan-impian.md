# Contoh Output: Perayaan Pencapaian Impian (Toast Sekali)

## Sumber
- Commit: `c7337d1519d495d0ccd022fb18d63f72d443866a`
- File rujukan: `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/impian/helper/impian_progres_helper.dart`

## Implementasi

### Helper Progres Impian (Pure Class)
```dart
// lib/fitur/impian/helper/impian_progres_helper.dart
class ImpianProgresHelper {
  const ImpianProgresHelper._();

  static double rasio(double saldo, double target) {
    if (target <= 0) return 0.0;
    return (saldo / target).clamp(0.0, 1.0);
  }

  static bool tercapai(double saldo, double target) {
    if (target <= 0) return false;
    return saldo >= target;
  }

  static double sisa(double saldo, double target) {
    if (target <= 0) return 0;
    final s = target - saldo;
    return s < 0 ? 0 : s;
  }
}
```

### Logika Perayaan di ImpianScreen
```dart
// lib/fitur/impian/screens/impian_screen.dart
class _ImpianScreenState extends ConsumerState<ImpianScreen> {
  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    final impianAsync = ref.watch(impianProvider);

    // Handle loading/error biodata & impian (lihat pola async value)
    // ...

    final biodata = biodataAsync.requireValue;
    final impianState = impianAsync.requireValue;
    final uangDihemat = biodata?.uangDihemat ?? 0;

    return ListView.builder(
      itemCount: impianState.listImpian.length,
      itemBuilder: (context, index) {
        final impian = impianState.listImpian[index];
        final saldo = uangDihemat;
        final target = impian.jumlah.toDouble();

        // Cek pencapaian
        final sudahTercapai = ImpianProgresHelper.tercapai(saldo, target);
        
        // Cek dan tampilkan perayaan (sekali saja)
        if (sudahTercapai) {
          _tampilkanPerayaanJikaBelum(impian.id, impian.nama);
        }

        return _ImpianItem(
          impian: impian,
          saldo: saldo,
          target: target,
          sudahTercapai: sudahTercapai,
        );
      },
    );
  }

  Future<void> _tampilkanPerayaanJikaBelum(String impianId, String impianNama) async {
    final prefs = await SharedPreferences.getInstance();
    final daftarDiraikan = prefs.getStringList('impian_diraikan') ?? <String>[];
    
    if (daftarDiraikan.contains(impianId)) return; // Sudah diraikan

    // Tandai sudah diraikan (non-blocking)
    daftarDiraikan.add(impianId);
    unawaited(prefs.setStringList('impian_diraikan', daftarDiraikan));

    // Tampilkan toast perayaan (non-blocking dengan error handling)
    if (mounted) {
      unawaited(
        AppToast.sukses(
          context,
          'Selamat! Impian "$impianNama" telah tercapai!',
        ).catchError((e, s) => L.e('Gagal toast perayaan: $e $s')),
      );
    }
  }
}
```

### Widget Item Impian dengan Progress Visual
```dart
class _ImpianItem extends StatelessWidget {
  const _ImpianItem({
    required this.impian,
    required this.saldo,
    required this.target,
    required this.sudahTercapai,
  });

  final ImpianModel impian;
  final double saldo;
  final double target;
  final bool sudahTercapai;

  @override
  Widget build(BuildContext context) {
    final rasio = ImpianProgresHelper.rasio(saldo, target);
    final sisa = ImpianProgresHelper.sisa(saldo, target);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(impian.nama, style: Theme.of(context).textTheme.titleMedium),
                ),
                if (sudahTercapai)
                  const Chip(
                    label: Text('Tercapai!', style: TextStyle(color: Colors.green)),
                    backgroundColor: Color(0xFFE8F5E9),
                  ),
              ],
            ),
            // Visual progress bar
            VisualTabunganImpian(
              rasio: rasio,
              saldo: saldo,
              target: target,
            ),
            // Info teks
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Terkumpul: ${FormatUang.format(saldo)}'),
                Text(sudahTercapai 
                    ? 'Target tercapai!' 
                    : 'Sisa: ${FormatUang.format(sisa)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## Penjelasan
1. **Helper murni `ImpianProgresHelper`** → tidak bergantung `BuildContext`/`provider`, mudah diuji, reusable.
2. **Guard pembagian nol** → `if (target <= 0) return 0.0/false` di semua method.
3. **`SharedPreferences` persist** → key `impian_diraikan` menyimpan list ID yang sudah diraikan, survive restart.
4. **`unawaited()` untuk penandaan & toast** → non-blocking UI, error di-catch via `.catchError()`.
5. **Cek `mounted` sebelum toast** → mencegah crash jika widget sudah dispose.
6. **Rasio di-clamp 0.0–1.0** → aman untuk `LinearProgressIndicator`.
7. **Saldo dari `biodata.uangDihemat`** → konsisten dengan aturan "saldo terkumpul = uang dihemat", bukan `totalJumlah` impian.