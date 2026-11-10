import 'dart:async';

import 'package:berhenti_merokok/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/screens/form_konsumsi_rokok.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/state/konsumsi_rokok_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Layar daftar riwayat konsumsi rokok harian dengan FAB quick log (+1).
class KonsumsiRokokScreen extends ConsumerStatefulWidget {
  const KonsumsiRokokScreen({super.key});

  @override
  ConsumerState<KonsumsiRokokScreen> createState() =>
      _KonsumsiRokokScreenState();
}

class _KonsumsiRokokScreenState extends ConsumerState<KonsumsiRokokScreen> {
  @override
  Widget build(BuildContext context) {
    final konsumsiAsync = ref.watch(konsumsiRokokProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Konsumsi Rokok')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: konsumsiAsync.when(
            data: (state) {
              if (state.listKonsumsi.isEmpty) {
                return const _EmptyKonsumsiRokok();
              }
              return _DaftarKonsumsi(state: state);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) {
              L.e('KonsumsiRokokScreen error: $e $s');
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    const Text('Gagal memuat data konsumsi'),
                    OutlinedButton(
                      onPressed: () {
                        final _ = ref.refresh(konsumsiRokokProvider);
                      },
                      child: const Text('Coba lagi'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => unawaited(
          ref
              .read(konsumsiRokokProvider.notifier)
              .catatCepat()
              .then((_) {
                if (mounted) {
                  AppToast.sukses(context, 'Rokok dicatat (+1)');
                }
              })
              .catchError((Object e, StackTrace s) {
                L.e('Gagal catat cepat konsumsi: $e $s');
                if (mounted) {
                  AppToast.gagal(context, 'Gagal mencatat rokok');
                }
              }),
        ),
        child: const Icon(CupertinoIcons.add),
        tooltip: 'Catat Rokok (+1)',
      ),
    );
  }
}

/// Widget terisolasi yang menampilkan daftar kartu konsumsi per tanggal.
class _DaftarKonsumsi extends StatelessWidget {
  const _DaftarKonsumsi({required this.state});

  final KonsumsiRokokState state;

  @override
  Widget build(BuildContext context) {
    final ringkasan = state.ringkasanHarian;
    final tanggalUrut = ringkasan.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      itemCount: tanggalUrut.length,
      itemBuilder: (context, index) {
        final tanggalKey = tanggalUrut[index];
        final total = ringkasan[tanggalKey] ?? 0;
        final entriHari = state.listKonsumsi.where((e) {
          final lokal = e.tanggal.toLocal();
          final key =
              '${lokal.year}-${lokal.month.toString().padLeft(2, '0')}-${lokal.day.toString().padLeft(2, '0')}';
          return key == tanggalKey;
        }).toList();
        final adaSlip = entriHari.any((e) => e.isSlip);
        final tanggalContoh = entriHari.isNotEmpty
            ? entriHari.first.tanggal
            : null;

        return Card(
          key: ValueKey(tanggalKey),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                tanggalContoh != null ? '${tanggalContoh.day}' : '?',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            title: Text(
              tanggalContoh != null
                  ? FormatTanggal.formatSingkat(tanggalContoh)
                  : tanggalKey,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '$total batang${adaSlip ? '  •  SLIP' : ''}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: adaSlip
                    ? const Color(0xFFEF5350)
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: adaSlip ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: adaSlip
                ? const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFEF5350),
                  )
                : const Icon(CupertinoIcons.chevron_right),
            onTap: () => unawaited(
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => FormKonsumsiRokok(
                  konsumsi: entriHari.isNotEmpty ? entriHari.first : null,
                ),
              ).catchError((Object e, StackTrace s) {
                L.e('Gagal membuka form konsumsi: $e $s');
                return null;
              }),
            ),
          ),
        );
      },
    );
  }
}

/// Empty state saat belum ada data konsumsi.
class _EmptyKonsumsiRokok extends StatelessWidget {
  const _EmptyKonsumsiRokok();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              Icon(CupertinoIcons.smoke, size: 64, color: Colors.grey),
              Text(
                'Belum ada catatan konsumsi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Tekan tombol + untuk mencatat rokok pertama Anda.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
