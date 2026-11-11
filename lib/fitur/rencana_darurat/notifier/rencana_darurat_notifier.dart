import 'package:berhenti_merokok/fitur/rencana_darurat/model/rencana_darurat_model.dart';
import 'package:berhenti_merokok/fitur/rencana_darurat/state/rencana_darurat_state.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

part 'rencana_darurat_notifier.g.dart';

/// Batas maksimal rencana darurat yang tersimpan.
const int batasMaksRencanaDarurat = 3;

/// Panjang maksimal masing-masing kolom `jika` dan `maka`.
const int panjangMaksRencanaDarurat = 150;

/// Exception ketika penyimpanan melebihi batas [batasMaksRencanaDarurat].
class RencanaPenuhException implements Exception {
  const RencanaPenuhException();

  @override
  String toString() => 'Rencana darurat sudah penuh (maks $batasMaksRencanaDarurat)';
}

/// Exception ketika `jika` duplikat (trim, case-insensitive).
class RencanaDuplikatException implements Exception {
  const RencanaDuplikatException();

  @override
  String toString() => 'Rencana untuk situasi ini sudah ada';
}

/// Validasi murni untuk kolom `jika` dan `maka` rencana darurat.
bool rencanaDaruratValid(String jika, String maka) {
  final j = jika.trim();
  final m = maka.trim();
  return j.isNotEmpty &&
      m.isNotEmpty &&
      j.length <= panjangMaksRencanaDarurat &&
      m.length <= panjangMaksRencanaDarurat;
}

bool _jikaDuplikat(
  List<RencanaDaruratModel> list,
  String jika, {
  String? kecualiId,
}) {
  final normal = jika.trim().toLowerCase();
  return list.any(
    (e) =>
        e.id != kecualiId && e.jika.trim().toLowerCase() == normal,
  );
}

@Riverpod(keepAlive: true)
class RencanaDaruratNotifier extends _$RencanaDaruratNotifier {
  @override
  Future<RencanaDaruratState> build() async {
    return await _ambilSemua();
  }

  Future<RencanaDaruratState> _ambilSemua() async {
    try {
      final op = const SqfliteOp();
      final rows = await op.ambilSemua(
        NamaTabel.rencanaDarurat,
        orderBy: '${NamaKolom.dibuat} ASC',
      );
      final daftar = rows.map(RencanaDaruratModel.fromSqflite).toList();
      L.i('daftar.length=${daftar.length}');
      return RencanaDaruratState(
        listRencana: daftar,
        jumlahRencana: daftar.length,
      );
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data rencana darurat: $e $s');
      rethrow;
    }
  }

  Future<void> tambah({required String jika, required String maka}) async {
    final jikaTrim = jika.trim();
    final makaTrim = maka.trim();
    L.i('jika.length=${jikaTrim.length}, maka.length=${makaTrim.length}');
    try {
      final dataLama = await future;
      if (dataLama.listRencana.length >= batasMaksRencanaDarurat) {
        L.w('rencana darurat penuh, tambah ditolak');
        throw const RencanaPenuhException();
      }
      if (_jikaDuplikat(dataLama.listRencana, jikaTrim)) {
        L.w('jika duplikat, tambah ditolak');
        throw const RencanaDuplikatException();
      }
      final model = RencanaDaruratModel(
        id: const Uuid().v4(),
        jika: jikaTrim,
        maka: makaTrim,
        dibuat: DateTime.now(),
      );
      final op = const SqfliteOp();
      await op.tambah(
        NamaTabel.rencanaDarurat,
        model.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      final baru = [...dataLama.listRencana, model];
      state = AsyncValue.data(
        RencanaDaruratState(
          listRencana: baru,
          jumlahRencana: baru.length,
        ),
      );
      L.s('Rencana darurat berhasil disimpan');
    } on RencanaPenuhException {
      rethrow;
    } on RencanaDuplikatException {
      rethrow;
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan rencana darurat: $e $s');
      rethrow;
    }
  }

  Future<void> ubah(RencanaDaruratModel model) async {
    final jikaTrim = model.jika.trim();
    final makaTrim = model.maka.trim();
    L.i('model.id=${model.id}');
    try {
      final dataLama = await future;
      if (_jikaDuplikat(dataLama.listRencana, jikaTrim, kecualiId: model.id)) {
        L.w('jika duplikat, ubah ditolak');
        throw const RencanaDuplikatException();
      }
      final modelBaru = model.copyWith(jika: jikaTrim, maka: makaTrim);
      final op = const SqfliteOp();
      await op.ubah(
        NamaTabel.rencanaDarurat,
        modelBaru.toSqflite(),
        where: '${NamaKolom.id} = ?',
        whereArgs: [model.id],
      );
      final baru = dataLama.listRencana
          .map((e) => e.id == model.id ? modelBaru : e)
          .toList();
      state = AsyncValue.data(
        RencanaDaruratState(
          listRencana: baru,
          jumlahRencana: baru.length,
        ),
      );
      L.s('Rencana darurat berhasil diubah');
    } on RencanaDuplikatException {
      rethrow;
    } on Exception catch (e, s) {
      L.e('Gagal mengubah rencana darurat: $e $s');
      rethrow;
    }
  }

  Future<void> hapus(String id) async {
    L.i('id=$id');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.hapus(
        NamaTabel.rencanaDarurat,
        where: '${NamaKolom.id} = ?',
        whereArgs: [id],
      );
      final baru = dataLama.listRencana.where((e) => e.id != id).toList();
      state = AsyncValue.data(
        RencanaDaruratState(
          listRencana: baru,
          jumlahRencana: baru.length,
        ),
      );
      L.s('Rencana darurat berhasil dihapus');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus rencana darurat: $e $s');
      rethrow;
    }
  }
}
