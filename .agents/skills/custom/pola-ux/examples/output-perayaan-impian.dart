// commit: c7337d1519d495d0ccd022fb18d63f72d443866a
// Output: Perayaan pencapaian impian dengan SharedPreferences persist & unawaited

class _ImpianScreenState extends ConsumerState<ImpianScreen> {
  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    final impianAsync = ref.watch(impianProvider);

    // ... handle loading/error ...

    final uangDihemat = biodataAsync.requireValue?.uangDihemat ?? 0;
    final listImpian = impianAsync.requireValue.listImpian;

    return ListView.builder(
      itemCount: listImpian.length,
      itemBuilder: (context, index) {
        final impian = listImpian[index];
        final target = impian.jumlah.toDouble();

        // Cek pencapaian via helper
        final sudahTercapai = ImpianProgresHelper.tercapai(uangDihemat, target);
        
        // Tampilkan perayaan sekali saja
        if (sudahTercapai) {
          _tampilkanPerayaanJikaBelum(impian.id, impian.nama);
        }

        return _ImpianItem(
          impian: impian,
          saldo: uangDihemat,
          target: target,
          sudahTercapai: sudahTercapai,
        );
      },
    );
  }

  Future<void> _tampilkanPerayaanJikaBelum(String impianId, String impianNama) async {
    final prefs = await SharedPreferences.getInstance();
    final daftarDiraikan = prefs.getStringList('impian_diraikan') ?? <String>[];
    
    // Sudah diraikan → skip
    if (daftarDiraikan.contains(impianId)) return;

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

// Helper murni untuk perhitungan progres:
class ImpianProgresHelper {
  const ImpianProgresHelper._();

  static double rasio(double saldo, double target) {
    if (target <= 0) return 0.0; // Guard pembagian nol
    return (saldo / target).clamp(0.0, 1.0);
  }

  static bool tercapai(double saldo, double target) {
    if (target <= 0) return false; // Guard pembagian nol
    return saldo >= target;
  }

  static double sisa(double saldo, double target) {
    if (target <= 0) return 0;
    final s = target - saldo;
    return s < 0 ? 0 : s;
  }
}