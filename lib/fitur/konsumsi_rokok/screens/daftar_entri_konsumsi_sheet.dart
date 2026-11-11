import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/screens/form_konsumsi_rokok.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Bottom sheet daftar entri konsumsi untuk tanggal tertentu.
/// Mendukung edit (ketuk entri) dan hapus dengan undo (U3, U4, U2).
class DaftarEntriKonsumsiSheet extends ConsumerStatefulWidget {
  const DaftarEntriKonsumsiSheet({
    super.key,
    required this.tanggal,
    required this.entriHari,
  });

  final DateTime tanggal;
  final List<KonsumsiRokokModel> entriHari;

  @override
  ConsumerState<DaftarEntriKonsumsiSheet> createState() =>
      _DaftarEntriKonsumsiSheetState();
}

class _DaftarEntriKonsumsiSheetState
    extends ConsumerState<DaftarEntriKonsumsiSheet> {
  late List<KonsumsiRokokModel> _entri;

  @override
  void initState() {
    super.initState();
    _entri = List.from(widget.entriHari);
    // Urutkan: terbaru di atas (berdasarkan dibuat desc)
    _entri.sort((a, b) => b.dibuat.compareTo(a.dibuat));
  }

  String _formatJam(DateTime dt) {
    final lokal = dt.toLocal();
    return '${lokal.hour.toString().padLeft(2, '0')}:${lokal.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _editEntri(KonsumsiRokokModel entri) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FormKonsumsiRokok(konsumsi: entri),
    );
    if (result == true && mounted) {
      // Form mengembalikan true saat berhasil simpan
      await _refreshDariDb();
    }
  }

  Future<void> _hapusEntri(KonsumsiRokokModel entri) async {
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Catatan',
      message:
          'Metrik uang dihemat, rokok tidak dihisap, dan target tapering akan ikut menyesuaikan. Lanjutkan hapus?',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (konfirmasi != OkCancelResult.ok) {
      L.w('konfirmasi hapus bukan ok');
      return;
    }
    if (!mounted) return;

    // Simpan salinan untuk undo (U2)
    final salinan = entri;
    try {
      await ref.read(konsumsiRokokProvider.notifier).hapus(salinan.id);
      if (!mounted) return;
      await _refreshDariDb();

      // Tampilkan Snackbar undo (U2)
      _tampilkanUndoHapus(salinan);
    } on Exception catch (e, s) {
      L.e('Gagal hapus entri: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menghapus catatan');
      }
    }
  }

  void _tampilkanUndoHapus(KonsumsiRokokModel entri) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Catatan dihapus'),
        action: SnackBarAction(
          label: 'Urungkan',
          onPressed: () => unawaited(
            ref
                .read(konsumsiRokokProvider.notifier)
                .tambah(entri)
                .catchError((Object e, StackTrace s) {
              L.e('Gagal undo hapus: $e $s');
              if (context.mounted) {
                AppToast.gagal(context, 'Gagal membatalkan hapus');
              }
            }),
          ),
        ),
        duration: const Duration(seconds: 10),
      ),
    );
  }

  Future<void> _refreshDariDb() async {
    try {
      final state = await ref.read(konsumsiRokokProvider.future);
      final entriBaru = state.listKonsumsi.where((e) {
        final lokal = e.tanggal.toLocal();
        final key =
            '${lokal.year}-${lokal.month.toString().padLeft(2, '0')}-${lokal.day.toString().padLeft(2, '0')}';
        final keyWidget =
            '${widget.tanggal.year}-${widget.tanggal.month.toString().padLeft(2, '0')}-${widget.tanggal.day.toString().padLeft(2, '0')}';
        return key == keyWidget;
      }).toList();
      if (mounted) {
        setState(() {
          _entri = entriBaru;
          _entri.sort((a, b) => b.dibuat.compareTo(a.dibuat));
        });
      }
    } on Exception catch (e, s) {
      L.e('Gagal refresh entri: $e $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tanggalStr = FormatTanggal.formatDasar(widget.tanggal);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            Text(
              'Catatan $tanggalStr',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (_entri.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Tidak ada catatan untuk tanggal ini',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              )
            else
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _entri.length,
                  itemBuilder: (context, index) {
                    final entri = _entri[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            '${entri.jumlah}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        title: Text(
                          '${entri.jumlah} batang${entri.isSlip ? ' • SLIP' : ''}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        subtitle: Text(
                          '${_formatJam(entri.dibuat)}${entri.catatan != null ? ' — ${entri.catatan}' : ''}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                CupertinoIcons.pencil,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onPressed: () => _editEntri(entri),
                              tooltip: 'Edit',
                            ),
                            IconButton(
                              icon: Icon(
                                CupertinoIcons.trash,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              onPressed: () => _hapusEntri(entri),
                              tooltip: 'Hapus',
                            ),
                          ],
                        ),
                        onTap: () => _editEntri(entri),
                      ),
                    );
                  },
                ),
              ),
            FilledButton(
              onPressed: () => Nav.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        ),
      ),
    );
  }
}