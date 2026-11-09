// commit: 07fc8df6cf5ea28fe7133b1aee5dae7b05b96590
Future<void> aktifkanNotifikasiSalah() async {
  try {
    final izin = await mintaIzinSistem();
    if (!izin) {
      // SALAH: Melempar Exception dengan string, deteksi via string matching
      throw Exception('Izin notifikasi tidak diberikan');
    }
  } on Exception catch (e) {
    // SALAH: Deteksi error via string matching - rentan jika pesan berubah
    if (e.toString().contains('Izin notifikasi tidak diberikan')) {
      // tangani kegagalan izin
    }
    rethrow;
  }
}

Future<bool> mintaIzinSistem() async => false;