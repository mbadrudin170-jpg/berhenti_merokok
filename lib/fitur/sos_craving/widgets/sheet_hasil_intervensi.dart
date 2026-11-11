import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/sos_craving/enum/hasil_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/model/sos_intervensi_model.dart';
import 'package:berhenti_merokok/fitur/sos_craving/notifier/sos_intervensi_notifier.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Bottom sheet satu pertanyaan opsi hasil intervensi SOS Craving.
///
/// Tampilkan setelah intervensi selesai. Opsi: Berkurang / Tetap / Belum selesai,
/// plus aksi Lewati. Hasil dikembalikan sebagai [HasilIntervensiSos] atau null
/// bila pengguna menekan Lewati / menutup sheet tanpa memilih.
class SheetHasilIntervensi extends ConsumerWidget {
  const SheetHasilIntervensi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final warnaSurface = Theme.of(context).colorScheme.surface;

    return Container(
      decoration: BoxDecoration(
        color: warnaSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            Text(
              'Apakah dorongan merokok berkurang?',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Pilih salah satu atau lewati.',
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            _TombolHasil(
              label: HasilIntervensiSos.berkurang.label,
              value: HasilIntervensiSos.berkurang,
              onTap: () => Navigator.pop(context, HasilIntervensiSos.berkurang),
            ),
            _TombolHasil(
              label: HasilIntervensiSos.tetap.label,
              value: HasilIntervensiSos.tetap,
              onTap: () => Navigator.pop(context, HasilIntervensiSos.tetap),
            ),
            _TombolHasil(
              label: HasilIntervensiSos.belumSelesai.label,
              value: HasilIntervensiSos.belumSelesai,
              onTap: () =>
                  Navigator.pop(context, HasilIntervensiSos.belumSelesai),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Lewati'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Satu tombol pilihan hasil intervensi dalam bottom sheet.
class _TombolHasil extends StatelessWidget {
  const _TombolHasil({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final HasilIntervensiSos value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      child: Text(label),
    );
  }
}

/// Mengambil entri diary craving terbaru untuk hari ini (berdasarkan UTC).
///
/// Mengembalikan `id` entri terbaru bila ditemukan, atau `null` bila tidak ada.
Future<String?> _ambilEntriDiaryTerbaruHariIni() async {
  try {
    final op = const SqfliteOp();
    final now = DateTime.now().toUtc();
    final tanggalHariIni =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final rows = await op.ambil(
      NamaTabel.diaryCraving,
      where: '${NamaKolom.tanggal} LIKE ?',
      whereArgs: ['$tanggalHariIni%'],
      orderBy: '${NamaKolom.tanggal} DESC',
      limit: 1,
    );
    if (rows.isEmpty) {
      return null;
    }
    return rows.first[NamaKolom.id] as String?;
  } on Exception catch (e, s) {
    L.w('Gagal mencari entri diary hari ini: $e $s');
    return null;
  }
}

/// Menampilkan bottom sheet pertanyaan hasil intervensi dan menyimpan hasilnya.
///
/// Setelah menyimpan, bila ada entri diary craving hari ini, tawarkan
/// "Tautkan ke catatan craving?" bila pengguna setuju.
///
/// [jenisIntervensi] wajib valid enum. [detail] hanya untuk tab Distraksi.
/// Mengembalikan [HasilIntervensiSos] yang dipilih, atau null bila dilewati.
Future<HasilIntervensiSos?> tampilkanDanSimpanHasilIntervensi({
  required BuildContext context,
  required WidgetRef ref,
  required JenisIntervensiSos jenisIntervensi,
  String? detail,
}) async {
  final hasil = await showModalBottomSheet<HasilIntervensiSos>(
    context: context,
    isScrollControlled: true,
    builder: (_) => const SheetHasilIntervensi(),
  );

  SosIntervensiModel? modelDisimpan;
  try {
    modelDisimpan = await ref
        .read(sosIntervensiProvider.notifier)
        .simpan(
          jenis: jenisIntervensi,
          detail: detail,
          hasil: hasil,
        );
    if (context.mounted) {
      AppToast.sukses(
        context,
        'Hasil intervensi tersimpan${hasil == null ? ' (dilewati)' : ''}',
      );
    }
  } on Exception catch (e, s) {
    L.e('Gagal menyimpan hasil intervensi SOS: $e $s');
    if (context.mounted) {
      AppToast.gagal(context, 'Gagal menyimpan hasil intervensi');
    }
    return hasil;
  }

  // Tawarkan tautan ke diary craving bila ada entri hari ini dan model tersimpan.
  if (context.mounted) {
    final diaryId = await _ambilEntriDiaryTerbaruHariIni();
    if (diaryId != null) {
      final konfirmasi = await showOkCancelAlertDialog(
        context: context,
        title: 'Tautkan ke catatan craving?',
        message:
            'Hasil intervensi ini akan ditautkan ke entri craving hari ini '
            'agar Anda bisa melihat hubungan antara pemicu dan teknik yang '
            'dicoba.',
        okLabel: 'Tautkan',
        cancelLabel: 'Batal',
      );
      if (konfirmasi == OkCancelResult.ok) {
        try {
          await ref
              .read(sosIntervensiProvider.notifier)
              .ubahDiaryCravingId(
                id: modelDisimpan.id,
                diaryCravingId: diaryId,
              );
          if (context.mounted) {
            AppToast.sukses(context, 'Tautkan ke catatan craving berhasil');
          }
        } on Exception catch (e, s) {
          L.w('Gagal menautkan ke catatan craving: $e $s');
          if (context.mounted) {
            AppToast.gagal(context, 'Gagal menautkan ke catatan craving');
          }
        }
      }
    }
  }

  return hasil;
}
