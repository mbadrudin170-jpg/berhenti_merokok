import 'dart:convert';
import 'dart:io';

import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:csv/csv.dart';
import 'package:share_global_saya/core_shared.dart';

/// Versi format berkas cadangan JSON.
const int versiCadangan = 1;

/// Kunci tabel pada payload cadangan.
const List<String> tabelCadangan = <String>[
  NamaTabel.biodata,
  NamaTabel.impian,
  NamaTabel.diaryCraving,
  NamaTabel.alasanBerhenti,
  NamaTabel.konsumsiRokok,
  NamaTabel.sosIntervensi,
  NamaTabel.rencanaDarurat,
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
      final konsumsi = await op.ambilSemua(NamaTabel.konsumsiRokok);
      final sosIntervensi = await op.ambilSemua(NamaTabel.sosIntervensi);
      final rencanaDarurat = await op.ambilSemua(NamaTabel.rencanaDarurat);
      L.i(
        'biodata=${biodata.length}, impian=${impian.length}, '
        'diary=${diary.length}, alasan=${alasan.length}, '
        'konsumsi=${konsumsi.length}, sosIntervensi=${sosIntervensi.length}, '
        'rencanaDarurat=${rencanaDarurat.length}',
      );

      final payload = <String, Object?>{
        'versi': versiCadangan,
        'dibuatPada': DateTime.now().toUtc().toIso8601String(),
        NamaTabel.biodata: biodata,
        NamaTabel.impian: impian,
        NamaTabel.diaryCraving: diary,
        NamaTabel.alasanBerhenti: alasan,
        NamaTabel.konsumsiRokok: konsumsi,
        NamaTabel.sosIntervensi: sosIntervensi,
        NamaTabel.rencanaDarurat: rencanaDarurat,
      };
      final json = jsonEncode(payload);
      L.s('Cadangan JSON berhasil dibuat');
      return json;
    } on Exception catch (e, s) {
      L.e('Gagal membuat cadangan JSON: $e $s');
      rethrow;
    }
  }

  /// Menulis [isi] ke [path] sebagai UTF-8. Menghapus berkas parsial saat
  /// gagal.
  static Future<void> _tulisBerkas(String path, String isi, String jenis) async {
    L.i('tulis berkas $jenis path=$path');
    final file = File(path);
    try {
      await file.writeAsString(isi, flush: true);
      L.s('Berkas $jenis berhasil ditulis');
    } on Exception catch (e, s) {
      L.e('Gagal menulis berkas $jenis: $e $s');
      try {
        if (await file.exists()) {
          await file.delete();
          L.w('Berkas $jenis parsial dihapus');
        }
      } on Exception catch (e2, s2) {
        L.e('Gagal menghapus berkas $jenis parsial: $e2 $s2');
      }
      rethrow;
    }
  }

  /// Menulis cadangan ke [path]. Menghapus berkas parsial saat gagal.
  static Future<void> tulisCadanganKeBerkas(String path, String json) {
    return _tulisBerkas(path, json, 'cadangan');
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

  /// Mengambil daftar nama kolom [tabel] dari skema database, sesuai urutan
  /// definisi tabel.
  static Future<List<String>> kolomTabel(String tabel) async {
    L.i('kolomTabel tabel=$tabel');
    if (!tabelCadangan.contains(tabel)) {
      L.w('Tabel tidak dikenal: $tabel');
      throw ArgumentError.value(tabel, 'tabel', 'Tabel tidak terdaftar di tabelCadangan');
    }
    try {
      final rows = await const SqfliteOp().queryRaw('PRAGMA table_info($tabel)');
      final kolom = rows
          .map((baris) => baris['name'] as String)
          .toList(growable: false);
      L.i('kolomTabel tabel=$tabel jumlahKolom=${kolom.length}');
      return kolom;
    } on Exception catch (e, s) {
      L.e('Gagal mengambil kolom tabel $tabel: $e $s');
      rethrow;
    }
  }

  /// Mengonversi [rows] menjadi string CSV dengan [header] memakai paket
  /// `csv` (`ListToCsvConverter`). Nilai null ditulis sebagai string kosong.
  static String buatCsvDariBaris(
    List<String> header,
    List<Map<String, Object?>> rows,
  ) {
    L.i('buatCsvDariBaris header=${header.length} baris=${rows.length}');
    final data = <List<dynamic>>[
      header,
      for (final baris in rows)
        header
            .map((kolom) => baris[kolom]?.toString() ?? '')
            .toList(growable: false),
    ];
    return const ListToCsvConverter().convert(data);
  }

  /// Membuat string CSV untuk [tabel]: header nama kolom + seluruh baris.
  static Future<String> buatCsvTabel(String tabel) async {
    L.i('buatCsvTabel tabel=$tabel');
    try {
      final header = await kolomTabel(tabel);
      final rows = await const SqfliteOp().ambilSemua(tabel);
      L.i('buatCsvTabel tabel=$tabel baris=${rows.length}');
      return buatCsvDariBaris(header, rows);
    } on Exception catch (e, s) {
      L.e('Gagal membuat CSV tabel $tabel: $e $s');
      rethrow;
    }
  }

  /// Nama berkas CSV untuk [tabel] dengan pola `<nama_tabel>_<timestamp>.csv`.
  static String namaBerkasCsv(String tabel, {int? timestamp}) {
    final ts = timestamp ?? DateTime.now().millisecondsSinceEpoch;
    return '${tabel}_$ts.csv';
  }

  /// Memvalidasi [header] CSV terhadap kolom yang diizinkan untuk tabel
  /// target. Mengembalikan `true` jika semua kolom dikenal dan header tidak
  /// kosong.
  static bool validasiHeaderCsv(
    List<String> header,
    List<String> kolomDiizinkan,
  ) {
    if (header.isEmpty) {
      L.w('Header CSV kosong');
      return false;
    }
    final valid = header.every(kolomDiizinkan.contains);
    if (!valid) {
      L.w('Header CSV memuat kolom tidak dikenal: $header');
    }
    return valid;
  }

  /// Memvalidasi setiap baris CSV memiliki jumlah kolom yang sama dengan
  /// [header]. Mengembalikan `true` jika semua baris valid.
  static bool validasiBarisCsv(
    List<String> header,
    List<List<dynamic>> baris,
  ) {
    if (header.isEmpty) {
      L.w('Header CSV kosong, baris tidak dapat divalidasi');
      return false;
    }
    final valid = baris.every((b) => b.length == header.length);
    if (!valid) {
      L.w('Ada baris CSV dengan jumlah kolom tidak sama dengan header');
    }
    return valid;
  }

  /// Memvalidasi teks CSV untuk [tabel] terhadap [kolomDiizinkan] dan
  /// mengembalikan daftar baris data (tanpa header) yang sudah tervalidasi.
  ///
  /// Melempar [BerkasCadanganTidakValidException] jika berkas kosong, format
  /// tidak valid, header tidak cocok, atau ada baris dengan jumlah kolom
  /// yang tidak sama dengan header.
  static List<List<dynamic>> validasiTeksCsv({
    required String tabel,
    required String teks,
    required List<String> kolomDiizinkan,
  }) {
    L.i('validasiTeksCsv tabel=$tabel panjang=${teks.length}');
    if (teks.trim().isEmpty) {
      L.w('Berkas CSV tabel $tabel kosong');
      throw const BerkasCadanganTidakValidException('Berkas CSV kosong');
    }
    final dinormalisasi = teks.replaceAll('\r\n', '\n');
    final List<List<dynamic>> rows;
    try {
      rows = const CsvToListConverter(
        eol: '\n',
        shouldParseNumbers: false,
      ).convert(dinormalisasi);
    } on Exception catch (e, s) {
      L.e('Gagal mem-parse CSV tabel $tabel: $e $s');
      throw const BerkasCadanganTidakValidException('Format CSV tidak valid');
    }
    if (rows.isEmpty) {
      L.w('Berkas CSV tabel $tabel tidak memiliki baris');
      throw const BerkasCadanganTidakValidException('Berkas CSV kosong');
    }
    final header = rows.first.map((e) => e.toString()).toList();
    if (!validasiHeaderCsv(header, kolomDiizinkan)) {
      throw BerkasCadanganTidakValidException(
        'Header CSV tabel $tabel tidak valid',
      );
    }
    final baris = rows.skip(1).toList(growable: false);
    if (!validasiBarisCsv(header, baris)) {
      throw BerkasCadanganTidakValidException(
        'Baris CSV tabel $tabel tidak valid',
      );
    }
    L.s('CSV tabel $tabel valid (${baris.length} baris)');
    return baris;
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
