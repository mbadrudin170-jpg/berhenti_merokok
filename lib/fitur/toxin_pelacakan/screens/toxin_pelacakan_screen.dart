import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart';
import 'package:berhenti_merokok/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart';
import 'package:berhenti_merokok/fitur/toxin_pelacakan/helper/toxin_hitung_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Layar pelacakan toxin yang dihindari tubuh sejak tidak merokok.
///
/// Menampilkan daftar zat berbahaya berdasarkan estimasi rokok yang tidak
/// dihisap dari biodata berdampingan dengan aktual dari catatan konsumsi
/// (`MetrikBerhentiHelper`).
class ToxinPelacakanScreen extends ConsumerStatefulWidget {
  const ToxinPelacakanScreen({super.key});

  @override
  ConsumerState<ToxinPelacakanScreen> createState() =>
      _ToxinPelacakanScreenState();
}

class _ToxinPelacakanScreenState extends ConsumerState<ToxinPelacakanScreen> {
  @override
  void initState() {
    super.initState();
    L.i('ToxinPelacakanScreen initState');
  }

  @override
  void dispose() {
    L.i('ToxinPelacakanScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    final konsumsiAsync = ref.watch(konsumsiRokokProvider);

    if (biodataAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (biodataAsync.hasError) {
      L.e(
        'biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}',
      );
      return Scaffold(
        appBar: AppBar(title: const Text('Pelacakan Toxin')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  const Text('Gagal memuat data'),
                  OutlinedButton(
                    onPressed: () {
                      final _ = ref.refresh(biodataProvider);
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final biodata = biodataAsync.requireValue;
    if (biodata == null) {
      return _buildBiodataNull();
    }

    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    if (tanggalBerhenti == null) {
      return _buildBelumBerhenti();
    }

    final rokokEstimasi = MetrikBerhentiHelper.hitungRokokTidakDiHisapEstimasi(
      biodata,
    );
    final konsumsiList = konsumsiAsync.asData?.value.listKonsumsi;
    final adaCatatan = konsumsiList != null && konsumsiList.isNotEmpty;
    final hariTercatat = adaCatatan
        ? MetrikBerhentiHelper.hitungJumlahHariTercatat(konsumsiList)
        : 0;
    final rokokAktual = adaCatatan
        ? MetrikBerhentiHelper.hitungRokokDihindariAktual(biodata, konsumsiList)
        : 0;

    if (konsumsiAsync.hasError) {
      L.e(
        'konsumsiAsync error: ${konsumsiAsync.error} ${konsumsiAsync.stackTrace}',
      );
    }

    // Fallback seperti badge: aktual bila ada catatan, estimasi bila belum ada.
    final rokokTidakDiHisap = adaCatatan ? rokokAktual : rokokEstimasi;
    L.i(
      'rokokEstimasi=$rokokEstimasi, adaCatatan=$adaCatatan, hariTercatat=$hariTercatat, rokokAktual=$rokokAktual, rokokTidakDiHisap=$rokokTidakDiHisap',
    );

    if (rokokTidakDiHisap == 0) {
      return _buildBelumAdaRokokDiHindari();
    }

    final daftarToxin = ToxinHitungHelper.hitung(rokokTidakDiHisap);
    L.i('daftarToxin.length=${daftarToxin.length}');

    return Scaffold(
      appBar: AppBar(title: const Text('Pelacakan Toxin')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Text(
                'Zat berbahaya yang dihindari',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Rokok yang tidak dihisap sejak '
                '${FormatTanggal.formatDasar(tanggalBerhenti)}:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Estimasi (baseline): $rokokEstimasi batang',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (konsumsiAsync.isLoading)
                Text(
                  'Menghitung dari catatan…',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              else if (konsumsiAsync.hasError)
                Text(
                  'Catatan konsumsi gagal dimuat; menampilkan estimasi.',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              else if (!adaCatatan)
                Text(
                  'Belum ada catatan konsumsi — aktual tersedia setelah Anda '
                  'mencatat.',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              else
                Text(
                  'Dari catatan: $rokokAktual batang dihindari '
                  '(berdasarkan $hariTercatat hari tercatat)',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: daftarToxin.length,
                  itemBuilder: (context, index) {
                    final toxin = daftarToxin[index];
                    return Card(
                      key: ValueKey(toxin.nama),
                      child: ListTile(
                        leading: Icon(
                          CupertinoIcons.cloud,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          toxin.nama,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              '${toxin.jenisZat} · '
                              '${toxin.kuantitasDiHindari.toStringAsFixed(1)} unit',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              toxin.efekSingkat,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                            ),
                          ],
                        ),
                        trailing: Text(
                          'Sumber: ${toxin.sumberReferensi}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Theme.of(context).colorScheme.onSurface
                                    .withValues(alpha: 0.5),
                              ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              Text(
                'Data perkiraan ilustratif berdasarkan referensi kesehatan umum '
                '(WHO / CDC / AHA / ACS), bukan klaim medis aplikasi.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface
                      .withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBiodataNull() {
    return Scaffold(
      appBar: AppBar(title: const Text('Pelacakan Toxin')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                const Icon(CupertinoIcons.info, size: 48),
                const Text(
                  'Belum ada data biodata',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Isi biodata dan tentukan tanggal mulai berhenti untuk '
                  'melihat pelacakan toxin.',
                  textAlign: TextAlign.center,
                ),
                OutlinedButton(
                  onPressed: () => unawaited(
                    Nav.to(
                      context,
                      const FormBiodata(buatPertama: false),
                    ).catchError((Object e, StackTrace s) {
                      L.e('Gagal navigasi ke Form Biodata: $e $s');
                      return null;
                    }),
                  ),
                  child: const Text('Isi Biodata'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBelumBerhenti() {
    return Scaffold(
      appBar: AppBar(title: const Text('Pelacakan Toxin')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                const Icon(CupertinoIcons.heart, size: 48),
                const Text(
                  'Tanggal mulai berhenti belum ditetapkan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Isi tanggal mulai berhenti pada biodata untuk melihat '
                  'pelacakan toxin.',
                  textAlign: TextAlign.center,
                ),
                OutlinedButton(
                  onPressed: () => unawaited(
                    Nav.to(
                      context,
                      const FormBiodata(buatPertama: false),
                    ).catchError((Object e, StackTrace s) {
                      L.e('Gagal navigasi ke Form Biodata: $e $s');
                      return null;
                    }),
                  ),
                  child: const Text('Isi Biodata'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBelumAdaRokokDiHindari() {
    return Scaffold(
      appBar: AppBar(title: const Text('Pelacakan Toxin')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                const Icon(CupertinoIcons.check_mark_circled, size: 48),
                const Text(
                  'Belum ada rokok yang dihindari',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Data toxin akan tersedia setelah Anda mulai hari smoke-free.',
                  textAlign: TextAlign.center,
                ),
                OutlinedButton(
                  onPressed: () => unawaited(
                    Nav.to(
                      context,
                      const FormBiodata(buatPertama: false),
                    ).catchError((Object e, StackTrace s) {
                      L.e('Gagal navigasi ke Form Biodata: $e $s');
                      return null;
                    }),
                  ),
                  child: const Text('Isi Biodata'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
