// commit: 1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec
import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/shared/utils/format_tanggal.dart';
import 'package:flutter/material.dart';

class _BiodataScreenStateSalah extends State<BiodataScreen> {
  @override
  Widget build(BuildContext context) {
    final biodata = BiodataModel(
      tanggalLahir: DateTime(1990, 1, 1),
      tanggalMulaiMerokok: DateTime(2010, 5, 15),
      tanggalMulaiBerhentiMerokok: null,
    );

    // Menggunakan operator ! langsung pada field nullable - MELANGGAR type promotion
    return Column(
      children: [
        _buildItemSalah(
          'Tanggal lahir',
          biodata.tanggalLahir == null
              ? 'Belum dipilih'
              : FormatTanggal.formatDasar(biodata.tanggalLahir!),
        ),
        _buildItemSalah(
          'Tanggal mulai merokok',
          biodata.tanggalMulaiMerokok == null
              ? 'Belum dipilih'
              : FormatTanggal.formatDasar(biodata.tanggalMulaiMerokok!),
        ),
        _buildItemSalah(
          'Tanggal mulai berhenti',
          biodata.tanggalMulaiBerhentiMerokok == null
              ? 'Belum dipilih'
              : FormatTanggal.formatDasar(biodata.tanggalMulaiBerhentiMerokok!),
        ),
      ],
    );
  }

  Widget _buildItemSalah(String label, String value) {
    return ListTile(title: Text(label), subtitle: Text(value));
  }
}