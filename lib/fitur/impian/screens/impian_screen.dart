import 'dart:async';

import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/screens/detail_impian_screen.dart';
import 'package:berhenti_merokok/fitur/impian/screens/form_impian.dart';
import 'package:berhenti_merokok/fitur/impian/state/impian_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class ImpianScreen extends ConsumerStatefulWidget {
  const ImpianScreen({super.key});

  @override
  ConsumerState<ImpianScreen> createState() => _ImpianScreenState();
}

class _ImpianScreenState extends ConsumerState<ImpianScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final impianAsync = ref.watch(impianProvider);

    if (impianAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (impianAsync.hasError) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gagal memuat data impian'),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  final _ = ref.refresh(impianProvider);
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final impianState = impianAsync.requireValue;
    final List<ImpianModel> listImpian = impianState.listImpian;
    if (listImpian.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Impian')),
        body: const _EmptyImpian(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => unawaited(Nav.to(context, const FormImpian())),
          child: const Icon(CupertinoIcons.add),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Impian')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 8,
            children: [
              _buildSaldoTerkumpul(impianState),
              Expanded(
                child: ListView.separated(
                  itemCount: listImpian.length,
                  itemBuilder: (context, index) {
                    final ImpianModel item = listImpian[index];
                    return Card(
                      key: ValueKey(item.id),
                      child: ListTile(
                        onTap: () => unawaited(
                          Nav.to(context, DetailImpianScreen(id: item.id)),
                        ),
                        title: Text(item.nama),
                        subtitle: Text(
                          'Target: ${FormatTanggal.formatDasar(item.targetTanggal)}',
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => unawaited(Nav.to(context, const FormImpian())),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }

  Widget _buildSaldoTerkumpul(ImpianState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Saldo terkumpul'),
            Text(
              '${FormatUang.formatRupiah(state.totalJumlah)}',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget untuk state kosong daftar impian.
class _EmptyImpian extends StatelessWidget {
  const _EmptyImpian();

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
              Icon(CupertinoIcons.star, size: 48),
              Text(
                'Belum ada impian',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Tekan tombol + untuk menambah impian pertama.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
