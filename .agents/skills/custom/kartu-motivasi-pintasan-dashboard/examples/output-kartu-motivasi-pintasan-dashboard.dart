// commit: e6595744b3840998d840e398ca1782e7be7d50b4
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class DashboardBenar extends ConsumerWidget {
  const DashboardBenar({super.key});
  @override Widget build(BuildContext context, WidgetRef ref) {
    final alasanAsync = ref.watch(alasanBerhentiProvider);
    
    // BENAR: asData?.value untuk data opsional
    final jumlah = alasanAsync.asData?.value?.jumlahAlasan ?? 0;
    L.i('jumlahAlasan=$jumlah');
    
    // BENAR: unawaited DENGAN catchError
    return Column(children: [
      Text('Alasan: $jumlah'),
      ElevatedButton(
        onPressed: () => unawaited(
          Nav.to(context, const SosCravingScreen()).catchError((e, s) {
            L.e('Gagal navigasi ke SOS Craving: $e $s');
            return null;
          }),
        ),
        child: const Text('SOS Craving'),
      ),
    ]);
  }
}

class FormAlasanBenar extends ConsumerStatefulWidget {
  const FormAlasanBenar({super.key});
  @override ConsumerState<FormAlasanBenar> createState() => _FormAlasanBenarState();
}

class _FormAlasanBenarState extends ConsumerState<FormAlasanBenar> {
  final _teksController = TextEditingController();
  final snippets = ['Kesehatan', 'Keluarga', 'Uang', 'Kebebasan'];
  
  @override Widget build(BuildContext context) => Column(children: snippets.map((snippet) {
    final terpilih = _teksController.text == snippet;
    // BENAR: Log FilterChip
    L.i('snippet=$snippet, terpilih=$terpilih');
    return FilterChip(
      label: Text(snippet), selected: terpilih,
      onSelected: (dipilih) {
        L.i('snippet dipilih=$snippet, dipilih=$dipilih');
        setState(() => _teksController.text = dipilih ? snippet : '');
      },
    );
  }).toList());
}