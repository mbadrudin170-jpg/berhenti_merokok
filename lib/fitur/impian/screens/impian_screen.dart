import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/enum/sort_impian.dart';
import 'package:berhenti_merokok/fitur/impian/helper/impian_progres_helper.dart';
import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/screens/detail_impian_screen.dart';
import 'package:berhenti_merokok/fitur/impian/screens/form_impian.dart';
import 'package:berhenti_merokok/fitur/impian/widget/visual_tabungan_impian.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImpianScreen extends ConsumerStatefulWidget {
  const ImpianScreen({super.key});

  @override
  ConsumerState<ImpianScreen> createState() => _ImpianScreenState();
}

class _ImpianScreenState extends ConsumerState<ImpianScreen> {
  SortImpian _sortImpian = SortImpian.mendekatiTerkumpulAz;
  final Set<String> _sudahDiraikan = <String>{};

  @override
  void initState() {
    super.initState();
    _muatSudahDiraikan();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _muatSudahDiraikan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final daftar = prefs.getStringList('impian_diraikan') ?? <String>[];
      if (mounted) {
        setState(() {
          _sudahDiraikan.addAll(daftar);
        });
      }
    } catch (e, s) {
      L.e('Gagal memuat daftar impian diraikan: $e $s');
    }
  }

  Future<void> _tandaiSudahDiraikan(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final daftar = prefs.getStringList('impian_diraikan') ?? <String>[];
      if (!daftar.contains(id)) {
        daftar.add(id);
        await prefs.setStringList('impian_diraikan', daftar);
      }
    } catch (e, s) {
      L.e('Gagal menyimpan impian diraikan: $e $s');
    }
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
          final sisaA = ImpianProgresHelper.sisa(uangDihemat, a.jumlah);
          final sisaB = ImpianProgresHelper.sisa(uangDihemat, b.jumlah);
          return sisaA.compareTo(sisaB);
        case SortImpian.mendekatiTerkumpulZa:
          final sisaA = ImpianProgresHelper.sisa(uangDihemat, a.jumlah);
          final sisaB = ImpianProgresHelper.sisa(uangDihemat, b.jumlah);
          return sisaB.compareTo(sisaA);
      }
    });
    final jumlahTercapai = listImpian
        .where((item) => ImpianProgresHelper.tercapai(uangDihemat, item.jumlah))
        .length;
    L.i('jumlahTercapai=$jumlahTercapai/${listImpian.length}');

    // Cek impian yang baru tercapai dan tampilkan toast perayaan.
    for (final item in listImpian) {
      final sudahTercapai = ImpianProgresHelper.tercapai(
        uangDihemat,
        item.jumlah,
      );
      if (sudahTercapai && !_sudahDiraikan.contains(item.id)) {
        if (mounted) {
          AppToast.sukses(
            context,
            'Selamat! Impian "${item.nama}" telah tercapai!',
          );
        }
        unawaited(_tandaiSudahDiraikan(item.id));
      }
    }

    if (listImpian.isEmpty) {
      L.w('listImpian kosong');
      return Scaffold(
        appBar: AppBar(title: const Text('Impian'), scrolledUnderElevation: 2),
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
        scrolledUnderElevation: 2,
        actions: [
          IconButton(
            tooltip: 'Urutkan',
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
                    final rasio = ImpianProgresHelper.rasio(
                      uangDihemat,
                      item.jumlah,
                    );
                    final sudahTercapai = ImpianProgresHelper.tercapai(
                      uangDihemat,
                      item.jumlah,
                    );
                    final sisa = ImpianProgresHelper.sisa(
                      uangDihemat,
                      item.jumlah,
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
                            VisualTabunganImpian(
                              rasio: rasio,
                              tercapai: sudahTercapai,
                            ),
                            if (sudahTercapai)
                              Text(
                                'Tercapai',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            // Bungkus Text dengan Flexible agar tidak overflow pada layar sempit.
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Sisa: ${FormatUang.formatRupiah(sisa)}',
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Target: ${FormatUang.formatRupiah(item.jumlah)}',
                                    textAlign: TextAlign.end,
                                  ),
                                ),
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
        // Jarak seragam antar-anak Row diatur dengan properti spacing
        // (optimasi_ui.md #4), bukan SizedBox individual.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            const Icon(Icons.savings_outlined),
            Column(
              children: [
                const Text('Saldo terkumpul'),
                Text(
                  FormatUang.formatRupiah(saldoTerkumpul),
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
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
