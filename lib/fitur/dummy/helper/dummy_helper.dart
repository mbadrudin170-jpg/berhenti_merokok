import 'package:berhenti_merokok/fitur/dummy/dummy_data/dummy_impian.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:sqflite/sqflite.dart';

/// Helper untuk mengelola data dummy aplikasi.
class DummyHelper {
  /// Memasukkan seluruh data dummy impian ke database SQLite.
  static Future<void> insert() async {
    final op = const SqfliteOp();
    await op.batch((batch) {
      for (final impian in dummyImpian) {
        batch.insert(
          NamaTabel.impian,
          impian.toSqflite(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  /// Menghapus seluruh data dummy impian dari database SQLite.
  static Future<void> delete() async {
    final op = const SqfliteOp();
    await op.batch((batch) {
      for (final impian in dummyImpian) {
        batch.delete(NamaTabel.impian, where: 'id = ?', whereArgs: [impian.id]);
      }
    });
  }
}
