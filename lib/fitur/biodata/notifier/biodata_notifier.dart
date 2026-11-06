import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

part 'biodata_notifier.g.dart';

@riverpod
class BiodataNotifier extends _$BiodataNotifier {
  @override
  Future<BiodataModel?> build() async {
    return await _ambilData();
  }

  Future<BiodataModel?> _ambilData() async {
    try {
      final op = const SqfliteOp();
      final row = await op.ambilSatu(NamaTabel.biodata);
      if (row == null) {
        return null;
      }
      return BiodataModel.fromSqflite(row);
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data biodata: $e $s');
      rethrow;
    }
  }

  Future<void> simpan(BiodataModel biodata) async {
    try {
      final existing = await future;
      final model = biodata.id.isEmpty
          ? biodata.copyWith(id: existing?.id ?? const Uuid().v4())
          : biodata;
      final op = const SqfliteOp();
      await op.tambah(
        NamaTabel.biodata,
        model.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      state = AsyncValue.data(model);
      L.s('Biodata berhasil disimpan');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan biodata: $e $s');
      rethrow;
    }
  }
}
