// commit: 338a0216257bb9f75617f144fd2fae0d7faf63d2
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CadanganSalah extends ConsumerStatefulWidget {
  const CadanganSalah({super.key});
  @override ConsumerState<CadanganSalah> createState() => _CadanganSalahState();
}

class _CadanganSalahState extends ConsumerState<CadanganSalah> {
  Future<void> _pulihkan() async {
    // SALAH: Pemulihan tanpa transaksi atomic
    final op = SqfliteOp();
    for (final tabel in ['tabel1', 'tabel2']) {
      await op.hapusSemua(tabel);
      await op.tambah(tabel, {}); // Jika gagal di tengah, data rusak
    }
    
    // SALAH: String matching untuk error
    try {} catch (e) { if (e.toString().contains('invalid')) {} }
    
    // SALAH: unawaited tanpa catchError
    unawaited(EasyLoading.show(status: 'Memproses...'));
    unawaited(EasyLoading.dismiss());
    
    // SALAH: Tidak cek mounted setelah await
    Navigator.pop(context);
  }

  @override Widget build(BuildContext context) => ElevatedButton(onPressed: _pulihkan, child: const Text('Pulihkan'));
}

class SqfliteOp { Future<void> hapusSemua(String tabel) async {} Future<void> tambah(String tabel, Map data) async {} }