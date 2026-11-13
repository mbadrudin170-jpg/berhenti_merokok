import 'package:berhenti_merokok/fitur/sos_craving/enum/hasil_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/model/sos_intervensi_model.dart';
import 'package:berhenti_merokok/fitur/sos_craving/state/sos_intervensi_state.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

part 'sos_intervensi_notifier.g.dart';

@Riverpod(keepAlive: true)
class SosIntervensiNotifier extends _$SosIntervensiNotifier {
  @override
  Future<SosIntervensiState> build() async {
    return await _ambilSemua();
  }

  Future<SosIntervensiState> _ambilSemua() async {
    try {
      final op = const SqfliteOp();
      final rows = await op.ambilSemua(
        NamaTabel.sosIntervensi,
        orderBy: '${NamaKolom.dibuat} DESC',
      );
      final daftar = rows.map(SosIntervensiModel.fromSqflite).toList();
      L.i('daftar.length=${daftar.length}');
      final berhasil = daftar
          .where((e) => e.hasilIntervensi == HasilIntervensiSos.berkurang)
          .length;
      return SosIntervensiState(
        listIntervensi: daftar,
        jumlahIntervensi: daftar.length,
        jumlahBerhasil: berhasil,
      );
    } on Exception catch (e, s) {
      L.e('Gagal mengambil riwayat intervensi SOS: $e $s');
      rethrow;
    }
  }

  /// Menyimpan satu baris hasil intervensi SOS.
  ///
  /// [jenis] wajib valid enum. [detail] hanya untuk tab Distraksi.
  /// [hasil] nullable bila pertanyaan dilewati. [diaryCravingId] nullable.
  /// Mengembalikan model yang disimpan (termasuk [id] yang di-generate).
  Future<SosIntervensiModel> simpan({
    required JenisIntervensiSos jenis,
    String? detail,
    HasilIntervensiSos? hasil,
    String? diaryCravingId,
    String? substitusi,
  }) async {
    final id = const Uuid().v4();
    final dibuat = DateTime.now().toUtc();
    L.i(
      'id=$id, jenis=${jenis.name}, detail=$detail, hasil=${hasil?.name}, diaryCravingId=$diaryCravingId, substitusi=$substitusi, dibuat=$dibuat',
    );
    try {
      final dataLama = await future;
      final model = SosIntervensiModel(
        id: id,
        jenisIntervensi: jenis,
        detail: detail,
        hasilIntervensi: hasil,
        diaryCravingId: diaryCravingId,
        substitusi: substitusi,
        dibuat: dibuat,
      );
      final op = const SqfliteOp();
      await op.tambah(
        NamaTabel.sosIntervensi,
        model.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
      final baruList = [model, ...dataLama.listIntervensi];
      final berhasil = baruList
          .where((e) => e.hasilIntervensi == HasilIntervensiSos.berkurang)
          .length;
      state = AsyncValue.data(
        SosIntervensiState(
          listIntervensi: baruList,
          jumlahIntervensi: dataLama.jumlahIntervensi + 1,
          jumlahBerhasil: berhasil,
        ),
      );
      L.s('Riwayat intervensi SOS berhasil disimpan');
      return model;
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan riwayat intervensi SOS: $e $s');
      rethrow;
    }
  }

  /// Memperbarui [diaryCravingId] pada baris [id] sos_intervensi.
  Future<void> ubahDiaryCravingId({
    required String id,
    required String? diaryCravingId,
  }) async {
    L.i('id=$id, diaryCravingId=$diaryCravingId');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.ubah(
        NamaTabel.sosIntervensi,
        {NamaKolom.diaryCravingId: diaryCravingId},
        where: '${NamaKolom.id} = ?',
        whereArgs: [id],
      );
      final baru = dataLama.listIntervensi.map((e) {
        if (e.id == id) {
          return e.copyWith(diaryCravingId: diaryCravingId);
        }
        return e;
      }).toList();
      final berhasil = baru
          .where((e) => e.hasilIntervensi == HasilIntervensiSos.berkurang)
          .length;
      state = AsyncValue.data(
        SosIntervensiState(
          listIntervensi: baru,
          jumlahIntervensi: baru.length,
          jumlahBerhasil: berhasil,
        ),
      );
      L.s('Diary craving ID berhasil diperbarui');
    } on Exception catch (e, s) {
      L.e('Gagal memperbarui diary craving ID: $e $s');
      rethrow;
    }
  }
}
