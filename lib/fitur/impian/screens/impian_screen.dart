import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/enum/sort_impian.dart';
import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/screens/detail_impian_screen.dart';
import 'package:berhenti_merokok/fitur/impian/screens/form_impian.dart';
import 'package:collection/collection.dart';
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
  SortImpian _sortImpian = SortImpian.mendekatiTerkumpulAz;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showModalSort() {
    L.i('sortImpian=$_sortImpian');
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Text(
                  'Urutkan',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                ...SortImpian.values.map((sort) {
                  return ListTile(
                    leading: Icon(sort.icon),
                    title: Text(sort.label),
                    trailing: _sortImpian == sort
                        ? const Icon(Icons.check)
                        : null,
                    onTap: () {
                      setState(() => _sortImpian = sort);
                      Nav.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final impianAsync = ref.watch(impianProvider);
    final biodataAsync = ref.watch(biodataProvider);
    L.i(
      'impianAsync.isLoading=${impianAsync.isLoading}, hasError=${impianAsync.hasError}',
    );

    if (impianAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (impianAsync.hasError) {
      L.w('impianProvider error=${impianAsync.error}');
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
    final List<ImpianModel> listImpianAsli = impianState.listImpian;
    L.i(
      'listImpian.length=${listImpianAsli.length}, totalJumlah=${impianState.totalJumlah}',
    );

    // Saldo terkumpul = uang yang dihemat dari tidak merokok (berdasarkan biodata).
    BiodataModel? biodata;
    if (biodataAsync.isLoading) {
      L.w('biodataAsync loading');
    } else if (biodataAsync.hasError) {
      L.w('biodataAsync error=${biodataAsync.error}');
    } else {
      biodata = biodataAsync.requireValue;
    }
    final uangDihemat = biodata?.uangDihemat ?? 0;
    L.i('uangDihemat=$uangDihemat');

    final List<ImpianModel> listImpian = listImpianAsli.sorted((a, b) {
      switch (_sortImpian) {
        case SortImpian.namaAz:
          return a.nama.compareTo(b.nama);
        case SortImpian.namaZa:
          return b.nama.compareTo(a.nama);
        case SortImpian.jumlahAz:
          return a.jumlah.compareTo(b.jumlah);
        case SortImpian.jumlahZa:
          return b.jumlah.compareTo(a.jumlah);
        case SortImpian.mendekatiTerkumpulAz:
          final sisaA = (a.jumlah - uangDihemat).clamp(0.0, double.infinity);
          final sisaB = (b.jumlah - uangDihemat).clamp(0.0, double.infinity);
          return sisaA.compareTo(sisaB);
        case SortImpian.mendekatiTerkumpulZa:
          final sisaA = (a.jumlah - uangDihemat).clamp(0.0, double.infinity);
          final sisaB = (b.jumlah - uangDihemat).clamp(0.0, double.infinity);
          return sisaB.compareTo(sisaA);
      }
    });
    final jumlahTercapai = listImpian
        .where((item) => uangDihemat >= item.jumlah)
        .length;
    L.i('jumlahTercapai=$jumlahTercapai/${listImpian.length}');

    if (listImpian.isEmpty) {
      L.w('listImpian kosong');
      return Scaffold(
        appBar: AppBar(
          title: const Text('Impian'),
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          scrolledUnderElevation: 2,
          forceMaterialTransparency: false,
        ),
        body: const _EmptyImpian(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => unawaited(Nav.to(context, const FormImpian())),
          child: const Icon(CupertinoIcons.add),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impian'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 2,
        forceMaterialTransparency: false,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.sort_up),
            onPressed: () => _showModalSort(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 8,
            children: [
              _buildSaldoTerkumpul(uangDihemat),
              Text(
                '$jumlahTercapai dari ${listImpian.length} impian tercapai',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: listImpian.length,
                  itemBuilder: (context, index) {
                    final ImpianModel item = listImpian[index];
                    L.i(
                      'item.id=${item.id}, item.nama=${item.nama}, item.jumlah=${item.jumlah}',
                    );
                    return Card(
                      key: ValueKey(item.id),
                      child: ListTile(
                        onTap: () => unawaited(
                          Nav.to(context, DetailImpianScreen(id: item.id)),
                        ),
                        title: Text(item.nama),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            LinearProgressIndicator(
                              value: uangDihemat <= 0 || item.jumlah <= 0
                                  ? 0
                                  : (uangDihemat / item.jumlah).clamp(0.0, 1.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sisa: ${FormatUang.formatRupiah((item.jumlah - uangDihemat).clamp(0.0, double.infinity))}',
                                ),
                                Text(FormatUang.formatRupiah(item.jumlah)),
                              ],
                            ),
                          ],
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

  Widget _buildSaldoTerkumpul(double saldoTerkumpul) {
    L.i('saldoTerkumpul=$saldoTerkumpul');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Saldo terkumpul'),
            Text(
              '${FormatUang.formatRupiah(saldoTerkumpul)}',
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
