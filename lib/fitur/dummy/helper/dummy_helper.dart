import 'package:berhenti_merokok/fitur/dummy/dummy_data/dummy_biodata.dart';
import 'package:berhenti_merokok/fitur/dummy/dummy_data/dummy_impian.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:sqflite/sqflite.dart';

/// Helper untuk mengelola data dummy aplikasi.
class DummyHelper {
  /// Memasukkan seluruh data dummy ke database SQLite.
  static Future<void> insert() async {
    final op = const SqfliteOp();
    await op.transaksi((txn) async {
      for (final impian in dummyImpian) {
        await txn.insert(
          NamaTabel.impian,
          impian.toSqflite(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      for (final biodata in dummyBiodata) {
        await txn.insert(
          NamaTabel.biodata,
          biodata.toSqflite(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  /// Menghapus seluruh data dummy dari database SQLite.
  static Future<void> delete() async {
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
  }
}
