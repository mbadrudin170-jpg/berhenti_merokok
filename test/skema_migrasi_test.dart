import 'dart:io';

import 'package:berhenti_merokok/shared/db/sqflite/sqflite.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Daftar kolom wajib per tabel untuk skema versi terkini (v15).
const Map<String, List<String>> _kolomWajib = {
  NamaTabel.biodata: [
    NamaKolom.id,
    NamaKolom.nama,
    NamaKolom.tanggalLahir,
    NamaKolom.jumlahRokokPerHari,
    NamaKolom.hargaRokokPerBungkus,
    NamaKolom.batangPerBungkus,
    NamaKolom.tanggalMulaiMerokok,
    NamaKolom.tanggalMulaiBerhentiMerokok,
    NamaKolom.modeBerhenti,
    NamaKolom.penurunanPerMinggu,
    NamaKolom.tanggalMulaiTapering,
    NamaKolom.targetSmokeFreeHari,
  ],
  NamaTabel.impian: [
    NamaKolom.id,
    NamaKolom.nama,
    NamaKolom.targetTanggal,
    NamaKolom.dibuat,
    NamaKolom.jumlah,
  ],
  NamaTabel.diaryCraving: [
    NamaKolom.id,
    NamaKolom.tanggal,
    NamaKolom.pemicu,
    NamaKolom.intensitas,
    NamaKolom.catatan,
    NamaKolom.durasiMenit,
    NamaKolom.mood,
    NamaKolom.strategi,
    NamaKolom.hasil,
    NamaKolom.dibuat,
  ],
  NamaTabel.alasanBerhenti: [NamaKolom.id, NamaKolom.teks, NamaKolom.dibuat],
  NamaTabel.konsumsiRokok: [
    NamaKolom.id,
    NamaKolom.tanggal,
    NamaKolom.jumlah,
    NamaKolom.isSlip,
    NamaKolom.catatan,
    NamaKolom.pemicu,
    NamaKolom.dibuat,
  ],
  NamaTabel.sosIntervensi: [
    NamaKolom.id,
    NamaKolom.jenisIntervensi,
    NamaKolom.detail,
    NamaKolom.hasilIntervensi,
    NamaKolom.diaryCravingId,
    NamaKolom.dibuat,
  ],
  NamaTabel.rencanaDarurat: [
    NamaKolom.id,
    NamaKolom.jika,
    NamaKolom.maka,
    NamaKolom.dibuat,
  ],
};

Future<String> _pathDatabase() async =>
    join(await getDatabasesPath(), 'berhenti_merokok.db');

void main() {
  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    await AppDatabase.tutupDatabase();
    final pathDb = await _pathDatabase();
    if (await File(pathDb).exists()) {
      await File(pathDb).delete();
    }
  });

  tearDown(() async {
    await AppDatabase.tutupDatabase();
    final pathDb = await _pathDatabase();
    if (await File(pathDb).exists()) {
      await File(pathDb).delete();
    }
  });

  group('Skema instalasi baru (onCreate v15)', () {
    test('membuat seluruh tabel dengan kolom wajib', () async {
      final db = await AppDatabase.database;

      expect(await db.getVersion(), 15);

      for (final entry in _kolomWajib.entries) {
        final info = await db.rawQuery('PRAGMA table_info(${entry.key})');
        final namaKolom = info.map((baris) => baris['name']).toSet();
        for (final kolom in entry.value) {
          expect(
            namaKolom.contains(kolom),
            isTrue,
            reason: 'Kolom $kolom absen pada tabel ${entry.key}',
          );
        }
      }
    });

    test('indeks idx_konsumsi_tanggal tersedia', () async {
      final db = await AppDatabase.database;

      final indeks = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type = 'index' "
        "AND name = 'idx_konsumsi_tanggal'",
      );

      expect(indeks, hasLength(1));
    });

    test('INSERT konsumsi_rokok dengan kolom pemicu berhasil', () async {
      final db = await AppDatabase.database;

      await db.insert(NamaTabel.konsumsiRokok, {
        NamaKolom.id: 'uji-1',
        NamaKolom.tanggal: DateTime.now().toUtc().toIso8601String(),
        NamaKolom.jumlah: 1,
        NamaKolom.isSlip: 0,
        NamaKolom.catatan: null,
        NamaKolom.pemicu: 'stres',
        NamaKolom.dibuat: DateTime.now().toUtc().toIso8601String(),
      });

      final baris = await db.query(
        NamaTabel.konsumsiRokok,
        where: '${NamaKolom.id} = ?',
        whereArgs: ['uji-1'],
      );

      expect(baris, hasLength(1));
      expect(baris.single[NamaKolom.pemicu], 'stres');
    });
  });

  group('Migrasi v14 (instalasi lama tanpa pemicu) ke v15', () {
    test(
      'onUpgrade menambahkan kolom pemicu dan mempertahankan data lama',
      () async {
        // Fixture: database versi 14 yang dibuat melalui onCreate versi 14
        // (sebelum perbaikan `230f0b1`) — tabel konsumsi_rokok TANPA kolom
        // pemicu. Sengaja hanya membuat tabel konsumsi_rokok karena cabang
        // onUpgrade v15 hanya menyentuh tabel tersebut.
        final pathDb = await _pathDatabase();
        var db = await databaseFactory.openDatabase(
          pathDb,
          options: OpenDatabaseOptions(
            version: 14,
            onCreate: (db, _) async {
              await db.execute('''
              CREATE TABLE ${NamaTabel.konsumsiRokok}(
                ${NamaKolom.id} TEXT PRIMARY KEY,
                ${NamaKolom.tanggal} TEXT NOT NULL,
                ${NamaKolom.jumlah} INTEGER NOT NULL DEFAULT 1,
                ${NamaKolom.isSlip} INTEGER NOT NULL DEFAULT 0,
                ${NamaKolom.catatan} TEXT,
                ${NamaKolom.dibuat} TEXT NOT NULL
              )
            ''');
            },
          ),
        );
        await db.insert(NamaTabel.konsumsiRokok, {
          NamaKolom.id: 'lama-1',
          NamaKolom.tanggal: '2026-11-13T00:00:00.000Z',
          NamaKolom.jumlah: 1,
          NamaKolom.isSlip: 0,
          NamaKolom.dibuat: '2026-11-13T00:00:00.000Z',
        });
        await db.close();

        // Buka kembali melalui AppDatabase (versi 15) — memicu onUpgrade(14 → 15).
        db = await AppDatabase.database;

        expect(await db.getVersion(), 15);

        final info = await db.rawQuery(
          'PRAGMA table_info(${NamaTabel.konsumsiRokok})',
        );
        final namaKolom = info.map((baris) => baris['name']).toSet();
        expect(
          namaKolom.contains(NamaKolom.pemicu),
          isTrue,
          reason: 'Kolom pemicu tidak ditambahkan oleh migrasi v15',
        );

        // Data lama tetap ada, pemicu null.
        final barisLama = await db.query(
          NamaTabel.konsumsiRokok,
          where: '${NamaKolom.id} = ?',
          whereArgs: ['lama-1'],
        );
        expect(barisLama, hasLength(1));
        expect(barisLama.single[NamaKolom.pemicu], isNull);

        // INSERT dengan pemicu berhasil setelah migrasi.
        await db.insert(NamaTabel.konsumsiRokok, {
          NamaKolom.id: 'baru-1',
          NamaKolom.tanggal: DateTime.now().toUtc().toIso8601String(),
          NamaKolom.jumlah: 1,
          NamaKolom.isSlip: 0,
          NamaKolom.pemicu: 'kopi',
          NamaKolom.dibuat: DateTime.now().toUtc().toIso8601String(),
        });

        final barisBaru = await db.query(
          NamaTabel.konsumsiRokok,
          where: '${NamaKolom.id} = ?',
          whereArgs: ['baru-1'],
        );
        expect(barisBaru.single[NamaKolom.pemicu], 'kopi');
      },
    );
  });
}
