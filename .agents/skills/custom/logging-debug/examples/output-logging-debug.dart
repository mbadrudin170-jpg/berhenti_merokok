// commit: be04199e5b44537ee1052a3815f5af8518308148
import 'package:berhenti_merokok/shared/utils/l.dart';

class _ContohBenarState extends State<ContohBenar> {
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();
  DateTime? _targetTanggal;

  @override
  void initState() {
    super.initState();
    // Log initState diperbolehkan (dipanggil sekali)
    L.i('ContohBenar initState');
  }

  @override
  void dispose() {
    // Log dispose diperbolehkan (dipanggil sekali)
    L.i('ContohBenar dispose');
    _namaController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  void _simpan() {
    // Log variabel SETELAH mendapatkan nilai, gabungkan variabel terkait
    L.i('_namaController.text=${_namaController.text}, _jumlahController.text=${_jumlahController.text}, _targetTanggal=$_targetTanggal');

    final nama = _namaController.text;
    final jumlah = int.tryParse(_jumlahController.text) ?? 0;

    // Gunakan L.i untuk info, bukan print
    L.i('Simpan: nama=$nama, jumlah=$jumlah');

    // Tampilkan model langsung, jangan uraikan properti
    final model = ImpianModel(nama: nama, jumlah: jumlah);
    L.i('model=$model');

    // Contoh log di catch dengan stack trace
    try {
      // operasi database...
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan: $e $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TIDAK log di build() - noise
    return TextFormField(controller: _namaController);
  }
}

// Contoh logging pada method helper yang menerima parameter
Widget _buildInfoCard({
  required IconData icon,
  required String title,
  required String subtitle,
}) {
  // Log parameter method helper
  L.i('icon=$icon, title=$title, subtitle=$subtitle');
  return Card(child: ListTile(leading: Icon(icon), title: Text(title), subtitle: Text(subtitle)));
}

// Contoh logging kondisi peringatan dengan L.w
void _validasiJumlah(int jumlah) {
  if (jumlah <= 0) {
    L.w('jumlah <= 0');
    return;
  }
  // ...
}

// Contoh logging state AsyncValue
void _handleBiodataAsync(AsyncValue<BiodataModel?> biodataAsync) {
  L.i('biodataAsync=$biodataAsync');
  if (biodataAsync.isLoading) {
    L.w('biodataAsync loading');
    return;
  }
  if (biodataAsync.hasError) {
    L.e('biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}');
    return;
  }
  // ...
}