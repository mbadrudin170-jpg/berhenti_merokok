import 'package:berhenti_merokok/fitur/pemulihan_kesehatan/helper/progres_milestone_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProgresMilestoneHelper.rasio', () {
    test('mengembalikan 0 untuk durasi nol', () {
      final hasil = ProgresMilestoneHelper.rasio(
        Duration.zero,
        const Duration(days: 1),
      );
      expect(hasil, 0.0);
    });

    test('mengembalikan 1 untuk durasi sama dengan target', () {
      final hasil = ProgresMilestoneHelper.rasio(
        const Duration(days: 1),
        const Duration(days: 1),
      );
      expect(hasil, 1.0);
    });

    test('mengembalikan 1 untuk durasi melebihi target', () {
      final hasil = ProgresMilestoneHelper.rasio(
        const Duration(days: 2),
        const Duration(days: 1),
      );
      expect(hasil, 1.0);
    });

    test('mengembalikan nilai parsial terklam', () {
      final hasil = ProgresMilestoneHelper.rasio(
        const Duration(hours: 12),
        const Duration(hours: 24),
      );
      expect(hasil, 0.5);
    });

    test('mengembalikan 0 untuk durasi negatif', () {
      final hasil = ProgresMilestoneHelper.rasio(
        const Duration(seconds: -10),
        const Duration(hours: 1),
      );
      expect(hasil, 0.0);
    });

    test('mengembalikan 1 untuk target nol detik (guard)', () {
      final hasil = ProgresMilestoneHelper.rasio(
        const Duration(hours: 1),
        Duration.zero,
      );
      expect(hasil, 1.0);
    });
  });

  group('ProgresMilestoneHelper.persentase', () {
    test('mengembalikan 0 untuk durasi nol', () {
      final hasil = ProgresMilestoneHelper.persentase(
        Duration.zero,
        const Duration(days: 1),
      );
      expect(hasil, 0);
    });

    test('mengembalikan 50 untuk setengah target', () {
      final hasil = ProgresMilestoneHelper.persentase(
        const Duration(hours: 12),
        const Duration(hours: 24),
      );
      expect(hasil, 50);
    });

    test('mengembalikan 100 untuk durasi >= target', () {
      final hasil = ProgresMilestoneHelper.persentase(
        const Duration(days: 3),
        const Duration(days: 1),
      );
      expect(hasil, 100);
    });
  });

  group('ProgresMilestoneHelper.tercapai', () {
    test('false saat durasi kurang dari target', () {
      final hasil = ProgresMilestoneHelper.tercapai(
        const Duration(minutes: 10),
        const Duration(minutes: 20),
      );
      expect(hasil, isFalse);
    });

    test('true saat durasi sama dengan target', () {
      final hasil = ProgresMilestoneHelper.tercapai(
        const Duration(minutes: 20),
        const Duration(minutes: 20),
      );
      expect(hasil, isTrue);
    });

    test('true saat durasi melebihi target', () {
      final hasil = ProgresMilestoneHelper.tercapai(
        const Duration(hours: 1),
        const Duration(minutes: 20),
      );
      expect(hasil, isTrue);
    });

    test('true untuk target nol detik (guard)', () {
      final hasil = ProgresMilestoneHelper.tercapai(
        Duration.zero,
        Duration.zero,
      );
      expect(hasil, isTrue);
    });
  });

  group('ProgresMilestoneHelper.sisaWaktu', () {
    test('mengembalikan sisa durasi saat belum tercapai', () {
      final hasil = ProgresMilestoneHelper.sisaWaktu(
        const Duration(minutes: 10),
        const Duration(minutes: 20),
      );
      expect(hasil, const Duration(minutes: 10));
    });

    test('mengembalikan nol saat sudah tercapai', () {
      final hasil = ProgresMilestoneHelper.sisaWaktu(
        const Duration(minutes: 30),
        const Duration(minutes: 20),
      );
      expect(hasil, Duration.zero);
    });

    test('mengembalikan target penuh untuk durasi negatif', () {
      final hasil = ProgresMilestoneHelper.sisaWaktu(
        const Duration(seconds: -5),
        const Duration(minutes: 20),
      );
      expect(hasil, const Duration(minutes: 20));
    });
  });
}
