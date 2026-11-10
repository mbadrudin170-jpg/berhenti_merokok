import 'package:berhenti_merokok/fitur/konsumsi_rokok/helper/konsumsi_hitung_helper.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/state/konsumsi_rokok_state.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

part 'konsumsi_rokok_notifier.g.dart';

@Riverpod(keepAlive: true)
class KonsumsiRokokNotifier extends _$KonsumsiRokokNotifier {
  @override
  Future<KonsumsiRokokState> build() async {
    return await _ambilSemua();
  }

  Future<KonsumsiRokokState> _ambilSemua() async {
    try {
      final op = const SqfliteOp();
      final rows = await op.ambilSemua(
        NamaTabel.konsumsiRokok,
        orderBy: '${NamaKolom.tanggal} DESC, ${NamaKolom.dibuat} DESC',
      );
      final daftar = rows.map(KonsumsiRokokModel.fromSqflite).toList();
      final ringkasan = KonsumsiHitungHelper.ringkasanHarian(daftar);
      final total = KonsumsiHitungHelper.totalKonsumsi(daftar);
      L.i('daftar.length=${daftar.length}, total=$total');
      return KonsumsiRokokState(
        listKonsumsi: daftar,
        jumlahTotal: total,
        ringkasanHarian: ringkasan,
      );
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data konsumsi rokok: $e $s');
      rethrow;
    }
  }

  /// Catat satu batang rokok pada hari ini (quick log, tanpa form).
  Future<void> catatCepat({bool isSlip = false, String? catatan}) async {
    final sekarang = DateTime.now().toUtc();
    final model = KonsumsiRokokModel(
      id: const Uuid().v4(),
      tanggal: sekarang,
      jumlah: 1,
      isSlip: isSlip,
      catatan: catatan,
      dibuat: DateTime.now().toUtc(),
    );
    L.i('catatCepat jumlah=1, isSlip=$isSlip');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.tambah(
        NamaTabel.konsumsiRokok,
        model.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      final baru = [model, ...dataLama.listKonsumsi];
      state = AsyncValue.data(
        KonsumsiRokokState(
          listKonsumsi: baru,
          jumlahTotal: dataLama.jumlahTotal + 1,
          ringkasanHarian: KonsumsiHitungHelper.ringkasanHarian(baru),
        ),
      );
      L.s('Konsumsi cepat berhasil dicatat');
    } on Exception catch (e, s) {
      L.e('Gagal catat cepat konsumsi: $e $s');
      rethrow;
    }
  }

  Future<void> tambah(KonsumsiRokokModel konsumsi) async {
    L.i('konsumsi=$konsumsi');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.tambah(
        NamaTabel.konsumsiRokok,
        konsumsi.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      final baru = [konsumsi, ...dataLama.listKonsumsi];
      state = AsyncValue.data(
        KonsumsiRokokState(
          listKonsumsi: baru,
          jumlahTotal: dataLama.jumlahTotal + konsumsi.jumlah,
          ringkasanHarian: KonsumsiHitungHelper.ringkasanHarian(baru),
        ),
      );
      L.s('Konsumsi berhasil disimpan');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan konsumsi: $e $s');
      rethrow;
    }
  }

  Future<void> ubah(KonsumsiRokokModel konsumsi) async {
    L.i('konsumsi=$konsumsi');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.ubah(
        NamaTabel.konsumsiRokok,
        konsumsi.toSqflite(),
        where: '${NamaKolom.id} = ?',
        whereArgs: [konsumsi.id],
      );
      final baru = dataLama.listKonsumsi
          .map((e) => e.id == konsumsi.id ? konsumsi : e)
          .toList();
      state = AsyncValue.data(
        KonsumsiRokokState(
          listKonsumsi: baru,
          jumlahTotal: KonsumsiHitungHelper.totalKonsumsi(baru),
          ringkasanHarian: KonsumsiHitungHelper.ringkasanHarian(baru),
        ),
      );
      L.s('Konsumsi berhasil diubah');
    } on Exception catch (e, s) {
      L.e('Gagal mengubah konsumsi: $e $s');
      rethrow;
    }
  }

  Future<void> hapus(String id) async {
    L.i('id=$id');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.hapus(
        NamaTabel.konsumsiRokok,
        where: '${NamaKolom.id} = ?',
        whereArgs: [id],
      );
      final baru = dataLama.listKonsumsi.where((e) => e.id != id).toList();
      state = AsyncValue.data(
        KonsumsiRokokState(
          listKonsumsi: baru,
          jumlahTotal: KonsumsiHitungHelper.totalKonsumsi(baru),
          ringkasanHarian: KonsumsiHitungHelper.ringkasanHarian(baru),
        ),
      );
      L.s('Konsumsi berhasil dihapus');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus konsumsi: $e $s');
      rethrow;
    }
  }
}
