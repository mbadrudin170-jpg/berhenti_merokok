import 'package:berhenti_merokok/fitur/cadangan/helper/cadangan_helper.dart';
import 'package:csv/csv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CadanganHelper.buatCsvDariBaris', () {
    test('menghasilkan header meskipun tidak ada baris data', () {
      final csv = CadanganHelper.buatCsvDariBaris(
        const ['id', 'tanggal'],
        const [],
      );
      expect(csv, 'id,tanggal');
    });

    test('menulis nilai null sebagai string kosong', () {
      final csv = CadanganHelper.buatCsvDariBaris(
        const ['id', 'catatan'],
        const [
          {'id': '1', 'catatan': null},
        ],
      );
      final rows = const CsvToListConverter(
        eol: '\r\n',
        shouldParseNumbers: false,
      ).convert(csv);
      expect(rows, [
        ['id', 'catatan'],
        ['1', ''],
      ]);
    });

    test('meng-quote nilai yang memuat koma, kutip, dan newline', () {
      final csv = CadanganHelper.buatCsvDariBaris(
        const ['id', 'teks'],
        const [
          {'id': '1', 'teks': 'a,b'},
          {'id': '2', 'teks': 'dia berkata "halo"'},
          {'id': '3', 'teks': 'baris1\nbaris2'},
        ],
      );
      final rows = const CsvToListConverter(
        eol: '\r\n',
        shouldParseNumbers: false,
      ).convert(csv);
      expect(rows, [
        ['id', 'teks'],
        ['1', 'a,b'],
        ['2', 'dia berkata "halo"'],
        ['3', 'baris1\nbaris2'],
      ]);
    });

    test('round-trip: data yang diekspor terbaca kembali dengan benar', () {
      final data = <Map<String, Object?>>[
        {'id': 'a-1', 'jumlah': 3, 'catatan': 'uji, koma'},
        {'id': 'a-2', 'jumlah': null, 'catatan': null},
      ];
      final csv = CadanganHelper.buatCsvDariBaris(
        const ['id', 'jumlah', 'catatan'],
        data,
      );
      final rows = const CsvToListConverter(
        eol: '\r\n',
        shouldParseNumbers: false,
      ).convert(csv);
      expect(rows.first, ['id', 'jumlah', 'catatan']);
      expect(rows[1], ['a-1', '3', 'uji, koma']);
      expect(rows[2], ['a-2', '', '']);
    });
  });

  group('CadanganHelper.namaBerkasCsv', () {
    test('menghasilkan pola <nama_tabel>_<timestamp>.csv', () {
      final nama = CadanganHelper.namaBerkasCsv('impian', timestamp: 12345);
      expect(nama, 'impian_12345.csv');
    });

    test('memuat nama tabel untuk setiap tabel cadangan', () {
      for (final tabel in tabelCadangan) {
        expect(CadanganHelper.namaBerkasCsv(tabel), startsWith('${tabel}_'));
        expect(CadanganHelper.namaBerkasCsv(tabel), endsWith('.csv'));
      }
    });
  });

  group('CadanganHelper.validasiHeaderCsv', () {
    test('mengembalikan false untuk header kosong', () {
      expect(CadanganHelper.validasiHeaderCsv(const [], const ['id']), isFalse);
    });

    test('mengembalikan true jika semua kolom dikenal', () {
      expect(
        CadanganHelper.validasiHeaderCsv(
          const ['id', 'tanggal'],
          const ['id', 'tanggal', 'catatan'],
        ),
        isTrue,
      );
    });

    test('mengembalikan false jika ada kolom tidak dikenal', () {
      expect(
        CadanganHelper.validasiHeaderCsv(
          const ['id', 'kolom_asing'],
          const ['id', 'tanggal'],
        ),
        isFalse,
      );
    });
  });

  group('CadanganHelper.validasiBarisCsv', () {
    test('mengembalikan false untuk header kosong', () {
      expect(CadanganHelper.validasiBarisCsv(const [], const []), isFalse);
    });

    test('mengembalikan true jika semua baris cocok dengan header', () {
      expect(
        CadanganHelper.validasiBarisCsv(
          const ['id', 'teks'],
          const [
            ['1', 'a'],
            ['2', 'b'],
          ],
        ),
        isTrue,
      );
    });

    test('mengembalikan false jika ada baris tidak cocok', () {
      expect(
        CadanganHelper.validasiBarisCsv(
          const ['id', 'teks'],
          const [
            ['1', 'a'],
            ['2'],
          ],
        ),
        isFalse,
      );
    });
  });

  group('CadanganHelper.validasiTeksCsv', () {
    const kolom = ['id', 'tanggal', 'catatan'];

    test('mengembalikan baris data untuk CSV valid', () {
      final baris = CadanganHelper.validasiTeksCsv(
        tabel: 'diary_craving',
        teks: 'id,tanggal,catatan\r\n1,2026-11-11,uji\r\n2,2026-11-12,coba\n',
        kolomDiizinkan: kolom,
      );
      expect(baris, [
        ['1', '2026-11-11', 'uji'],
        ['2', '2026-11-12', 'coba'],
      ]);
    });

    test('melempar exception untuk berkas kosong', () {
      expect(
        () => CadanganHelper.validasiTeksCsv(
          tabel: 'diary_craving',
          teks: '   ',
          kolomDiizinkan: kolom,
        ),
        throwsA(isA<BerkasCadanganTidakValidException>()),
      );
    });

    test('melempar exception untuk header tidak dikenal', () {
      expect(
        () => CadanganHelper.validasiTeksCsv(
          tabel: 'diary_craving',
          teks: 'id,kolom_asing\r\n1,x\r\n',
          kolomDiizinkan: kolom,
        ),
        throwsA(isA<BerkasCadanganTidakValidException>()),
      );
    });

    test('melempar exception untuk baris dengan kolom tidak cocok', () {
      expect(
        () => CadanganHelper.validasiTeksCsv(
          tabel: 'diary_craving',
          teks: 'id,tanggal,catatan\r\n1,2026-11-11\r\n',
          kolomDiizinkan: kolom,
        ),
        throwsA(isA<BerkasCadanganTidakValidException>()),
      );
    });

    test('menolak berkas dengan hanya header sebagai data kosong valid', () {
      final baris = CadanganHelper.validasiTeksCsv(
        tabel: 'diary_craving',
        teks: 'id,tanggal,catatan\r\n',
        kolomDiizinkan: kolom,
      );
      expect(baris, isEmpty);
    });
  });
}
