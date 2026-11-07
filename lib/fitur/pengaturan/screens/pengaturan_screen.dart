import 'dart:async';

import 'package:berhenti_merokok/fitur/tema/enum/tema_enum.dart';
import 'package:berhenti_merokok/fitur/tema/notifier/tema_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman pengaturan aplikasi, termasuk pilihan tema.
class PengaturanScreen extends ConsumerStatefulWidget {
  const PengaturanScreen({super.key});

  @override
  ConsumerState<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends ConsumerState<PengaturanScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _ubahTema(TemaEnum tema) async {
    L.i('tema=$tema');
    try {
      await ref.read(temaProvider.notifier).set(tema);
    } on Exception catch (e, s) {
      L.e('Gagal mengubah tema: $e $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildTema()],
        ),
      ),
    );
  }

  Widget _buildTema() {
    final temaAsync = ref.watch(temaProvider);
    L.i('temaAsync=$temaAsync');
    if (temaAsync.isLoading) {
      L.w('tema loading');
      return const SizedBox.shrink();
    }
    if (temaAsync.hasError) {
      L.w('tema error');
      return const SizedBox.shrink();
    }
    final temaSaatIni = temaAsync.requireValue;
    L.i('temaSaatIni=$temaSaatIni');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Tema', style: Theme.of(context).textTheme.bodyMedium),
        PopupMenuButton<TemaEnum>(
          initialValue: temaSaatIni,
          onSelected: (tema) {
            unawaited(_ubahTema(tema));
          },
          itemBuilder: (context) => TemaEnum.values
              .map(
                (tema) => PopupMenuItem<TemaEnum>(
                  value: tema,
                  child: Row(
                    spacing: 8,
                    children: [Icon(tema.icon), Text(tema.label)],
                  ),
                ),
              )
              .toList(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(temaSaatIni.icon),
              Text(temaSaatIni.label),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    );
  }
}
