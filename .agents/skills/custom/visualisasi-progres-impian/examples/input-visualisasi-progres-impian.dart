// commit: c7337d1519d495d0ccd022fb18d63f72d443866a
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImpianScreenSalah extends ConsumerWidget {
  const ImpianScreenSalah({super.key});
  @override Widget build(BuildContext context, WidgetRef ref) {
    final impianState = ref.watch(impianProvider).requireValue;
    final biodata = ref.watch(biodataProvider).requireValue;
    final uangDihemat = biodata?.uangDihemat ?? 0;
    
    return ListView.builder(itemCount: impianState.list.length, itemBuilder: (_, i) {
      final item = impianState.list[i];
      // SALAH: Hitung inline, formula berbeda daftar vs detail
      final rasio = uangDihemat <= 0 || item.jumlah <= 0 ? 0 : (uangDihemat / item.jumlah).clamp(0.0, 1.0);
      // SALAH: Pakai totalJumlah sebagai saldo
      final rasio2 = impianState.totalJumlah <= 0 ? 0 : (impianState.totalJumlah / item.jumlah).clamp(0.0, 1.0);
      
      return ListTile(title: Text(item.nama), subtitle: LinearProgressIndicator(value: rasio));
    });
  }
}

class ImpianProgresHelperSalah {
  static double rasio(double saldo, double target) => saldo / target; // SALAH: no guard divisi nol
}