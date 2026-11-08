import 'dart:convert';
import 'dart:io';

import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:share_global_saya/core_shared.dart';

/// Versi format berkas cadangan JSON.
const int versiCadangan = 1;

/// Kunci tabel pada payload cadangan.
const List<String> tabelCadangan = <String>[
  NamaTabel.biodata,
  NamaTabel.impian,
  NamaTabel.diaryCraving,
  NamaTabel.alasanBerhenti,
];

/// Exception ketika berkas cadangan tidak valid.
class BerkasCadanganTidakValidException implements Exception {
  /// Membuat exception dengan [pesan].
  const BerkasCadanganTidakValidException(this.pesan);

  /// Pesan kesalahan.
  final String pesan;

  @override
  String toString() => 'Berkas cadangan tidak valid: $pesan';
}

/// Logika ekspor dan pemulihan data cadangan lokal.
class CadanganHelper {
  CadanganHelper._();

  /// Mengumpulkan seluruh data tabel menjadi payload JSON.
  static Future<String> buatCadanganJson() async {
    L.i('buatCadanganJson mulai');
    try {
      final op = const SqfliteOp();
      final biodata = await op.ambilSemua(NamaTabel.biodata);
      final impian = await op.ambilSemua(NamaTabel.impian);
      final diary = await op.ambilSemua(NamaTabel.diaryCraving);
      final alasan = await op.ambilSemua(NamaTabel.alasanBerhenti);
      L.i(
        'biodata=${biodata.length}, impian=${impian.length}, '
        'diary=${diary.length}, alasan=${alasan.length}',
      );

      final payload = <String, Object?>{
        'versi': versiCadangan,
        'dibuatPada': DateTime.now().toUtc().toIso8601String(),
        NamaTabel.biodata: biodata,
        NamaTabel.impian: impian,
        NamaTabel.diaryCraving: diary,
        NamaTabel.alasanBerhenti: alasan,
      };
      final json = jsonEncode(payload);
      L.s('Cadangan JSON berhasil dibuat');
      return json;
    } on Exception catch (e, s) {
      L.e('Gagal membuat cadangan JSON: $e $s');
      rethrow;
    }
  }

  /// Menulis cadangan ke [path]. Menghapus berkas parsial saat gagal.
  static Future<void> tulisCadanganKeBerkas(String path, String json) async {
    L.i('tulisCadanganKeBerkas path=$path');
    final file = File(path);
    try {
      await file.writeAsString(json, flush: true);
      L.s('Cadangan berhasil ditulis ke berkas');
    } on Exception catch (e, s) {
      L.e('Gagal menulis cadangan ke berkas: $e $s');
      try {
        if (await file.exists()) {
          await file.delete();
          L.w('Berkas cadangan parsial dihapus');
        }
      } on Exception catch (e2, s2) {
        L.e('Gagal menghapus berkas cadangan parsial: $e2 $s2');
      }
      rethrow;
    }
  }

  /// Membaca dan memvalidasi berkas cadangan dari [path].
  static Future<Map<String, dynamic>> bacaDanValidasiBerkas(String path) async {
    L.i('bacaDanValidasiBerkas path=$path');
    try {
      final file = File(path);
      if (!await file.exists()) {
        throw const BerkasCadanganTidakValidException('Berkas tidak ditemukan');
      }
      final json = await file.readAsString();
      return validasiPayload(json);
    } on BerkasCadanganTidakValidException catch (e, s) {
      L.e('Berkas cadangan tidak valid: $e $s');
      rethrow;
    } on Exception catch (e, s) {
      L.e('Gagal membaca berkas cadangan: $e $s');
      throw BerkasCadanganTidakValidException('Gagal membaca berkas: $e');
    }
  }

  /// Memvalidasi [json] cadangan dan mengembalikan payload.
  static Map<String, dynamic> validasiPayload(String json) {
    L.i('validasiPayload mulai');
    Object? decoded;
    try {
      decoded = jsonDecode(json);
    } on FormatException catch (e, s) {
      L.e('Format JSON cadangan tidak valid: $e $s');
      throw const BerkasCadanganTidakValidException('Format JSON tidak valid');
    }
    if (decoded is! Map<String, dynamic>) {
      L.w('Payload cadangan bukan objek');
      throw const BerkasCadanganTidakValidException(
        'Payload harus berupa objek JSON',
      );
    }
    final versi = decoded['versi'];
    if (versi is! int || versi < 1 || versi > versiCadangan) {
      L.w('Versi cadangan tidak didukung: $versi');
      throw BerkasCadanganTidakValidException(
        'Versi cadangan tidak didukung: $versi',
      );
    }
    for (final tabel in tabelCadangan) {
      final nilai = decoded[tabel];
      if (nilai == null) {
        L.w('Tabel $tabel tidak ada pada cadangan, dianggap kosong');
        continue;
      }
      if (nilai is! List) {
        L.w('Data tabel $tabel bukan list');
        throw BerkasCadanganTidakValidException(
          'Data tabel $tabel tidak valid',
        );
      }
      for (final row in nilai) {
        if (row is! Map) {
          L.w('Baris tabel $tabel bukan objek');
          throw BerkasCadanganTidakValidException(
            'Baris tabel $tabel tidak valid',
          );
        }
      }
    }
    L.s('Payload cadangan valid');
    return decoded;
  }

  /// Memulihkan data dari [payload] yang sudah divalidasi secara atomik.
  static Future<void> pulihkanDariPayload(Map<String, dynamic> payload) async {
    L.i('pulihkanDariPayload mulai');
    try {
      final op = const SqfliteOp();
      await op.transaksi((txn) async {
        for (final tabel in tabelCadangan) {
          await txn.delete(tabel);
          L.i('Hapus data lama tabel $tabel');
        }
        for (final tabel in tabelCadangan) {
          final rows = payload[tabel];
          if (rows is! List) continue;
          for (final row in rows) {
            if (row is! Map) continue;
            await txn.insert(tabel, Map<String, Object?>.from(row));
          }
          L.i('Pulihkan ${rows.length} baris tabel $tabel');
        }
      });
      L.s('Pemulihan data cadangan berhasil');
    } on Exception catch (e, s) {
      L.e('Gagal memulihkan data cadangan: $e $s');
      rethrow;
    }
  }
}
