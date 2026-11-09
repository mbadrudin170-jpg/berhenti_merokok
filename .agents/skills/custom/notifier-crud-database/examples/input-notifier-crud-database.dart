// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'notifier_salah.g.dart';

@Riverpod(keepAlive: true)
class NotifierSalah extends _$NotifierSalah {
  @override
  Future<List<String>> build() async {
    // Tidak memanggil _ambilSemua
    return [];
  }

  Future<void> tambah(String item) async {
    // Update state SEBELUM operasi database - SALAH
    state = AsyncValue.data([item, ...state.valueOrNull ?? []]);
    final db = await openDatabase('app.db'); // Membuat instance DB baru - SALAH
    await db.insert('tabel', {'item': item});
    // Tidak ada try/catch, tidak ada rethrow
  }
}