// commit: 1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BiodataScreen extends ConsumerWidget {
  const BiodataScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(body: Text('Biodata'));
  }
}