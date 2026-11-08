import 'package:berhenti_merokok/shared/helper/shared_keys.dart';
import 'package:berhenti_merokok/shared/notifikasi/notifikasi_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  group('NotifikasiService - preferensi', () {
    test('aktif default false', () async {
      expect(await NotifikasiService.aktif(), isFalse);
    });

    test('setAktif menyimpan nilai true', () async {
      await NotifikasiService.setAktif(true);
      expect(await NotifikasiService.aktif(), isTrue);
    });

    test('setAktif menyimpan nilai false', () async {
      await NotifikasiService.setAktif(true);
      await NotifikasiService.setAktif(false);
      expect(await NotifikasiService.aktif(), isFalse);
    });

    test('jam default 8', () async {
      expect(await NotifikasiService.jam(), 8);
    });

    test('menit default 0', () async {
      expect(await NotifikasiService.menit(), 0);
    });

    test('setWaktu menyimpan jam dan menit', () async {
      await NotifikasiService.setWaktu(14, 30);
      expect(await NotifikasiService.jam(), 14);
      expect(await NotifikasiService.menit(), 30);
    });

    test('preferensi tersimpan pada SharedPreferences', () async {
      await NotifikasiService.setAktif(true);
      await NotifikasiService.setWaktu(9, 15);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(SharedKeys.notifikasiHarian), isTrue);
      expect(prefs.getInt(SharedKeys.notifikasiJam), 9);
      expect(prefs.getInt(SharedKeys.notifikasiMenit), 15);
    });
  });
}
