import 'package:berhenti_merokok/fitur/diary_craving/model/diary_craving_model.dart';
import 'package:berhenti_merokok/fitur/diary_craving/state/diary_craving_state.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

part 'diary_craving_notifier.g.dart';

@Riverpod(keepAlive: true)
class DiaryCravingNotifier extends _$DiaryCravingNotifier {
  @override
  Future<DiaryCravingState> build() async {
    return await _ambilSemua();
  }

  Future<DiaryCravingState> _ambilSemua() async {
    try {
      final op = const SqfliteOp();
      final rows = await op.ambilSemua(
        NamaTabel.diaryCraving,
        orderBy: '${NamaKolom.tanggal} DESC',
      );
      final daftar = rows.map(DiaryCravingModel.fromSqflite).toList();
      L.i('daftar.length=${daftar.length}');
      return DiaryCravingState(
        listCraving: daftar,
        jumlahCraving: daftar.length,
      );
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data diary craving: $e $s');
      rethrow;
    }
  }

  Future<void> tambah(DiaryCravingModel craving) async {
    L.i('craving=$craving');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.tambah(
        NamaTabel.diaryCraving,
        craving.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      state = AsyncValue.data(
        DiaryCravingState(
          listCraving: [craving, ...dataLama.listCraving],
          jumlahCraving: dataLama.jumlahCraving + 1,
        ),
      );
      L.s('Diary craving berhasil disimpan');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan diary craving: $e $s');
      rethrow;
    }
  }

  Future<void> ubah(DiaryCravingModel craving) async {
    L.i('craving=$craving');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.ubah(
        NamaTabel.diaryCraving,
        craving.toSqflite(),
        where: '${NamaKolom.id} = ?',
        whereArgs: [craving.id],
      );
      final baru = dataLama.listCraving
          .map((e) => e.id == craving.id ? craving : e)
          .toList();
      state = AsyncValue.data(
        DiaryCravingState(listCraving: baru, jumlahCraving: baru.length),
      );
      L.s('Diary craving berhasil diubah');
    } on Exception catch (e, s) {
      L.e('Gagal mengubah diary craving: $e $s');
      rethrow;
    }
  }

  Future<void> hapus(String id) async {
    L.i('id=$id');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.hapus(
        NamaTabel.diaryCraving,
        where: '${NamaKolom.id} = ?',
        whereArgs: [id],
      );
      final baru = dataLama.listCraving.where((e) => e.id != id).toList();
      state = AsyncValue.data(
        DiaryCravingState(listCraving: baru, jumlahCraving: baru.length),
      );
      L.s('Diary craving berhasil dihapus');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus diary craving: $e $s');
      rethrow;
    }
  }
}
