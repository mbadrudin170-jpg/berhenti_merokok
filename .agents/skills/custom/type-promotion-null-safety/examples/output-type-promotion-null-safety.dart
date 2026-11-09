// commit: 1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec
import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/shared/utils/format_tanggal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _BiodataScreenStateBenar extends ConsumerState<BiodataScreen> {
  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    final biodata = biodataAsync.asData?.value;

    // Salin field nullable ke variabel lokal SEBELUM null-check
    final tanggalLahir = biodata?.tanggalLahir;
    final tanggalMulaiMerokok = biodata?.tanggalMulaiMerokok;
    final tanggalMulaiBerhentiMerokok = biodata?.tanggalMulaiBerhentiMerokok;

    // Gunakan variabel lokal untuk null-check - type promotion berlaku
    return Column(
      children: [
        _buildItemBenar(
          'Tanggal lahir',
          tanggalLahir == null
              ? 'Belum dipilih'
              : FormatTanggal.formatDasar(tanggalLahir),
        ),
        _buildItemBenar(
          'Tanggal mulai merokok',
          tanggalMulaiMerokok == null
              ? 'Belum dipilih'
              : FormatTanggal.formatDasar(tanggalMulaiMerokok),
        ),
        _buildItemBenar(
          'Tanggal mulai berhenti',
          tanggalMulaiBerhentiMerokok == null
              ? 'Belum dipilih'
              : FormatTanggal.formatDasar(tanggalMulaiBerhentiMerokok),
        ),
      ],
    );
  }

  Widget _buildItemBenar(String label, String value) {
    return ListTile(title: Text(label), subtitle: Text(value));
  }
}