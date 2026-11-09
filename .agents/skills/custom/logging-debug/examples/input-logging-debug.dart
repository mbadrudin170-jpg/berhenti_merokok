// commit: be04199e5b44537ee1052a3815f5af8518308148
import 'package:berhenti_merokok/shared/utils/l.dart';

class _ContohSalahState extends State<ContohSalah> {
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();
  DateTime? _targetTanggal;

  void _simpan() {
    // Tidak ada log pada variabel controller dan targetTanggal
    final nama = _namaController.text;
    final jumlah = int.tryParse(_jumlahController.text) ?? 0;
    // print digunakan alih-alih L.i
    print('Simpan: nama=$nama, jumlah=$jumlah');
    // Menguraikan properti model satu per satu
    final model = ImpianModel(nama: nama, jumlah: jumlah);
    print('Model: nama=${model.nama}, jumlah=${model.jumlah}');
  }

  @override
  Widget build(BuildContext context) {
    // Log di build() yang dipanggil berulang
    L.i('build dipanggil');
    return TextFormField(controller: _namaController);
  }
}