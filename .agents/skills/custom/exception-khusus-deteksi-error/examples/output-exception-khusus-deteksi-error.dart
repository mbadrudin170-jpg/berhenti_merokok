// commit: 07fc8df6cf5ea28fe7133b1aee5dae7b05b96590

// BENAR: Exception khusus sebagai class terpisah
class IzinNotifikasiTidakDiberikanException implements Exception {
  const IzinNotifikasiTidakDiberikanException();
  @override
  String toString() => 'Izin notifikasi tidak diberikan';
}

class BerkasCadanganTidakValidException implements Exception {
  const BerkasCadanganTidakValidException(this.pesan);
  final String pesan;
  @override
  String toString() => 'Berkas cadangan tidak valid: $pesan';
}

Future<void> aktifkanNotifikasiBenar() async {
  try {
    final izin = await mintaIzinSistem();
    if (!izin) {
      // BENAR: Melempar exception khusus
      throw const IzinNotifikasiTidakDiberikanException();
    }
  } on Exception catch (e, s) {
    // BENAR: Deteksi via type check (is) - tidak bergantung pada string
    if (e is IzinNotifikasiTidakDiberikanException) {
      // tangani kegagalan izin spesifik
      return;
    }
    // Error lain tetap dilempar
    rethrow;
  }
}

Future<void> pulihkanCadangan(String path) async {
  try {
    final payload = await bacaBerkasCadangan(path);
    if (!validasiPayload(payload)) {
      throw BerkasCadanganTidakValidException('Format JSON tidak valid');
    }
  } on BerkasCadanganTidakValidException catch (e) {
    // BENAR: Tangkap exception khusus langsung
    // Handle error spesifik
  } on Exception catch (e, s) {
    // Error lain
    rethrow;
  }
}

Future<bool> mintaIzinSistem() async => false;
Future<Map<String, dynamic>> bacaBerkasCadangan(String path) async => {};
bool validasiPayload(Map<String, dynamic> payload) => true;