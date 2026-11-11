import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/rencana_darurat/model/rencana_darurat_model.dart';
import 'package:berhenti_merokok/fitur/rencana_darurat/notifier/rencana_darurat_notifier.dart';
import 'package:berhenti_merokok/fitur/rencana_darurat/screens/form_rencana_darurat.dart';
import 'package:berhenti_merokok/shared/widget/empty_state_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Layar kelola rencana darurat if-then (daftar + tambah/ubah/hapus).
class RencanaDaruratScreen extends ConsumerStatefulWidget {
  const RencanaDaruratScreen({super.key});

  @override
  ConsumerState<RencanaDaruratScreen> createState() =>
      _RencanaDaruratScreenState();
}

class _RencanaDaruratScreenState extends ConsumerState<RencanaDaruratScreen> {
  @override
  void initState() {
    super.initState();
    L.i('RencanaDaruratScreen initState');
  }

  @override
  void dispose() {
    L.i('RencanaDaruratScreen dispose');
    super.dispose();
  }

  void _navigasiKeForm({RencanaDaruratModel? rencana}) {
    unawaited(
      Nav.to(context, FormRencanaDarurat(rencana: rencana)).catchError((
        Object e,
        StackTrace s,
      ) {
        L.e('Gagal navigasi ke Form Rencana Darurat: $e $s');
        return null;
      }),
    );
  }

  Future<void> _hapus(RencanaDaruratModel item) async {
    L.i('item.id=${item.id}');
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus rencana?',
      message: 'Rencana "Jika ${item.jika}" akan dihapus permanen. Lanjutkan?',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!mounted) return;
    try {
      await ref.read(rencanaDaruratProvider.notifier).hapus(item.id);
      if (mounted) {
        AppToast.sukses(context, 'Rencana darurat berhasil dihapus');
      }
    } on Exception catch (e, s) {
      L.e('Gagal menghapus rencana darurat: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menghapus rencana darurat');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final rencanaAsync = ref.watch(rencanaDaruratProvider);
    L.i(
      'rencanaAsync.isLoading=${rencanaAsync.isLoading}, '
      'hasError=${rencanaAsync.hasError}',
    );

    if (rencanaAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (rencanaAsync.hasError) {
      L.w('rencanaDaruratProvider error=${rencanaAsync.error}');
      return Scaffold(
        appBar: AppBar(title: const Text('Rencana Darurat')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              const Text('Gagal memuat data rencana darurat'),
              OutlinedButton(
                onPressed: () {
                  final _ = ref.refresh(rencanaDaruratProvider);
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final state = rencanaAsync.requireValue;
    final list = state.listRencana;
    final penuh = list.length >= batasMaksRencanaDarurat;
    L.i('list.length=${list.length}, penuh=$penuh');

    final fab = Tooltip(
      message: penuh
          ? 'Maksimal $batasMaksRencanaDarurat rencana tersimpan'
          : 'Tambah rencana',
      child: FloatingActionButton(
        onPressed: penuh ? null : () => _navigasiKeForm(),
        child: const Icon(CupertinoIcons.add),
      ),
    );

    if (list.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Rencana Darurat')),
        body: EmptyStateView(
          ikon: Icons.event_note_outlined,
          judul: 'Belum ada rencana darurat',
          deskripsi:
              'Tulis rencana "Jika …, Maka …" agar kamu punya respons '
              'otomatis saat craving muncul.',
          ctaLabel: 'Tambah Rencana',
          onCta: () => _navigasiKeForm(),
        ),
        floatingActionButton: fab,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Rencana Darurat')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              L.i('item.id=${item.id}');
              return Card(
                key: ValueKey(item.id),
                child: ListTile(
                  title: Text('Jika ${item.jika}'),
                  subtitle: Text('Maka ${item.maka}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Hapus',
                    onPressed: () => unawaited(_hapus(item)),
                  ),
                  onTap: () => _navigasiKeForm(rencana: item),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        ),
      ),
      floatingActionButton: fab,
    );
  }
}
