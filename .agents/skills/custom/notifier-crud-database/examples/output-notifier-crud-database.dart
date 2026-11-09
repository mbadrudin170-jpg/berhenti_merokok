// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:berhenti_merokok/shared/utils/l.dart';

part 'notifier_benar.g.dart';

@Riverpod(keepAlive: true)
class NotifierBenar extends _$NotifierBenar {
  @override
  Future<List<String>> build() async {
    return _ambilSemua();
  }

  Future<List<String>> _ambilSemua() async {
    final op = const SqfliteOp();
    final rows = await op.ambilSemua(NamaTabel.tabel);
    return rows.map((r) => r['item'] as String).toList();
  }

  Future<void> tambah(String item) async {
    L.i('item=$item');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.tambah(NamaTabel.tabel, {'item': item},
          conflictAlgorithm: ConflictAlgorithm.replace);
      state = AsyncValue.data([item, ...dataLama]);
      L.s('Item berhasil disimpan');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan item: $e $s');
      rethrow;
    }
  }

  Future<void> hapus(String item) async {
    L.i('item=$item');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.hapus(NamaTabel.tabel, where: 'item = ?', whereArgs: [item]);
      state = AsyncValue.data(dataLama.where((i) => i != item).toList());
      L.s('Item berhasil dihapus');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus item: $e $s');
      rethrow;
    }
  }
}