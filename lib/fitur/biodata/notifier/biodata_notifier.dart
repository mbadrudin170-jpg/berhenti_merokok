import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

part 'biodata_notifier.g.dart';

@riverpod
class BiodataNotifier extends _$BiodataNotifier {
  @override
  Future<BiodataModel?> build() async {
    return await _ambilData();
  }

  Future<BiodataModel?> _ambilData() async {
    try {
      final db = await AppDatabase.database;
      final rows = await db.query('biodata', limit: 1);
      if (rows.isEmpty) {
        return null;
      }
      final row = rows.first;
      return BiodataModel(
        id: row['id'] as String,
        nama: row['nama'] as String,
        tanggalLahir: ParserUtil.parseDateTime(row['tanggal_lahir'])?.toLocal(),
        jumlahRokokPerHari: ParserUtil.parseIntOrNull(
          row['jumlah_rokok_per_hari'],
        ),
        hargaRokokPerBungkus: ParserUtil.parseDoubleOrNull(
          row['harga_rokok_per_bungkus'],
        ),
        tanggalMulaiMerokok: ParserUtil.parseDateTime(
          row['tanggal_mulai_merokok'],
        )?.toLocal(),
      );
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data biodata: $e $s');
      rethrow;
    }
  }

  Future<void> simpan(BiodataModel biodata) async {
    try {
      final db = await AppDatabase.database;
      await db.insert('biodata', <String, Object?>{
        'id': biodata.id,
        'nama': biodata.nama,
        'tanggal_lahir': biodata.tanggalLahir?.toUtc().toIso8601String(),
        'jumlah_rokok_per_hari': biodata.jumlahRokokPerHari,
        'harga_rokok_per_bungkus': biodata.hargaRokokPerBungkus,
        'tanggal_mulai_merokok': biodata.tanggalMulaiMerokok
            ?.toUtc()
            .toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
      state = AsyncValue.data(biodata);
      L.s('Biodata berhasil disimpan');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan biodata: $e $s');
      rethrow;
    }
  }
}
