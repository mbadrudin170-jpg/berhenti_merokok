import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/alasan_berhenti/model/alasan_berhenti_model.dart';
import 'package:berhenti_merokok/fitur/alasan_berhenti/notifier/alasan_berhenti_notifier.dart';
import 'package:berhenti_merokok/fitur/alasan_berhenti/screens/form_alasan_berhenti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class AlasanBerhentiScreen extends ConsumerStatefulWidget {
  const AlasanBerhentiScreen({super.key});

  @override
  ConsumerState<AlasanBerhentiScreen> createState() =>
      _AlasanBerhentiScreenState();
}

class _AlasanBerhentiScreenState extends ConsumerState<AlasanBerhentiScreen> {
  @override
  void initState() {
    super.initState();
    L.i('AlasanBerhentiScreen initState');
  }

  @override
  void dispose() {
    L.i('AlasanBerhentiScreen dispose');
    super.dispose();
  }

  Future<void> _hapus(AlasanBerhentiModel item) async {
    L.i('item.id=${item.id}');
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Alasan',
      message: 'Apakah Anda yakin ingin menghapus alasan berhenti ini?',
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
      await ref.read(alasanBerhentiProvider.notifier).hapus(item.id);
      if (mounted) {
        AppToast.sukses(context, 'Alasan berhenti berhasil dihapus');
      }
    } on Exception catch (e, s) {
      L.e('Gagal menghapus alasan berhenti: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menghapus alasan berhenti');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final alasanAsync = ref.watch(alasanBerhentiProvider);
    L.i(
      'alasanAsync.isLoading=${alasanAsync.isLoading}, hasError=${alasanAsync.hasError}',
    );

    if (alasanAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (alasanAsync.hasError) {
      L.w('alasanBerhentiProvider error=${alasanAsync.error}');
      return Scaffold(
        appBar: AppBar(title: const Text('Alasan Berhenti')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              const Text('Gagal memuat data alasan berhenti'),
              OutlinedButton(
                onPressed: () {
                  final _ = ref.refresh(alasanBerhentiProvider);
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final state = alasanAsync.requireValue;
    final list = state.listAlasan;
    L.i('list.length=${list.length}');

    if (list.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Alasan Berhenti')),
        body: const _EmptyAlasanBerhenti(),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              unawaited(Nav.to(context, const FormAlasanBerhenti())),
          child: const Icon(CupertinoIcons.add),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Alasan Berhenti')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              L.i('item.id=${item.id}, item.teks=${item.teks}');
              return Card(
                key: ValueKey(item.id),
                child: ListTile(
                  title: Text(item.teks),
                  subtitle: Text(FormatWaktuLengkap.formatSingkat(item.dibuat)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Hapus',
                    onPressed: () => unawaited(_hapus(item)),
                  ),
                  onTap: () => unawaited(
                    Nav.to(context, FormAlasanBerhenti(alasan: item)),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => unawaited(Nav.to(context, const FormAlasanBerhenti())),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}

class _EmptyAlasanBerhenti extends StatelessWidget {
  const _EmptyAlasanBerhenti();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(CupertinoIcons.heart, size: 48),
              Text(
                'Belum ada alasan berhenti',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Tekan tombol + untuk mencatat alasan berhenti pertama.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
