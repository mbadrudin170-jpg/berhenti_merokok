import 'package:berhenti_merokok/fitur/alasan_berhenti/model/alasan_berhenti_model.dart';
import 'package:berhenti_merokok/fitur/alasan_berhenti/state/alasan_berhenti_state.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

part 'alasan_berhenti_notifier.g.dart';

@Riverpod(keepAlive: true)
class AlasanBerhentiNotifier extends _$AlasanBerhentiNotifier {
  @override
  Future<AlasanBerhentiState> build() async {
    return await _ambilSemua();
  }

  Future<AlasanBerhentiState> _ambilSemua() async {
    try {
      final op = const SqfliteOp();
      final rows = await op.ambilSemua(
        NamaTabel.alasanBerhenti,
        orderBy: '${NamaKolom.dibuat} DESC',
      );
      final daftar = rows.map(AlasanBerhentiModel.fromSqflite).toList();
      L.i('daftar.length=${daftar.length}');
      return AlasanBerhentiState(
        listAlasan: daftar,
        jumlahAlasan: daftar.length,
      );
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data alasan berhenti: $e $s');
      rethrow;
    }
  }

  Future<void> tambah(String teks) async {
    L.i('teks=$teks');
    try {
      final dataLama = await future;
      final model = AlasanBerhentiModel(
        id: const Uuid().v4(),
        teks: teks,
        dibuat: DateTime.now(),
      );
      final op = const SqfliteOp();
      await op.tambah(
        NamaTabel.alasanBerhenti,
        model.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      state = AsyncValue.data(
        AlasanBerhentiState(
          listAlasan: [model, ...dataLama.listAlasan],
          jumlahAlasan: dataLama.jumlahAlasan + 1,
        ),
      );
      L.s('Alasan berhenti berhasil disimpan');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan alasan berhenti: $e $s');
      rethrow;
    }
  }

  Future<void> ubah(AlasanBerhentiModel model) async {
    L.i('model=$model');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.ubah(
        NamaTabel.alasanBerhenti,
        model.toSqflite(),
        where: '${NamaKolom.id} = ?',
        whereArgs: [model.id],
      );
      final baru = dataLama.listAlasan
          .map((e) => e.id == model.id ? model : e)
          .toList();
      state = AsyncValue.data(
        AlasanBerhentiState(listAlasan: baru, jumlahAlasan: baru.length),
      );
      L.s('Alasan berhenti berhasil diubah');
    } on Exception catch (e, s) {
      L.e('Gagal mengubah alasan berhenti: $e $s');
      rethrow;
    }
  }

  Future<void> hapus(String id) async {
    L.i('id=$id');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.hapus(
        NamaTabel.alasanBerhenti,
        where: '${NamaKolom.id} = ?',
        whereArgs: [id],
      );
      final baru = dataLama.listAlasan.where((e) => e.id != id).toList();
      state = AsyncValue.data(
        AlasanBerhentiState(listAlasan: baru, jumlahAlasan: baru.length),
      );
      L.s('Alasan berhenti berhasil dihapus');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus alasan berhenti: $e $s');
      rethrow;
    }
  }
}
