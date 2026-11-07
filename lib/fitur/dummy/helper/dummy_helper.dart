import 'package:berhenti_merokok/fitur/dummy/dummy_data/dummy_biodata.dart';
import 'package:berhenti_merokok/fitur/dummy/dummy_data/dummy_impian.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

/// Helper untuk mengelola data dummy aplikasi.
class DummyHelper {
  /// Memasukkan seluruh data dummy ke database SQLite.
  static Future<void> insert() async {
    L.i('tes');
    L.i(
      'dummyImpian.length=${dummyImpian.length}, dummyBiodata.length=${dummyBiodata.length}',
    );
    try {
      final op = const SqfliteOp();
      await op.transaksi((txn) async {
        for (final impian in dummyImpian) {
          await txn.insert(
            NamaTabel.impian,
            impian.toSqflite(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        // Hapus biodata yang ada agar data dummy menjadi satu-satunya biodata
        // yang terbaca aplikasi (ambilSatu mengembalikan baris pertama).
        await txn.delete(NamaTabel.biodata);
        for (final biodata in dummyBiodata) {
          await txn.insert(
            NamaTabel.biodata,
            biodata.toSqflite(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      L.i('insert selesai');
    } on Exception catch (e, s) {
      L.e('Gagal memasukkan data dummy: $e $s');
      rethrow;
    }
  }

  /// Menghapus seluruh data dummy dari database SQLite.
  static Future<void> delete() async {
    L.i(
      'dummyImpian.length=${dummyImpian.length}, dummyBiodata.length=${dummyBiodata.length}',
    );
    try {
      final op = const SqfliteOp();
      await op.transaksi((txn) async {
        for (final impian in dummyImpian) {
          await txn.delete(
            NamaTabel.impian,
            where: 'id = ?',
            whereArgs: [impian.id],
          );
        }
        for (final biodata in dummyBiodata) {
          await txn.delete(
            NamaTabel.biodata,
            where: 'id = ?',
            whereArgs: [biodata.id],
          );
        }
      });
      L.i('delete selesai');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus data dummy: $e $s');
      rethrow;
    }
  }
}
