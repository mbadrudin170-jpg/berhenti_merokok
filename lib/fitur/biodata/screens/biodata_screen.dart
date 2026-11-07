import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class BiodataScreen extends ConsumerStatefulWidget {
  const BiodataScreen({super.key});

  @override
  ConsumerState<BiodataScreen> createState() => _BiodataScreenState();
}

class _BiodataScreenState extends ConsumerState<BiodataScreen> {
  @override
  void initState() {
    super.initState();
    L.i('BiodataScreen initState');
  }

  @override
  void dispose() {
    L.i('BiodataScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    L.i('biodataAsync=$biodataAsync');

    if (biodataAsync.isLoading) {
      L.w('biodataAsync loading');
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      L.e(
        'biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}',
      );
      return Scaffold(
        appBar: AppBar(title: const Text('Biodata')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gagal memuat data'),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  final _ = ref.refresh(biodataProvider);
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final biodata = biodataAsync.requireValue;
    L.i('biodata=$biodata');

    // Salin field nullable ke variabel lokal agar type promotion berlaku
    // (menghindari penggunaan operator `!`).
    final tanggalLahir = biodata?.tanggalLahir;
    final tanggalMulaiMerokok = biodata?.tanggalMulaiMerokok;
    final tanggalMulaiBerhentiMerokok = biodata?.tanggalMulaiBerhentiMerokok;

    return Scaffold(
      appBar: AppBar(title: const Text('Biodata')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: biodata == null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12,
                    children: [
                      const Text('Belum ada data biodata'),
                      OutlinedButton(
                        onPressed: () => unawaited(
                          Nav.to(
                            context,
                            const FormBiodata(buatPertama: false),
                          ),
                        ),
                        child: const Text('Isi Biodata'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 12,
                    children: [
                      _buildItem('Nama', biodata.nama),
                      _buildItem(
                        'Tanggal lahir',
                        tanggalLahir == null
                            ? 'Belum dipilih'
                            : FormatTanggal.formatDasar(tanggalLahir),
                      ),
                      _buildItem(
                        'Jumlah rokok per hari',
                        biodata.jumlahRokokPerHari.toString(),
                      ),
                      _buildItem(
                        'Harga rokok per bungkus',
                        biodata.hargaRokokPerBungkus.toString(),
                      ),
                      _buildItem(
                        'Batang per bungkus',
                        biodata.batangPerBungkus.toString(),
                      ),
                      _buildItem(
                        'Tanggal mulai merokok',
                        tanggalMulaiMerokok == null
                            ? 'Belum dipilih'
                            : FormatTanggal.formatDasar(tanggalMulaiMerokok),
                      ),
                      _buildItem(
                        'Tanggal mulai berhenti merokok',
                        tanggalMulaiBerhentiMerokok == null
                            ? 'Belum dipilih'
                            : FormatTanggal.formatDasar(
                                tanggalMulaiBerhentiMerokok,
                              ),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () => unawaited(
                          Nav.to(
                            context,
                            FormBiodata(
                              buatPertama: false,
                              biodataModel: biodata,
                            ),
                          ),
                        ),
                        child: const Text('Ubah Biodata'),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildItem(String label, String nilai) {
    L.i('label=$label, nilai=$nilai');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(nilai, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
