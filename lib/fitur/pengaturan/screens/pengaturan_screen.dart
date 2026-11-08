import 'dart:async';

import 'package:berhenti_merokok/fitur/tema/enum/tema_enum.dart';
import 'package:berhenti_merokok/fitur/tema/notifier/tema_notifier.dart';
import 'package:berhenti_merokok/shared/notifikasi/notifikasi_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman pengaturan aplikasi, termasuk pilihan tema dan notifikasi.
class PengaturanScreen extends ConsumerStatefulWidget {
  const PengaturanScreen({super.key});

  @override
  ConsumerState<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends ConsumerState<PengaturanScreen> {
  bool _notifikasiAktif = false;
  int _jam = 8;
  int _menit = 0;
  bool _memuatNotifikasi = true;

  @override
  void initState() {
    super.initState();
    _muatPreferensiNotifikasi();
  }

  Future<void> _muatPreferensiNotifikasi() async {
    L.i('PengaturanScreen initState notifikasi');
    try {
      final aktif = await NotifikasiService.aktif();
      final jam = await NotifikasiService.jam();
      final menit = await NotifikasiService.menit();
      if (!mounted) return;
      setState(() {
        _notifikasiAktif = aktif;
        _jam = jam;
        _menit = menit;
        _memuatNotifikasi = false;
      });
      L.i('aktif=$aktif, jam=$jam, menit=$menit');
    } on Exception catch (e, s) {
      L.e('Gagal memuat preferensi notifikasi: $e $s');
      if (mounted) {
        setState(() {
          _memuatNotifikasi = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _ubahTema(TemaEnum tema) async {
    L.i('tema=$tema');
    try {
      await ref.read(temaProvider.notifier).set(tema);
    } on Exception catch (e, s) {
      L.e('Gagal mengubah tema: $e $s');
    }
  }

  Future<void> _ubahNotifikasi(bool value) async {
    L.i('value=$value');
    setState(() {
      _notifikasiAktif = value;
    });
    try {
      if (value) {
        await NotifikasiService.jadwalkanPengingatHarian(
          jam: _jam,
          menit: _menit,
        );
        AppToast.sukses(context, 'Pengingat harian diaktifkan');
      } else {
        await NotifikasiService.batalkanPengingatHarian();
        AppToast.info(context, 'Pengingat harian dinonaktifkan');
      }
    } on Exception catch (e, s) {
      L.e('Gagal mengubah notifikasi: $e $s');
      if (mounted) {
        setState(() {
          _notifikasiAktif = !value;
        });
        AppToast.gagal(context, 'Gagal mengubah pengingat harian');
      }
    }
  }

  Future<void> _pilihWaktu() async {
    L.i('jam=$_jam, menit=$_menit');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _jam, minute: _menit),
    );
    if (picked == null) return;
    L.i('picked=${picked.hour}:${picked.minute}');
    setState(() {
      _jam = picked.hour;
      _menit = picked.minute;
    });
    if (_notifikasiAktif) {
      try {
        await NotifikasiService.jadwalkanPengingatHarian(
          jam: _jam,
          menit: _menit,
        );
        AppToast.sukses(context, 'Waktu pengingat diperbarui');
      } on Exception catch (e, s) {
        L.e('Gagal memperbarui waktu pengingat: $e $s');
        AppToast.gagal(context, 'Gagal memperbarui waktu pengingat');
      }
    } else {
      await NotifikasiService.setWaktu(_jam, _menit);
    }
  }

  Future<void> _ujiNotifikasi() async {
    L.i('uji notifikasi');
    try {
      await NotifikasiService.tampilkanSekarang();
      AppToast.info(context, 'Notifikasi uji coba ditampilkan');
    } on Exception catch (e, s) {
      L.e('Gagal menampilkan notifikasi uji coba: $e $s');
      AppToast.gagal(context, 'Gagal menampilkan notifikasi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [_buildTema(), _buildNotifikasi()],
        ),
      ),
    );
  }

  Widget _buildTema() {
    final temaAsync = ref.watch(temaProvider);
    L.i('temaAsync=$temaAsync');
    if (temaAsync.isLoading) {
      L.w('tema loading');
      return const SizedBox.shrink();
    }
    if (temaAsync.hasError) {
      L.w('tema error');
      return const SizedBox.shrink();
    }
    final temaSaatIni = temaAsync.requireValue;
    L.i('temaSaatIni=$temaSaatIni');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Tema', style: Theme.of(context).textTheme.bodyMedium),
        PopupMenuButton<TemaEnum>(
          initialValue: temaSaatIni,
          onSelected: (tema) {
            unawaited(_ubahTema(tema));
          },
          itemBuilder: (context) => TemaEnum.values
              .map(
                (tema) => PopupMenuItem<TemaEnum>(
                  value: tema,
                  child: Row(
                    spacing: 8,
                    children: [Icon(tema.icon), Text(tema.label)],
                  ),
                ),
              )
              .toList(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(temaSaatIni.icon),
              Text(temaSaatIni.label),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotifikasi() {
    if (_memuatNotifikasi) {
      return const Center(child: CircularProgressIndicator());
    }
    final waktu =
        '${_jam.toString().padLeft(2, '0')}:${_menit.toString().padLeft(2, '0')}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pengingat harian',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Switch(
              value: _notifikasiAktif,
              onChanged: (value) {
                unawaited(_ubahNotifikasi(value));
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Waktu: $waktu', style: Theme.of(context).textTheme.bodySmall),
            OutlinedButton(
              onPressed: () {
                unawaited(_pilihWaktu());
              },
              child: const Text('Ubah waktu'),
            ),
          ],
        ),
        OutlinedButton(
          onPressed: () {
            unawaited(_ujiNotifikasi());
          },
          child: const Text('Uji coba notifikasi'),
        ),
      ],
    );
  }
}
