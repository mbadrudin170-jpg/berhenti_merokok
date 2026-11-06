import 'dart:async';

import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/screens/form_impian.dart';
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

    return Scaffold(
      appBar: AppBar(title: const Text('Impian')),
      body: Center(
        child: Text('ImpianScreen (${impianState.jumlahImpian} impian)'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => unawaited(Nav.to(context, const FormImpian())),
      ),
    );
  }
}
