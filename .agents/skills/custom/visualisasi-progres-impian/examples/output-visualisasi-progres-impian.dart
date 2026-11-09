// commit: c7337d1519d495d0ccd022fb18d63f72d443866a
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// BENAR: Helper murni tanpa BuildContext/provider
class ImpianProgresHelper {
  const ImpianProgresHelper._();
  static double rasio(double saldo, double target) {
    if (target <= 0) return 0.0; // Guard divisi nol
    return (saldo / target).clamp(0.0, 1.0);
  }
  static bool tercapai(double saldo, double target) {
    if (target <= 0) return false;
    return saldo >= target;
  }
}

class ImpianScreenBenar extends ConsumerWidget {
  const ImpianScreenBenar({super.key});
  @override Widget build(BuildContext context, WidgetRef ref) {
    final impianState = ref.watch(impianProvider).requireValue;
    final biodataAsync = ref.watch(biodataProvider);
    final biodata = biodataAsync.asData?.value;
    final uangDihemat = biodata?.uangDihemat ?? 0; // BENAR: saldo dari biodata.uangDihemat
    
    return ListView.builder(itemCount: impianState.list.length, itemBuilder: (_, i) {
      final item = impianState.list[i];
      // BENAR: Pakai helper murni
      final rasio = ImpianProgresHelper.rasio(uangDihemat, item.jumlah);
      final tercapai = ImpianProgresHelper.tercapai(uangDihemat, item.jumlah);
      
      // BENAR: Perayaan sekali via SharedPreferences
      if (tercapai) {
        unawaited(_tandaiDanRaiikan(context, item.id, item.nama));
      }
      
      return ListTile(
        title: Text(item.nama),
        subtitle: LinearProgressIndicator(value: rasio),
        trailing: tercapai ? const Icon(Icons.celebration, color: Colors.amber) : null,
      );
    });
  }
  
  Future<void> _tandaiDanRaiikan(BuildContext context, String id, String nama) async {
    final prefs = await SharedPreferences.getInstance();
    final daftar = prefs.getStringList('impian_diraikan') ?? <String>[];
    if (!daftar.contains(id)) {
      daftar.add(id);
      await prefs.setStringList('impian_diraikan', daftar);
      AppToast.sukses(context, 'Selamat! Impian "$nama" telah tercapai!');
    }
  }
}