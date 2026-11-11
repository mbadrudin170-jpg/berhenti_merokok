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
import 'package:berhenti_merokok/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart';
import 'package:berhenti_merokok/shared/widget/empty_state_view.dart';
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
    final konsumsiAsync = ref.watch(konsumsiRokokProvider);
    L.i(
      'impianAsync.isLoading=${impianAsync.isLoading}, hasError=${impianAsync.hasError}, konsumsiAsync.isLoading=${konsumsiAsync.isLoading}, hasError=${konsumsiAsync.hasError}',
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

    // Catatan konsumsi dipakai untuk saldo aktual ("dari catatan"). Bila belum
    // ada (atau gagal dimuat), progress memakai estimasi baseline biodata.
    var konsumsiList = const <KonsumsiRokokModel>[];
    if (konsumsiAsync.isLoading) {
      L.w('konsumsiAsync loading');
    } else if (konsumsiAsync.hasError) {
      L.w('konsumsiAsync error=${konsumsiAsync.error}');
    } else {
      konsumsiList = konsumsiAsync.requireValue.listKonsumsi;
    }

    // Saldo terkumpul: estimasi dari biodata dan aktual dari catatan konsumsi.
    BiodataModel? biodata;
    if (biodataAsync.isLoading) {
      L.w('biodataAsync loading');
    } else if (biodataAsync.hasError) {
      L.w('biodataAsync error=${biodataAsync.error}');
    } else {
      biodata = biodataAsync.requireValue;
    }
    final uangEstimasi = biodata == null
        ? 0.0
        : MetrikBerhentiHelper.hitungUangDihematEstimasi(biodata);
    final uangAktual = biodata == null
        ? 0.0
        : MetrikBerhentiHelper.hitungUangDihematAktual(biodata, konsumsiList);
    final hariTercatat = MetrikBerhentiHelper.hitungJumlahHariTercatat(
      konsumsiList,
    );
    final pakaiAktual = hariTercatat > 0;
    // Progres impian: aktual bila ada catatan, fallback estimasi.
    final saldoUntukProgres = pakaiAktual ? uangAktual : uangEstimasi;
    L.i(
      'uangEstimasi=$uangEstimasi, uangAktual=$uangAktual, hariTercatat=$hariTercatat, pakaiAktual=$pakaiAktual, saldoUntukProgres=$saldoUntukProgres',
    );

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
          final sisaA = ImpianProgresHelper.sisa(saldoUntukProgres, a.jumlah);
          final sisaB = ImpianProgresHelper.sisa(saldoUntukProgres, b.jumlah);
          return sisaA.compareTo(sisaB);
        case SortImpian.mendekatiTerkumpulZa:
          final sisaA = ImpianProgresHelper.sisa(saldoUntukProgres, a.jumlah);
          final sisaB = ImpianProgresHelper.sisa(saldoUntukProgres, b.jumlah);
          return sisaB.compareTo(sisaA);
      }
    });
    final jumlahTercapai = listImpian
        .where(
          (item) =>
              ImpianProgresHelper.tercapai(saldoUntukProgres, item.jumlah),
        )
        .length;
    L.i('jumlahTercapai=$jumlahTercapai/${listImpian.length}');

    // Cek impian yang baru tercapai. Toast dan penandaan dijadwalkan
    // setelah build selesai agar AppToast (FToast.showToast) tidak memanggil
    // setState/insert Overlay selama fase build, dan agar _sudahDiraikan
    // terupdate sehingga toast tidak muncul berulang pada setiap rebuild.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      for (final item in listImpian) {
        final sudahTercapai = ImpianProgresHelper.tercapai(
          saldoUntukProgres,
          item.jumlah,
        );
        if (sudahTercapai && !_sudahDiraikan.contains(item.id)) {
          L.i('impianTercapai=${item.nama}, id=${item.id}');
          AppToast.sukses(
            context,
            'Selamat! Impian "${item.nama}" telah tercapai!',
          );
          unawaited(_tandaiSudahDiraikan(item.id));
          setState(() {
            _sudahDiraikan.add(item.id);
          });
        }
      }
    });

    if (listImpian.isEmpty) {
      L.w('listImpian kosong');
      return Scaffold(
        appBar: AppBar(title: const Text('Impian'), scrolledUnderElevation: 2),
        body: EmptyStateView(
          ikon: CupertinoIcons.star,
          judul: 'Belum ada impian',
          deskripsi:
              'Catat impian yang ingin kamu capai dengan uang yang dihemat '
              'dari berhenti merokok.',
          ctaLabel: 'Tambah Impian',
          onCta: () => unawaited(
            Nav.to(context, const FormImpian()).catchError((
              Object e,
              StackTrace s,
            ) {
              L.e('Gagal navigasi ke Form Impian: $e $s');
              return null;
            }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => unawaited(
            Nav.to(context, const FormImpian()).catchError((
              Object e,
              StackTrace s,
            ) {
              L.e('Gagal navigasi ke Form Impian: $e $s');
              return null;
            }),
          ),
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
              _buildSaldoTerkumpul(
                uangEstimasi,
                uangAktual,
                pakaiAktual,
                hariTercatat,
              ),
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
                      saldoUntukProgres,
                      item.jumlah,
                    );
                    final sudahTercapai = ImpianProgresHelper.tercapai(
                      saldoUntukProgres,
                      item.jumlah,
                    );
                    final sisa = ImpianProgresHelper.sisa(
                      saldoUntukProgres,
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
                              pakaiAktual: pakaiAktual,
                              labelSaldo: pakaiAktual
                                  ? 'Progres dari catatan (berdasarkan $hariTercatat hari tercatat)'
                                  : 'Progres estimasi dari biodata',
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
        onPressed: () => unawaited(
            Nav.to(context, const FormImpian()).catchError((
              Object e,
              StackTrace s,
            ) {
              L.e('Gagal navigasi ke Form Impian: $e $s');
              return null;
            }),
          ),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }

  Widget _buildSaldoTerkumpul(
    double estimasi,
    double aktual,
    bool pakaiAktual,
    int hariTercatat,
  ) {
    L.i(
      'estimasi=$estimasi, aktual=$aktual, pakaiAktual=$pakaiAktual, hariTercatat=$hariTercatat',
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        // Jarak seragam antar-anak Row diatur dengan properti spacing
        // (optimasi_ui.md #4), bukan SizedBox individual.
        child: Column(
          spacing: 8,
          children: [
            Text(
              'Saldo terkumpul',
              style: Theme.of(context).textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                const Icon(Icons.savings_outlined),
                _SaldoItem(
                  label: 'Estimasi',
                  nilai: FormatUang.formatRupiah(estimasi),
                ),
                _SaldoItem(
                  label: 'Dari catatan',
                  nilai: pakaiAktual
                      ? FormatUang.formatRupiah(aktual)
                      : 'Belum ada catatan',
                ),
              ],
            ),
            Text(
              pakaiAktual
                  ? 'Aktual berdasarkan $hariTercatat hari tercatat. Estimasi dari kebiasaan harian biodata.'
                  : 'Belum ada catatan konsumsi. Menampilkan estimasi dari kebiasaan harian biodata.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Item saldo dengan label sumber angka ("Estimasi" / "Dari catatan").
class _SaldoItem extends StatelessWidget {
  const _SaldoItem({required this.label, required this.nilai});

  final String label;
  final String nilai;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 4,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        Text(
          nilai,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}


