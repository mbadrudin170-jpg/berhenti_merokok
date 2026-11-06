import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

part 'impian_notifier.g.dart';

@Riverpod(keepAlive: true)
class ImpianNotifier extends _$ImpianNotifier {
  @override
  Future<List<ImpianModel>> build() async {
    return await _ambilSemua();
  }

  Future<List<ImpianModel>> _ambilSemua() async {
    try {
      final op = const SqfliteOp();
      final rows = await op.ambilSemua(NamaTabel.impian);
      return rows.map(ImpianModel.fromSqflite).toList();
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data impian: $e $s');
      rethrow;
    }
  }

  Future<void> tambah(ImpianModel impian) async {
    final dataLama = await future;
    try {
      final op = const SqfliteOp();
      await op.tambah(
        NamaTabel.impian,
        impian.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      state = AsyncValue.data([...dataLama, impian]);
      L.s('Impian berhasil disimpan');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan impian: $e $s');
      rethrow;
    }
  }

  /// Menambahkan banyak impian sekaligus menggunakan operasi batch.
  Future<void> tambahBanyak(List<ImpianModel> daftarImpian) async {
    final dataLama = await future;
    try {
      final op = const SqfliteOp();
      await op.batch((batch) {
        for (final impian in daftarImpian) {
          batch.insert(
            NamaTabel.impian,
            impian.toSqflite(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      state = AsyncValue.data([...dataLama, ...daftarImpian]);
      L.s('Impian berhasil disimpan (batch)');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan impian (batch): $e $s');
      rethrow;
    }
  }

  Future<void> ubah(ImpianModel impian) async {
    final dataLama = await future;
    try {
      final op = const SqfliteOp();
      await op.ubah(
        NamaTabel.impian,
        impian.toSqflite(),
        where: '${NamaKolom.id} = ?',
        whereArgs: [impian.id],
      );
      state = AsyncValue.data(
        dataLama.map((e) => e.id == impian.id ? impian : e).toList(),
      );
      L.s('Impian berhasil diubah');
    } on Exception catch (e, s) {
      L.e('Gagal mengubah impian: $e $s');
      rethrow;
    }
  }

  Future<void> hapus(String id) async {
    final dataLama = await future;
    try {
      final op = const SqfliteOp();
      await op.hapus(
        NamaTabel.impian,
        where: '${NamaKolom.id} = ?',
        whereArgs: [id],
      );
      state = AsyncValue.data(dataLama.where((e) => e.id != id).toList());
      L.s('Impian berhasil dihapus');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus impian: $e $s');
      rethrow;
    }
  }

  /// Menghapus banyak impian sekaligus menggunakan operasi batch.
  Future<void> hapusBanyak(List<String> daftarId) async {
    final dataLama = await future;
    try {
      final op = const SqfliteOp();
      await op.batch((batch) {
        for (final id in daftarId) {
          batch.delete(
            NamaTabel.impian,
            where: '${NamaKolom.id} = ?',
            whereArgs: [id],
          );
        }
      });
      state = AsyncValue.data(
        dataLama.where((e) => !daftarId.contains(e.id)).toList(),
      );
      L.s('Impian berhasil dihapus (batch)');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus impian (batch): $e $s');
      rethrow;
    }
  }

  /// Mengubah banyak impian sekaligus menggunakan operasi batch.
  Future<void> ubahBanyak(List<ImpianModel> daftarImpian) async {
    final dataLama = await future;
    try {
      final op = const SqfliteOp();
      await op.batch((batch) {
        for (final impian in daftarImpian) {
          batch.update(
            NamaTabel.impian,
            impian.toSqflite(),
            where: '${NamaKolom.id} = ?',
            whereArgs: [impian.id],
          );
        }
      });
      state = AsyncValue.data(
        dataLama.map((e) {
          final pengganti = daftarImpian.firstWhereOrNull(
            (item) => item.id == e.id,
          );
          return pengganti ?? e;
        }).toList(),
      );
      L.s('Impian berhasil diubah (batch)');
    } on Exception catch (e, s) {
      L.e('Gagal mengubah impian (batch): $e $s');
      rethrow;
    }
  }
}
