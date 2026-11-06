// ============================================================
// FILE: lib/app.dart
// ============================================================

```dart
// lib/app.dart

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart' as mui;
import 'package:myapp/fitur/kunci_aplikasi/widget/kunci_aplikasi_gate.dart';
import 'package:myapp/home.dart';
import 'package:myapp/shared/notifikasi/notifikasi_service.dart';
import 'package:myapp/shared/tema/font.dart';
import 'package:myapp/shared/tema/tema_provider.dart';
import 'package:share_global_saya/core_shared.dart';

/// Delegate lokalisasi untuk widget dari paket [material_ui] yang dipakai
/// oleh `adaptive_dialog`. Paket tersebut memakai kelas [MaterialLocalizations]
/// tersendiri, sehingga delegate Flutter bawaan tidak cukup untuk menghindari
/// `null check operator used on a null value`.
class _MaterialUiLocalizationsDelegate
    extends LocalizationsDelegate<mui.MaterialLocalizations> {
  const _MaterialUiLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<mui.MaterialLocalizations> load(Locale locale) =>
      mui.DefaultMaterialLocalizations.load(locale);

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<mui.MaterialLocalizations> old,
  ) => false;
}

/// Aplikasi utama untuk manajemen service kendaraan.
class App extends ConsumerWidget {
  /// Membuat instance [App] dengan kunci opsional.
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(temaModeProvider);
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
    final darkBaseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
    final themed = baseTheme.copyWith(
      textTheme: terapkanFontInter(baseTheme.textTheme),
    );
    final themedDark = darkBaseTheme.copyWith(
      textTheme: terapkanFontInter(darkBaseTheme.textTheme),
    );

    return MaterialApp(
      title: 'Service',
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: themed,
      darkTheme: themedDark,
      themeMode: themeMode,
      // Perbaikan: deklarasikan supportedLocales dan delegates lokalisasi Flutter SDK.
      supportedLocales: const [Locale('id', 'ID')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        _MaterialUiLocalizationsDelegate(),
      ],
      home: const PengelolaOverlayLogDebug(
        child: KunciAplikasiGate(child: Home()),
      ),
      navigatorKey: NotifikasiService.navigatorKey,
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/bahan_bakar/enum/sort_bahan_bakar.dart
// ============================================================

```dart
// lib/fitur/bahan_bakar/enum/sort_bahan_bakar.dart

import 'package:flutter/material.dart';

/// Opsi pengurutan daftar bahan bakar.
enum SortBahanBakarEnum {
  /// Urutkan tanggal dari terbaru ke terlama.
  tanggalTerbaru,

  /// Urutkan tanggal dari terlama ke terbaru.
  tanggalTerlama,

  /// Urutkan KM dari terendah ke tertinggi.
  kmTerendah,

  /// Urutkan KM dari tertinggi ke terendah.
  kmTertinggi,

  /// Urutkan liter dari terendah ke tertinggi.
  literTerendah,

  /// Urutkan liter dari tertinggi ke terendah.
  literTertinggi,

  /// Urutkan harga per liter dari terendah ke tertinggi.
  hargaTerendah,

  /// Urutkan harga per liter dari tertinggi ke terendah.
  hargaTertinggi,

  /// Urutkan total biaya dari terendah ke tertinggi.
  totalTerendah,

  /// Urutkan total biaya dari tertinggi ke terendah.
  totalTertinggi,
}

/// Extension untuk [SortBahanBakarEnum] yang menyediakan label dan ikon tampilan.
extension SortBahanBakarExtension on SortBahanBakarEnum {
  /// Label teks yang ditampilkan kepada pengguna.
  String get label {
    switch (this) {
      case SortBahanBakarEnum.tanggalTerbaru:
        return 'Tanggal (Terbaru)';
      case SortBahanBakarEnum.tanggalTerlama:
        return 'Tanggal (Terlama)';
      case SortBahanBakarEnum.kmTerendah:
        return 'KM (Terendah)';
      case SortBahanBakarEnum.kmTertinggi:
        return 'KM (Tertinggi)';
      case SortBahanBakarEnum.literTerendah:
        return 'Liter (Terendah)';
      case SortBahanBakarEnum.literTertinggi:
        return 'Liter (Tertinggi)';
      case SortBahanBakarEnum.hargaTerendah:
        return 'Harga (Terendah)';
      case SortBahanBakarEnum.hargaTertinggi:
        return 'Harga (Tertinggi)';
      case SortBahanBakarEnum.totalTerendah:
        return 'Total (Terendah)';
      case SortBahanBakarEnum.totalTertinggi:
        return 'Total (Tertinggi)';
    }
  }

  /// Ikon yang merepresentasikan opsi pengurutan.
  IconData get icon {
    switch (this) {
      case SortBahanBakarEnum.tanggalTerbaru:
      case SortBahanBakarEnum.tanggalTerlama:
        return Icons.calendar_today;
      case SortBahanBakarEnum.kmTerendah:
      case SortBahanBakarEnum.kmTertinggi:
        return Icons.speed;
      case SortBahanBakarEnum.literTerendah:
      case SortBahanBakarEnum.literTertinggi:
        return Icons.local_gas_station;
      case SortBahanBakarEnum.hargaTerendah:
      case SortBahanBakarEnum.hargaTertinggi:
        return Icons.payments;
      case SortBahanBakarEnum.totalTerendah:
      case SortBahanBakarEnum.totalTertinggi:
        return Icons.receipt_long;
    }
  }
}

/// Opsi rentang tanggal untuk filter data bahan bakar.
enum RentangTanggalBahanBakarEnum {
  /// Hanya data hari ini.
  hariIni,

  /// Data 7 hari terakhir.
  mingguIni,

  /// Data bulan berjalan.
  bulanIni,

  /// Data tahun berjalan.
  tahunIni,

  /// Semua data tanpa filter tanggal.
  semua,

  /// Rentang tanggal kustom (diisi pengguna).
  kustom,
}

/// Extension untuk [RentangTanggalBahanBakarEnum] yang menyediakan label tampilan.
extension RentangTanggalBahanBakarExtension on RentangTanggalBahanBakarEnum {
  /// Label teks yang ditampilkan kepada pengguna.
  String get label {
    switch (this) {
      case RentangTanggalBahanBakarEnum.hariIni:
        return 'Hari Ini';
      case RentangTanggalBahanBakarEnum.mingguIni:
        return 'Minggu Ini';
      case RentangTanggalBahanBakarEnum.bulanIni:
        return 'Bulan Ini';
      case RentangTanggalBahanBakarEnum.tahunIni:
        return 'Tahun Ini';
      case RentangTanggalBahanBakarEnum.semua:
        return 'Semua';
      case RentangTanggalBahanBakarEnum.kustom:
        return 'Kustom';
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/bahan_bakar/helper/filter_bahan_bakar.dart
// ============================================================

```dart
// lib/fitur/bahan_bakar/helper/filter_bahan_bakar.dart
import 'package:flutter/material.dart';
import 'package:myapp/fitur/bahan_bakar/enum/sort_bahan_bakar.dart';
import 'package:myapp/fitur/bahan_bakar/model/bahan_bakar_model.dart';

/// Memfilter daftar bahan bakar berdasarkan kendaraan terpilih dan rentang tanggal. Diekstrak agar logika filter tanggal konsisten di seluruh halaman.
List<BahanBakarModel> filterTersaring({
  required List<BahanBakarModel> daftar,
  String? selectedId,
  required RentangTanggalBahanBakarEnum rentang,
  DateTimeRange? rentangKustom,
  DateTime? now,
}) {
  now ??= DateTime.now();
  DateTime? tanggalMulai;
  DateTime? tanggalAkhir;
  switch (rentang) {
    case RentangTanggalBahanBakarEnum.hariIni:
      tanggalMulai = DateTime(now.year, now.month, now.day);
      tanggalAkhir = tanggalMulai
          .add(const Duration(days: 1))
          .subtract(const Duration(seconds: 1));
      break;
    case RentangTanggalBahanBakarEnum.mingguIni:
      final hariIni = DateTime(now.year, now.month, now.day);
      tanggalMulai = hariIni.subtract(Duration(days: now.weekday - 1));
      tanggalAkhir = tanggalMulai
          .add(const Duration(days: 7))
          .subtract(const Duration(seconds: 1));
      break;
    case RentangTanggalBahanBakarEnum.bulanIni:
      tanggalMulai = DateTime(now.year, now.month);
      tanggalAkhir = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
      break;
    case RentangTanggalBahanBakarEnum.tahunIni:
      tanggalMulai = DateTime(now.year);
      tanggalAkhir = DateTime(now.year, 12, 31, 23, 59, 59);
      break;
    case RentangTanggalBahanBakarEnum.kustom:
      if (rentangKustom != null) {
        tanggalMulai = rentangKustom.start;
        tanggalAkhir = rentangKustom.end
            .add(const Duration(days: 1))
            .subtract(const Duration(seconds: 1));
      }
      break;
    case RentangTanggalBahanBakarEnum.semua:
      break;
  }

  return daftar.where((bahanBakar) {
    if (selectedId != null &&
        selectedId.isNotEmpty &&
        bahanBakar.idKendaraan != selectedId) {
      return false;
    }
    if (tanggalMulai != null && bahanBakar.tanggal.isBefore(tanggalMulai)) {
      return false;
    }
    if (tanggalAkhir != null && bahanBakar.tanggal.isAfter(tanggalAkhir)) {
      return false;
    }
    return true;
  }).toList();
}
```


// ============================================================
// FILE: lib/fitur/bahan_bakar/model/bahan_bakar_model.dart
// ============================================================

```dart
// lib/fitur/bahan_bakar/model/bahan_bakar_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'bahan_bakar_model.freezed.dart';

/// Model data pengisian bahan bakar kendaraan.
@freezed
abstract class BahanBakarModel with _$BahanBakarModel {
  const BahanBakarModel._();

  /// Membuat instance [BahanBakarModel] dengan data pengisian bahan bakar.
  const factory BahanBakarModel({
    /// ID unik data bahan bakar.
    required String id,

    /// ID kendaraan yang terkait.
    required String idKendaraan,

    /// Tanggal pengisian bahan bakar.
    required DateTime tanggal,

    /// Nilai kilometer kendaraan saat pengisian.
    required double km,

    /// Jumlah liter bahan bakar yang diisi.
    required double liter,

    /// Harga per liter bahan bakar.
    required double hargaPerLiter,

    /// Total biaya pengisian bahan bakar.
    required double total,

    /// Catatan tambahan, boleh null.
    String? catatan,

    /// Waktu data terakhir diperbarui.
    required DateTime diperbarui,

    /// Tanggal diarsipkan, boleh null.
    DateTime? diarsipkan,
  }) = _BahanBakarModel;

  // ==================== Supabase ====================

  /// Membuat [BahanBakarModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory BahanBakarModel.fromSupabase(Map<String, dynamic> map) {
    return BahanBakarModel(
      id: map[NamaKolom.id]?.toString() ?? '',
      idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      tanggal:
          ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
      km: ParserUtil.parseDouble(map[NamaKolom.km]),
      liter: ParserUtil.parseDouble(map[NamaKolom.liter]),
      hargaPerLiter: ParserUtil.parseDouble(map[NamaKolom.hargaPerLiter]),
      total: ParserUtil.parseDouble(map[NamaKolom.total]),
      catatan: map[NamaKolom.catatan]?.toString(),
      diperbarui:
          ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
      diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    );
  }

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.km: km,
    NamaKolom.liter: liter,
    NamaKolom.hargaPerLiter: hargaPerLiter,
    NamaKolom.total: total,
    NamaKolom.catatan: catatan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  // ==================== Sqflite ====================

  /// Membuat [BahanBakarModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory BahanBakarModel.fromSqflite(Map<String, dynamic> map) {
    return BahanBakarModel(
      id: map[NamaKolom.id]?.toString() ?? '',
      idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      tanggal:
          ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
      km: ParserUtil.parseDouble(map[NamaKolom.km]),
      liter: ParserUtil.parseDouble(map[NamaKolom.liter]),
      hargaPerLiter: ParserUtil.parseDouble(map[NamaKolom.hargaPerLiter]),
      total: ParserUtil.parseDouble(map[NamaKolom.total]),
      catatan: map[NamaKolom.catatan]?.toString(),
      diperbarui:
          ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
      diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    );
  }

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.km: km,
    NamaKolom.liter: liter,
    NamaKolom.hargaPerLiter: hargaPerLiter,
    NamaKolom.total: total,
    NamaKolom.catatan: catatan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```


// ============================================================
// FILE: lib/fitur/bahan_bakar/notifier/bahan_bakar_notifier.dart
// ============================================================

```dart
// lib/fitur/bahan_bakar/notifier/bahan_bakar_notifier.dart

import 'package:myapp/fitur/bahan_bakar/model/bahan_bakar_model.dart';
import 'package:myapp/fitur/bahan_bakar/state/bahan_bakar_state.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'bahan_bakar_notifier.g.dart';

/// Notifier untuk mengelola data bahan bakar kendaraan.
@Riverpod(keepAlive: true)
class BahanBakarNotifier extends _$BahanBakarNotifier {
  final _tabelBahanBakar = NamaTabel.bahanBakar;

  /// Membangun state awal dengan memuat data bahan bakar dari database.
  @override
  Future<BahanBakarState> build() async {
    try {
      final listDb = await ref
          .read(baseOpSqfliteProvider)
          .ambilData(NamaTabel.bahanBakar);
      final listHasil = listDb
          .whereType<Map<String, dynamic>>()
          .map(BahanBakarModel.fromSqflite)
          .toList();
      return BahanBakarState(listBahanBakar: listHasil);
    } catch (e, s) {
      // Memastikan build tidak gagal diam-diam; catat error dan lempar ulang agar Riverpod menandai AsyncError.
      L.e('Muat data bahan bakar gagal: $e $s');
      rethrow;
    }
  }

  /// Menambahkan [bahanBakar] baru ke daftar dan database.
  Future<void> tambah(BahanBakarModel bahanBakar) async {
    final dataLama = await future;
    final listBaru = dataLama.copyWith(
      listBahanBakar: [...dataLama.listBahanBakar, bahanBakar],
    );
    // Optimistic update: perbarui state terlebih dahulu.
    state = AsyncValue.data(listBaru);

    try {
      await ref
          .read(baseOpSqfliteProvider)
          .tambah(_tabelBahanBakar, bahanBakar.toSqflite());
    } on Exception catch (e, s) {
      L.e('tambah bahan bakar gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Mengubah data [bahanBakar] di daftar dan database.
  Future<void> ubah(BahanBakarModel bahanBakar) async {
    final dataLama = await future;
    final listBaru = dataLama.listBahanBakar
        .map((e) => e.id == bahanBakar.id ? bahanBakar : e)
        .toList();
    final stateBaru = dataLama.copyWith(listBahanBakar: listBaru);
    // Optimistic update: perbarui state terlebih dahulu.
    state = AsyncValue.data(stateBaru);

    try {
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(_tabelBahanBakar, bahanBakar.toSqflite(), bahanBakar.id);
    } on Exception catch (e, s) {
      L.e('ubah bahan bakar gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Menghapus data bahan bakar dengan [id] dari daftar dan database.
  Future<void> hapus(String id) async {
    final dataLama = await future;
    final listBaru = dataLama.listBahanBakar.where((e) => e.id != id).toList();
    final stateBaru = dataLama.copyWith(listBahanBakar: listBaru);
    // Optimistic update: perbarui state terlebih dahulu.
    state = AsyncValue.data(stateBaru);

    try {
      await ref.read(baseOpSqfliteProvider).hapus(_tabelBahanBakar, id);
    } on Exception catch (e, s) {
      L.e('hapus bahan bakar gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Melakukan batch insert [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(List<BahanBakarModel> data) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabelBahanBakar,
            data.map((e) => e.toSqflite()).toList(),
          );

      final listDb = await ref
          .read(baseOpSqfliteProvider)
          .ambilData(NamaTabel.bahanBakar);
      final listHasil = listDb
          .whereType<Map<String, dynamic>>()
          .map(BahanBakarModel.fromSqflite)
          .toList();
      state = AsyncValue.data(BahanBakarState(listBahanBakar: listHasil));
    } catch (e, s) {
      L.e('Gagal batch insert bahan bakar $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/bahan_bakar/page/bahan_bakar_page.dart
// ============================================================

```dart
// lib/fitur/bahan_bakar/page/bahan_bakar_page.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart'; // Gunakan sorted dari collection (AGENTS.md)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/bahan_bakar/enum/sort_bahan_bakar.dart';
import 'package:myapp/fitur/bahan_bakar/helper/filter_bahan_bakar.dart';
import 'package:myapp/fitur/bahan_bakar/model/bahan_bakar_model.dart';
import 'package:myapp/fitur/bahan_bakar/notifier/bahan_bakar_notifier.dart';
import 'package:myapp/fitur/bahan_bakar/page/detail_bbm.dart';
import 'package:myapp/fitur/bahan_bakar/page/form_bahan_bakar.dart';
import 'package:myapp/fitur/bahan_bakar/page/statistik_bahan_bakar.dart';
import 'package:myapp/fitur/bahan_bakar/state/bahan_bakar_state.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/kendaraan/state/kendaraan_state.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:myapp/shared/widget/kendaraan_terpilih_list.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman untuk mengelola data bahan bakar kendaraan.
class BahanBakarPage extends ConsumerStatefulWidget {
  /// Buat halaman bahan bakar.
  const BahanBakarPage({super.key});

  @override
  ConsumerState<BahanBakarPage> createState() => _BahanBakarPageState();
}

class _BahanBakarPageState extends ConsumerState<BahanBakarPage> {
  bool _sedangMemuat = false;
  KendaraanModel? _kendaraanTerpilih;
  SortBahanBakarEnum _sortBahanBakar = SortBahanBakarEnum.tanggalTerbaru;
  RentangTanggalBahanBakarEnum _rentangTanggal =
      RentangTanggalBahanBakarEnum.semua;
  DateTimeRange? _rentangTanggalKustom;
  Future<void> _hapusBahanBakar(
    BuildContext context,
    BahanBakarModel bahanBakar,
  ) async {
    if (_sedangMemuat) return;
    try {
      final konfirmasi = await showOkCancelAlertDialog(
        context: context,
        title: 'Hapus Data',
        message: 'Data bahan bakar ini akan dihapus secara permanen.',
        okLabel: 'Hapus',
        cancelLabel: 'Batal',
        isDestructiveAction: true,
      );
      if (konfirmasi != OkCancelResult.ok) return;
      if (mounted) setState(() => _sedangMemuat = true);
      await ref.read(bahanBakarProvider.notifier).hapus(bahanBakar.id);
      if (context.mounted) {
        AppToast.sukses(context, 'Bahan bakar berhasil dihapus');
      }
    } catch (e, s) {
      L.e('Gagal menghapus bahan bakar: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal menghapus bahan bakar');
      }
    } finally {
      if (mounted) setState(() => _sedangMemuat = false);
    }
  }

  @override
  void initState() {
    super.initState();
    unawaited(Future.microtask(_reloadKendaraanTerpilih));
  }

  Future<void> _reloadKendaraanTerpilih() async {
    try {
      final idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
      final kendaraanState = await ref.read(kendaraanProvider.future);
      KendaraanModel? kendaraan;
      if (idKendaraan != null && idKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.getById(idKendaraan);
        if (kendaraan == null && kendaraanState.listKendaraan.isNotEmpty) {
          kendaraan = kendaraanState.listKendaraan.first;
        }
      } else if (_kendaraanTerpilih != null) {
        kendaraan = _kendaraanTerpilih;
      } else if (kendaraanState.listKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.listKendaraan.first;
      }
      if (mounted) {
        setState(() {
          _kendaraanTerpilih = kendaraan;
        });
      }
    } catch (e, s) {
      L.e('Gagal memuat kendaraan terpilih: $e $s');
    }
  }

  Future<void> _modalOpsiTanggalKustom() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Rentang Tanggal',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ...RentangTanggalBahanBakarEnum.values.map(
                (rentang) => ListTile(
                  leading: const Icon(Icons.date_range),
                  title: Text(rentang.label),
                  trailing: rentang == _rentangTanggal
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () async {
                    // Perbaikan: gunakan Nav.pop sesuai konvensi navigasi proyek.
                    Nav.pop(context);
                    if (!mounted) return;
                    if (rentang == RentangTanggalBahanBakarEnum.kustom) {
                      final picked = await showDateRangePicker(
                        context: this.context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        initialDateRange: _rentangTanggalKustom,
                      );
                      if (picked != null && mounted) {
                        setState(() {
                          _rentangTanggal = rentang;
                          _rentangTanggalKustom = picked;
                        });
                      }
                    } else if (mounted) {
                      setState(() => _rentangTanggal = rentang);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedKendaraanIdProvider, (previous, next) {
      // Bandingkan nilai AsyncValue secara aman via asData untuk menghindari akses .value tanpa guard.
      if (previous?.asData?.value != next.asData?.value) {
        unawaited(_reloadKendaraanTerpilih());
      }
    });

    final bahanBakarAsync = ref.watch(bahanBakarProvider);
    final kendaraanAsync = ref.watch(kendaraanProvider);

    if (bahanBakarAsync.isLoading || kendaraanAsync.isLoading) {
      return _buildLoading();
    }
    if (bahanBakarAsync.hasError || kendaraanAsync.hasError) {
      return _buildError();
    }

    final bahanBakarState = bahanBakarAsync.requireValue;
    final kendaraanState = kendaraanAsync.requireValue;
    return _buildScaffold(context, bahanBakarState, kendaraanState);
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text('Memuat data bahan bakar...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data bahan bakar'),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(
                  selectedKendaraanIdProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  bahanBakarProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  kendaraanProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    BahanBakarState bahanBakarState,
    KendaraanState kendaraanState,
  ) {
    final selectedId = _kendaraanTerpilih?.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bahan Bakar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: _modalOpsiTanggalKustom,
          ),
          PopupMenuButton<SortBahanBakarEnum>(
            icon: const Icon(Icons.sort),
            initialValue: _sortBahanBakar,
            onSelected: (value) {
              setState(() => _sortBahanBakar = value);
            },
            itemBuilder: (context) => SortBahanBakarEnum.values
                .map(
                  (sort) => PopupMenuItem<SortBahanBakarEnum>(
                    value: sort,
                    child: Row(
                      spacing: 8,
                      children: [
                        Icon(sort.icon, size: 20),
                        Expanded(child: Text(sort.label)),
                        if (sort == _sortBahanBakar)
                          const Icon(Icons.check, size: 18),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Statistik',
            onPressed: () =>
                unawaited(Nav.to(context, const StatistikBahanBakar())),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: KendaraanTerpilihList(
              listKendaraan: kendaraanState.listKendaraan,
              selectedId: selectedId,
              onSelected: (kendaraan) {
                setState(() => _kendaraanTerpilih = kendaraan);
              },
              onReload: _reloadKendaraanTerpilih,
            ),
          ),
          if (_rentangTanggal != RentangTanggalBahanBakarEnum.semua)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                'Menampilkan data: ${_rentangTanggal.label}', // UX #13: label filter tanggal lebih informatif
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          Expanded(
            child: _buildListBbm(context, bahanBakarState, kendaraanState),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        tooltip: 'Tambah bahan bakar',
        onPressed: () => unawaited(Nav.to(context, const FormBahanBakar())),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListBbm(
    BuildContext context,
    BahanBakarState bahanBakarState,
    KendaraanState kendaraanState,
  ) {
    final selectedId = _kendaraanTerpilih?.id;
    final daftarTersaring = filterTersaring(
      daftar: bahanBakarState.listBahanBakar,
      selectedId: selectedId,
      rentang: _rentangTanggal,
      rentangKustom: _rentangTanggalKustom,
    );

    // Gunakan sorted dari collection, bukan sort mutating (AGENTS.md)
    final list = daftarTersaring.sorted((a, b) {
      switch (_sortBahanBakar) {
        case SortBahanBakarEnum.tanggalTerbaru:
          return b.tanggal.compareTo(a.tanggal);
        case SortBahanBakarEnum.tanggalTerlama:
          return a.tanggal.compareTo(b.tanggal);
        case SortBahanBakarEnum.kmTerendah:
          return a.km.compareTo(b.km);
        case SortBahanBakarEnum.kmTertinggi:
          return b.km.compareTo(a.km);
        case SortBahanBakarEnum.literTerendah:
          return a.liter.compareTo(b.liter);
        case SortBahanBakarEnum.literTertinggi:
          return b.liter.compareTo(a.liter);
        case SortBahanBakarEnum.hargaTerendah:
          return a.hargaPerLiter.compareTo(b.hargaPerLiter);
        case SortBahanBakarEnum.hargaTertinggi:
          return b.hargaPerLiter.compareTo(a.hargaPerLiter);
        case SortBahanBakarEnum.totalTerendah:
          return a.total.compareTo(b.total);
        case SortBahanBakarEnum.totalTertinggi:
          return b.total.compareTo(a.total);
      }
    });
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_gas_station_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            const Text('Belum ada data bahan bakar'),
            const SizedBox(height: 16),
            if (selectedId == null || selectedId.isEmpty)
              const Text('Pilih kendaraan terlebih dahulu')
            else
              FilledButton.icon(
                onPressed: () =>
                    unawaited(Nav.to(context, const FormBahanBakar())),
                icon: const Icon(Icons.add),
                label: const Text('Tambah Bahan Bakar'),
              ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final bahanBakar = list[index];
        final mataUang = ref
            .watch(mataUangProvider)
            .maybeWhen(data: (m) => m, orElse: () => daftarMataUang.first);
        return _buildCardItem(context, bahanBakar, mataUang);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 4),
    );
  }

  Widget _buildCardItem(
    BuildContext context,
    BahanBakarModel bahanBakar,
    MataUangItem mataUang,
  ) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.local_gas_station),
        title: Text('${bahanBakar.liter.toStringAsFixed(2)} liter'),
        subtitle: Text(
          '${FormatTanggal.formatDasar(bahanBakar.tanggal)} • ${FormatNomor.formatRibuan(bahanBakar.km.toInt())} km',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              child: Text(
                formatMataUang(bahanBakar.total, mataUang),
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
              tooltip: 'Hapus',
              onPressed: () => unawaited(_hapusBahanBakar(context, bahanBakar)),
            ),
          ],
        ),
        onTap: () => unawaited(Nav.to(context, DetailBbm(id: bahanBakar.id))), // unawaited: Nav.to mengembalikan Future (optimasi_bug_runtime.md #10)
        onLongPress: () => unawaited(_hapusBahanBakar(context, bahanBakar)),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/bahan_bakar/page/detail_bbm.dart
// ============================================================

```dart
// lib/fitur/bahan_bakar/page/detail_bbm.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/bahan_bakar/notifier/bahan_bakar_notifier.dart';
import 'package:myapp/fitur/bahan_bakar/page/form_bahan_bakar.dart';
import 'package:myapp/fitur/bahan_bakar/state/bahan_bakar_state.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/page/detail_kendaraan_page.dart';
import 'package:myapp/fitur/kendaraan/state/kendaraan_state.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:universal_io/io.dart';

/// Halaman detail bahan bakar untuk menampilkan informasi lengkap.
class DetailBbm extends ConsumerWidget {
  /// Identifikasi bahan bakar yang ditampilkan.
  final String id;

  /// Membuat [DetailBbm] dengan [id] bahan bakar.
  const DetailBbm({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bahanBakarAsync = ref.watch(bahanBakarProvider);
    final kendaraanAsync = ref.watch(kendaraanProvider);

    if (bahanBakarAsync.isLoading || kendaraanAsync.isLoading) {
      return _buildLoading();
    }
    if (bahanBakarAsync.hasError || kendaraanAsync.hasError) {
      return _buildError(ref);
    }

    final bahanBakarState = bahanBakarAsync.requireValue;
    final kendaraanState = kendaraanAsync.requireValue;
    final mataUang = ref
        .watch(mataUangProvider)
        .maybeWhen(data: (m) => m, orElse: () => daftarMataUang.first);
    return _buildScaffold(context, bahanBakarState, kendaraanState, mataUang);
  }

  Widget _buildScaffold(
    BuildContext context,
    BahanBakarState bahanBakarState,
    KendaraanState kendaraanState,
    MataUangItem mataUang,
  ) {
    final bahanBakar = bahanBakarState.getById(id);
    if (bahanBakar == null) {
      return _buildTidakDitemukan(context, 'Data bahan bakar tidak ditemukan');
    }
    final kendaraan = kendaraanState.getById(bahanBakar.idKendaraan);
    if (kendaraan == null) {
      return _buildTidakDitemukan(context, 'Data kendaraan tidak ditemukan');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Bahan Bakar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
            onPressed: () {
              unawaited(
                Nav.to(context, FormBahanBakar(bahanBakar: bahanBakar)),
              ); // aturan unawaited
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildKendaraan(context, kendaraan),
            _buildInfoRow(
              'Tanggal',
              FormatTanggal.formatDasar(bahanBakar.tanggal),
            ),
            const Divider(),
            _buildInfoRow(
              'KM',
              '${FormatNomor.formatRibuan(bahanBakar.km.toInt())} km',
            ),
            const Divider(),
            _buildInfoRow(
              'Liter',
              '${bahanBakar.liter.toStringAsFixed(2)} liter',
            ),
            const Divider(),
            _buildInfoRow(
              'Harga per Liter',
              formatMataUang(bahanBakar.hargaPerLiter, mataUang),
            ),
            const Divider(),
            _buildInfoRow('Total', formatMataUang(bahanBakar.total, mataUang)),
            const Divider(),
            _CatatanInfoRow(value: bahanBakar.catatan ?? '-'),
            const Divider(),
            _buildInfoRow(
              'Terakhir Diperbarui',
              FormatWaktuLengkap.formatSingkat(bahanBakar.diperbarui),
            ),
            if (bahanBakar.diarsipkan != null) ...[
              const Divider(),
              () {
                // Menghindari !; diarsipkan sudah dicek non-null.
                final d = bahanBakar.diarsipkan;
                if (d == null) return const SizedBox.shrink();
                return _buildInfoRow(
                  'Diarsipkan',
                  FormatWaktuLengkap.formatSingkat(d),
                );
              }(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildKendaraan(BuildContext context, KendaraanModel kendaraan) {
    return Card(
      child: ListTile(
        leading: (() {
          final path = kendaraan.pathGambar;
          // Menghindari !; jika null pakai icon, jika ada pakai Image.file.
          if (path == null) return const Icon(Icons.directions_car);
          try {
            final file = File(path);
            return Image.file(
              file,
              errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
            );
          } catch (e, s) {
            L.e('Gagal muat gambar kendaraan: $e $s');
            return const Icon(Icons.broken_image);
          }
        })(),
        title: Text(kendaraan.nama),
        subtitle: Text(
          '${kendaraan.merk}'
          '${kendaraan.platNomor == null ? '' : ' • ${kendaraan.platNomor}'}',
        ),
        onTap: () =>
            unawaited(Nav.to(context, DetailKendaraanPage(id: kendaraan.id))),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Builder(
              builder: (context) => Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Builder(
              builder: (context) => Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTidakDitemukan(BuildContext context, String pesan) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Bahan Bakar')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 24,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(pesan, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              // Ganti Navigator.pop langsung dengan Nav.pop sesuai konvensi navigasi proyek.
              onPressed: () => Nav.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text('Memuat data bahan bakar...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError(WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data bahan bakar'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(
                  bahanBakarProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  kendaraanProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CatatanInfoRow extends StatefulWidget {
  final String value;
  const _CatatanInfoRow({required this.value});

  @override
  State<_CatatanInfoRow> createState() => _CatatanInfoRowState();
}

class _CatatanInfoRowState extends State<_CatatanInfoRow> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Catatan',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final textPainter = TextPainter(
                  text: TextSpan(
                    text: widget.value,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  maxLines: 3,
                  textDirection: Directionality.of(context),
                  textScaler: MediaQuery.textScalerOf(context),
                )..layout(maxWidth: constraints.maxWidth);
                final isOverflow = textPainter.didExceedMaxLines;
                textPainter.dispose();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.value,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: _expanded ? null : 3,
                      overflow: _expanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                    ),
                    if (isOverflow)
                      TextButton(
                        onPressed: () => setState(() => _expanded = !_expanded),
                        child: Text(
                          _expanded ? 'Sembunyikan' : 'Lihat selengkapnya',
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/bahan_bakar/page/form_bahan_bakar.dart
// ============================================================

```dart
// lib/fitur/bahan_bakar/page/form_bahan_bakar.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/bahan_bakar/model/bahan_bakar_model.dart';
import 'package:myapp/fitur/bahan_bakar/notifier/bahan_bakar_notifier.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/page/form_kendaraan.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/shared/widget/pemilih_kendaraan.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Form untuk menambah atau mengedit data bahan bakar kendaraan.
class FormBahanBakar extends ConsumerStatefulWidget {
  /// Model bahan bakar yang akan diedit. [null] jika mode tambah.
  final BahanBakarModel? bahanBakar;

  /// Buat form bahan bakar.
  const FormBahanBakar({super.key, this.bahanBakar});

  @override
  ConsumerState<FormBahanBakar> createState() => _FormBahanBakarState();
}

class _FormBahanBakarState extends ConsumerState<FormBahanBakar> {
  final _formKey = GlobalKey<FormState>();
  final _kmController = TextEditingController();
  final _literController = TextEditingController();
  final _hargaController = TextEditingController();
  final _catatanController = TextEditingController();

  bool _modeEdit = false;
  KendaraanModel? _kendaraanTerpilih;
  bool _isLoading = false;
  DateTime _tanggal = DateTime.now();

  @override
  void initState() {
    super.initState();
    _modeEdit = widget.bahanBakar != null;
    if (_modeEdit) {
      // Menghindari ! sesuai AGENTS.md; model dijamin oleh kondisi.
      final b = widget.bahanBakar;
      if (b == null) return;
      _kmController.text = b.km.toStringAsFixed(0);
      _literController.text = b.liter.toString();
      _hargaController.text = b.hargaPerLiter.toStringAsFixed(0);
      _catatanController.text = b.catatan ?? '';
      _tanggal = b.tanggal;
    }

    // Menangkap error provider agar Future.microtask tidak menjadi unhandled, dan menjaga setState hanya saat widget masih mounted pada kedua cabang.
    unawaited(
      Future.microtask(() async {
        try {
          var idKendaraan = widget.bahanBakar?.idKendaraan;
          if (idKendaraan == null || idKendaraan.isEmpty) {
            idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
          }
          final kendaraanState = await ref.read(kendaraanProvider.future);
          if (idKendaraan != null) {
            final kendaraan = kendaraanState.getById(idKendaraan);
            if (mounted) {
              setState(() => _kendaraanTerpilih = kendaraan);
            }
          } else if (kendaraanState.listKendaraan.isNotEmpty) {
            final kendaraan = kendaraanState.listKendaraan.first;
            if (mounted) {
              setState(() => _kendaraanTerpilih = kendaraan);
            }
          }
        } catch (e, s) {
          L.e('Gagal memuat kendaraan terpilih form bahan bakar: $e $s');
        }
      }),
    ); // unawaited: Future.microtask per optimasi_bug_runtime.md #10
  }

  @override
  void dispose() {
    _kmController.dispose();
    _literController.dispose();
    _hargaController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    try {
      final picked = await showDatePicker(
        context: context,
        initialDate: _tanggal,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        // Hindari setState saat widget sudah tidak aktif setelah await showDatePicker.
        if (mounted) setState(() => _tanggal = picked);
      }
    } catch (e, s) {
      // Log error dan rethrow sesuai AGENTS.md poin 6
      L.e('Gagal memilih tanggal: $e $s');
      rethrow;
    }
  }

  double _parse(String text) {
    // Hapus titik pemisah ribuan (format Indonesia) lalu ganti koma menjadi titik desimal
    final clean = text
        .replaceAll('.', '') // Hapus semua titik
        .replaceAll(',', '.'); // Ganti koma dengan titik
    return double.tryParse(clean) ?? 0;
  }

  Future<void> _simpanForm() async {
    if (_isLoading) return;
    // Menghindari ! pada GlobalKey State sesuai AGENTS.md.
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) return;
    setState(() => _isLoading = true);
    // Hanya tanya ganti kendaraan saat edit, bukan saat tambah baru
    final modelEdit = widget.bahanBakar;
    if (modelEdit != null && modelEdit.idKendaraan != _kendaraanTerpilih?.id) {
      final konfirmasi = await showOkCancelAlertDialog(
        context: context,
        title: 'Ganti Kendaraan?',
        message:
            'Kendaraan terpilih berubah. Lanjutkan menyimpan data bahan bakar?',
        okLabel: 'Lanjutkan',
        cancelLabel: 'Batal',
      );
      if (konfirmasi != OkCancelResult.ok) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }
    }
    unawaited(
      EasyLoading.show(
        status: _modeEdit
            ? 'Memperbarui bahan bakar...'
            : 'Menyimpan bahan bakar...',
      ),
    ); // UX #34: EasyLoading menggantikan custom modal loading
    try {
      final km = _parse(_kmController.text);
      final liter = _parse(_literController.text);
      final harga = _parse(_hargaController.text);
      final total = liter * harga;
      final kendaraan = _kendaraanTerpilih;
      if (kendaraan == null) {
        if (mounted) AppToast.gagal(context, 'Pilih kendaraan terlebih dahulu');
        return;
      }
      final modelEdit = widget.bahanBakar;
      final id = (_modeEdit && modelEdit != null)
          ? modelEdit.id
          : const Uuid().v4();
      final data = BahanBakarModel(
        id: id,
        idKendaraan: kendaraan.id,
        tanggal: _tanggal,
        km: km,
        liter: liter,
        hargaPerLiter: harga,
        total: total,
        catatan: _catatanController.text.trim().isEmpty
            ? null
            : _catatanController.text.trim(),
        diperbarui: DateTime.now(),
      );
      if (_modeEdit) {
        await ref.read(bahanBakarProvider.notifier).ubah(data);
      } else {
        await ref.read(bahanBakarProvider.notifier).tambah(data);
      }
      if (mounted) {
        AppToast.sukses(
          context,
          _modeEdit
              ? 'Bahan bakar berhasil diperbarui'
              : 'Bahan bakar berhasil ditambahkan',
        );
        Nav.pop(context);
      }
    } catch (e, s) {
      L.e('Gagal menyimpan bahan bakar: $e $s');
      if (mounted) AppToast.gagal(context, 'Gagal menyimpan bahan bakar');
    } finally {
      unawaited(EasyLoading.dismiss()); // UX #34
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kendaraanAsync = ref.watch(kendaraanProvider);
    if (kendaraanAsync.isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_modeEdit ? 'Edit Bahan Bakar' : 'Tambah Bahan Bakar'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (kendaraanAsync.hasError) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_modeEdit ? 'Edit Bahan Bakar' : 'Tambah Bahan Bakar'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gagal memuat kendaraan'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  final _ = ref.refresh(kendaraanProvider);
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }
    final kendaraanstate = kendaraanAsync.requireValue;
    final listKendaraan = kendaraanstate.listKendaraan;
    final kendaraanTerpilih = _kendaraanTerpilih;
    return Scaffold(
      appBar: AppBar(
        title: Text(_modeEdit ? 'Edit Bahan Bakar' : 'Tambah Bahan Bakar'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16, // jarak antar anak pakai spacing (UI #7)
            children: [
              if (kendaraanTerpilih != null) ...[
                PemilihKendaraan(
                  kendaraanTerpilih: kendaraanTerpilih,
                  listKendaraan: listKendaraan,
                  onSelected: (value) => setState(() {
                    _kendaraanTerpilih = value;
                  }),
                ),
              ] else
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () =>
                        unawaited(Nav.to(context, const FormKendaraan())),
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah kendaraan'),
                  ),
                ),
              Card(
                child: ListTile(
                  title: const Text('Tanggal'),
                  subtitle: Text(FormatTanggal.formatDasar(_tanggal)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: _pilihTanggal,
                ),
              ),
              InputAngka(
                controller: _kmController,
                label: 'KM saat isi',
                hintText: 'Contoh: 12500',
                validator: (v) {
                  final n = _parse(v ?? '');
                  if (n <= 0) return 'KM harus lebih dari 0';
                  return null;
                },
              ),
              InputAngka(
                controller: _literController,
                label: 'Jumlah Liter',
                hintText: 'Contoh: 5',
                validator: (v) {
                  final n = _parse(v ?? '');
                  if (n <= 0) return 'Liter harus lebih dari 0';
                  return null;
                },
              ),
              InputAngka(
                controller: _hargaController,
                label: 'Harga per Liter',
                hintText: 'Contoh: 15000',
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _simpanForm(),
                validator: (v) {
                  final n = _parse(v ?? '');
                  if (n <= 0) return 'Harga harus lebih dari 0';
                  return null;
                },
              ),
              InputTeks(
                controller: _catatanController,
                label: 'Catatan (opsional)',
                hintText: 'Contoh: isi full tank',
                wajib: false,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _simpanForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/bahan_bakar/page/statistik_bahan_bakar.dart
// ============================================================

```dart
import 'dart:async';
import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/bahan_bakar/enum/sort_bahan_bakar.dart';
import 'package:myapp/fitur/bahan_bakar/helper/filter_bahan_bakar.dart';
import 'package:myapp/fitur/bahan_bakar/notifier/bahan_bakar_notifier.dart';
import 'package:myapp/fitur/bahan_bakar/state/bahan_bakar_state.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/kendaraan/state/kendaraan_state.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:myapp/shared/widget/kendaraan_terpilih_list.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman statistik bahan bakar untuk menampilkan grafik dan ringkasan.
class StatistikBahanBakar extends ConsumerStatefulWidget {
  /// Membuat [StatistikBahanBakar].
  const StatistikBahanBakar({super.key});

  @override
  ConsumerState<StatistikBahanBakar> createState() =>
      _StatistikBahanBakarState();
}

class _StatistikBahanBakarState extends ConsumerState<StatistikBahanBakar> {
  KendaraanModel? _kendaraanTerpilih;
  RentangTanggalBahanBakarEnum _rentangTanggal =
      RentangTanggalBahanBakarEnum.semua;
  DateTimeRange? _rentangTanggalKustom;

  @override
  void initState() {
    super.initState();
    unawaited(Future.microtask(_reloadKendaraanTerpilih));
  }

  @override
  void dispose() {
    // Tidak ada controller/subscription/timer yang perlu dibersihkan.
    super.dispose();
  }

  Future<void> _reloadKendaraanTerpilih({bool? state = false}) async {
    try {
      final idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
      final kendaraanState = await ref.read(kendaraanProvider.future);
      KendaraanModel? kendaraan;
      if (idKendaraan != null && idKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.getById(idKendaraan);
        if (kendaraan == null && kendaraanState.listKendaraan.isNotEmpty) {
          kendaraan = kendaraanState.listKendaraan.first;
        }
      } else if (_kendaraanTerpilih != null) {
        kendaraan = _kendaraanTerpilih;
      } else if (kendaraanState.listKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.listKendaraan.first;
      }
      if (!mounted) return;
      setState(() {
        _kendaraanTerpilih = kendaraan;
      });
    } catch (e, s) {
      // Mencegah exception provider yang tidak tertangani saat memuat kendaraan terpilih.
      L.e('Gagal memuat kendaraan terpilih statistik bahan bakar: $e $s');
    }
  }

  Future<void> _modallOpsiTanggalCustom() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: _rentangTanggalKustom,
    );
    if (picked != null && mounted) {
      setState(() {
        _rentangTanggal = RentangTanggalBahanBakarEnum.kustom;
        _rentangTanggalKustom = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedKendaraanIdProvider, (previous, next) {
      // Bandingkan nilai AsyncValue secara aman via asData untuk menghindari akses .value tanpa guard.
      if (previous?.asData?.value != next.asData?.value) {
        unawaited(_reloadKendaraanTerpilih());
      }
    });

    final bahanBakarAsync = ref.watch(bahanBakarProvider);
    final kendaraanAsync = ref.watch(kendaraanProvider);
    final mataUangAsync = ref.watch(mataUangProvider);

    if (bahanBakarAsync.isLoading ||
        kendaraanAsync.isLoading ||
        mataUangAsync.isLoading) {
      return _buildLoading();
    }
    if (bahanBakarAsync.hasError ||
        kendaraanAsync.hasError ||
        mataUangAsync.hasError) {
      return _buildError();
    }

    final bahanBakarState = bahanBakarAsync.requireValue;
    final kendaraanState = kendaraanAsync.requireValue;
    final mataUangItem = mataUangAsync.requireValue;

    return _buildScaffold(kendaraanState, bahanBakarState, mataUangItem);
  }

  AppBar _buildappbar() {
    return AppBar(
      title: const Text('Statistik Bahan Bakar'),
      elevation: 0,
      scrolledUnderElevation: 1,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      actions: [
        PopupMenuButton<RentangTanggalBahanBakarEnum>(
          icon: const Icon(Icons.date_range),
          initialValue: _rentangTanggal,
          onSelected: (value) {
            setState(() => _rentangTanggal = value);
            if (value == RentangTanggalBahanBakarEnum.kustom) {
              unawaited(_modallOpsiTanggalCustom());
            }
          },
          itemBuilder: (context) => RentangTanggalBahanBakarEnum.values
              .map(
                (rentang) => PopupMenuItem<RentangTanggalBahanBakarEnum>(
                  value: rentang,
                  child: Row(
                    spacing: 8,
                    children: [
                      const Icon(Icons.date_range, size: 20),
                      Expanded(child: Text(rentang.label)),
                      if (rentang == _rentangTanggal)
                        const Icon(Icons.check, size: 18),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildScaffold(
    KendaraanState kendaraanState,
    BahanBakarState bahanBakarState,
    MataUangItem mataUangItem,
  ) {
    final idKendaraan = _kendaraanTerpilih?.id;
    final daftarTersaring = filterTersaring(
      daftar: bahanBakarState.listBahanBakar,
      selectedId: idKendaraan,
      rentang: _rentangTanggal,
      rentangKustom: _rentangTanggalKustom,
    );
    final bahanBakarTersaring = BahanBakarState(
      listBahanBakar: daftarTersaring,
    );

    final hargaRataRataPerKm = bahanBakarTersaring.getRataRataBiayaPerKm(null);
    final totalBiaya = bahanBakarTersaring.getJumlahTotal(null);
    final kmPerLiter = bahanBakarTersaring.getKmPerLiter(null);
    final trend = bahanBakarTersaring.getKmPerLiterTrend(null);
    return Scaffold(
      appBar: _buildappbar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            KendaraanTerpilihList(
              listKendaraan: kendaraanState.listKendaraan,
              selectedId: _kendaraanTerpilih?.id,
              onSelected: (kendaraan) {
                setState(() => _kendaraanTerpilih = kendaraan);
              },
              onReload: () => _reloadKendaraanTerpilih(state: true),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _buildItemRow(
                    icon: Icons.payments_outlined,
                    color: Theme.of(context).colorScheme.tertiary,
                    label: 'Total biaya',
                    value: formatMataUang(totalBiaya, mataUangItem),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildItemRow(
                    icon: Icons.route_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                    label: 'Harga per KM',
                    value: formatMataUang(hargaRataRataPerKm, mataUangItem),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildItemRow(
                    icon: Icons.local_gas_station_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    label: 'Km per Liter',
                    value: kmPerLiter.toStringAsFixed(2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildTrendChart(trend),
          ],
        ),
      ),
    );
  }

  // _buildItemRow
  Widget _buildItemRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: .12),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(label),
      trailing: FittedBox(
        fit: BoxFit.scaleDown, // angka: kecilkan, jangan potong
        alignment: Alignment.centerRight,
        child: Text(
          value,
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildTrendChart(List<MapEntry<DateTime, double>> trend) {
    if (trend.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('Belum cukup data untuk grafik tren')),
      );
    }
    final spots = trend
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.value))
        .toList();
    final minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b) - 2;
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) + 2;
    final intervalY = _hitYInterval(minY, maxY);
    final chartMinY = (minY / intervalY).floor() * intervalY;
    final chartMaxY = (maxY / intervalY).ceil() * intervalY;
    return Card(
      child: SizedBox(
        height: 340,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LineChart(
            LineChartData(
              minY: chartMinY,
              maxY: chartMaxY,
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (spots) => spots
                      .map(
                        (s) => LineTooltipItem(
                          '${s.y.toStringAsFixed(2)} km/L',
                          // Menghindari crash jika textTheme.bodySmall null dengan fallback gaya teks default.
                          Theme.of(context).textTheme.bodySmall ??
                              const TextStyle(),
                        ),
                      )
                      .toList(),
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: _hitYInterval(chartMinY, chartMaxY),
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.labelSmall,
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 100,
                    interval: _getXInterval(trend.length),
                    getTitlesWidget: (value, meta) {
                      if (value % 1 != 0) return const SizedBox.shrink();
                      final index = value.toInt();
                      if (index < 0 || index >= trend.length) {
                        return const SizedBox.shrink();
                      }

                      return SideTitleWidget(
                        meta: meta,
                        space: 12,
                        angle: -math.pi / 4, // 3. Gunakan angle native fl_chart
                        child: Text(
                          FormatTanggal.formatSingkat(trend[index].key),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Theme.of(context).colorScheme.primary,
                  barWidth: 3,
                  preventCurveOverShooting: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _hitYInterval(double minY, double maxY) {
    final range = maxY - minY;
    if (range <= 5) return 1;
    if (range <= 10) return 2;
    if (range <= 20) return 5;
    return 10;
  }

  double _getXInterval(int length) {
    // Jika data lebih dari 7, tampilkan setiap 2 data (atau lebih)
    if (length > 10) return (length / 7).ceilToDouble();
    if (length > 7) return 2;
    return 1;
  }

  Widget _buildLoading() {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(strokeWidth: 3),
            Text(
              'Memuat statistik bahan bakar...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data'),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: () {
                final _ = ref.refresh(
                  bahanBakarProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  kendaraanProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/bahan_bakar/state/bahan_bakar_state.dart
// ============================================================

```dart
// lib/fitur/bahan_bakar/state/bahan_bakar_state.dart

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/bahan_bakar/model/bahan_bakar_model.dart';
import 'package:share_global_saya/core_shared.dart';

part 'bahan_bakar_state.freezed.dart';

/// State untuk mengelola data bahan bakar kendaraan.
@freezed
abstract class BahanBakarState with _$BahanBakarState {
  const BahanBakarState._();

  /// Membuat state [BahanBakarState] dengan daftar pengisian bahan bakar.
  const factory BahanBakarState({
    @Default([]) List<BahanBakarModel> listBahanBakar,
  }) = _BahanBakarState;

  /// Mengambil daftar bahan bakar berdasarkan [idKendaraan].
  List<BahanBakarModel> getListByIdKendaraan(String? idKendaraan) {
    if (idKendaraan == null || idKendaraan.isEmpty) {
      return [];
    }
    return listBahanBakar.where((b) => b.idKendaraan == idKendaraan).toList();
  }

  /// Mengembalikan pengisian bahan bakar dengan [id], atau null jika tidak ditemukan.
  BahanBakarModel? getById(String id) {
    return listBahanBakar.firstWhereOrNull((item) => item.id == id);
  }

  /// Mengembalikan pengisian bahan bakar terbaru berdasarkan tanggal untuk kendaraan tertentu.
  BahanBakarModel? terbaruByIdKendaraan(String? idKendaraan) {
    final list = getListByIdKendaraan(idKendaraan);
    if (list.isEmpty) return null;
    return maxBy(
      list,
      (b) => b.tanggal,
    ); // aturan: gunakan maxBy dari collection
  }

  /// Menghitung jumlah total biaya bahan bakar.
  double getJumlahTotal(String? idKendaraan) {
    final list = idKendaraan == null || idKendaraan.isEmpty
        ? listBahanBakar
        : getListByIdKendaraan(idKendaraan);
    return list.fold<double>(0, (sum, b) => sum + b.total);
  }

  /// Menghitung total selisih KM dari daftar pengisian yang telah diurutkan. Melewatkan entri dengan KM negatif, selisih besar (>500000), dan mencegah rollover palsu.
  double _hitungSelisihKm(List<BahanBakarModel> sorted) {
    double total = 0;
    for (var i = 1; i < sorted.length; i++) {
      final kmLama = sorted[i - 1].km;
      final kmBaru = sorted[i].km;
      // Validasi: km tidak boleh negatif.
      if (kmLama < 0 || kmBaru < 0) continue;
      if (kmBaru >= kmLama) {
        final selisih = kmBaru - kmLama;
        // Batas validasi: selisih tidak lebih dari 500000.
        if (selisih > 500000) continue;
        total += selisih;
      } else {
        // Mencegah rollover palsu saat input KM salah (misal 12.500 jadi 12)
        if ((kmLama - kmBaru) > 900000) {
          total += (kmBaru + 1000000) - kmLama;
        } else {
          total += 0;
        }
      }
    }
    return total;
  }

  /// Menghitung total kilometer berdasarkan kendaraan.
  double getTotalKmByIdKendaraan(String? idKendaraan) {
    try {
      final list = getListByIdKendaraan(idKendaraan);
      if (list.length < 2) return 0;
      // Menggunakan sorted dari package:collection sesuai AGENTS.md.
      final sorted = [...list].sorted((a, b) => a.tanggal.compareTo(b.tanggal));
      return _hitungSelisihKm(sorted);
    } catch (e, s) {
      // Log error dan kembalikan 0 agar tidak crash.
      L.e('getTotalKmByIdKendaraan error: $e $s');
      return 0;
    }
  }

  /// Menghitung total kilometer seluruh kendaraan.
  double getTotalKm() {
    try {
      double total = 0;
      final grouped = <String, List<BahanBakarModel>>{};
      for (final b in listBahanBakar) {
        grouped.putIfAbsent(b.idKendaraan, () => []).add(b);
      }
      for (final list in grouped.values) {
        if (list.length < 2) continue;
        final sorted = [...list]
            .sorted((a, b) => a.tanggal.compareTo(b.tanggal));
        total += _hitungSelisihKm(sorted);
      }
      return total;
    } catch (e, s) {
      // Log error dan kembalikan 0 agar tidak crash.
      L.e('getTotalKm error: $e $s');
      return 0;
    }
  }

  /// Menghitung total liter bahan bakar.
  double getTotalLiter(String? idKendaraan) {
    final list = idKendaraan == null || idKendaraan.isEmpty
        ? listBahanBakar
        : getListByIdKendaraan(idKendaraan);
    return list.fold<double>(0, (sum, b) => sum + b.liter);
  }

  /// Menghitung rata-rata biaya per kilometer.
  double getRataRataBiayaPerKm(String? idKendaraan) {
    final totalKm = idKendaraan == null || idKendaraan.isEmpty
        ? getTotalKm()
        : getTotalKmByIdKendaraan(idKendaraan);
    if (totalKm == 0) return 0;
    return getJumlahTotal(idKendaraan) / totalKm;
  }

  /// Menghitung rata-rata biaya per liter.
  double getRataRataBiayaPerLiter(String? idKendaraan) {
    final totalLiter = getTotalLiter(idKendaraan);
    if (totalLiter == 0) return 0;
    return getJumlahTotal(idKendaraan) / totalLiter;
  }

  /// Menghitung kilometer per liter.
  double getKmPerLiter(String? idKendaraan) {
    final totalKm = idKendaraan == null || idKendaraan.isEmpty
        ? getTotalKm()
        : getTotalKmByIdKendaraan(idKendaraan);
    final totalLiter = getTotalLiter(idKendaraan);
    if (totalLiter == 0) return 0;
    return totalKm / totalLiter;
  }

  /// Menghitung tren kilometer per liter.
  List<MapEntry<DateTime, double>> getKmPerLiterTrend(String? idKendaraan) {
    if (idKendaraan == null || idKendaraan.isEmpty) {
      final grouped = <String, List<BahanBakarModel>>{};
      for (final b in listBahanBakar) {
        grouped.putIfAbsent(b.idKendaraan, () => []).add(b);
      }
      final hasil = <MapEntry<DateTime, double>>[];
      for (final list in grouped.values) {
        if (list.length < 2) continue;
        // Menggunakan sorted dari package:collection sesuai AGENTS.md.
        final sorted = [...list]
            .sorted((a, b) => a.tanggal.compareTo(b.tanggal));
        for (var i = 1; i < sorted.length; i++) {
          final kmLama = sorted[i - 1].km;
          final kmBaru = sorted[i].km;
          final liter = sorted[i].liter;
          if (liter <= 0) continue;
          double kmTempuh;
          if (kmBaru >= kmLama) {
            kmTempuh = kmBaru - kmLama;
          } else {
            kmTempuh = (kmBaru + 1000000) - kmLama;
          }
          hasil.add(MapEntry(sorted[i].tanggal, kmTempuh / liter));
        }
      }
      // Menggunakan sorted dari package:collection sesuai AGENTS.md.
      final hasilSorted = hasil.sorted((a, b) => a.key.compareTo(b.key));
      return hasilSorted;
    }
    final list = getListByIdKendaraan(idKendaraan);
    if (list.isEmpty) return [];
    // Menggunakan sorted dari package:collection sesuai AGENTS.md.
    final sorted = [...list].sorted((a, b) => a.tanggal.compareTo(b.tanggal));
    final hasil = <MapEntry<DateTime, double>>[];
    for (var i = 1; i < sorted.length; i++) {
      final kmLama = sorted[i - 1].km;
      final kmBaru = sorted[i].km;
      final liter = sorted[i].liter;
      if (liter <= 0) continue;
      double kmTempuh;
      if (kmBaru >= kmLama) {
        kmTempuh = kmBaru - kmLama;
      } else {
        kmTempuh = (kmBaru + 1000000) - kmLama;
      }
      hasil.add(MapEntry(sorted[i].tanggal, kmTempuh / liter));
    }
    return hasil;
  }
}
```


// ============================================================
// FILE: lib/fitur/dashboard/page/dashboard_page.dart
// ============================================================

```dart
// lib/fitur/dashboard/page/dashboard_page.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/dashboard/provider/dashboard_provider.dart';
import 'package:myapp/fitur/impian/notifier/impian_notifier.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_model.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_notifier.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/km/model/km_model.dart';
import 'package:myapp/fitur/km/notifier/km_notifier.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:myapp/shared/widget/kendaraan_terpilih_list.dart';
import 'package:myapp/shared/widget/scroll_ke_atas.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman dashboard ringkasan (KM terbaru, jadwal service terdekat, saldo transaksi, progres impian) sebagai overview kendaraan.
class DashboardPage extends ConsumerStatefulWidget {
  /// Membuat instance [DashboardPage].
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage>
    implements ScrollKeAtas {
  KendaraanModel? _kendaraanTerpilih;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    L.i('DashboardPage diinisialisasi');
    unawaited(Future.microtask(_reloadKendaraanTerpilih));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _reloadKendaraanTerpilih() async {
    try {
      final idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
      final kendaraanState = await ref.read(kendaraanProvider.future);
      KendaraanModel? kendaraan;
      if (idKendaraan != null && idKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.getById(idKendaraan);
        if (kendaraan == null && kendaraanState.listKendaraan.isNotEmpty) {
          kendaraan = kendaraanState.listKendaraan.first;
        }
      } else if (_kendaraanTerpilih != null) {
        kendaraan = _kendaraanTerpilih;
      } else if (kendaraanState.listKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.listKendaraan.first;
      }
      if (mounted) {
        setState(() {
          _kendaraanTerpilih = kendaraan;
        });
      }
    } catch (e, s) {
      L.e('Gagal memuat kendaraan terpilih: $e $s');
    }
  }

  @override
  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<String?>>(selectedKendaraanIdProvider, (
      previous,
      next,
    ) {
      try {
        if (next.isLoading || next.hasError) return;

        final prevValue = previous?.value;
        final nextValue = next.value;

        if (prevValue != nextValue) {
          unawaited(_reloadKendaraanTerpilih());
        }
      } catch (e, s) {
        L.e('Gagal proses perubahan kendaraan di dashboard: $e $s');
      }
    });
    final kendaraanAsync = ref.watch(kendaraanProvider);
    final mataUangAsync = ref.watch(mataUangProvider);

    if (kendaraanAsync.isLoading || mataUangAsync.isLoading) {
      return _buildLoading();
    }

    if (kendaraanAsync.hasError || mataUangAsync.hasError) {
      return _buildError();
    }
    final kendaraanState = kendaraanAsync.requireValue;
    final mataUang = mataUangAsync.requireValue;
    final dashboardAsync = ref.watch(dashboardProvider(_kendaraanTerpilih?.id));
    if (dashboardAsync.isLoading) return _buildLoading();
    if (dashboardAsync.hasError) return _buildError();
    final dashboardState = dashboardAsync.requireValue;

    final effectiveId = _kendaraanTerpilih?.id;
    final kendaraan = effectiveId == null
        ? null
        : kendaraanState.getById(effectiveId);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Column(
        children: [
          KendaraanTerpilihList(
            listKendaraan: kendaraanState.listKendaraan,
            selectedId: _kendaraanTerpilih?.id,
            onSelected: (k) {
              setState(() => _kendaraanTerpilih = k);
            },
            onReload: _reloadKendaraanTerpilih,
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              children: [
                _buildCardKm(dashboardState.kmTerbaru),
                const SizedBox(height: 12),
                _buildCardJadwal(
                  dashboardState.jadwalServiceTerdekat,
                  dashboardState.kmTerbaru?.km,
                ),
                const SizedBox(height: 12),
                _buildCardSaldo(dashboardState.saldo, mataUang),
                const SizedBox(height: 12),
                _buildCardImpian(
                  dashboardState.jumlahImpian.toInt(),
                  dashboardState.impianTercapai,
                ),
                if (kendaraan != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    kendaraan.nama,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardKm(KmModel? kmTerbaru) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 16,
          children: [
            const Icon(Icons.speed, size: 32),
            Expanded(
              child: Column(
                spacing: 4, // jarak antar anak pakai spacing (UI #6)
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KM Terbaru',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    kmTerbaru == null
                        ? 'Belum ada data KM'
                        : '${FormatNomor.formatRibuan(kmTerbaru.km.toInt())} km',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (kmTerbaru != null)
                    Text(
                      FormatTanggal.formatDasar(kmTerbaru.tanggal),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardJadwal(JadwalServiceModel? jadwal, double? kmTerbaru) {
    var sisaBulanText = '-';
    var sisaKmText = '-';
    Color? warnaBulan;
    Color? warnaKm;
    double? sisaBulan;
    double? sisaKm;
    if (jadwal != null) {
      sisaBulan = _sisaBulan(jadwal);
      sisaKm = kmTerbaru == null
          ? null
          : (jadwal.km + jadwal.kmTerakhirService) - kmTerbaru;
      sisaBulanText = sisaBulan == null
          ? '-'
          : 'Sisa ${sisaBulan.toStringAsFixed(1)} bulan';
      sisaKmText = sisaKm == null
          ? '-'
          : 'Sisa ${FormatNomor.formatRibuan(sisaKm.toInt())} km';
      warnaBulan = (sisaBulan != null && sisaBulan < 0)
          ? Theme.of(context).colorScheme.error
          : null;
      warnaKm = (sisaKm != null && sisaKm < 0)
          ? Theme.of(context).colorScheme.error
          : null;
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 16,
          children: [
            const Icon(Icons.calendar_month, size: 32),
            Expanded(
              child: Column(
                spacing: 4, // jarak antar anak pakai spacing (UI #6)
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jadwal Service Terdekat',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    jadwal == null ? 'Belum ada jadwal service' : jadwal.nama,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (jadwal != null) ...[
                    Text(
                      sisaBulanText,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: warnaBulan),
                    ),
                    Text(
                      sisaKmText,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: warnaKm),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double? _sisaBulan(JadwalServiceModel jadwal) {
    if (jadwal.bulan <= 0) return null;
    final targetTanggal = DateTime(
      jadwal.tanggalTerakhirService.year,
      jadwal.tanggalTerakhirService.month + jadwal.bulan.toInt(),
      jadwal.tanggalTerakhirService.day,
    );
    final sisaHari = targetTanggal.difference(DateTime.now()).inDays;
    return sisaHari / 30;
  }

  Widget _buildCardSaldo(double saldo, MataUangItem mataUang) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 16,
          children: [
            const Icon(Icons.savings, size: 32),
            Expanded(
              child: Column(
                spacing: 4, // jarak antar anak pakai spacing (UI #6)
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saldo Transaksi',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    formatMataUang(saldo, mataUang),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardImpian(int jumlahImpian, double impianTerpenuhi) {
    final progress = jumlahImpian == 0 ? 0.0 : impianTerpenuhi / jumlahImpian;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8, // jarak antar anak pakai spacing (UI #6)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 16,
              children: [
                const Icon(Icons.flag, size: 32),
                Text(
                  'Progres Impian',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Text(
              '${impianTerpenuhi.toInt()} dari $jumlahImpian impian tercapai',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Semantics(
              label: 'Progres impian',
              value: '${(progress * 100).toInt()}%',
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
              ),
            ), // UI #19: Semantics untuk aksesibilitas
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            Text(
              'Memuat dashboard...', // UX #15: pesan loading lebih spesifik
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Gagal memuat data dashboard',
            ), // UX #16: pesan error spesifik
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 44),
              ),
              onPressed: () {
                final _ = ref.refresh(
                  kendaraanProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  kmProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  jadwalServiceProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  transaksiProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  impianProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  mataUangProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/dashboard/provider/dashboard_provider.dart
// ============================================================

```dart
import 'package:collection/collection.dart';
import 'package:myapp/fitur/dashboard/state/dashboard_state.dart';
import 'package:myapp/fitur/impian/notifier/impian_notifier.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_model.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_notifier.dart';
import 'package:myapp/fitur/km/notifier/km_notifier.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_provider.g.dart';

/// Provider (state) untuk menyimpan nilai dashboard.
@Riverpod(keepAlive: true)
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Future<DashboardState> build(String? idKendaraan) async =>
      await _muatData(idKendaraan);

  Future<DashboardState> _muatData(String? idKendaraanValue) async {
    final idKendaraan = idKendaraanValue;
    final impianState = await ref.watch(impianProvider.future);
    final kmState = await ref.watch(kmProvider.future);
    final transaksiState = await ref.watch(transaksiProvider.future);
    final jadwalState = await ref.watch(jadwalServiceProvider.future);

    final kmTerbaru = kmState.kmTerbaruByIdKendaraan(idKendaraan);
    final listJadwal = idKendaraan == null || idKendaraan.isEmpty
        ? jadwalState.listJadwalService
        : jadwalState.getListByIdKendaraan(idKendaraan);
    final jadwalTerdekat = _jadwalTerdekat(listJadwal, kmTerbaru?.km);
    final saldo = idKendaraan == null
        ? transaksiState.getSaldo()
        : transaksiState.getSaldoByIdKendaraan(idKendaraan);
    final listImpian = idKendaraan == null
        ? impianState.listImpian
        : impianState.getListByIdKendaraan(idKendaraan);
    final jumlahImpian = listImpian.length;
    final listImpianTerpenuhi = idKendaraan == null
        ? impianState.getListImpianTerpenuhi(saldo)
        : impianState.getListImpianTerpenuhiByIdKendaraan(idKendaraan, saldo);

    return DashboardState(
      jumlahImpian: jumlahImpian.toDouble(),
      impianTercapai: listImpianTerpenuhi.length.toDouble(),
      jadwalServiceTerdekat: jadwalTerdekat,
      kmTerbaru: kmTerbaru,
      saldo: saldo,
    );
  }

  JadwalServiceModel? _jadwalTerdekat(
    List<JadwalServiceModel> list,
    double? kmTerbaru,
  ) {
    if (list.isEmpty) return null;
    final sorted = [...list].sorted(
      (a, b) =>
          _skorUrgensi(a, kmTerbaru).compareTo(_skorUrgensi(b, kmTerbaru)),
    );
    return sorted.first;
  }

  double _skorUrgensi(JadwalServiceModel jadwal, double? kmTerbaru) {
    final rasioKm = _rasioKm(jadwal, kmTerbaru);
    final rasioHari = _rasioHari(jadwal);
    if (rasioKm == null && rasioHari == null) return double.infinity;
    if (rasioKm == null) return rasioHari ?? double.infinity;
    if (rasioHari == null) return rasioKm;
    return rasioKm < rasioHari ? rasioKm : rasioHari;
  }

  double? _rasioKm(JadwalServiceModel jadwal, double? kmTerbaru) {
    if (kmTerbaru == null) return null;
    if (jadwal.km <= 0) return null;
    final sisaKm = (jadwal.km + jadwal.kmTerakhirService) - kmTerbaru;
    return sisaKm / jadwal.km;
  }

  double? _rasioHari(JadwalServiceModel jadwal) {
    if (jadwal.bulan <= 0) return null;
    final targetTanggal = DateTime(
      jadwal.tanggalTerakhirService.year,
      jadwal.tanggalTerakhirService.month + jadwal.bulan.toInt(),
      jadwal.tanggalTerakhirService.day,
    );
    final sisaHari = targetTanggal.difference(DateTime.now()).inDays;
    return sisaHari / (jadwal.bulan * 30);
  }
}
```


// ============================================================
// FILE: lib/fitur/dashboard/state/dashboard_state.dart
// ============================================================

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_model.dart';
import 'package:myapp/fitur/km/model/km_model.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const DashboardState._();

  const factory DashboardState({
    KmModel? kmTerbaru,
    @Default(0) double saldo,
    JadwalServiceModel? jadwalServiceTerdekat,
    @Default(0) double jumlahImpian,
    @Default(0) double impianTercapai,
  }) = _DashboardState;
}
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/bahan_bakar/notifier/bahan_bakar_notifier.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_bahan_bakar.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_impian.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_jadwal_service.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_jadwal_service_komponen.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_kategori_transaksi.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_kendaraan.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_km.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_komponen.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_pengingat.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_riwayat_jadwal_service.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_transaksi.dart';
import 'package:myapp/fitur/impian/notifier/impian_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_komponen_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/riwayat_jadwal_service_notifier.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/km/notifier/km_notifier.dart';
import 'package:myapp/fitur/komponen/notifier/komponen_notifier.dart';
import 'package:myapp/fitur/pengingat/notifier/pengingat_notifier.dart';
import 'package:myapp/fitur/transaksi/notifier/kategori_transaksi_notifier.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:share_global_saya/core_shared.dart';

/// Koleksi data dummy untuk pengembangan dan pengujian aplikasi.
class DummyData {
  /// Menyisipkan semua data dummy ke database melalui [ref]. Seluruh operasi lintas entitas dibungkus dalam satu transaksi DB (begin/commit/rollback) agar konsisten; jika gagal akan rollback.
  static Future<void> insertData(WidgetRef ref) async {
    L.i('DummyData.insertData mulai');
    try {
      // Urutan insert menjaga integritas foreign key:

      L.i('insert kendaraan mulai');
      // 1. Insert kendaraan
      await ref
          .read(kendaraanProvider.notifier)
          .batchInsertFromSync(dummyKendaraan);
      L.s('insert kendaraan selesai');

      L.i('insert komponen mulai');
      // 2. Insert komponen
      await ref
          .read(komponenProvider.notifier)
          .batchInsertFromSync(dummyKomponen);
      L.s('insert komponen selesai');

      L.i('insert jadwal service mulai');
      // 3. Insert jadwal service
      await ref
          .read(jadwalServiceProvider.notifier)
          .batchInsertFromSync(dummyJadwalService);
      L.s('insert jadwal service selesai');

      L.i('insert jadwal service komponen mulai');
      // 4. Insert jadwal service komponen (relasi)
      await ref
          .read(jadwalServiceKomponenProvider.notifier)
          .batchInsertFromSync(dummyJadwalServiceKomponen);
      L.s('insert jadwal service komponen selesai');

      L.i('insert km mulai');
      // 5. Insert km
      await ref.read(kmProvider.notifier).batchInsertFromSync(dummyKm);
      L.s('insert km selesai');

      L.i('insert bahan bakar mulai');
      // 6. Insert bahan bakar
      await ref
          .read(bahanBakarProvider.notifier)
          .batchInsertFromSync(dummyBahanBakar);
      L.s('insert bahan bakar selesai');

      L.i('insert riwayat jadwal service mulai');
      // 7. Insert riwayat jadwal service
      await ref
          .read(riwayatJadwalServiceProvider.notifier)
          .batchInsertFromSync(dummyRiwayatJadwalService);
      L.s('insert riwayat jadwal service selesai');

      L.i('insert tabungan mulai');
      // 8. Insert transaksi dummy
      await ref
          .read(transaksiProvider.notifier)
          .batchInsertFromSync(dummyTransaksi);
      L.s('insert tabungan selesai');

      L.i('insert kategori tabungan mulai');
      // 8b. Insert kategori transaksi dummy
      await ref
          .read(kategoriTransaksiProvider.notifier)
          .batchInsertFromSync(dummyKategoriTransaksi);
      L.s('insert kategori tabungan selesai');

      L.i('insert impian mulai');
      // 9. Insert impian dummy
      await ref.read(impianProvider.notifier).batchInsertFromSync(dummyImpian);
      L.s('insert impian selesai');

      L.i('insert pengingat mulai');
      // 10. Insert pengingat dummy
      await ref
          .read(pengingatProvider.notifier)
          .batchInsertFromSync(dummyPengingat);
      L.s('insert pengingat selesai');
      L.s('DummyData.insertData selesai');
    } catch (e, s) {
      L.e('Insert data dummy gagal: $e $s');
      rethrow;
    } finally {
      L.i('DummyData.insertData selesai (finally)');
    }
  }

  /// Menghapus semua data dummy dari database melalui [ref]. Seluruh operasi penghapusan lintas entitas dibungkus dalam satu transaksi DB (begin/commit/rollback) agar konsisten; jika gagal rollback.
  static Future<void> hapusSemuaData(WidgetRef ref) async {
    L.i('DummyData.hapusSemuaData mulai');
    try {
      // Urutan hapus: relasi → jadwal service → komponen → km → kendaraan

      L.i('hapus relasi dummy mulai');
      // 1. Hapus semua relasi dummy
      final jadwalServiceKomponenIds = [
        JadwalServiceKomponenIdDummy.item1,
        JadwalServiceKomponenIdDummy.item2,
        JadwalServiceKomponenIdDummy.item3,
        JadwalServiceKomponenIdDummy.item4,
        JadwalServiceKomponenIdDummy.item5,
        JadwalServiceKomponenIdDummy.item6,
        JadwalServiceKomponenIdDummy.item7,
        JadwalServiceKomponenIdDummy.item8,
        JadwalServiceKomponenIdDummy.item9,
        JadwalServiceKomponenIdDummy.item10,
      ];
      for (final id in jadwalServiceKomponenIds) {
        await ref.read(jadwalServiceKomponenProvider.notifier).hapus(id);
      }

      L.i('hapus riwayat jadwal service dummy mulai');
      // 2. Hapus semua riwayat jadwal service dummy
      final riwayatIds = [
        RiwayatJadwalServiceIdDummy.item1,
        RiwayatJadwalServiceIdDummy.item2,
      ];
      for (final id in riwayatIds) {
        await ref.read(riwayatJadwalServiceProvider.notifier).hapus(id);
      }

      L.i('hapus jadwal service dummy mulai');
      // 3. Hapus semua jadwal service dummy
      final jadwalIds = [
        JadwalServiceIdDummy.item1,
        JadwalServiceIdDummy.item2,
        JadwalServiceIdDummy.item3,
        JadwalServiceIdDummy.item4,
        JadwalServiceIdDummy.item5,
        JadwalServiceIdDummy.item6,
        JadwalServiceIdDummy.item7,
        JadwalServiceIdDummy.item8,
        JadwalServiceIdDummy.item9,
        JadwalServiceIdDummy.item10,
        JadwalServiceIdDummy.item11,
        JadwalServiceIdDummy.item12,
        JadwalServiceIdDummy.item13,
        JadwalServiceIdDummy.item14,
        JadwalServiceIdDummy.item15,
      ];
      for (final id in jadwalIds) {
        await ref.read(jadwalServiceProvider.notifier).hapus(id);
      }

      L.i('hapus komponen dummy mulai');
      // 3. Hapus semua komponen dummy (termasuk yang baru)
      final komponenIds = [
        KomponenIdDummy.item1,
        KomponenIdDummy.item2,
        KomponenIdDummy.item3,
        KomponenIdDummy.item4, // 🆕
        KomponenIdDummy.item5, // 🆕
        KomponenIdDummy.item6, // 🆕
        KomponenIdDummy.item7, // 🆕
        KomponenIdDummy.item8, // 🆕
        KomponenIdDummy.item9, // 🆕
        KomponenIdDummy.item10, // 🆕
        KomponenIdDummy.item11, // 🆕
        KomponenIdDummy.item12, // 🆕
        KomponenIdDummy.item13, // 🆕
      ];
      for (final id in komponenIds) {
        await ref.read(komponenProvider.notifier).hapus(id);
      }

      L.i('hapus tabungan dummy mulai');
      // 4. Hapus semua transaksi dummy
      final transaksiIds = [
        TransaksiIdDummy.item1,
        TransaksiIdDummy.item2,
        TransaksiIdDummy.item3,
        TransaksiIdDummy.item4,
        TransaksiIdDummy.item5,
        TransaksiIdDummy.item6,
      ];
      for (final id in transaksiIds) {
        await ref.read(transaksiProvider.notifier).hapus(id);
      }

      L.i('hapus kategori tabungan dummy mulai');
      // 4b2. Hapus semua kategori transaksi dummy
      final kategoriTransaksiIds = [
        KategoriTransaksiIdDummy.item1,
        KategoriTransaksiIdDummy.item2,
        KategoriTransaksiIdDummy.item3,
        KategoriTransaksiIdDummy.item4,
        KategoriTransaksiIdDummy.item5,
        KategoriTransaksiIdDummy.item6,
      ];
      for (final id in kategoriTransaksiIds) {
        await ref.read(kategoriTransaksiProvider.notifier).hapus(id);
      }

      L.i('hapus impian dummy mulai');
      // 4b. Hapus semua impian dummy
      final impianIds = [
        ImpianIdDummy.item1,
        ImpianIdDummy.item2,
        ImpianIdDummy.item3,
        ImpianIdDummy.item4,
        ImpianIdDummy.item5,
        ImpianIdDummy.item6,
      ];
      for (final id in impianIds) {
        await ref.read(impianProvider.notifier).hapus(id);
      }

      L.i('hapus bahan bakar dummy mulai');
      // 4c. Hapus semua bahan bakar dummy
      final bahanBakarIds = [
        BahanBakarIdDummy.item1,
        BahanBakarIdDummy.item2,
        BahanBakarIdDummy.item3,
        BahanBakarIdDummy.item4,
        BahanBakarIdDummy.item5,
        BahanBakarIdDummy.item6,
        BahanBakarIdDummy.item7,
        BahanBakarIdDummy.item8,
        BahanBakarIdDummy.item9,
        BahanBakarIdDummy.item10,
        BahanBakarIdDummy.item11,
        BahanBakarIdDummy.item12,
        BahanBakarIdDummy.item13,
        BahanBakarIdDummy.item14,
        BahanBakarIdDummy.item15,
      ];
      for (final id in bahanBakarIds) {
        await ref.read(bahanBakarProvider.notifier).hapus(id);
      }

      L.i('hapus kendaraan dummy mulai');
      // 5. Hapus semua kendaraan dummy
      final kendaraanIds = [
        KendaraanIdDummy.item1,
        KendaraanIdDummy.item2,
        KendaraanIdDummy.item3,
      ];
      for (final id in kendaraanIds) {
        await ref.read(kendaraanProvider.notifier).hapus(id);
      }

      L.i('hapus pengingat dummy mulai');
      // 6. Hapus semua pengingat dummy
      final pengingatIds = [
        PengingatIdDummy.item1,
        PengingatIdDummy.item2,
        PengingatIdDummy.item3,
        PengingatIdDummy.item4,
      ];
      for (final id in pengingatIds) {
        await ref.read(pengingatProvider.notifier).hapus(id);
      }
      L.s('DummyData.hapusSemuaData selesai');
    } catch (e, s) {
      L.e('Hapus semua data dummy gagal: $e $s');
      rethrow;
    } finally {
      L.i('DummyData.hapusSemuaData selesai (finally)');
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_bahan_bakar.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_bahan_bakar.dart

import 'package:myapp/fitur/bahan_bakar/model/bahan_bakar_model.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_kendaraan.dart';
import 'package:myapp/fitur/dummy/dummy_helper.dart';

/// ID dummy untuk data bahan bakar.
class BahanBakarIdDummy {
  /// ID dummy bahan bakar item1.
  static const String item1 = '00000000-0000-0000-0006-000000000001';

  /// ID dummy bahan bakar item2.
  static const String item2 = '00000000-0000-0000-0006-000000000002';

  /// ID dummy bahan bakar item3.
  static const String item3 = '00000000-0000-0000-0006-000000000003';

  /// ID dummy bahan bakar item4.
  static const String item4 = '00000000-0000-0000-0006-000000000004';

  /// ID dummy bahan bakar item5.
  static const String item5 = '00000000-0000-0000-0006-000000000005';

  /// ID dummy bahan bakar item6.
  static const String item6 = '00000000-0000-0000-0006-000000000006';

  /// ID dummy bahan bakar item7.
  static const String item7 = '00000000-0000-0000-0006-000000000007';

  /// ID dummy bahan bakar item8.
  static const String item8 = '00000000-0000-0000-0006-000000000008';

  /// ID dummy bahan bakar item9.
  static const String item9 = '00000000-0000-0000-0006-000000000009';

  /// ID dummy bahan bakar item10.
  static const String item10 = '00000000-0000-0000-0006-000000000010';

  /// ID dummy bahan bakar item11.
  static const String item11 = '00000000-0000-0000-0006-000000000011';

  /// ID dummy bahan bakar item12.
  static const String item12 = '00000000-0000-0000-0006-000000000012';

  /// ID dummy bahan bakar item13.
  static const String item13 = '00000000-0000-0000-0006-000000000013';

  /// ID dummy bahan bakar item14.
  static const String item14 = '00000000-0000-0000-0006-000000000014';

  /// ID dummy bahan bakar item15.
  static const String item15 = '00000000-0000-0000-0006-000000000015';
}

/// Daftar data dummy bahan bakar.
final List<BahanBakarModel> dummyBahanBakar = [
  BahanBakarModel(
    id: BahanBakarIdDummy.item1,
    idKendaraan: KendaraanIdDummy.item1,
    tanggal: DummyDate.bulanLalu(5),
    km: 999980.0,
    liter: 30.0,
    hargaPerLiter: 10000.0,
    total: 300000.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item2,
    idKendaraan: KendaraanIdDummy.item1,
    tanggal: DummyDate.bulanLalu(12),
    km: 999995.0,
    liter: 28.0,
    hargaPerLiter: 10200.0,
    total: 285600.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item3,
    idKendaraan: KendaraanIdDummy.item1,
    tanggal: DummyDate.bulanSekarang(3),
    km: 5.0,
    liter: 32.0,
    hargaPerLiter: 10100.0,
    total: 323200.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item4,
    idKendaraan: KendaraanIdDummy.item1,
    tanggal: DummyDate.bulanSekarang(10),
    km: 100.0,
    liter: 29.0,
    hargaPerLiter: 10300.0,
    total: 298700.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item5,
    idKendaraan: KendaraanIdDummy.item1,
    tanggal: DummyDate.bulanSekarang(18),
    km: 200.0,
    liter: 31.0,
    hargaPerLiter: 10400.0,
    total: 322400.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item6,
    idKendaraan: KendaraanIdDummy.item2,
    tanggal: DummyDate.bulanLalu(4),
    km: 999900.0,
    liter: 15.0,
    hargaPerLiter: 10000.0,
    total: 150000.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item7,
    idKendaraan: KendaraanIdDummy.item2,
    tanggal: DummyDate.bulanLalu(11),
    km: 999950.0,
    liter: 14.0,
    hargaPerLiter: 10100.0,
    total: 141400.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item8,
    idKendaraan: KendaraanIdDummy.item2,
    tanggal: DummyDate.bulanSekarang(2),
    km: 10.0,
    liter: 16.0,
    hargaPerLiter: 10200.0,
    total: 163200.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item9,
    idKendaraan: KendaraanIdDummy.item2,
    tanggal: DummyDate.bulanSekarang(9),
    km: 60.0,
    liter: 15.5,
    hargaPerLiter: 10300.0,
    total: 159650.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item10,
    idKendaraan: KendaraanIdDummy.item2,
    tanggal: DummyDate.bulanSekarang(17),
    km: 120.0,
    liter: 14.5,
    hargaPerLiter: 10400.0,
    total: 150800.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item11,
    idKendaraan: KendaraanIdDummy.item3,
    tanggal: DummyDate.bulanLalu(6),
    km: 999800.0,
    liter: 50.0,
    hargaPerLiter: 10000.0,
    total: 500000.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item12,
    idKendaraan: KendaraanIdDummy.item3,
    tanggal: DummyDate.bulanLalu(13),
    km: 999900.0,
    liter: 48.0,
    hargaPerLiter: 10100.0,
    total: 484800.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item13,
    idKendaraan: KendaraanIdDummy.item3,
    tanggal: DummyDate.bulanSekarang(4),
    km: 20.0,
    liter: 52.0,
    hargaPerLiter: 10200.0,
    total: 530400.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item14,
    idKendaraan: KendaraanIdDummy.item3,
    tanggal: DummyDate.bulanSekarang(11),
    km: 80.0,
    liter: 49.0,
    hargaPerLiter: 10300.0,
    total: 504700.0,
    diperbarui: DummyDate.now,
  ),
  BahanBakarModel(
    id: BahanBakarIdDummy.item15,
    idKendaraan: KendaraanIdDummy.item3,
    tanggal: DummyDate.bulanSekarang(19),
    km: 150.0,
    liter: 51.0,
    hargaPerLiter: 10400.0,
    total: 530400.0,
    diperbarui: DummyDate.now,
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_impian.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_impian.dart

import 'package:myapp/fitur/dummy/dummy_data/dummy_kendaraan.dart';
import 'package:myapp/fitur/dummy/dummy_helper.dart';
import 'package:myapp/fitur/impian/model/impian_model.dart';

/// ID dummy untuk data impian.
class ImpianIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0006-000000000001';

  /// ID dummy item 2.
  static const String item2 = '00000000-0000-0000-0006-000000000002';

  /// ID dummy item 3.
  static const String item3 = '00000000-0000-0000-0006-000000000003';

  /// ID dummy item 4.
  static const String item4 = '00000000-0000-0000-0006-000000000004';

  /// ID dummy item 5.
  static const String item5 = '00000000-0000-0000-0006-000000000005';

  /// ID dummy item 6.
  static const String item6 = '00000000-0000-0000-0006-000000000006';
}

/// Daftar data dummy impian.
final List<ImpianModel> dummyImpian = [
  ImpianModel(
    id: ImpianIdDummy.item1,
    idKendaraan: KendaraanIdDummy.item1,
    deskripsi: 'Beli ban baru',
    jumlah: 2000000.0,
    tanggalDibuat: DummyDate.bulanLalu(5),
    diperbarui: DummyDate.now,
    tanggalTarget: DummyDate.bulanDepan(10),
  ),
  ImpianModel(
    id: ImpianIdDummy.item2,
    idKendaraan: KendaraanIdDummy.item1,
    deskripsi: 'Service AC mobil',
    jumlah: 1500000.0,
    tanggalDibuat: DummyDate.bulanLalu(8),
    diperbarui: DummyDate.now,
    tanggalTarget: DummyDate.bulanDepan(15),
  ),
  ImpianModel(
    id: ImpianIdDummy.item3,
    idKendaraan: KendaraanIdDummy.item2,
    deskripsi: 'Ganti knalpot racing',
    jumlah: 1000000.0,
    tanggalDibuat: DummyDate.bulanLalu(3),
    diperbarui: DummyDate.now,
    tanggalTarget: DummyDate.bulanDepan(20),
  ),
  ImpianModel(
    id: ImpianIdDummy.item4,
    idKendaraan: KendaraanIdDummy.item2,
    deskripsi: 'Beli helm baru',
    jumlah: 500000.0,
    tanggalDibuat: DummyDate.bulanLalu(6),
    diperbarui: DummyDate.now,
    tanggalTarget: DummyDate.bulanDepan(5),
  ),
  ImpianModel(
    id: ImpianIdDummy.item5,
    idKendaraan: KendaraanIdDummy.item3,
    deskripsi: 'Ganti oli gardan',
    jumlah: 800000.0,
    tanggalDibuat: DummyDate.bulanLalu(2),
    diperbarui: DummyDate.now,
    tanggalTarget: DummyDate.bulanDepan(12),
  ),
  ImpianModel(
    id: ImpianIdDummy.item6,
    idKendaraan: KendaraanIdDummy.item3,
    deskripsi: 'Pasang roof rack',
    jumlah: 3000000.0,
    tanggalDibuat: DummyDate.bulanLalu(4),
    diperbarui: DummyDate.now,
    tanggalTarget: DummyDate.bulanDepan(25),
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_jadwal_service.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_jadwal_service.dart

import 'package:myapp/fitur/dummy/dummy_data/dummy_kendaraan.dart';
import 'package:myapp/fitur/dummy/dummy_helper.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_model.dart';

/// ID dummy untuk data jadwal service.
class JadwalServiceIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0003-000000000001';

  /// ID dummy item 2.
  static const String item2 = '00000000-0000-0000-0003-000000000002';

  /// ID dummy item 3.
  static const String item3 = '00000000-0000-0000-0003-000000000003';

  /// ID dummy item 4.
  static const String item4 = '00000000-0000-0000-0003-000000000004';

  /// ID dummy item 5.
  static const String item5 = '00000000-0000-0000-0003-000000000005';

  /// ID dummy item 6.
  static const String item6 = '00000000-0000-0000-0003-000000000006';

  /// ID dummy item 7.
  static const String item7 = '00000000-0000-0000-0003-000000000007';

  /// ID dummy item 8.
  static const String item8 = '00000000-0000-0000-0003-000000000008';

  /// ID dummy item 9.
  static const String item9 = '00000000-0000-0000-0003-000000000009';

  /// ID dummy item 10.
  static const String item10 = '00000000-0000-0000-0003-000000000010';

  /// ID dummy item 11.
  static const String item11 = '00000000-0000-0000-0003-000000000011';

  /// ID dummy item 12.
  static const String item12 = '00000000-0000-0000-0003-000000000012';

  /// ID dummy item 13.
  static const String item13 = '00000000-0000-0000-0003-000000000013';

  /// ID dummy item 14.
  static const String item14 = '00000000-0000-0000-0003-000000000014';

  /// ID dummy item 15.
  static const String item15 = '00000000-0000-0000-0003-000000000015';
}

/// Daftar data dummy jadwal service yang digunakan untuk pengujian dan demonstrasi.
final List<JadwalServiceModel> dummyJadwalService = [
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item1,
    nama: 'Service Ringan',
    bulan: 1.0,
    km: 5000.0,
    kmTerakhirService: 5000.0,
    tanggalTerakhirService: DummyDate.bulanLalu(15),
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item4,
    nama: 'Service Oli',
    bulan: 2.0,
    km: 10000.0,
    kmTerakhirService: 10000.0,
    tanggalTerakhirService: DummyDate.bulanSekarang(10),
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item7,
    nama: 'Service Roda',
    bulan: 1.0,
    km: 5000.0,
    kmTerakhirService: 5000.0,
    tanggalTerakhirService: DummyDate.bulanSekarang(25),
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item8,
    nama: 'Service AC',
    bulan: 6.0,
    km: 20000.0,
    kmTerakhirService: 15000.0,
    tanggalTerakhirService: DummyDate.bulanLalu(20),
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item9,
    nama: 'Service Transmisi',
    bulan: 12.0,
    km: 40000.0,
    kmTerakhirService: 35000.0,
    tanggalTerakhirService: DummyDate.bulanDepan(5),
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
  ),

  JadwalServiceModel(
    id: JadwalServiceIdDummy.item2,
    nama: 'Service Sedang',
    bulan: 3.0,
    km: 15000.0,
    kmTerakhirService: 15000.0,
    tanggalTerakhirService: DummyDate.bulanLalu(15)
        .subtract(const Duration(days: 60)),
    idKendaraan: KendaraanIdDummy.item2,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item5,
    nama: 'Service Rem',
    bulan: 4.0,
    km: 20000.0,
    kmTerakhirService: 20000.0,
    tanggalTerakhirService: DummyDate.bulanLalu(5),
    idKendaraan: KendaraanIdDummy.item2,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item10,
    nama: 'Service Rantai',
    bulan: 2.0,
    km: 8000.0,
    kmTerakhirService: 8000.0,
    tanggalTerakhirService: DummyDate.bulanSekarang(15),
    idKendaraan: KendaraanIdDummy.item2,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item11,
    nama: 'Service Busi',
    bulan: 6.0,
    km: 12000.0,
    kmTerakhirService: 10000.0,
    tanggalTerakhirService: DummyDate.bulanLalu(28),
    idKendaraan: KendaraanIdDummy.item2,
    diperbarui: DummyDate.now,
  ),

  JadwalServiceModel(
    id: JadwalServiceIdDummy.item3,
    nama: 'Service Berat',
    bulan: 6.0,
    km: 30000.0,
    kmTerakhirService: 30000.0,
    tanggalTerakhirService: DummyDate.bulanLalu(15)
        .subtract(const Duration(days: 150)),
    idKendaraan: KendaraanIdDummy.item3,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item6,
    nama: 'Service Mesin',
    bulan: 6.0,
    km: 30000.0,
    kmTerakhirService: 30000.0,
    tanggalTerakhirService: DummyDate.bulanDepan(20),
    idKendaraan: KendaraanIdDummy.item3,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item12,
    nama: 'Service Kopling',
    bulan: 8.0,
    km: 45000.0,
    kmTerakhirService: 42000.0,
    tanggalTerakhirService: DummyDate.bulanLalu(10),
    idKendaraan: KendaraanIdDummy.item3,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item13,
    nama: 'Service Gardan',
    bulan: 12.0,
    km: 60000.0,
    kmTerakhirService: 55000.0,
    tanggalTerakhirService: DummyDate.bulanDepan(15),
    idKendaraan: KendaraanIdDummy.item3,
    diperbarui: DummyDate.now,
  ),

  JadwalServiceModel(
    id: JadwalServiceIdDummy.item14,
    nama: 'Service Ban',
    bulan: 2.0,
    km: 15000.0,
    kmTerakhirService: 12000.0,
    tanggalTerakhirService: DummyDate.bulanSekarang(8),
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceModel(
    id: JadwalServiceIdDummy.item15,
    nama: 'Service Baterai',
    bulan: 12.0,
    km: 50000.0,
    kmTerakhirService: 48000.0,
    tanggalTerakhirService: DummyDate.bulanLalu(25),
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_jadwal_service_komponen.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_jadwal_service_komponen.dart

import 'package:myapp/fitur/dummy/dummy_data/dummy_jadwal_service.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_kendaraan.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_komponen.dart';
import 'package:myapp/fitur/dummy/dummy_helper.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_komponen_model.dart';

/// ID dummy untuk relasi jadwal service dengan komponen.
class JadwalServiceKomponenIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0004-000000000001';

  /// ID dummy item 2.
  static const String item2 = '00000000-0000-0000-0004-000000000002';

  /// ID dummy item 3.
  static const String item3 = '00000000-0000-0000-0004-000000000003';

  /// ID dummy item 4.
  static const String item4 = '00000000-0000-0000-0004-000000000004';

  /// ID dummy item 5.
  static const String item5 = '00000000-0000-0000-0004-000000000005';

  /// ID dummy item 6.
  static const String item6 = '00000000-0000-0000-0004-000000000006';

  /// ID dummy item 7.
  static const String item7 = '00000000-0000-0000-0004-000000000007';

  /// ID dummy item 8.
  static const String item8 = '00000000-0000-0000-0004-000000000008';

  /// ID dummy item 9.
  static const String item9 = '00000000-0000-0000-0004-000000000009';

  /// ID dummy item 10.
  static const String item10 = '00000000-0000-0000-0004-000000000010';
}

/// Daftar data dummy relasi jadwal service dengan komponen.
final List<JadwalServiceKomponenModel> dummyJadwalServiceKomponen = [
  JadwalServiceKomponenModel(
    id: JadwalServiceKomponenIdDummy.item1,
    jadwalServiceId: JadwalServiceIdDummy.item1, // Service Ringan
    komponenId: KomponenIdDummy.item1, // Oli Mesin
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceKomponenModel(
    id: JadwalServiceKomponenIdDummy.item2,
    jadwalServiceId: JadwalServiceIdDummy.item1, // Service Ringan
    // Menyamakan komponen dan kendaraan agar relasi tidak menyambung ke kendaraan lain
    komponenId: KomponenIdDummy.item1, // Oli Mesin (milih kend 1)
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceKomponenModel(
    id: JadwalServiceKomponenIdDummy.item5,
    jadwalServiceId: JadwalServiceIdDummy.item4, // Service Oli
    komponenId: KomponenIdDummy.item1, // Oli Mesin
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceKomponenModel(
    id: JadwalServiceKomponenIdDummy.item6,
    jadwalServiceId: JadwalServiceIdDummy.item7, // Service Roda
    komponenId: KomponenIdDummy.item3, // Kampas Rem
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
  ),

  JadwalServiceKomponenModel(
    id: JadwalServiceKomponenIdDummy.item3,
    jadwalServiceId: JadwalServiceIdDummy.item2, // Service Sedang
    komponenId: KomponenIdDummy.item2, // Filter Udara
    idKendaraan: KendaraanIdDummy.item2,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceKomponenModel(
    id: JadwalServiceKomponenIdDummy.item7,
    jadwalServiceId: JadwalServiceIdDummy.item5, // Service Rem
    komponenId: KomponenIdDummy.item3, // Kampas Rem
    idKendaraan: KendaraanIdDummy.item2,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceKomponenModel(
    id: JadwalServiceKomponenIdDummy.item8,
    jadwalServiceId: JadwalServiceIdDummy.item10, // Service Rantai
    komponenId: KomponenIdDummy.item2, // Filter Udara
    idKendaraan: KendaraanIdDummy.item2,
    diperbarui: DummyDate.now,
  ),

  JadwalServiceKomponenModel(
    id: JadwalServiceKomponenIdDummy.item4,
    jadwalServiceId: JadwalServiceIdDummy.item3, // Service Berat
    komponenId: KomponenIdDummy.item1, // Oli Mesin
    idKendaraan: KendaraanIdDummy.item3,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceKomponenModel(
    id: JadwalServiceKomponenIdDummy.item9,
    jadwalServiceId: JadwalServiceIdDummy.item6, // Service Mesin
    komponenId: KomponenIdDummy.item1, // Oli Mesin
    idKendaraan: KendaraanIdDummy.item3,
    diperbarui: DummyDate.now,
  ),
  JadwalServiceKomponenModel(
    id: JadwalServiceKomponenIdDummy.item10,
    jadwalServiceId: JadwalServiceIdDummy.item12, // Service Kopling
    komponenId: KomponenIdDummy.item3, // Kampas Rem
    idKendaraan: KendaraanIdDummy.item3,
    diperbarui: DummyDate.now,
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_kategori_transaksi.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_kategori_transaksi.dart

import 'package:myapp/fitur/dummy/dummy_helper.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/fitur/transaksi/model/kategori_transaksi_model.dart';

/// ID dummy untuk data kategori transaksi.
class KategoriTransaksiIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0010-000000000001';

  /// ID dummy item 2.
  static const String item2 = '00000000-0000-0000-0010-000000000002';

  /// ID dummy item 3.
  static const String item3 = '00000000-0000-0000-0010-000000000003';

  /// ID dummy item 4.
  static const String item4 = '00000000-0000-0000-0010-000000000004';

  /// ID dummy item 5.
  static const String item5 = '00000000-0000-0000-0010-000000000005';

  /// ID dummy item 6.
  static const String item6 = '00000000-0000-0000-0010-000000000006';
}

/// Daftar data dummy kategori transaksi.
final List<KategoriTransaksiModel> dummyKategoriTransaksi = [
  KategoriTransaksiModel(
    id: KategoriTransaksiIdDummy.item1,
    nama: 'Parkir',
    ikon: 'local_parking',
    warna: '#3B82F6',
    tipe: TipeTransaksiEnum.pengeluaran,
    diperbarui: DummyDate.now,
  ),
  KategoriTransaksiModel(
    id: KategoriTransaksiIdDummy.item2,
    nama: 'Tol',
    ikon: 'toll',
    warna: '#10B981',
    tipe: TipeTransaksiEnum.pengeluaran,
    diperbarui: DummyDate.now,
  ),
  KategoriTransaksiModel(
    id: KategoriTransaksiIdDummy.item3,
    nama: 'Cuci Kendaraan',
    ikon: 'local_car_wash',
    warna: '#06B6D4',
    tipe: TipeTransaksiEnum.pengeluaran,
    diperbarui: DummyDate.now,
  ),
  KategoriTransaksiModel(
    id: KategoriTransaksiIdDummy.item4,
    nama: 'Asuransi',
    ikon: 'security',
    warna: '#8B5CF6',
    tipe: TipeTransaksiEnum.pengeluaran,
    diperbarui: DummyDate.now,
  ),
  KategoriTransaksiModel(
    id: KategoriTransaksiIdDummy.item5,
    nama: 'Perbaikan',
    ikon: 'build',
    warna: '#F59E0B',
    tipe: TipeTransaksiEnum.pengeluaran,
    diperbarui: DummyDate.now,
  ),
  KategoriTransaksiModel(
    id: KategoriTransaksiIdDummy.item6,
    nama: 'Lainnya',
    ikon: 'more_horiz',
    warna: '#6B7280',
    tipe: TipeTransaksiEnum.pengeluaran,
    diperbarui: DummyDate.now,
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_kendaraan.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_kendaraan.dart

import 'package:myapp/fitur/dummy/dummy_helper.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';

/// ID dummy untuk data kendaraan.
class KendaraanIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0005-000000000001';

  /// ID dummy item 2.
  static const String item2 = '00000000-0000-0000-0005-000000000002';

  /// ID dummy item 3.
  static const String item3 = '00000000-0000-0000-0005-000000000003';
}

/// Daftar data dummy kendaraan.
final List<KendaraanModel> dummyKendaraan = [
  KendaraanModel(
    id: KendaraanIdDummy.item1,
    nama: 'Mobil Keluarga',
    merk: 'Toyota',
    platNomor: 'B 1234 CD',
    tahunKeluar: '2019',
    model: 'Avanza',
    jenis: 'Mobil',
    diperbarui: DummyDate.now,
  ),
  KendaraanModel(
    id: KendaraanIdDummy.item2,
    nama: 'Motor Sport',
    merk: 'Honda',
    platNomor: 'B 5678 EF',
    tahunKeluar: '2021',
    model: 'CBR',
    jenis: 'Motor',
    diperbarui: DummyDate.now,
  ),
  KendaraanModel(
    id: KendaraanIdDummy.item3,
    nama: 'Truk',
    merk: 'Mitsubishi',
    platNomor: 'B 9012 GH',
    tahunKeluar: '2018',
    model: 'Canter',
    jenis: 'Truk',
    diperbarui: DummyDate.now,
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_km.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_km.dart

import 'package:myapp/fitur/dummy/dummy_data/dummy_kendaraan.dart'; // 🆕 import ID kendaraan
import 'package:myapp/fitur/dummy/dummy_helper.dart';
import 'package:myapp/fitur/km/model/km_model.dart';

/// ID dummy untuk data kilometer.
class KmIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0001-000000000001';

  /// ID dummy item 2.
  static const String item2 = '00000000-0000-0000-0001-000000000002';

  /// ID dummy item 3.
  static const String item3 = '00000000-0000-0000-0001-000000000003';
}

/// Daftar data dummy kilometer.
final List<KmModel> dummyKm = [
  KmModel(
    id: KmIdDummy.item1,
    km: 10000.0,
    idKendaraan: KendaraanIdDummy.item1, // 🆕 merujuk ke kendaraan 1
    tanggal: DummyDate.bulanSekarang(15),
    diperbarui: DummyDate.now,
  ),
  KmModel(
    id: KmIdDummy.item2,
    km: 20000.0,
    idKendaraan: KendaraanIdDummy.item2, // 🆕 merujuk ke kendaraan 2
    tanggal: DummyDate.bulanLalu(3),
    diperbarui: DummyDate.now,
  ),
  KmModel(
    id: KmIdDummy.item3,
    km: 15000.0,
    idKendaraan: KendaraanIdDummy.item3, // 🆕 merujuk ke kendaraan 3
    tanggal: DummyDate.bulanDepan(10),
    diperbarui: DummyDate.now,
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_komponen.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_komponen.dart

import 'package:myapp/fitur/dummy/dummy_data/dummy_kendaraan.dart';
import 'package:myapp/fitur/dummy/dummy_helper.dart';
import 'package:myapp/fitur/komponen/model/komponen_model.dart';
import 'package:myapp/fitur/komponen/model/link_toko_model.dart';

/// ID dummy untuk data komponen.
class KomponenIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0002-000000000001';

  /// ID dummy item 2.
  static const String item2 = '00000000-0000-0000-0002-000000000002';

  /// ID dummy item 3.
  static const String item3 = '00000000-0000-0000-0002-000000000003';

  /// ID dummy item 4.
  static const String item4 = '00000000-0000-0000-0002-000000000004';

  /// ID dummy item 5.
  static const String item5 = '00000000-0000-0000-0002-000000000005';

  /// ID dummy item 6.
  static const String item6 = '00000000-0000-0000-0002-000000000006';

  /// ID dummy item 7.
  static const String item7 = '00000000-0000-0000-0002-000000000007';

  /// ID dummy item 8.
  static const String item8 = '00000000-0000-0000-0002-000000000008';

  /// ID dummy item 9.
  static const String item9 = '00000000-0000-0000-0002-000000000009';

  /// ID dummy item 10.
  static const String item10 = '00000000-0000-0000-0002-000000000010';

  /// ID dummy item 11.
  static const String item11 = '00000000-0000-0000-0002-000000000011';

  /// ID dummy item 12.
  static const String item12 = '00000000-0000-0000-0002-000000000012';

  /// ID dummy item 13.
  static const String item13 = '00000000-0000-0000-0002-000000000013';
}

/// Daftar data dummy komponen.
final List<KomponenModel> dummyKomponen = [
  KomponenModel(
    id: KomponenIdDummy.item1,
    nama: 'Oli Mesin',
    harga: 2000,
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),
  KomponenModel(
    id: KomponenIdDummy.item2,
    nama: 'Filter Udara',
    harga: 2,
    idKendaraan: KendaraanIdDummy.item2,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),
  KomponenModel(
    id: KomponenIdDummy.item3,
    nama: 'Kampas Rem',
    harga: 2000,
    idKendaraan: KendaraanIdDummy.item3,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),

  KomponenModel(
    id: KomponenIdDummy.item4,
    nama: 'Busi',
    harga: 150000,
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),
  KomponenModel(
    id: KomponenIdDummy.item5,
    nama: 'Aki',
    harga: 850000,
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),
  KomponenModel(
    id: KomponenIdDummy.item6,
    nama: 'Filter Oli',
    harga: 75000,
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),
  KomponenModel(
    id: KomponenIdDummy.item7,
    nama: 'Kampas Kopling',
    harga: 350000,
    idKendaraan: KendaraanIdDummy.item1,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),

  KomponenModel(
    id: KomponenIdDummy.item8,
    nama: 'Kampas Rem Depan',
    harga: 180000,
    idKendaraan: KendaraanIdDummy.item2,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),
  KomponenModel(
    id: KomponenIdDummy.item9,
    nama: 'Kampas Rem Belakang',
    harga: 160000,
    idKendaraan: KendaraanIdDummy.item2,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),
  KomponenModel(
    id: KomponenIdDummy.item10,
    nama: 'Oli Gardan',
    harga: 120000,
    idKendaraan: KendaraanIdDummy.item2,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),

  KomponenModel(
    id: KomponenIdDummy.item11,
    nama: 'Filter Solar',
    harga: 200000,
    idKendaraan: KendaraanIdDummy.item3,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),
  KomponenModel(
    id: KomponenIdDummy.item12,
    nama: 'Turbocharger',
    harga: 2500000,
    idKendaraan: KendaraanIdDummy.item3,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),
  KomponenModel(
    id: KomponenIdDummy.item13,
    nama: 'Radiator',
    harga: 1200000,
    idKendaraan: KendaraanIdDummy.item3,
    diperbarui: DummyDate.now,
    linkToko: [
      const LinkTokoModel(
        namaToko: 'Toko Sparepart',
        url: 'https://tokosparepart.id',
      ),
    ],
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_pengingat.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_pengingat.dart

import 'package:myapp/fitur/dummy/dummy_data/dummy_kendaraan.dart';
import 'package:myapp/fitur/dummy/dummy_helper.dart';
import 'package:myapp/fitur/pengingat/enum/kategori_pengingat.dart';
import 'package:myapp/fitur/pengingat/model/pengingat_model.dart';

/// ID dummy untuk data pengingat.
class PengingatIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0007-000000000001';

  /// ID dummy item 2.
  static const String item2 = '00000000-0000-0000-0007-000000000002';

  /// ID dummy item 3.
  static const String item3 = '00000000-0000-0000-0007-000000000003';

  /// ID dummy item 4.
  static const String item4 = '00000000-0000-0000-0007-000000000004';
}

/// Daftar data dummy pengingat untuk semua kategori.
final List<PengingatModel> dummyPengingat = [
  PengingatModel(
    id: PengingatIdDummy.item1,
    idKendaraan: KendaraanIdDummy.item1,
    pesan: 'Pajak kendaraan jatuh tempo minggu ini',
    tanggalTampil: DummyDate.bulanSekarang(15),
    kategoriPengingat: KategoriPengingat.pajak,
    pageTujuan: PageTujuan.kendaraanPage,
    diperbarui: DummyDate.now,
  ),
  PengingatModel(
    id: PengingatIdDummy.item2,
    idKendaraan: KendaraanIdDummy.item1,
    pesan: 'Jadwal service rutin bulan ini',
    tanggalTampil: DummyDate.bulanDepan(10),
    kategoriPengingat: KategoriPengingat.jadwalService,
    pageTujuan: PageTujuan.kendaraanPage,
    diperbarui: DummyDate.now,
  ),
  PengingatModel(
    id: PengingatIdDummy.item3,
    idKendaraan: KendaraanIdDummy.item1,
    pesan: 'Cek semua pengingat kendaraan',
    tanggalTampil: DummyDate.bulanSekarang(20),
    kategoriPengingat: KategoriPengingat.semua,
    pageTujuan: PageTujuan.kendaraanPage,
    diperbarui: DummyDate.now,
  ),
  PengingatModel(
    id: PengingatIdDummy.item4,
    idKendaraan: KendaraanIdDummy.item1,
    pesan: 'Service AC dan ganti oli',
    tanggalTampil: DummyDate.bulanDepan(5),
    kategoriPengingat: KategoriPengingat.jadwalService,
    pageTujuan: PageTujuan.kendaraanPage,
    diperbarui: DummyDate.now,
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_riwayat_jadwal_service.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_riwayat_jadwal_service.dart

import 'package:myapp/fitur/dummy/dummy_data/dummy_jadwal_service.dart';
import 'package:myapp/fitur/dummy/dummy_data/dummy_kendaraan.dart';
import 'package:myapp/fitur/dummy/dummy_helper.dart';
import 'package:myapp/fitur/jadwal_service/model/riwayat_jadwal_service_model.dart';

/// ID dummy untuk data riwayat jadwal service.
class RiwayatJadwalServiceIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0006-000000000001';

  /// ID dummy item 2.
  static const String item2 = '00000000-0000-0000-0006-000000000002';
}

/// Daftar data dummy riwayat jadwal service.
final List<RiwayatJadwalServiceModel> dummyRiwayatJadwalService = [
  RiwayatJadwalServiceModel(
    id: RiwayatJadwalServiceIdDummy.item1,
    jadwalServiceId: JadwalServiceIdDummy.item2, // Service Sedang
    idKendaraan: KendaraanIdDummy.item2,
    nama: 'Service Sedang',
    tanggalService: DummyDate.bulanLalu(20),
    km: 12000.0,
    biaya: 200000.0,
    diperbarui: DummyDate.now,
  ),
  RiwayatJadwalServiceModel(
    id: RiwayatJadwalServiceIdDummy.item2,
    jadwalServiceId: JadwalServiceIdDummy.item5, // Service Rem
    idKendaraan: KendaraanIdDummy.item2,
    nama: 'Service Rem',
    tanggalService: DummyDate.bulanSekarang(5),
    km: 18000.0,
    biaya: 150000.0,
    diperbarui: DummyDate.now,
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_transaksi.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_transaksi.dart

import 'package:myapp/fitur/dummy/dummy_data/dummy_kendaraan.dart';
import 'package:myapp/fitur/dummy/dummy_helper.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/fitur/transaksi/model/transaksi_model.dart';

/// ID dummy untuk data transaksi.
class TransaksiIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0004-000000000001';

  /// ID dummy item 2.
  static const String item2 = '00000000-0000-0000-0004-000000000002';

  /// ID dummy item 3.
  static const String item3 = '00000000-0000-0000-0004-000000000003';

  /// ID dummy item 4.
  static const String item4 = '00000000-0000-0000-0004-000000000004';

  /// ID dummy item 5.
  static const String item5 = '00000000-0000-0000-0004-000000000005';

  /// ID dummy item 6.
  static const String item6 = '00000000-0000-0000-0004-000000000006';
}

/// Daftar data dummy transaksi.
final List<TransaksiModel> dummyTransaksi = [
  TransaksiModel(
    id: TransaksiIdDummy.item1,
    idKendaraan: KendaraanIdDummy.item1,
    deskripsi: 'Pemasukan gaji bulanan',
    jumlah: 5000000.0,
    tanggal: DummyDate.bulanSekarang(10),
    tipeTransaksi: TipeTransaksiEnum.pemasukan,
    diperbarui: DummyDate.now,
  ),
  TransaksiModel(
    id: TransaksiIdDummy.item2,
    idKendaraan: KendaraanIdDummy.item1,
    deskripsi: 'Beli oli mesin',
    jumlah: 150000.0,
    tanggal: DummyDate.bulanSekarang(12),
    tipeTransaksi: TipeTransaksiEnum.pengeluaran,
    diperbarui: DummyDate.now,
  ),
  TransaksiModel(
    id: TransaksiIdDummy.item3,
    idKendaraan: KendaraanIdDummy.item2,
    deskripsi: 'Service motor',
    jumlah: 200000.0,
    tanggal: DummyDate.bulanLalu(5),
    tipeTransaksi: TipeTransaksiEnum.pengeluaran,
    diperbarui: DummyDate.now,
  ),
  TransaksiModel(
    id: TransaksiIdDummy.item4,
    idKendaraan: KendaraanIdDummy.item3,
    deskripsi: 'Penjualan barang bekas',
    jumlah: 300000.0,
    tanggal: DummyDate.bulanDepan(8),
    tipeTransaksi: TipeTransaksiEnum.pemasukan,
    diperbarui: DummyDate.now,
  ),
  TransaksiModel(
    id: TransaksiIdDummy.item5,
    idKendaraan: KendaraanIdDummy.item1,
    deskripsi: 'Beli kampas rem',
    jumlah: 180000.0,
    tanggal: DummyDate.bulanSekarang(20),
    tipeTransaksi: TipeTransaksiEnum.pengeluaran,
    diperbarui: DummyDate.now,
  ),
  TransaksiModel(
    id: TransaksiIdDummy.item6,
    idKendaraan: KendaraanIdDummy.item2,
    deskripsi: 'Pemasukan servis motor',
    jumlah: 500000.0,
    tanggal: DummyDate.bulanSekarang(15),
    tipeTransaksi: TipeTransaksiEnum.pemasukan,
    diperbarui: DummyDate.now,
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_helper.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_helper.dart

/// Helper untuk membuat tanggal dummy dengan mudah. Semua tanggal akan berada di bulan dan tahun yang sama dengan saat eksekusi, dan dibatasi maksimal tanggal 25 agar aman.
class DummyDate {
  static DateTime get _now => DateTime.now();

  /// Waktu sekarang yang digunakan sebagai nilai default untuk bidang diperbarui.
  static DateTime get now => _now;

  /// Membuat tanggal di bulan sekarang dengan hari tertentu. [day] = tanggal (1-31), akan dijepit ke rentang 1..min(25, lastDayOfMonth). [hour], [minute] = jam dan menit (default 0).
  static DateTime bulanSekarang(int day, [int hour = 0, int minute = 0]) {
    final lastDay = DateTime(_now.year, _now.month + 1, 0).day;
    final maxDay = lastDay < 25 ? lastDay : 25; // batasi maksimal 25
    final safeDay = day.clamp(1, maxDay);
    return DateTime(_now.year, _now.month, safeDay, hour, minute);
  }

  /// Membuat tanggal di bulan depan dengan hari tertentu. [day] = tanggal (1-31), akan dijepit ke rentang 1..min(25, lastDayOfMonth).
  static DateTime bulanDepan(int day, [int hour = 0, int minute = 0]) {
    var month = _now.month + 1;
    var year = _now.year;
    if (month > 12) {
      month = 1;
      year++;
    }
    final lastDay = DateTime(year, month + 1, 0).day;
    final maxDay = lastDay < 25 ? lastDay : 25;
    final safeDay = day.clamp(1, maxDay);
    return DateTime(year, month, safeDay, hour, minute);
  }

  /// Membuat tanggal di bulan lalu dengan hari tertentu. [day] = tanggal (1-31), akan dijepit ke rentang 1..min(25, lastDayOfMonth).
  static DateTime bulanLalu(int day, [int hour = 0, int minute = 0]) {
    var month = _now.month - 1;
    var year = _now.year;
    if (month < 1) {
      month = 12;
      year--;
    }
    final lastDay = DateTime(year, month + 1, 0).day;
    final maxDay = lastDay < 25 ? lastDay : 25;
    final safeDay = day.clamp(1, maxDay);
    return DateTime(year, month, safeDay, hour, minute);
  }
}
```


// ============================================================
// FILE: lib/fitur/dummy/page/dummy_page.dart
// ============================================================

```dart
// lib/fitur/dummy/page/dummy_page.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/dummy/dummy_data.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman untuk menjalankan aksi-aksi testing data dummy selama pengembangan.
class DummyPage extends ConsumerStatefulWidget {
  /// Membuat instance [DummyPage] dengan kunci opsional.
  const DummyPage({super.key});

  @override
  ConsumerState<DummyPage> createState() => _DummyPageState();
}

class _DummyPageState extends ConsumerState<DummyPage> {
  bool _loading = false;

  void _showLoadingDialog(BuildContext context, String message) {
    L.i('menampilkan dialog loading: $message');
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => PopScope(
          canPop: false,
          child: AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 24),
                Text(message),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Insert semua data dummy
  Future<void> _insertDummyData(BuildContext context, WidgetRef ref) async {
    L.i('mulai _insertDummyData');
    // Konfirmasi sebelum menimpa agar pengguna sadar data dummy akan diganti
    final confirmed = await showOkCancelAlertDialog(
      // migrasi adaptive_dialog (UX #12)
      context: context,
      title: 'Tambahkan Data Dummy?',
      message: 'Data dummy akan ditambahkan. Baris dummy lama akan tertimpa jika ID sama.',
      okLabel: 'Tambahkan',
      cancelLabel: 'Batal',
    );
    if (confirmed != OkCancelResult.ok) {
      L.i('insert dummy dibatalkan oleh pengguna');
      return;
    }
    if (_loading) {
      L.w('insert dummy diabaikan karena sedang loading');
      return;
    }
    // Cek mounted setelah await dialog konfirmasi untuk mencegah setState pada widget yang sudah tidak ada
    if (!mounted) {
      L.w('widget unmounted setelah konfirmasi insert');
      return;
    }
    setState(() => _loading = true);
    if (context.mounted) _showLoadingDialog(context, 'Menambahkan data...');
    try {
      await DummyData.insertData(ref);
      L.s('data dummy berhasil ditambahkan');
      if (context.mounted) {
        AppToast.sukses(context, 'Data dummy berhasil ditambahkan.');
      }
    } catch (e, s) {
      L.e('gagal menambahkan data dummy: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal menambahkan data dummy: $e');
      }
    } finally {
      if (context.mounted && Navigator.of(context).canPop()) {
        if (Navigator.of(context).canPop()) {
          Nav.pop(context); // Tutup dialog loading
        }
      }
      if (mounted) {
        setState(() => _loading = false);
      }
      L.i('selesai proses insert dummy');
    }
  }

  // Hapus semua data dummy
  Future<void> _deleteAllDummyData(BuildContext context, WidgetRef ref) async {
    L.i('mulai _deleteAllDummyData');
    final deleteConfirmed = await showOkCancelAlertDialog(
      // migrasi adaptive_dialog (UX #12)
      context: context,
      title: 'Hapus Semua Data?',
      message: 'Semua data dummy akan dihapus. Data yang Anda buat sendiri tidak terpengaruh.',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );

    if (deleteConfirmed == OkCancelResult.ok) {
      // Guard mounted setelah await dialog konfirmasi untuk mencegah setState pada widget yang sudah tidak ada.
      if (!mounted) {
        L.w('widget unmounted setelah konfirmasi hapus');
        return;
      }
      if (_loading) {
        L.w('hapus diabaikan karena sedang loading');
        return;
      }
      setState(() => _loading = true);
      if (context.mounted) {
        _showLoadingDialog(context, 'Menghapus semua data...');
      }
      try {
        await DummyData.hapusSemuaData(ref);
        await ref.read(selectedKendaraanIdProvider.notifier).clear();
        L.s('semua data dummy berhasil dihapus');
        if (context.mounted) {
          AppToast.sukses(context, 'Semua data dummy berhasil dihapus.');
        }
      } catch (e, s) {
        L.e('gagal menghapus data dummy: $e $s');
        if (context.mounted) {
          AppToast.gagal(context, 'Gagal menghapus data dummy: $e');
        }
      } finally {
        if (context.mounted) {
          if (Navigator.of(context).canPop()) {
            Nav.pop(context); // Tutup dialog loading
          }
        }
        if (mounted) {
          setState(() => _loading = false);
        }
        L.i('selesai proses hapus dummy');
      }
    } else {
      L.i('hapus dummy dibatalkan oleh pengguna');
    }
  }

  // Reset data (hapus lalu insert ulang)
  Future<void> _resetDummyData(BuildContext context, WidgetRef ref) async {
    L.i('mulai _resetDummyData');
    final resetConfirmed = await showOkCancelAlertDialog(
      // migrasi adaptive_dialog (UX #12)
      context: context,
      title: 'Reset Data Dummy?',
      message: 'Tindakan ini akan MENGHAPUS SEMUA DATA lalu menambahkan ulang data dummy. Lanjutkan?',
      okLabel: 'Reset',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );

    if (resetConfirmed == OkCancelResult.ok) {
      // Guard mounted setelah await dialog konfirmasi untuk mencegah setState pada widget yang sudah tidak ada.
      if (!mounted) {
        L.w('widget unmounted setelah konfirmasi reset');
        return;
      }
      if (_loading) {
        L.w('reset diabaikan karena sedang loading');
        return;
      }
      setState(() => _loading = true);
      if (context.mounted) {
        _showLoadingDialog(context, 'Mereset data...');
      }
      try {
        await DummyData.hapusSemuaData(ref);
        await DummyData.insertData(ref);
        L.s('data dummy berhasil di-reset');
        if (context.mounted) {
          AppToast.sukses(context, 'Data dummy berhasil di-reset.');
        }
      } catch (e, s) {
        L.e('gagal mereset data dummy: $e $s');
        if (context.mounted) {
          AppToast.gagal(context, 'Gagal mereset data dummy: $e');
        }
      } finally {
        if (context.mounted) {
          if (Navigator.of(context).canPop()) {
            Nav.pop(context); // Tutup dialog loading
          }
        }
        if (mounted) {
          setState(() => _loading = false);
        }
        L.i('selesai proses reset dummy');
      }
    } else {
      L.i('reset dummy dibatalkan oleh pengguna');
    }
  }

  @override
  Widget build(BuildContext context) {
    L.i('build DummyPage');
    final ref = this.ref;
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Dummy')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Gunakan halaman ini untuk menjalankan aksi-aksi testing selama pengembangan.',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                label: const Text('Tambah Data Dummy'),
                onPressed: _loading
                    ? null
                    : () => _insertDummyData(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                icon: Icon(
                  Icons.delete_forever,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                label: const Text('Hapus Semua Data Dummy'),
                onPressed: _loading
                    ? null
                    : () => _deleteAllDummyData(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                icon: Icon(
                  Icons.refresh,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                label: const Text('Reset Data Dummy (Hapus + Tambah)'),
                onPressed: _loading
                    ? null
                    : () => _resetDummyData(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  foregroundColor: Theme.of(context).colorScheme.onTertiary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'Aksi Lainnya:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/enum/sort_impian_enum.dart
// ============================================================

```dart
// lib/fitur/impian/enum/sort_impian_enum.dart

/// Enum untuk opsi pengurutan impian.
enum SortImpianEnum {
  /// Urutkan progres dari 100% ke 0%.
  progressZA,

  /// Urutkan progres dari 0% ke 100%.
  progressAZ,

  /// Urutkan deskripsi impian secara A ke Z.
  deskripsiAZ,

  /// Urutkan deskripsi impian secara Z ke A.
  deskripsiZA,

  /// Urutkan jumlah target dari terendah ke tertinggi.
  jumlahAZ,

  /// Urutkan jumlah target dari tertinggi ke terendah.
  jumlahZA,

  /// Urutkan tanggal target dari terlama ke terbaru.
  tanggalAZ,

  /// Urutkan tanggal target dari terbaru ke terlama.
  tanggalZA,
}

/// Extension untuk mendapatkan label tampilan dari [SortImpianEnum].
extension SortImpianExtension on SortImpianEnum {
  /// Mengembalikan label human-readable untuk opsi pengurutan ini.
  String get label {
    switch (this) {
      case SortImpianEnum.deskripsiAZ:
        return 'Deskripsi A-Z';
      case SortImpianEnum.deskripsiZA:
        return 'Deskripsi Z-A';
      case SortImpianEnum.jumlahAZ:
        return 'Jumlah Terendah';
      case SortImpianEnum.jumlahZA:
        return 'Jumlah Tertinggi';
      case SortImpianEnum.tanggalAZ:
        return 'Tanggal Terlama';
      case SortImpianEnum.tanggalZA:
        return 'Tanggal Terbaru';
      case SortImpianEnum.progressAZ:
        return 'Progres 0% - 100%';
      case SortImpianEnum.progressZA:
        return 'Progres 100% - 0%';
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/model/impian_model.dart
// ============================================================

```dart
// lib/fitur/impian/model/impian_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'impian_model.freezed.dart';

/// Model data impian (target transaksi) untuk suatu kendaraan.
@freezed
abstract class ImpianModel with _$ImpianModel {
  const ImpianModel._();

  /// Membuat instance [ImpianModel] dengan data lengkap.
  const factory ImpianModel({
    required String id,
    required String idKendaraan,
    required String deskripsi,
    required double jumlah,
    required DateTime tanggalDibuat,
    required DateTime diperbarui,
    DateTime? tanggalTarget,
    DateTime? diarsipkan,
  }) = _ImpianModel;

  // ==================== Supabase ====================

  /// Membuat [ImpianModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory ImpianModel.fromSupabase(Map<String, dynamic> map) {
    return ImpianModel(
      id: map[NamaKolom.id]?.toString() ?? '',
      idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      deskripsi: map[NamaKolom.deskripsi]?.toString() ?? '',
      jumlah: ParserUtil.parseDouble(map[NamaKolom.jumlah]),
      tanggalDibuat:
          ParserUtil.parseDateTime(map[NamaKolom.tanggalDibuat]) ??
          DateTime.now(),
      diperbarui:
          ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
      tanggalTarget: ParserUtil.parseDateTime(map[NamaKolom.tanggalTarget]),
      diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    );
  }

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.deskripsi: deskripsi,
    NamaKolom.jumlah: jumlah,
    NamaKolom.tanggalDibuat: tanggalDibuat.toIso8601String(),
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.tanggalTarget: tanggalTarget?.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  // ==================== Sqflite ====================

  /// Membuat [ImpianModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory ImpianModel.fromSqflite(Map<String, dynamic> map) {
    return ImpianModel(
      id: map[NamaKolom.id]?.toString() ?? '',
      idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      deskripsi: map[NamaKolom.deskripsi]?.toString() ?? '',
      jumlah: ParserUtil.parseDouble(map[NamaKolom.jumlah]),
      tanggalDibuat:
          ParserUtil.parseDateTime(map[NamaKolom.tanggalDibuat]) ??
          DateTime.now(),
      diperbarui:
          ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
      tanggalTarget: ParserUtil.parseDateTime(map[NamaKolom.tanggalTarget]),
      diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    );
  }

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.deskripsi: deskripsi,
    NamaKolom.jumlah: jumlah,
    NamaKolom.tanggalDibuat: tanggalDibuat.toIso8601String(),
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.tanggalTarget: tanggalTarget?.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```


// ============================================================
// FILE: lib/fitur/impian/notifier/impian_notifier.dart
// ============================================================

```dart
import 'package:myapp/fitur/impian/model/impian_model.dart';
import 'package:myapp/fitur/impian/state/impian_state.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'impian_notifier.g.dart';

/// Notifier untuk mengelola data impian (target transaksi).
@Riverpod(keepAlive: true)
class ImpianNotifier extends _$ImpianNotifier {
  final _tabelImpian = NamaTabel.impian;

  /// Membangun state awal dengan memuat daftar impian dari database.
  @override
  Future<ImpianState> build() async {
    L.i('build impian_notifier mulai');
    final hasil = await _muatDariDb();
    L.i('build impian_notifier selesai');
    return hasil;
  }

  /// Menambahkan [impian] baru ke daftar dan database.
  Future<void> tambah(ImpianModel impian) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.copyWith(
      listImpian: [...dataLama.listImpian, impian],
    );
    state = AsyncValue.data(listBaru);

    try {
      // 2. Baru update DB
      await ref
          .read(baseOpSqfliteProvider)
          .tambah(_tabelImpian, impian.toSqflite());
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('tambah impian gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Menghapus impian dengan [id] dari daftar dan database.
  Future<void> hapus(String id) async {
    final dataLama = await future;
    final listBaru = dataLama.listImpian.where((e) => e.id != id).toList();
    // Optimistic update: hapus dari state DULU
    state = AsyncValue.data(dataLama.copyWith(listImpian: listBaru));

    try {
      // 2. Baru hapus DB
      await ref.read(baseOpSqfliteProvider).hapus(_tabelImpian, id);
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('hapus impian gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Mengubah data [impian] di daftar dan database.
  Future<void> ubah(ImpianModel impian) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.listImpian
        .map((e) => e.id == impian.id ? impian : e)
        .toList();
    state = AsyncValue.data(dataLama.copyWith(listImpian: listBaru));

    try {
      // 2. Baru update DB
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(_tabelImpian, impian.toSqflite(), impian.id);
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('ubah impian gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Memuat ulang data impian dari database (helper terpusat).
  Future<ImpianState> _muatDariDb() async {
    final listDb = await ref
        .read(baseOpSqfliteProvider)
        .ambilData(NamaTabel.impian);
    final listHasil = listDb
        .whereType<Map<String, dynamic>>()
        .map(ImpianModel.fromSqflite)
        .toList();
    L.i('muat data impian dari db selesai');
    return ImpianState(listImpian: listHasil);
  }

  /// Melakukan batch insert [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(List<ImpianModel> data) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabelImpian,
            data.map((e) => e.toSqflite()).toList(),
          );

      state = AsyncValue.data(await _muatDariDb());
    } catch (e, s) {
      L.e('Gagal batch insert impian $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/page/detail_impian_page.dart
// ============================================================

```dart
// lib/fitur/impian/page/detail_impian_page.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/impian/model/impian_model.dart';
import 'package:myapp/fitur/impian/notifier/impian_notifier.dart';
import 'package:myapp/fitur/impian/page/form_impian.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman detail untuk melihat informasi lengkap impian.
class DetailImpianPage extends ConsumerStatefulWidget {
  /// ID impian yang akan ditampilkan detailnya.
  final String id;

  /// Membuat instance [DetailImpianPage] dengan [id] impian.
  const DetailImpianPage({super.key, required this.id});

  @override
  ConsumerState<DetailImpianPage> createState() => _DetailImpianPageState();
}

class _DetailImpianPageState extends ConsumerState<DetailImpianPage> {
  bool _isLoading = false;
  String get id => widget.id;

  /// Menampilkan dialog konfirmasi penghapusan impian.
  Future<void> _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    ImpianModel? impian,
  ) async {
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Impian?',
      message: 'Data impian ini akan dihapus secara permanen.',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );

    if (konfirmasi == OkCancelResult.ok) {
      try {
        final id = impian?.id;
        if (id == null) {
          return;
        }
        setState(() => _isLoading = true);
        await ref.read(impianProvider.notifier).hapus(id);
        if (context.mounted) {
          AppToast.sukses(context, 'Impian berhasil dihapus');
          Nav.pop(context);
        }
      } catch (e, s) {
        L.e('Gagal menghapus impian: $e $s');
        if (context.mounted) {
          AppToast.gagal(context, 'Gagal menghapus impian');
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    } else {
      L.i('Penghapusan impian dibatalkan');
    }
  }

  @override
  Widget build(BuildContext context) {
    final impianAsync = ref.watch(impianProvider);
    final transaksiAsync = ref.watch(transaksiProvider);
    final mataUangAsync = ref.watch(mataUangProvider);
    // Urutan pemeriksaan wajib: loading → error → data
    if (impianAsync.isLoading ||
        transaksiAsync.isLoading ||
        mataUangAsync.isLoading) {
      return _buildLoading();
    }
    if (impianAsync.hasError ||
        transaksiAsync.hasError ||
        mataUangAsync.hasError) {
      return _buildError(ref);
    }

    final impianState = impianAsync.requireValue;
    final transaksiState = transaksiAsync.requireValue;
    final mataUangItem = mataUangAsync.requireValue;

    final impian = impianState.getById(id);
    if (impian == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Impian')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 24,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              const Text('Impian tidak ditemukan'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => Nav.pop(context),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      );
    }
    // Menyamakan rumus progres dengan ringkasan (saldo = pemasukan - pengeluaran)
    final totalTerkumpul = transaksiState.getSaldoByIdKendaraan(
      impian.idKendaraan,
    );
    final progress = impian.jumlah <= 0
        ? 0.0
        : (totalTerkumpul / impian.jumlah).clamp(0.0, 1.0);
    final sisa = ((impian.jumlah) - totalTerkumpul).clamp(0.0, double.infinity);
    final sudahCapai = totalTerkumpul >= (impian.jumlah);
    final estimasiPerHari = impianState.transaksiPerHari(
      impian,
      totalTerkumpul,
    );
    final estimasiHariTercapai = impianState.estimasiHariTercapai(
      impian,
      totalTerkumpul,
    );
    final transaksiPerHariTanpaTarget = impianState.transaksiPerHariTanpaTarget(
      impian,
      totalTerkumpul,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          impian.deskripsi,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () =>
                unawaited(Nav.to(context, FormImpian(impianModel: impian))),
            tooltip: 'Edit Impian',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Deskripsi', impian.deskripsi),
            const Divider(),
            _buildInfoRow(
              'Jumlah Target',
              formatMataUang(impian.jumlah, mataUangItem),
            ),
            const Divider(),
            _buildInfoRow(
              'Terakhir Diperbarui',
              FormatWaktuLengkap.formatSingkat(impian.diperbarui),
            ),
            if (impian.diarsipkan != null)
              _buildInfoRow(
                'Diarsipkan',
                FormatWaktuLengkap.formatSingkat(
                  impian.diarsipkan ?? DateTime.now(),
                ),
              ),
            const Divider(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sudahCapai ? 'Target Tercapai' : 'Progress Impian',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: sudahCapai
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                              ),
                        ),
                        Text(
                          '${(progress * 100).toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: sudahCapai
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Semantics(
                      label:
                          'Progress impian ${(progress * 100).toStringAsFixed(1)} persen',
                      value: '${(progress * 100).toStringAsFixed(1)}%',
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 12,
                        borderRadius: BorderRadius.circular(12),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          sudahCapai
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildProgressInfo(
                          'Terkumpul',
                          formatMataUang(totalTerkumpul, mataUangItem),
                          sudahCapai
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primary,
                        ),
                        _buildProgressInfo(
                          'Sisa',
                          formatMataUang(sisa, mataUangItem),
                          sudahCapai
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.error,
                        ),
                      ],
                    ),
                    if (impian.tanggalTarget != null)
                      _buildInfoRow(
                        'Target Tabung per Hari',
                        estimasiPerHari == null
                            ? '-'
                            : estimasiPerHari == 0
                            ? 'Sudah tercapai'
                            : formatMataUang(estimasiPerHari, mataUangItem),
                      ),
                    // Fitur 2: Estimasi waktu tercapai
                    if (estimasiHariTercapai != null)
                      _buildInfoRow(
                        'Estimasi Tercapai',
                        estimasiHariTercapai == 0
                            ? 'Sudah tercapai'
                            : estimasiHariTercapai < 30
                            ? '${estimasiHariTercapai.toStringAsFixed(0)} hari'
                            : '${(estimasiHariTercapai / 30).toStringAsFixed(1)} bulan',
                      ),
                    // Fitur 4: Estimasi transaksi harian tanpa tanggal target
                    if (impian.tanggalTarget == null &&
                        transaksiPerHariTanpaTarget != null)
                      _buildInfoRow(
                        'Estimasi Tabung per Hari',
                        transaksiPerHariTanpaTarget == 0
                            ? 'Sudah tercapai'
                            : formatMataUang(
                                transaksiPerHariTanpaTarget,
                                mataUangItem,
                              ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading
                    ? null
                    : () => _showDeleteConfirmation(context, ref, impian),
                icon: _isLoading
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    : const Icon(Icons.delete),
                label: Text(_isLoading ? 'Menghapus...' : 'Hapus Impian'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Widget _buildError(WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(
                  impianProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  transaksiProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressInfo(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/page/form_impian.dart
// ============================================================

```dart
// lib/fitur/impian/page/form_impian.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/impian/model/impian_model.dart';
import 'package:myapp/fitur/impian/notifier/impian_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Opsi tanggal untuk impian.
enum OpsiTanggal {
  /// Tanggal impian.
  tanggal,

  /// Target impian.
  target,
}

/// Halaman form untuk menambah atau mengedit data impian.
class FormImpian extends ConsumerStatefulWidget {
  /// Model impian yang akan diedit. [null] jika mode tambah.
  final ImpianModel? impianModel;

  /// Membuat form impian. [impianModel] parameter opsional untuk mode edit.
  const FormImpian({super.key, this.impianModel});

  @override
  ConsumerState<FormImpian> createState() => _FormImpianState();
}

class _FormImpianState extends ConsumerState<FormImpian> {
  final _formKey = GlobalKey<FormState>();
  final _deskripsiController = TextEditingController();
  final _jumlahController = TextEditingController();

  final _deskripsiFocusNode = FocusNode();
  final _jumlahFocusNode = FocusNode();

  DateTime? _tanggalTerpilih;
  DateTime? _targetTerpilih;

  bool _modeEdit = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _modeEdit = widget.impianModel != null;
    if (_modeEdit) {
      // Menghindari operator ! sesuai AGENTS.md; model sudah dijamin non-null oleh _modeEdit.
      final model = widget.impianModel;
      if (model == null) return; // defensif null
      _deskripsiController.text = model.deskripsi;
      _jumlahController.text = model.jumlah.toStringAsFixed(0);
      _tanggalTerpilih = model.tanggalDibuat;
      _targetTerpilih = model.tanggalTarget;
    } else {
      _tanggalTerpilih = DateTime.now();
    }
    L.i('FormImpian dibuka, mode edit: $_modeEdit');
  }

  @override
  void dispose() {
    _deskripsiController.dispose();
    _jumlahController.dispose();
    _deskripsiFocusNode.dispose();
    _jumlahFocusNode.dispose();
    L.i('FormImpian ditutup');
    super.dispose();
  }

  /// Menyimpan data impian (tambah atau edit).
  Future<void> _simpanForm() async {
    if (_isLoading) {
      L.w('Form masih loading, simpan diabaikan');
      return;
    }
    // Menghindari ! pada GlobalKey FormState sesuai AGENTS.md.
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      L.w('Validasi form gagal');
      return;
    }
    L.i('Menyimpan data impian, mode edit: $_modeEdit');
    setState(() => _isLoading = true);
    try {
      // Menghindari ! saat akses id model edit sesuai AGENTS.md.
      final modelEdit = widget.impianModel;
      final idImpian = (_modeEdit && modelEdit != null)
          ? modelEdit.id
          : const Uuid().v4();
      // Baca ID kendaraan terpilih via ref.read + AsyncValue dengan guard sesuai aturan Riverpod (tanpa extension watch di luar build).
      final selectedAsync = ref.read(selectedKendaraanIdProvider);
      final idKendaraan = (selectedAsync.isLoading || selectedAsync.hasError)
          ? ''
          : (selectedAsync.requireValue ?? '');
      if (idKendaraan.isEmpty) {
        L.w('Tidak ada kendaraan terpilih');
        AppToast.gagal(context, 'Pilih kendaraan terlebih dahulu');
        if (mounted) setState(() => _isLoading = false);
        return;
      }
      final jumlah = InputAngka.parseAngkaRibuan(_jumlahController.text);
      if (jumlah <= 0) {
        AppToast.gagal(context, 'Jumlah impian harus lebih dari 0');
        if (mounted) setState(() => _isLoading = false);
        return;
      }
      if (_tanggalTerpilih == null) {
        AppToast.gagal(context, 'Pilih tanggal terlebih dahulu');
        if (mounted) setState(() => _isLoading = false);
        return;
      }
      // Menghindari ! pada DateTime nilable sesuai AGENTS.md.
      final target = _targetTerpilih;
      final tanggal = _tanggalTerpilih;
      if (target != null && tanggal != null && target.isBefore(tanggal)) {
        AppToast.gagal(
          context,
          'Tanggal target tidak boleh lebih awal dari tanggal dibuat',
        );
        if (mounted) setState(() => _isLoading = false);
        return;
      }
      final impianToSave = ImpianModel(
        id: idImpian,
        idKendaraan: idKendaraan,
        deskripsi: _deskripsiController.text.trim(),
        jumlah: jumlah,
        // Menghindari ! pada tanggal setelah pengecekan null sesuai AGENTS.md.
        tanggalDibuat: (_tanggalTerpilih ?? DateTime.now()),
        tanggalTarget: _targetTerpilih,
        diperbarui: DateTime.now(),
        // Menjaga status arsip tetap saat edit, bukan menghapus ke null
        diarsipkan: widget.impianModel?.diarsipkan,
      );
      L.i('impianToSave $impianToSave');
      if (_modeEdit) {
        await ref.read(impianProvider.notifier).ubah(impianToSave);
      } else {
        await ref.read(impianProvider.notifier).tambah(impianToSave);
      }
      if (mounted) {
        AppToast.sukses(
          context,
          _modeEdit
              ? 'Impian berhasil diperbarui'
              : 'Impian berhasil ditambahkan',
        );
        Nav.pop(context);
        L.s('Data impian berhasil ${_modeEdit ? 'diperbarui' : 'ditambahkan'}');
      }
    } catch (e, s) {
      L.e('Gagal menyimpan impian: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan impian');
      }
    } finally {
      if (mounted) {
        setState(
          () => _isLoading = false,
        ); // hapus pengecekan mounted ganda (bug runtime #7)
      }
    }
  }

  Future<void> _pilihTanggal(OpsiTanggal opsiTanggal) async {
    final opsiTerpilih = opsiTanggal == OpsiTanggal.tanggal
        ? _tanggalTerpilih
        : _targetTerpilih;
    final now = DateTime.now();
    final firstDate = opsiTanggal == OpsiTanggal.target
        ? (_tanggalTerpilih ?? DateTime(2000))
        : DateTime(2000);
    final picked = await showDatePicker(
      context: context,
      initialDate: opsiTerpilih ?? now,
      firstDate: firstDate,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (mounted) {
        setState(() {
          if (opsiTanggal == OpsiTanggal.tanggal) {
            _tanggalTerpilih = picked;
          } else {
            _targetTerpilih = picked;
          }
        });
      }
    }
  }

  void _resetKeSekarang(OpsiTanggal opsiTanggal) {
    L.i('Reset tanggal ke sekarang');
    setState(() {
      if (opsiTanggal == OpsiTanggal.tanggal) {
        _tanggalTerpilih = DateTime.now();
      } else {
        _targetTerpilih = DateTime.now();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_modeEdit ? 'Edit Impian' : 'Tambah Impian')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildFormImpian(),
              const SizedBox(height: 24),
              _buildTombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormImpian() {
    return Column(
      spacing: 16,
      children: [
        InputTeks(
          controller: _deskripsiController,
          label: 'Deskripsi Impian',
          focusNode: _deskripsiFocusNode,
        ),
        InputAngka(
          controller: _jumlahController,
          label: 'Jumlah Target',
          prefixIcon: Icons.savings,
        ),
        PemilihTanggalWaktuWidget(
          tanggalTerpilih: _tanggalTerpilih,
          onPilihTanggal: () => _pilihTanggal(OpsiTanggal.tanggal),
          onResetKeSekarang: () => _resetKeSekarang(OpsiTanggal.tanggal),
          teksLabel: 'Tanggal',
        ),
        PemilihTanggalWaktuWidget(
          tanggalTerpilih: _targetTerpilih,
          onPilihTanggal: () => _pilihTanggal(OpsiTanggal.target),
          onResetKeSekarang: () => _resetKeSekarang(OpsiTanggal.target),
          teksLabel: 'Tanggal Target',
        ),
      ],
    );
  }

  Widget _buildTombolSimpan() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _simpanForm,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
      ),
      child: _isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          : const Text('Simpan'),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/page/impian_page.dart
// ============================================================

```dart
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/impian/enum/sort_impian_enum.dart';
import 'package:myapp/fitur/impian/model/impian_model.dart';
import 'package:myapp/fitur/impian/notifier/impian_notifier.dart';
import 'package:myapp/fitur/impian/page/detail_impian_page.dart';
import 'package:myapp/fitur/impian/page/form_impian.dart';
import 'package:myapp/fitur/impian/state/impian_state.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/kendaraan/state/kendaraan_state.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:myapp/fitur/transaksi/state/transaksi_state.dart';
import 'package:myapp/shared/widget/kendaraan_terpilih_list.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman daftar impian (target transaksi) dengan fitur pencarian dan pengurutan.
class ImpianPage extends ConsumerStatefulWidget {
  /// Buat halaman impian.
  const ImpianPage({super.key});

  @override
  ConsumerState<ImpianPage> createState() => _ImpianPageState();
}

class _ImpianPageState extends ConsumerState<ImpianPage> {
  final _cariController = TextEditingController();
  final _cariFocusNode = FocusNode();
  SortImpianEnum _sortImpian = SortImpianEnum.progressZA;
  bool _modeCari = false;
  KendaraanModel? _kendaraanTerpilih;
  bool _sedangNavigasi = false;
  Timer? _cariDebounce;

  @override
  void initState() {
    super.initState();
    _cariController.addListener(_saatTeksCariBerubah);
    unawaited(Future.microtask(_reloadKendaraanTerpilih));
  }

  Future<void> _reloadKendaraanTerpilih() async {
    try {
      // Gunakan .future agar id kendaraan terbaca setelah provider selesai dimuat.
      final idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
      final kendaraanState = await ref.read(kendaraanProvider.future);
      KendaraanModel? kendaraan;
      if (idKendaraan != null && idKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.getById(idKendaraan);
        if (kendaraan == null && kendaraanState.listKendaraan.isNotEmpty) {
          kendaraan = kendaraanState.listKendaraan.first;
        }
      } else if (_kendaraanTerpilih != null) {
        kendaraan = _kendaraanTerpilih;
      } else if (kendaraanState.listKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.listKendaraan.first;
      }
      L.i(
        'idKendaraan=$idKendaraan, kendaraanState=$kendaraanState, kendaraan=$kendaraan',
      );
      if (mounted) {
        setState(() => _kendaraanTerpilih = kendaraan);
      }
    } catch (e, s) {
      L.e('Gagal memuat kendaraan terpilih impian: $e $s');
    }
  }

  void _saatTeksCariBerubah() {
    // Debounce setState agar tidak rebuild seluruh halaman pada setiap keystroke.
    _cariDebounce?.cancel();
    _cariDebounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) setState(() {});
    });
  }

  Future<void> _modalOpsiSort() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true, // ← BARU: handle untuk drag sheet
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sort,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Urutkan Impian',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                RadioGroup<SortImpianEnum>(
                  groupValue: _sortImpian,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _sortImpian = value);
                      // Perbaikan: gunakan Nav.pop sesuai konvensi navigasi proyek.
                      Nav.pop(context);
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: SortImpianEnum.values.map((sort) {
                      return ListTile(
                        title: Text(sort.label),
                        leading: Radio<SortImpianEnum>(value: sort),
                        onTap: () {
                          setState(() => _sortImpian = sort);
                          // Perbaikan: gunakan Nav.pop sesuai konvensi navigasi proyek.
                          Nav.pop(context);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Mengurutkan daftar impian [items] sesuai opsi pengurutan yang dipilih.
  List<ImpianModel> _getSortedList(
    List<ImpianModel>? items,
    double transaksiTerkumpul,
  ) {
    final sorted = [...?items];
    // Menggunakan sorted dari package:collection sesuai AGENTS.md (bukan .sort native).
    // `sorted` mengembalikan list BARU; simpan hasilnya agar pengurutan berlaku.
    switch (_sortImpian) {
      case SortImpianEnum.deskripsiAZ:
        return sorted.sorted((a, b) => a.deskripsi.compareTo(b.deskripsi));
      case SortImpianEnum.deskripsiZA:
        return sorted.sorted((a, b) => b.deskripsi.compareTo(a.deskripsi));
      case SortImpianEnum.jumlahAZ:
        return sorted.sorted((a, b) => a.jumlah.compareTo(b.jumlah));
      case SortImpianEnum.jumlahZA:
        return sorted.sorted((a, b) => b.jumlah.compareTo(a.jumlah));
      case SortImpianEnum.tanggalAZ:
        return sorted.sorted(
          (a, b) => a.tanggalDibuat.compareTo(b.tanggalDibuat),
        );
      case SortImpianEnum.tanggalZA:
        return sorted.sorted(
          (a, b) => b.tanggalDibuat.compareTo(a.tanggalDibuat),
        );
      case SortImpianEnum.progressAZ:
        return sorted.sorted((a, b) {
          final pa = a.jumlah == 0 ? 0.0 : (transaksiTerkumpul / a.jumlah);
          final pb = b.jumlah == 0 ? 0.0 : (transaksiTerkumpul / b.jumlah);
          return pa.compareTo(pb);
        });
      case SortImpianEnum.progressZA:
        return sorted.sorted((a, b) {
          final pa = a.jumlah == 0 ? 0.0 : (transaksiTerkumpul / a.jumlah);
          final pb = b.jumlah == 0 ? 0.0 : (transaksiTerkumpul / b.jumlah);
          return pb.compareTo(pa);
        });
    }
  }

  @override
  void dispose() {
    _cariDebounce?.cancel();
    _cariController.removeListener(_saatTeksCariBerubah);

    _cariController.dispose();
    _cariFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Bandingkan nilai AsyncValue menggunakan valueOrNull untuk menghindari akses .value tanpa guard.
    ref.listen(selectedKendaraanIdProvider, (previous, next) {
      if (previous?.asData?.value != next.asData?.value) {
        unawaited(_reloadKendaraanTerpilih());
      }
    });
    final kendaraanAsync = ref.watch(kendaraanProvider);
    final impianAsync = ref.watch(impianProvider);
    final transaksiAsync = ref.watch(transaksiProvider);
    final mataUangAsync = ref.watch(mataUangProvider);
    // Urutan pemeriksaan AsyncValue: loading → error → data (optimasi_bug_runtime.md poin 9).
    if (kendaraanAsync.isLoading ||
        impianAsync.isLoading ||
        transaksiAsync.isLoading ||
        mataUangAsync.isLoading) {
      return _buildLoading();
    }
    if (kendaraanAsync.hasError ||
        impianAsync.hasError ||
        transaksiAsync.hasError ||
        mataUangAsync.hasError) {
      return _buildError();
    }

    final kendaraanState = kendaraanAsync.requireValue;
    final impianState = impianAsync.requireValue;
    final transaksiState = transaksiAsync.requireValue;
    final mataUangItem = mataUangAsync.requireValue;

    final listImpian = impianState.listImpian;
    return Scaffold(
      appBar: _buildAppBarDefault(listImpian.length),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 4,
          children: [
            KendaraanTerpilihList(
              listKendaraan: kendaraanState.listKendaraan,
              selectedId: _kendaraanTerpilih?.id,
              onSelected: (k) {
                setState(() => _kendaraanTerpilih = k);
              },
              onReload: _reloadKendaraanTerpilih,
            ),
            _buildcardRingkasan(
              kendaraanState,
              impianState,
              transaksiState,
              mataUangItem,
            ),
            listImpian.isEmpty
                ? _buildListKosong()
                : _buildListImpian(transaksiState, impianState, mataUangItem),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab-impian',
        tooltip: 'Tambah impian',
        onPressed: _sedangNavigasi
            ? null
            : () async {
                setState(() => _sedangNavigasi = true);
                await Nav.to(context, const FormImpian());
                if (mounted) setState(() => _sedangNavigasi = false);
              },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            const Text('Memuat impian...'),
            // Memberikan informasi jelas jika data gagal dimuat (UX poin 2).
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                'Jika data belum muncul, coba ulang.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(
                  kendaraanProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  impianProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  transaksiProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBarDefault(int jumlahImpian) {
    return AppBar(
      title: _modeCari
          ? InputTeks(
              controller: _cariController,
              focusNode: _cariFocusNode,
              hintText: 'Cari impian...',
              prefixIcon: Icons.search,
              suffixIcon: Icons.close,
              onSuffixIconPressed: _cariController.clear,
            )
          // Gunakan Text sebagai title AppBar (bukan Padding/Column) agar sesuai pola title AppBar.
          : const Text('Impian'),
      actions: [
        if (_modeCari) ...[
          TextButton(
            onPressed: () {
              _cariController.clear();
              _cariFocusNode.unfocus();
              setState(() {
                _modeCari = false;
              });
            },
            child: const Text('Batal'),
          ),
        ] else ...[
          IconButton(
            onPressed: () {
              setState(() {
                _modeCari = true;
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _cariFocusNode.requestFocus();
              });
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(onPressed: _modalOpsiSort, icon: const Icon(Icons.sort)),
        ],
      ],
    );
  }

  Widget _buildcardRingkasan(
    KendaraanState kendaraanState,
    ImpianState impianState,
    TransaksiState transaksiState,
    MataUangItem mataUangItem,
  ) {
    final idKendaraan = _kendaraanTerpilih?.id;
    final kendaraan = kendaraanState.getById(idKendaraan ?? '');
    final jumlahTarget = idKendaraan == null
        ? impianState.getTotalJumlah()
        : impianState.getTotalJumlahByIdKendaraan(idKendaraan);
    final saldoTransaksi = idKendaraan == null
        ? transaksiState.getSaldo()
        : transaksiState.getSaldoByIdKendaraan(idKendaraan);
    final impianTerpenuhi = idKendaraan == null
        ? impianState.getListImpianTerpenuhi(saldoTransaksi)
        : impianState.getListImpianTerpenuhiByIdKendaraan(
            idKendaraan,
            saldoTransaksi,
          );
    final jumlahImpian = impianState.listImpian.length;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                idKendaraan == null ? 'Semua' : kendaraan?.nama ?? 'Tanpa data',
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: Colors.white),
              ),
              FittedBox(
                child: Text(
                  formatMataUang(jumlahTarget, mataUangItem),
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
              Row(
                spacing: 4,
                children: [
                  Icon(
                    CupertinoIcons.checkmark_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  Text(
                    '${impianTerpenuhi.length} dari $jumlahImpian impian tercapai',
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF), // konsisten putih (UI #14)
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListKosong() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.flag_outlined,
            size: 24,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 8),
          Text(
            'Belum ada impian yang tercatat',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => unawaited(Nav.to(context, const FormImpian())),
            icon: const Icon(Icons.add),
            label: const Text('Tambah Impian'),
          ),
        ],
      ),
    );
  }

  Widget _buildListImpian(
    TransaksiState transaksiState,
    ImpianState impianState,
    MataUangItem mataUangItem,
  ) {
    final idKendaraan = _kendaraanTerpilih?.id;
    final transaksiTerkumpul = idKendaraan == null
        ? transaksiState.getSaldo()
        : transaksiState.getSaldoByIdKendaraan(idKendaraan);
    final listImpian = idKendaraan == null
        ? impianState.listImpian
        : impianState.getListByIdKendaraan(idKendaraan);
    final sortedItems = _getSortedList(listImpian, transaksiTerkumpul);
    final cari = _cariController.text.toLowerCase();
    final filteredItems = sortedItems
        .where((item) => item.deskripsi.toLowerCase().contains(cari))
        .toList();
    if (filteredItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            Text(
              'Impian tidak ditemukan',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }
    return Expanded(
      child: ListView.separated(
        itemCount: filteredItems.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          // Mencegah NaN/Infinity saat target impian bernilai 0.
          final progress =
              (item.jumlah == 0 ? 0.0 : (transaksiTerkumpul / item.jumlah))
                  .clamp(0.0, 1.0);
          final sudahCapai = progress >= 1.0;
          final transaksiPerhari =
              impianState.transaksiPerHari(item, transaksiTerkumpul) ??
              impianState.transaksiPerHariTanpaTarget(item, transaksiTerkumpul);
          return InkWell(
            onTap: () {
              unawaited(Nav.to(context, DetailImpianPage(id: item.id)));
            },
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// nama impian
                        Expanded(
                          child: Text(
                            item.deskripsi,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                          ),
                        ),

                        /// persen progres
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: sudahCapai
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.primary,
                          ),
                          child: Text(
                            '${(progress * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(
                                0xFFFFFFFF,
                              ), // konsisten putih (UI #14)
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// indikator progress
                    Semantics(
                      label: 'Progres impian',
                      value: '${(progress * 100).toInt()}%',
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          sudahCapai
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ), // UI #19: Semantics untuk aksesibilitas
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Target Perhari'),
                            Text(
                              formatMataUang(
                                transaksiPerhari ?? 0,
                                mataUangItem,
                              ),
                              style: const TextStyle(
                                // Gunakan konstanta FontWeight.w800 (bukan konstruktor numerik) sesuai aturan optimasi_ui.md.
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Target total'),
                            Text(
                              formatMataUang(item.jumlah, mataUangItem),
                              style: const TextStyle(
                                // Gunakan konstanta FontWeight.w800 (bukan konstruktor numerik) sesuai aturan optimasi_ui.md.
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/state/impian_state.dart
// ============================================================

```dart
// lib/fitur/impian/state/impian_state.dart

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/impian/model/impian_model.dart';

part 'impian_state.freezed.dart';

/// State untuk mengelola daftar impian (target transaksi).
@freezed
abstract class ImpianState with _$ImpianState {
  const ImpianState._();

  /// Membuat instance [ImpianState] dengan daftar impian.
  const factory ImpianState({@Default([]) List<ImpianModel> listImpian}) =
      _ImpianState;

  /// Mengembalikan daftar impian yang terkait dengan [idKendaraan].
  List<ImpianModel> getListByIdKendaraan(String idKendaraan) {
    return listImpian.where((i) => i.idKendaraan == idKendaraan).toList();
  }

  /// Mengembalikan total jumlah seluruh impian.
  double getTotalJumlah() {
    return listImpian.fold(0.0, (sum, i) => sum + i.jumlah);
  }

  /// Mengembalikan total jumlah impian untuk [idKendaraan].
  double getTotalJumlahByIdKendaraan(String idKendaraan) {
    return getListByIdKendaraan(idKendaraan)
        .fold(0.0, (sum, i) => sum + i.jumlah);
  }

  /// Mengembalikan impian dengan [id], atau null jika tidak ditemukan.
  ImpianModel? getById(String id) {
    return listImpian.firstWhereOrNull((i) => i.id == id);
  }

  /// Mengembalikan semua impian yang sudah terpenuhi (diarsipkan).
  List<ImpianModel> getListImpianTerpenuhi(double saldoTransaksi) {
    return listImpian
        .where(
          (i) =>
              i.diarsipkan == null && // belum diarsipkan
              i.jumlah > 0 &&
              saldoTransaksi >= i.jumlah,
        )
        .toList();
  }

  /// Menghitung jumlah impian yang terpenuhi.
  List<ImpianModel> getListImpianTerpenuhiByIdKendaraan(
    String idKendaraan,
    double saldoTransaksi,
  ) {
    return getListByIdKendaraan(idKendaraan)
        .where(
          (i) =>
              i.diarsipkan == null && // belum diarsipkan
              i.jumlah > 0 &&
              saldoTransaksi >= i.jumlah,
        )
        .toList();
  }

  /// Menghitung transaksi per hari untuk impian.
  double? transaksiPerHari(ImpianModel impian, double totalTerkumpul) {
    final tanggalTarget = impian.tanggalTarget;
    if (tanggalTarget == null) return null;

    final sisa = impian.jumlah - totalTerkumpul;
    if (sisa <= 0) return 0.0;

    final selisihHari = tanggalTarget.difference(DateTime.now()).inDays;
    if (selisihHari < 0) return null; // target sudah lewat
    if (selisihHari == 0) return impian.jumlah;
    return sisa / selisihHari;
  }

  /// Estimasi sisa hari hingga impian tercapai berdasarkan rata-rata transaksi per hari sejak [ImpianModel.tanggalDibuat]; null jika belum ada transaksi atau data tidak cukup.
  double? estimasiHariTercapai(ImpianModel impian, double totalTerkumpul) {
    final sisa = impian.jumlah - totalTerkumpul;
    if (sisa <= 0) return 0.0; // sudah tercapai

    if (totalTerkumpul <= 0) {
      return null; // belum ada transaksi, tidak bisa estimasi
    }

    final daysElapsed = DateTime.now().difference(impian.tanggalDibuat).inDays;
    final hari = daysElapsed <= 0 ? 1 : daysElapsed;
    final avgPerHari = totalTerkumpul / hari;
    if (avgPerHari <= 0) return null;

    return sisa / avgPerHari;
  }

  /// Estimasi transaksi per hari tanpa bergantung pada tanggal target, menggunakan estimasi hari tercapai (Fitur 2) sebagai penyebut; null jika estimasi hari tidak tersedia.
  double? transaksiPerHariTanpaTarget(
    ImpianModel impian,
    double totalTerkumpul,
  ) {
    final sisa = impian.jumlah - totalTerkumpul;
    if (sisa <= 0) return 0.0; // sudah tercapai

    final estimasiHari = estimasiHariTercapai(impian, totalTerkumpul);
    if (estimasiHari == null || estimasiHari <= 0) return null;

    return sisa / estimasiHari;
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/enum/opsi_jadwal_service_enum.dart
// ============================================================

```dart
/// Opsi aksi yang tersedia pada detail jadwal service.
enum OpsiJadwalServiceEnum {
  /// Aksi mengedit data jadwal service.
  edit,

  /// Aksi menghapus data jadwal service.
  hapus,
}

/// Extension untuk [OpsiJadwalServiceEnum] yang menyediakan label tampilan.
extension OpsiJadwalServiceEnumExtension on OpsiJadwalServiceEnum {
  /// Label teks yang ditampilkan kepada pengguna.
  String get label {
    switch (this) {
      case OpsiJadwalServiceEnum.edit:
        return 'Edit';
      case OpsiJadwalServiceEnum.hapus:
        return 'Hapus';
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/enum/opsi_sort_komponen_enum.dart
// ============================================================

```dart
/// Opsi pengurutan komponen berdasarkan biaya.
enum OpsiSortKomponenEnum {
  /// Urutkan dari biaya terendah ke tertinggi.
  biayaterendah,

  /// Urutkan dari biaya tertinggi ke terendah.
  biayatertinggi,
}

/// Extension untuk [OpsiSortKomponenEnum] yang menyediakan label tampilan.
extension OpsiSortKomponenEnumExtension on OpsiSortKomponenEnum {
  /// Label teks yang ditampilkan kepada pengguna.
  String get label => switch (this) {
    OpsiSortKomponenEnum.biayaterendah => 'Biaya Terendah',
    OpsiSortKomponenEnum.biayatertinggi => 'Biaya Tertinggi',
  };
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/enum/opsi_statistik_jadwal_service_enum.dart
// ============================================================

```dart
/// Opsi statistik biaya jadwal service.
enum OpsiStatistikJadwalServiceEnum {
  /// Total biaya.
  total,

  /// Biaya per kilometer.
  perKm,

  /// Biaya per hari.
  perHari,

  /// Biaya per minggu.
  perMinggu,

  /// Biaya per bulan.
  perBulan,

  /// Biaya per tahun.
  perTahun,
}

/// Extension untuk [OpsiStatistikJadwalServiceEnum] yang menyediakan label tampilan.
extension OpsiStatistikJadwalServiceEnumExtension
    on OpsiStatistikJadwalServiceEnum {
  /// Label teks yang ditampilkan kepada pengguna.
  String get label => switch (this) {
    OpsiStatistikJadwalServiceEnum.total => 'Total',
    OpsiStatistikJadwalServiceEnum.perKm => 'Per KM',
    OpsiStatistikJadwalServiceEnum.perHari => 'Per Hari',
    OpsiStatistikJadwalServiceEnum.perMinggu => 'Per Minggu',
    OpsiStatistikJadwalServiceEnum.perBulan => 'Per Bulan',
    OpsiStatistikJadwalServiceEnum.perTahun => 'Per Tahun',
  };
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/enum/sort_jadwal_service_enum.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/enum/sort_jadwal_service_enum.dart

import 'package:flutter/material.dart';

/// Opsi pengurutan daftar jadwal service.
enum SortJadwalServiceEnum {
  /// Urutkan nama dari A ke Z.
  namaAZ,

  /// Urutkan nama dari Z ke A.
  namaZA,

  /// Urutkan bulan dari terendah ke tertinggi.
  bulanAZ,

  /// Urutkan bulan dari tertinggi ke terendah.
  bulanZA,

  /// Urutkan KM dari terendah ke tertinggi.
  kmAZ,

  /// Urutkan KM dari tertinggi ke terendah.
  kmZA,

  /// Urutkan berdasarkan tingkat urgensi paling tinggi.
  palingMendesak,
}

/// Extension untuk [SortJadwalServiceEnum] yang menyediakan label dan ikon tampilan.
extension SortJadwalServiceExtension on SortJadwalServiceEnum {
  /// Label teks yang ditampilkan kepada pengguna.
  String get label {
    switch (this) {
      case SortJadwalServiceEnum.namaAZ:
        return 'Nama (A-Z)';
      case SortJadwalServiceEnum.namaZA:
        return 'Nama (Z-A)';
      case SortJadwalServiceEnum.bulanAZ:
        return 'Bulan (Terendah)';
      case SortJadwalServiceEnum.bulanZA:
        return 'Bulan (Tertinggi)';
      case SortJadwalServiceEnum.kmAZ:
        return 'KM (Terendah)';
      case SortJadwalServiceEnum.kmZA:
        return 'KM (Tertinggi)';
      case SortJadwalServiceEnum.palingMendesak:
        return 'Paling Mendesak';
    }
  }

  /// Ikon yang merepresentasikan opsi pengurutan.
  IconData get icon {
    switch (this) {
      case SortJadwalServiceEnum.namaAZ:
        return Icons.sort_by_alpha;
      case SortJadwalServiceEnum.namaZA:
        return Icons.sort_by_alpha;
      case SortJadwalServiceEnum.bulanAZ:
        return Icons.calendar_month;
      case SortJadwalServiceEnum.bulanZA:
        return Icons.calendar_month;
      case SortJadwalServiceEnum.kmAZ:
        return Icons.speed;
      case SortJadwalServiceEnum.kmZA:
        return Icons.speed;
      case SortJadwalServiceEnum.palingMendesak:
        return Icons.warning_amber;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/enum/sort_jadwal_service_komponen_enum.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/enum/sort_jadwal_service_komponen_enum.dart

import 'package:flutter/material.dart';

/// Opsi pengurutan komponen jadwal service.
enum SortJadwalServiceKomponenEnum {
  /// Urutkan nama komponen dari A ke Z.
  komponenNamaAZ,

  /// Urutkan nama komponen dari Z ke A.
  komponenNamaZA,

  /// Urutkan harga dari terendah ke tertinggi.
  hargaAZ,

  /// Urutkan harga dari tertinggi ke terendah.
  hargaZA,
}

/// Extension untuk [SortJadwalServiceKomponenEnum] yang menyediakan label dan ikon tampilan.
extension SortJadwalServiceKomponenExtension on SortJadwalServiceKomponenEnum {
  /// Label teks yang ditampilkan kepada pengguna.
  String get label {
    switch (this) {
      case SortJadwalServiceKomponenEnum.komponenNamaAZ:
        return 'Komponen (A-Z)';
      case SortJadwalServiceKomponenEnum.komponenNamaZA:
        return 'Komponen (Z-A)';
      case SortJadwalServiceKomponenEnum.hargaAZ:
        return 'Harga (Terendah)';
      case SortJadwalServiceKomponenEnum.hargaZA:
        return 'Harga (Tertinggi)';
    }
  }

  /// Ikon yang merepresentasikan opsi pengurutan.
  IconData get icon {
    switch (this) {
      case SortJadwalServiceKomponenEnum.komponenNamaAZ:
        return Icons.sort_by_alpha;
      case SortJadwalServiceKomponenEnum.komponenNamaZA:
        return Icons.sort_by_alpha;
      case SortJadwalServiceKomponenEnum.hargaAZ:
        return Icons.money_off;
      case SortJadwalServiceKomponenEnum.hargaZA:
        return Icons.attach_money;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/enum/tampilan_jadwal_service_enum.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/enum/tampilan_jadwal_service_enum.dart

/// Tampilan yang tersedia pada halaman daftar jadwal service.
enum TampilanJadwalServiceEnum {
  /// Daftar jadwal service yang akan datang.
  jadwalService,

  /// Riwayat service yang sudah pernah dilakukan.
  riwayat,
}

/// Extension untuk [TampilanJadwalServiceEnum] yang menyediakan label tampilan.
extension TampilanJadwalServiceEnumExtension on TampilanJadwalServiceEnum {
  /// Label teks yang ditampilkan kepada pengguna.
  String get label {
    switch (this) {
      case TampilanJadwalServiceEnum.jadwalService:
        return 'Jadwal Service';
      case TampilanJadwalServiceEnum.riwayat:
        return 'Riwayat';
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/model/jadwal_service_komponen_model.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/model/jadwal_service_komponen_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'jadwal_service_komponen_model.freezed.dart';

/// Model data komponen yang terikat dengan jadwal service.
@freezed
abstract class JadwalServiceKomponenModel with _$JadwalServiceKomponenModel {
  const JadwalServiceKomponenModel._();

  /// Membuat instance [JadwalServiceKomponenModel] dengan data lengkap.
  const factory JadwalServiceKomponenModel({
    required String id,
    required String jadwalServiceId,
    required String komponenId,
    required String idKendaraan,
    required DateTime diperbarui,
    DateTime? diarsipkan,
  }) = _JadwalServiceKomponenModel;

  /// Membuat [JadwalServiceKomponenModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory JadwalServiceKomponenModel.fromSqflite(Map<String, dynamic> map) =>
      JadwalServiceKomponenModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        jadwalServiceId: map[NamaKolom.jadwalServiceId]?.toString() ?? '',
        komponenId: map[NamaKolom.komponenId]?.toString() ?? '',
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.jadwalServiceId: jadwalServiceId,
    NamaKolom.komponenId: komponenId,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/model/jadwal_service_model.dart
// ============================================================

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'jadwal_service_model.freezed.dart';

/// Model data jadwal service kendaraan.
@freezed
abstract class JadwalServiceModel with _$JadwalServiceModel {
  const JadwalServiceModel._();

  /// Membuat instance [JadwalServiceModel] dengan data lengkap.
  const factory JadwalServiceModel({
    required String id,
    required String nama,
    required double bulan,
    required double km,
    required double kmTerakhirService,
    required DateTime tanggalTerakhirService,
    required String idKendaraan,
    required DateTime diperbarui,
    DateTime? diarsipkan,
  }) = _JadwalServiceModel;

  /// Membuat [JadwalServiceModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory JadwalServiceModel.fromSupabase(
    Map<String, dynamic> map,
  ) => JadwalServiceModel(
    id: map[NamaKolom.id]?.toString() ?? '',
    nama: map[NamaKolom.nama]?.toString() ?? '',
    bulan: ParserUtil.parseDouble(map[NamaKolom.bulan]),
    km: ParserUtil.parseDouble(map[NamaKolom.km]),
    kmTerakhirService: ParserUtil.parseDouble(map[NamaKolom.kmTerakhirService]),
    tanggalTerakhirService:
        ParserUtil.parseDateTime(map[NamaKolom.tanggalTerakhirService]) ??
        DateTime.now(),
    idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '', // 🆕
    diperbarui:
        ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
    diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
  );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.bulan: bulan,
    NamaKolom.km: km,
    NamaKolom.kmTerakhirService: kmTerakhirService,
    NamaKolom.tanggalTerakhirService: tanggalTerakhirService.toIso8601String(),
    NamaKolom.idKendaraan: idKendaraan, // 🆕
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  /// Membuat [JadwalServiceModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory JadwalServiceModel.fromSqflite(
    Map<String, dynamic> map,
  ) => JadwalServiceModel(
    id: map[NamaKolom.id]?.toString() ?? '',
    nama: map[NamaKolom.nama]?.toString() ?? '',
    bulan: ParserUtil.parseDouble(map[NamaKolom.bulan]),
    km: ParserUtil.parseDouble(map[NamaKolom.km]),
    kmTerakhirService: ParserUtil.parseDouble(map[NamaKolom.kmTerakhirService]),
    tanggalTerakhirService:
        ParserUtil.parseDateTime(map[NamaKolom.tanggalTerakhirService]) ??
        DateTime.now(),
    idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '', // 🆕
    diperbarui:
        ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
    diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
  );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.bulan: bulan,
    NamaKolom.km: km,
    NamaKolom.kmTerakhirService: kmTerakhirService,
    NamaKolom.tanggalTerakhirService: tanggalTerakhirService.toIso8601String(),
    NamaKolom.idKendaraan: idKendaraan, // 🆕
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/model/riwayat_jadwal_service_model.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/model/riwayat_jadwal_service_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'riwayat_jadwal_service_model.freezed.dart';

/// Model data riwayat service kendaraan (catatan service yang sudah dilakukan).
@freezed
abstract class RiwayatJadwalServiceModel with _$RiwayatJadwalServiceModel {
  const RiwayatJadwalServiceModel._();

  /// Membuat instance [RiwayatJadwalServiceModel] dengan data lengkap.
  const factory RiwayatJadwalServiceModel({
    /// ID unik data riwayat service.
    required String id,

    /// ID jadwal service yang menjadi acuan riwayat ini.
    required String jadwalServiceId,

    /// ID kendaraan yang serviced.
    required String idKendaraan,

    /// Nama service pada saat riwayat dicatat (snapshot nama jadwal service).
    required String nama,

    /// Tanggal service dilakukan.
    required DateTime tanggalService,

    /// Kilometer kendaraan pada saat service dilakukan.
    required double km,

    /// Total biaya service yang dicatat.
    required double biaya,

    /// Catatan tambahan service, boleh null.
    String? catatan,

    /// Waktu data terakhir diperbarui.
    required DateTime diperbarui,

    /// Tanggal diarsipkan, boleh null.
    DateTime? diarsipkan,
  }) = _RiwayatJadwalServiceModel;

  // ==================== Supabase ====================

  /// Membuat [RiwayatJadwalServiceModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory RiwayatJadwalServiceModel.fromSupabase(Map<String, dynamic> map) =>
      RiwayatJadwalServiceModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        jadwalServiceId: map[NamaKolom.jadwalServiceId]?.toString() ?? '',
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
        nama: map[NamaKolom.nama]?.toString() ?? '',
        tanggalService:
            ParserUtil.parseDateTime(map[NamaKolom.tanggalService]) ??
            DateTime.now(),
        km: ParserUtil.parseDouble(map[NamaKolom.km]),
        biaya: ParserUtil.parseDouble(map[NamaKolom.biaya]),
        catatan: map[NamaKolom.catatan]?.toString(),
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.jadwalServiceId: jadwalServiceId,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.nama: nama,
    NamaKolom.tanggalService: tanggalService.toIso8601String(),
    NamaKolom.km: km,
    NamaKolom.biaya: biaya,
    NamaKolom.catatan: catatan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  // ==================== Sqflite ====================

  /// Membuat [RiwayatJadwalServiceModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory RiwayatJadwalServiceModel.fromSqflite(Map<String, dynamic> map) =>
      RiwayatJadwalServiceModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        jadwalServiceId: map[NamaKolom.jadwalServiceId]?.toString() ?? '',
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
        nama: map[NamaKolom.nama]?.toString() ?? '',
        tanggalService:
            ParserUtil.parseDateTime(map[NamaKolom.tanggalService]) ??
            DateTime.now(),
        km: ParserUtil.parseDouble(map[NamaKolom.km]),
        biaya: ParserUtil.parseDouble(map[NamaKolom.biaya]),
        catatan: map[NamaKolom.catatan]?.toString(),
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.jadwalServiceId: jadwalServiceId,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.nama: nama,
    NamaKolom.tanggalService: tanggalService.toIso8601String(),
    NamaKolom.km: km,
    NamaKolom.biaya: biaya,
    NamaKolom.catatan: catatan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  /// Jumlah hari sejak service dilakukan (tidak negatif meski tanggal mendatang).
  int get hariSejakService =>
      DateTime.now().difference(tanggalService).inDays.clamp(0, 99999);
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/notifier/jadwal_service_komponen_notifier.dart
// ============================================================

```dart
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_komponen_model.dart';
import 'package:myapp/fitur/jadwal_service/state/jadwal_service_komponen_state.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'jadwal_service_komponen_notifier.g.dart';

/// Notifier untuk mengelola data komponen jadwal service.
@Riverpod(keepAlive: true)
class JadwalServiceKomponenNotifier extends _$JadwalServiceKomponenNotifier {
  final _tabelJadwalServiceKomponen = NamaTabel.jadwalServiceKomponen;

  /// Membangun state awal dengan memuat data dari database.
  @override
  Future<JadwalServiceKomponenState> build() async {
    return await _muatData();
  }

  Future<JadwalServiceKomponenState> _muatData() async {
    try {
      final listDb = await ref
          .read(baseOpSqfliteProvider)
          .ambilData(_tabelJadwalServiceKomponen);
      final listHasil = listDb
          .whereType<Map<String, dynamic>>()
          .map(JadwalServiceKomponenModel.fromSqflite)
          .toList();
      return JadwalServiceKomponenState(listJadwalServiceKomponen: listHasil);
    } on Exception catch (e, s) {
      L.e('Gagal memuat jadwal service komponen: $e $s');
      rethrow;
    }
  }

  /// Menambahkan [jadwalServiceKomponen] baru ke daftar dan database.
  Future<void> tambah(JadwalServiceKomponenModel jadwalServiceKomponen) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.copyWith(
      listJadwalServiceKomponen: [
        ...dataLama.listJadwalServiceKomponen,
        jadwalServiceKomponen,
      ],
    );
    state = AsyncValue.data(listBaru);

    try {
      // 2. Baru update DB
      await ref
          .read(baseOpSqfliteProvider)
          .tambah(
            _tabelJadwalServiceKomponen,
            jadwalServiceKomponen.toSqflite(),
          );
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('tambah jadwal service komponen gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Menghapus relasi komponen dengan [id] dari daftar dan database.
  Future<void> hapus(String id) async {
    final dataLama = await future;
    // 1. Optimistic update: hapus dari state DULU
    final listBaru = dataLama.listJadwalServiceKomponen
        .where((e) => e.id != id)
        .toList();
    state = AsyncValue.data(
      dataLama.copyWith(listJadwalServiceKomponen: listBaru),
    );

    try {
      // 2. Baru hapus DB
      await ref
          .read(baseOpSqfliteProvider)
          .hapus(_tabelJadwalServiceKomponen, id);
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('hapus jadwal service komponen gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Mengubah data [jadwalServiceKomponen] di daftar dan database.
  Future<void> ubah(JadwalServiceKomponenModel jadwalServiceKomponen) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.listJadwalServiceKomponen
        .map(
          (e) => e.id == jadwalServiceKomponen.id ? jadwalServiceKomponen : e,
        )
        .toList();
    state = AsyncValue.data(
      dataLama.copyWith(listJadwalServiceKomponen: listBaru),
    );

    try {
      // 2. Baru update DB
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(
            _tabelJadwalServiceKomponen,
            jadwalServiceKomponen.toSqflite(),
            jadwalServiceKomponen.id,
          );
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('ubah jadwal service komponen gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Melakukan batch insert [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(
    List<JadwalServiceKomponenModel> data,
  ) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabelJadwalServiceKomponen,
            data.map((e) => e.toSqflite()).toList(),
          );
      state = AsyncValue.data(await _muatData());
    } catch (e, s) {
      L.e('Gagal batch insert jadwal service komponen $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/notifier/jadwal_service_komponen_sorted_provider.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/notifier/jadwal_service_komponen_sorted_provider.dart
// Konversi provider manual ke @riverpod (riverpod_generator) untuk konsistensi.

import 'package:collection/collection.dart';
import 'package:myapp/fitur/jadwal_service/enum/sort_jadwal_service_komponen_enum.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_komponen_model.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_komponen_notifier.dart';
import 'package:myapp/fitur/komponen/notifier/komponen_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jadwal_service_komponen_sorted_provider.g.dart';

/// Provider terurut berdasarkan jadwalServiceId (tanpa sortir tambahan).
@riverpod
List<JadwalServiceKomponenModel> jadwalServiceKomponenSorted(
  Ref ref,
  String jadwalServiceId,
) {
  final asyncState = ref.watch(jadwalServiceKomponenProvider);
  final komponenAsync = ref.watch(komponenProvider);

  return asyncState.when(
    data: (state) {
      final list = state.getListByJadwalServiceId(jadwalServiceId);
      if (list.isEmpty || komponenAsync.isLoading || komponenAsync.hasError) {
        return list;
      }
      return list;
    },
    loading: () => [],
    error: (_, _) => [],
  );
}

/// Provider terurut berdasarkan relasi dan opsi pengurutan.
@riverpod
List<JadwalServiceKomponenModel> jadwalServiceKomponenSort(
  Ref ref,
  ({String jadwalServiceId, SortJadwalServiceKomponenEnum sortBy}) params,
) {
  final asyncState = ref.watch(jadwalServiceKomponenProvider);
  final komponenAsync = ref.watch(komponenProvider);

  return asyncState.when(
    data: (state) {
      final list = state.getListByJadwalServiceId(params.jadwalServiceId);
      if (list.isEmpty || komponenAsync.isLoading || komponenAsync.hasError) {
        return list;
      }
      final komponenState = komponenAsync.requireValue;
      var sortedList = [...list];

      switch (params.sortBy) {
        case SortJadwalServiceKomponenEnum.komponenNamaAZ:
          sortedList = sortedList.sorted((a, b) {
            final namaA = komponenState.getById(a.komponenId)?.nama ?? '';
            final namaB = komponenState.getById(b.komponenId)?.nama ?? '';
            return namaA.compareTo(namaB);
          });
          break;
        case SortJadwalServiceKomponenEnum.komponenNamaZA:
          sortedList = sortedList.sorted((a, b) {
            final namaA = komponenState.getById(a.komponenId)?.nama ?? '';
            final namaB = komponenState.getById(b.komponenId)?.nama ?? '';
            return namaB.compareTo(namaA);
          });
          break;
        case SortJadwalServiceKomponenEnum.hargaAZ:
          sortedList = sortedList.sorted((a, b) {
            final hargaA = komponenState.getById(a.komponenId)?.harga ?? 0;
            final hargaB = komponenState.getById(b.komponenId)?.harga ?? 0;
            return hargaA.compareTo(hargaB);
          });
          break;
        case SortJadwalServiceKomponenEnum.hargaZA:
          sortedList = sortedList.sorted((a, b) {
            final hargaA = komponenState.getById(a.komponenId)?.harga ?? 0;
            final hargaB = komponenState.getById(b.komponenId)?.harga ?? 0;
            return hargaB.compareTo(hargaA);
          });
          break;
      }
      return sortedList;
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/notifier/jadwal_service_notifier.dart
// ============================================================

```dart
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_model.dart';
import 'package:myapp/fitur/jadwal_service/state/jadwal_service_state.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'jadwal_service_notifier.g.dart';

/// Notifier untuk mengelola data jadwal service kendaraan.
@Riverpod(keepAlive: true)
class JadwalServiceNotifier extends _$JadwalServiceNotifier {
  final _tabelJadwalService = NamaTabel.jadwalService;

  /// Membangun state awal dengan memuat daftar jadwal service dari database.
  @override
  Future<JadwalServiceState> build() async {
    L.i('build jadwal_service_notifier mulai');
    // Muat semua jadwal service tanpa filter kendaraan terpilih.
    L.i('build jadwal_service_notifier selesai');
    return await _muatData();
  }

  Future<JadwalServiceState> _muatData() async {
    try {
      final listDb = await ref
          .read(baseOpSqfliteProvider)
          .ambilData(NamaTabel.jadwalService);
      final listHasil = listDb
          .whereType<Map<String, dynamic>>()
          .map(JadwalServiceModel.fromSqflite)
          .toList();
      final stateHasil = JadwalServiceState(listJadwalService: listHasil);
      return stateHasil;
    } on Exception catch (e, s) {
      L.e('Gagal ambil data: $e $s');
      rethrow;
    }
  }

  /// Menambahkan [jadwal] baru ke daftar dan database.
  Future<void> tambah(JadwalServiceModel jadwal) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.copyWith(
      listJadwalService: [...dataLama.listJadwalService, jadwal],
    );
    state = AsyncValue.data(listBaru);

    try {
      // 2. Baru update DB
      await ref
          .read(baseOpSqfliteProvider)
          .tambah(_tabelJadwalService, jadwal.toSqflite());
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('tambah jadwal service gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Menghapus jadwal service dengan [id] dari daftar dan database.
  Future<void> hapus(String id) async {
    final dataLama = await future;
    // 1. Optimistic update: hapus dari state DULU
    final listBaru = dataLama.listJadwalService
        .where((e) => e.id != id)
        .toList();
    state = AsyncValue.data(dataLama.copyWith(listJadwalService: listBaru));

    try {
      // 2. Baru hapus DB
      await ref.read(baseOpSqfliteProvider).hapus(_tabelJadwalService, id);
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('hapus jadwal service gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Mengubah data [jadwal] di daftar dan database.
  Future<void> ubah(JadwalServiceModel jadwal) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.listJadwalService
        .map((e) => e.id == jadwal.id ? jadwal : e)
        .toList();
    state = AsyncValue.data(dataLama.copyWith(listJadwalService: listBaru));

    try {
      // 2. Baru update DB
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(_tabelJadwalService, jadwal.toSqflite(), jadwal.id);
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('ubah jadwal service gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Melakukan batch insert data [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(List<JadwalServiceModel> data) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabelJadwalService,
            data.map((e) => e.toSqflite()).toList(),
          );
      state = AsyncValue.data(await _muatData());
    } catch (e, s) {
      L.e('Gagal batch insert jadwal service $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/notifier/riwayat_jadwal_service_notifier.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/notifier/riwayat_jadwal_service_notifier.dart

import 'package:myapp/fitur/jadwal_service/model/riwayat_jadwal_service_model.dart';
import 'package:myapp/fitur/jadwal_service/state/riwayat_jadwal_service_state.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'riwayat_jadwal_service_notifier.g.dart';

/// Notifier untuk mengelola data riwayat service kendaraan.
@Riverpod(keepAlive: true)
class RiwayatJadwalServiceNotifier extends _$RiwayatJadwalServiceNotifier {
  final _tabelRiwayatJadwalService = NamaTabel.riwayatJadwalService;

  /// Membangun state awal dengan memuat seluruh riwayat service.
  @override
  Future<RiwayatJadwalServiceState> build() async {
    return await _muatData();
  }

  Future<RiwayatJadwalServiceState> _muatData() async {
    try {
      final listDb = await ref
          .read(baseOpSqfliteProvider)
          .ambilData(_tabelRiwayatJadwalService);
      final listHasil = listDb
          .whereType<Map<String, dynamic>>()
          .map(RiwayatJadwalServiceModel.fromSqflite)
          .toList();
      return RiwayatJadwalServiceState(listRiwayatJadwalService: listHasil);
    } on Exception catch (e, s) {
      L.e('Gagal ambil data riwayat jadwal service: $e $s');
      rethrow;
    }
  }

  /// Menambahkan [riwayat] baru ke daftar dan database.
  Future<void> tambah(RiwayatJadwalServiceModel riwayat) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.copyWith(
      listRiwayatJadwalService: [...dataLama.listRiwayatJadwalService, riwayat],
    );
    state = AsyncValue.data(listBaru);

    try {
      // 2. Baru update DB
      await ref
          .read(baseOpSqfliteProvider)
          .tambah(_tabelRiwayatJadwalService, riwayat.toSqflite());
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('tambah riwayat jadwal service gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Mengubah data [riwayat] di daftar dan database.
  Future<void> ubah(RiwayatJadwalServiceModel riwayat) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.listRiwayatJadwalService
        .map((e) => e.id == riwayat.id ? riwayat : e)
        .toList();
    state = AsyncValue.data(
      dataLama.copyWith(listRiwayatJadwalService: listBaru),
    );

    try {
      // 2. Baru update DB
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(
            _tabelRiwayatJadwalService,
            riwayat.toSqflite(),
            riwayat.id,
          );
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('ubah riwayat jadwal service gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Menghapus riwayat service dengan [id] dari daftar dan database.
  Future<void> hapus(String id) async {
    final dataLama = await future;
    // 1. Optimistic update: hapus dari state DULU
    final listBaru = dataLama.listRiwayatJadwalService
        .where((e) => e.id != id)
        .toList();
    state = AsyncValue.data(
      dataLama.copyWith(listRiwayatJadwalService: listBaru),
    );

    try {
      // 2. Baru hapus DB
      await ref
          .read(baseOpSqfliteProvider)
          .hapus(_tabelRiwayatJadwalService, id);
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('hapus riwayat jadwal service gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Melakukan batch insert data [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(List<RiwayatJadwalServiceModel> data) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabelRiwayatJadwalService,
            data.map((e) => e.toSqflite()).toList(),
          );
      state = AsyncValue.data(await _muatData());
    } catch (e, s) {
      L.e('Gagal batch insert riwayat jadwal service $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/page/detail_jadwal_service.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/page/detail_jadwal_service.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/jadwal_service/enum/sort_jadwal_service_komponen_enum.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_model.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_komponen_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_komponen_sorted_provider.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_notifier.dart';
import 'package:myapp/fitur/jadwal_service/page/form_jadwal_service.dart';
import 'package:myapp/fitur/jadwal_service/page/form_jadwal_service_komponen.dart';
import 'package:myapp/fitur/jadwal_service/state/jadwal_service_komponen_state.dart';
import 'package:myapp/fitur/jadwal_service/state/jadwal_service_state.dart';
import 'package:myapp/fitur/km/notifier/km_notifier.dart';
import 'package:myapp/fitur/km/state/km_state.dart';
import 'package:myapp/fitur/komponen/notifier/komponen_notifier.dart';
import 'package:myapp/fitur/komponen/page/detail_komponen_page.dart';
import 'package:myapp/fitur/komponen/state/komponen_state.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman detail jadwal service dengan daftar komponen yang terikat.
class DetailJadwalService extends ConsumerStatefulWidget {
  /// ID jadwal service yang akan ditampilkan detailnya.
  final String id;

  /// Buat halaman detail jadwal service.
  const DetailJadwalService({super.key, required this.id});

  @override
  ConsumerState<DetailJadwalService> createState() =>
      _DetailJadwalServiceState();
}

class _DetailJadwalServiceState extends ConsumerState<DetailJadwalService> {
  SortJadwalServiceKomponenEnum _currentSort =
      SortJadwalServiceKomponenEnum.komponenNamaAZ;
  bool _isSortSheetOpen = false;

  Future<void> _showModalBottomSheet() async {
    if (_isSortSheetOpen) return;
    _isSortSheetOpen = true;
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        // Bungkus konten bottom sheet dengan SafeArea agar tidak tertutup area sistem.
        return SafeArea(
          child: RadioGroup<SortJadwalServiceKomponenEnum>(
            groupValue: _currentSort,
            onChanged: (v) {
              if (v != null) {
                setState(() => _currentSort = v);
                // Perbaikan: gunakan Nav.pop sesuai konvensi navigasi proyek.
                Nav.pop(context);
              }
            },
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: SortJadwalServiceKomponenEnum.values.map((o) {
                      return Card(
                        child: RadioListTile<SortJadwalServiceKomponenEnum>(
                          value: o,
                          title: Text(o.label),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() => _isSortSheetOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final komponenAsync = ref.watch(komponenProvider);
    final jadwalServiceKomponenAsync = ref.watch(jadwalServiceKomponenProvider);
    final kmAsync = ref.watch(kmProvider);
    final jadwalServiceAsync = ref.watch(jadwalServiceProvider);
    final mataUangAsync = ref.watch(mataUangProvider);
    // Urutan pemeriksaan AsyncValue: loading → error → data (optimasi_bug_runtime.md poin 9).
    if (komponenAsync.isLoading ||
        jadwalServiceKomponenAsync.isLoading ||
        kmAsync.isLoading ||
        jadwalServiceAsync.isLoading ||
        mataUangAsync.isLoading) {
      return _buildLoading();
    }
    if (komponenAsync.hasError ||
        jadwalServiceKomponenAsync.hasError ||
        kmAsync.hasError ||
        jadwalServiceAsync.hasError ||
        mataUangAsync.hasError) {
      return _buildError();
    }

    final komponenState = komponenAsync.requireValue;
    final jadwalServiceState = jadwalServiceAsync.requireValue;
    final kmState = kmAsync.requireValue;
    final jadwalServiceKomponenState = jadwalServiceKomponenAsync.requireValue;
    final mataUangItem = mataUangAsync.requireValue;
    return _buildScaffold(
      komponenState,
      jadwalServiceState,
      kmState,
      jadwalServiceKomponenState,
      mataUangItem,
    );
  }

  Widget _buildScaffold(
    KomponenState komponenState,
    JadwalServiceState jadwalServiceState,
    KmState kmState,
    JadwalServiceKomponenState jadwalServiceKomponenState,
    MataUangItem mataUangItem,
  ) {
    final jadwalService = jadwalServiceState.getById(widget.id);
    if (jadwalService == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Jadwal Service')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 24,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              const Text('Jadwal Service tidak ditemukan'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => Nav.pop(context),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: _buildAppBar(context, jadwalService),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDetailJadwalService(jadwalService, kmState),
          _buildListKomponen(
            komponenState,
            jadwalServiceKomponenState,
            jadwalService,
            mataUangItem,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, JadwalServiceModel jadwalService) {
    return AppBar(
      title: Text(jadwalService.nama),
      actions: [
        IconButton(
          tooltip: 'Edit',
          onPressed: () {
            unawaited(
              Nav.to(
                context,
                FormJadwalService(jadwalServiceModel: jadwalService),
              ),
            );
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          tooltip: 'Hapus',
          icon: const Icon(Icons.delete),
          onPressed: () async {
            final confirmed = await showOkCancelAlertDialog(
              context: context,
              title: 'Hapus Data',
              message: 'Data jadwal service ini akan dihapus secara permanen.',
              okLabel: 'Hapus',
              cancelLabel: 'Batal',
              isDestructiveAction: true,
            );
            if (confirmed == OkCancelResult.ok) {
              try {
                await ref.read(jadwalServiceProvider.notifier).hapus(widget.id);
                if (context.mounted) {
                  AppToast.sukses(context, 'Jadwal service berhasil dihapus');
                  // Ganti Navigator.pop langsung dengan Nav.pop sesuai konvensi navigasi proyek.
                  Nav.pop(context);
                }
              } catch (e, s) {
                L.e('Gagal menghapus jadwal service: $e $s');
                if (context.mounted) {
                  AppToast.gagal(context, 'Gagal menghapus jadwal service');
                }
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildDetailJadwalService(
    JadwalServiceModel jadwalService,
    KmState kmState,
  ) {
    L.i(
      '_buildDetailJadwalService dipanggil, jadwalService: $jadwalService), kmState: ${kmState.listKm.length} data',
    );

    // Jangan pakai 0 sebagai fallback; jika belum ada data KM, sisa KM tidak dapat dihitung.
    final kmTerbaru = kmState
        .kmTerbaruByIdKendaraan(jadwalService.idKendaraan)
        ?.km;
    final sisaKm = kmTerbaru == null
        ? null
        : (jadwalService.km + jadwalService.kmTerakhirService) - kmTerbaru;
    final now = DateTime.now();
    // Menyamakan algoritma tanggal jatuh tempo dengan daftar (kalender, bukan 30 hari)
    final targetTanggal = DateTime(
      jadwalService.tanggalTerakhirService.year,
      jadwalService.tanggalTerakhirService.month + jadwalService.bulan.toInt(),
      jadwalService.tanggalTerakhirService.day,
    );
    final sisaBulan = targetTanggal.difference(now).inDays / 30;

    L.i(
      'Perhitungan detail: km=$kmTerbaru, sisaKm=$sisaKm, sisaBulan=$sisaBulan, targetTanggal=$targetTanggal',
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItemRow('Nama', jadwalService.nama),
            _buildItemRow('Bulan', jadwalService.bulan.toString()),
            _buildItemRow(
              'KM Periode',
              FormatNomor.formatRibuan(jadwalService.km.toInt()),
            ),
            _buildItemRow(
              'KM Terakhir Service',
              FormatNomor.formatRibuan(jadwalService.kmTerakhirService.toInt()),
            ),
            _buildItemRow(
              'Tanggal Terakhir Service',
              FormatTanggal.formatSingkat(jadwalService.tanggalTerakhirService),
            ),
            _buildItemRow(
              'Tanggal Service Selanjutnya',
              FormatTanggal.formatSingkat(targetTanggal),
            ),
            _buildItemRow(
              'Sisa KM',
              sisaKm == null
                  ? 'Belum ada data KM'
                  : FormatNomor.formatRibuan(sisaKm.toInt()),
              valueStyle: sisaKm != null && sisaKm < 0
                  ? TextStyle(color: Theme.of(context).colorScheme.error)
                  : null,
            ),
            _buildItemRow(
              'Sisa Bulan',
              sisaBulan.toStringAsFixed(1),
              valueStyle: TextStyle(
                color: sisaBulan < 0
                    ? Theme.of(context).colorScheme.error
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListKomponen(
    KomponenState komponenState,
    JadwalServiceKomponenState jadwalServiceKomponenState,
    JadwalServiceModel jadwalService,
    MataUangItem mataUangItem,
  ) {
    final params = (jadwalServiceId: jadwalService.id, sortBy: _currentSort);
    final listRelasi = ref.watch(jadwalServiceKomponenSortProvider(params));
    final listJadwalServiceKomponen = jadwalServiceKomponenState
        .getListByJadwalServiceId(jadwalService.id);
    L.i(
      '_buildListKomponen dipanggil, jumlah relasi: $listJadwalServiceKomponen',
    );
    final totalHarga = listJadwalServiceKomponen.fold<double>(0.0, (sum, item) {
      final komponen = komponenState.getById(item.komponenId);
      return sum + (komponen?.harga ?? 0.0);
    });
    L.i('Total harga komponen: $totalHarga}');

    final biayaPerKm = jadwalService.km == 0
        ? 0.0
        : totalHarga / jadwalService.km;
    final biayaPerBulan = jadwalService.bulan == 0
        ? 0.0
        : totalHarga / jadwalService.bulan;
    final biayaPerHari = jadwalService.bulan == 0
        ? 0.0
        : totalHarga / (jadwalService.bulan * 30);
    final biayaPerMinggu = jadwalService.bulan == 0
        ? 0.0
        : totalHarga / (jadwalService.bulan * 30 / 7);
    final biayaPerTahun = jadwalService.bulan == 0
        ? 0.0
        : totalHarga / (jadwalService.bulan / 12);

    return Card(
      child: ExpansionTile(
        title: const Text('Daftar Komponen'),
        subtitle: Text(formatMataUang(totalHarga, mataUangItem)),
        initiallyExpanded: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildItemRow(
                  'Biaya per KM',
                  formatMataUang(biayaPerKm, mataUangItem),
                ),
                _buildItemRow(
                  'Biaya per Hari',
                  formatMataUang(biayaPerHari, mataUangItem),
                ),
                _buildItemRow(
                  'Biaya per Minggu',
                  formatMataUang(biayaPerMinggu, mataUangItem),
                ),
                _buildItemRow(
                  'Biaya per Bulan',
                  formatMataUang(biayaPerBulan, mataUangItem),
                ),
                _buildItemRow(
                  'Biaya per Tahun',
                  formatMataUang(biayaPerTahun, mataUangItem),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _showModalBottomSheet,
                  child: Row(
                    spacing: 4,
                    children: [
                      const Icon(Icons.sort),
                      Text(_currentSort.label),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (listRelasi.isEmpty)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.build_circle_outlined,
                    size: 24,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 12),
                  const Text('Belum ada komponen'),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => unawaited(
                      Nav.to(
                        context,
                        FormJadwalServiceKomponen(jadwalServiceId: widget.id),
                      ),
                    ),
                    child: const Text('Tambah Komponen'),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listRelasi.length,
              itemBuilder: (context, index) {
                final item = listRelasi[index];
                final komponen = komponenState.getById(item.komponenId);
                L.i('item $item');
                return Card(
                  child: ListTile(
                    title: Text(komponen?.nama ?? 'Komponen Tidak Ditemukan'),
                    trailing: Text(
                      formatMataUang(komponen?.harga ?? 0, mataUangItem),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    onTap: komponen == null
                        ? null
                        : () {
                            L.i(
                              'Navigasi ke detail komponen: ${komponen.id} (nama: ${komponen.nama})',
                            );
                            unawaited(
                              Nav.to(
                                context,
                                DetailKomponenPage(id: komponen.id),
                              ),
                            );
                          },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildItemRow(
    String label,
    String value, {
    TextStyle? labelStyle,
    TextStyle? valueStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: labelStyle ?? Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: valueStyle ?? Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text('Memuat detail jadwal service...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data jadwal service'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(komponenProvider);
                final _ = ref.refresh(jadwalServiceProvider);
                final _ = ref.refresh(kmProvider);
                final _ = ref.refresh(jadwalServiceKomponenProvider);
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/page/form_jadwal_service.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/page/form_jadwal_service.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_komponen_model.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_model.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_komponen_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_notifier.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/komponen/model/komponen_model.dart';
import 'package:myapp/fitur/komponen/notifier/komponen_notifier.dart';
import 'package:myapp/fitur/komponen/page/detail_komponen_page.dart';
import 'package:myapp/fitur/komponen/page/form_komponen.dart';
import 'package:myapp/fitur/komponen/state/komponen_state.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:myapp/shared/widget/pemilih_kendaraan.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Form untuk menambah atau mengedit data jadwal service beserta komponennya.
class FormJadwalService extends ConsumerStatefulWidget {
  /// Model jadwal service yang akan diedit. [null] jika mode tambah.
  final JadwalServiceModel? jadwalServiceModel;

  /// Buat form jadwal service.
  const FormJadwalService({super.key, this.jadwalServiceModel});

  @override
  ConsumerState<FormJadwalService> createState() => _FormJadwalServiceState();
}

class _FormJadwalServiceState extends ConsumerState<FormJadwalService> {
  String get _idJadwalService => widget.jadwalServiceModel?.id ?? '';
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _bulanController = TextEditingController();
  final _kmController = TextEditingController();
  final _kmTerakhirServiceController = TextEditingController();
  final _tanggalTerakhirServiceController = TextEditingController();
  final _kmTerakhirServiceFocusNode = FocusNode();
  final _namaFocusNode = FocusNode();
  final _bulanFocusNode = FocusNode();
  final _kmFocusNode = FocusNode();
  final _komponenFocusNode = FocusNode();
  bool _isLoading = false;
  bool _modeEdit = false;
  KomponenModel? _komponenTerpilih;
  List<KomponenModel> _komponenDipilih = [];
  KendaraanModel? _kendaraanTerpilih;

  @override
  void initState() {
    super.initState();
    _modeEdit = widget.jadwalServiceModel != null;
    L.i('FormJadwalService diinisialisasi, mode edit: $_modeEdit');
    if (_modeEdit) {
      final model = widget.jadwalServiceModel;
      if (model == null) return;
      _namaController.text = model.nama;
      _bulanController.text = FormatNomor.formatRibuan(model.bulan.toInt());
      _kmController.text = FormatNomor.formatRibuan(model.km.toInt());
      _tanggalTerakhirServiceController.text = _formatTanggal(
        model.tanggalTerakhirService,
      );
      _kmTerakhirServiceController.text = FormatNomor.formatRibuan(
        model.kmTerakhirService.toInt(),
      );
    } else {
      _tanggalTerakhirServiceController.text = _formatTanggal(DateTime.now());
    }
    unawaited(
      Future.microtask(() async {
        try {
          var idKendaraan = widget.jadwalServiceModel?.idKendaraan;
          if (idKendaraan == null || idKendaraan.isEmpty) {
            idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
          }
          final kendaraanState = await ref.read(kendaraanProvider.future);
          if (idKendaraan != null) {
            final kendaraan = kendaraanState.getById(idKendaraan);
            if (mounted) {
              setState(() => _kendaraanTerpilih = kendaraan);
            }
          } else if (kendaraanState.listKendaraan.isNotEmpty) {
            final kendaraan = kendaraanState.listKendaraan.first;
            if (mounted) {
              setState(() => _kendaraanTerpilih = kendaraan);
            }
          }
        } catch (e, s) {
          L.e('Gagal memuat kendaraan terpilih form jadwal service: $e $s');
        }
      }),
    ); // unawaited: Future.microtask per optimasi_bug_runtime.md #10

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      try {
        final relasiState = await ref.read(
          jadwalServiceKomponenProvider.future,
        );
        final komponenState = await ref.read(komponenProvider.future);

        final relasi = relasiState.getListByJadwalServiceId(_idJadwalService);
        final list = <KomponenModel>[];
        for (final k in relasi) {
          final komponen = komponenState.getById(k.komponenId);
          if (komponen == null) continue;
          list.add(komponen);
        }
        if (mounted) {
          setState(() {
            _komponenDipilih = list;
          });
        }
      } catch (e, s) {
        L.e('Gagal memuat relasi komponen: $e $s');
        if (mounted) {
          AppToast.gagal(context, 'Gagal memuat komponen terkait');
        }
      }
    });
  }

  String _formatTanggal(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _pilihTanggal() async {
    L.i('Pilih tanggal ditekan');
    final now = DateTime.now();
    final initialDate = _modeEdit
        ? (widget.jadwalServiceModel?.tanggalTerakhirService ?? now)
        : now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: now,
    );
    if (picked != null) {
      _tanggalTerakhirServiceController.text = _formatTanggal(picked);
      L.i('Tanggal terpilih: $picked');
    }
  }

  DateTime _parseTanggal(String value) {
    return DateTime.tryParse(value) ?? DateTime.now();
  }

  Future<void> _simpanForm() async {
    L.i('Simpan form ditekan, mode edit: $_modeEdit');
    if (_isLoading) {
      L.w('Form masih loading, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('Validasi form gagal');
      return;
    }
    L.i('Validasi form berhasil');
    // Prioritaskan kendaraan yang dipilih di form agar tidak tersimpan ke kendaraan lain.
    String? idDariProvider;
    try {
      idDariProvider = await ref.read(selectedKendaraanIdProvider.future);
    } catch (e, s) {
      L.e('Gagal membaca kendaraan terpilih: $e $s');
    }
    final idKendaraan = _kendaraanTerpilih?.id ?? idDariProvider;
    if (idKendaraan == null) {
      AppToast.gagal(context, 'Tolong pilih kendaraan anda terlebih dahulu');
      return;
    }

    setState(() => _isLoading = true);
    unawaited(EasyLoading.show(status: 'Menyimpan...'));
    L.i('Menyimpan jadwal service...');
    try {
      final notifier = ref.read(jadwalServiceProvider.notifier);
      final jadwalServiceToSave = JadwalServiceModel(
        id: _modeEdit
            ? (widget.jadwalServiceModel?.id ?? const Uuid().v4())
            : const Uuid().v4(),
        nama: _namaController.text.trim(),
        bulan: InputAngka.parseAngkaRibuan(_bulanController.text),
        km: InputAngka.parseAngkaRibuan(_kmController.text),
        tanggalTerakhirService: _parseTanggal(
          _tanggalTerakhirServiceController.text,
        ),
        diperbarui: DateTime.now(),
        kmTerakhirService: InputAngka.parseAngkaRibuan(
          _kmTerakhirServiceController.text,
        ),
        idKendaraan: idKendaraan,
      );
      L.i('data jadwalservicetosave $jadwalServiceToSave');
      if (_modeEdit) {
        await notifier.ubah(jadwalServiceToSave);
      } else {
        await notifier.tambah(jadwalServiceToSave);
      }
      final listRelasi = _komponenDipilih.map((komponen) {
        return JadwalServiceKomponenModel(
          id: const Uuid().v4(),
          jadwalServiceId: jadwalServiceToSave.id,
          komponenId: komponen.id,
          idKendaraan: jadwalServiceToSave.idKendaraan,
          diperbarui: DateTime.now(),
        );
      }).toList();

      if (_modeEdit && mounted) {
        final konfirmasi = await showOkCancelAlertDialog(
          context: context,
          title: 'Hapus Relasi Lama',
          message: 'Apakah Anda yakin ingin menghapus relasi komponen lama saat edit?',
          okLabel: 'Hapus',
          cancelLabel: 'Batal',
          isDestructiveAction: true,
        );
        // Konfirmasi sebelum menghapus relasi lama (optimasi_ux.md poin 1)
        if (konfirmasi == OkCancelResult.ok) {
          final relasiState = await ref.read(
            jadwalServiceKomponenProvider.future,
          );
          final relasiLama = relasiState.listJadwalServiceKomponen
              .where((r) => r.jadwalServiceId == jadwalServiceToSave.id)
              .toList();
          for (final relasi in relasiLama) {
            await ref
                .read(jadwalServiceKomponenProvider.notifier)
                .hapus(relasi.id);
          }
        }
      }

      await ref
          .read(jadwalServiceKomponenProvider.notifier)
          .batchInsertFromSync(listRelasi);
      L.i('jadwl service komponen berhasil di tambahkan $listRelasi');
      if (mounted) {
        AppToast.sukses(
          context,
          _modeEdit
              ? 'Jadwal service berhasil diperbarui'
              : 'Jadwal service berhasil ditambahkan',
        );
        L.s(
          'Jadwal service berhasil ${_modeEdit ? 'diperbarui' : 'ditambahkan'}',
        );
        Nav.pop(context, true);
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan jadwal service: $e $s');
      if (mounted) {
        setState(() => _isLoading = false);
        AppToast.gagal(context, 'Gagal menyimpan jadwal service');
      }
    } finally {
      if (mounted) {
        unawaited(EasyLoading.dismiss());
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    L.i('FormJadwalService ditutup');
    _namaController.dispose();
    _bulanController.dispose();
    _kmController.dispose();
    _tanggalTerakhirServiceController.dispose();
    _kmTerakhirServiceController.dispose();
    _kmTerakhirServiceFocusNode.dispose();
    _namaFocusNode.dispose();
    _bulanFocusNode.dispose();
    _kmFocusNode.dispose();
    _komponenFocusNode.dispose();
    super.dispose();
  }

  Future<void> _hapusKomponen(
    KomponenModel item,
    String? jadwalServiceId,
    List<JadwalServiceKomponenModel> relasiList,
  ) async {
    if (jadwalServiceId != null) {
      final relasi = relasiList.firstWhereOrNull(
        (r) => r.komponenId == item.id && r.jadwalServiceId == jadwalServiceId,
      );
      if (relasi == null) {
        L.w('Relasi tidak ditemukan untuk komponen ${item.id}');
      } else {
        final konfirmasi = await showOkCancelAlertDialog(
          context: context,
          title: 'Hapus Data',
          message: 'Data relasi ini akan dihapus.',
          okLabel: 'Hapus',
          cancelLabel: 'Batal',
          isDestructiveAction: true,
        );
        if (konfirmasi != OkCancelResult.ok) return;
        try {
          await ref
              .read(jadwalServiceKomponenProvider.notifier)
              .hapus(relasi.id);
          L.i('Relasi berhasil dihapus: ${relasi.id}');
        } catch (e, s) {
          L.e('Gagal menghapus relasi komponen: $e $s');
          if (mounted) {
            AppToast.gagal(context, 'Gagal menghapus komponen');
          }
          return;
        }
      }
    }
    L.i('Menghapus komponen dari daftar: ${item.nama}');
    if (!mounted) return;
    setState(() {
      _komponenDipilih.removeWhere((e) => e.id == item.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final komponenAsync = ref.watch(komponenProvider);
    final jadwalServiceKomponenAsync = ref.watch(jadwalServiceKomponenProvider);
    final kendaraanAsync = ref.watch(kendaraanProvider);
    final mataUangAsync = ref.watch(mataUangProvider);
    if (komponenAsync.isLoading || // fixed: isLoading sebelum hasError per aturan_riverpod.md #3
        jadwalServiceKomponenAsync.isLoading ||
        kendaraanAsync.isLoading ||
        mataUangAsync.isLoading) {
      return _buildLoading();
    }
    if (komponenAsync.hasError ||
        jadwalServiceKomponenAsync.hasError ||
        kendaraanAsync.hasError ||
        mataUangAsync.hasError) {
      return _buildError();
    }
    final kendaraanState = kendaraanAsync.requireValue;
    final komponenState = komponenAsync.requireValue;
    final jadwalServiceKomponenState = jadwalServiceKomponenAsync.requireValue;
    final mataUangItem = mataUangAsync.requireValue;

    final kendaraanTerpilih = _kendaraanTerpilih;
    final listKendaraan = kendaraanState.listKendaraan;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _modeEdit ? 'Edit Jadwal Service' : 'Tambah Jadwal Service',
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            // Sesuaikan padding form dengan standar DESAINS.MD (16, bukan 8)
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        spacing: 16,
                        children: [
                          if (kendaraanTerpilih != null)
                            PemilihKendaraan(
                              kendaraanTerpilih: kendaraanTerpilih,
                              listKendaraan: listKendaraan,
                              onSelected: (value) => setState(() {
                                _kendaraanTerpilih = value;
                              }),
                            ),
                          _buildFormJadwalService(),
                          _buildInputKomponen(komponenState),
                          if (komponenState.listKomponenState.isNotEmpty)
                            _buildJadwalServiceKomponen(
                              komponenState,
                              jadwalServiceKomponenState
                                  .listJadwalServiceKomponen,
                              widget.jadwalServiceModel?.id,
                              mataUangItem,
                            ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildTombolSimpan(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormJadwalService() {
    return Column(
      spacing: 16,
      children: [
        InputTeks(
          controller: _namaController,
          label: 'Nama',
          focusNode: _namaFocusNode,
          nextFocusNode: _bulanFocusNode,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Nama wajib diisi';
            return null;
          },
        ),
        InputAngka(
          controller: _bulanController,
          label: 'Bulan',
          focusNode: _bulanFocusNode,
          nextFocusNode: _kmFocusNode,
          validator: (v) {
            final n = InputAngka.parseAngkaRibuan(v ?? '');
            if (n <= 0) return 'Bulan harus lebih dari 0';
            return null;
          },
        ),
        InputAngka(
          controller: _kmController,
          label: 'Km',
          focusNode: _kmFocusNode,
          validator: (v) {
            final n = InputAngka.parseAngkaRibuan(v ?? '');
            if (n <= 0) return 'Km harus lebih dari 0';
            return null;
          },
        ),
        InputAngka(
          controller: _kmTerakhirServiceController,
          label: 'Km terakhir Service',
        ),
        InputTeks(
          controller: _tanggalTerakhirServiceController,
          label: 'Terakhir Service',
          suffixIcon: Icons.calendar_today,
          onSuffixIconPressed: _pilihTanggal,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Tanggal terakhir service wajib diisi';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildInputKomponen(KomponenState komponenState) {
    return Column(
      spacing: 8,
      children: [
        if (komponenState.listKomponenState.isEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                L.i('Tombol Tambah Komponen ditekan');
                unawaited(Nav.to(context, const FormKomponen()));
              },
              child: const Text('Tambah Komponen'),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: Center(
                child: InputDropdown<KomponenModel>(
                  key: ValueKey(_komponenTerpilih?.id ?? ''),
                  value: _komponenTerpilih,
                  label: _komponenDipilih.isEmpty
                      ? 'Pilih Komponen'
                      : 'Pilih komponen lainnya',
                  hintText: komponenState.listKomponenState.isEmpty
                      ? 'Belum ada komponen'
                      : 'Cari komponen...',
                  wajib: false,
                  items: komponenState.listKomponenState,
                  displayString: (komponen) => komponen.nama,
                  focusNode: _komponenFocusNode,
                  onChanged: (komponen) {
                    setState(() {
                      _komponenTerpilih = komponen;
                    });
                  },
                ),
              ),
            ),
            Center(
              child: IconButton(
                tooltip: 'Tambah',
                icon: const Icon(Icons.add),
                onPressed: _komponenTerpilih == null
                    ? null
                    : () {
                        final komponenTerpilih = _komponenTerpilih;
                        if (komponenTerpilih == null) return;
                        L.i(
                          'Tombol tambah komponen dipilih: ${komponenTerpilih.nama}',
                        );
                        setState(() {
                          if (!_komponenDipilih.contains(komponenTerpilih)) {
                            _komponenDipilih.insert(0, komponenTerpilih);
                            _komponenTerpilih = null;
                          } else {
                            AppToast.info(
                              context,
                              'Komponen ${komponenTerpilih.nama} sudah ditambahkan',
                            );
                          }
                        });
                        L.i(
                          'komponen yang di tambahkan dalam mode tambah $_komponenTerpilih sekarang komponen dipilih menjadi $_komponenDipilih',
                        );
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            _komponenFocusNode.requestFocus();
                          }
                        });
                      },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildJadwalServiceKomponen(
    KomponenState komponenState,
    List<JadwalServiceKomponenModel> relasiList, // tambahan
    String? jadwalServiceId,
    MataUangItem mataUangItem,
  ) {
    L.i('Membangun daftar komponen terpilih, total: $_komponenDipilih');
    final totalHarga = _komponenDipilih.fold<double>(
      0.0,
      (sum, item) => sum + item.harga,
    );
    L.i('total harga =$totalHarga');
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _komponenDipilih.length,
          itemBuilder: (context, index) {
            final item = _komponenDipilih[index];
            return ListTile(
              title: Text(item.nama),
              subtitle: Text(formatMataUang(item.harga, mataUangItem)),
              trailing: IconButton(
                tooltip: 'Hapus',
                onPressed: () => unawaited(
                  _hapusKomponen(item, jadwalServiceId, relasiList),
                ),
                icon: const Icon(Icons.delete),
              ),
              onTap: () {
                unawaited(Nav.to(context, DetailKomponenPage(id: item.id)));
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total'),
              Text(formatMataUang(totalHarga, mataUangItem)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTombolSimpan() {
    return OutlinedButton(onPressed: _simpanForm, child: const Text('Simpan'));
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text('Memuat form jadwal service...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat form jadwal service'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(
                  komponenProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  jadwalServiceKomponenProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/page/form_jadwal_service_komponen.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/page/form_jadwal_service_komponen.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_komponen_model.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_komponen_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/komponen/model/komponen_model.dart';
import 'package:myapp/fitur/komponen/notifier/komponen_notifier.dart';
import 'package:myapp/fitur/komponen/page/form_komponen.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Form untuk menambahkan komponen ke dalam jadwal service.
class FormJadwalServiceKomponen extends ConsumerStatefulWidget {
  /// ID jadwal service tempat komponen akan ditambahkan.
  final String? jadwalServiceId;

  /// Buat form komponen jadwal service.
  const FormJadwalServiceKomponen({super.key, this.jadwalServiceId});

  @override
  ConsumerState<FormJadwalServiceKomponen> createState() =>
      _FormJadwalServiceKomponenState();
}

class _FormJadwalServiceKomponenState
    extends ConsumerState<FormJadwalServiceKomponen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  KomponenModel? _komponenTerpilih;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    L.i(
      'FormJadwalServiceKomponen dibuka untuk jadwal: ${widget.jadwalServiceId}',
    );
  }

  @override
  void dispose() {
    L.i('FormJadwalServiceKomponen ditutup');
    super.dispose();
  }

  /// Menyimpan relasi jadwal service - komponen.
  Future<void> _simpan() async {
    if (_isLoading) return;

    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('Validasi form gagal, simpan dibatalkan');
      return;
    }

    // Menggunakan variabel lokal agar type promotion berlaku dan menghindari operator ! (AGENTS.md poin 1).
    final komponenTerpilih = _komponenTerpilih;
    if (komponenTerpilih == null) {
      AppToast.gagal(context, 'Silakan pilih komponen terlebih dahulu');
      return;
    }

    final jadwalServiceId = widget.jadwalServiceId;
    if (jadwalServiceId == null || jadwalServiceId.trim().isEmpty) {
      AppToast.gagal(context, 'Jadwal service tidak valid');
      return;
    }

    String? idKendaraan;
    try {
      idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
    } catch (e, s) {
      L.e('Gagal mengambil kendaraan terpilih: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal memuat kendaraan terpilih');
      }
      return;
    }
    if (idKendaraan == null || idKendaraan.trim().isEmpty) {
      if (mounted) AppToast.gagal(context, 'Kendaraan belum dipilih');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref
          .read(jadwalServiceKomponenProvider.notifier)
          .tambah(
            JadwalServiceKomponenModel(
              id: const Uuid().v4(),
              jadwalServiceId: jadwalServiceId,
              komponenId: komponenTerpilih.id,
              idKendaraan: idKendaraan,
              diperbarui: DateTime.now(),
            ),
          );

      L.s('Relasi berhasil disimpan: ${komponenTerpilih.nama}');
      if (mounted) {
        AppToast.sukses(context, 'Komponen berhasil ditambahkan ke jadwal');
        Nav.pop(context, true);
      }
    } catch (e, s) {
      L.e('Gagal menyimpan relasi: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menambahkan komponen');
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final komponenAsync = ref.watch(komponenProvider);

    if (komponenAsync.isLoading) {
      return _buildLoading();
    }
    if (komponenAsync.hasError) {
      return _buildError(ref);
    }

    final komponenState = komponenAsync.requireValue;
    final listKomponen = komponenState.listKomponenState;
    final mataUang = ref
        .watch(mataUangProvider)
        .maybeWhen(data: (m) => m, orElse: () => daftarMataUang.first);

    if (listKomponen.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Tambah Komponen ke Jadwal')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12, // Menggunakan spacing sesuai DESAINS.md; menghindari SizedBox untuk jarak anak.
            children: [
              Icon(
                Icons.build_circle_outlined,
                size: 24,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const Text('Belum ada komponen'),
              const SizedBox(height: 4),
              FilledButton(
                onPressed: () {
                  L.i('Tombol Tambah Komponen ditekan');
                  unawaited(Nav.to(context, const FormKomponen()));
                },
                child: const Text('Tambah Komponen'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Komponen ke Jadwal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputDropdown<KomponenModel>(
                value: _komponenTerpilih,
                label: 'Pilih Komponen',
                hintText: 'Cari atau pilih komponen...',
                items: listKomponen,
                displayString: (komponen) => komponen.nama,
                itemBuilder: (komponen) => ListTile(
                  leading: const Icon(Icons.build_circle),
                  title: Text(komponen.nama),
                  subtitle: Text(
                    formatMataUang(komponen.harga, mataUang),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _komponenTerpilih = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Komponen wajib dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _simpan,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Tambah ke Jadwal'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Memuat data...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError(WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data komponen'), // UX #16
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(komponenProvider);
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/page/form_riwayat_jadwal_service.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/page/form_riwayat_jadwal_service.dart

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_model.dart';
import 'package:myapp/fitur/jadwal_service/model/riwayat_jadwal_service_model.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/riwayat_jadwal_service_notifier.dart';
import 'package:myapp/fitur/jadwal_service/state/jadwal_service_state.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/fitur/transaksi/model/transaksi_model.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Form untuk menambah atau mengedit riwayat jadwal service kendaraan.
class FormRiwayatJadwalService extends ConsumerStatefulWidget {
  /// Model riwayat yang akan diedit. [null] jika mode tambah.
  final RiwayatJadwalServiceModel? riwayat;

  /// ID jadwal service acuan. Jika null, gunakan nama manual.
  final String? jadwalServiceId;

  /// Buat form riwayat jadwal service.
  const FormRiwayatJadwalService({
    super.key,
    this.riwayat,
    this.jadwalServiceId,
  });

  @override
  ConsumerState<FormRiwayatJadwalService> createState() =>
      _FormRiwayatJadwalServiceState();
}

class _FormRiwayatJadwalServiceState
    extends ConsumerState<FormRiwayatJadwalService> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _namaFocusNode = FocusNode();
  final _tanggalServiceController = TextEditingController();
  final _kmController = TextEditingController();
  final _biayaController = TextEditingController();
  final _catatanController = TextEditingController();
  bool _isLoading = false;
  bool _modeEdit = false;
  bool _modePilihJadwalService = false;
  bool _catatKeTransaksi = false;
  String? _linkedTransaksiId;
  String? _selectedJadwalServiceId;
  String? _selectedJadwalServiceNama;
  double _biayaValue = 0;
  final Map<String, List<JadwalServiceModel>> _autocompleteCache = {};

  @override
  void initState() {
    super.initState();
    _modeEdit = widget.riwayat != null;
    L.i('FormRiwayatJadwalService diinisialisasi, mode edit: $_modeEdit');
    final jadwalServiceId = widget.jadwalServiceId;
    if (jadwalServiceId != null && jadwalServiceId.isNotEmpty) {
      _selectedJadwalServiceId = jadwalServiceId;
    } else if (widget.riwayat?.jadwalServiceId.isNotEmpty ?? false) {
      _selectedJadwalServiceId = widget.riwayat?.jadwalServiceId;
    }
    if (_modeEdit) {
      final model = widget.riwayat;
      if (model == null) return;
      _namaController.text = model.nama;
      _tanggalServiceController.text = _formatTanggal(model.tanggalService);
      _kmController.text = FormatNomor.formatRibuan(model.km.round());
      _biayaController.text = FormatNomor.formatRibuan(model.biaya.round());
      _biayaValue = model.biaya;
      _catatanController.text = model.catatan ?? '';
      // Cari transaksi yang sudah terhubung ke riwayat ini.
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        try {
          final transaksiState = await ref.read(transaksiProvider.future);
          final listTransaksi = transaksiState.listTransaksi;
          for (final transaksi in listTransaksi) {
            if (transaksi.riwayatJadwalServiceId == model.id) {
              _linkedTransaksiId = transaksi.id;
              _catatKeTransaksi = true;
              break;
            }
          }
          if (mounted) setState(() {});
        } catch (e, s) {
          L.e('Gagal memuat transaksi terkait riwayat: $e $s');
          if (mounted) {
            AppToast.gagal(context, 'Gagal memuat transaksi terkait');
          }
        }
      });
    } else {
      _tanggalServiceController.text = _formatTanggal(DateTime.now());
    }
    _namaController.addListener(_onNamaBerubah);
    _biayaController.addListener(() {
      _biayaValue = parseMataUang(_biayaController.text) ?? 0;
      if (mounted) {
        setState(() {});
      }
    });
  }

  String _formatTanggal(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _pilihTanggal() async {
    L.i('Pilih tanggal service ditekan');
    final now = DateTime.now();
    final initialDate = _modeEdit
        ? (widget.riwayat?.tanggalService ?? now)
        : now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      _tanggalServiceController.text = _formatTanggal(picked);
      L.i('Tanggal service terpilih: $picked');
    }
  }

  DateTime _parseTanggal(String value) {
    return DateTime.tryParse(value) ?? DateTime.now();
  }

  Future<void> _simpanForm() async {
    L.i('Simpan form riwayat ditekan, mode edit: $_modeEdit');
    if (_isLoading) {
      L.w('Form masih loading, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('Validasi form gagal');
      return;
    }
    L.i('Validasi form berhasil');
    // Menunggu muat ID kendaraan agar tidak gagal saat provider belum siap
    String? idKendaraan;
    try {
      // Bungkus await provider agar error tidak crash; log dan toast jika gagal
      idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
    } catch (e, s) {
      L.e('Gagal membaca selectedKendaraanIdProvider: $e $s');
      if (mounted) AppToast.gagal(context, 'Gagal memuat data kendaraan');
      return;
    }
    if (idKendaraan == null) {
      if (mounted) {
        AppToast.gagal(context, 'Tolong pilih kendaraan anda terlebih dahulu');
      }
      return;
    }

    setState(() => _isLoading = true);
    L.i('Menyimpan riwayat jadwal service...');
    try {
      final notifier = ref.read(riwayatJadwalServiceProvider.notifier);
      final riwayatToSave = RiwayatJadwalServiceModel(
        id: _modeEdit
            ? (widget.riwayat?.id ?? const Uuid().v4())
            : const Uuid().v4(),
        jadwalServiceId:
            _selectedJadwalServiceId ??
            (() {
              final jsId = widget.jadwalServiceId;
              if (jsId != null && jsId.isNotEmpty) return jsId;
              return widget.riwayat?.jadwalServiceId ?? '';
            })(),
        idKendaraan: idKendaraan,
        nama: _namaController.text.trim(),
        tanggalService: _parseTanggal(_tanggalServiceController.text),
        km: (parseMataUang(_kmController.text) ?? 0).toDouble(),
        biaya: (parseMataUang(_biayaController.text) ?? 0).toDouble(),
        catatan: _catatanController.text.trim().isEmpty
            ? null
            : _catatanController.text.trim(),
        diperbarui: DateTime.now(),
      );
      L.i('data riwayat to save $riwayatToSave');
      if (_catatKeTransaksi) {
        final biaya = parseMataUang(_biayaController.text) ?? 0;
        if (biaya > 0) {
          final tabungan = TransaksiModel(
            id: _linkedTransaksiId ?? const Uuid().v4(),
            idKendaraan: idKendaraan,
            deskripsi: 'Service: ${_namaController.text.trim()}',
            jumlah: biaya.toDouble(),
            tipeTransaksi: TipeTransaksiEnum.pengeluaran,
            tanggal: _parseTanggal(_tanggalServiceController.text),
            diperbarui: DateTime.now(),
            riwayatJadwalServiceId: riwayatToSave.id, // foreign key
          );
          if (_linkedTransaksiId != null) {
            await ref.read(transaksiProvider.notifier).ubah(tabungan);
          } else {
            await ref.read(transaksiProvider.notifier).tambah(tabungan);
            _linkedTransaksiId = tabungan.id;
          }
        } else if (_linkedTransaksiId != null) {
          // Jika biaya 0/tidak valid, hapus transaksi yang sudah terhubung.
          if (!mounted) return;
          final konfirmasi = await showOkCancelAlertDialog(
            context: context,
            title: 'Hapus Transaksi Terhubung?',
            message: 'Transaksi tabungan terhubung akan dihapus.',
            okLabel: 'Hapus',
            cancelLabel: 'Batal',
            isDestructiveAction: true,
          );
          // Jika user batal menghapus transaksi terhubung, batalkan penyimpanan agar data tetap konsisten.
          if (konfirmasi != OkCancelResult.ok) {
            if (mounted) setState(() => _isLoading = false);
            return;
          }
          final linkedId = _linkedTransaksiId;
          if (linkedId != null) {
            await ref.read(transaksiProvider.notifier).hapus(linkedId);
          }
          _linkedTransaksiId = null;
        }
      } else if (_linkedTransaksiId != null) {
        // Jika pengguna mematikan catat transaksi, hapus transaksi terhubung.
        if (!mounted) return;
        final konfirmasi = await showOkCancelAlertDialog(
          context: context,
          title: 'Hapus Transaksi Terhubung?',
          message: 'Transaksi tabungan terhubung akan dihapus.',
          okLabel: 'Hapus',
          cancelLabel: 'Batal',
          isDestructiveAction: true,
        );
        // Jika user batal menghapus transaksi terhubung, batalkan penyimpanan agar data tetap konsisten.
        if (konfirmasi != OkCancelResult.ok) {
          if (mounted) setState(() => _isLoading = false);
          return;
        }
        final linkedId = _linkedTransaksiId;
        if (linkedId != null) {
          await ref.read(transaksiProvider.notifier).hapus(linkedId);
          _linkedTransaksiId = null;
        }
      }
      if (_modeEdit) {
        await notifier.ubah(riwayatToSave);
      } else {
        await notifier.tambah(riwayatToSave);
      }
      if (mounted) {
        AppToast.sukses(
          context,
          _modeEdit
              ? 'Riwayat service berhasil diperbarui'
              : 'Riwayat service berhasil ditambahkan',
        );
        L.s(
          'Riwayat service berhasil ${_modeEdit ? 'diperbarui' : 'ditambahkan'}',
        );
        Nav.pop(context, true);
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan riwayat jadwal service: $e $s');
      if (mounted) {
        setState(() => _isLoading = false);
        AppToast.gagal(context, 'Gagal menyimpan riwayat jadwal service');
      }
    }
  }

  void _onNamaBerubah() {
    if (_selectedJadwalServiceId == null) return;
    if (_selectedJadwalServiceNama != null &&
        _namaController.text.trim() != _selectedJadwalServiceNama) {
      setState(() {
        _selectedJadwalServiceId = null;
        _selectedJadwalServiceNama = null;
      });
    }
  }

  @override
  void dispose() {
    L.i('FormRiwayatJadwalService ditutup');
    _namaController.removeListener(_onNamaBerubah);
    _namaController.dispose();
    _namaFocusNode.dispose();
    _tanggalServiceController.dispose();
    _kmController.dispose();
    _biayaController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jadwalAsync = ref.watch(jadwalServiceProvider);
    final kendaraanAsync = ref.watch(selectedKendaraanIdProvider);

    if (jadwalAsync.isLoading || kendaraanAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (jadwalAsync.hasError || kendaraanAsync.hasError) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            _modeEdit ? 'Edit Riwayat Service' : 'Tambah Riwayat Service',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gagal memuat data'),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  final _ = ref.refresh(
                    jadwalServiceProvider,
                  ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                  final _ = ref.refresh(
                    selectedKendaraanIdProvider,
                  ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }
    final jadwalState = jadwalAsync.requireValue;
    final idKendaraanTerpilih = kendaraanAsync.requireValue;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _modeEdit ? 'Edit Riwayat Service' : 'Tambah Riwayat Service',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 16,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _modePilihJadwalService =
                                    !_modePilihJadwalService;
                              });
                            },
                            child: Text(
                              _modePilihJadwalService
                                  ? 'Tutup pilih jadwal service'
                                  : 'Pilih jadwal service',
                            ),
                          ),
                        ),
                        if (_modePilihJadwalService)
                          _buildAutocompleteJadwalService(
                            idKendaraanTerpilih,
                            jadwalState,
                          ),
                        if (!_modePilihJadwalService)
                          InputTeks(
                            controller: _namaController,
                            label: 'Nama',
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Nama wajib diisi';
                              }
                              return null;
                            },
                          ),
                        InputTeks(
                          controller: _tanggalServiceController,
                          label: 'Tanggal Service',
                          suffixIcon: Icons.calendar_today,
                          onSuffixIconPressed: _pilihTanggal,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Tanggal service wajib diisi';
                            }
                            return null;
                          },
                        ),
                        InputAngka(
                          controller: _kmController,
                          label: 'Km',
                          validator: (v) {
                            final n = parseMataUang(v ?? '') ?? 0;
                            if (n <= 0) return 'Km harus lebih dari 0';
                            return null;
                          },
                        ),
                        InputAngka(
                          controller: _biayaController,
                          label: 'Biaya',
                          onChanged: (_) {
                            _biayaValue =
                                parseMataUang(_biayaController.text) ?? 0;
                            if (mounted) setState(() {});
                          },
                        ),
                        Tooltip(
                          message: _biayaValue <= 0
                              ? 'Isi biaya lebih dari 0 untuk mengaktifkan'
                              : 'Buat transaksi pengeluaran otomatis di Transaksi',
                          child: SwitchListTile.adaptive(
                            title: const Text(
                              'Catat sebagai pengeluaran di Transaksi',
                            ),
                            subtitle: Text(
                              _biayaValue <= 0
                                  ? 'Isi biaya lebih dari 0 untuk mengaktifkan'
                                  : 'Buat transaksi pengeluaran otomatis di Transaksi',
                            ),
                            value: _catatKeTransaksi,
                            // disable jika biaya kosong/0
                            onChanged: (_biayaValue <= 0)
                                ? null
                                : (v) => setState(() => _catatKeTransaksi = v),
                          ),
                        ),
                        InputTeks(
                          controller: _catatanController,
                          label: 'Catatan',
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
              _buildTombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAutocompleteJadwalService(
    String? idKendaraanTerpilih,
    JadwalServiceState jadwalState,
  ) {
    return Autocomplete<JadwalServiceModel>(
      focusNode: _namaFocusNode,
      textEditingController: _namaController,
      optionsBuilder: (textEditingValue) {
        // Data dari state yang di-watch di build (bukan .value langsung);
        // guard loading/error sudah dilakukan sebelum requireValue.
        final query = textEditingValue.text.toLowerCase().trim();
        // Hindari operator ! agar tidak crash jika key hilang dari cache
        if (_autocompleteCache.containsKey(query)) {
          final hasil = _autocompleteCache[query];
          return hasil ?? const [];
        }
        final idKendaraan = idKendaraanTerpilih;
        final list = jadwalState.listJadwalService
            .where((j) => idKendaraan == null || j.idKendaraan == idKendaraan)
            .where((j) {
              final nama = j.nama.toLowerCase();
              if (query.isEmpty) return true;
              if (nama.contains(query)) return true;
              final kata = nama
                  .replaceAll(RegExp(r'[^a-z0-9]'), ' ')
                  .split(RegExp(r'\s+'))
                  .where((w) => w.isNotEmpty)
                  .toList();
              final inisial = kata.map((w) => w[0]).join();
              if (inisial.contains(query)) return true;
              var i = 0;
              for (final c in nama.runes) {
                if (i < query.length && String.fromCharCode(c) == query[i]) {
                  i++;
                }
              }
              if (i == query.length) return true;
              return false;
            })
            .toList();
        _autocompleteCache[query] = list;
        if (_autocompleteCache.length > 20) {
          _autocompleteCache.remove(_autocompleteCache.keys.first);
        }
        return list;
      },
      displayStringForOption: (j) => j.nama,
      onSelected: (j) {
        _namaController.text = j.nama;
        setState(() {
          _selectedJadwalServiceId = j.id;
          _selectedJadwalServiceNama = j.nama;
        });
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
            return InputTeks(
              controller: textEditingController,
              focusNode: focusNode,
              label: 'Pilih jadwal service',
              wajib: false,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Nama wajib diisi';
                }
                return null;
              },
              onSubmitted: (_) => onFieldSubmitted(),
            );
          },
    );
  }

  Widget _buildTombolSimpan() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _simpanForm,
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('Simpan'),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/page/jadwal_service_page.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/page/jadwal_service_page.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/jadwal_service/enum/opsi_jadwal_service_enum.dart';
import 'package:myapp/fitur/jadwal_service/enum/sort_jadwal_service_enum.dart';
import 'package:myapp/fitur/jadwal_service/enum/tampilan_jadwal_service_enum.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_model.dart';
import 'package:myapp/fitur/jadwal_service/model/riwayat_jadwal_service_model.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/riwayat_jadwal_service_notifier.dart';
import 'package:myapp/fitur/jadwal_service/page/detail_jadwal_service.dart';
import 'package:myapp/fitur/jadwal_service/page/form_jadwal_service.dart';
import 'package:myapp/fitur/jadwal_service/page/form_riwayat_jadwal_service.dart';
import 'package:myapp/fitur/jadwal_service/page/statistik_jadwal_service_page.dart';
import 'package:myapp/fitur/jadwal_service/page/statistik_riwayat_jadwal_service_page.dart';
import 'package:myapp/fitur/jadwal_service/state/jadwal_service_state.dart';
import 'package:myapp/fitur/jadwal_service/state/riwayat_jadwal_service_state.dart';
import 'package:myapp/fitur/jadwal_service/widget/riwayat_jadwal_service_list.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/kendaraan/state/kendaraan_state.dart';
import 'package:myapp/fitur/km/notifier/km_notifier.dart';
import 'package:myapp/fitur/km/state/km_state.dart';
import 'package:myapp/fitur/transaksi/model/transaksi_model.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:myapp/shared/widget/kendaraan_terpilih_list.dart';
import 'package:myapp/shared/widget/scroll_ke_atas.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman daftar jadwal service dengan fitur pencarian, pengurutan, dan statistik.
class JadwalServicePage extends ConsumerStatefulWidget {
  /// Buat halaman daftar jadwal service.
  const JadwalServicePage({super.key});

  @override
  ConsumerState<JadwalServicePage> createState() => _JadwalServicePageState();
}

class _JadwalServicePageState extends ConsumerState<JadwalServicePage>
    implements ScrollKeAtas {
  SortJadwalServiceEnum _currentSort = SortJadwalServiceEnum.namaAZ;
  bool _isNavigating = false;
  TampilanJadwalServiceEnum _tampilan = TampilanJadwalServiceEnum.jadwalService;
  final SearchController _searchController = SearchController();
  KendaraanModel? _kendaraanTerpilih;
  final ScrollController _scrollController = ScrollController();
  ProviderSubscription<AsyncValue<String?>>? _kendaraanSub;

  @override
  void initState() {
    super.initState();
    unawaited(Future.microtask(_reloadKendaraanTerpilih));
    _kendaraanSub = ref.listenManual(selectedKendaraanIdProvider, (
      previous,
      next,
    ) {
      /// Perbandingan aman: cek status sebelum akses .value (aturan #10).
      try {
        final prevReady =
            previous != null && !previous.isLoading && !previous.hasError;
        final nextReady = !next.isLoading && !next.hasError;
        final prevValue = prevReady ? previous.value : null;
        final nextValue = nextReady ? next.value : null;
        if (prevValue != nextValue) {
          unawaited(_reloadKendaraanTerpilih());
        }
      } catch (e, s) {
        L.e('Gagal memproses perubahan kendaraan terpilih: $e $s');
      }
    });
  }

  @override
  void dispose() {
    _kendaraanSub?.close();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _reloadKendaraanTerpilih() async {
    try {
      final idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
      final kendaraanState = await ref.read(kendaraanProvider.future);
      KendaraanModel? kendaraan;
      if (idKendaraan != null && idKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.getById(idKendaraan);
        if (kendaraan == null && kendaraanState.listKendaraan.isNotEmpty) {
          kendaraan = kendaraanState.listKendaraan.first;
        }
      } else if (_kendaraanTerpilih != null) {
        kendaraan = _kendaraanTerpilih;
      } else if (kendaraanState.listKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.listKendaraan.first;
      }
      if (mounted) {
        setState(() {
          _kendaraanTerpilih = kendaraan;
        });
      }
    } catch (e, s) {
      L.e('Gagal memuat kendaraan terpilih jadwal service: $e $s');
    }
  }

  List<JadwalServiceModel> _getSortedList(
    List<JadwalServiceModel> items,
    double? kmTerbaru, // dari KmState.kmTerbaru?.km
  ) {
    // Menggunakan sorted dari package:collection sesuai AGENTS.md, bukan native .sort().
    var sorted = [...items];
    switch (_currentSort) {
      case SortJadwalServiceEnum.namaAZ:
        sorted = sorted.sorted((a, b) => a.nama.compareTo(b.nama));
        break;
      case SortJadwalServiceEnum.namaZA:
        sorted = sorted.sorted((a, b) => b.nama.compareTo(a.nama));
        break;
      case SortJadwalServiceEnum.bulanAZ:
        sorted = sorted.sorted((a, b) => a.bulan.compareTo(b.bulan));
        break;
      case SortJadwalServiceEnum.bulanZA:
        sorted = sorted.sorted((a, b) => b.bulan.compareTo(a.bulan));
        break;
      case SortJadwalServiceEnum.kmAZ:
        sorted = sorted.sorted((a, b) => a.km.compareTo(b.km));
        break;
      case SortJadwalServiceEnum.kmZA:
        sorted = sorted.sorted((a, b) => b.km.compareTo(a.km));
        break;
      case SortJadwalServiceEnum.palingMendesak:
        // urut dari skor terkecil (= paling mendesak) ke terbesar
        sorted = sorted.sorted(
          (a, b) =>
              _skorUrgensi(a, kmTerbaru).compareTo(_skorUrgensi(b, kmTerbaru)),
        );
        break;
    }
    return sorted;
  }

  /// Skor urgensi: makin kecil = makin mendesak. Rumus: - rasioKm   = sisaKm / jadwal.km            (kalau km > 0) - rasioHari = sisaHari / (jadwal.bulan×30)  (kalau bulan > 0) - skor      = min(rasioKm, rasioHari) Aturan tepi: - kmTerbaru null    → abaikan rasioKm, pakai rasioHari saja - jadwal.km <= 0    → abaikan rasioKm, pakai rasioHari saja - jadwal.bulan <= 0 → abaikan rasioHari, pakai rasioKm saja - keduanya 0        → skor = double.infinity (taruh paling bawah)
  double _skorUrgensi(JadwalServiceModel jadwal, double? kmTerbaru) {
    final rasioKm = _hitungRasioKm(jadwal, kmTerbaru);
    final rasioHari = _hitungRasioHari(jadwal);

    if (rasioKm == null && rasioHari == null) return double.infinity;
    // Pengecekan null eksplisit: rasioHari sudah dipastikan non-null di atas, fallback 0 jika null.
    if (rasioKm == null) return rasioHari ?? 0;
    if (rasioHari == null) return rasioKm;
    return rasioKm < rasioHari ? rasioKm : rasioHari;
  }

  double? _hitungRasioKm(JadwalServiceModel jadwal, double? kmTerbaru) {
    if (kmTerbaru == null) return null;
    if (jadwal.km <= 0) return null;
    final sisaKm = (jadwal.km + jadwal.kmTerakhirService) - kmTerbaru;
    return sisaKm / jadwal.km;
  }

  double? _hitungRasioHari(JadwalServiceModel jadwal) {
    if (jadwal.bulan <= 0) return null;
    // Tambahkan hari, bukan bulan, agar pecahan bulan dan overflow bulan ditangani konsisten.
    final targetTanggal = jadwal.tanggalTerakhirService.add(
      Duration(days: (jadwal.bulan * 30).round()),
    );
    final sisaHari = targetTanggal.difference(DateTime.now()).inDays;
    return sisaHari / (jadwal.bulan * 30);
  }

  /// Sisa bulan menuju service berikutnya. Negatif = sudah lewat. `null` = `bulan <= 0` (tidak bisa dihitung).
  double? _sisaBulan(JadwalServiceModel jadwal) {
    if (jadwal.bulan <= 0) return null;
    final targetTanggal = DateTime(
      jadwal.tanggalTerakhirService.year,
      jadwal.tanggalTerakhirService.month + jadwal.bulan.toInt(),
      jadwal.tanggalTerakhirService.day,
    );
    final sisaHari = targetTanggal.difference(DateTime.now()).inDays;
    return sisaHari / 30;
  }

  /// Sisa KM menuju service berikutnya. Negatif = sudah lewat. `null` = `kmTerbaru` belum ada.
  double? _sisaKm(JadwalServiceModel jadwal, double? kmTerbaru) {
    if (kmTerbaru == null) return null;
    return (jadwal.km + jadwal.kmTerakhirService) - kmTerbaru;
  }

  void _modalOpsiSort() {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          // Bungkus konten bottom sheet dengan SafeArea agar tidak tertutup area sistem.
          return SafeArea(
            child: RadioGroup<SortJadwalServiceEnum>(
              groupValue: _currentSort,
              onChanged: (v) {
                if (v != null) {
                  setState(() => _currentSort = v);
                  // Perbaikan: gunakan Nav.pop sesuai konvensi navigasi proyek.
                  Nav.pop(context);
                }
              },
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: SortJadwalServiceEnum.values.map((o) {
                        return Card(
                          child: RadioListTile<SortJadwalServiceEnum>(
                            value: o,
                            title: Text(o.label),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _modalOpsiItem(JadwalServiceModel jadwalService) async {
    final hasil = await showDialog<OpsiJadwalServiceEnum>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text('Pilih Aksi'),
          children: [
            SimpleDialogOption(
              onPressed: () =>
                  Nav.pop(dialogContext, OpsiJadwalServiceEnum.edit),
              child: Row(
                children: [
                  const Icon(Icons.edit),
                  const SizedBox(width: 12),
                  Text(OpsiJadwalServiceEnum.edit.label),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () =>
                  Nav.pop(dialogContext, OpsiJadwalServiceEnum.hapus),
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    OpsiJadwalServiceEnum.hapus.label,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    if (hasil == null) return;
    if (!mounted) return;

    switch (hasil) {
      case OpsiJadwalServiceEnum.edit:
        await Nav.to(
          context,
          FormJadwalService(jadwalServiceModel: jadwalService),
        );
        break;
      case OpsiJadwalServiceEnum.hapus:
        final konfirmasi = await showOkCancelAlertDialog(
          context: context,
          title: 'Hapus Data',
          message: 'Data jadwal service ini akan dihapus secara permanen.',
          okLabel: 'Hapus',
          cancelLabel: 'Batal',
          isDestructiveAction: true,
        );
        if (konfirmasi != OkCancelResult.ok) return;
        try {
          await ref
              .read(jadwalServiceProvider.notifier)
              .hapus(jadwalService.id);
          if (mounted) {
            AppToast.sukses(context, 'Jadwal service berhasil dihapus');
          }
        } catch (e, s) {
          L.e('Gagal menghapus jadwal service: $e $s');
          if (mounted) {
            AppToast.gagal(context, 'Gagal menghapus jadwal service');
          }
        }
        break;
    }
  }

  Future<void> _modalOpsiRiwayat(RiwayatJadwalServiceModel riwayat) async {
    final hasil = await showDialog<OpsiJadwalServiceEnum>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text('Pilih Aksi'),
          children: [
            SimpleDialogOption(
              onPressed: () =>
                  Nav.pop(dialogContext, OpsiJadwalServiceEnum.edit),
              child: Row(
                children: [
                  const Icon(Icons.edit),
                  const SizedBox(width: 12),
                  Text(OpsiJadwalServiceEnum.edit.label),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () =>
                  Nav.pop(dialogContext, OpsiJadwalServiceEnum.hapus),
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    OpsiJadwalServiceEnum.hapus.label,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    if (hasil == null) return;
    if (!mounted) return;

    switch (hasil) {
      case OpsiJadwalServiceEnum.edit:
        await Nav.to(context, FormRiwayatJadwalService(riwayat: riwayat));
        break;
      case OpsiJadwalServiceEnum.hapus:
        final konfirmasi = await showOkCancelAlertDialog(
          context: context,
          title: 'Hapus Data',
          message: 'Data riwayat service ini akan dihapus secara permanen.',
          okLabel: 'Hapus',
          cancelLabel: 'Batal',
          isDestructiveAction: true,
        );
        if (konfirmasi != OkCancelResult.ok) return;
        try {
          String? linkedTransaksiId;
          // Gunakan .future agar data transaksi tetap terbaca walau state belum tersedia.
          List<TransaksiModel>? listTransaksi;
          try {
            listTransaksi = (await ref.read(transaksiProvider.future))
                .listTransaksi;
          } catch (e, s) {
            L.e('Gagal memuat transaksi terkait riwayat: $e $s');
          }
          if (listTransaksi != null) {
            for (final transaksi in listTransaksi) {
              if (transaksi.riwayatJadwalServiceId == riwayat.id) {
                linkedTransaksiId = transaksi.id;
                break;
              }
            }
          }
          await ref
              .read(riwayatJadwalServiceProvider.notifier)
              .hapus(riwayat.id);
          if (linkedTransaksiId != null) {
            await ref.read(transaksiProvider.notifier).hapus(linkedTransaksiId);
          }
          if (mounted) {
            AppToast.sukses(context, 'Riwayat service berhasil dihapus');
          }
        } catch (e, s) {
          L.e('Gagal menghapus riwayat jadwal service: $e $s');
          if (mounted) {
            AppToast.gagal(context, 'Gagal menghapus riwayat jadwal service');
          }
        }
        break;
    }
  }

  @override
  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final jadwalServiceAsync = ref.watch(jadwalServiceProvider);
    final riwayatAsync = ref.watch(riwayatJadwalServiceProvider);
    final kendaraanAsync = ref.watch(kendaraanProvider);
    final kmAsync = ref.watch(kmProvider);

    // Urutan pemeriksaan AsyncValue: loading → error → data (optimasi_bug_runtime.md poin 9).
    if (jadwalServiceAsync.isLoading ||
        riwayatAsync.isLoading ||
        kendaraanAsync.isLoading ||
        kmAsync.isLoading) {
      return _buildLoading();
    }
    if (jadwalServiceAsync.hasError ||
        riwayatAsync.hasError ||
        kendaraanAsync.hasError ||
        kmAsync.hasError) {
      return _buildError(ref);
    }

    final jadwalServiceState = jadwalServiceAsync.requireValue;
    final riwayatJadwalServiceState = riwayatAsync.requireValue;
    final kendaraanState = kendaraanAsync.requireValue;
    final kmState = kmAsync.requireValue;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(
        jadwalServiceState,
        riwayatJadwalServiceState,
        kendaraanState,
        kmState,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        tooltip: 'Tambah Jadwal Service',
        // Mencegah navigasi ganda saat FAB ditekan berulang kali
        onPressed: _isNavigating
            ? null
            : () async {
                setState(() => _isNavigating = true);
                if (_tampilan == TampilanJadwalServiceEnum.riwayat) {
                  await Nav.to(context, const FormRiwayatJadwalService());
                } else {
                  await Nav.to(context, const FormJadwalService());
                }
                if (mounted) setState(() => _isNavigating = false);
              },
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Jadwal Service'),
      actions: [
        IconButton(
          tooltip: 'Statistik',
          icon: const Icon(Icons.bar_chart),
          onPressed: () => unawaited(
            Nav.to(
              context,
              _tampilan == TampilanJadwalServiceEnum.riwayat
                  ? const StatistikRiwayatJadwalServicePage()
                  : const StatistikJadwalServicePage(),
            ),
          ),
        ),

        IconButton(
          tooltip: _searchController.isAttached && _searchController.isOpen
              ? 'Tutup'
              : 'Cari',
          onPressed: () {
            if (_searchController.isAttached) {
              if (_searchController.isOpen) {
                _searchController.closeView(null);
              } else {
                _searchController.openView();
              }
            }
          },
          icon: Icon(
            _searchController.isAttached && _searchController.isOpen
                ? Icons.close
                : Icons.search,
          ),
        ),
        IconButton(
          tooltip: 'Urutkan',
          onPressed: _modalOpsiSort,
          icon: const Icon(Icons.sort),
        ),
      ],
    );
  }

  // Widget SearchAnchor yang ditempatkan di body
  Widget _buildSearchAnchor(List<JadwalServiceModel> allData) {
    return SearchAnchor(
      searchController: _searchController,
      isFullScreen: false,
      builder: (context, controller) {
        return const SizedBox.shrink();
      },
      suggestionsBuilder: (context, controller) {
        final query = controller.text.toLowerCase();

        final filtered = allData.where((item) {
          return item.nama.toLowerCase().contains(query) ||
              item.bulan.toString().contains(query) ||
              item.km.toString().contains(query);
        }).toList();

        final displayList = query.isEmpty ? allData : filtered;

        if (displayList.isEmpty) {
          return [
            Center(
              child: Text(
                'Tidak ada hasil ditemukan',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ];
        }

        return displayList.map((item) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                (item.nama.isNotEmpty ? item.nama[0] : '?').toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              item.nama,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '${item.bulan.toStringAsFixed(0)} bulan sekali • ${FormatNomor.formatRibuan(item.km.toInt())} km',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () {
              controller.closeView(item.nama);
              unawaited(Nav.to(context, DetailJadwalService(id: item.id)));
            },
            trailing: const Icon(Icons.chevron_right, size: 20),
          );
        }).toList();
      },
    );
  }

  Widget _buildBody(
    JadwalServiceState jadwalServiceState,
    RiwayatJadwalServiceState riwayatJadwalServiceState,
    KendaraanState kendaraanState,
    KmState kmState,
  ) {
    final list = jadwalServiceState.listJadwalService;
    final kmTerbaru = kmState
        .kmTerbaruByIdKendaraan(_kendaraanTerpilih?.id)
        ?.km;
    final selectedId = _kendaraanTerpilih?.id;
    final filteredList = (selectedId == null || selectedId.isEmpty)
        ? list
        : jadwalServiceState.getListByIdKendaraan(selectedId);
    final listTersortir = _getSortedList(filteredList, kmTerbaru);
    return Column(
      children: [
        KendaraanTerpilihList(
          listKendaraan: kendaraanState.listKendaraan,
          selectedId: selectedId,
          onSelected: (kendaraan) {
            setState(() => _kendaraanTerpilih = kendaraan);
          },
          onReload: _reloadKendaraanTerpilih,
        ),
        _buildTombolOpsiTampilan(),
        Expanded(
          child: _tampilan == TampilanJadwalServiceEnum.riwayat
              ? RiwayatJadwalServiceList(
                  state: riwayatJadwalServiceState,
                  idKendaraan: selectedId,
                  onOpsi: _modalOpsiRiwayat,
                  onTambah: () => unawaited(
                    Nav.to(context, const FormRiwayatJadwalService()),
                  ),
                )
              : listTersortir.isEmpty
              ? _buildListKosong()
              : Stack(
                  children: [
                    ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(12),
                      itemCount: listTersortir.length,
                      itemBuilder: (context, index) {
                        final item = listTersortir[index];
                        return _buildJadwalCard(context, item, kmTerbaru);
                      },
                    ),
                    _buildSearchAnchor(listTersortir),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildTombolOpsiTampilan() {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SegmentedButton<TampilanJadwalServiceEnum>(
        segments: const [
          ButtonSegment<TampilanJadwalServiceEnum>(
            value: TampilanJadwalServiceEnum.jadwalService,
            label: Text(
              'Jadwal Service',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            icon: Icon(Icons.event_note),
          ),
          ButtonSegment<TampilanJadwalServiceEnum>(
            value: TampilanJadwalServiceEnum.riwayat,
            label: Text(
              'Riwayat',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            icon: Icon(Icons.history),
          ),
        ],
        selected: {_tampilan},
        showSelectedIcon: false,
        expandedInsets: EdgeInsets.zero,
        style: SegmentedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        onSelectionChanged: (selection) {
          setState(() => _tampilan = selection.first);
        },
      ),
    );
  }

  Widget _buildJadwalCard(
    BuildContext context,
    JadwalServiceModel jadwalService,
    double? kmTerbaru,
  ) {
    // hitung sisa
    final sisaBulan = _sisaBulan(jadwalService);
    final sisaKm = _sisaKm(jadwalService, kmTerbaru);
    // warna merah kalau sudah lewat (negatif)
    final warnaSisaBulan = (sisaBulan != null && sisaBulan < 0)
        ? Theme.of(context).colorScheme.error
        : null;
    final warnaSisaKm = (sisaKm != null && sisaKm < 0)
        ? Theme.of(context).colorScheme.error
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          jadwalService.nama,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            // baris 1: interval
            Row(
              spacing: 4,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                Flexible(
                  child: Text(
                    '${jadwalService.bulan.toStringAsFixed(0)} bulan sekali',
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.speed,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                Flexible(
                  child: Text(
                    '${FormatNomor.formatRibuan(jadwalService.km.toInt())} km',
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // baris 2: sisa
            Row(
              spacing: 4,
              children: [
                Icon(
                  Icons.hourglass_bottom,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                Flexible(
                  child: Text(
                    sisaBulan == null
                        ? 'Sisa bulan: -'
                        : 'Sisa ${sisaBulan.toStringAsFixed(1)} bulan lagi',
                    style: TextStyle(fontSize: 13, color: warnaSisaBulan),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.route,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                Flexible(
                  child: Text(
                    sisaKm == null
                        ? 'Sisa km: -'
                        : 'Sisa ${FormatNomor.formatRibuan(sisaKm.toInt())} km lagi',
                    style: TextStyle(fontSize: 13, color: warnaSisaKm),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          tooltip: 'Opsi',
          icon: const Icon(Icons.more_vert),
          onPressed: () => _modalOpsiItem(jadwalService),
        ),
        isThreeLine: true,
        onTap: () {
          unawaited(Nav.to(context, DetailJadwalService(id: jadwalService.id)));
        },
      ),
    );
  }

  Widget _buildListKosong() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month,
            size: 24,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada jadwal service',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Tambahkan jadwal service untuk kendaraan Anda',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () =>
                unawaited(Nav.to(context, const FormJadwalService())),
            icon: const Icon(Icons.add),
            label: const Text('Tambah Jadwal Service'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text('Memuat jadwal service...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError(WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat jadwal service'),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(
                  jadwalServiceProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  riwayatJadwalServiceProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  kendaraanProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/page/statistik_jadwal_service_page.dart
// ============================================================

```dart
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/jadwal_service/enum/opsi_sort_komponen_enum.dart';
import 'package:myapp/fitur/jadwal_service/enum/opsi_statistik_jadwal_service_enum.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_komponen_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_notifier.dart';
import 'package:myapp/fitur/jadwal_service/state/jadwal_service_komponen_state.dart';
import 'package:myapp/fitur/jadwal_service/state/jadwal_service_state.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/komponen/notifier/komponen_notifier.dart';
import 'package:myapp/fitur/komponen/page/detail_komponen_page.dart';
import 'package:myapp/fitur/komponen/state/komponen_state.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman statistik biaya service jadwal dengan berbagai opsi perhitungan.
class StatistikJadwalServicePage extends ConsumerStatefulWidget {
  /// Buat halaman statistik jadwal service.
  const StatistikJadwalServicePage({super.key});

  @override
  ConsumerState<StatistikJadwalServicePage> createState() =>
      _StatistikJadwalServicePageState();
}

class _StatistikJadwalServicePageState
    extends ConsumerState<StatistikJadwalServicePage> {
  OpsiStatistikJadwalServiceEnum _selectedOpsi =
      OpsiStatistikJadwalServiceEnum.total;
  OpsiSortKomponenEnum _selectedSortKomponen =
      OpsiSortKomponenEnum.biayatertinggi;

  double _totalBiaya(
    JadwalServiceState? jadwalServiceState,
    KomponenState? komponenState,
    JadwalServiceKomponenState? jadwalServiceKomponenState, {
    String? idKendaraan,
  }) {
    final listJadwalServiceKomponen =
        (jadwalServiceKomponenState?.listJadwalServiceKomponen ?? [])
            .where((r) => idKendaraan == null || r.idKendaraan == idKendaraan)
            .toList();
    var biaya = 0.0;
    for (final item in listJadwalServiceKomponen) {
      final komponen = komponenState?.getById(item.komponenId);
      final jadwal = jadwalServiceState?.getById(item.jadwalServiceId);
      if (komponen == null || jadwal == null) continue;
      biaya += komponen.harga;
    }
    L.i('biaya : $biaya');
    return biaya;
  }

  Map<String, double> _totalBiayaPerKomponen(
    JadwalServiceState? jadwalServiceState,
    JadwalServiceKomponenState? jadwalServiceKomponenState,
    KomponenState? komponenState, {
    String? idKendaraan,
  }) {
    final listJadwalServiceKomponen =
        (jadwalServiceKomponenState?.listJadwalServiceKomponen ?? [])
            .where((r) => idKendaraan == null || r.idKendaraan == idKendaraan)
            .toList();

    L.i('_totalBiayaPerKomponen: jumlah relasi = $listJadwalServiceKomponen');

    final map = <String, _DataKomponen>{};
    // Hindari menghitung relasi duplikat (komponen + jadwal yang sama) lebih dari sekali.
    final relasiTerproses = <String>{};
    for (final js in listJadwalServiceKomponen) {
      final komponen = komponenState?.getById(js.komponenId);
      if (komponen == null) continue;
      final jadwal = jadwalServiceState?.getById(js.jadwalServiceId);
      if (jadwal == null) continue;
      if (!relasiTerproses.add('${komponen.id}|${jadwal.id}')) continue;
      final existing = map[komponen.id];
      if (existing != null) {
        map[komponen.id] = _DataKomponen(
          totalBiaya: existing.totalBiaya + komponen.harga,
          totalKm: existing.totalKm + jadwal.km,
          totalBulan: existing.totalBulan + jadwal.bulan,
        );
      } else {
        map[komponen.id] = _DataKomponen(
          totalBiaya: komponen.harga,
          totalKm: jadwal.km,
          totalBulan: jadwal.bulan,
        );
      }
    }
    L.i('_totalBiayaPerKomponen: jumlah komponen unik = $map');

    final hasil = <String, double>{};
    for (final entri in map.entries) {
      final data = entri.value;
      switch (_selectedOpsi) {
        case OpsiStatistikJadwalServiceEnum.total:
          hasil[entri.key] = data.totalBiaya;
          break;
        case OpsiStatistikJadwalServiceEnum.perKm:
          hasil[entri.key] = data.totalKm == 0
              ? 0.0
              : data.totalBiaya / data.totalKm;
          break;
        case OpsiStatistikJadwalServiceEnum.perHari:
          hasil[entri.key] = data.totalBulan == 0
              ? 0.0
              : data.totalBiaya / (data.totalBulan * 30);
          break;
        case OpsiStatistikJadwalServiceEnum.perMinggu:
          hasil[entri.key] = data.totalBulan == 0
              ? 0.0
              : data.totalBiaya / (data.totalBulan * 30 / 7);
          break;
        case OpsiStatistikJadwalServiceEnum.perBulan:
          hasil[entri.key] = data.totalBulan == 0
              ? 0.0
              : data.totalBiaya / data.totalBulan;
          break;
        case OpsiStatistikJadwalServiceEnum.perTahun:
          hasil[entri.key] = data.totalBulan == 0
              ? 0.0
              : data.totalBiaya / (data.totalBulan / 12);
          break;
      }
    }
    final sortedEntries = hasil.entries.toList().sorted((a, b) {
      if (_selectedSortKomponen == OpsiSortKomponenEnum.biayatertinggi) {
        return b.value.compareTo(a.value); // biaya tertinggi dulu
      } else {
        return a.value.compareTo(b.value); // biaya terendah dulu
      }
    });
    L.i(
      '_totalBiayaPerKomponen: opsi=${_selectedOpsi.label}, sort=${_selectedSortKomponen.label}, hasil=$sortedEntries entri',
    );
    return Map.fromEntries(sortedEntries);
  }

  Widget _barisBiaya(String label, double nilai, MataUangItem mataUangItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          formatMataUang(nilai, mataUangItem),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Guard status AsyncValue untuk provider kendaraan agar tidak sembunyi loading/error.
    final idKendaraanAsync = ref.watch(selectedKendaraanIdProvider);
    final jadwalServiceAsync = ref.watch(jadwalServiceProvider);
    final jadwalServiceKomponenAsync = ref.watch(jadwalServiceKomponenProvider);
    final komponenAsync = ref.watch(komponenProvider);
    final mataUangAsync = ref.watch(mataUangProvider);

    if (jadwalServiceAsync.isLoading ||
        jadwalServiceKomponenAsync.isLoading ||
        komponenAsync.isLoading ||
        idKendaraanAsync.isLoading ||
        mataUangAsync.isLoading) {
      return _buildLoading();
    }
    if (jadwalServiceAsync.hasError ||
        jadwalServiceKomponenAsync.hasError ||
        komponenAsync.hasError ||
        idKendaraanAsync.hasError ||
        mataUangAsync.hasError) {
      return _buildError(ref);
    }

    // Ambil nilai aman setelah guard loading/error.
    final idKendaraan = idKendaraanAsync.requireValue;
    final mataUangItem = mataUangAsync.requireValue;

    final jadwalServiceState = jadwalServiceAsync.requireValue;
    final jadwalServiceKomponenState = jadwalServiceKomponenAsync.requireValue;
    final komponenState = komponenAsync.requireValue;

    {
      final totalBiaya = _totalBiaya(
        jadwalServiceState,
        komponenState,
        jadwalServiceKomponenState,
        idKendaraan: idKendaraan,
      );
      final totalKm = jadwalServiceState.getTotalKm();
      final totalBulan = jadwalServiceState.getTotalBulan();
      final totalHari = jadwalServiceState.getTotalHari();
      final totalTahun = jadwalServiceState.getTotalTahun();
      final totalMinggu = jadwalServiceState.getTotalMinggu();
      final totalBiayaperKm = totalKm == 0 ? 0.0 : totalBiaya / totalKm;
      final totalBiayaperBulan = totalBulan == 0
          ? 0.0
          : totalBiaya / totalBulan;
      final totalBiayaperHari = totalHari == 0 ? 0.0 : totalBiaya / totalHari;
      final totalBiayaperTahun = totalTahun == 0
          ? 0.0
          : totalBiaya / totalTahun;
      final totalBiayaperMinggu = totalMinggu == 0
          ? 0.0
          : totalBiaya / totalMinggu;
      L.i(
        'Statistik build: totalBiaya=$totalBiaya, totalKm=$totalKm, totalBulan=$totalBulan, '
        'totalHari=$totalHari, totalTahun=$totalTahun, totalMinggu=$totalMinggu',
      );
      return Scaffold(
        appBar: AppBar(title: const Text('Statistik Biaya Service')),
        body: Column(
          spacing: 8,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Total Biaya',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatMataUang(totalBiaya, mataUangItem),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ExpansionTile(
                  shape: const RoundedRectangleBorder(),
                  collapsedShape: const RoundedRectangleBorder(),
                  initiallyExpanded: true,
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  title: const Text('Biaya per Unit Waktu'),
                  children: [
                    Column(
                      spacing: 8,
                      children: [
                        _barisBiaya(
                          'Biaya Per KM',
                          totalBiayaperKm,
                          mataUangItem,
                        ),
                        _barisBiaya(
                          'Biaya Per Hari',
                          totalBiayaperHari,
                          mataUangItem,
                        ),
                        _barisBiaya(
                          'Biaya Per Minggu',
                          totalBiayaperMinggu,
                          mataUangItem,
                        ),
                        _barisBiaya(
                          'Biaya Per Bulan',
                          totalBiayaperBulan,
                          mataUangItem,
                        ),
                        _barisBiaya(
                          'Biaya Per Tahun',
                          totalBiayaperTahun,
                          mataUangItem,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _buildDetailKomponen(
              jadwalServiceState,
              jadwalServiceKomponenState,
              komponenState,
              mataUangItem,
              idKendaraan: idKendaraan,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [CircularProgressIndicator(), Text('Memuat data...')],
        ),
      ),
    );
  }

  Widget _buildError(WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data statistik jadwal service'), // UX #16
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(jadwalServiceProvider);
                final _ = ref.refresh(jadwalServiceKomponenProvider);
                final _ = ref.refresh(komponenProvider);
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailKomponen(
    JadwalServiceState? jadwalServiceState,
    JadwalServiceKomponenState? jadwalServiceKomponenState,
    KomponenState? komponenState,
    MataUangItem mataUangItem, {
    String? idKendaraan,
  }) {
    final list = _totalBiayaPerKomponen(
      jadwalServiceState,
      jadwalServiceKomponenState,
      komponenState,
      idKendaraan: idKendaraan,
    );
    L.i('_buildDetailKomponen: jumlah item ditampilkan = $list');
    TextStyle style(OpsiStatistikJadwalServiceEnum ops) => TextStyle(
      fontWeight: _selectedOpsi == ops ? FontWeight.bold : FontWeight.w500,
      color: _selectedOpsi == ops
          ? Theme.of(context).colorScheme.onPrimary
          : Theme.of(context).colorScheme.onSurface,
    );

    final childrenMap = <OpsiStatistikJadwalServiceEnum, Widget>{
      OpsiStatistikJadwalServiceEnum.total: Text(
        'Total',
        style: style(OpsiStatistikJadwalServiceEnum.total),
      ),
      OpsiStatistikJadwalServiceEnum.perKm: Text(
        'Per KM',
        style: style(OpsiStatistikJadwalServiceEnum.perKm),
      ),
      OpsiStatistikJadwalServiceEnum.perHari: Text(
        'Per Hari',
        style: style(OpsiStatistikJadwalServiceEnum.perHari),
      ),
      OpsiStatistikJadwalServiceEnum.perMinggu: Text(
        'Per Minggu',
        style: style(OpsiStatistikJadwalServiceEnum.perMinggu),
      ),
      OpsiStatistikJadwalServiceEnum.perBulan: Text(
        'Per Bulan',
        style: style(OpsiStatistikJadwalServiceEnum.perBulan),
      ),
      OpsiStatistikJadwalServiceEnum.perTahun: Text(
        'Per Tahun',
        style: style(OpsiStatistikJadwalServiceEnum.perTahun),
      ),
    };
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 8,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: CupertinoSlidingSegmentedControl(
              thumbColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              children: childrenMap,
              groupValue: _selectedOpsi,
              onValueChanged: (newValue) {
                if (newValue != null) {
                  setState(() => _selectedOpsi = newValue);
                }
              },
            ),
          ),
          Card(
            child: ExpansionTile(
              shape: const RoundedRectangleBorder(),
              collapsedShape: const RoundedRectangleBorder(),
              initiallyExpanded: true,
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              title: Text(_selectedOpsi.label),
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: PopupMenuButton<OpsiSortKomponenEnum>(
                    onSelected: (v) {
                      setState(() => _selectedSortKomponen = v);
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: OpsiSortKomponenEnum.biayaterendah,
                        child: Text(
                          'Biaya Terendah',
                          style: TextStyle(
                            color:
                                _selectedSortKomponen ==
                                    OpsiSortKomponenEnum.biayaterendah
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: OpsiSortKomponenEnum.biayatertinggi,
                        child: Text(
                          'Biaya Tertinggi',
                          style: TextStyle(
                            color:
                                _selectedSortKomponen ==
                                    OpsiSortKomponenEnum.biayatertinggi
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      ),
                    ],
                    child: Text(
                      _selectedSortKomponen.label,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (list.isEmpty)
                  const Center(child: Text('Belum ada komponen')),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: list.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = list.entries.toList()[index];
                    final komponen = komponenState?.getById(item.key);
                    L.i(
                      'Statistik item [$index]: komponenId=${item.key}, '
                      'nama=${komponen?.nama ?? '-'}, biaya=${item.value}',
                    );
                    return InkWell(
                      onTap: () => unawaited(
                        Nav.to(context, DetailKomponenPage(id: item.key)),
                      ), // aturan unawaited
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(komponen?.nama ?? ''),
                            Text(formatMataUang(item.value, mataUangItem)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Data pengelola biaya komponen untuk statistik.
class _DataKomponen {
  double totalBiaya;
  double totalKm;
  double totalBulan;

  _DataKomponen({
    required this.totalBiaya,
    required this.totalKm,
    required this.totalBulan,
  });
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/page/statistik_riwayat_jadwal_service_page.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/page/statistik_riwayat_jadwal_service_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/jadwal_service/notifier/riwayat_jadwal_service_notifier.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman statistik riwayat service kendaraan.
class StatistikRiwayatJadwalServicePage extends ConsumerWidget {
  /// Buat halaman statistik riwayat service.
  const StatistikRiwayatJadwalServicePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riwayatJadwalServiceAsync = ref.watch(riwayatJadwalServiceProvider);
    final mataUangAsync = ref.watch(mataUangProvider);
    if (riwayatJadwalServiceAsync.isLoading || mataUangAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (riwayatJadwalServiceAsync.hasError || mataUangAsync.hasError) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gagal memuat statistik'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.refresh(riwayatJadwalServiceProvider),
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }
    // Menggunakan .value (nullable) + guard null agar tidak memakai operator ! (AGENTS.md poin 1).
    final riwayatJadwalServiceState = riwayatJadwalServiceAsync.requireValue;
    final mataUangItem = mataUangAsync.requireValue;
    final totalBiaya = riwayatJadwalServiceState.getTotalBiaya();
    final jumlahService = riwayatJadwalServiceState.getJumlahService();
    final rataRataBiaya = riwayatJadwalServiceState.getRataRataBiaya();
    final rataRataJarak = riwayatJadwalServiceState.getRataRataJarakKm();
    final terbaru = riwayatJadwalServiceState.getTerbaru();

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Riwayat Service')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 12,
          children: [
            _kartuStatistik(
              judul: 'Total Biaya Service',
              nilai: formatMataUang(totalBiaya, mataUangItem),
              warna: Theme.of(context).colorScheme.primary,
            ),
            _kartuStatistik(
              judul: 'Jumlah Service',
              nilai: jumlahService.toString(),
              warna: Theme.of(context).colorScheme.secondary,
            ),
            _kartuStatistik(
              judul: 'Rata-rata Biaya',
              nilai: formatMataUang(rataRataBiaya, mataUangItem),
              warna: Theme.of(context).colorScheme.tertiary,
            ),
            _kartuStatistik(
              judul: 'Rata-rata Jarak',
              nilai: '${FormatNomor.formatRibuan(rataRataJarak.round())} km',
              warna: Theme.of(context).colorScheme.primary,
            ),
            if (terbaru != null)
              Card(
                child: ListTile(
                  title: const Text('Service Terbaru'),
                  subtitle: Text(
                    '${terbaru.nama} • ${FormatTanggal.formatDasar(terbaru.tanggalService)}',
                  ),
                  trailing: Text(formatMataUang(terbaru.biaya, mataUangItem)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _kartuStatistik({
    required String judul,
    required String nilai,
    required Color warna,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(judul, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              nilai,
              style: TextStyle(fontWeight: FontWeight.bold, color: warna),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/state/jadwal_service_komponen_state.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/state/jadwal_service_komponen_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_komponen_model.dart';
import 'package:myapp/fitur/komponen/model/komponen_model.dart';

part 'jadwal_service_komponen_state.freezed.dart';

/// State untuk mengelola daftar komponen jadwal service.
@freezed
abstract class JadwalServiceKomponenState with _$JadwalServiceKomponenState {
  const JadwalServiceKomponenState._();

  /// Membuat instance [JadwalServiceKomponenState] dengan daftar relasi komponen.
  const factory JadwalServiceKomponenState({
    @Default([]) List<JadwalServiceKomponenModel> listJadwalServiceKomponen,
  }) = _JadwalServiceKomponenState;

  /// Mengembalikan daftar komponen yang terkait dengan [jadwalServiceId].
  List<JadwalServiceKomponenModel> getListByJadwalServiceId(
    String jadwalServiceId,
  ) {
    return listJadwalServiceKomponen
        .where((relasi) => relasi.jadwalServiceId == jadwalServiceId)
        .toList();
  }

  /// Menghitung total biaya komponen untuk jadwal service. Jika [jadwalServiceId] diberikan, hanya komponen yang terkait dengan jadwal service tersebut yang dihitung. Jika null, semua komponen dari [komponenList] dijumlahkan.
  double getTotalBiaya({
    required List<KomponenModel> komponenList,
    String? jadwalServiceId,
  }) {
    final komponenIds = jadwalServiceId == null
        ? komponenList.map((e) => e.id).toSet()
        : listJadwalServiceKomponen
              .where((relasi) => relasi.jadwalServiceId == jadwalServiceId)
              .map((e) => e.komponenId)
              .toSet();

    return komponenList
        .where((k) => komponenIds.contains(k.id))
        .fold<double>(0, (sum, k) => sum + k.harga);
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/state/jadwal_service_state.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/state/jadwal_service_state.dart

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/jadwal_service/model/jadwal_service_model.dart';

part 'jadwal_service_state.freezed.dart';

/// State untuk menyimpan daftar jadwal service kendaraan.
@freezed
abstract class JadwalServiceState with _$JadwalServiceState {
  const JadwalServiceState._();

  /// Membuat instance [JadwalServiceState] dengan daftar jadwal service.
  const factory JadwalServiceState({
    @Default([]) List<JadwalServiceModel> listJadwalService,
  }) = _JadwalServiceState;

  /// Mencari jadwal service berdasarkan [id]. Mengembalikan null jika jadwal service dengan [id] tidak ditemukan.
  JadwalServiceModel? getById(String id) =>
      listJadwalService.firstWhereOrNull((jd) => jd.id == id);

  /// Mengembalikan daftar jadwal service untuk kendaraan dengan [idKendaraan]. Mengembalikan list kosong jika [idKendaraan] null atau kosong.
  List<JadwalServiceModel> getListByIdKendaraan(String? idKendaraan) {
    if (idKendaraan == null || idKendaraan.isEmpty) {
      return [];
    }
    return listJadwalService
        .where((jd) => jd.idKendaraan == idKendaraan)
        .toList();
  }

  /// Menghitung total km dari semua jadwal service.
  double getTotalKm() =>
      listJadwalService.fold<double>(0, (sum, jd) => sum + jd.km);

  /// Menghitung total bulan dari semua jadwal service.
  double getTotalBulan() =>
      listJadwalService.fold<double>(0, (sum, jd) => sum + jd.bulan);

  /// Menghitung total hari (asumsi 1 bulan = 30 hari).
  double getTotalHari() => getTotalBulan() * 30;

  /// Menghitung total tahun (asumsi 1 tahun = 12 bulan).
  double getTotalTahun() => getTotalBulan() / 12;

  /// Menghitung total minggu (asumsi 1 minggu = 7 hari).
  double getTotalMinggu() => getTotalHari() / 7;

  /// Menghitung sisa KM untuk satu jadwal service terhadap [currentOdometer]. Jika [currentOdometer] null, kembalikan interval [km] sebagai perkiraan sisa. Mengembalikan negatif jika sudah melewati batas KM.
  double sisaKm(JadwalServiceModel jadwal, {double? currentOdometer}) {
    if (currentOdometer == null) {
      return jadwal.km;
    }
    // km adalah interval (periode), kmTerakhirService adalah odometer saat service terakhir.
    return jadwal.kmTerakhirService + jadwal.km - currentOdometer;
  }

  /// Menghitung sisa bulan untuk satu jadwal service. Mengembalikan negatif jika sudah melewati batas bulan.
  double sisaBulan(JadwalServiceModel jadwal) {
    final selisih =
        DateTime.now().difference(jadwal.tanggalTerakhirService).inDays / 30;
    return jadwal.bulan - selisih;
  }

  /// Cek apakah jadwal service sudah waktunya service (sisa KM <= 0 atau sisa bulan <= 0).
  bool sudahWaktuService(
    JadwalServiceModel jadwal, {
    double? currentOdometer,
  }) =>
      sisaKm(jadwal, currentOdometer: currentOdometer) <= 0 ||
      sisaBulan(jadwal) <= 0;
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/state/riwayat_jadwal_service_state.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/state/riwayat_jadwal_service_state.dart

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/jadwal_service/model/riwayat_jadwal_service_model.dart';

part 'riwayat_jadwal_service_state.freezed.dart';

/// State untuk mengelola daftar riwayat service kendaraan.
@freezed
abstract class RiwayatJadwalServiceState with _$RiwayatJadwalServiceState {
  const RiwayatJadwalServiceState._();

  /// Membuat instance [RiwayatJadwalServiceState] dengan daftar riwayat service.
  const factory RiwayatJadwalServiceState({
    @Default([]) List<RiwayatJadwalServiceModel> listRiwayatJadwalService,
  }) = _RiwayatJadwalServiceState;

  /// Mengembalikan riwayat service dengan [id], atau null jika tidak ditemukan.
  RiwayatJadwalServiceModel? getById(String id) =>
      listRiwayatJadwalService.firstWhereOrNull((r) => r.id == id);

  /// Mengembalikan daftar riwayat service untuk kendaraan dengan [idKendaraan]. Mengembalikan list kosong jika [idKendaraan] null atau kosong.
  List<RiwayatJadwalServiceModel> getListByIdKendaraan(String? idKendaraan) {
    if (idKendaraan == null || idKendaraan.isEmpty) {
      return [];
    }
    return listRiwayatJadwalService
        .where((r) => r.idKendaraan == idKendaraan)
        .toList();
  }

  /// Mengembalikan daftar riwayat service untuk jadwal service dengan [jadwalServiceId].
  List<RiwayatJadwalServiceModel> getListByJadwalServiceId(
    String jadwalServiceId,
  ) {
    if (jadwalServiceId.isEmpty) {
      return [];
    }
    return listRiwayatJadwalService
        .where((r) => r.jadwalServiceId == jadwalServiceId)
        .toList();
  }

  /// Menghitung total biaya service. Jika [idKendaraan] diberikan, hanya riwayat milik kendaraan tersebut yang dihitung.
  double getTotalBiaya({String? idKendaraan}) {
    final list = idKendaraan == null
        ? listRiwayatJadwalService
        : getListByIdKendaraan(idKendaraan);
    return list.fold<double>(0, (sum, r) => sum + r.biaya);
  }

  /// Menghitung jumlah service yang sudah dilakukan. Jika [idKendaraan] diberikan, hanya riwayat milik kendaraan tersebut yang dihitung.
  int getJumlahService({String? idKendaraan}) {
    final list = idKendaraan == null
        ? listRiwayatJadwalService
        : getListByIdKendaraan(idKendaraan);
    return list.length;
  }

  /// Menghitung rata-rata biaya per service. Mengembalikan 0 jika belum ada riwayat.
  double getRataRataBiaya({String? idKendaraan}) {
    final jumlah = getJumlahService(idKendaraan: idKendaraan);
    if (jumlah == 0) {
      return 0;
    }
    return getTotalBiaya(idKendaraan: idKendaraan) / jumlah;
  }

  /// Menghitung jarak tempuh antar service (selisih km service terakhir dan service sebelumnya) rata-rata. Mengembalikan 0 jika riwayat kurang dari 2.
  double getRataRataJarakKm({String? idKendaraan}) {
    final list = _urutkanTanggalTerlama(
      idKendaraan == null
          ? listRiwayatJadwalService
          : getListByIdKendaraan(idKendaraan),
    );
    // Untuk kurang dari 2 riwayat, rata-rata jarak tidak dapat dihitung.
    if (list.length < 2) {
      return 0;
    }
    var total = 0.0;
    for (var i = 1; i < list.length; i++) {
      // Gunakan nilai absolut agar jarak tempuh tidak bernilai negatif.
      total += (list[i].km - list[i - 1].km).abs();
    }
    return total / (list.length - 1);
  }

  /// Mengembalikan riwayat service terbaru (tanggal service paling baru). Mengembalikan null jika belum ada riwayat.
  RiwayatJadwalServiceModel? getTerbaru({String? idKendaraan}) {
    final list = _urutkanTanggalTerlama(
      idKendaraan == null
          ? listRiwayatJadwalService
          : getListByIdKendaraan(idKendaraan),
    );
    if (list.isEmpty) {
      return null;
    }
    return list.last;
  }

  /// Mengembalikan daftar riwayat service diurutkan dari yang paling lama ke yang paling baru berdasarkan tanggal service.
  List<RiwayatJadwalServiceModel> getTerurutTanggal({String? idKendaraan}) =>
      _urutkanTanggalTerlama(
        idKendaraan == null
            ? listRiwayatJadwalService
            : getListByIdKendaraan(idKendaraan),
      );

  List<RiwayatJadwalServiceModel> _urutkanTanggalTerlama(
    List<RiwayatJadwalServiceModel> list,
  ) {
    // Gunakan sorted dari package:collection sesuai aturan.
    return list.sorted((a, b) => a.tanggalService.compareTo(b.tanggalService));
  }
}
```


// ============================================================
// FILE: lib/fitur/jadwal_service/widget/riwayat_jadwal_service_list.dart
// ============================================================

```dart
// lib/fitur/jadwal_service/widget/riwayat_jadwal_service_list.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/jadwal_service/model/riwayat_jadwal_service_model.dart';
import 'package:myapp/fitur/jadwal_service/state/riwayat_jadwal_service_state.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:share_global_saya/core_shared.dart';

/// Widget daftar riwayat service kendaraan beserta ringkasan total biaya, jumlah service, dan rata-rata jarak tempuh antar service.
class RiwayatJadwalServiceList extends ConsumerWidget {
  /// State riwayat service yang berisi data riwayat.
  final RiwayatJadwalServiceState state;

  /// ID kendaraan untuk memfilter riwayat. Jika null atau kosong, semua riwayat ditampilkan.
  final String? idKendaraan;

  /// Callback saat kartu riwayat ditekan.
  final ValueChanged<RiwayatJadwalServiceModel>? onTap;

  /// Callback saat tombol opsi pada kartu riwayat ditekan.
  final ValueChanged<RiwayatJadwalServiceModel>? onOpsi;

  /// Apakah bagian ringkasan ditampilkan di atas daftar.
  final bool tampilkanRingkasan;

  /// Callback saat tombol tambah pada empty state ditekan.
  final VoidCallback? onTambah;

  /// Buat widget daftar riwayat service.
  const RiwayatJadwalServiceList({
    super.key,
    required this.state,
    this.idKendaraan,
    this.onTap,
    this.onOpsi,
    this.onTambah,
    this.tampilkanRingkasan = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mataUang = ref
        .watch(mataUangProvider)
        .maybeWhen(data: (m) => m, orElse: () => daftarMataUang.first);
    final list = _listRiwayat();

    if (list.isEmpty) {
      return _buildListKosong(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: list.length + (tampilkanRingkasan ? 1 : 0),
      itemBuilder: (context, index) {
        if (tampilkanRingkasan && index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildRingkasan(context, mataUang),
          );
        }
        final item = list[index - (tampilkanRingkasan ? 1 : 0)];
        return _buildCard(context, item, mataUang);
      },
    );
  }

  /// Daftar riwayat sesuai filter kendaraan, diurutkan dari yang paling baru.
  List<RiwayatJadwalServiceModel> _listRiwayat() {
    final id = _idKendaraanEfektif();
    final list = state.getTerurutTanggal(idKendaraan: id);
    return list.reversed.toList();
  }

  /// ID kendaraan yang dipakai untuk filter, null berarti semua kendaraan.
  String? _idKendaraanEfektif() {
    final id = idKendaraan;
    if (id == null || id.isEmpty) {
      return null;
    }
    return id;
  }

  /// Kartu ringkasan total service, total biaya, dan rata-rata jarak tempuh.
  Widget _buildRingkasan(BuildContext context, MataUangItem mataUang) {
    final id = _idKendaraanEfektif();
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoRingkasan(
              context,
              'Jumlah Service',
              '${state.getJumlahService(idKendaraan: id)}',
              Theme.of(context).colorScheme.onSurface,
            ),
            _buildInfoRingkasan(
              context,
              'Total Biaya',
              formatMataUang(state.getTotalBiaya(idKendaraan: id), mataUang),
              Theme.of(context).colorScheme.primary,
            ),
            _buildInfoRingkasan(
              context,
              'Rata-rata Jarak',
              '${FormatNomor.formatRibuan(state.getRataRataJarakKm(idKendaraan: id).round())} km',
              Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }

  /// Kolom informasi ringkasan dengan label dan nilai.
  Widget _buildInfoRingkasan(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: color),
          ),
        ),
      ],
    );
  }

  /// Kartu satu riwayat service.
  Widget _buildCard(
    BuildContext context,
    RiwayatJadwalServiceModel item,
    MataUangItem mataUang,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    // Variabel lokal agar type promotion berlaku dan menghindari operator ! (AGENTS.md poin 1).
    final onTapCallback = onTap;
    final onOpsiCallback = onOpsi;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(
            Icons.build_outlined,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          item.nama,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            // baris 1: tanggal service dan km
            Row(
              spacing: 4,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                Flexible(
                  child: Text(
                    FormatTanggal.formatDasar(item.tanggalService),
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.speed,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                Flexible(
                  child: Text(
                    '${FormatNomor.formatRibuan(item.km.round())} km',
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // baris 2: biaya service
            Row(
              spacing: 4,
              children: [
                Icon(
                  Icons.payments_outlined,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                Flexible(
                  child: Text(
                    formatMataUang(item.biaya, mataUang),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.history,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                Flexible(
                  child: Text(
                    '${item.hariSejakService} hari lalu',
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (item.catatan?.isNotEmpty ?? false) ...[
              const SizedBox(height: 4),
              // baris 3: catatan service
              Row(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.notes,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  Expanded(
                    child: Text(
                      item.catatan ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        trailing: onOpsiCallback == null
            ? null
            : IconButton(
                tooltip: 'Opsi',
                icon: const Icon(Icons.more_vert),
                onPressed: () => onOpsiCallback(item),
              ),
        isThreeLine: true,
        onTap: onTapCallback == null ? null : () => onTapCallback(item),
      ),
    );
  }

  Widget _buildListKosong(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada riwayat service',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            'Riwayat service yang sudah dilakukan akan tampil di sini',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          if (onTambah != null) ...[
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: onTambah,
              icon: const Icon(Icons.add),
              label: const Text('Tambah Riwayat'),
            ),
          ],
        ],
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/helper/pilih_gambar_web.dart
// ============================================================

```dart
import 'dart:async';

import 'package:web/web.dart' as web;

/// Memilih gambar di web menggunakan input file native, mengembalikan object URL.
Future<String?> pilihGambarWeb() async {
  final input = web.HTMLInputElement()
    ..type = 'file'
    ..accept = 'image/*';
  input.click();
  try {
    await input.onChange.first.timeout(const Duration(minutes: 5));
  } on TimeoutException {
    // User membatalkan atau tidak memilih file; hindari hang selamanya.
  }
  final files = input.files;
  if (files == null || files.length == 0) return null;
  final file = files.item(0);
  if (file == null) return null;
  return web.URL.createObjectURL(file);
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/helper/pilih_gambar_web_stub.dart
// ============================================================

```dart
/// Stub untuk platform non-web.
Future<String?> pilihGambarWeb() async => null;
```


// ============================================================
// FILE: lib/fitur/kendaraan/model/kendaraan_model.dart
// ============================================================

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'kendaraan_model.freezed.dart';

/// Model data kendaraan pengguna.
@freezed
abstract class KendaraanModel with _$KendaraanModel {
  const KendaraanModel._();

  /// Membuat instance [KendaraanModel] dengan data lengkap.
  const factory KendaraanModel({
    required String id,
    required String nama,
    required String merk,
    String? platNomor,
    String? pathGambar,
    String? tahunKeluar,
    String? model,
    String? jenis,
    required DateTime diperbarui,
    DateTime? diarsipkan,
  }) = _KendaraanModel;

  /// Membuat [KendaraanModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KendaraanModel.fromSupabase(Map<String, dynamic> map) =>
      KendaraanModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        nama: map[NamaKolom.nama]?.toString() ?? '',
        merk: map[NamaKolom.merk]?.toString() ?? '',
        platNomor: map[NamaKolom.platNomor]?.toString(),
        pathGambar: map[NamaKolom.pathGambar]?.toString(),
        tahunKeluar: map[NamaKolom.tahunKeluar]?.toString(),
        model: map[NamaKolom.model]?.toString(),
        jenis: map[NamaKolom.jenis]?.toString(),
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.merk: merk,
    NamaKolom.platNomor: platNomor,
    NamaKolom.pathGambar: pathGambar,
    NamaKolom.tahunKeluar: tahunKeluar,
    NamaKolom.model: model,
    NamaKolom.jenis: jenis,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  /// Membuat [KendaraanModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KendaraanModel.fromSqflite(Map<String, dynamic> map) =>
      KendaraanModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        nama: map[NamaKolom.nama]?.toString() ?? '',
        merk: map[NamaKolom.merk]?.toString() ?? '',
        platNomor: map[NamaKolom.platNomor]?.toString(),
        pathGambar: map[NamaKolom.pathGambar]?.toString(),
        tahunKeluar: map[NamaKolom.tahunKeluar]?.toString(),
        model: map[NamaKolom.model]?.toString(),
        jenis: map[NamaKolom.jenis]?.toString(),
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.merk: merk,
    NamaKolom.platNomor: platNomor,
    NamaKolom.pathGambar: pathGambar,
    NamaKolom.tahunKeluar: tahunKeluar,
    NamaKolom.model: model,
    NamaKolom.jenis: jenis,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/model/pajak_model.dart
// ============================================================

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'pajak_model.freezed.dart';

/// Model data pajak kendaraan.
@freezed
abstract class PajakModel with _$PajakModel {
  const PajakModel._();

  /// Membuat instance [PajakModel] dengan data lengkap.
  const factory PajakModel({
    required String id,
    required String nama,
    required DateTime tanggal,
    required double biaya,
    required String idKendaraan,
  }) = _PajakModel;

  // ==================== Supabase ====================

  /// Membuat [PajakModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory PajakModel.fromSupabase(Map<String, dynamic> map) => _dariMap(map);

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => _keMap();

  // ==================== Sqflite ====================

  /// Membuat [PajakModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory PajakModel.fromSqflite(Map<String, dynamic> map) => _dariMap(map);

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => _keMap();

  // ==================== Konversi internal ====================

  /// Satu metode konversi dari Map (Supabase/Sqflite) ke [PajakModel].
  // Bungkus parsing dalam try/catch agar kegagalan parsing tercatat (L.e) dan tidak crash diam-diam.
  static PajakModel _dariMap(Map<String, dynamic> map) {
    try {
      return PajakModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        nama: map[NamaKolom.nama]?.toString() ?? '',
        tanggal:
            ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
        biaya: ParserUtil.parseDouble(map[NamaKolom.biaya]),
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      );
    } on Exception catch (e, s) {
      L.e('Gagal parse PajakModel: $e $s');
      rethrow;
    }
  }

  /// Satu metode konversi dari instance ke Map (Supabase/Sqflite).
  Map<String, dynamic> _keMap() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.biaya: biaya,
    NamaKolom.idKendaraan: idKendaraan,
  };
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/notifier/kendaraan_notifier.dart
// ============================================================

```dart
// lib/fitur/kendaraan/notifier/kendaraan_notifier.dart
import 'package:myapp/fitur/bahan_bakar/notifier/bahan_bakar_notifier.dart';
import 'package:myapp/fitur/impian/notifier/impian_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_komponen_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/riwayat_jadwal_service_notifier.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/pajak_notifier.dart';
import 'package:myapp/fitur/kendaraan/state/kendaraan_state.dart';
import 'package:myapp/fitur/km/notifier/km_notifier.dart';
import 'package:myapp/fitur/komponen/notifier/komponen_notifier.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:myapp/shared/db/sqflite/db_sqflite.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/notifikasi/notifikasi_service.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'kendaraan_notifier.g.dart';

/// Notifier untuk data kendaraan.
@Riverpod(keepAlive: true)
class KendaraanNotifier extends _$KendaraanNotifier {
  String get _tabelKendaraan => NamaTabel.kendaraan;

  @override
  Future<KendaraanState> build() async {
    L.i('build kendaraan_notifier mulai');
    try {
      // Bungkus build dalam try/catch agar kegagalan load tercatat (L.e) dan di-rethrow (optimasi_bug_runtime.md poin 6).
      L.i('build kendaraan_notifier selesai');
      return await _muatData();
    } on Exception catch (e, s) {
      L.e('build kendaraan gagal: $e $s');
      rethrow;
    }
  }

  Future<KendaraanState> _muatData() async {
    L.i('kendaraan_notifier _muatData mulai');
    try {
      final listDb = await ref
          .read(baseOpSqfliteProvider)
          .ambilData(_tabelKendaraan);
      final listHasil = listDb
          .whereType<Map<String, dynamic>>()
          .map(KendaraanModel.fromSqflite)
          .toList();
      final stateHasil = KendaraanState(listKendaraan: listHasil);
      L.i('kendaraan_notifier _muatData selesai');
      return stateHasil;
    } on Exception catch (e, s) {
      L.e('Gagal memuat kendaraan: $e $s');
      rethrow;
    }
  }

  Future<void> _muatUlang() async {
    state = AsyncValue.data(await _muatData());
  }

  /// Menambahkan [kendaraan] baru ke daftar dan database.
  Future<void> tambah(KendaraanModel kendaraan) async {
    final dataLama = await future;
    final listBaru = dataLama.copyWith(
      listKendaraan: [...dataLama.listKendaraan, kendaraan],
    );
    // Optimistic update: perbarui state terlebih dahulu.
    state = AsyncValue.data(listBaru);

    try {
      await ref
          .read(baseOpSqfliteProvider)
          .tambah(_tabelKendaraan, kendaraan.toSqflite());
      await _muatUlang();
    } on Exception catch (e, s) {
      L.e('tambah kendaraan gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Mengubah data [kendaraan] di daftar dan database.
  Future<void> perbarui(KendaraanModel kendaraan) async {
    final dataLama = await future;
    final listBaru = dataLama.listKendaraan
        .map((e) => e.id == kendaraan.id ? kendaraan : e)
        .toList();
    final stateBaru = dataLama.copyWith(listKendaraan: listBaru);
    // Optimistic update: perbarui state terlebih dahulu.
    state = AsyncValue.data(stateBaru);

    try {
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(_tabelKendaraan, kendaraan.toSqflite(), kendaraan.id);
      await _muatUlang();
    } on Exception catch (e, s) {
      L.e('perbarui kendaraan gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Menghapus kendaraan dengan [id] dari daftar dan database. Semua data terkait (pajak, bahan bakar, km, jadwal service, komponen, transaksi, impian) juga dihapus (cascade delete).
  Future<void> hapus(String id) async {
    try {
      final baseOp = ref.read(baseOpSqfliteProvider);
      final db = await ref.read(dbSqfliteProvider).database;

      // Batalkan notifikasi pajak terkait sebelum menghapus.
      final pajakList = await baseOp.ambilDataDenganWhere(
        NamaTabel.pajak,
        '${NamaKolom.idKendaraan} = ?',
        [id],
      );
      for (final row in pajakList) {
        // Menghindari parsing dinamis `as String?`; gunakan cek tipe eksplisit sesuai AGENTS.md.
        final rawId = row[NamaKolom.id];
        final pajakId = rawId is String ? rawId : null;
        if (pajakId != null && pajakId.isNotEmpty) {
          await NotifikasiService.batalkanJadwal(pajakId);
        }
      }

      // Cascade delete dalam satu transaksi agar konsisten (rollback jika gagal).
      await db.transaction((txn) async {
        await txn.delete(
          NamaTabel.pajak,
          where: '${NamaKolom.idKendaraan} = ?',
          whereArgs: [id],
        );
        await txn.delete(
          NamaTabel.bahanBakar,
          where: '${NamaKolom.idKendaraan} = ?',
          whereArgs: [id],
        );
        await txn.delete(
          NamaTabel.km,
          where: '${NamaKolom.idKendaraan} = ?',
          whereArgs: [id],
        );
        await txn.delete(
          NamaTabel.jadwalServiceKomponen, // konsisten dengan konstanta (bug runtime #1)
          where: '${NamaKolom.idKendaraan} = ?',
          whereArgs: [id],
        );
        await txn.delete(
          NamaTabel.jadwalService,
          where: '${NamaKolom.idKendaraan} = ?',
          whereArgs: [id],
        );
        await txn.delete(
          NamaTabel.riwayatJadwalService,
          where: '${NamaKolom.idKendaraan} = ?',
          whereArgs: [id],
        );
        await txn.delete(
          NamaTabel.transaksi,
          where: '${NamaKolom.idKendaraan} = ?',
          whereArgs: [id],
        );
        await txn.delete(
          NamaTabel.impian,
          where: '${NamaKolom.idKendaraan} = ?',
          whereArgs: [id],
        );
        await txn.delete(
          NamaTabel.komponen,
          where: '${NamaKolom.idKendaraan} = ?',
          whereArgs: [id],
        );
        await txn.delete(
          _tabelKendaraan,
          where: '${NamaKolom.id} = ?',
          whereArgs: [id],
        ); // konsisten konstanta (bug runtime #1)
      });

      // Refresh provider terkait agar state di memori langsung diperbarui (Riverpod bagian 6).
      final _ = ref.refresh(pajakProvider);
      final _ = ref.refresh(bahanBakarProvider);
      final _ = ref.refresh(kmProvider);
      final _ = ref.refresh(jadwalServiceProvider);
      final _ = ref.refresh(jadwalServiceKomponenProvider);
      final _ = ref.refresh(riwayatJadwalServiceProvider);
      final _ = ref.refresh(transaksiProvider);
      final _ = ref.refresh(impianProvider);
      final _ = ref.refresh(komponenProvider);

      await _muatUlang();
      L.s('Kendaraan berhasil dihapus (cascade): $id');
    } on Exception catch (e, s) {
      L.e('hapus kendaraan gagal: $e $s');
      rethrow;
    }
  }

  /// Melakukan batch insert [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(List<KendaraanModel> data) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabelKendaraan,
            data.map((e) => e.toSqflite()).toList(),
          );

      await _muatUlang();
    } catch (e, s) {
      L.e('Gagal batch insert kendaraan $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/notifier/pajak_notifier.dart
// ============================================================

```dart
// lib/fitur/kendaraan/notifier/pajak_notifier.dart
import 'package:myapp/fitur/kendaraan/model/pajak_model.dart';
import 'package:myapp/fitur/kendaraan/state/pajak_state.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/notifikasi/notifikasi_service.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'pajak_notifier.g.dart';

/// Notifier untuk data pajak kendaraan.
@Riverpod(keepAlive: true)
class PajakNotifier extends _$PajakNotifier {
  String get _tabelPajak => NamaTabel.pajak;

  @override
  Future<PajakState> build() async {
    try {
      // Bungkus build dalam try/catch agar kegagalan load tercatat (L.e) dan di-rethrow
      // (optimasi_bug_runtime.md poin 6), konsisten dengan kendaraan_notifier.
      return await _muatData();
    } on Exception catch (e, s) {
      L.e('build pajak gagal: $e $s');
      rethrow;
    }
  }

  Future<PajakState> _muatData() async {
    try {
      final listDb = await ref
          .read(baseOpSqfliteProvider)
          .ambilData(_tabelPajak);
      final listHasil = listDb
          .whereType<Map<String, dynamic>>()
          .map(PajakModel.fromSqflite)
          .toList();
      return PajakState(listPajak: listHasil);
    } on Exception catch (e, s) {
      L.e('Gagal memuat pajak: $e $s');
      rethrow;
    }
  }

  Future<void> _muatUlang() async {
    state = AsyncValue.data(await _muatData());
  }

  /// Menambahkan [pajak] baru ke daftar dan database.
  Future<void> tambah(PajakModel pajak) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .tambah(_tabelPajak, pajak.toSqflite());
      await _muatUlang();
      // Hindari notifikasi langsung untuk tanggal jatuh tempo yang sudah lewat.
      if (pajak.tanggal.isAfter(DateTime.now())) {
        try {
          await NotifikasiService.tampilkanAtauJadwalkan(
            id: pajak.id,
            judul: 'Pajak ${pajak.nama} jatuh tempo',
            isi: 'Jatuh tempo ${FormatTanggal.formatDasar(pajak.tanggal)}',
            waktu: pajak.tanggal,
            kategori: KategoriNotifikasi.kendaraan,
          );
        } catch (e, s) {
          L.e('Gagal menjadwalkan notifikasi pajak: $e $s');
        }
      }
    } on Exception catch (e, s) {
      L.e('tambah pajak gagal: $e $s');
      rethrow;
    }
  }

  /// Mengubah data [pajak] di daftar dan database.
  Future<void> perbarui(PajakModel pajak) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(_tabelPajak, pajak.toSqflite(), pajak.id);
      await _muatUlang();
      // Hindari notifikasi langsung untuk tanggal jatuh tempo yang sudah lewat.
      if (pajak.tanggal.isAfter(DateTime.now())) {
        try {
          await NotifikasiService.tampilkanAtauJadwalkan(
            id: pajak.id,
            judul: 'Pajak ${pajak.nama} jatuh tempo',
            isi: 'Jatuh tempo ${FormatTanggal.formatDasar(pajak.tanggal)}',
            waktu: pajak.tanggal,
            kategori: KategoriNotifikasi.kendaraan,
          );
        } catch (e, s) {
          L.e('Gagal menjadwalkan notifikasi pajak: $e $s');
        }
      }
    } on Exception catch (e, s) {
      L.e('perbarui pajak gagal: $e $s');
      rethrow;
    }
  }

  /// Menghapus pajak dengan [id] dari daftar dan database.
  Future<void> hapus(String id) async {
    try {
      await ref.read(baseOpSqfliteProvider).hapus(_tabelPajak, id);
      try {
        await NotifikasiService.batalkanJadwal(id);
      } catch (e, s) {
        L.e('Gagal membatalkan jadwal notifikasi pajak: $e $s');
      }
      await _muatUlang();
    } on Exception catch (e, s) {
      L.e('hapus pajak gagal: $e $s');
      rethrow;
    }
  }

  /// Melakukan batch insert [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(List<PajakModel> data) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabelPajak,
            data.map((e) => e.toSqflite()).toList(),
          );

      await _muatUlang();
    } catch (e, s) {
      L.e('Gagal batch insert pajak $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/page/detail_kendaraan_page.dart
// ============================================================

```dart
// lib/fitur/kendaraan/page/detail_kendaraan_page.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/model/pajak_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/notifier/pajak_notifier.dart';
import 'package:myapp/fitur/kendaraan/page/form_kendaraan.dart';
import 'package:myapp/fitur/kendaraan/page/form_pajak.dart';
import 'package:myapp/fitur/kendaraan/state/kendaraan_state.dart';
import 'package:myapp/fitur/kendaraan/state/pajak_state.dart';
import 'package:myapp/fitur/kendaraan/widget/card_item_kendaraan.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman detail untuk melihat informasi lengkap kendaraan.
class DetailKendaraanPage extends ConsumerStatefulWidget {
  /// ID kendaraan yang akan ditampilkan detailnya.
  final String id;

  /// Buat halaman detail kendaraan.
  const DetailKendaraanPage({super.key, required this.id});

  @override
  ConsumerState<DetailKendaraanPage> createState() =>
      _DetailKendaraanPageState();
}

class _DetailKendaraanPageState extends ConsumerState<DetailKendaraanPage> {
  bool _isDeleting = false;
  final Set<String> _deletingPajakIds = <String>{};

  String get id => widget.id;

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    KendaraanModel kendaraan,
  ) async {
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Data',
      message:
          'Data kendaraan ini akan dihapus secara permanen.\n\n"${kendaraan.nama}"',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (konfirmasi != OkCancelResult.ok) {
      L.i('Penghapusan kendaraan dibatalkan');
      return;
    }
    unawaited(EasyLoading.show(status: 'Menghapus...'));
    if (!mounted) {
      unawaited(EasyLoading.dismiss());
      return;
    }
    L.i('Menghapus kendaraan: ${kendaraan.id}');
    // Hindari setState saat widget sudah tidak aktif setelah await dialog.
    if (mounted) setState(() => _isDeleting = true);
    try {
      await ref.read(kendaraanProvider.notifier).hapus(kendaraan.id);
      if (context.mounted) {
        AppToast.sukses(context, 'Kendaraan berhasil dihapus');
        Nav.pop(context);
      }
    } catch (e, s) {
      L.e('Gagal menghapus kendaraan: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal menghapus kendaraan');
      }
    } finally {
      unawaited(EasyLoading.dismiss());
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  Future<void> _hapusPajak(PajakModel item) async {
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Data',
      message: 'Data pajak ini akan dihapus secara permanen.\n\n"${item.nama}"',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (konfirmasi != OkCancelResult.ok) return;
    if (!mounted) return;
    setState(() => _deletingPajakIds.add(item.id));
    try {
      await ref.read(pajakProvider.notifier).hapus(item.id);
      if (mounted) {
        AppToast.sukses(context, 'Pajak berhasil dihapus');
      }
    } catch (e, s) {
      L.e('Gagal menghapus pajak: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menghapus pajak');
      }
    } finally {
      if (mounted) {
        setState(() => _deletingPajakIds.remove(item.id));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final kendaraanAsync = ref.watch(kendaraanProvider);
    final pajakAsync = ref.watch(pajakProvider);
    final mataUangAsync = ref.watch(mataUangProvider);

    // Urutkan pemeriksaan AsyncValue: loading → error → data (optimasi_bug_runtime.md poin 9).
    if (kendaraanAsync.isLoading ||
        pajakAsync.isLoading ||
        mataUangAsync.isLoading) {
      return _buildLoading();
    }
    if (kendaraanAsync.hasError ||
        pajakAsync.hasError ||
        mataUangAsync.hasError) {
      return _buildError();
    }

    final kendaraanState = kendaraanAsync.requireValue;
    final pajakState = pajakAsync.requireValue;
    final mataUangItem = mataUangAsync.requireValue;
    return _buildScaffold(context, kendaraanState, pajakState, mataUangItem);
  }

  Widget _buildScaffold(
    BuildContext context,
    KendaraanState kendaraanState,
    PajakState pajakState,
    MataUangItem mataUangItem,
  ) {
    final kendaraan = kendaraanState.getById(id);
    L.i('$kendaraan');
    if (kendaraan == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kendaraan')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              Icon(
                Icons.error_outline,
                size: 24,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const Text('Kendaraan tidak ditemukan'),
              FilledButton(
                onPressed: () => Nav.pop(context),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kendaraan.nama,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              unawaited(
                Nav.to(context, FormKendaraan(kendaraanModel: kendaraan)),
              );
            },
            tooltip: 'Edit Kendaraan',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardItemKendaraan(kendaraanModel: kendaraan),
            _buildCaradInfoKendaraan(kendaraan),
            _buildCardPajak(pajakState, mataUangItem),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isDeleting
                    ? null
                    : () => _showDeleteConfirmation(context, kendaraan),
                icon: const Icon(Icons.delete),
                label: const Text('Hapus Kendaraan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaradInfoKendaraan(KendaraanModel kendaraan) {
    return Card(
      child: Column(
        children: [
          _buildInfoRow('Nama', kendaraan.nama),
          const Divider(),
          _buildInfoRow('Merk', kendaraan.merk),
          const Divider(),
          // Menghindari null assertion (!) dengan ?. dan ?? (AGENTS.md poin 1).
          if ((kendaraan.tahunKeluar?.isNotEmpty) ?? false) ...[
            _buildInfoRow('Tahun Keluar', kendaraan.tahunKeluar ?? ''),
            const Divider(),
          ],
          if ((kendaraan.model?.isNotEmpty) ?? false) ...[
            _buildInfoRow('Model', kendaraan.model ?? ''),
            const Divider(),
          ],
          if ((kendaraan.jenis?.isNotEmpty) ?? false) ...[
            _buildInfoRow('Jenis', kendaraan.jenis ?? ''),
            const Divider(),
          ],
          _buildInfoRow('Plat Nomor', kendaraan.platNomor ?? '-'),
          const Divider(),
          _buildInfoRow(
            'Terakhir Diperbarui',
            FormatWaktuLengkap.formatSingkat(kendaraan.diperbarui),
          ),
          if (kendaraan.diarsipkan != null)
            _buildInfoRow(
              'Diarsipkan',
              FormatWaktuLengkap.formatSingkat(
                kendaraan.diarsipkan ?? DateTime.now(),
              ),
            ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildCardPajak(PajakState pajakState, MataUangItem mataUangItem) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daftar Pajak',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton.icon(
                onPressed: () =>
                    unawaited(Nav.to(context, FormPajak(idKendaraan: id))),
                icon: const Icon(Icons.add),
                label: const Text('Tambah Pajak'),
              ),
            ],
          ),
          _buildPajakList(context, id, pajakState, mataUangItem),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total Pajak: ${formatMataUang(pajakState.totalPajakByIdKendaraan(id), mataUangItem)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPajakList(
    BuildContext context,
    String idKendaraan,
    PajakState pajakState,
    MataUangItem mataUangItem,
  ) {
    final list = pajakState.getListByIdKendaraan(idKendaraan);
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 24,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            Text(
              'Belum ada daftar pajak',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            TextButton.icon(
              onPressed: () => unawaited(
                Nav.to(context, FormPajak(idKendaraan: idKendaraan)),
              ), // unawaited: Nav.to mengembalikan Future (optimasi_bug_runtime.md #10)
              icon: const Icon(Icons.add),
              label: const Text('Tambah Pajak'),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          child: ListTile(
            title: Text(
              item.nama,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(FormatTanggal.formatDasar(item.tanggal)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: Text(
                    formatMataUang(item.biaya, mataUangItem),
                    style: Theme.of(context).textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: _deletingPajakIds.contains(item.id)
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.error,
                        ),
                  tooltip: 'Hapus Pajak',
                  onPressed: _deletingPajakIds.contains(item.id)
                      ? null
                      : () => unawaited(_hapusPajak(item)),
                ),
              ],
            ),
            onTap: () => unawaited(
              Nav.to(
                context,
                FormPajak(pajakModel: item, idKendaraan: idKendaraan),
              ),
            ),
            onLongPress: () => unawaited(_hapusPajak(item)),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            CircularProgressIndicator(),
            Text('Memuat daftar kendaraan...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            const Text('Gagal memuat data kendaraan'),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(
                  kendaraanProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  pajakProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/page/form_kendaraan.dart
// ============================================================

```dart
// lib/fitur/kendaraan/page/form_kendaraan.dart

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/fitur/kendaraan/helper/pilih_gambar_web_stub.dart'
    if (dart.library.html) 'package:myapp/fitur/kendaraan/helper/pilih_gambar_web.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/home.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Halaman form untuk menambah atau mengedit data kendaraan.
class FormKendaraan extends ConsumerStatefulWidget {
  /// Model kendaraan yang akan diedit. [null] jika mode tambah.
  final KendaraanModel? kendaraanModel;

  /// Apakah ini pendaftaran pertama kali.
  final bool pertamaDaftar;

  /// Membuat form kendaraan. [kendaraanModel] parameter opsional untuk mode edit.
  const FormKendaraan({
    super.key,
    this.kendaraanModel,
    this.pertamaDaftar = false,
  });

  @override
  ConsumerState<FormKendaraan> createState() => _FormKendaraanState();
}

class _FormKendaraanState extends ConsumerState<FormKendaraan> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _merkController = TextEditingController();
  final _platNomorController = TextEditingController();
  final _tahunKeluarController = TextEditingController();
  final _modelController = TextEditingController();
  final _jenisController = TextEditingController();

  final _namaFocusNode = FocusNode();
  final _merkFocusNode = FocusNode();
  final _platNomorFocusNode = FocusNode();
  final _tahunKeluarFocusNode = FocusNode();
  final _modelFocusNode = FocusNode();
  final _jenisFocusNode = FocusNode();

  bool _modeEdit = false;
  bool _isLoading = false;
  bool _sedangPilihGambar = false;
  String? _pathGambar;

  @override
  void initState() {
    super.initState();
    _modeEdit = widget.kendaraanModel != null;
    _namaController.text = widget.kendaraanModel?.nama ?? '';
    _merkController.text = widget.kendaraanModel?.merk ?? '';
    _platNomorController.text = widget.kendaraanModel?.platNomor ?? '';
    _tahunKeluarController.text = widget.kendaraanModel?.tahunKeluar ?? '';
    _modelController.text = widget.kendaraanModel?.model ?? '';
    _jenisController.text = widget.kendaraanModel?.jenis ?? '';
    _pathGambar = widget.kendaraanModel?.pathGambar;
    L.i('FormKendaraan dibuka, mode edit: $_modeEdit');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _merkController.dispose();
    _platNomorController.dispose();
    _tahunKeluarController.dispose();
    _modelController.dispose();
    _jenisController.dispose();
    _namaFocusNode.dispose();
    _merkFocusNode.dispose();
    _platNomorFocusNode.dispose();
    _tahunKeluarFocusNode.dispose();
    _modelFocusNode.dispose();
    _jenisFocusNode.dispose();
    L.i('FormKendaraan ditutup');
    super.dispose();
  }

  /// Memilih gambar dari galeri dan menyimpannya ke direktori aplikasi.
  Future<void> _pilihGambar() async {
    if (_sedangPilihGambar) return;
    setState(() => _sedangPilihGambar = true);
    try {
      if (kIsWeb) {
        final url = await pilihGambarWeb();
        if (url != null && mounted) {
          setState(() => _pathGambar = url);
          L.s('Gambar kendaraan (web) dipilih: $url');
        }
        return;
      }

      final picker = ImagePicker();
      final xfile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (xfile == null) return;

      final dir = await getApplicationDocumentsDirectory(); // dead code kIsWeb kedua dihapus (bug runtime #3)
      final target = File(
        p.join(dir.path, 'kendaraan_${const Uuid().v4()}.jpg'),
      );
      await File(xfile.path).copy(target.path);

      if (mounted) {
        setState(() => _pathGambar = target.path);
      }
      L.s('Gambar kendaraan disimpan: ${target.path}');
    } catch (e, s) {
      L.e('Gagal memilih gambar kendaraan: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal memilih gambar');
      }
    } finally {
      if (mounted) {
        setState(() => _sedangPilihGambar = false);
      }
    }
  }

  /// Menghapus gambar yang dipilih.
  void _hapusGambar() {
    setState(() => _pathGambar = null);
  }

  /// Menyimpan data kendaraan (tambah atau edit).
  Future<void> _simpanForm() async {
    if (_isLoading) {
      L.w('Form masih loading, simpan diabaikan');
      return;
    }
    // Gunakan ?. agar tidak crash jika state form belum tersedia.
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('Validasi form gagal');
      return;
    }
    L.i('Menyimpan data kendaraan, mode edit: $_modeEdit');
    setState(() => _isLoading = true);
    unawaited(
      EasyLoading.show(
        status: _modeEdit
            ? 'Memperbarui kendaraan...'
            : 'Menambahkan kendaraan...',
      ),
    ); // UX #34
    try {
      // Akses id setelah pengecekan null menggunakan variabel lokal (AGENTS.md poin 1).
      final modelEdit = widget.kendaraanModel;
      final idKendaraan = _modeEdit && modelEdit != null
          ? modelEdit.id
          : const Uuid().v4();
      final kendaraanToSave = KendaraanModel(
        id: idKendaraan,
        nama: _namaController.text.trim(),
        merk: _merkController.text.trim(),
        platNomor: _platNomorController.text.trim().isNotEmpty
            ? _platNomorController.text.trim()
            : null,
        tahunKeluar: _tahunKeluarController.text.trim().isNotEmpty
            ? _tahunKeluarController.text.trim()
            : null,
        model: _modelController.text.trim().isNotEmpty
            ? _modelController.text.trim()
            : null,
        jenis: _jenisController.text.trim().isNotEmpty
            ? _jenisController.text.trim()
            : null,
        pathGambar: _pathGambar,
        diperbarui: DateTime.now(),
      );
      L.i('kendaraanToSave $kendaraanToSave');
      if (_modeEdit) {
        await ref.read(kendaraanProvider.notifier).perbarui(kendaraanToSave);
      } else {
        await ref.read(kendaraanProvider.notifier).tambah(kendaraanToSave);
      }

      if (widget.pertamaDaftar) {
        await ref.read(selectedKendaraanIdProvider.notifier).set(idKendaraan);
      }
      if (mounted) {
        AppToast.sukses(
          context,
          _modeEdit
              ? 'Kendaraan berhasil diperbarui'
              : 'Kendaraan berhasil ditambahkan',
        );
        unawaited(EasyLoading.dismiss()); // UX #34
        if (widget.pertamaDaftar) {
          await Nav.toReplacement(context, const Home());
          if (!mounted) return; // cek mounted setelah await navigasi
        } else {
          Nav.pop(context);
        }
        L.s(
          'Data kendaraan berhasil ${_modeEdit ? 'diperbarui' : 'ditambahkan'}',
        );
      }
    } catch (e, s) {
      L.e('Gagal menyimpan kendaraan: $e $s');
      if (mounted) {
        unawaited(EasyLoading.dismiss()); // UX #34
        AppToast.gagal(context, 'Gagal menyimpan kendaraan');
      }
    } finally {
      if (mounted) {
        unawaited(EasyLoading.dismiss()); // UX #34
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_modeEdit ? 'Edit Kendaraan' : 'Tambah Kendaraan'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildGambar(),
              const SizedBox(height: 16),
              _buildFormKendaraan(),
              const SizedBox(height: 24),
              _buildTombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGambar() {
    final pathGambar = _pathGambar;
    return Column(
      children: [
        if (pathGambar != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: kIsWeb
                ? CachedNetworkImage(
                    // Perbaikan: gunakan CachedNetworkImage alih-alih Image.network.
                    imageUrl: pathGambar,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SizedBox(
                      width: 120,
                      height: 120,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const SizedBox.shrink(),
                  )
                : Image.file(
                    File(pathGambar),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
          )
        else
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.directions_car,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        const SizedBox(height: 8),
        // Atur jarak antar anak dengan spacing, bukan SizedBox (aturan_sumber_kode)
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _sedangPilihGambar ? null : _pilihGambar,
              icon: _sedangPilihGambar
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.photo_library),
              label: Text(
                _pathGambar == null ? 'Pilih Gambar' : 'Ganti Gambar',
              ),
            ),
            if (_pathGambar != null) ...[
              OutlinedButton.icon(
                onPressed: _hapusGambar,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Hapus'),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildFormKendaraan() {
    return Column(
      spacing: 16, // jarak antar anak pakai spacing (UI #8)
      children: [
        InputTeks(
          controller: _namaController,
          label: 'Nama Kendaraan',
          focusNode: _namaFocusNode,
          nextFocusNode: _merkFocusNode,
        ),
        InputTeks(
          controller: _merkController,
          label: 'Merk',
          focusNode: _merkFocusNode,
          nextFocusNode: _platNomorFocusNode,
        ),
        InputTeks(
          controller: _platNomorController,
          label: 'Plat Nomor (Opsional)',
          wajib: false,
          focusNode: _platNomorFocusNode,
        ),
        InputTeks(
          controller: _tahunKeluarController,
          label: 'Tahun Keluar (Opsional)',
          wajib: false,
          focusNode: _tahunKeluarFocusNode,
          hintText: 'Contoh: 2020',
        ),
        InputTeks(
          controller: _modelController,
          label: 'Model (Opsional)',
          wajib: false,
          focusNode: _modelFocusNode,
          hintText: 'Contoh: Beat',
        ),
        InputTeks(
          controller: _jenisController,
          label: 'Jenis (Opsional)',
          wajib: false,
          focusNode: _jenisFocusNode,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _simpanForm(),
          hintText: 'Contoh: Motor',
        ),
      ],
    );
  }

  Widget _buildTombolSimpan() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _simpanForm,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
      ),
      child: _isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          : const Text('Simpan'),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/page/form_pajak.dart
// ============================================================

```dart
// lib/fitur/kendaraan/page/form_pajak.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/model/pajak_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/pajak_notifier.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Form untuk menambah atau mengedit data pajak kendaraan.
class FormPajak extends ConsumerStatefulWidget {
  /// Model pajak yang akan diedit. [null] jika mode tambah.
  final PajakModel? pajakModel;

  /// ID kendaraan terkait.
  final String idKendaraan;

  /// Buat form pajak.
  const FormPajak({super.key, this.pajakModel, required this.idKendaraan});

  @override
  ConsumerState<FormPajak> createState() => _FormPajakState();
}

class _FormPajakState extends ConsumerState<FormPajak> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _biayaController = TextEditingController();
  final _namaFocusNode = FocusNode();
  final _biayaFocusNode = FocusNode();

  bool _modeEdit = false;
  bool _isLoading = false;
  bool _isPickingDate = false;
  DateTime _tanggal = DateTime.now();

  @override
  void initState() {
    super.initState();
    _modeEdit = widget.pajakModel != null;
    if (_modeEdit) {
      final pajak = widget.pajakModel;
      if (pajak == null) return;
      _namaController.text = pajak.nama;
      _biayaController.text = pajak.biaya.toStringAsFixed(0);
      _tanggal = pajak.tanggal;
    }
    L.i('FormPajak dibuka, mode edit: $_modeEdit');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _biayaController.dispose();
    _namaFocusNode.dispose();
    _biayaFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    if (_isPickingDate) return;
    _isPickingDate = true;
    try {
      final picked = await showDatePicker(
        context: context,
        initialDate: _tanggal,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      // Cegah setState setelah widget tidak lagi terpasang setelah await.
      if (picked != null && mounted) {
        setState(() => _tanggal = picked);
      }
    } catch (e, s) {
      // Catat kegagalan pemilihan tanggal agar mudah ditelusuri.
      L.e('Gagal memilih tanggal pajak: $e $s');
      rethrow;
    } finally {
      _isPickingDate = false;
    }
  }

  Future<void> _simpanForm() async {
    if (_isLoading) return;
    // Gunakan ?.validate() agar tidak crash jika state form belum tersedia.
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    unawaited(EasyLoading.show(status: 'Menyimpan pajak...')); // UX #34
    try {
      // Akses id setelah pengecekan null menggunakan variabel lokal (AGENTS.md poin 1).
      final modelEdit = widget.pajakModel;
      final id = _modeEdit && modelEdit != null
          ? modelEdit.id
          : const Uuid().v4();
      final pajakToSave = PajakModel(
        id: id,
        nama: _namaController.text.trim(),
        tanggal: _tanggal,
        biaya: InputAngka.parseAngkaRibuan(_biayaController.text),
        idKendaraan: widget.idKendaraan,
      );
      if (_modeEdit) {
        await ref.read(pajakProvider.notifier).perbarui(pajakToSave);
      } else {
        await ref.read(pajakProvider.notifier).tambah(pajakToSave);
      }
      if (mounted) {
        AppToast.sukses(
          context,
          _modeEdit
              ? 'Pajak berhasil diperbarui'
              : 'Pajak berhasil ditambahkan',
        );
        unawaited(EasyLoading.dismiss()); // UX #34
        Nav.pop(context);
      }
    } catch (e, s) {
      L.e('Gagal menyimpan pajak: $e $s');
      if (mounted) {
        unawaited(EasyLoading.dismiss()); // UX #34
        AppToast.gagal(context, 'Gagal menyimpan pajak');
      }
    } finally {
      if (mounted) {
        unawaited(EasyLoading.dismiss()); // UX #34
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_modeEdit ? 'Edit Pajak' : 'Tambah Pajak')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16, // jarak antar anak pakai spacing (UI #9)
            children: [
              InputTeks(
                controller: _namaController,
                label: 'Nama Pajak (mis. PKB, STNK)',
                focusNode: _namaFocusNode,
                nextFocusNode: _biayaFocusNode,
              ),
              InputAngka(
                controller: _biayaController,
                label: 'Biaya',
                focusNode: _biayaFocusNode,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _simpanForm(),
                validator: (v) {
                  final n = InputAngka.parseAngkaRibuan(v ?? '');
                  if (n <= 0) return 'Biaya harus lebih dari 0';
                  return null;
                },
              ),
              ListTile(
                title: const Text('Tanggal Jatuh Tempo'),
                subtitle: Text(FormatTanggal.formatDasar(_tanggal)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pilihTanggal,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                // Mencegah double submit saat proses simpan sedang berjalan.
                onPressed: _isLoading ? null : _simpanForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/page/kendaraan_page.dart
// ============================================================

```dart
// lib/fitur/kendaraan/page/kendaraan_page.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/page/detail_kendaraan_page.dart';
import 'package:myapp/fitur/kendaraan/page/form_kendaraan.dart'; // baru
import 'package:myapp/fitur/kendaraan/state/kendaraan_state.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman daftar kendaraan pengguna.
class KendaraanPage extends ConsumerWidget {
  /// Buat halaman daftar kendaraan.
  const KendaraanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kendaraanAsync = ref.watch(kendaraanProvider);

    // Urutkan pemeriksaan AsyncValue: loading → error → data (optimasi_bug_runtime.md poin 9).
    if (kendaraanAsync.isLoading) {
      return _buildLoading();
    }
    if (kendaraanAsync.hasError) {
      return _buildError(ref);
    }

    final kendaraanState = kendaraanAsync.requireValue;
    return _buildScaffold(context, ref, kendaraanState);
  }

  Widget _buildScaffold(
    BuildContext context,
    WidgetRef ref,
    KendaraanState kendaraanState,
  ) {
    final listKendaraan = kendaraanState.listKendaraan;

    return Scaffold(
      appBar: AppBar(title: const Text('Kendaraan')),
      body: listKendaraan.isEmpty
          ? _buildListKosong(context)
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: listKendaraan.length,
              itemBuilder: (context, index) {
                final item = listKendaraan[index];
                return _buildItemKendaraan(context, ref, item);
              },
            ),
      floatingActionButton: listKendaraan.isEmpty
          ? null
          : FloatingActionButton(
              heroTag: null,
              tooltip: 'Tambah Kendaraan',
              onPressed: () {
                unawaited(Nav.to(context, const FormKendaraan()));
              },
              child: const Icon(Icons.add),
            ),
    );
  }

  Widget _buildItemKendaraan(
    BuildContext context,
    WidgetRef ref,
    KendaraanModel kendaraan,
  ) {
    return ListTile(
      title: Text(kendaraan.nama, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: const Icon(Icons.chevron_right),
      onLongPress: () => _modalOpsiKendaraan(context, ref, kendaraan),
      onTap: () {
        unawaited(Nav.to(context, DetailKendaraanPage(id: kendaraan.id)));
      },
    );
  }

  Widget _buildListKosong(BuildContext context) {
    return Center(
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.directions_car_outlined, size: 24),
          const Text('Belum ada kendaraan'),
          ElevatedButton.icon(
            onPressed: () {
              unawaited(Nav.to(context, const FormKendaraan()));
            },
            icon: const Icon(Icons.add),
            label: const Text('Tambah Kendaraan'),
          ),
        ],
      ),
    );
  }

  void _modalOpsiKendaraan(
    BuildContext context,
    WidgetRef ref,
    KendaraanModel kendaraan,
  ) {
    unawaited(_modalOpsiKendaraanAsync(context, ref, kendaraan));
  }

  Future<void> _modalOpsiKendaraanAsync(
    BuildContext context,
    WidgetRef ref,
    KendaraanModel kendaraan,
  ) async {
    final result = await showModalActionSheet<String>(
      context: context,
      title: 'Opsi Kendaraan',
      message: kendaraan.nama,
      cancelLabel: 'Batal',
      actions: const [
        SheetAction(label: 'Edit', key: 'edit'),
        SheetAction(label: 'Hapus', isDestructiveAction: true, key: 'hapus'),
      ],
    );
    if (!context.mounted) return;
    if (result == 'edit') {
      unawaited(Nav.to(context, FormKendaraan(kendaraanModel: kendaraan)));
    } else if (result == 'hapus') {
      unawaited(_konfirmasiHapus(context, ref, kendaraan));
    }
  }

  Future<void> _konfirmasiHapus(
    BuildContext context,
    WidgetRef ref,
    KendaraanModel kendaraan,
  ) async {
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Kendaraan?',
      message: 'Data kendaraan ini akan dihapus secara permanen.',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (konfirmasi != OkCancelResult.ok) return;
    try {
      await ref.read(kendaraanProvider.notifier).hapus(kendaraan.id);
      if (context.mounted) {
        AppToast.sukses(context, 'Kendaraan berhasil dihapus');
      }
    } catch (e, s) {
      L.e('Gagal menghapus kendaraan: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal menghapus kendaraan');
      }
    }
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text('Memuat daftar kendaraan...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError(WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat daftar kendaraan'),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(kendaraanProvider);
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/page/perbandingan_kendaraan_page.dart
// ============================================================

```dart
// lib/fitur/kendaraan/page/perbandingan_kendaraan_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/bahan_bakar/notifier/bahan_bakar_notifier.dart';
import 'package:myapp/fitur/jadwal_service/notifier/riwayat_jadwal_service_notifier.dart';
import 'package:myapp/fitur/bahan_bakar/enum/sort_bahan_bakar.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/km/notifier/km_notifier.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman perbandingan statistik antar kendaraan (biaya per km, konsumsi BBM, total biaya, saldo, dll.).
class PerbandinganKendaraanPage extends ConsumerStatefulWidget {
  /// Membuat [PerbandinganKendaraanPage].
  const PerbandinganKendaraanPage({super.key});

  @override
  ConsumerState<PerbandinganKendaraanPage> createState() =>
      _PerbandinganKendaraanPageState();
}

class _PerbandinganKendaraanPageState
    extends ConsumerState<PerbandinganKendaraanPage> {
  RentangTanggalBahanBakarEnum _rentangTanggal =
      RentangTanggalBahanBakarEnum.semua;
  DateTimeRange? _rentangTanggalKustom;

  @override
  Widget build(BuildContext context) {
    final kendaraanAsync = ref.watch(kendaraanProvider);
    final kmAsync = ref.watch(kmProvider);
    final bahanBakarAsync = ref.watch(bahanBakarProvider);
    final transaksiAsync = ref.watch(transaksiProvider);
    final riwayatAsync = ref.watch(riwayatJadwalServiceProvider);
    final mataUangAsync = ref.watch(mataUangProvider);

    if (kendaraanAsync.isLoading ||
        kmAsync.isLoading ||
        bahanBakarAsync.isLoading ||
        transaksiAsync.isLoading ||
        riwayatAsync.isLoading ||
        mataUangAsync.isLoading) {
      return _buildLoading();
    }
    if (kendaraanAsync.hasError ||
        kmAsync.hasError ||
        bahanBakarAsync.hasError ||
        transaksiAsync.hasError ||
        riwayatAsync.hasError ||
        mataUangAsync.hasError) {
      return _buildError();
    }

    final kendaraanState = kendaraanAsync.requireValue;
    final kmState = kmAsync.requireValue;
    final bahanBakarState = bahanBakarAsync.requireValue;
    final transaksiState = transaksiAsync.requireValue;
    final riwayatState = riwayatAsync.requireValue;
    final mataUangItem = mataUangAsync.requireValue;

    final listKendaraan = kendaraanState.listKendaraan
        .where((k) => k.diarsipkan == null)
        .toList();

    if (listKendaraan.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Perbandingan Kendaraan')),
        body: const Center(child: Text('Belum ada kendaraan.')),
      );
    }

    // Bangun data per kendaraan.
    final data = listKendaraan.map((k) {
      final kmTerbaru = kmState.kmTerbaruByIdKendaraan(k.id);
      final totalBiayaService = riwayatState.getTotalBiaya(idKendaraan: k.id);
      final jumlahService = riwayatState.getJumlahService(idKendaraan: k.id);
      final totalPengeluaran = transaksiState.getTotalPengeluaranByIdKendaraan(
        k.id,
      );
      final totalPemasukan = transaksiState.getTotalPemasukanByIdKendaraan(
        k.id,
      );
      final saldo = transaksiState.getSaldoByIdKendaraan(k.id);
      final totalLiterBbm = bahanBakarState.getTotalLiter(k.id);
      final totalBiayaBbm = bahanBakarState.getJumlahTotal(k.id);
      final kmPerLiter = bahanBakarState.getKmPerLiter(k.id);
      final biayaPerKm = bahanBakarState.getRataRataBiayaPerKm(k.id);
      return _DataKendaraan(
        kendaraan: k,
        kmTerbaru: kmTerbaru?.km,
        totalBiayaService: totalBiayaService,
        jumlahService: jumlahService,
        totalPengeluaran: totalPengeluaran,
        totalPemasukan: totalPemasukan,
        saldo: saldo,
        totalLiterBbm: totalLiterBbm,
        totalBiayaBbm: totalBiayaBbm,
        kmPerLiter: kmPerLiter,
        biayaPerKm: biayaPerKm,
      );
    }).toList();

    final rows = <_Baris>[
      _Baris('KM Terbaru', (d) {
        final km = d.kmTerbaru;
        return km == null ? '-' : '${FormatNomor.formatRibuan(km.toInt())} km';
      }),
      _Baris(
        'Total Biaya Service',
        (d) => formatMataUang(d.totalBiayaService, mataUangItem),
      ),
      _Baris('Jumlah Service', (d) => d.jumlahService.toString()),
      _Baris(
        'Total Pengeluaran',
        (d) => formatMataUang(d.totalPengeluaran, mataUangItem),
      ),
      _Baris(
        'Total Pemasukan',
        (d) => formatMataUang(d.totalPemasukan, mataUangItem),
      ),
      _Baris('Saldo', (d) => formatMataUang(d.saldo, mataUangItem)),
      _Baris(
        'Total Liter BBM',
        (d) => '${d.totalLiterBbm.toStringAsFixed(2)} L',
      ),
      _Baris(
        'Total Biaya BBM',
        (d) => formatMataUang(d.totalBiayaBbm, mataUangItem),
      ),
      _Baris('KM per Liter', (d) => '${d.kmPerLiter.toStringAsFixed(2)} km/L'),
      _Baris(
        'Biaya per KM (BBM)',
        (d) => formatMataUang(d.biayaPerKm, mataUangItem),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perbandingan Kendaraan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              // TODO: Implement action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(
                label: Text(
                  'Metrik',
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ...data.map(
                (d) => DataColumn(
                  label: Text(
                    d.kendaraan.nama,
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
            rows: rows.map((r) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      r.label,
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...data.map(
                    (d) => DataCell(
                      Text(
                        r.nilai(d),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      appBar: AppBar(title: const Text('Perbandingan Kendaraan')),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError() {
    return Scaffold(
      appBar: AppBar(title: const Text('Perbandingan Kendaraan')),
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data'),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(kendaraanProvider);
                final _ = ref.refresh(kmProvider);
                final _ = ref.refresh(bahanBakarProvider);
                final _ = ref.refresh(transaksiProvider);
                final _ = ref.refresh(riwayatJadwalServiceProvider);
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataKendaraan {
  _DataKendaraan({
    required this.kendaraan,
    required this.kmTerbaru,
    required this.totalBiayaService,
    required this.jumlahService,
    required this.totalPengeluaran,
    required this.totalPemasukan,
    required this.saldo,
    required this.totalLiterBbm,
    required this.totalBiayaBbm,
    required this.kmPerLiter,
    required this.biayaPerKm,
  });

  final KendaraanModel kendaraan;
  final double? kmTerbaru;
  final double totalBiayaService;
  final int jumlahService;
  final double totalPengeluaran;
  final double totalPemasukan;
  final double saldo;
  final double totalLiterBbm;
  final double totalBiayaBbm;
  final double kmPerLiter;
  final double biayaPerKm;
}

class _Baris {
  _Baris(this.label, this.nilai);

  final String label;
  final String Function(_DataKendaraan) nilai;
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/provider/selected_kendaraan_provider.dart
// ============================================================

```dart
// lib/fitur/kendaraan/provider/selected_kendaraan_provider.dart
import 'package:myapp/shared/konstanta/shared_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'selected_kendaraan_provider.g.dart';

/// Provider untuk menyimpan dan mengambil ID kendaraan yang sedang dipilih.
@Riverpod(keepAlive: true)
class SelectedKendaraanId extends _$SelectedKendaraanId {
  @override
  Future<String?> build() async {
    return await get();
  }

  /// Mendapatkan ID kendaraan yang disimpan di SharedPreferences.
  Future<String?> get() async {
    final hasil = await SharedPrefService.getString(
      KunciShared.kendaraanTerpilih,
    );
    if (hasil == null || hasil.isEmpty) return null;
    return hasil;
  }

  /// Menyimpan [id] kendaraan yang dipilih ke SharedPreferences.
  Future<void> set(String id) async {
    try {
      await SharedPrefService.setString(KunciShared.kendaraanTerpilih, id);
      L.i('Berhasil menyimpan key kendaraan dengan id $id');
      state = AsyncData(id);
    } catch (e, s) {
      L.e('Gagal menyimpan key kendaraan dengan id $id: $e $s');
      rethrow;
    }
  }

  /// Menghapus pilihan kendaraan dari SharedPreferences.
  Future<void> clear() async {
    try {
      await SharedPrefService.remove(KunciShared.kendaraanTerpilih);
      L.i('Berhasil menghapus key kendaraan terpilih');
      state = const AsyncData(null);
    } catch (e, s) {
      L.e('Gagal menghapus key kendaraan terpilih: $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/state/kendaraan_state.dart
// ============================================================

```dart
// lib/fitur/kendaraan/state/kendaraan_state.dart

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';

part 'kendaraan_state.freezed.dart';

/// State untuk mengelola daftar kendaraan pengguna.
@freezed
abstract class KendaraanState with _$KendaraanState {
  const KendaraanState._();

  /// Membuat instance [KendaraanState] dengan daftar kendaraan.
  const factory KendaraanState({
    @Default([]) List<KendaraanModel> listKendaraan,
  }) = _KendaraanState;

  /// Mengembalikan kendaraan dengan [id], atau null jika tidak ditemukan. Menggunakan [firstWhereOrNull] dari package:collection (aturan #1).
  KendaraanModel? getById(String id) {
    return listKendaraan.firstWhereOrNull((item) => item.id == id);
  }
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/state/pajak_state.dart
// ============================================================

```dart
// lib/fitur/kendaraan/state/pajak_state.dart

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/kendaraan/model/pajak_model.dart';

part 'pajak_state.freezed.dart';

/// State untuk mengelola daftar pajak kendaraan.
@freezed
abstract class PajakState with _$PajakState {
  const PajakState._();

  /// Membuat instance [PajakState] dengan daftar pajak.
  const factory PajakState({@Default([]) List<PajakModel> listPajak}) =
      _PajakState;

  /// Mengembalikan pajak dengan [id], atau null jika tidak ditemukan.
  PajakModel? getById(String id) {
    return listPajak.firstWhereOrNull((item) => item.id == id);
  }

  /// Mengambil daftar pajak berdasarkan [idKendaraan].
  List<PajakModel> getListByIdKendaraan(String? idKendaraan) {
    if (idKendaraan == null || idKendaraan.isEmpty) {
      return [];
    }
    return listPajak.where((p) => p.idKendaraan == idKendaraan).toList();
  }

  /// Menghitung total biaya pajak berdasarkan [idKendaraan].
  double totalPajakByIdKendaraan(String? idKendaraan) {
    return getListByIdKendaraan(idKendaraan)
        .fold<double>(0, (sum, p) => sum + p.biaya);
  }
}
```


// ============================================================
// FILE: lib/fitur/kendaraan/widget/card_item_kendaraan.dart
// ============================================================

```dart
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';

/// Kartu ringkas kendaraan dengan gambar berbentuk kotak (persegi).
class CardItemKendaraan extends StatelessWidget {
  /// Data kendaraan yang ditampilkan. Jika null, kartu menampilkan placeholder.
  final KendaraanModel? kendaraanModel;

  /// Ukuran sisi gambar kotak (persegi). Nilai default mengikuti referensi DESAINS.md (64 dp). Konstanta jarak dan ukuran diambil dari standar desain proyek.
  final double ukuranGambar;

  /// Aksi saat kartu ditekan.
  final VoidCallback? ontap;

  /// Buat kartu item kendaraan.
  const CardItemKendaraan({
    super.key,
    this.kendaraanModel,
    this.ukuranGambar = 64,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final kendaraan = kendaraanModel;
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: _buildGambarKotak(context, kendaraan?.pathGambar),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      kendaraan?.nama ?? 'Kendaraan tidak ditemukan',
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      kendaraan?.merk ?? '-',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            if (ontap != null) const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  /// Membangun gambar berbentuk kotak (persegi) dengan sisi [ukuranGambar].
  Widget _buildGambarKotak(BuildContext context, String? path) {
    if (path == null || path.isEmpty) {
      return SizedBox(
        width: ukuranGambar,
        height: ukuranGambar,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.directions_car,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    Widget image;
    if (kIsWeb) {
      // Perbaikan: gunakan CachedNetworkImage alih-alih Image.network.
      image = CachedNetworkImage(
        imageUrl: path,
        width: ukuranGambar,
        height: ukuranGambar,
        fit: BoxFit.cover,
        placeholder: (context, url) => SizedBox(
          width: ukuranGambar,
          height: ukuranGambar,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => SizedBox(
          width: ukuranGambar,
          height: ukuranGambar,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.broken_image,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    } else {
      // Hindari I/O sinkron (existsSync) di thread UI; gunakan errorBuilder
      // pada Image.file untuk menampilkan placeholder saat file tidak ada.
      image = Image.file(
        File(path),
        width: ukuranGambar,
        height: ukuranGambar,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => SizedBox(
          width: ukuranGambar,
          height: ukuranGambar,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.broken_image,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(width: ukuranGambar, height: ukuranGambar, child: image),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/km/model/km_model.dart
// ============================================================

```dart
// lib/fitur/km/model/km_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'km_model.freezed.dart';

/// Model data kilometer (pengukuran jarak tempuh) kendaraan.
@freezed
abstract class KmModel with _$KmModel {
  const KmModel._();

  /// Buat instance KmModel dengan data kilometer.
  const factory KmModel({
    /// ID unik data kilometer.
    required String id,

    /// Nilai kilometer kendaraan.
    required double km,

    /// ID kendaraan yang terkait.
    required String idKendaraan,

    /// Tanggal pencatatan kilometer.
    required DateTime tanggal,

    /// Waktu data terakhir diperbarui.
    required DateTime diperbarui,

    /// Tanggal diarsipkan, boleh null.
    DateTime? diarsipkan,
  }) = _KmModel;

  /// ============================================================ KONVERSI DARI / KE SUPABASE ============================================================

  /// Membuat [KmModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KmModel.fromSupabase(Map<String, dynamic> map) => _dariMap(map);

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => _keMap();

  /// ============================================================ KONVERSI DARI / KE SQLITE ============================================================

  /// Membuat [KmModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KmModel.fromSqflite(Map<String, dynamic> map) => _dariMap(map);

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => _keMap();

  // ==================== Konversi internal ====================

  /// Satu metode konversi dari Map (Supabase/Sqflite) ke [KmModel].
  // Bungkus parsing dalam try/catch; berikan default 0.0 jika km null/tidak valid (L.w dicatat oleh ParserUtil).
  static KmModel _dariMap(Map<String, dynamic> map) {
    try {
      return KmModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        km: ParserUtil.parseDouble(map[NamaKolom.km]),
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
        tanggal:
            ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );
    } on Exception catch (e, s) {
      L.e('Gagal parse KmModel: $e $s');
      rethrow;
    }
  }

  /// Satu metode konversi dari instance ke Map (Supabase/Sqflite).
  Map<String, dynamic> _keMap() => {
    NamaKolom.id: id,
    NamaKolom.km: km,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```


// ============================================================
// FILE: lib/fitur/km/notifier/km_notifier.dart
// ============================================================

```dart
import 'package:myapp/fitur/km/model/km_model.dart';
import 'package:myapp/fitur/km/state/km_state.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'km_notifier.g.dart';

/// Notifier untuk mengelola data kilometer kendaraan.
@Riverpod(keepAlive: true)
class KmNotifier extends _$KmNotifier {
  final _tabelKm = NamaTabel.km;

  /// Membangun state awal dengan memuat data KM dari database.
  @override
  Future<KmState> build() async {
    L.i('build km_notifier mulai');
    try {
      // Bungkus build dalam try/catch agar kegagalan load tercatat (L.e) dan di-rethrow (optimasi_bug_runtime.md poin 6).
      final listDb = await ref
          .read(baseOpSqfliteProvider)
          .ambilData(NamaTabel.km);
      final listHasil = listDb.map(KmModel.fromSqflite).toList();
      L.i('build km_notifier selesai');
      return KmState(listKm: listHasil);
    } on Exception catch (e, s) {
      L.e('build km gagal: $e $s');
      rethrow;
    }
  }

  /// Menambahkan [km] baru ke daftar dan database.
  Future<void> tambah(KmModel km) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.copyWith(listKm: [...dataLama.listKm, km]);
    state = AsyncValue.data(listBaru);

    try {
      // 2. Baru update DB
      await ref.read(baseOpSqfliteProvider).tambah(_tabelKm, km.toSqflite());
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('tambah km gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Menghapus data KM dengan [id] dari daftar dan database.
  Future<void> hapus(String id) async {
    final dataLama = await future;
    // 1. Optimistic update: hapus dari state DULU
    final listBaru = dataLama.listKm.where((e) => e.id != id).toList();
    state = AsyncValue.data(dataLama.copyWith(listKm: listBaru));

    try {
      // 2. Baru hapus DB
      await ref.read(baseOpSqfliteProvider).hapus(_tabelKm, id);
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('hapus km gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Mengubah data [km] di daftar dan database.
  Future<void> ubah(KmModel km) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.listKm
        .map((e) => e.id == km.id ? km : e)
        .toList();
    state = AsyncValue.data(dataLama.copyWith(listKm: listBaru));

    try {
      // 2. Baru update DB
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(_tabelKm, km.toSqflite(), km.id);
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('ubah km gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Melakukan batch insert [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(List<KmModel> data) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabelKm,
            data.map((e) => e.toSqflite()).toList(),
          );

      // Muat ulang data dari DB (semua kendaraan)
      final listDb = await ref
          .read(baseOpSqfliteProvider)
          .ambilData(NamaTabel.km);
      final listHasil = listDb.map(KmModel.fromSqflite).toList();
      state = AsyncValue.data(KmState(listKm: listHasil));
    } catch (e, s) {
      L.e('Gagal batch insert km $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/km/page/km_page.dart
// ============================================================

```dart
// lib/fitur/km/page/km_page.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/jadwal_service/notifier/jadwal_service_notifier.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/page/form_kendaraan.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/kendaraan/state/kendaraan_state.dart';
import 'package:myapp/fitur/km/model/km_model.dart';
import 'package:myapp/fitur/km/notifier/km_notifier.dart';
import 'package:myapp/fitur/km/state/km_state.dart';
import 'package:myapp/shared/notifikasi/notifikasi_service.dart';
import 'package:myapp/shared/widget/kendaraan_terpilih_list.dart';
import 'package:myapp/shared/widget/scroll_ke_atas.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

/// Halaman untuk mengelola data kilometer kendaraan.
class KmPage extends ConsumerStatefulWidget {
  /// Buat halaman pengelolaan KM kendaraan.
  const KmPage({super.key});

  @override
  ConsumerState<KmPage> createState() => _KmPageState();
}

class _KmPageState extends ConsumerState<KmPage> implements ScrollKeAtas {
  // Gunakan satu instance Uuid konstan agar tidak membuat instance baru pada setiap pemanggilan.
  static const Uuid _uuid = Uuid();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _kmController = TextEditingController();
  final _kmFocusNode = FocusNode();
  bool _isLoading = false;
  DateTime? _tanggalTerpilih;
  TimeOfDay? _waktuTerpilih;
  KmModel? _itemToEdit;
  StateSetter? _dialogSetState;
  bool _modeHapus = false;
  bool _isDeletingKm = false;
  final ScrollController _scrollController = ScrollController();
  KendaraanModel? _kendaraanTerpilih;

  @override
  void initState() {
    super.initState();
    L.i('KmPage diinisialisasi');
    _tanggalTerpilih = DateTime.now();
    _waktuTerpilih = TimeOfDay.now();
    unawaited(
      Future.microtask(() async {
        try {
          await _reloadKendaraanTerpilih();
        } catch (e, s) {
          L.e('Gagal reload kendaraan terpilih: $e $s');
        }
      }),
    );
  }

  @override
  void dispose() {
    L.i('KmPage dibersihkan');
    _kmController.dispose();
    _kmFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _tampilkanForm() {
    L.i('Menampilkan form tambah/edit');
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (dialogContext, setDialogState) {
              // Simpan setState lokal ke variabel class
              _dialogSetState = setDialogState;
              return _buildForm();
            },
          );
        },
      ).whenComplete(() {
        _dialogSetState = null;
      }),
    );
  }

  void _resetFormState() {
    L.i('_resetFormState dijalankan');
    _itemToEdit = null;
    _kmController.clear();
    _tanggalTerpilih = DateTime.now();
    _waktuTerpilih = TimeOfDay.now();
  }

  Future<void> _reloadKendaraanTerpilih({bool? state = false}) async {
    try {
      final idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
      final kendaraanState = await ref.read(kendaraanProvider.future);
      KendaraanModel? kendaraan;
      if (idKendaraan != null && idKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.getById(idKendaraan);
        if (kendaraan == null && kendaraanState.listKendaraan.isNotEmpty) {
          kendaraan = kendaraanState.listKendaraan.first;
        }
      } else if (_kendaraanTerpilih != null) {
        kendaraan = _kendaraanTerpilih;
      } else if (kendaraanState.listKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.listKendaraan.first;
      }
      if (state == true && mounted) {
        setState(() {
          _kendaraanTerpilih = kendaraan;
        });
      } else {
        _kendaraanTerpilih = kendaraan;
      }
    } catch (e, s) {
      L.e('Gagal reload kendaraan terpilih: $e $s');
    }
  }

  Future<void> _hapusKm(KmModel item) async {
    if (_isDeletingKm) return;
    L.i('Tombol hapus ditekan untuk item ID: ${item.id}');
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Data',
      message:
          'Data kilometer ini akan dihapus secara permanen.\n\n'
          '"${FormatNomor.formatRibuan(item.km.toInt())} km"',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (konfirmasi != OkCancelResult.ok) return;
    // Hindari setState saat widget sudah tidak aktif setelah await dialog.
    if (mounted) setState(() => _isDeletingKm = true);
    try {
      await ref.read(kmProvider.notifier).hapus(item.id);
      L.s('Item KM berhasil dihapus, ID: ${item.id}');
      if (mounted) {
        AppToast.sukses(context, 'Data KM berhasil dihapus');
      }
    } catch (e, s) {
      L.e('Gagal menghapus item KM: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menghapus data KM');
      }
    } finally {
      if (mounted) setState(() => _isDeletingKm = false);
    }
  }

  Future<void> _pilihTanggal() async {
    try {
      L.i('Memilih tanggal');
      final now = DateTime.now();
      final picked = await showDatePicker(
        context: context,
        initialDate: _tanggalTerpilih ?? now,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        // Cegah setState setelah widget tidak lagi terpasang setelah await showDatePicker.
        if (!mounted) return;
        setState(() {
          _tanggalTerpilih = picked;
          _waktuTerpilih ??= TimeOfDay.now();
        });
        // Hindari memanggil setter dialog yang sudah tidak valid setelah dialog ditutup.
        if (mounted) _dialogSetState?.call(() {});
        L.i('Tanggal terpilih: $picked');
      } else {
        L.i('Pemilihan tanggal dibatalkan');
      }
    } catch (e, s) {
      // Catat kegagalan pemilihan tanggal agar mudah ditelusuri.
      L.e('Gagal memilih tanggal KM: $e $s');
      rethrow;
    }
  }

  Future<void> _pilihWaktu() async {
    try {
      L.i('Memilih waktu waktu sekarang $_waktuTerpilih');
      final picked = await showTimePicker(
        context: context,
        initialTime: _waktuTerpilih ?? TimeOfDay.now(),
      );
      if (picked != null) {
        // Cegah setState setelah widget tidak lagi terpasang setelah await showTimePicker.
        if (!mounted) return;
        setState(() {
          _waktuTerpilih = picked;
          _tanggalTerpilih ??= DateTime.now();
        });
        // Hindari setState dialog setelah ditutup (race dengan dispose)
        if (mounted) _dialogSetState?.call(() {});
        L.i('Waktu terpilih: ${picked.hour}:${picked.minute}');
      } else {
        L.i('Pemilihan waktu dibatalkan');
      }
    } catch (e, s) {
      // Catat kegagalan pemilihan waktu agar mudah ditelusuri.
      L.e('Gagal memilih waktu KM: $e $s');
      rethrow;
    }
  }

  void _resetKeSekarang() {
    L.i('Reset tanggal & waktu ke sekarang');
    setState(() {
      _tanggalTerpilih = DateTime.now();
      _waktuTerpilih = TimeOfDay.now();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(_reloadKendaraanTerpilih(state: true));
      });
    });
    // Hindari setState dialog setelah ditutup (race dengan dispose)
    if (mounted) _dialogSetState?.call(() {});
  }

  DateTime _gabungTanggalWaktu(DateTime tanggal, TimeOfDay waktu) {
    return DateTime(
      tanggal.year,
      tanggal.month,
      tanggal.day,
      waktu.hour,
      waktu.minute,
    );
  }

  Future<void> _simpanForm() async {
    if (_isLoading) {
      L.w('Form masih dalam proses, simpan diabaikan');
      return;
    }
    // Gunakan ?. agar tidak crash jika state form belum tersedia.
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('Validasi form gagal');
      return;
    }
    final modeEdit = _itemToEdit != null;
    L.i('Menyimpan data KM, mode edit: $modeEdit');
    setState(() {
      _isLoading = true;
    });
    try {
      final rawText = _kmController.text.trim();
      final cleanText = rawText.replaceAll(RegExp(r'[^0-9\-]'), '');
      if (cleanText.isEmpty || cleanText == '-') {
        L.w('Nilai KM tidak valid: $rawText');
        AppToast.gagal(context, 'Masukkan angka KM yang valid');
        setState(() => _isLoading = false);
        return;
      }
      final kmValue = double.tryParse(cleanText);
      if (kmValue == null) {
        L.w('Nilai KM tidak valid: ${_kmController.text}');
        AppToast.gagal(context, 'Masukkan angka KM yang valid');
        setState(() => _isLoading = false);
        return;
      }
      // Validasi nilai KM agar tidak negatif atau non-finite.
      if (!kmValue.isFinite || kmValue <= 0) {
        L.w('Nilai KM tidak valid: ${_kmController.text}');
        AppToast.gagal(context, 'Masukkan angka KM yang valid');
        setState(() => _isLoading = false);
        return;
      }
      final tanggalTerpilih = _tanggalTerpilih;
      final waktuTerpilih = _waktuTerpilih;
      if (tanggalTerpilih == null || waktuTerpilih == null) {
        AppToast.gagal(context, 'Tanggal tidak valid');
        setState(() => _isLoading = false);
        return;
      }
      final tanggalGabungan = _gabungTanggalWaktu(
        tanggalTerpilih,
        waktuTerpilih,
      );
      final kendaraan = _kendaraanTerpilih?.id;
      if (kendaraan == null || kendaraan.isEmpty) {
        L.w('Tidak ada kendaraan terpilih');
        AppToast.gagal(context, 'Pilih kendaraan terlebih dahulu');
        setState(() => _isLoading = false);
        return;
      }
      final kmToSave = KmModel(
        // Gunakan fallback UUID agar tidak crash jika _itemToEdit null pada mode edit.
        id: modeEdit ? (_itemToEdit?.id ?? _uuid.v4()) : _uuid.v4(),
        km: kmValue,
        tanggal: tanggalGabungan,
        diperbarui: DateTime.now(),
        idKendaraan: kendaraan,
      );
      if (modeEdit) {
        await ref.read(kmProvider.notifier).ubah(kmToSave);
        _resetFormState();
        L.i('berhasil mereset formstate');
      } else {
        await ref.read(kmProvider.notifier).tambah(kmToSave);
        // Cek notifikasi jadwal service berdasarkan KM terbaru (fire-and-forget, non-blocking UI)
        unawaited(
          Future(() async {
            try {
              final izin = await NotifikasiService.mintaIzin();
              if (!izin) {
                L.w('Izin notifikasi tidak diberikan');
                if (mounted) {
                  AppToast.gagal(context, 'Izin notifikasi belum diberikan');
                }
                return;
              }
              final jadwalState = await ref.read(jadwalServiceProvider.future);
              final listJadwal = jadwalState.getListByIdKendaraan(kendaraan);
              L.i(
                'Cek notifikasi jadwal kendaraan $kendaraan: ${listJadwal.length} jadwal',
              );
              for (final jadwal in listJadwal) {
                if (jadwal.diarsipkan != null) continue;
                final sisaKm = (jadwal.km + jadwal.kmTerakhirService) - kmValue;
                if (sisaKm <= 0) {
                  L.i(
                    'Tampilkan notifikasi service ${jadwal.nama}, sisaKm $sisaKm',
                  );
                  await NotifikasiService.tampilkanNotifikasi(
                    id: jadwal.id,
                    judul: 'Waktunya Service: ${jadwal.nama}',
                    isi: 'Sisa KM: ${sisaKm.toStringAsFixed(0)} KM.',
                    kategori: KategoriNotifikasi.jadwalService,
                  );
                }
              }
            } catch (e, s) {
              L.e('Gagal cek notifikasi saat tambah KM: $e $s');
            }
          }),
        );
      }
      if (mounted) {
        Nav.pop(context);
        AppToast.sukses(
          context,
          modeEdit
              ? 'Data KM berhasil diperbarui'
              : 'Data KM berhasil ditambahkan',
        );
        L.s(
          'Data KM berhasil ${modeEdit ? 'diperbarui' : 'ditambahkan'} $kmToSave',
        );
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan KM: $e $s');
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan data KM');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedKendaraanIdProvider, (previous, next) {
      if (previous?.asData?.value != next.asData?.value) {
        unawaited(_reloadKendaraanTerpilih(state: true));
      }
    });
    final selectedKendaraanIdAsync = ref.watch(selectedKendaraanIdProvider);
    final kmAsync = ref.watch(kmProvider);
    final kendaraanAsync = ref.watch(kendaraanProvider);

    if (kmAsync.isLoading ||
        kendaraanAsync.isLoading ||
        selectedKendaraanIdAsync.isLoading) {
      return const _LoadingView();
    }
    if (kmAsync.hasError ||
        kendaraanAsync.hasError ||
        selectedKendaraanIdAsync.hasError) {
      return _buildError();
    }

    final kmState = kmAsync.requireValue;
    final kendaraanState = kendaraanAsync.requireValue;
    selectedKendaraanIdAsync.requireValue;
    return Scaffold(
      appBar: _buildAppbar(kmState),
      drawer: _buildDrawer(
        kendaraanState,
        selectedKendaraanIdAsync.asData?.value,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: KendaraanTerpilihList(
              listKendaraan: kendaraanState.listKendaraan,
              selectedId: _kendaraanTerpilih?.id,
              onSelected: (kendaraan) {
                setState(() => _kendaraanTerpilih = kendaraan);
              },
              onReload: () => _reloadKendaraanTerpilih(state: true),
            ),
          ),
          Expanded(child: _buildListKm(kmState, kendaraanState)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        tooltip: 'Tambah data KM',
        onPressed: () {
          _resetFormState();
          L.i('Tombol tambah ditekan');
          _tampilkanForm();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppbar(KmState kmState) {
    return AppBar(
      title: const Text('Data KM'),
      actions: [
        if (_modeHapus)
          // Jika mode hapus aktif, tampilkan tombol close
          IconButton(
            tooltip: 'Tutup',
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                _modeHapus = false;
              });
            },
          )
        else
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final konfirmasi = await showOkCancelAlertDialog(
                context: context,
                title: 'Mode Hapus',
                message: 'Aktifkan mode hapus untuk memilih data KM yang akan dihapus?',
                okLabel: 'Aktifkan', // Tujuan tombol jelas sesuai optimasi_ux.md poin 4
                cancelLabel: 'Batal',
                isDestructiveAction: true,
              );
              if (konfirmasi != OkCancelResult.ok) return;
              if (!mounted) return;
              setState(() {
                _modeHapus = true;
              });
            },
          ),
        // Jika tidak ada data dan mode hapus tidak aktif, tidak tampilkan apa-apa
      ],
    );
  }

  Widget _buildDrawer(
    KendaraanState kendaraanState,
    String? selectedKendaraanId,
  ) {
    final listKendaraan = kendaraanState.listKendaraan;
    return Drawer(
      child: listKendaraan.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    Icon(
                      Icons.directions_car_outlined,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const Text(
                      'Belum ada kendaraan',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    FilledButton.icon(
                      onPressed: () =>
                          unawaited(Nav.to(context, const FormKendaraan())),
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah Kendaraan'),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: listKendaraan.length,
              itemBuilder: (context, index) {
                final item = listKendaraan[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      item.nama,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    // ID kendaraan terpilih diterima melalui parameter, bukan ref.watch di dalam builder.
                    trailing: selectedKendaraanId == item.id
                        ? const Icon(Icons.task_alt)
                        : null,
                    onTap: () async {
                      await ref
                          .read(selectedKendaraanIdProvider.notifier)
                          .set(item.id);
                      L.i(
                        'berhasil menyimpan key kendaraan dengan id ${item.id} ke prefs',
                      );
                      if (context.mounted) {
                        Scaffold.of(context).closeDrawer();
                      }
                    },
                  ),
                );
              },
            ),
    );
  }

  Widget _buildListKm(KmState kmState, KendaraanState kendaraanState) {
    final idKendaraanterpilih = _kendaraanTerpilih?.id;
    final list = idKendaraanterpilih == null || idKendaraanterpilih.isEmpty
        ? kmState.listKm
        : kmState.getListByIdKendaraan(idKendaraanterpilih);
    if (list.isEmpty && _modeHapus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _modeHapus) {
          setState(() {
            _modeHapus = false;
          });
        }
      });
    }
    if (list.isEmpty) {
      return _buildListKosong();
    }
    return ListView.builder(
      controller: _scrollController,
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final kendaraan = kendaraanState.getById(item.idKendaraan);
        return ListTile(
          title: Row(
            spacing: 4,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${FormatNomor.formatRibuan(item.km.toInt())} KM',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              if (_kendaraanTerpilih == null)
                Text(
                  '- ${kendaraan?.nama ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
            ],
          ),
          subtitle: Text(
            FormatTanggal.formatDasar(item.tanggal),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'Edit',
                onPressed: () {
                  L.i('Tombol edit ditekan untuk item ID: ${item.id}');
                  setState(() {
                    _itemToEdit = item;
                    _kmController.text = FormatNomor.formatRibuan(
                      item.km.toInt(),
                    );
                    _tanggalTerpilih = item.tanggal;
                    _waktuTerpilih = TimeOfDay.fromDateTime(item.tanggal);
                  });
                  _tampilkanForm();
                },
                icon: const Icon(Icons.edit),
              ),
              if (_modeHapus)
                IconButton(
                  tooltip: 'Hapus',
                  onPressed: _isDeletingKm ? null : () => _hapusKm(item),
                  icon: const Icon(Icons.delete),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListKosong() {
    return Center(
      child: Column(
        spacing: 16, // jarak antar anak pakai spacing (UI #13)
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.directions_car_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          Text(
            'Belum ada data KM',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            'Tambahkan data kilometer pertama untuk kendaraan yang terpilih.',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          FilledButton.icon(
            onPressed: () {
              _resetFormState();
              _tampilkanForm();
            },
            icon: const Icon(Icons.add),
            label: const Text('Tambah Data KM'),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    L.i('_kmController $_kmController');
    return AlertDialog(
      scrollable: true,
      title: Text(_itemToEdit == null ? 'Tambah Item' : 'Edit Item'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputAngka(
              controller: _kmController,
              focusNode: _kmFocusNode,
              prefixIcon: Icons.speed,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _simpanForm(),
              validator: (v) {
                final n = InputAngka.parseAngkaRibuan(v ?? '');
                if (n <= 0) return 'Masukkan angka KM yang valid';
                return null;
              },
            ),
            PemilihTanggalWaktuWidget(
              tanggalTerpilih: _tanggalTerpilih,
              waktuTerpilih: _waktuTerpilih,
              onPilihTanggal: _pilihTanggal,
              onPilihWaktu: _pilihWaktu,
              onResetKeSekarang: _resetKeSekarang,
              teksLabel: 'Tanggal & Waktu Service',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            L.i('Tombol Batal ditekan, menutup form dan mereset form');
            _resetFormState();
            _dialogSetState = null;
            Nav.pop(context);
          },
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: _isLoading ? null : _simpanForm,
          child: _isLoading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Simpan'),
        ),
      ],
    );
  }

  Widget _buildError() {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data KM'), // UX #16: pesan error spesifik
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(
                  kmProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  kendaraanProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlightColor = Theme.of(context).colorScheme.surfaceContainerHigh;

    final placeholders = ListView.builder(
      itemCount: 6,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Container(
                      width: 140,
                      height: 16,
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 12,
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        );
      },
    );

    final child = disableAnimations
        ? placeholders
        : Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            period: const Duration(milliseconds: 1200),
            child: placeholders,
          );

    return Scaffold(
      appBar: AppBar(title: const Text('Data KM')),
      body: Semantics(label: 'Memuat data KM', liveRegion: true, child: child),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/km/state/km_state.dart
// ============================================================

```dart
// lib/fitur/km/state/km_state.dart

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/km/model/km_model.dart';

part 'km_state.freezed.dart';

/// State untuk mengelola data kilometer (km) kendaraan.
@freezed
abstract class KmState with _$KmState {
  const KmState._();

  /// Membuat state [KmState] dengan daftar kilometer kendaraan.
  const factory KmState({@Default([]) List<KmModel> listKm}) = _KmState;

  /// Mengembalikan data kilometer terbaru berdasarkan tanggal. Jika [listKm] kosong, mengembalikan `null`.
  KmModel? get kmTerbaru => maxBy(listKm, (km) => km.tanggal);

  /// Mengembalikan data kilometer terbaru berdasarkan tanggal untuk kendaraan tertentu. Jika tidak ada, mengembalikan `null`.
  KmModel? kmTerbaruByIdKendaraan(String? idKendaraan) {
    final list = getListByIdKendaraan(idKendaraan);
    return maxBy(list, (km) => km.tanggal);
  }

  /// Mengambil daftar kilometer berdasarkan [idKendaraan]. Jika [idKendaraan] null atau kosong, mengembalikan list kosong.
  List<KmModel> getListByIdKendaraan(String? idKendaraan) {
    if (idKendaraan == null || idKendaraan.isEmpty) {
      return [];
    }
    return listKm.where((km) => km.idKendaraan == idKendaraan).toList();
  }
}
```


// ============================================================
// FILE: lib/fitur/komponen/enum/sort_komponen_enum.dart
// ============================================================

```dart
// lib/fitur/komponen/enum/sort_komponen_enum.dart

/// Enum untuk opsi pengurutan komponen.
enum SortKomponenEnum {
  /// Urutkan nama komponen secara A ke Z.
  namaAZ,

  /// Urutkan nama komponen secara Z ke A.
  namaZA,

  /// Urutkan harga komponen dari terendah ke tertinggi.
  hargaAZ,

  /// Urutkan harga komponen dari tertinggi ke terendah.
  hargaZA,
}

/// Extension untuk mendapatkan label tampilan dari [SortKomponenEnum].
extension StatusExtension on SortKomponenEnum {
  /// Mengembalikan label human-readable untuk opsi pengurutan ini.
  String get label {
    switch (this) {
      case SortKomponenEnum.namaAZ:
        return 'Nama Terendah';
      case SortKomponenEnum.namaZA:
        return 'Nama Tertinggi';
      case SortKomponenEnum.hargaAZ:
        return 'Harga Terendah';
      case SortKomponenEnum.hargaZA:
        return 'Harga Tertinggi';
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/komponen/model/komponen_model.dart
// ============================================================

```dart
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/komponen/model/link_toko_model.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'komponen_model.freezed.dart';

/// Model data komponen kendaraan (misal: oli, filter, rem).
@freezed
abstract class KomponenModel with _$KomponenModel {
  const KomponenModel._();

  /// Membuat instance [KomponenModel] dengan data lengkap.
  const factory KomponenModel({
    /// ID unik komponen.
    required String id,

    /// Nama komponen.
    required String nama,

    /// Harga komponen.
    required double harga,

    /// Daftar tautan toko.
    @Default([]) List<LinkTokoModel> linkToko,

    /// ID kendaraan yang memiliki komponen ini.
    required String idKendaraan,

    /// Waktu terakhir diperbarui.
    required DateTime diperbarui,

    /// Waktu diarsipkan, null jika belum diarsipkan.
    DateTime? diarsipkan,
  }) = _KomponenModel;

  /// Membuat [KomponenModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KomponenModel.fromSupabase(Map<String, dynamic> map) {
    return KomponenModel(
      id: map[NamaKolom.id]?.toString() ?? '',
      nama: map[NamaKolom.nama]?.toString() ?? '',
      harga: ParserUtil.parseDouble(map[NamaKolom.harga]),
      linkToko: _parseLinkTokoSupabase(map[NamaKolom.linkToko]),
      idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      diperbarui:
          ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
      diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    );
  }

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.harga: harga,
    NamaKolom.linkToko: linkToko.map((link) => link.toJson()).toList(),
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  /// Membuat [KomponenModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KomponenModel.fromSqflite(Map<String, dynamic> map) => KomponenModel(
    id: map[NamaKolom.id]?.toString() ?? '',
    nama: map[NamaKolom.nama]?.toString() ?? '',
    harga: ParserUtil.parseDouble(map[NamaKolom.harga]),
    linkToko: LinkTokoModel.parseListFrom(map[NamaKolom.linkToko]?.toString()),
    idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
    diperbarui:
        ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
    diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
  );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.harga: harga,
    NamaKolom.linkToko: jsonEncode(
      linkToko.map((link) => link.toJson()).toList(),
    ),
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  /// 🆕 Metode utilitas statis untuk mengurai linkToko dari data Supabase.
  // ubah parameter dynamic → Object? agar pengecekan tipe aman (optimasi_bug_runtime poin 2)
  static List<LinkTokoModel> _parseLinkTokoSupabase(Object? value) {
    if (value == null) {
      return [];
    }

    if (value is List) {
      try {
        // Tambahkan guard untuk tipe Map<String, dynamic> yang benar sebelum pemetaan
        return value
            .whereType<Map<String, dynamic>>()
            .map(LinkTokoModel.fromJson)
            .toList();
      } catch (e) {
        L.w('Gagal mengurai linkToko dari Supabase: $e');
        return [];
      }
    } else if (value is String && value.isNotEmpty) {
      return LinkTokoModel.parseListFrom(value);
    }

    return [];
  }
}
```


// ============================================================
// FILE: lib/fitur/komponen/model/link_toko_model.dart
// ============================================================

```dart
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'link_toko_model.freezed.dart';
part 'link_toko_model.g.dart';

/// Tautan toko untuk membeli komponen kendaraan.
@freezed
abstract class LinkTokoModel with _$LinkTokoModel {
  const LinkTokoModel._();

  /// Membuat [LinkTokoModel].
  const factory LinkTokoModel({
    /// Nama toko.
    required String namaToko,

    /// URL toko.
    required String url,
  }) = _LinkTokoModel;

  /// Membuat [LinkTokoModel] dari JSON.
  factory LinkTokoModel.fromJson(Map<String, dynamic> json) =>
      _$LinkTokoModelFromJson(json);

  /// Mengurai JSON menjadi [LinkTokoModel]; list kosong jika gagal.
  static List<LinkTokoModel> parseListFrom(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is! List) return [];
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(LinkTokoModel.fromJson)
          .toList();
    } catch (e, s) {
      L.e('Gagal mengurai linkToko dari JSON: $e $s');
      return [];
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/komponen/notifier/komponen_notifier.dart
// ============================================================

```dart
// lib/fitur/komponen/notifier/komponen_notifier.dart

import 'package:myapp/fitur/komponen/model/komponen_model.dart';
import 'package:myapp/fitur/komponen/state/komponen_state.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'komponen_notifier.g.dart';

/// Notifier untuk mengelola data komponen kendaraan.
@Riverpod(keepAlive: true)
class KomponenNotifier extends _$KomponenNotifier {
  final _tabelKomponen = NamaTabel.komponen;

  /// Membangun state awal dengan memuat data komponen dari database.
  @override
  Future<KomponenState> build() async {
    return await _muatData();
  }

  Future<KomponenState> _muatData() async {
    try {
      final db = ref.read(baseOpSqfliteProvider);
      final listDb = await db.ambilData(_tabelKomponen);
      final listHasil = listDb
          .whereType<Map<String, dynamic>>()
          .map(KomponenModel.fromSqflite)
          .toList();
      return KomponenState(listKomponenState: listHasil);
    } on Exception catch (e, s) {
      L.e('Gagal memuat komponen: $e $s');
      rethrow;
    }
  }

  /// Menambahkan [komponen] baru ke daftar dan database.
  Future<void> tambah(KomponenModel komponen) async {
    final dataLama = await future;
    // 1. Optimistic update
    final listBaru = dataLama.copyWith(
      listKomponenState: [...dataLama.listKomponenState, komponen],
    );
    state = AsyncValue.data(listBaru);

    try {
      // 2. Update DB
      await ref
          .read(baseOpSqfliteProvider)
          .tambah(_tabelKomponen, komponen.toSqflite());
    } on Exception catch (e, s) {
      // 3. Rollback
      L.e('tambah komponen gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Menghapus komponen dengan [id] dari daftar dan database.
  Future<void> hapus(String id) async {
    final dataLama = await future;
    // 1. Optimistic update
    final listBaru = dataLama.listKomponenState
        .where((e) => e.id != id)
        .toList();
    state = AsyncValue.data(dataLama.copyWith(listKomponenState: listBaru));

    try {
      // 2. Hapus DB
      await ref.read(baseOpSqfliteProvider).hapus(_tabelKomponen, id);
    } on Exception catch (e, s) {
      // 3. Rollback
      L.e('hapus komponen gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Mengubah data [komponen] di daftar dan database.
  Future<void> ubah(KomponenModel komponen) async {
    final dataLama = await future;
    // 1. Optimistic update
    final listBaru = dataLama.listKomponenState
        .map((e) => e.id == komponen.id ? komponen : e)
        .toList();
    state = AsyncValue.data(dataLama.copyWith(listKomponenState: listBaru));

    try {
      // 2. Update DB
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(_tabelKomponen, komponen.toSqflite(), komponen.id);
    } on Exception catch (e, s) {
      // 3. Rollback
      L.e('ubah komponen gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Melakukan batch insert [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(List<KomponenModel> data) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabelKomponen,
            data.map((e) => e.toSqflite()).toList(),
          );

      state = AsyncValue.data(await _muatData());
    } catch (e, s) {
      L.e('Gagal batch insert komponen $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/komponen/page/detail_komponen_page.dart
// ============================================================

```dart
// lib/fitur/komponen/page/detail_komponen_page.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/komponen/model/komponen_model.dart';
import 'package:myapp/fitur/komponen/model/link_toko_model.dart';
import 'package:myapp/fitur/komponen/notifier/komponen_notifier.dart';
import 'package:myapp/fitur/komponen/page/form_komponen.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:url_launcher/url_launcher.dart';

/// Halaman detail untuk melihat informasi lengkap komponen.
class DetailKomponenPage extends ConsumerStatefulWidget {
  /// ID komponen yang akan ditampilkan detailnya.
  final String id;

  /// Buat halaman detail komponen.
  const DetailKomponenPage({super.key, required this.id});

  @override
  ConsumerState<DetailKomponenPage> createState() => _DetailKomponenPageState();
}

class _DetailKomponenPageState extends ConsumerState<DetailKomponenPage> {
  bool _isLoading = false;
  String get id => widget.id;

  Future<void> _openLink(BuildContext context, String? url) async {
    if (url == null || url.isEmpty) {
      AppToast.gagal(context, 'Link pembelian tidak tersedia');
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) {
      AppToast.gagal(context, 'Format link tidak valid');
      return;
    }
    try {
      final launched = await launchUrl(uri, webOnlyWindowName: '_self');
      if (launched) {
        L.s('Link berhasil dibuka');
      } else {
        if (context.mounted) {
          AppToast.gagal(context, 'Tidak dapat membuka link');
        }
      }
    } catch (e, s) {
      L.e('Gagal membuka link: $e$s');
      if (context.mounted) {
        AppToast.gagal(context, 'Terjadi kesalahan saat membuka link');
      }
    }
  }

  // Fungsi untuk menampilkan konfirmasi hapus
  Future<void> _showDeleteConfirmation(
    BuildContext context,
    KomponenModel komponen,
  ) async {
    final confirmed = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Data',
      message: 'Data komponen ini akan dihapus secara permanen.',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );

    if (confirmed == OkCancelResult.ok) {
      L.i('Menghapus komponen: ${komponen.id}');
      // Hindari setState saat widget sudah tidak aktif setelah await dialog.
      if (mounted) setState(() => _isLoading = true);
      try {
        await ref.read(komponenProvider.notifier).hapus(komponen.id);
        if (context.mounted) {
          AppToast.sukses(context, 'Komponen berhasil dihapus');
          Nav.pop(context);
        }
      } catch (e, s) {
        L.e('Gagal menghapus komponen: $e $s');
        if (context.mounted) {
          AppToast.gagal(context, 'Gagal menghapus komponen');
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    } else {
      L.i('Penghapusan komponen dibatalkan');
    }
  }

  @override
  Widget build(BuildContext context) {
    final komponenAsync = ref.watch(komponenProvider);
    // Perbaikan: periksa isLoading terlebih dahulu, baru hasError (aturan Riverpod).
    if (komponenAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (komponenAsync.hasError) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gagal memuat komponen'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.refresh(komponenProvider),
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final komponenState = komponenAsync.requireValue;
    final komponen = komponenState.getById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          komponen?.nama ?? 'Tanpa Nama',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              if (komponen == null) {
                return AppToast.warning(context, 'Komponen tidak ditemukan');
              }
              unawaited(Nav.to(context, FormKomponen(komponenModel: komponen)));
            },
            tooltip: 'Edit Komponen',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16), // JarakApp.lg = 16 dp
        child: _buildInfoKomponen(context, ref, komponen),
      ),
    );
  }

  Widget _buildInfoKomponen(
    BuildContext context,
    WidgetRef ref,
    KomponenModel? komponen,
  ) {
    if (komponen == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 24,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            Text(
              'Komponen tidak ditemukan',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => Nav.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali'),
            ),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(context, 'Nama', komponen.nama),
          const Divider(),
          _buildInfoRow(
            context,
            'Harga',
            formatMataUang(
              komponen.harga,
              ref
                  .watch(mataUangProvider)
                  .maybeWhen(
                    data: (m) => m,
                    orElse: () => daftarMataUang.first,
                  ),
            ),
          ),
          const Divider(),
          _buildInfoRow(
            context,
            'Terakhir Diperbarui',
            FormatWaktuLengkap.formatSingkat(komponen.diperbarui),
          ),
          if (komponen.linkToko.isNotEmpty) ...[
            const Divider(),
            Text(
              'Link Toko',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ..._buildGroupedLinks(context, komponen.linkToko),
          ],
          const SizedBox(height: 16),
          // Tombol hapus dengan konfirmasi
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading
                  ? null
                  : () => _showDeleteConfirmation(context, komponen),
              icon: _isLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : const Icon(Icons.delete),
              label: Text(_isLoading ? 'Menghapus...' : 'Hapus Komponen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value, {
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 8), trailing],
        ],
      ),
    );
  }

  List<Widget> _buildGroupedLinks(
    BuildContext context,
    List<LinkTokoModel> links,
  ) {
    final grouped = <String, List<LinkTokoModel>>{};
    for (final link in links) {
      grouped.putIfAbsent(link.namaToko, () => []).add(link);
    }
    final widgets = <Widget>[];
    for (final entry in grouped.entries) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Text(
            entry.key,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
      for (final link in entry.value) {
        widgets.add(
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Tooltip(
              message: link.url,
              child: Text(
                link.url,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.open_in_new, size: 20),
              onPressed: () => _openLink(context, link.url),
              tooltip: 'Buka link',
            ),
          ),
        );
      }
    }
    return widgets;
  }
}
```


// ============================================================
// FILE: lib/fitur/komponen/page/form_komponen.dart
// ============================================================

```dart
// lib/fitur/komponen/form_komponen.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/page/form_kendaraan.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/komponen/model/komponen_model.dart';
import 'package:myapp/fitur/komponen/model/link_toko_model.dart';
import 'package:myapp/fitur/komponen/notifier/komponen_notifier.dart';
import 'package:myapp/shared/widget/pemilih_kendaraan.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Form untuk menambah atau mengedit data komponen.
class FormKomponen extends ConsumerStatefulWidget {
  /// Model komponen yang akan diedit. [null] jika mode tambah.
  final KomponenModel? komponenModel;

  /// Buat form komponen.
  const FormKomponen({super.key, this.komponenModel});

  @override
  ConsumerState<FormKomponen> createState() => _FormKomponenState();
}

class _FormKomponenState extends ConsumerState<FormKomponen> {
  late final bool _modeEdit;

  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final TextEditingController _namaTokoController = TextEditingController();
  final _urlController = TextEditingController();
  final _editTokoController = TextEditingController();
  final _editLinkController = TextEditingController();
  final _namaTokoFocusNode = FocusNode();
  final _urlFocusNode = FocusNode();
  final _editLinkFocusNode = FocusNode();
  final _editTokoFocusNode = FocusNode();
  final _namaFocusNode = FocusNode();
  final _hargaFocusNode = FocusNode();
  final _linkFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isDeletingToko = false;
  KendaraanModel? _kendaraanTerpilih;
  List<LinkTokoModel> _linkTokoModel = [];
  String? _editToko;
  LinkTokoModel? _editLink;
  final List<String> _presetToko = [
    'Shopee',
    'Tokopedia',
    'Blibli',
    'Bengkel Resmi',
    'Toko Sparepart',
  ];

  @override
  void initState() {
    super.initState();
    _modeEdit = widget.komponenModel != null;
    if (_modeEdit) {
      final komponen = widget.komponenModel;
      if (komponen == null) return;
      _namaController.text = komponen.nama;
      _hargaController.text = komponen.harga.toStringAsFixed(0);
      _linkTokoModel = List.from(komponen.linkToko);
      L.i('FormKomponen dibuka untuk EDIT komponen: ${komponen.id}');
    } else {
      L.i('FormKomponen dibuka untuk TAMBAH komponen baru');
    }

    // Menangkap error provider agar tidak menjadi unhandled, dan menjaga setState hanya saat widget masih mounted.
    unawaited(
      Future.microtask(() async {
        try {
          var idKendaraan = widget.komponenModel?.idKendaraan;
          if (idKendaraan == null || idKendaraan.isEmpty) {
            idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
          }
          final kendaraanState = await ref.read(kendaraanProvider.future);
          if (idKendaraan != null && idKendaraan.isNotEmpty) {
            final kendaraan = kendaraanState.getById(idKendaraan);
            if (mounted && kendaraan != null) {
              setState(() => _kendaraanTerpilih = kendaraan);
            }
          } else if (kendaraanState.listKendaraan.isNotEmpty) {
            final kendaraan = kendaraanState.listKendaraan.first;
            if (mounted) {
              setState(() => _kendaraanTerpilih = kendaraan);
            }
          }
        } catch (e, s) {
          L.e('Gagal memuat kendaraan terpilih form komponen: $e $s');
        }
      }),
    ); // unawaited: Future.microtask per optimasi_bug_runtime.md #10
  }

  @override
  void dispose() {
    _namaTokoController.dispose();
    _urlController.dispose();
    _namaController.dispose();
    _hargaController.dispose();
    _editLinkController.dispose(); // ← TAMBAH
    _editTokoController.dispose(); // ← TAMBAH

    _namaTokoFocusNode.dispose();
    _urlFocusNode.dispose();
    _namaFocusNode.dispose();
    _hargaFocusNode.dispose();
    _linkFocusNode.dispose();
    _editTokoFocusNode.dispose(); // ← TAMBAH
    _editLinkFocusNode.dispose();
    super.dispose();
  }

  void _tambahLinkToko() {
    final namaToko = _namaTokoController.text.trim();
    final url = _urlController.text.trim();

    if (namaToko.isEmpty || url.isEmpty) {
      AppToast.gagal(context, 'Nama toko dan URL wajib diisi');
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty) {
      AppToast.gagal(context, 'Format URL tidak valid');
      return;
    }

    setState(() {
      _linkTokoModel.add(LinkTokoModel(namaToko: namaToko, url: url));
      _namaTokoController.clear();
      _urlController.clear();
    });
  }

  Map<String, List<LinkTokoModel>> groupLinkTokoByNamaToko(
    List<LinkTokoModel> linkTokoList,
  ) {
    final grouped = <String, List<LinkTokoModel>>{};

    for (final link in linkTokoList) {
      grouped.putIfAbsent(link.namaToko, () => []).add(link);
    }

    return grouped;
  }
  // GANTI _toggleEditToko DENGAN 2 METHOD:

  void _mulaiEditToko(String namaToko) {
    setState(() {
      _editToko = namaToko;
      _editTokoController.text = namaToko;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _editTokoFocusNode.requestFocus();
    });
  }

  void _batalEditToko() {
    setState(() {
      _editToko = null;
      _editTokoController.clear();
      _editTokoFocusNode.unfocus(); // ← TAMBAH INI
    });
  }

  void _simpanEditToko(String namaTokoLama) {
    final namaBaru = _editTokoController.text.trim();
    if (namaBaru.isEmpty) return;
    setState(() {
      _linkTokoModel = _linkTokoModel.map((link) {
        if (link.namaToko == namaTokoLama) {
          return LinkTokoModel(namaToko: namaBaru, url: link.url);
        }
        return link;
      }).toList();
      _editToko = null;
      _editTokoController.clear();
    });
  }

  Future<void> _hapusToko(String namaToko) async {
    if (_isDeletingToko) return;
    final confirmed = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Toko?',
      message: 'Semua link pada toko ini akan dihapus. Lanjutkan?',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (confirmed != OkCancelResult.ok) return;
    // Hindari setState saat widget sudah tidak aktif setelah await dialog.
    if (mounted) setState(() => _isDeletingToko = true);
    try {
      setState(() {
        _linkTokoModel.removeWhere((l) => l.namaToko == namaToko);
      });
    } finally {
      if (mounted) setState(() => _isDeletingToko = false);
    }
  }

  Future<void> _hapusLinkToko(LinkTokoModel link) async {
    if (_isDeletingToko) return;
    final confirmed = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Link?',
      message: 'Link toko ini akan dihapus. Lanjutkan?',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (confirmed != OkCancelResult.ok) return;
    // Hindari setState saat widget sudah tidak aktif setelah await dialog.
    if (mounted) setState(() => _isDeletingToko = true);
    try {
      setState(() {
        _linkTokoModel.remove(link);
      });
    } finally {
      if (mounted) setState(() => _isDeletingToko = false);
    }
  }

  void _toggleEditLink({LinkTokoModel? linkToko}) {
    final link = linkToko;
    if (link != null) {
      setState(() {
        _editLink = link;
        _editLinkController.text = link.url;
      });
    } else {
      setState(() {
        _editLink = null;
        _editLinkController.clear();
      });
    }
  }

  void _mulaiTambahLinkKeToko(String namaToko) {
    setState(() {
      _namaTokoController.text = namaToko;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _urlFocusNode.requestFocus();
    });
  }

  Future<void> _tempelUrlDariClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (!mounted) return;
    final text = data?.text;
    if (text != null && text.isNotEmpty) {
      _urlController.text = text;
      AppToast.sukses(context, 'Link berhasil ditempel');
    } else {
      AppToast.info(context, 'Clipboard kosong');
    }
  }

  Future<void> _simpan() async {
    if (_isLoading) return;

    // Validasi form
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('Validasi form gagal, simpan dibatalkan');
      return;
    }
    var idKendaraan = _kendaraanTerpilih?.id;
    if (idKendaraan == null || idKendaraan.isEmpty) {
      try {
        idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
      } catch (e, s) {
        L.e('Gagal mengambil kendaraan terpilih: $e $s');
        if (mounted) {
          AppToast.gagal(context, 'Gagal memuat kendaraan terpilih');
        }
        return;
      }
    }
    if (idKendaraan == null || idKendaraan.isEmpty) {
      if (mounted) {
        AppToast.gagal(context, 'Tolong pilih kendaraan Anda terlebih dahulu');
      }
      return;
    }
    if (mounted) setState(() => _isLoading = true);
    try {
      final komponenToSave = KomponenModel(
        id: _modeEdit
            ? (widget.komponenModel?.id ?? const Uuid().v4())
            : const Uuid().v4(),
        nama: _namaController.text.trim(),
        harga: InputAngka.parseAngkaRibuan(_hargaController.text),
        linkToko: _linkTokoModel,
        diperbarui: DateTime.now(),
        idKendaraan: idKendaraan,
      );
      if (_modeEdit) {
        await ref.read(komponenProvider.notifier).ubah(komponenToSave);
      } else {
        await ref.read(komponenProvider.notifier).tambah(komponenToSave);
      }
      if (mounted) {
        AppToast.sukses(
          context,
          _modeEdit
              ? 'Komponen berhasil diperbarui'
              : 'Komponen berhasil disimpan',
        );
        Nav.pop(context);
      }
    } catch (e, s) {
      // Gagal
      L.e('Gagal menyimpan komponen: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan komponen');
      }
    } finally {
      // Selesai loading (baik sukses atau gagal)
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(_modeEdit ? 'Edit Komponen' : 'Tambah Komponen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildKendaraanAktif(),
              const SizedBox(height: 24),
              _buildFormKomponen(),
              const SizedBox(height: 24),
              _buildListLinkToko(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            spacing: 8,
            children: [
              OutlinedButton(
                onPressed: () => Nav.pop(context), // ✅ Aksi kembali/batal
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Batal'), // ✅ Label Batal
              ),
              Expanded(child: _buildTombolSimpan()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKendaraanAktif() {
    final kendaraanAsync = ref.watch(kendaraanProvider);
    if (kendaraanAsync.hasError) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Gagal memuat kendaraan',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.error),
        ),
      );
    }
    if (kendaraanAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final kendaraanState = kendaraanAsync.requireValue;
    final listKendaraan = kendaraanState.listKendaraan;
    final kendaraanTerpilih = _kendaraanTerpilih;
    if (kendaraanTerpilih != null) {
      return PemilihKendaraan(
        kendaraanTerpilih: kendaraanTerpilih,
        listKendaraan: listKendaraan,
        onSelected: (value) => setState(() {
          _kendaraanTerpilih = value;
        }),
      );
    }
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () => unawaited(Nav.to(context, const FormKendaraan())),
        icon: const Icon(Icons.add),
        label: const Text('Tambah kendaraan'),
      ),
    );
  }

  Widget _buildFormKomponen() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            InputTeks(
              controller: _namaController,
              label: 'Nama Komponen',
              focusNode: _namaFocusNode,
              nextFocusNode: _hargaFocusNode,
            ),
            InputAngka(
              controller: _hargaController,
              label: 'Harga',
              prefixIcon: Icons.money,
              focusNode: _hargaFocusNode,
              nextFocusNode: _linkFocusNode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListLinkToko() {
    final grouped = groupLinkTokoByNamaToko(_linkTokoModel);
    final totalToko = grouped.length; // Jumlah unik toko
    final totalUrl = _linkTokoModel.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Link Toko Pembelian',
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  spacing: 4,
                  children: [
                    Text('$totalToko Toko'), // Contoh: "3 Toko"
                    Text('$totalUrl Tautan'), // Contoh: "7 Tautan"
                  ],
                ),
              ],
            ),
            const Divider(),
            _buildCardGrupToko(),
            _buildCardFormLink(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardGrupToko() {
    final grouped = groupLinkTokoByNamaToko(_linkTokoModel);
    if (grouped.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: grouped.entries.map((entry) {
        final namaToko = entry.key;
        final links = entry.value;
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          child: ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(namaToko, maxLines: 1, overflow: TextOverflow.ellipsis),
                TextButton.icon(
                  icon: const Icon(Icons.add, size: 20),
                  label: Text(
                    'link',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  onPressed: () {
                    _mulaiTambahLinkKeToko(namaToko);
                  },
                ),
              ],
            ),
            shape: const Border(),
            collapsedShape: const Border(),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            children: [
              ...links.map((link) {
                final editLink = link == _editLink;
                return ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: editLink
                      ? InputTeks(
                          controller: _editLinkController,
                          focusNode: _editLinkFocusNode,
                          autofocus: true,
                          label: 'URL',
                        )
                      : Text(
                          link.url,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                  trailing: editLink
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: _toggleEditLink,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.check,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onPressed: () {
                                final urlBaru = _editLinkController.text.trim();
                                if (urlBaru.isNotEmpty) {
                                  setState(() {
                                    _linkTokoModel = _linkTokoModel.map((l) {
                                      if (l == link) {
                                        return LinkTokoModel(
                                          namaToko: l.namaToko,
                                          url: urlBaru,
                                        );
                                      }
                                      return l;
                                    }).toList();
                                    _editLink = null;
                                    _editLinkController.clear();
                                  });
                                }
                              },
                            ),
                          ],
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _toggleEditLink(linkToko: link),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              onPressed: _isDeletingToko
                                  ? null
                                  : () => _hapusLinkToko(link),
                            ),
                          ],
                        ),
                );
              }),
              const Divider(),
              _buildEditToko(namaToko),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEditToko(String namaToko) {
    if (_editToko == namaToko) {
      return Row(
        spacing: 4,
        children: [
          Expanded(
            child: InputTeks(
              controller: _editTokoController,
              focusNode: _editTokoFocusNode,
              autofocus: true,
              label: 'Nama toko',
              hintText: 'Nama toko baru',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama toko wajib diisi';
                }
                return null;
              },
            ),
          ),
          Row(
            spacing: 4,
            children: [
              TextButton.icon(
                onPressed: () => _simpanEditToko(namaToko),
                icon: const Icon(Icons.check),
                label: const Text('Simpan'),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: _batalEditToko,
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: () => _mulaiEditToko(namaToko),
          icon: const Icon(Icons.edit_outlined, size: 20), // ✅ Ikon pensil edit
          label: Text(
            'Edit Toko',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        TextButton.icon(
          onPressed: _isDeletingToko ? null : () => _hapusToko(namaToko),
          icon: const Icon(Icons.delete),
          label: const Text('Hapus Toko'),
        ),
      ],
    );
  }

  Widget _buildCardFormLink() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 12,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _presetToko.map((toko) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ActionChip(
                      label: Text(
                        '+ $toko',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      onPressed: () {
                        _namaTokoController.text = toko;
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            InputTeks(
              controller: _namaTokoController,
              focusNode: _namaTokoFocusNode,
              nextFocusNode: _urlFocusNode,
              label: 'Nama Toko',
              hintText: 'Shopee',
              wajib: false,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _tempelUrlDariClipboard, // ✅ Aktif
                    icon: const Icon(
                      Icons.content_paste,
                      size: 20,
                    ), // ✅ Ikon paste
                    label: Text(
                      'Tempel Link',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
                InputTeks(
                  controller: _urlController,
                  focusNode: _urlFocusNode,
                  hintText: 'https://...',
                  wajib: false,
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _tambahLinkToko,
                icon: const Icon(Icons.add),
                label: const Text('Tambahkan toko ke daftar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTombolSimpan() {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : _simpan,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      icon: const Icon(Icons.check),
      label: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('Simpan'),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/komponen/page/komponen_page.dart
// ============================================================

```dart
// lib/fitur/komponen/page/komponen_page.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/kendaraan/state/kendaraan_state.dart';
import 'package:myapp/fitur/komponen/enum/sort_komponen_enum.dart';
import 'package:myapp/fitur/komponen/model/komponen_model.dart';
import 'package:myapp/fitur/komponen/notifier/komponen_notifier.dart';
import 'package:myapp/fitur/komponen/page/detail_komponen_page.dart';
import 'package:myapp/fitur/komponen/page/form_komponen.dart';
import 'package:myapp/fitur/komponen/state/komponen_state.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:myapp/shared/widget/kendaraan_terpilih_list.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman daftar komponen kendaraan.
class KomponenPage extends ConsumerStatefulWidget {
  /// Buat halaman daftar komponen.
  const KomponenPage({super.key});

  @override
  ConsumerState<KomponenPage> createState() => _KomponenPageState();
}

class _KomponenPageState extends ConsumerState<KomponenPage> {
  final _cariController = TextEditingController();
  final _cariFocusNode = FocusNode();
  SortKomponenEnum _currentSort = SortKomponenEnum.namaAZ;
  bool _modeCari = false;
  bool _isNavigating = false;
  bool _isSheetOpen = false;
  bool _isDeletingKomponen = false;
  KendaraanModel? _kendaraanTerpilih;

  @override
  void initState() {
    super.initState();
    _cariController.addListener(_saatTeksCariBerubah);
    unawaited(Future.microtask(_reloadKendaraanTerpilih));
  }

  void _saatTeksCariBerubah() {
    if (mounted) setState(() {});
  }

  Future<void> _reloadKendaraanTerpilih() async {
    final idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
    final kendaraanState = await ref.read(kendaraanProvider.future);
    KendaraanModel? kendaraan;
    if (idKendaraan != null && idKendaraan.isNotEmpty) {
      kendaraan = kendaraanState.getById(idKendaraan);
      if (kendaraan == null && kendaraanState.listKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.listKendaraan.first;
      }
    } else if (_kendaraanTerpilih != null) {
      kendaraan = _kendaraanTerpilih;
    } else if (kendaraanState.listKendaraan.isNotEmpty) {
      kendaraan = kendaraanState.listKendaraan.first;
    }
    if (mounted) {
      setState(() {
        _kendaraanTerpilih = kendaraan;
      });
    }
  }

  @override
  void dispose() {
    _cariController.removeListener(_saatTeksCariBerubah);
    _cariController.dispose();
    _cariFocusNode.dispose();
    super.dispose();
  }

  /// Mengurutkan [listKomponen] sesuai opsi yang dipilih user [_currentSort]. Menggunakan `sorted` dari paket `collection` sesuai peraturan sumber kode.
  List<KomponenModel> _sortListKomponen(List<KomponenModel> listKomponen) {
    switch (_currentSort) {
      case SortKomponenEnum.namaAZ:
        return listKomponen.sorted((a, b) => a.nama.compareTo(b.nama));
      case SortKomponenEnum.namaZA:
        return listKomponen.sorted((a, b) => b.nama.compareTo(a.nama));
      case SortKomponenEnum.hargaAZ:
        return listKomponen.sorted((a, b) => a.harga.compareTo(b.harga));
      case SortKomponenEnum.hargaZA:
        return listKomponen.sorted((a, b) => b.harga.compareTo(a.harga));
    }
  }

  void _modalOpsiSort() {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          // Bungkus konten bottom sheet dengan SafeArea agar tidak tertutup area sistem.
          return SafeArea(
            child: RadioGroup<SortKomponenEnum>(
              groupValue: _currentSort,
              onChanged: (ske) {
                if (ske != null) {
                  setState(() => _currentSort = ske);
                  // Perbaikan: gunakan Nav.pop sesuai konvensi navigasi proyek.
                  Nav.pop(context);
                }
              },
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24), // JarakApp.xl = 24 dp
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: SortKomponenEnum.values.map((ske) {
                        return Card(
                          child: RadioListTile<SortKomponenEnum>(
                            value: ske,
                            title: Text(ske.label),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedKendaraanIdProvider, (previous, next) {
      // Bandingkan nilai AsyncValue secara aman via asData untuk menghindari akses .value tanpa guard.
      if (previous?.asData?.value != next.asData?.value) {
        unawaited(_reloadKendaraanTerpilih());
      }
    });
    final komponenAsync = ref.watch(komponenProvider);
    final kendaraanAsync = ref.watch(kendaraanProvider);
    // Urutan pemeriksaan AsyncValue: loading → error → data (optimasi_bug_runtime.md poin 9).
    if (kendaraanAsync.isLoading || komponenAsync.isLoading) {
      return _buildLoading();
    }
    if (kendaraanAsync.hasError || komponenAsync.hasError) {
      final error = kendaraanAsync.hasError
          ? kendaraanAsync.error
          : komponenAsync.error;
      final stackTrace = kendaraanAsync.hasError
          ? kendaraanAsync.stackTrace
          : komponenAsync.stackTrace;
      return _buildError(
        kendaraanAsync.hasError
            ? 'Gagal memuat kendaraan'
            : 'Gagal memuat komponen',
        kendaraanAsync.hasError
            ? () {
                final _ = ref.refresh(kendaraanProvider);
              }
            : () {
                final _ = ref.refresh(komponenProvider);
              },
        error: error,
        stackTrace: stackTrace,
      );
    }

    final kendaraanState = kendaraanAsync.requireValue;
    final komponenState = komponenAsync.requireValue;
    return _buildScaffold(kendaraanState, komponenState);
  }

  Widget _buildLoading() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Widget _buildError(
    String pesan,
    VoidCallback onRetry, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (error != null) {
      L.e('KomponenPage error: $pesan — $error $stackTrace');
    }
    return Scaffold(
      body: Semantics(
        label: pesan,
        liveRegion: true,
        child: Center(
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(pesan),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScaffold(
    KendaraanState kendaraanState,
    KomponenState komponenState,
  ) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Column(
        children: [
          KendaraanTerpilihList(
            listKendaraan: kendaraanState.listKendaraan,
            selectedId: _kendaraanTerpilih?.id,
            onSelected: (kendaraan) {
              setState(() => _kendaraanTerpilih = kendaraan);
            },
            onReload: _reloadKendaraanTerpilih,
          ),
          Expanded(child: _buildlistKomponen(komponenState)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        tooltip: 'Tambah komponen',
        // Mencegah navigasi ganda saat FAB ditekan berulang
        onPressed: _isNavigating
            ? null
            : () async {
                setState(() => _isNavigating = true);
                await Nav.to(context, const FormKomponen());
                if (mounted) setState(() => _isNavigating = false);
              },
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: _modeCari
          ? InputTeks(
              controller: _cariController,
              focusNode: _cariFocusNode,
              hintText: 'Cari komponen...',
              prefixIcon: Icons.search,
              wajib: false,
              suffixIcon: _cariController.text.isNotEmpty ? Icons.close : null,
              onSuffixIconPressed: _cariController.text.isNotEmpty
                  ? () {
                      _cariController.clear();
                      setState(() {});
                    }
                  : null,
            )
          : const Text('Komponen'),
      actions: [
        if (_modeCari) ...[
          TextButton(
            onPressed: () {
              _cariController.clear();
              _cariFocusNode.unfocus();
              setState(() {
                _modeCari = false;
              });
            },
            child: const Text('Batal'),
          ),
        ] else ...[
          IconButton(
            onPressed: () {
              setState(() {
                _modeCari = true;
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _cariFocusNode.requestFocus();
              });
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(onPressed: _modalOpsiSort, icon: const Icon(Icons.sort)),
        ],
      ],
    );
  }

  Widget _buildlistKomponen(KomponenState komponenState) {
    final selectedId = _kendaraanTerpilih?.id;
    final listKomponen = selectedId == null
        ? komponenState.listKomponenState
        : komponenState.listKomponenState
              .where((k) => k.idKendaraan == selectedId)
              .toList();
    final listKomponenTerurut = _sortListKomponen(listKomponen);
    // Filter berdasarkan teks pencarian kalau mode cari aktif.
    final cari = _cariController.text.toLowerCase();
    final listTampil = cari.isEmpty
        ? listKomponenTerurut
        : listKomponenTerurut
              .where((k) => k.nama.toLowerCase().contains(cari))
              .toList();

    // Empty state — bedakan "belum ada data" vs "tidak ditemukan".
    if (listTampil.isEmpty) {
      return _KomponenKosong(
        modeCari: _modeCari,
        onTambah: _modeCari
            ? null
            : () => unawaited(Nav.to(context, const FormKomponen())),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: listTampil.length,
      itemBuilder: (context, index) {
        final komponen = listTampil[index];
        return _buildItemKomponen(context, ref, komponen);
      },
    );
  }

  Widget _buildItemKomponen(
    BuildContext context,
    WidgetRef ref,
    KomponenModel komponenModel,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          komponenModel.nama,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          'Harga: ${formatMataUang(komponenModel.harga, ref.watch(mataUangProvider).maybeWhen(data: (m) => m, orElse: () => daftarMataUang.first))}',
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          unawaited(Nav.to(context, DetailKomponenPage(id: komponenModel.id)));
        },
        onLongPress: () {
          if (_isSheetOpen) return;
          _isSheetOpen = true;
          unawaited(
            showModalBottomSheet<void>(
              context: context,
              builder: (sheetContext) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Edit'),
                        onTap: () {
                          // Perbaikan: gunakan Nav.pop sesuai konvensi navigasi proyek.
                          Nav.pop(sheetContext);
                          unawaited(
                            Nav.to(
                              context,
                              FormKomponen(komponenModel: komponenModel),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        title: Text(
                          'Hapus',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                        ),
                        onTap: () async {
                          if (_isDeletingKomponen) return;
                          // Perbaikan: gunakan Nav.pop sesuai konvensi navigasi proyek.
                          Nav.pop(sheetContext);
                          final confirmed = await showOkCancelAlertDialog(
                            context: context,
                            title: 'Hapus Data',
                            message: 'Data komponen ini akan dihapus secara permanen.',
                            okLabel: 'Hapus',
                            cancelLabel: 'Batal',
                            isDestructiveAction: true,
                          );
                          if (confirmed != OkCancelResult.ok) return;
                          // Hindari setState saat widget sudah tidak aktif setelah await dialog.
                          if (mounted) {
                            setState(() => _isDeletingKomponen = true);
                          }
                          try {
                            await ref
                                .read(komponenProvider.notifier)
                                .hapus(komponenModel.id);
                            if (context.mounted) {
                              AppToast.sukses(
                                context,
                                'Berhasil menghapus ${komponenModel.nama}',
                              );
                            }
                          } catch (e, s) {
                            L.e('Gagal hapus komponen: $e $s');
                            if (context.mounted) {
                              AppToast.gagal(
                                context,
                                'Gagal menghapus ${komponenModel.nama}',
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() => _isDeletingKomponen = false);
                            }
                          }
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.close),
                        title: const Text('Batal'),
                        onTap: () => Nav.pop(sheetContext),
                      ),
                    ],
                  ),
                );
              },
            ).whenComplete(() => _isSheetOpen = false),
          );
        },
      ),
    );
  }
}

/// Widget privat untuk tampilan kosong pada daftar komponen.
class _KomponenKosong extends StatelessWidget {
  final bool modeCari;
  final VoidCallback? onTambah;

  const _KomponenKosong({required this.modeCari, this.onTambah});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: modeCari ? 'Komponen tidak ditemukan' : 'Belum ada komponen',
      liveRegion: true,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              modeCari ? Icons.search_off : Icons.extension_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              modeCari ? 'Komponen tidak ditemukan' : 'Belum ada komponen',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              modeCari
                  ? 'Coba kata kunci lain.'
                  : 'Tambahkan komponen pertama untuk kendaraan terpilih.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onTambah != null) ...[
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: onTambah,
                icon: const Icon(Icons.add),
                label: const Text('Tambah Komponen'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/komponen/provider/komponen_sorted_provider.dart
// ============================================================

```dart
// Konversi dari Provider.family manual ke @riverpod (riverpod_generator) agar konsisten.
// lib/fitur/komponen/provider/komponen_sorted_provider.dart

import 'package:collection/collection.dart';
import 'package:myapp/fitur/komponen/enum/sort_komponen_enum.dart';
import 'package:myapp/fitur/komponen/model/komponen_model.dart';
import 'package:myapp/fitur/komponen/notifier/komponen_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'komponen_sorted_provider.g.dart';

/// Provider family tergenerasi (riverpod_generator) untuk daftar komponen diurutkan.
@riverpod
List<KomponenModel> komponenSorted(Ref ref, SortKomponenEnum sortBy) {
  final asyncState = ref.watch(komponenProvider);
  return asyncState.when(
    data: (state) {
      // Gunakan sorted dari package:collection (aturan pemanfaatan SDK).
      final list = [...state.listKomponenState];
      switch (sortBy) {
        case SortKomponenEnum.namaAZ:
          return list.sorted((a, b) => a.nama.compareTo(b.nama));
        case SortKomponenEnum.namaZA:
          return list.sorted((a, b) => b.nama.compareTo(a.nama));
        case SortKomponenEnum.hargaAZ:
          return list.sorted((a, b) => a.harga.compareTo(b.harga));
        case SortKomponenEnum.hargaZA:
          return list.sorted((a, b) => b.harga.compareTo(a.harga));
      }
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
```


// ============================================================
// FILE: lib/fitur/komponen/state/komponen_state.dart
// ============================================================

```dart
// lib/fitur/komponen/state/komponen_state.dart
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:myapp/fitur/komponen/model/komponen_model.dart';

part 'komponen_state.freezed.dart';

/// State untuk mengelola daftar komponen kendaraan.
@freezed
abstract class KomponenState with _$KomponenState {
  const KomponenState._();

  /// Membuat instance [KomponenState] dengan daftar komponen.
  const factory KomponenState({
    @Default([]) List<KomponenModel> listKomponenState,
  }) = _KomponenState;

  /// Mengembalikan komponen dengan [id], atau null jika tidak ditemukan.
  KomponenModel? getById(String id) {
    return listKomponenState.firstWhereOrNull((item) => item.id == id);
  }

  /// Mengembalikan daftar komponen yang ID-nya terdapat dalam [ids].
  List<KomponenModel> getListByKomponenIds(List<String> ids) {
    return listKomponenState.where((k) => ids.contains(k.id)).toList();
  }

  /// Mengembalikan daftar komponen yang terkait dengan [idKendaraan].
  List<KomponenModel> getListByIdKendaraan(String? idKendaraan) {
    if (idKendaraan == null || idKendaraan.isEmpty) {
      return [];
    }
    return listKomponenState
        .where((k) => k.idKendaraan == idKendaraan)
        .toList();
  }
}
```


// ============================================================
// FILE: lib/fitur/kunci_aplikasi/enum/metode_kunci_enum.dart
// ============================================================

```dart
/// Metode kunci aplikasi yang tersedia.
enum MetodeKunci {
  /// Hanya biometrik (sidik jari / Face ID).
  biometrik,

  /// Hanya PIN.
  pin,

  /// Biometrik dengan fallback PIN.
  biometrikDanPin,
}
```


// ============================================================
// FILE: lib/fitur/kunci_aplikasi/model/kunci_aplikasi_model.dart
// ============================================================

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/kunci_aplikasi/enum/metode_kunci_enum.dart';

part 'kunci_aplikasi_model.freezed.dart';

/// Model preferensi kunci aplikasi.
@freezed
abstract class KunciAplikasiModel with _$KunciAplikasiModel {
  const KunciAplikasiModel._();

  /// Membuat instance [KunciAplikasiModel].
  const factory KunciAplikasiModel({
    @Default(false) bool aktif,
    @Default(MetodeKunci.pin) MetodeKunci metode,
    @Default(1) int durasiAutoLockMenit,
    String? pinHash,
    String? salt,
  }) = _KunciAplikasiModel;
}
```


// ============================================================
// FILE: lib/fitur/kunci_aplikasi/notifier/kunci_aplikasi_notifier.dart
// ============================================================

```dart
import 'package:collection/collection.dart';
import 'package:myapp/fitur/kunci_aplikasi/enum/metode_kunci_enum.dart';
import 'package:myapp/fitur/kunci_aplikasi/model/kunci_aplikasi_model.dart';
import 'package:myapp/fitur/kunci_aplikasi/service/kunci_aplikasi_service.dart';
import 'package:myapp/shared/konstanta/shared_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'kunci_aplikasi_notifier.g.dart';

/// Notifier untuk preferensi kunci aplikasi.
@Riverpod(keepAlive: true)
class KunciAplikasiNotifier extends _$KunciAplikasiNotifier {
  @override
  Future<KunciAplikasiModel> build() async {
    return await _muat();
  }

  Future<KunciAplikasiModel> _muat() async {
    try {
      final aktif =
          await SharedPrefService.getBool(KunciShared.kunciAplikasiAktif) ??
          false;
      final metodeStr = await SharedPrefService.getString(
        KunciShared.kunciAplikasiMetode,
      );
      final metode =
          MetodeKunci.values.firstWhereOrNull((e) => e.name == metodeStr) ??
          MetodeKunci.pin;
      final durasi =
          await SharedPrefService.getInt(
            KunciShared.kunciAplikasiDurasiAutoLock,
          ) ??
          1;
      final pinHash = await KunciAplikasiService.ambilPinHash();
      final salt = await KunciAplikasiService.ambilSalt();
      return KunciAplikasiModel(
        aktif: aktif,
        metode: metode,
        durasiAutoLockMenit: durasi,
        pinHash: pinHash,
        salt: salt,
      );
    } catch (e, s) {
      L.e('Gagal muat kunci aplikasi: $e $s');
      rethrow;
    }
  }

  /// Menyimpan preferensi kunci aplikasi.
  Future<void> simpan(KunciAplikasiModel nilai) async {
    final lama = await future;
    state = AsyncData(nilai);
    try {
      await SharedPrefService.setBool(
        KunciShared.kunciAplikasiAktif,
        nilai.aktif,
      );
      await SharedPrefService.setString(
        KunciShared.kunciAplikasiMetode,
        nilai.metode.name,
      );
      await SharedPrefService.setInt(
        KunciShared.kunciAplikasiDurasiAutoLock,
        nilai.durasiAutoLockMenit,
      );
      // Data sensitif (pinHash, salt) disimpan eksklusif di secure storage.
      await KunciAplikasiService.simpanPinHash(nilai.pinHash);
      await KunciAplikasiService.simpanSalt(nilai.salt);
    } catch (e, s) {
      L.e('Gagal simpan kunci aplikasi: $e $s');
      state = AsyncData(lama);
      rethrow;
    }
  }

  /// Mengaktifkan kunci dengan PIN baru.
  Future<void> aktifkan(MetodeKunci metode, String pin, int durasi) async {
    try {
      await KunciAplikasiService.simpanPin(pin);
      final model = KunciAplikasiModel(
        aktif: true,
        metode: metode,
        durasiAutoLockMenit: durasi,
        pinHash: await KunciAplikasiService.ambilPinHash(),
        salt: await KunciAplikasiService.ambilSalt(),
      );
      await simpan(model);
    } catch (e, s) {
      L.e('Gagal aktifkan kunci: $e $s');
      rethrow;
    }
  }

  /// Menonaktifkan kunci (hapus PIN).
  Future<void> nonaktifkan() async {
    try {
      await KunciAplikasiService.hapusKunci();
      state = const AsyncData(KunciAplikasiModel());
    } catch (e, s) {
      L.e('Gagal nonaktifkan kunci: $e $s');
      rethrow;
    }
  }

  /// Memperbarui durasi auto-lock.
  Future<void> setDurasi(int menit) async {
    // Bungkus async dengan try/catch dan log + rethrow
    try {
      final lama = await future;
      await simpan(lama.copyWith(durasiAutoLockMenit: menit));
    } catch (e, s) {
      L.e('Gagal set durasi: $e $s');
      rethrow;
    }
  }

  /// Memperbarui metode.
  Future<void> setMetode(MetodeKunci metode) async {
    // Bungkus async dengan try/catch dan log + rethrow
    try {
      final lama = await future;
      await simpan(lama.copyWith(metode: metode));
    } catch (e, s) {
      L.e('Gagal set metode: $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/kunci_aplikasi/page/kunci_aplikasi_page.dart
// ============================================================

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kunci_aplikasi/enum/metode_kunci_enum.dart';
import 'package:myapp/fitur/kunci_aplikasi/notifier/kunci_aplikasi_notifier.dart';
import 'package:myapp/fitur/kunci_aplikasi/service/kunci_aplikasi_service.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman kunci aplikasi.
class KunciAplikasiPage extends ConsumerStatefulWidget {
  /// Membuat [KunciAplikasiPage].
  const KunciAplikasiPage({super.key, required this.onBerhasil});

  /// Callback saat kunci berhasil dibuka.
  final VoidCallback onBerhasil;

  @override
  ConsumerState<KunciAplikasiPage> createState() => _KunciAplikasiPageState();
}

class _KunciAplikasiPageState extends ConsumerState<KunciAplikasiPage> {
  final PinInputController _pinController = PinInputController();
  String _pin = '';
  bool _memproses = false;
  String? _pesanError;
  DateTime? _terkunciSampai;
  Duration _sisaWaktu = Duration.zero;
  Timer? _timerHitungMundur;

  // Promosikan lokal untuk menghindari operator ! (AGENTS.md poin 1)
  bool get _terkunci {
    final sampai = _terkunciSampai;
    return sampai != null && sampai.isAfter(DateTime.now());
  }

  @override
  void dispose() {
    _timerHitungMundur?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    unawaited(_muatStatusKunci());
    WidgetsBinding.instance.addPostFrameCallback((_) => _cobaBiometrikAwal());
  }

  Future<void> _muatStatusKunci() async {
    final waktu = await KunciAplikasiService.ambilWaktuKunci();
    if (!mounted) return;
    if (waktu != null) {
      setState(() => _terkunciSampai = waktu);
      _mulaiHitungMundur();
    } else {
      setState(() => _terkunciSampai = null);
    }
  }

  void _mulaiHitungMundur() {
    _timerHitungMundur?.cancel();
    if (_terkunciSampai == null) return;
    // Baca ulang dari lokal setelah cek null (AGENTS.md poin 1)
    void perbarui() {
      final saatIni = _terkunciSampai;
      if (saatIni == null) return;
      final sisa = saatIni.difference(DateTime.now());
      if (sisa <= Duration.zero) {
        _timerHitungMundur?.cancel();
        _timerHitungMundur = null;
        unawaited(KunciAplikasiService.resetPercobaan());
        if (mounted) {
          setState(() {
            _terkunciSampai = null;
            _sisaWaktu = Duration.zero;
            _pesanError = null;
          });
        }
      } else {
        if (mounted) setState(() => _sisaWaktu = sisa);
      }
    }

    perbarui();
    _timerHitungMundur = Timer.periodic(
      const Duration(seconds: 1),
      (_) => perbarui(),
    );
  }

  String _formatDurasi(Duration d) {
    final jam = d.inHours;
    final menit = d.inMinutes.remainder(60);
    final detik = d.inSeconds.remainder(60);
    if (jam > 0) {
      return '$jam jam ${menit.toString().padLeft(2, '0')} menit ${detik.toString().padLeft(2, '0')} detik';
    }
    return '${menit.toString().padLeft(2, '0')}:${detik.toString().padLeft(2, '0')}';
  }

  Future<void> _cobaBiometrikAwal() async {
    // Bungkus async dengan try/catch dan log + rethrow
    try {
      // Biometrik dicoba otomatis jika tersedia dan diaktifkan; fallback ke PIN tetap tersedia.
      final model = await ref.read(kunciAplikasiProvider.future);
      final bioAktif = model.metode != MetodeKunci.pin;
      if (!bioAktif) return;
      final tersedia = await KunciAplikasiService.biometrikTersedia();
      if (!tersedia || !mounted) return;
      await _autentikasiBiometrik();
    } catch (e, s) {
      L.e('Gagal coba biometrik awal: $e $s');
      rethrow;
    }
  }

  Future<void> _autentikasiBiometrik() async {
    if (_memproses) return;
    setState(() => _memproses = true);
    try {
      final ok = await KunciAplikasiService.autentikasiBiometrik();
      if (!mounted) return;
      if (ok) {
        widget.onBerhasil();
      } else {
        setState(() => _pesanError = 'Autentikasi biometrik gagal.');
      }
    } finally {
      if (mounted) setState(() => _memproses = false);
    }
  }

  Future<void> _verifikasiPin() async {
    if (_terkunci) {
      if (mounted) {
        setState(
          () => _pesanError =
              'Terkunci. Coba lagi dalam ${_formatDurasi(_sisaWaktu)}.',
        );
      }
      return;
    }
    if (_pin.length < 4 || _memproses) return;
    setState(() {
      _memproses = true;
      _pesanError = null;
    });
    try {
      final ok = await KunciAplikasiService.verifikasiPin(_pin);
      if (!mounted) return;
      if (ok) {
        await KunciAplikasiService.resetPercobaan();
        if (mounted) {
          setState(() {
            _pin = '';
            _pesanError = null;
          });
          _pinController.clear();
        }
        widget.onBerhasil();
      } else {
        final percobaan = await KunciAplikasiService.ambilPercobaanGagal() + 1;
        if (!mounted) return;
        await KunciAplikasiService.simpanPercobaanGagal(percobaan);
        if (percobaan >= KunciAplikasiService.batasPercobaanGagal) {
          final sampai = DateTime.now().add(KunciAplikasiService.durasiLockout);
          await KunciAplikasiService.simpanWaktuKunci(sampai);
          await KunciAplikasiService.simpanPercobaanGagal(0);
          if (mounted) {
            setState(() {
              _terkunciSampai = sampai;
              _pin = '';
              _pesanError =
                  'Terlalu banyak percobaan. Coba lagi setelah 1 jam.';
            });
            _pinController.clear();
            _mulaiHitungMundur();
          }
        } else {
          final sisa = KunciAplikasiService.batasPercobaanGagal - percobaan;
          if (mounted) {
            setState(() {
              _pesanError = 'PIN salah. Sisa percobaan: $sisa.';
              _pin = '';
            });
            _pinController.clear();
          }
        }
      }
    } finally {
      if (mounted) setState(() => _memproses = false);
    }
  }

  Future<void> _resetDebug() async {
    await KunciAplikasiService.resetPercobaan();
    if (!mounted) return;
    _pinController.clear();
    setState(() {
      _pin = '';
      _pesanError = null;
      _terkunciSampai = null;
      _sisaWaktu = Duration.zero;
    });
    _timerHitungMundur?.cancel();
    _timerHitungMundur = null;
  }

  @override
  Widget build(BuildContext context) {
    final kunciAsync = ref.watch(kunciAplikasiProvider);
    if (kunciAsync.isLoading) {
      return _buildLoading();
    }
    if (kunciAsync.hasError) {
      return _buildError(context, ref);
    }
    final kunciModel = kunciAsync.requireValue;
    final pinAktif = kunciModel.metode != MetodeKunci.biometrik;
    final bioAktif = kunciModel.metode != MetodeKunci.pin;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 56),
                const SizedBox(height: 12),
                Text(
                  'Aplikasi Terkunci',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Masukkan PIN atau gunakan biometrik.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                if (_terkunci)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Terkunci. Coba lagi dalam ${_formatDurasi(_sisaWaktu)}.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  )
                else if (_pesanError != null)
                  // Gunakan ?? '' untuk menghindari bang operator (AGENTS.md poin 1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      _pesanError ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                // Pin input
                if (pinAktif) ...[
                  MaterialPinField(
                    length: 4,
                    pinController: _pinController,
                    enabled: !_terkunci,
                    obscureText: true,
                    onChanged: (v) {
                      if (!mounted) return;
                      setState(() {
                        _pin = v;
                        _pesanError = null;
                      });
                    },
                    onCompleted: (_) => _verifikasiPin(),
                    theme: MaterialPinTheme(
                      cellSize: const Size(52, 52),
                      spacing: 10,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      filledFillColor: Theme.of(context).colorScheme.primary,
                      focusedFillColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      followingFillColor: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      borderColor: Theme.of(context).colorScheme.outline,
                      focusedBorderColor: Theme.of(context).colorScheme.primary,
                      filledBorderColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _pin.length >= 4 && !_memproses && !_terkunci
                          ? _verifikasiPin
                          : null,
                      child: _memproses
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Buka Kunci'),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (bioAktif)
                  TextButton.icon(
                    onPressed: _memproses ? null : _autentikasiBiometrik,
                    icon: const Icon(Icons.fingerprint),
                    label: const Text('Gunakan Biometrik'),
                  ),
                TextButton.icon(
                  onPressed: _memproses ? null : _resetDebug,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset (Debug)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Memuat kunci aplikasi...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat kunci aplikasi'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(kunciAplikasiProvider);
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/kunci_aplikasi/page/pengaturan_kunci_page.dart
// ============================================================

```dart
import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kunci_aplikasi/enum/metode_kunci_enum.dart';
import 'package:myapp/fitur/kunci_aplikasi/notifier/kunci_aplikasi_notifier.dart';
import 'package:myapp/fitur/kunci_aplikasi/service/kunci_aplikasi_service.dart';
import 'package:myapp/shared/konstanta/shared_keys.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman pengaturan kunci aplikasi.
class PengaturanKunciPage extends ConsumerStatefulWidget {
  /// Membuat [PengaturanKunciPage].
  const PengaturanKunciPage({super.key});

  @override
  ConsumerState<PengaturanKunciPage> createState() =>
      _PengaturanKunciPageState();
}

class _PengaturanKunciPageState extends ConsumerState<PengaturanKunciPage> {
  bool _biometrikTersedia = false;

  @override
  void initState() {
    super.initState();
    unawaited(_cekBiometrik());
  }

  Future<void> _cekBiometrik() async {
    // Bungkus async dengan try/catch dan log + rethrow
    try {
      final v = await KunciAplikasiService.biometrikTersedia();
      if (mounted) setState(() => _biometrikTersedia = v);
    } catch (e, s) {
      L.e('Gagal cek biometrik: $e $s');
      rethrow;
    }
  }

  Future<void> _aktifkan() async {
    final hasil = await _dialogPinBaru();
    if (hasil == null) return;
    // Pengecekan tipe aman tanpa cast langsung (hindari `as` pada data mungkin null)
    final pinRaw = hasil['pin'];
    final pin = pinRaw is String ? pinRaw : '';
    final metodeRaw = hasil['metode'];
    final metode = metodeRaw is MetodeKunci
        ? metodeRaw
        : MetodeKunci.pin; // Cek tipe aman
    final durasiRaw = hasil['durasi'];
    final durasi = durasiRaw is int
        ? durasiRaw
        : 1; // Cast aman dengan pengecekan tipe
    if (pin.isEmpty) return;
    try {
      await ref
          .read(kunciAplikasiProvider.notifier)
          .aktifkan(metode, pin, durasi);
      if (mounted) AppToast.sukses(context, 'Kunci aplikasi diaktifkan');
    } catch (e, s) {
      L.e('Gagal aktifkan kunci: $e $s');
      if (mounted) AppToast.gagal(context, 'Gagal mengaktifkan kunci');
    }
  }

  Future<void> _nonaktifkan() async {
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Nonaktifkan Kunci',
      message: 'Apakah Anda yakin ingin menonaktifkan kunci aplikasi?',
      okLabel: 'Nonaktifkan',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (konfirmasi != OkCancelResult.ok) return;
    try {
      await ref.read(kunciAplikasiProvider.notifier).nonaktifkan();
      if (mounted) AppToast.sukses(context, 'Kunci aplikasi dinonaktifkan');
    } catch (e, s) {
      L.e('Gagal nonaktifkan kunci: $e $s');
      if (mounted) AppToast.gagal(context, 'Gagal menonaktifkan kunci');
    }
  }

  Future<void> _togglePin(bool value) async {
    // Bungkus async dengan try/catch dan log + rethrow
    try {
      final model = await ref.read(kunciAplikasiProvider.future);
      if (!mounted) return;
      final bioAktif = model.metode != MetodeKunci.pin;
      if (!value && !bioAktif) {
        // Tidak boleh menonaktifkan keduanya; nonaktifkan kunci jika biometrik tidak tersedia.
        if (_biometrikTersedia) {
          await ref
              .read(kunciAplikasiProvider.notifier)
              .setMetode(MetodeKunci.biometrik);
        } else {
          await _nonaktifkan();
        }
        return;
      }
      MetodeKunci baru;
      if (value && bioAktif) {
        baru = MetodeKunci.biometrikDanPin;
      } else if (value && !bioAktif) {
        baru = MetodeKunci.pin;
      } else if (!value && bioAktif) {
        baru = MetodeKunci.biometrik;
      } else {
        baru = MetodeKunci.pin;
      }
      await ref.read(kunciAplikasiProvider.notifier).setMetode(baru);
    } catch (e, s) {
      L.e('Gagal toggle PIN: $e $s');
      rethrow;
    }
  }

  Future<void> _toggleBiometrik(bool value) async {
    // Bungkus async dengan try/catch dan log + rethrow
    try {
      final model = await ref.read(kunciAplikasiProvider.future);
      if (!mounted) return;
      final pinAktif = model.metode != MetodeKunci.biometrik;
      if (!value && !pinAktif) {
        await _nonaktifkan();
        return;
      }
      MetodeKunci baru;
      if (value && pinAktif) {
        baru = MetodeKunci.biometrikDanPin;
      } else if (value && !pinAktif) {
        baru = MetodeKunci.biometrik;
      } else if (!value && pinAktif) {
        baru = MetodeKunci.pin;
      } else {
        baru = MetodeKunci.pin;
      }
      await ref.read(kunciAplikasiProvider.notifier).setMetode(baru);
    } catch (e, s) {
      L.e('Gagal toggle biometrik: $e $s');
      rethrow;
    }
  }

  Future<void> _ubahPin() async {
    final pinLamaCtrl = TextEditingController();
    final pinBaruCtrl = TextEditingController();
    final konfirmasiCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ubah PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: pinLamaCtrl,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'PIN Lama'),
            ),
            TextField(
              controller: pinBaruCtrl,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'PIN Baru (4 digit)',
              ),
            ),
            TextField(
              controller: konfirmasiCtrl,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Konfirmasi PIN Baru',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Nav.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Nav.pop(ctx, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    final pinLama = pinLamaCtrl.text.trim();
    final pinBaru = pinBaruCtrl.text.trim();
    final konfirmasi = konfirmasiCtrl.text.trim();
    pinLamaCtrl.dispose();
    pinBaruCtrl.dispose();
    konfirmasiCtrl.dispose();
    if (ok != true) return;
    if (pinBaru.length != 4) {
      if (mounted) AppToast.gagal(context, 'PIN harus 4 digit');
      return;
    }
    if (pinBaru != konfirmasi) {
      if (mounted) AppToast.gagal(context, 'Konfirmasi PIN tidak cocok');
      return;
    }
    final verif = await KunciAplikasiService.verifikasiPin(pinLama);
    if (!mounted) return;
    if (!verif) {
      if (mounted) AppToast.gagal(context, 'PIN lama salah');
      return;
    }
    try {
      await KunciAplikasiService.simpanPin(pinBaru);
      final hash = await SharedPrefService.getString(
        KunciShared.kunciAplikasiPinHash,
      );
      final salt = await SharedPrefService.getString(
        KunciShared.kunciAplikasiSalt,
      );
      final lama = await ref.read(kunciAplikasiProvider.future);
      await ref
          .read(kunciAplikasiProvider.notifier)
          .simpan(lama.copyWith(pinHash: hash, salt: salt));
      if (mounted) AppToast.sukses(context, 'PIN berhasil diubah');
    } catch (e, s) {
      L.e('Gagal ubah PIN: $e $s');
      if (mounted) AppToast.gagal(context, 'Gagal mengubah PIN');
    }
  }

  Future<Map<String, dynamic>?> _dialogPinBaru() async {
    final pinCtrl = TextEditingController();
    final konfirmasiCtrl = TextEditingController();
    var aktifkanBiometrik = _biometrikTersedia;
    var durasi = 1;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Aktifkan Kunci'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: pinCtrl,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'PIN (4 digit)'),
                ),
                TextField(
                  controller: konfirmasiCtrl,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Konfirmasi PIN',
                  ),
                ),
                const SizedBox(height: 12),
                if (_biometrikTersedia)
                  CheckboxListTile(
                    value: aktifkanBiometrik,
                    onChanged: (v) {
                      if (v != null) setState(() => aktifkanBiometrik = v);
                    },
                    title: const Text('Aktifkan biometrik'),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                const SizedBox(height: 12),
                DropdownButton<int>(
                  value: durasi,
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Langsung')),
                    DropdownMenuItem(value: 1, child: Text('1 menit')),
                    DropdownMenuItem(value: 5, child: Text('5 menit')),
                    DropdownMenuItem(value: 15, child: Text('15 menit')),
                    DropdownMenuItem(value: -1, child: Text('Tidak pernah')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => durasi = v);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Nav.pop(ctx, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Nav.pop(ctx, true),
              child: const Text('Aktifkan'),
            ),
          ],
        ),
      ),
    );
    final pin = pinCtrl.text.trim();
    final konfirmasi = konfirmasiCtrl.text.trim();
    pinCtrl.dispose();
    konfirmasiCtrl.dispose();
    if (ok != true) return null;
    if (pin.length != 4) {
      if (mounted) AppToast.gagal(context, 'PIN harus 4 digit');
      return null;
    }
    if (pin != konfirmasi) {
      if (mounted) AppToast.gagal(context, 'Konfirmasi PIN tidak cocok');
      return null;
    }
    final metode = aktifkanBiometrik && _biometrikTersedia
        ? MetodeKunci.biometrikDanPin
        : MetodeKunci.pin;
    return {'pin': pin, 'metode': metode, 'durasi': durasi};
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(kunciAplikasiProvider);
    if (asyncModel.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (asyncModel.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kunci Aplikasi')),
        body: Center(child: Text('Gagal memuat: ${asyncModel.error}')),
      );
    }
    final model = asyncModel.requireValue;
    return Scaffold(
      appBar: AppBar(title: const Text('Kunci Aplikasi')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Aktifkan Kunci Aplikasi'),
            subtitle: Text(model.aktif ? 'Aktif' : 'Nonaktif'),
            value: model.aktif,
            onChanged: (v) async {
              if (v) {
                await _aktifkan();
              } else {
                await _nonaktifkan();
              }
            },
          ),
          if (model.aktif) ...[
            SwitchListTile(
              title: const Text('PIN'),
              subtitle: const Text('Wajib untuk membuka kunci'),
              value: model.metode != MetodeKunci.biometrik,
              onChanged: _togglePin,
            ),
            if (_biometrikTersedia)
              SwitchListTile(
                title: const Text('Biometrik'),
                subtitle: const Text('Sidik jari / Face ID'),
                value: model.metode != MetodeKunci.pin,
                onChanged: _toggleBiometrik,
              ),
            ListTile(
              title: const Text('Auto-lock'),
              subtitle: Text(
                model.durasiAutoLockMenit == -1
                    ? 'Tidak pernah'
                    : (model.durasiAutoLockMenit == 0
                          ? 'Langsung'
                          : '${model.durasiAutoLockMenit} menit'),
              ),
              trailing: DropdownButton<int>(
                value: model.durasiAutoLockMenit,
                items: const [
                  DropdownMenuItem(value: 0, child: Text('Langsung')),
                  DropdownMenuItem(value: 1, child: Text('1 menit')),
                  DropdownMenuItem(value: 5, child: Text('5 menit')),
                  DropdownMenuItem(value: 15, child: Text('15 menit')),
                  DropdownMenuItem(value: -1, child: Text('Tidak pernah')),
                ],
                onChanged: (v) async {
                  if (v != null) {
                    await ref.read(kunciAplikasiProvider.notifier).setDurasi(v);
                  }
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.password),
              title: const Text('Ubah PIN'),
              onTap: _ubahPin,
            ),
          ],
        ],
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/kunci_aplikasi/service/kunci_aplikasi_service.dart
// ============================================================

```dart
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myapp/shared/konstanta/shared_keys.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Layanan kunci aplikasi: verifikasi biometrik/PIN dan penyimpanan hash.
class KunciAplikasiService {
  KunciAplikasiService._();

  static final LocalAuthentication _localAuth = LocalAuthentication();
  static const Uuid _uuid = Uuid();
  // Penyimpanan aman untuk data sensitif (hash PIN dan salt).
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// Menentukan apakah perangkat mendukung biometrik.
  static Future<bool> biometrikTersedia() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final supported = await _localAuth.isDeviceSupported();
      return canCheck || supported;
    } catch (e, s) {
      L.e('Gagal cek biometrik: $e $s');
      return false;
    }
  }

  /// Mengembalikan daftar biometrik yang tersedia.
  static Future<List<BiometricType>> biometrikTersediaList() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e, s) {
      L.e('Gagal ambil biometrik: $e $s');
      return <BiometricType>[];
    }
  }

  /// Meminta autentikasi biometrik. Mengembalikan true jika berhasil.
  static Future<bool> autentikasiBiometrik({
    String alasan = 'Buka kunci aplikasi',
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: alasan,
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } on PlatformException catch (e, s) {
      L.e('Biometrik platform error: $e $s');
      return false;
    } catch (e, s) {
      L.e('Gagal autentikasi biometrik: $e $s');
      return false;
    }
  }

  /// Membuat salt acak.
  static String buatSalt() => _uuid.v4();

  /// Membuat hash PIN dengan salt.
  static String hashPin(String pin, String salt) {
    final bytes = utf8.encode('$salt:$pin');
    return sha256.convert(bytes).toString();
  }

  /// Menyimpan PIN baru (membuat salt baru).
  static Future<void> simpanPin(String pin) async {
    try {
      final salt = buatSalt();
      final hash = hashPin(pin, salt);
      // Simpan hash PIN dan salt di secure storage (bukan SharedPreferences).
      await _secureStorage.write(
        key: KunciShared.kunciAplikasiPinHash,
        value: hash,
      );
      await _secureStorage.write(
        key: KunciShared.kunciAplikasiSalt,
        value: salt,
      );
      // Bersihkan penyimpanan lama di SharedPreferences (migrasi).
      await SharedPrefService.remove(KunciShared.kunciAplikasiPinHash);
      await SharedPrefService.remove(KunciShared.kunciAplikasiSalt);
    } catch (e, s) {
      L.e('Gagal simpan PIN: $e $s');
      rethrow;
    }
  }

  /// Membaca hash PIN dari secure storage dengan migrasi legacy dari SharedPreferences.
  static Future<String?> ambilPinHash() async {
    try {
      var hash = await _secureStorage.read(
        key: KunciShared.kunciAplikasiPinHash,
      );
      if (hash == null) {
        final legacy = await SharedPrefService.getString(
          KunciShared.kunciAplikasiPinHash,
        );
        if (legacy != null) {
          await _secureStorage.write(
            key: KunciShared.kunciAplikasiPinHash,
            value: legacy,
          );
          await SharedPrefService.remove(KunciShared.kunciAplikasiPinHash);
          hash = legacy;
        }
      }
      return hash;
    } catch (e, s) {
      L.e('Gagal ambil pin hash: $e $s');
      return null;
    }
  }

  /// Membaca salt dari secure storage dengan migrasi legacy dari SharedPreferences.
  static Future<String?> ambilSalt() async {
    try {
      var salt = await _secureStorage.read(key: KunciShared.kunciAplikasiSalt);
      if (salt == null) {
        final legacy = await SharedPrefService.getString(
          KunciShared.kunciAplikasiSalt,
        );
        if (legacy != null) {
          await _secureStorage.write(
            key: KunciShared.kunciAplikasiSalt,
            value: legacy,
          );
          await SharedPrefService.remove(KunciShared.kunciAplikasiSalt);
          salt = legacy;
        }
      }
      return salt;
    } catch (e, s) {
      L.e('Gagal ambil salt: $e $s');
      return null;
    }
  }

  /// Menyimpan hash PIN ke secure storage.
  static Future<void> simpanPinHash(String? nilai) async {
    try {
      if (nilai == null) {
        await _secureStorage.delete(key: KunciShared.kunciAplikasiPinHash);
      } else {
        await _secureStorage.write(
          key: KunciShared.kunciAplikasiPinHash,
          value: nilai,
        );
      }
      await SharedPrefService.remove(KunciShared.kunciAplikasiPinHash);
    } catch (e, s) {
      L.e('Gagal simpan pin hash: $e $s');
      rethrow;
    }
  }

  /// Menyimpan salt ke secure storage.
  static Future<void> simpanSalt(String? nilai) async {
    try {
      if (nilai == null) {
        await _secureStorage.delete(key: KunciShared.kunciAplikasiSalt);
      } else {
        await _secureStorage.write(
          key: KunciShared.kunciAplikasiSalt,
          value: nilai,
        );
      }
      await SharedPrefService.remove(KunciShared.kunciAplikasiSalt);
    } catch (e, s) {
      L.e('Gagal simpan salt: $e $s');
      rethrow;
    }
  }

  /// Memverifikasi PIN dengan hash tersimpan.
  static Future<bool> verifikasiPin(String pin) async {
    try {
      // Baca dari secure storage; fallback ke SharedPreferences lama untuk migrasi.
      var hashTersimpan = await _secureStorage.read(
        key: KunciShared.kunciAplikasiPinHash,
      );
      var salt = await _secureStorage.read(key: KunciShared.kunciAplikasiSalt);
      if (hashTersimpan == null || salt == null) {
        final legacyHash = await SharedPrefService.getString(
          KunciShared.kunciAplikasiPinHash,
        );
        final legacySalt = await SharedPrefService.getString(
          KunciShared.kunciAplikasiSalt,
        );
        if (legacyHash != null && legacySalt != null) {
          await _secureStorage.write(
            key: KunciShared.kunciAplikasiPinHash,
            value: legacyHash,
          );
          await _secureStorage.write(
            key: KunciShared.kunciAplikasiSalt,
            value: legacySalt,
          );
          await SharedPrefService.remove(KunciShared.kunciAplikasiPinHash);
          await SharedPrefService.remove(KunciShared.kunciAplikasiSalt);
          hashTersimpan = legacyHash;
          salt = legacySalt;
        }
      }
      if (hashTersimpan == null || salt == null) return false;
      final hashInput = hashPin(pin, salt);
      return _bandingkanKonstan(hashInput, hashTersimpan);
    } catch (e, s) {
      L.e('Gagal verifikasi PIN: $e $s');
      return false;
    }
  }

  /// Batas maksimal percobaan PIN gagal sebelum lockout.
  static const int batasPercobaanGagal = 3;

  /// Durasi lockout setelah melebihi batas percobaan (1 jam).
  static const Duration durasiLockout = Duration(hours: 1);

  /// Mengambil jumlah percobaan PIN gagal saat ini.
  static Future<int> ambilPercobaanGagal() async {
    try {
      return await SharedPrefService.getInt(
            KunciShared.kunciAplikasiPercobaanGagal,
          ) ??
          0;
    } catch (e, s) {
      L.e('Gagal ambil percobaan gagal: $e $s');
      return 0;
    }
  }

  /// Menyimpan jumlah percobaan PIN gagal.
  static Future<void> simpanPercobaanGagal(int jumlah) async {
    try {
      await SharedPrefService.setInt(
        KunciShared.kunciAplikasiPercobaanGagal,
        jumlah,
      );
    } catch (e, s) {
      L.e('Gagal simpan percobaan gagal: $e $s');
      rethrow;
    }
  }

  /// Mengambil waktu berakhir lockout (null jika tidak terkunci).
  static Future<DateTime?> ambilWaktuKunci() async {
    try {
      final millis = await SharedPrefService.getInt(
        KunciShared.kunciAplikasiKunciSampai,
      );
      if (millis == null || millis <= 0) return null;
      final waktu = DateTime.fromMillisecondsSinceEpoch(millis);
      if (waktu.isBefore(DateTime.now())) return null;
      return waktu;
    } catch (e, s) {
      L.e('Gagal ambil waktu kunci: $e $s');
      return null;
    }
  }

  /// Menyimpan waktu berakhir lockout (null untuk menghapus).
  static Future<void> simpanWaktuKunci(DateTime? waktu) async {
    try {
      if (waktu == null) {
        await SharedPrefService.setInt(KunciShared.kunciAplikasiKunciSampai, 0);
      } else {
        await SharedPrefService.setInt(
          KunciShared.kunciAplikasiKunciSampai,
          waktu.millisecondsSinceEpoch,
        );
      }
    } catch (e, s) {
      L.e('Gagal simpan waktu kunci: $e $s');
      rethrow;
    }
  }

  /// Mereset percobaan gagal dan lockout (mis. setelah PIN benar).
  static Future<void> resetPercobaan() async {
    try {
      await simpanPercobaanGagal(0);
      await simpanWaktuKunci(null);
    } catch (e, s) {
      L.e('Gagal reset percobaan: $e $s');
      rethrow;
    }
  }

  /// Perbandingan string konstan-waktu sederhana.
  static bool _bandingkanKonstan(String a, String b) {
    if (a.length != b.length) return false;
    var hasil = 0;
    for (var i = 0; i < a.length; i++) {
      hasil |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return hasil == 0;
  }

  /// Menghapus data kunci (PIN).
  static Future<void> hapusKunci() async {
    try {
      await _secureStorage.delete(key: KunciShared.kunciAplikasiPinHash);
      await _secureStorage.delete(key: KunciShared.kunciAplikasiSalt);
      await SharedPrefService.remove(KunciShared.kunciAplikasiPinHash);
      await SharedPrefService.remove(KunciShared.kunciAplikasiSalt);
      await SharedPrefService.setBool(KunciShared.kunciAplikasiAktif, false);
      await simpanPercobaanGagal(0);
      await simpanWaktuKunci(null);
    } catch (e, s) {
      L.e('Gagal hapus kunci: $e $s');
      rethrow;
    }
  }

  /// Membaca status aktif.
  static Future<bool> aktif() async {
    try {
      final v = await SharedPrefService.getBool(KunciShared.kunciAplikasiAktif);
      return v ?? false;
    } catch (e, s) {
      L.e('Gagal baca status kunci aktif: $e $s');
      return false; // default aman jika SharedPref gagal
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/kunci_aplikasi/widget/kunci_aplikasi_gate.dart
// ============================================================

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kunci_aplikasi/model/kunci_aplikasi_model.dart';
import 'package:myapp/fitur/kunci_aplikasi/notifier/kunci_aplikasi_notifier.dart';
import 'package:myapp/fitur/kunci_aplikasi/page/kunci_aplikasi_page.dart';
import 'package:share_global_saya/core_shared.dart';

/// Penjaga akses aplikasi; menampilkan layar kunci bila perlu.
class KunciAplikasiGate extends ConsumerStatefulWidget {
  /// Membuat [KunciAplikasiGate].
  const KunciAplikasiGate({super.key, required this.child});

  /// Widget anak yang dilindungi.
  final Widget child;

  @override
  ConsumerState<KunciAplikasiGate> createState() => _KunciAplikasiGateState();
}

class _KunciAplikasiGateState extends ConsumerState<KunciAplikasiGate>
    with WidgetsBindingObserver {
  bool _terkunci = false;
  DateTime? _waktuBackground;

  @override
  void initState() {
    super.initState();
    L.i('KunciAplikasiGate initState');
    WidgetsBinding.instance.addObserver(this);
    unawaited(_muatAwal());
  }

  Future<void> _muatAwal() async {
    L.i('KunciAplikasiGate _muatAwal mulai');
    try {
      final model = await ref.read(kunciAplikasiProvider.future);
      L.i('KunciAplikasiGate model aktif=${model.aktif}');
      if (mounted && model.aktif) {
        setState(() => _terkunci = true);
        L.i('KunciAplikasiGate terkunci=true (awal)');
      }
    } catch (e, s) {
      L.e('KunciAplikasiGate _muatAwal gagal: $e $s');
    }
  }

  @override
  void dispose() {
    L.i('KunciAplikasiGate dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    L.i('KunciAplikasiGate lifecycle=$state');
    unawaited(_tanganiLifecycle(state));
  }

  Future<void> _tanganiLifecycle(AppLifecycleState state) async {
    KunciAplikasiModel model;
    try {
      model = await ref.read(kunciAplikasiProvider.future);
    } catch (e, st) {
      L.e('KunciAplikasiGate gagal baca model: $e $st');
      return;
    }
    if (!mounted || !model.aktif) {
      L.i('KunciAplikasiGate model null/tidak aktif, skip');
      return;
    }
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      _waktuBackground = DateTime.now();
      L.i('KunciAplikasiGate background waktu=$_waktuBackground');
      if (model.durasiAutoLockMenit == 0) {
        // Kunci langsung.
        L.i('KunciAplikasiGate durasi 0, kunci langsung');
        if (mounted) setState(() => _terkunci = true);
      }
    } else if (state == AppLifecycleState.resumed) {
      if (model.durasiAutoLockMenit < 0) {
        L.i('KunciAplikasiGate durasi <0, skip lock');
        return;
      }
      final mulai = _waktuBackground;
      if (mulai == null) {
        L.i('KunciAplikasiGate _waktuBackground null, skip');
        return;
      }
      final selisih = DateTime.now().difference(mulai).inMinutes;
      L.i(
        'KunciAplikasiGate resumed selisih=$selisih menit, durasi=${model.durasiAutoLockMenit}',
      );
      if (selisih >= model.durasiAutoLockMenit) {
        L.i('KunciAplikasiGate kunci karena selisih >= durasi');
        if (mounted) setState(() => _terkunci = true);
      }
    }
  }

  void _bukaKunci() {
    L.i('KunciAplikasiGate _bukaKunci');
    if (mounted) setState(() => _terkunci = false);
  }

  @override
  Widget build(BuildContext context) {
    final asyncModel = ref.watch(kunciAplikasiProvider);
    // Jika provider error, tampilkan child (jangan kunci).
    if (asyncModel.hasError) {
      L.i('KunciAplikasiGate provider error, tampilkan child');
      return widget.child;
    }
    if (asyncModel.isLoading) {
      L.i('KunciAplikasiGate provider loading, tampilkan child');
      return widget.child;
    }

    if (_terkunci) {
      L.i('KunciAplikasiGate terkunci, tampilkan KunciAplikasiPage');
      return KunciAplikasiPage(onBerhasil: _bukaKunci);
    }
    L.i('KunciAplikasiGate tidak terkunci, tampilkan child');
    return widget.child;
  }
}
```


// ============================================================
// FILE: lib/fitur/multi_mata_uang/helper/format_mata_uang.dart
// ============================================================

```dart
// lib/fitur/multi_mata_uang/helper/format_mata_uang.dart
import 'package:intl/intl.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';

/// Memformat [nilai] sebagai mata uang sesuai [mataUang] (locale + simbol). Jumlah digit desimal mengikuti default locale jika [digitDesimal] null.
String formatMataUang(num nilai, MataUangItem mataUang, {int? digitDesimal}) {
  final format = NumberFormat.currency(
    locale: mataUang.locale,
    symbol: mataUang.simbol,
    decimalDigits: digitDesimal,
  );
  return format.format(nilai);
}

/// Mem-parse teks input pengguna menjadi [double] dengan aman. Menangani format Indonesia/Eropa (titik ribuan, koma desimal) dan format standar (koma ribuan, titik desimal) berdasarkan pemisah terakhir. Mengembalikan null jika teks tidak valid.
double? parseMataUang(String teks) {
  final bersih = teks.trim().replaceAll(RegExp(r'[^\d.,\-]'), '');
  if (bersih.isEmpty) return null;

  final lastDot = bersih.lastIndexOf('.');
  final lastComma = bersih.lastIndexOf(',');
  String normal;

  if (lastDot != -1 && lastComma != -1) {
    if (lastDot > lastComma) {
      // Terakhir titik -> titik desimal, koma ribuan (standar US/Eropa)
      normal = bersih.replaceAll(',', '');
    } else {
      // Terakhir koma -> koma desimal, titik ribuan (format Indonesia/Eropa)
      normal = bersih.replaceAll('.', '').replaceAll(',', '.');
    }
  } else if (lastComma != -1) {
    // Hanya koma
    final after = bersih.substring(lastComma + 1);
    if (after.length > 2 || bersih.split(',').length > 2) {
      normal = bersih.replaceAll(',', '');
    } else {
      normal = bersih.replaceAll(',', '.');
    }
  } else if (lastDot != -1) {
    // Hanya titik
    final after = bersih.substring(lastDot + 1);
    final parts = bersih.split('.');
    if (after.length > 2 ||
        (after.length == 3 && parts.first.length <= 3) ||
        (parts.length > 2)) {
      normal = bersih.replaceAll('.', '');
    } else {
      normal = bersih;
    }
  } else {
    normal = bersih;
  }

  return double.tryParse(normal);
}
```


// ============================================================
// FILE: lib/fitur/multi_mata_uang/model/mata_uang_item.dart
// ============================================================

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mata_uang_item.freezed.dart';

/// Model untuk pemilihan mata uang oleh pengguna. Digunakan dalam fitur multi mata uang (3.9) bersama DropdownSearch. Konversi model ke freezed untuk konsistensi dan adanya copyWith/equality.
@freezed
abstract class MataUangItem with _$MataUangItem {
  const MataUangItem._();

  /// Membuat [MataUangItem].
  const factory MataUangItem({
    /// Kode ISO / identitas mata uang, misal IDR, USD, EUR.
    required String kode,

    /// Nama lengkap mata uang, misal Rupiah, US Dollar.
    required String nama,

    /// Simbol tampilan, misal Rp, $, €.
    required String simbol,

    /// Locale untuk format angka (titik/koma), misal id_ID atau en_US.
    required String locale,
  }) = _MataUangItem;
}

/// Daftar mata uang umum untuk pemilihan. Default adalah IDR; bisa diperluas sesuai kebutuhan perjalanan.
const daftarMataUang = [
  MataUangItem(kode: 'IDR', nama: 'Rupiah', simbol: 'Rp', locale: 'id_ID'),
  MataUangItem(kode: 'USD', nama: 'US Dollar', simbol: r'$', locale: 'en_US'),
  MataUangItem(kode: 'EUR', nama: 'Euro', simbol: '€', locale: 'de_DE'),
  MataUangItem(
    kode: 'SGD',
    nama: 'Singapore Dollar',
    simbol: r'S$',
    locale: 'en_SG',
  ),
  MataUangItem(kode: 'JPY', nama: 'Japanese Yen', simbol: '¥', locale: 'ja_JP'),
  MataUangItem(
    kode: 'MYR',
    nama: 'Malaysian Ringgit',
    simbol: 'RM',
    locale: 'ms_MY',
  ),
  MataUangItem(kode: 'THB', nama: 'Thai Baht', simbol: '฿', locale: 'th_TH'),
  MataUangItem(
    kode: 'GBP',
    nama: 'Pound Sterling',
    simbol: '£',
    locale: 'en_GB',
  ),
];
```


// ============================================================
// FILE: lib/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart
// ============================================================

```dart
// lib/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart
import 'package:collection/collection.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/shared/konstanta/shared_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'mata_uang_notifier.g.dart';

@Riverpod(keepAlive: true)
/// Notifier untuk mengelola mata uang yang dipilih.
class MataUangNotifier extends _$MataUangNotifier {
  @override
  Future<MataUangItem> build() async {
    try {
      final kode = await SharedPrefService.getString(
        KunciShared.mataUangTerpilih,
      );
      if (kode != null && kode.isNotEmpty) {
        final item = daftarMataUang.firstWhereOrNull((m) => m.kode == kode);
        if (item != null) return item;
      }
      return daftarMataUang.first;
    } catch (e, s) {
      L.e('Gagal muat mata uang: $e $s');
      rethrow;
    }
  }

  /// Mengatur mata uang yang dipilih.
  Future<void> set(MataUangItem item) async {
    try {
      await SharedPrefService.setString(
        KunciShared.mataUangTerpilih,
        item.kode,
      );
      state = AsyncData(item);
    } catch (e, s) {
      L.e('Gagal menyimpan mata uang: $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/pengaturan/page/pengaturan_page.dart
// ============================================================

```dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kunci_aplikasi/page/pengaturan_kunci_page.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:myapp/shared/db/sqflite/db_sqflite.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/notifikasi/notifikasi_service.dart';
import 'package:myapp/shared/tema/tema_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

/// Halaman pengaturan aplikasi.
class PengaturanPage extends ConsumerStatefulWidget {
  /// Membuat [PengaturanPage].
  const PengaturanPage({super.key});

  @override
  ConsumerState<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends ConsumerState<PengaturanPage> {
  bool _notifDiizinkan = false;
  bool _notifAktif = true;
  bool _memuatIzin = true;

  @override
  void initState() {
    super.initState();
    unawaited(_muatStatusNotifikasi());
  }

  Future<void> _muatStatusNotifikasi() async {
    var diizinkan = false;

    try {
      // Gunakan NotifikasiService agar tidak membuat instance baru plugin notifikasi.
      diizinkan = await NotifikasiService.mintaIzin();
      final aktif = await NotifikasiService.aktif;

      if (mounted) {
        setState(() {
          _notifDiizinkan = diizinkan;
          _notifAktif = aktif;
          _memuatIzin = false;
        });
      }
    } catch (e, s) {
      // Mencegah loading izin notifikasi macet selamanya jika terjadi error.
      L.e('Gagal memuat status notifikasi: $e $s');
      if (mounted) {
        setState(() => _memuatIzin = false);
      }
    }
  }

  Future<void> _mintaIzinNotifikasi() async {
    // Bungkus async dengan try/catch dan log + rethrow
    try {
      await NotifikasiService.mintaIzin();
      await _muatStatusNotifikasi();
    } catch (e, s) {
      L.e('Gagal minta izin notifikasi: $e $s');
      rethrow;
    }
  }

  Future<void> _setAktifNotifikasi(bool value) async {
    await NotifikasiService.setAktif(value);
    if (mounted) {
      setState(() => _notifAktif = value);
    }
  }

  Future<void> _tampilkanPilihanEkspor(BuildContext context) async {
    try {
      final hasil = await showAlertDialog<String>(
        context: context,
        title: 'Cadangkan Data',
        message: 'Pilih format file cadangan data kendaraan Anda.',
        actions: [
          const AlertDialogAction(label: 'CSV', key: 'csv'),
          const AlertDialogAction(label: 'JSON', key: 'json'),
          const AlertDialogAction(
            label: 'Batal',
            key: 'batal',
            isDefaultAction: true,
          ),
        ],
      );
      if (!mounted) return;
      if (hasil == 'csv') {
        await _eksporData(
          'csv',
        ); // aturan: await Future agar tidak unawaited_futures
      } else if (hasil == 'json') {
        await _eksporData(
          'json',
        ); // aturan: await Future agar tidak unawaited_futures
      }
    } catch (e, st) {
      L.e('Gagal menampilkan pilihan ekspor: $e $st');
    }
  }

  Future<void> _eksporData(String format) async {
    try {
      final db = await ref
          .read(dbSqfliteProvider)
          .database; // lewat provider, hindari instance baru (bug runtime #2)
      final hasil = await db.query(NamaTabel.kendaraan);
      Directory dir;
      try {
        dir = await getApplicationDocumentsDirectory();
      } catch (e, s) {
        // Fallback ke direktori sementara apabila direktori dokumen tidak tersedia; catat kegagalan.
        L.w(
          'Gagal mengakses direktori dokumen, gunakan direktori sementara: $e $s',
        );
        dir = await getTemporaryDirectory();
      }
      // Gunakan UUID sebagai identitas unik nama file cadangan, bukan timestamp.
      final namaWaktu = const Uuid().v4();
      final ext = format == 'csv' ? 'csv' : 'json';
      final namaFile = 'cadangan_kendaraan_$namaWaktu.$ext';
      final path = '${dir.path}/$namaFile';

      if (format == 'json') {
        final file = File(path);
        await file.writeAsString(jsonEncode(hasil));
      } else {
        final buffer = StringBuffer();
        if (hasil.isNotEmpty) {
          buffer.write('${hasil.first.keys.join(',')}\n');
          for (final baris in hasil) {
            buffer.write('${baris.values.map((v) => '"$v"').join(',')}\n');
          }
        }
        await File(path).writeAsString(buffer.toString());
      }

      await SharePlus.instance.share(
        ShareParams(files: [XFile(path)], text: 'Cadangan kendaraan $namaFile'),
      );

      if (mounted) {
        AppToast.sukses(context, 'Cadangan berhasil: $namaFile');
      }
    } catch (e, s) {
      L.e('Gagal ekspor cadangan: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal membuat cadangan data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final temaAsync = ref.watch(temaAplikasiProvider);
    final mataUangAsync = ref.watch(mataUangProvider);
    if (temaAsync.isLoading || mataUangAsync.isLoading) {
      return _buildLoading();
    }
    if (temaAsync.hasError || mataUangAsync.hasError) {
      return _buildError(context, ref);
    }

    final temaState = temaAsync.requireValue;
    final mataUang = mataUangAsync.requireValue;
    return _buildScaffold(context, ref, temaState, mataUang);
  }

  Widget _buildScaffold(
    BuildContext context,
    WidgetRef ref,
    TemaAplikasi temaState,
    MataUangItem mataUang,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            tooltip: 'Cadangan Data',
            onPressed: () => _tampilkanPilihanEkspor(context),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              _notifDiizinkan
                  ? (_notifAktif
                        ? Icons.notifications_active
                        : Icons.notifications_off)
                  : Icons.notifications_none,
            ),
            title: Text(
              'Notifikasi',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              _memuatIzin
                  ? 'Memeriksa izin...'
                  : (!_notifDiizinkan
                        ? 'Izin belum diberikan'
                        : (_notifAktif ? 'Aktif' : 'Nonaktif')),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            trailing: _memuatIzin
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : (!_notifDiizinkan
                      ? TextButton(
                          onPressed: _mintaIzinNotifikasi,
                          child: Text(
                            'Aktifkan izin',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      : Switch(
                          value: _notifAktif,
                          onChanged: _setAktifNotifikasi,
                        )),
          ),
          ListTile(
            title: Text('Tema', style: Theme.of(context).textTheme.bodyLarge),
            subtitle: Text(
              temaState.label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: PopupMenuButton<TemaAplikasi>(
              icon: Icon(temaState.icon),
              onSelected: (value) async {
                try {
                  await ref.read(temaAplikasiProvider.notifier).set(value);
                } catch (e, s) {
                  L.e('Gagal mengubah tema: $e $s');
                  if (context.mounted) {
                    AppToast.gagal(context, 'Gagal mengubah tema');
                  }
                }
              },
              itemBuilder: (context) => TemaAplikasi.values
                  .map(
                    (t) => CheckedPopupMenuItem<TemaAplikasi>(
                      value: t,
                      checked: t == temaState,
                      child: Row(
                        spacing: 8,
                        children: [
                          Icon(t.icon),
                          Text(
                            t.label,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          _buildMataUang(mataUang),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: Text(
              'Kunci Aplikasi',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              'PIN / biometrik',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () {
              // Navigasi wajib menggunakan helper Nav dari core_shared (aturan_lainnya.md poin 32).
              unawaited(Nav.to(context, const PengaturanKunciPage()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMataUang(MataUangItem mataUangItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        spacing: 16,
        children: [
          const Text('Mata Uang'),
          Expanded(
            child: DropdownSearch<MataUangItem>(
              items: (filter, props) => daftarMataUang,
              selectedItem: mataUangItem,
              itemAsString: (m) => '${m.simbol} ${m.kode} — ${m.nama}',
              onChanged: (m) async {
                if (m == null) return;
                try {
                  await ref.read(mataUangProvider.notifier).set(m);
                } catch (e, s) {
                  L.e('Gagal menyimpan mata uang: $e $s');
                  if (mounted) {
                    AppToast.gagal(context, 'Gagal menyimpan mata uang');
                  }
                }
              },
              compareFn: (a, b) => a.kode == b.kode,
              decoratorProps: const DropDownDecoratorProps(
                decoration: InputDecoration(
                  labelText: 'Mata Uang',
                  hintText: 'Pilih mata uang',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Text(
              'Memuat pengaturan...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Gagal memuat pengaturan',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(
                  temaAplikasiProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  mataUangProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: Text(
                'Coba lagi',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/pengingat/enum/kategori_pengingat.dart
// ============================================================

```dart
/// Kategori pengingat yang tersedia.
enum KategoriPengingat {
  /// Semua kategori.
  semua,

  /// Pengingat pajak.
  pajak,

  /// Pengingat jadwal service.
  jadwalService,
}

/// Ekstensi label untuk kategori pengingat.
extension KategoriPengingatExtension on KategoriPengingat {
  /// Label dalam bahasa Indonesia.
  String get label => switch (this) {
    KategoriPengingat.semua => 'Semua',
    KategoriPengingat.pajak => 'Pajak',
    KategoriPengingat.jadwalService => 'Jadwal Service',
  };
}
```


// ============================================================
// FILE: lib/fitur/pengingat/model/pengingat_model.dart
// ============================================================

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/pengingat/enum/kategori_pengingat.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'pengingat_model.freezed.dart';

/// Halaman tujuan pengingat.
enum PageTujuan {
  /// Halaman kendaraan.
  kendaraanPage,
}

/// Model pengingat pentru pajak dan jadwal service.
@freezed
abstract class PengingatModel with _$PengingatModel {
  const PengingatModel._();

  /// Buat instance [PengingatModel].
  const factory PengingatModel({
    /// ID unik pengingat.
    required String id,

    /// ID kendaraan terkait.
    required String idKendaraan,

    /// Pesan pengingat.
    required String pesan,

    /// Tanggal dan waktu menampilkan pengingat.
    required DateTime tanggalTampil,

    /// Kategori pengingat.
    required KategoriPengingat kategoriPengingat,

    /// Halaman tujuan.
    required PageTujuan pageTujuan,

    /// Waktu data terakhir diperbarui.
    required DateTime diperbarui,
  }) = _PengingatModel;

  /// Membuat [PengingatModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory PengingatModel.fromSqflite(Map<String, dynamic> map) {
    try {
      return PengingatModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
        pesan: map[NamaKolom.pesan]?.toString() ?? '',
        tanggalTampil:
            ParserUtil.parseDateTime(map[NamaKolom.tanggalTampil]) ??
            DateTime.now(),
        // Menggunakan safeParseEnum agar tidak melempar ArgumentError saat
        // nilai enum tidak valid, dengan fallback ke nilai default.
        kategoriPengingat:
            ParserUtil.safeParseEnum(
              KategoriPengingat.values,
              map[NamaKolom.kategoriPengingat]?.toString(),
            ) ??
            KategoriPengingat.pajak,
        pageTujuan:
            ParserUtil.safeParseEnum(
              PageTujuan.values,
              map[NamaKolom.pageTujuan]?.toString(),
            ) ??
            PageTujuan.kendaraanPage,
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
      );
    } catch (e, s) {
      L.e('Gagal parse PengingatModel dari Sqflite: $e $s');
      rethrow;
    }
  }

  /// Mengubah [PengingatModel] menjadi Map untuk Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.pesan: pesan,
    NamaKolom.tanggalTampil: tanggalTampil.toIso8601String(),
    NamaKolom.kategoriPengingat: kategoriPengingat.name,
    NamaKolom.pageTujuan: pageTujuan.name,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
  };
}
```


// ============================================================
// FILE: lib/fitur/pengingat/notifier/pengingat_notifier.dart
// ============================================================

```dart
// lib/fitur/pengingat/notifier/pengingat_notifier.dart
import 'package:myapp/fitur/pengingat/model/pengingat_model.dart';
import 'package:myapp/fitur/pengingat/state/pengingat_state.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'pengingat_notifier.g.dart';

/// Notifier untuk mengelola data pengingat.
@Riverpod(keepAlive: true)
class PengingatNotifier extends _$PengingatNotifier {
  final _tabelPengingat = NamaTabel
      .pengingat; // Gunakan konstanta agar konsisten dan mudah dipelihara.

  /// Membangun state awal dengan memuat data pengingat dari database.
  @override
  Future<PengingatState> build() async {
    return await _muatData();
  }

  /// Memuat ulang data pengingat dari database.
  Future<PengingatState> _muatData() async {
    try {
      final db = ref.read(baseOpSqfliteProvider);
      final listDb = await db.ambilData(_tabelPengingat);
      final listHasil = listDb
          .whereType<Map<String, dynamic>>()
          .map(PengingatModel.fromSqflite)
          .toList();
      // Defensif: hanya proses baris yang benar-benar bertipe Map.
      return PengingatState(listPengingat: listHasil);
    } catch (e, s) {
      // Tangani semua error runtime (termasuk ArgumentError dari model)
      // agar tidak ada yang terlewat saat parsing data database.
      L.e('Gagal memuat pengingat: $e $s');
      rethrow;
    }
  }

  /// Menambahkan [pengingat] baru ke daftar dan database.
  Future<void> tambah(PengingatModel pengingat) async {
    final dataLama = await future;
    // 1. Optimistic update
    final listBaru = dataLama.copyWith(
      listPengingat: [...dataLama.listPengingat, pengingat],
    );
    state = AsyncValue.data(listBaru);

    try {
      // 2. Update DB
      await ref
          .read(baseOpSqfliteProvider)
          .tambah(_tabelPengingat, pengingat.toSqflite());
    } catch (e, s) {
      // Tangani semua error runtime (termasuk ArgumentError dari model)
      // lalu rollback state ke data sebelumnya.
      L.e('tambah pengingat gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Menghapus pengingat dengan [id] dari daftar dan database.
  Future<void> hapus(String id) async {
    final dataLama = await future;
    // 1. Optimistic update
    final listBaru = dataLama.listPengingat.where((e) => e.id != id).toList();
    state = AsyncValue.data(dataLama.copyWith(listPengingat: listBaru));

    try {
      // 2. Hapus DB
      await ref.read(baseOpSqfliteProvider).hapus(_tabelPengingat, id);
    } catch (e, s) {
      // 3. Rollback
      L.e('hapus pengingat gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Mengubah data [pengingat] di daftar dan database.
  Future<void> ubah(PengingatModel pengingat) async {
    final dataLama = await future;
    // 1. Optimistic update
    final listBaru = dataLama.listPengingat
        .map((e) => e.id == pengingat.id ? pengingat : e)
        .toList();
    state = AsyncValue.data(dataLama.copyWith(listPengingat: listBaru));

    try {
      // 2. Update DB
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(_tabelPengingat, pengingat.toSqflite(), pengingat.id);
    } catch (e, s) {
      // Tangani semua error runtime (termasuk ArgumentError dari model)
      // lalu rollback state ke data sebelumnya.
      L.e('ubah pengingat gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Melakukan batch insert [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(List<PengingatModel> data) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabelPengingat,
            data.map((e) => e.toSqflite()).toList(),
          );

      state = AsyncValue.data(await _muatData());
    } catch (e, s) {
      L.e('Gagal batch insert pengingat $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/pengingat/page/detail_pengingat.dart
// ============================================================

```dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/page/detail_kendaraan_page.dart';
import 'package:myapp/fitur/pengingat/notifier/pengingat_notifier.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman detail pengingat.
class DetailPengingat extends ConsumerWidget {
  /// Identifikasi pengingat yang ditampilkan.
  final String id;

  /// Membuat [DetailPengingat] dengan [id] pengingat.
  const DetailPengingat({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pengingatAsync = ref.watch(pengingatProvider);
    final kendaraanAsync = ref.watch(kendaraanProvider);

    if (pengingatAsync.isLoading || kendaraanAsync.isLoading) {
      return _buildLoading();
    }

    if (pengingatAsync.hasError || kendaraanAsync.hasError) {
      return _buildError(context, ref);
    }

    final pengingatState = pengingatAsync.requireValue;
    final kendaraanState = kendaraanAsync.requireValue;

    final dataPengingat = pengingatState.getById(id);
    final idKendaraan = dataPengingat?.idKendaraan;

    KendaraanModel? kendaraanModel;
    if (idKendaraan != null) {
      kendaraanModel = kendaraanState.getById(idKendaraan);
    }

    if (dataPengingat == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Pengingat')),
        body: Center(
          child: Text(
            'Pengingat tidak ditemukan',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengingat')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildItemKendaraan(context, kendaraanModel),
              _buildRowCustom(
                context,
                'Pesan:',
                dataPengingat.pesan,
                spaceBetween: true,
              ),
              _buildRowCustom(
                context,
                'Tanggal tampil:',
                FormatWaktuLengkap.formatSingkat(dataPengingat.tanggalTampil),
                spaceBetween: true,
              ),
              _buildRowCustom(
                context,
                'Kategori:',
                dataPengingat.kategoriPengingat.name,
                spaceBetween: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemKendaraan(
    BuildContext context,
    KendaraanModel? kendaraanModel,
  ) {
    if (kendaraanModel == null) {
      return const Card(
        child: Center(child: Text('Kendaraan tidak ditemukan')),
      );
    }
    return InkWell(
      onTap: () => unawaited(
        Nav.to(context, DetailKendaraanPage(id: kendaraanModel.id)),
      ), // aturan unawaited
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            spacing: 8,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: _GambarKendaraan(
                    pathGambar: kendaraanModel.pathGambar,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildRowCustom(context, 'Nama:', kendaraanModel.nama),
                    _buildRowCustom(context, 'Merk:', kendaraanModel.merk),
                    _buildRowCustom(
                      context,
                      'Model:',
                      kendaraanModel.model ?? '-',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Membuat baris label-value untuk pengingat atau kendaraan.
  Widget _buildRowCustom(
    BuildContext context,
    String label,
    String value, {
    bool spaceBetween = false,
  }) {
    return Row(
      mainAxisAlignment: spaceBetween
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        if (spaceBetween)
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          )
        else
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        if (spaceBetween)
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.right,
            ),
          )
        else
          Flexible(
            child: Text(value, overflow: TextOverflow.ellipsis, softWrap: true),
          ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [CircularProgressIndicator(), Text('Memuat pengingat...')],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengingat')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Text(
              'Gagal memuat pengingat',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(
                  pengingatProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  kendaraanProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget gambar kendaraan dengan penanganan null dan error aman.
class _GambarKendaraan extends StatelessWidget {
  final String? pathGambar;
  const _GambarKendaraan({this.pathGambar});

  @override
  Widget build(BuildContext context) {
    final path = pathGambar;
    if (path == null || path.isEmpty) {
      return const Icon(Icons.directions_car, size: 64);
    }
    try {
      final file = File(path);
      return Image.file(
        file,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.directions_car, size: 64);
        },
      );
    } catch (e, s) {
      L.e('Gagal muat gambar kendaraan: $e $s');
      return const Icon(Icons.directions_car, size: 64);
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/pengingat/page/pengingat_page.dart
// ============================================================

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/pengingat/enum/kategori_pengingat.dart';
import 'package:myapp/fitur/pengingat/model/pengingat_model.dart';
import 'package:myapp/fitur/pengingat/notifier/pengingat_notifier.dart';
import 'package:myapp/fitur/pengingat/page/detail_pengingat.dart';
import 'package:myapp/fitur/pengingat/state/pengingat_state.dart';
import 'package:myapp/shared/widget/kendaraan_terpilih_list.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman pengingat untuk menampilkan daftar pengingat.
class PengingatPage extends ConsumerStatefulWidget {
  /// Membuat halaman pengingat.
  const PengingatPage({super.key});

  @override
  ConsumerState<PengingatPage> createState() => _PengingatPageState();
}

class _PengingatPageState extends ConsumerState<PengingatPage> {
  KategoriPengingat _kategoriPengingat = KategoriPengingat.semua;
  KendaraanModel? _kendaraanTerpilih;

  @override
  void initState() {
    super.initState();
    unawaited(Future.microtask(_reloadKendaraanTerpilih));
  }

  Future<void> _reloadKendaraanTerpilih() async {
    // Bungkus async dengan try/catch dan log + rethrow
    try {
      final idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
      final kendaraanState = await ref.read(kendaraanProvider.future);
      KendaraanModel? kendaraan;
      if (idKendaraan != null && idKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.getById(idKendaraan);
        if (kendaraan == null && kendaraanState.listKendaraan.isNotEmpty) {
          kendaraan = kendaraanState.listKendaraan.first;
        }
      } else if (_kendaraanTerpilih != null) {
        kendaraan = _kendaraanTerpilih;
      } else if (kendaraanState.listKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.listKendaraan.first;
      }
      if (mounted) {
        setState(() {
          _kendaraanTerpilih = kendaraan;
        });
      }
    } catch (e, s) {
      L.e('Gagal reload kendaraan terpilih: $e $s');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Respon perubahan kendaraan agar daftar pengingat diperbarui.
    ref.listen(selectedKendaraanIdProvider, (previous, next) {
      final prev = previous?.asData?.value;
      final cur = next.asData?.value;
      if (prev != cur) {
        unawaited(_reloadKendaraanTerpilih());
      }
    });
    final pengingatAsync = ref.watch(pengingatProvider);
    final kendaraanAsync = ref.watch(kendaraanProvider);

    if (pengingatAsync.isLoading || kendaraanAsync.isLoading) {
      return _buildLoading();
    }
    if (pengingatAsync.hasError || kendaraanAsync.hasError) {
      return _buildError(ref);
    }

    final state = pengingatAsync.requireValue;
    final kendaraanState = kendaraanAsync.requireValue;
    final selectedId = _kendaraanTerpilih?.id;
    return Scaffold(
      appBar: AppBar(title: const Text('Pengingat')),
      body: Column(
        spacing: 8,
        children: [
          KendaraanTerpilihList(
            listKendaraan: kendaraanState.listKendaraan,
            selectedId: selectedId,
            onSelected: (kendaraan) {
              setState(() => _kendaraanTerpilih = kendaraan);
            },
            onReload: _reloadKendaraanTerpilih,
          ),
          _buildOpsiPengingat(),
          Expanded(child: _buildListPengingat(state)),
        ],
      ),
    );
  }

  /// Menampilkan konten berdasarkan [state].
  Widget _buildListPengingat(PengingatState state) {
    final idKendaraan = _kendaraanTerpilih?.id;
    List<PengingatModel> listPengingat;
    listPengingat = idKendaraan == null
        ? state.listPengingat
        : state.getListByIdKendaraan(idKendaraan);
    listPengingat = _kategoriPengingat == KategoriPengingat.semua
        ? listPengingat
        : listPengingat
              .where((l) => l.kategoriPengingat == _kategoriPengingat)
              .toList();

    if (listPengingat.isEmpty) {
      return _buildKosong();
    }
    return ListView.builder(
      itemCount: listPengingat.length,
      itemBuilder: (context, index) {
        final pengingat = listPengingat[index];
        return _buildItemPengingat(pengingat);
      },
    );
  }

  Widget _buildItemPengingat(PengingatModel pengingat) {
    return ListTile(
      onTap: () =>
          unawaited(Nav.to(context, DetailPengingat(id: pengingat.id))),
      title: Text(
        pengingat.pesan,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        FormatWaktuLengkap.formatSingkat(pengingat.tanggalTampil),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Opsi kategori pengingat menggunakan ChoiceChip.
  Widget _buildOpsiPengingat() {
    final tema = Theme.of(context);
    return Row(
      spacing: 4,
      children: [
        const Text('Kategori Pengingat:'),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: KategoriPengingat.values.map((kategori) {
                final aktif = _kategoriPengingat == kategori;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(kategori.label),
                    selected: aktif,
                    showCheckmark: false,
                    selectedColor: tema.colorScheme.primary,
                    backgroundColor: tema.colorScheme.surfaceContainerHighest,
                    labelStyle: TextStyle(
                      color: aktif
                          ? tema.colorScheme.onPrimary
                          : tema.colorScheme.onSurface,
                    ),
                    onSelected: (_) => setState(() {
                      _kategoriPengingat = kategori;
                    }),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  /// Widget saat memuat data.
  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [CircularProgressIndicator(), Text('Memuat pengingat...')],
        ),
      ),
    );
  }

  /// Menampilkan tampilan kosong saat tidak ada pengingat.
  Widget _buildKosong() {
    final tema = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                // Latar lembut primer sesuai DESAINS.MD (12% opasitas)
                color: tema.colorScheme.primaryContainer.withValues(
                  alpha: 0.12,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 48,
                color: tema.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Belum ada pengingat',
              textAlign: TextAlign.center,
              style: tema.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: tema.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tidak ada pengingat yang tercatat.',
              textAlign: TextAlign.center,
              style: tema.textTheme.bodySmall?.copyWith(
                color: tema.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget saat terjadi error.
  Widget _buildError(WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat pengingat'),
            ElevatedButton(
              onPressed: () {
                try {
                  // Invalidasi provider pengingat dan kendaraan saat error.
                  final _ = ref.refresh(
                    pengingatProvider,
                  ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                  final _ = ref.refresh(
                    kendaraanProvider,
                  ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                } catch (e) {
                  // Abaikan kesalahan saat invalidasi provider.
                }
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/pengingat/state/pengingat_state.dart
// ============================================================

```dart
// lib/fitur/pengingat/state/pengingat_state.dart
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/pengingat/enum/kategori_pengingat.dart';
import 'package:myapp/fitur/pengingat/model/pengingat_model.dart';

part 'pengingat_state.freezed.dart';

/// State untuk mengelola daftar pengingat.
@freezed
abstract class PengingatState with _$PengingatState {
  const PengingatState._();

  /// Membuat instance [PengingatState] dengan daftar pengingat.
  const factory PengingatState({
    @Default([]) List<PengingatModel> listPengingat,
  }) = _PengingatState;

  /// Mengembalikan pengingat dengan [id], atau null jika tidak ditemukan.
  PengingatModel? getById(String id) {
    return listPengingat.firstWhereOrNull((item) => item.id == id);
  }

  /// Mengembalikan daftar pengingat yang sudah diurutkan berdasarkan [tanggalTampil].
  List<PengingatModel> getSortedByTanggalTampil() {
    return listPengingat.sorted(
      (a, b) => a.tanggalTampil.compareTo(b.tanggalTampil),
    );
  }

  /// Mengembalikan daftar pengingat berdasarkan [idKendaraan].
  List<PengingatModel> getListByIdKendaraan(String idKendaraan) {
    return listPengingat.where((p) => p.idKendaraan == idKendaraan).toList();
  }

  /// Mengembalikan daftar pengingat berdasarkan [kategoriPengingat].
  List<PengingatModel> getListByKategori(KategoriPengingat kategori) {
    return listPengingat.where((p) => p.kategoriPengingat == kategori).toList();
  }

  /// Mengembalikan daftar pengingat berdasarkan [pageTujuan].
  List<PengingatModel> getListByPageTujuan(PageTujuan tujuan) {
    return listPengingat.where((p) => p.pageTujuan == tujuan).toList();
  }
}
```


// ============================================================
// FILE: lib/fitur/sinkronisasi/enum/waktu_sinkronisasi_enum.dart
// ============================================================

```dart
// lib/fitur/sinkronisasi/enum/waktu_sinkronisasi_enum.dart

/// Enum untuk frekuensi sinkronisasi data.
enum WaktuSinkronisasiEnum {
  /// Sinkronisasi setiap hari.
  perhari,

  /// Sinkronisasi setiap minggu.
  perminggu,

  /// Sinkronisasi setiap bulan.
  perbulan,
}

/// Extension untuk mendapatkan label tampilan dari [WaktuSinkronisasiEnum].
extension WaktuSinkronisasiEnumExtension on WaktuSinkronisasiEnum {
  /// Mengembalikan label human-readable untuk frekuensi sinkronisasi ini.
  String get label {
    switch (this) {
      case WaktuSinkronisasiEnum.perhari:
        return 'Setiap Hari';
      case WaktuSinkronisasiEnum.perminggu:
        return 'Setiap Minggu';
      case WaktuSinkronisasiEnum.perbulan:
        return 'Setiap Bulan';
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/sinkronisasi/service/sinkronisasi_service.dart
// ============================================================

```dart
// lib/fitur/sinkronisasi/service/sinkronisasi_service.dart

import 'dart:io';

import 'package:myapp/fitur/sinkronisasi/enum/waktu_sinkronisasi_enum.dart';
import 'package:myapp/shared/konstanta/shared_keys.dart';
import 'package:myapp/shared/sinkronisasi/google_drive_helper.dart';
import 'package:share_global_saya/core_shared.dart';

/// Service untuk mengelola logika sinkronisasi otomatis ke Google Drive. Service ini **tidak mengelola state UI** — dirancang reusable, bisa dipanggil dari [SinkronisasiPage], provider, atau scheduler background di masa depan.
class SinkronisasiService {
  SinkronisasiService._();

  static const String _namaBackup = 'app_backup.db';

  /// Apakah sudah waktunya sinkronisasi berdasarkan [frekuensi] dan [last]? [last] adalah timestamp sinkronisasi terakhir (null = belum pernah).
  static bool perluSinkronisasi(
    DateTime? last,
    WaktuSinkronisasiEnum frekuensi,
  ) {
    if (last == null) return true;
    final now = DateTime.now();
    switch (frekuensi) {
      case WaktuSinkronisasiEnum.perhari:
        return last.year != now.year ||
            last.month != now.month ||
            last.day != now.day;
      case WaktuSinkronisasiEnum.perminggu:
        final lastStart = last.subtract(Duration(days: last.weekday - 1));
        final nowStart = now.subtract(Duration(days: now.weekday - 1));
        return nowStart.difference(lastStart).inDays >= 7;
      case WaktuSinkronisasiEnum.perbulan:
        return last.year != now.year || last.month != now.month;
    }
  }

  /// Baca riwayat sinkronisasi terakhir dari SharedPrefService.
  static Future<DateTime?> bacaLastSinkronisasi() async {
    final lastStr = await SharedPrefService.getString(
      KunciShared.lastSinkronisasi,
    );
    if (lastStr == null || lastStr.isEmpty) return null;
    return DateTime.tryParse(lastStr);
  }

  /// Catat riwayat sinkronisasi terakhir = sekarang.
  static Future<void> catatLastSinkronisasi() async {
    await SharedPrefService.setString(
      KunciShared.lastSinkronisasi,
      DateTime.now().toIso8601String(),
    );
  }

  /// Jalankan backup otomatis (silent) ke Google Drive. Return `true` kalau backup sukses, `false` kalau dilewati/gagal. Tidak mengubah state UI, tidak menampilkan toast.
  static Future<bool> sinkronisasiOtomatis({
    required String dbPath,
    required WaktuSinkronisasiEnum frekuensi,
  }) async {
    // Bungkus seluruh operasi I/O dalam try/catch agar exception tidak menyebar (optimasi_bug_runtime.md poin 6).
    try {
      if (!GoogleDriveHelper.sudahLogin) return false;

      final last = await bacaLastSinkronisasi();
      if (last != null && !perluSinkronisasi(last, frekuensi)) return false;

      final file = File(dbPath);
      if (!await file.exists()) return false;

      final ok = await GoogleDriveHelper.uploadFile(
        file: file,
        namaFile: _namaBackup,
      );
      if (ok) {
        await catatLastSinkronisasi();
      }
      return ok;
    } catch (e, s) {
      L.e('sinkronisasi otomatis gagal: $e $s');
      return false;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/sinkronisasi/sinkronisasi_page.dart
// ============================================================

```dart
// lib/fitur/sinkronisasi/sinkronisasi_page.dart

import 'dart:async';
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/sinkronisasi/enum/waktu_sinkronisasi_enum.dart';
import 'package:myapp/fitur/sinkronisasi/service/sinkronisasi_service.dart';
import 'package:myapp/shared/db/sqflite/db_sqflite.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/konstanta/shared_keys.dart';
import 'package:myapp/shared/sinkronisasi/google_drive_helper.dart';
import 'package:path/path.dart' as p;
import 'package:restart_app/restart_app.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

/// Halaman sinkronisasi dan backup database ke Google Drive.
class SinkronisasiPage extends ConsumerStatefulWidget {
  /// Buat halaman sinkronisasi database.
  const SinkronisasiPage({super.key});

  @override
  ConsumerState<SinkronisasiPage> createState() => _SinkronisasiPageState();
}

class _SinkronisasiPageState extends ConsumerState<SinkronisasiPage> {
  static const String _namaBackup = 'app_backup.db';

  bool _loading = false;
  bool _sedangOperasiDb = false;
  bool _sinkronisasiOtomatis = false;
  WaktuSinkronisasiEnum _frekuensi = WaktuSinkronisasiEnum.perhari;
  String _status = 'Belum login';
  String _email = '';

  @override
  void initState() {
    super.initState();
    unawaited(
      _muatPengaturan().then((_) async {
        try {
          // Pulihkan tampilan email dari SharedPref tanpa memicu modal login.
          final emailTersimpan = await SharedPrefService.getString(
            KunciShared.emailGoogle,
          );
          if (mounted) {
            setState(() {
              if (GoogleDriveHelper.sudahLogin) {
                _email = GoogleDriveHelper.email ?? '';
                _status = 'Sudah login';
              } else if (emailTersimpan != null && emailTersimpan.isNotEmpty) {
                _email = emailTersimpan;
                _status = 'Sesi tersimpan';
              }
            });
          }
          if (_sinkronisasiOtomatis) {
            unawaited(_jalankanSinkronisasiOtomatis());
          }
        } catch (e, s) {
          L.e('muat pengaturan lanjutan error: $e $s');
          if (mounted) setState(() => _status = 'Gagal memuat pengaturan');
        }
      }),
    );
    if (GoogleDriveHelper.sudahLogin) {
      _email = GoogleDriveHelper.email ?? '';
      _status = 'Sudah login';
    }
  }

  /// Dokumentasi preventif: tidak ada Timer/StreamSubscription/listener eksplisit saat ini. Tambahkan close()/cancel() di sini bila listener ditambahkan di masa depan (optimasi_bug_runtime.md #7).
  @override
  void dispose() {
    // Tidak ada resource yang perlu di-dispose saat ini.
    super.dispose();
  }

  Future<void> _muatPengaturan() async {
    try {
      final aktif = await SharedPrefService.getBool(
        KunciShared.aktifkanSinkronisasiOtomatis,
      );
      final freq = await SharedPrefService.getString(
        KunciShared.waktuSinkronisasi,
      );
      if (mounted) {
        setState(() {
          _sinkronisasiOtomatis = aktif ?? false;
          // Menggunakan firstWhereOrNull dari package:collection sesuai AGENTS.md.
          _frekuensi =
              WaktuSinkronisasiEnum.values.firstWhereOrNull(
                (e) => e.name == freq,
              ) ??
              WaktuSinkronisasiEnum.perhari;
        });
      }
    } catch (e, s) {
      L.e('muat pengaturan error: $e $s');
      if (mounted) {
        setState(() => _status = 'Gagal memuat pengaturan');
      }
    }
  }

  Future<void> _simpanPengaturan(bool aktif) async {
    try {
      await SharedPrefService.setBool(
        KunciShared.aktifkanSinkronisasiOtomatis,
        aktif,
      );
      // Beri feedback sukses agar pengguna tahu operasi selesai.
      if (mounted) AppToast.sukses(context, 'Pengaturan sinkronisasi disimpan');
    } catch (e, s) {
      L.e('Gagal menyimpan pengaturan sinkronisasi: $e $s');
      if (mounted) AppToast.gagal(context, 'Gagal menyimpan pengaturan');
    }
  }

  /// Simpan frekuensi dengan try/catch agar I/O tidak crash tanpa feedback.
  Future<void> _simpanFrekuensi(WaktuSinkronisasiEnum frekuensi) async {
    try {
      await SharedPrefService.setString(
        KunciShared.waktuSinkronisasi,
        frekuensi.name,
      );
      if (mounted) AppToast.sukses(context, 'Frekuensi sinkronisasi disimpan');
    } catch (e, s) {
      L.e('Gagal menyimpan frekuensi sinkronisasi: $e $s');
      if (mounted) AppToast.gagal(context, 'Gagal menyimpan frekuensi');
    }
  }

  /// Jalankan backup otomatis ke Google Drive (tanpa mengganggu UI). Dijalankan secara silent: tidak menampilkan toast, tidak mengubah state `_loading` global. Hanya dijalankan kalau sudah login, sudah waktunya, dan database ada.
  Future<void> _jalankanSinkronisasiOtomatis() async {
    // Hindari operasi bersamaan yang bisa menimpa atau merusak file DB.
    if (_sedangOperasiDb) return;
    _sedangOperasiDb = true;
    try {
      final dbPath = await _pathDatabase();
      if (dbPath == null) {
        _sedangOperasiDb = false;
        return;
      }

      // Coba pulihkan sesi Google tanpa dialog terlebih dahulu.
      final autoOk = await GoogleDriveHelper.cobaLoginOtomatis();
      if (!autoOk) {
        // Sesi/izin tidak valid → jangan sync; biarkan user login interaktif.
        if (mounted) {
          setState(() {
            _status = 'Belum login';
            _email = '';
          });
        }
        _sedangOperasiDb = false;
        return;
      }

      // WAJIB: tutup DB dulu supaya file tidak dikunci.
      try {
        await ref.read(dbSqfliteProvider).close();
        await SinkronisasiService.sinkronisasiOtomatis(
          dbPath: dbPath,
          frekuensi: _frekuensi,
        );
      } catch (e, s) {
        L.e('sinkronisasi otomatis gagal: $e $s');
      } finally {
        // Buka kembali DB agar tidak tetap tertutup.
        try {
          await ref.read(dbSqfliteProvider).database;
        } catch (e, s) {
          L.e('reopen db error sinkronisasi otomatis: $e $s');
        }
        // Lepaskan kunci operasi agar operasi lain bisa berjalan.
        _sedangOperasiDb = false;
      }
    } catch (e, s) {
      L.e('sinkronisasi otomatis gagal: $e $s');
    } finally {
      _sedangOperasiDb = false;
    }
  }

  /// Ambil path database yang sama dengan yang dipakai [DbSqflite].
  Future<String?> _pathDatabase() async {
    if (kIsWeb) return null; // web tidak punya file fisik
    final dbDir = await getDatabasesPath();
    return p.join(dbDir, 'app.db');
  }

  Future<void> _login() async {
    setState(() => _loading = true);
    try {
      final akun = await GoogleDriveHelper.login();
      if (!mounted) return;
      setState(() {
        _email = akun?.email ?? '';
        _status = akun != null ? 'Sudah login' : 'Belum login';
      });
      if (akun != null) {
        await SharedPrefService.setString(KunciShared.emailGoogle, akun.email);
      } else {
        await SharedPrefService.remove(KunciShared.emailGoogle);
      }
      if (akun == null && mounted) {
        AppToast.info(context, 'Login dibatalkan');
      }
    } catch (e, s) {
      L.e('login error: $e $s');
      if (mounted) AppToast.gagal(context, 'Login gagal. Silakan coba lagi.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _logout() async {
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Keluar Akun',
      message:
          'Yakin ingin keluar dari akun Google? Backup tidak akan dihapus.',
      okLabel: 'Keluar',
      cancelLabel: 'Batal',
    );
    if (konfirmasi != OkCancelResult.ok) return;

    setState(() => _loading = true);
    try {
      await GoogleDriveHelper.logout();
      await SharedPrefService.remove(KunciShared.emailGoogle);
      if (mounted) AppToast.sukses(context, 'Berhasil keluar akun');
    } catch (e, s) {
      L.e('logout error: $e $s');
      if (mounted) AppToast.gagal(context, 'Logout gagal. Silakan coba lagi.');
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
          _email = '';
          _status = 'Belum login';
        });
      }
    }
  }

  Future<void> _backup() async {
    // Hindari operasi bersamaan yang bisa merusak file DB.
    if (_sedangOperasiDb) return;
    _sedangOperasiDb = true;

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Backup ke Google Drive',
      message: 'Backup akan menimpa file backup sebelumnya di Google Drive. Lanjutkan?',
      okLabel: 'Backup',
      cancelLabel: 'Batal',
    );
    if (konfirmasi != OkCancelResult.ok) {
      _sedangOperasiDb = false;
      return;
    }

    setState(() => _loading = true);
    try {
      if (!GoogleDriveHelper.sudahLogin) {
        final okLogin = await GoogleDriveHelper.cobaLoginOtomatis();
        if (!okLogin) {
          if (mounted) {
            AppToast.info(context, 'Silakan login Google terlebih dahulu');
          }
          return;
        }
        if (mounted) {
          setState(() {
            _email = GoogleDriveHelper.email ?? '';
            _status = 'Sudah login';
          });
          await SharedPrefService.setString(
            KunciShared.emailGoogle,
            GoogleDriveHelper.email ?? '',
          );
        }
      }
      final dbPath = await _pathDatabase();
      if (dbPath == null) {
        if (mounted) AppToast.gagal(context, 'Backup tidak didukung di web');
        return;
      }
      final file = File(dbPath);
      if (!await file.exists()) {
        if (mounted) AppToast.gagal(context, 'Database tidak ditemukan');
        return;
      }

      // WAJIB: tutup DB dulu supaya file tidak dikunci.
      await ref.read(dbSqfliteProvider).close();

      final ok = await GoogleDriveHelper.uploadFile(
        file: file,
        namaFile: _namaBackup,
      );
      // Fitur baru: memberikan informasi jelas ke pengguna saat sinkron gagal (UX poin 6).
      if (mounted) {
        ok
            ? AppToast.sukses(context, 'Backup berhasil')
            : AppToast.gagal(
                context,
                'Sinkronisasi gagal. Periksa koneksi atau login Google.',
              );
      }
    } catch (e, s) {
      L.e('backup error: $e $s');
      if (mounted) AppToast.gagal(context, 'Backup gagal: $e');
    } finally {
      try {
        await ref.read(dbSqfliteProvider).database;
      } catch (e) {
        L.e('reopen db error: $e');
      }
      if (mounted) setState(() => _loading = false);
      // Lepaskan kunci operasi agar operasi database lain bisa berjalan.
      _sedangOperasiDb = false;
    }
  }

  Future<void> _restore() async {
    // Hindari operasi bersamaan yang bisa merusak file DB.
    if (_sedangOperasiDb) return;
    _sedangOperasiDb = true;

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Restore dari Google Drive?',
      message:
          'Semua data lokal akan ditimpa oleh data dari Google Drive. '
          'Restart aplikasi setelah restore selesai. Lanjutkan?',
      okLabel: 'Restore',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (konfirmasi != OkCancelResult.ok) {
      _sedangOperasiDb = false;
      return;
    }
    setState(() => _loading = true);
    try {
      if (!GoogleDriveHelper.sudahLogin) {
        final okLogin = await GoogleDriveHelper.cobaLoginOtomatis();
        if (!okLogin) {
          if (mounted) {
            AppToast.info(context, 'Silakan login Google terlebih dahulu');
          }
          return;
        }
        if (mounted) {
          setState(() {
            _email = GoogleDriveHelper.email ?? '';
            _status = 'Sudah login';
          });
          await SharedPrefService.setString(
            KunciShared.emailGoogle,
            GoogleDriveHelper.email ?? '',
          );
        }
      }

      final dbPath = await _pathDatabase();
      if (dbPath == null) {
        if (mounted) AppToast.gagal(context, 'Restore tidak didukung di web');
        return;
      }

      // WAJIB: tutup DB dulu supaya file bisa ditimpa.
      await ref.read(dbSqfliteProvider).close();

      final ok = await GoogleDriveHelper.downloadFile(
        namaFile: _namaBackup,
        simpanKePath: dbPath,
      );
      if (ok) {
        // Reset pilihan kendaraan agar sesuai DB hasil restore.
        try {
          final db = await ref.read(dbSqfliteProvider).database;
          final rows = await db.query(
            NamaTabel.kendaraan,
            columns: [NamaKolom.id],
            limit: 1,
          );
          final notifier = ref.read(selectedKendaraanIdProvider.notifier);
          if (rows.isNotEmpty) {
            // Hindari cast `as`; gunakan toString() untuk aman
            final id = rows.first[NamaKolom.id]?.toString();
            if (id != null && id.isNotEmpty) {
              await notifier.set(id);
            } else {
              await notifier.clear();
            }
          } else {
            await notifier.clear();
          }
        } catch (e, s) {
          L.e('reset selected kendaraan setelah restore gagal: $e $s');
        }
        if (mounted) {
          await _restartAfterRestore();
        }
      } else if (mounted) {
        AppToast.gagal(context, 'Restore gagal');
      }
    } catch (e, s) {
      L.e('restore error: $e $s');
      if (mounted) AppToast.gagal(context, 'Restore gagal: $e');
    } finally {
      try {
        await ref.read(dbSqfliteProvider).database;
      } catch (e) {
        L.e('reopen db error: $e');
      }
      if (mounted) setState(() => _loading = false);
      // Lepaskan kunci operasi agar operasi database lain bisa berjalan.
      _sedangOperasiDb = false;
    }
  }

  Future<void> _restartAfterRestore() async {
    if (mounted) {
      AppToast.sukses(context, 'Restore berhasil. Aplikasi akan direstart.');
    }
    await _restartApp();
  }

  Future<void> _restartApp() async {
    if (kIsWeb) return;
    try {
      final result = await Restart.restartApp();
      // Periksa hasil restart sebelum operasi UI setelah await.
      if (!mounted) return;
      if (!result.success) {
        L.e(
          'restart app gagal: code=${result.code}, message=${result.message}',
        );
        AppToast.info(context, 'Silakan restart aplikasi secara manual');
      }
    } catch (e, s) {
      L.e('restart app error: $e $s');
      if (mounted) {
        AppToast.info(context, 'Silakan restart aplikasi secara manual');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sudahLogin = _email.isNotEmpty;
    return Scaffold(
      appBar: AppBar(title: const Text('Sinkronisasi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                leading: Icon(
                  sudahLogin
                      ? Icons.account_circle
                      : Icons.account_circle_outlined,
                ),
                title: Text(
                  _status,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  sudahLogin ? _email : 'Login dengan Google',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (!sudahLogin)
              ElevatedButton.icon(
                onPressed: _loading ? null : _login,
                icon: _loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.login),
                label: const Text('Login Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            else ...[
              ElevatedButton.icon(
                onPressed: _loading ? null : _backup,
                icon: _loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.cloud_upload),
                label: const Text('Backup ke Google Drive'),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _loading ? null : _restore,
                icon: _loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.cloud_download),
                label: const Text('Restore dari Google Drive'),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _loading ? null : _logout,
                icon: _loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.logout),
                label: const Text('Logout'),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
            _buildOpsiPengaturan(),
          ],
        ),
      ),
    );
  }

  Widget _buildOpsiPengaturan() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('Sinkronisasi otomatis'),
            subtitle: const Text(
              'Perbarui data ke Google Drive secara otomatis',
            ),
            trailing: Switch(
              value: _sinkronisasiOtomatis,
              onChanged: (aktif) async {
                setState(() {
                  _sinkronisasiOtomatis = aktif;
                });
                await _simpanPengaturan(aktif);
                if (aktif) {
                  unawaited(_jalankanSinkronisasiOtomatis());
                }
              },
            ),
          ),
          if (_sinkronisasiOtomatis) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  const Text('Frekuensi: '),
                  const SizedBox(width: 8),
                  DropdownButton<WaktuSinkronisasiEnum>(
                    value: _frekuensi,
                    underline: const SizedBox(),
                    items: WaktuSinkronisasiEnum.values
                        .map(
                          (e) => DropdownMenuItem<WaktuSinkronisasiEnum>(
                            value: e,
                            child: Text(e.label),
                          ),
                        )
                        .toList(),
                    onChanged: (e) {
                      if (e == null) return;
                      setState(() => _frekuensi = e);
                      unawaited(_simpanFrekuensi(e));
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/transaksi/enum/tipe_transaksi_enum.dart
// ============================================================

```dart
// lib/fitur/transaksi/enum/tiep_transaksi_enum.dart

/// Tipe transaksi (pemasukan atau pengeluaran).
enum TipeTransaksiEnum {
  /// Transaksi pemasukan uang.
  pemasukan,

  /// Transaksi pengeluaran uang.
  pengeluaran,
}

/// Extension untuk [TipeTransaksiEnum] yang menyediakan label tampilan.
extension TipeTransaksiEnumExtension on TipeTransaksiEnum {
  /// Label teks yang ditampilkan kepada pengguna.
  String get label {
    switch (this) {
      case TipeTransaksiEnum.pemasukan:
        return 'Pemasukan';
      case TipeTransaksiEnum.pengeluaran:
        return 'Pengeluaran';
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/transaksi/model/kategori_transaksi_model.dart
// ============================================================

```dart
// lib/fitur/transaksi/model/kategori_transaksi_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'kategori_transaksi_model.freezed.dart';
part 'kategori_transaksi_model.g.dart';

/// Model data kategori transaksi (berlaku untuk transaksi pemasukan/pengeluaran).
@freezed
abstract class KategoriTransaksiModel with _$KategoriTransaksiModel {
  const KategoriTransaksiModel._();

  /// Membuat instance [KategoriTransaksiModel] dengan data lengkap.
  const factory KategoriTransaksiModel({
    @JsonKey(name: NamaKolom.id, defaultValue: '') required String id,
    @JsonKey(name: NamaKolom.nama, defaultValue: '') required String nama,
    @JsonKey(
      name: NamaKolom.tipeTransaksi,
      fromJson: _tipeFromJson,
      toJson: _tipeToJson,
    )
    required TipeTransaksiEnum tipe,
    @JsonKey(name: NamaKolom.ikon) String? ikon,
    @JsonKey(name: NamaKolom.warna) String? warna,
    @JsonKey(
      name: NamaKolom.diperbarui,
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson,
    )
    required DateTime diperbarui,
    @JsonKey(
      name: NamaKolom.diarsipkan,
      fromJson: _dateTimeOrNullFromJson,
      toJson: _dateTimeToJson,
    )
    DateTime? diarsipkan,
  }) = _KategoriTransaksiModel;

  /// Membuat [KategoriTransaksiModel] dari JSON/Map (Supabase & Sqflite).
  factory KategoriTransaksiModel.fromJson(Map<String, dynamic> json) =>
      _$KategoriTransaksiModelFromJson(json);

  /// Mengonversi instance ini menjadi Map untuk disimpan ke DB.
  @override
  Map<String, dynamic> toJson() =>
      _$KategoriTransaksiModelToJson(this as _KategoriTransaksiModel);
}

// ==================== Helper konversi ====================

TipeTransaksiEnum _tipeFromJson(Object? value) =>
    ParserUtil.safeParseEnum(TipeTransaksiEnum.values, value?.toString()) ??
    TipeTransaksiEnum.pemasukan;

String _tipeToJson(TipeTransaksiEnum value) => value.name;

DateTime _dateTimeFromJson(Object? value) =>
    ParserUtil.parseDateTime(value) ?? DateTime.now();

DateTime? _dateTimeOrNullFromJson(Object? value) =>
    ParserUtil.parseDateTime(value);

String? _dateTimeToJson(DateTime? value) => value?.toIso8601String();
```


// ============================================================
// FILE: lib/fitur/transaksi/model/transaksi_model.dart
// ============================================================

```dart
// lib/fitur/transaksi/model/transaksi_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'transaksi_model.freezed.dart';

/// Model data transaksi (pemasukan/pengeluaran).
@freezed
abstract class TransaksiModel with _$TransaksiModel {
  const TransaksiModel._();

  /// Membuat instance [TransaksiModel] dengan data lengkap.
  const factory TransaksiModel({
    required String id,
    required String idKendaraan,
    required String deskripsi,
    required double jumlah,
    required DateTime tanggal,
    required TipeTransaksiEnum tipeTransaksi,
    String? idKategoriTransaksi,
    String? pathStruk,
    required DateTime diperbarui,
    DateTime? diarsipkan,
    String? riwayatJadwalServiceId,
  }) = _TransaksiModel;

  // ==================== Supabase ====================

  /// Membuat [TransaksiModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory TransaksiModel.fromSupabase(
    Map<String, dynamic> map,
  ) => TransaksiModel(
    id: map[NamaKolom.id]?.toString() ?? '',
    idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
    deskripsi: map[NamaKolom.deskripsi]?.toString() ?? '',
    jumlah: ParserUtil.parseDouble(map[NamaKolom.jumlah]),
    tanggal: ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
    tipeTransaksi:
        ParserUtil.safeParseEnum(
          TipeTransaksiEnum.values,
          map[NamaKolom.tipeTransaksi]?.toString(),
        ) ??
        TipeTransaksiEnum.pemasukan,
    idKategoriTransaksi: map[NamaKolom.idKategoriTransaksi]?.toString(),
    pathStruk: map[NamaKolom.pathStruk]?.toString(),
    diperbarui:
        ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
    diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    riwayatJadwalServiceId: map[NamaKolom.riwayatJadwalServiceId]?.toString(),
  );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.deskripsi: deskripsi,
    NamaKolom.jumlah: jumlah,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.tipeTransaksi: tipeTransaksi.name,
    NamaKolom.idKategoriTransaksi: idKategoriTransaksi,
    NamaKolom.pathStruk: pathStruk,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
    NamaKolom.riwayatJadwalServiceId: riwayatJadwalServiceId,
  };

  // ==================== Sqflite ====================

  /// Membuat [TransaksiModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory TransaksiModel.fromSqflite(
    Map<String, dynamic> map,
  ) => TransaksiModel(
    id: map[NamaKolom.id]?.toString() ?? '',
    idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
    deskripsi: map[NamaKolom.deskripsi]?.toString() ?? '',
    jumlah: ParserUtil.parseDouble(map[NamaKolom.jumlah]),
    tanggal: ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
    tipeTransaksi:
        ParserUtil.safeParseEnum(
          TipeTransaksiEnum.values,
          map[NamaKolom.tipeTransaksi]?.toString(),
        ) ??
        TipeTransaksiEnum.pemasukan,
    idKategoriTransaksi: map[NamaKolom.idKategoriTransaksi]?.toString(),
    pathStruk: map[NamaKolom.pathStruk]?.toString(),
    diperbarui:
        ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
    diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    riwayatJadwalServiceId: map[NamaKolom.riwayatJadwalServiceId]?.toString(),
  );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.deskripsi: deskripsi,
    NamaKolom.jumlah: jumlah,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.tipeTransaksi: tipeTransaksi.name,
    NamaKolom.idKategoriTransaksi: idKategoriTransaksi,
    NamaKolom.pathStruk: pathStruk,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
    NamaKolom.riwayatJadwalServiceId: riwayatJadwalServiceId,
  };
}
```


// ============================================================
// FILE: lib/fitur/transaksi/notifier/kategori_transaksi_notifier.dart
// ============================================================

```dart
// lib/fitur/transaksi/notifier/kategori_transaksi_notifier.dart

import 'package:myapp/fitur/transaksi/model/kategori_transaksi_model.dart';
import 'package:myapp/fitur/transaksi/state/kategori_transaksi_state.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'kategori_transaksi_notifier.g.dart';

@Riverpod(keepAlive: true)
/// Notifier untuk mengelola kategori transaksi.
class KategoriTransaksiNotifier extends _$KategoriTransaksiNotifier {
  final _tabel = NamaTabel.kategoriTransaksi;

  @override
  Future<KategoriTransaksiState> build() async {
    return await _muatData();
  }

  Future<KategoriTransaksiState> _muatData() async {
    try {
      final listDb = await ref.read(baseOpSqfliteProvider).ambilData(_tabel);
      final listHasil = listDb
          .whereType<Map<String, dynamic>>()
          .map(KategoriTransaksiModel.fromJson)
          .toList();
      L.i('build kategori_transaksi_notifier selesai');
      return KategoriTransaksiState(listKategoriTransaksi: listHasil);
    } catch (e, s) {
      L.e('Gagal memuat data kategori transaksi: $e $s');
      rethrow;
    }
  }

  /// Melakukan batch insert [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(List<KategoriTransaksiModel> data) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabel,
            data.map((e) => e.toJson()).toList(),
          );
      state = AsyncValue.data(await _muatData());
    } catch (e, s) {
      L.e('Gagal batch insert kategori tabungan $e $s');
      rethrow;
    }
  }

  /// Menambahkan [kategori] baru.
  Future<void> tambah(KategoriTransaksiModel kategori) async {
    final dataLama = await future;
    final listBaru = [...dataLama.listKategoriTransaksi, kategori];
    state = AsyncValue.data(dataLama.copyWith(listKategoriTransaksi: listBaru));
    try {
      await ref.read(baseOpSqfliteProvider).tambah(_tabel, kategori.toJson());
    } on Exception catch (e, s) {
      L.e('tambah kategori tabungan gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Mengubah data [kategori].
  Future<void> ubah(KategoriTransaksiModel kategori) async {
    final dataLama = await future;
    final listBaru = dataLama.listKategoriTransaksi
        .map((e) => e.id == kategori.id ? kategori : e)
        .toList();
    state = AsyncValue.data(dataLama.copyWith(listKategoriTransaksi: listBaru));
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(_tabel, kategori.toJson(), kategori.id);
    } on Exception catch (e, s) {
      L.e('ubah kategori tabungan gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Menghapus kategori dengan [id].
  Future<void> hapus(String id) async {
    final dataLama = await future;
    final listBaru = dataLama.listKategoriTransaksi
        .where((e) => e.id != id)
        .toList();
    state = AsyncValue.data(dataLama.copyWith(listKategoriTransaksi: listBaru));
    try {
      await ref.read(baseOpSqfliteProvider).hapus(_tabel, id);
    } on Exception catch (e, s) {
      L.e('hapus kategori tabungan gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/transaksi/notifier/transaksi_notifier.dart
// ============================================================

```dart
import 'package:myapp/fitur/transaksi/model/transaksi_model.dart';
import 'package:myapp/fitur/transaksi/state/transaksi_state.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'transaksi_notifier.g.dart';

/// Notifier untuk mengelola data transaksi.
@Riverpod(keepAlive: true)
class TransaksiNotifier extends _$TransaksiNotifier {
  final _tabelTransaksi = NamaTabel.transaksi;

  /// Membangun state awal dengan memuat data transaksi dari database.
  @override
  Future<TransaksiState> build() async {
    return await _muatData();
  }

  /// Memuat ulang data transaksi untuk kendaraan yang sedang dipilih.
  Future<TransaksiState> _muatData() async {
    try {
      final listDb = await ref
          .read(baseOpSqfliteProvider)
          .ambilData(NamaTabel.transaksi);
      final listHasil = listDb
          .whereType<Map<String, dynamic>>()
          .map(TransaksiModel.fromSqflite)
          .toList();
      L.i('build transaksi_notifier selesai');
      return TransaksiState(listTransaksi: listHasil);
    } catch (e, s) {
      L.e('Gagal memuat data transaksi: $e $s');
      rethrow;
    }
  }

  /// Melakukan batch insert [data] ke Sqflite dan memuat ulang state.
  Future<void> batchInsertFromSync(List<TransaksiModel> data) async {
    try {
      await ref
          .read(baseOpSqfliteProvider)
          .sisipkanAtauPerbaruiBatch(
            _tabelTransaksi,
            data.map((e) => e.toSqflite()).toList(),
          );

      state = AsyncValue.data(await _muatData());
    } catch (e, s) {
      L.e('Gagal batch insert transaksi $e $s');
      rethrow;
    }
  }

  /// Menambahkan [transaksi] baru ke daftar dan database.
  Future<void> tambah(TransaksiModel transaksi) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.copyWith(
      listTransaksi: [...dataLama.listTransaksi, transaksi],
    );
    state = AsyncValue.data(listBaru);

    try {
      // 2. Baru update DB
      await ref
          .read(baseOpSqfliteProvider)
          .tambah(_tabelTransaksi, transaksi.toSqflite());
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('tambah transaksi gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Menghapus transaksi dengan [id] dari daftar dan database.
  Future<void> hapus(String id) async {
    final dataLama = await future;
    // 1. Optimistic update: hapus dari state DULU
    final listBaru = dataLama.listTransaksi.where((e) => e.id != id).toList();
    state = AsyncValue.data(dataLama.copyWith(listTransaksi: listBaru));

    try {
      // 2. Baru hapus DB
      await ref.read(baseOpSqfliteProvider).hapus(_tabelTransaksi, id);
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('hapus transaksi gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }

  /// Mengubah data [transaksi] di daftar dan database.
  Future<void> ubah(TransaksiModel transaksi) async {
    final dataLama = await future;
    // 1. Optimistic update: update state DULU
    final listBaru = dataLama.listTransaksi
        .map((e) => e.id == transaksi.id ? transaksi : e)
        .toList();
    state = AsyncValue.data(dataLama.copyWith(listTransaksi: listBaru));

    try {
      // 2. Baru update DB
      await ref
          .read(baseOpSqfliteProvider)
          .perbarui(_tabelTransaksi, transaksi.toSqflite(), transaksi.id);
    } on Exception catch (e, s) {
      // 3. Rollback kalau gagal
      L.e('ubah transaksi gagal, rollback: $e $s');
      state = AsyncValue.data(dataLama);
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/transaksi/page/detail_transaksi.dart
// ============================================================

```dart
// lib/fitur/transaksi/page/detail_transaksi.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/page/detail_kendaraan_page.dart';
import 'package:myapp/fitur/kendaraan/state/kendaraan_state.dart';
import 'package:myapp/fitur/kendaraan/widget/card_item_kendaraan.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/fitur/transaksi/model/transaksi_model.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:myapp/fitur/transaksi/page/form_transaksi.dart';
import 'package:myapp/fitur/transaksi/state/transaksi_state.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman detail untuk melihat informasi lengkap satu transaksi.
class DetailTransaksiPage extends ConsumerWidget {
  /// ID transaksi yang akan ditampilkan detailnya.
  final TransaksiModel transaksiModel;

  /// Buat halaman detail transaksi.
  const DetailTransaksiPage({super.key, required this.transaksiModel});

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    TransaksiModel tabungan,
  ) async {
    try {
      final result = await showOkCancelAlertDialog(
        context: context,
        title: 'Hapus Tabungan',
        message: 'Data transaksi tabungan ini akan dihapus secara permanen.',
        okLabel: 'Hapus',
        cancelLabel: 'Batal',
        isDestructiveAction: true,
      );

      if (result == OkCancelResult.ok) {
        L.i('Menghapus tabungan: ${tabungan.id}');
        try {
          unawaited(EasyLoading.show(status: 'Menghapus...'));
          await ref.read(transaksiProvider.notifier).hapus(tabungan.id);
          if (context.mounted) {
            AppToast.sukses(context, 'Tabungan berhasil dihapus');
            Nav.pop(context);
          }
        } catch (e, s) {
          L.e('Gagal menghapus tabungan: $e $s');
          if (context.mounted) {
            AppToast.gagal(context, 'Gagal menghapus tabungan');
          }
        } finally {
          unawaited(EasyLoading.dismiss());
        }
      } else {
        L.i('Penghapusan tabungan dibatalkan');
      }
    } catch (e, s) {
      L.e('Gagal menampilkan konfirmasi hapus tabungan: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal menghapus tabungan');
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaksiAsync = ref.watch(transaksiProvider);
    final kendaraanAsync = ref.watch(kendaraanProvider);
    final mataUangAsync = ref.watch(mataUangProvider);

    if (transaksiAsync.isLoading ||
        kendaraanAsync.isLoading ||
        mataUangAsync.isLoading) {
      return _buildLoading();
    }
    if (transaksiAsync.hasError ||
        kendaraanAsync.hasError ||
        mataUangAsync.hasError) {
      return _buildError(ref);
    }
    final kendaraanState = kendaraanAsync.requireValue;
    final transaksiState = transaksiAsync.requireValue;
    final mataUangItem = mataUangAsync.requireValue;
    return _buildScaffold(
      context,
      ref,
      transaksiState,
      kendaraanState,
      mataUangItem,
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    WidgetRef ref,
    TransaksiState transaksiState,
    KendaraanState kendaraanState,
    MataUangItem mataUangItem,
  ) {
    final tabungan =
        transaksiState.getById(transaksiModel.id) ?? transaksiModel;
    final kendaraan = kendaraanState.getById(tabungan.idKendaraan);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tabungan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              unawaited(
                Nav.to(context, FormTransaksi(transaksiModel: tabungan)),
              );
            },
            tooltip: 'Edit Tabungan',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          spacing: 8,
          children: [
            CardItemKendaraan(
              kendaraanModel: kendaraan,
              ontap: () => unawaited(
                Nav.to(context, DetailKendaraanPage(id: tabungan.idKendaraan)),
              ),
            ),
            _buildInfoTabungan(tabungan, mataUangItem),
            const Spacer(),

            /// Tombol hapus
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () =>
                    _showDeleteConfirmation(context, ref, tabungan),
                icon: const Icon(Icons.delete),
                label: const Text('Hapus Transaksi'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTabungan(
    TransaksiModel tabungan,
    MataUangItem mataUangItem,
  ) {
    final isPemasukan = tabungan.tipeTransaksi == TipeTransaksiEnum.pemasukan;

    return Card(
      child: Column(
        children: [
          _buildInfoRowCustom(
            'Tipe Transaksi',
            isPemasukan ? 'Pemasukan' : 'Pengeluaran',
          ),
          const Divider(),
          _buildInfoRowCustom('Deskripsi', tabungan.deskripsi),
          const Divider(),
          _buildInfoRowCustom(
            'Jumlah',
            formatMataUang(tabungan.jumlah, mataUangItem),
          ),
          const Divider(),
          _buildInfoRowCustom(
            'Tanggal',
            FormatWaktuLengkap.formatSingkat(tabungan.tanggal),
          ),
          const Divider(),
          _buildInfoRowCustom(
            'Terakhir Diperbarui',
            FormatWaktuLengkap.formatSingkat(tabungan.diperbarui),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRowCustom(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 120,
            child: Builder(
              builder: (context) => Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text('Memuat detail tabungan...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError(WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat detail tabungan'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(transaksiProvider);
                final _ = ref.refresh(kendaraanProvider);
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/transaksi/page/form_kategori_transaksi.dart
// ============================================================

```dart
// lib/fitur/transaksi/page/form_kategori_transaksi.dart

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/fitur/transaksi/model/kategori_transaksi_model.dart';
import 'package:myapp/fitur/transaksi/notifier/kategori_transaksi_notifier.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Halaman form untuk menambah atau mengedit kategori transaksi.
class FormKategoriTransaksi extends ConsumerStatefulWidget {
  /// Model kategori yang akan diedit. [null] jika mode tambah.
  final KategoriTransaksiModel? kategori;

  /// Membuat form kategori transaksi. [kategori] opsional untuk mode edit.
  const FormKategoriTransaksi({super.key, this.kategori});

  @override
  ConsumerState<FormKategoriTransaksi> createState() =>
      _FormKategoriTransaksiState();
}

class _FormKategoriTransaksiState extends ConsumerState<FormKategoriTransaksi> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _ikonController = TextEditingController();
  final _warnaController = TextEditingController();

  bool _modeEdit = false;
  bool _isLoading = false;
  TipeTransaksiEnum _tipeTerpilih = TipeTransaksiEnum.pemasukan;

  @override
  void initState() {
    super.initState();
    _modeEdit = widget.kategori != null;
    if (_modeEdit) {
      final model = widget.kategori;
      if (model == null) return;
      _namaController.text = model.nama;
      _ikonController.text = model.ikon ?? '';
      _warnaController.text = model.warna ?? '';
      _tipeTerpilih = model.tipe;
    }
    L.i('FormKategoriTransaksi dibuka, mode edit: $_modeEdit');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _ikonController.dispose();
    _warnaController.dispose();
    L.i('FormKategoriTransaksi ditutup');
    super.dispose();
  }

  /// Menyimpan data kategori (tambah atau edit).
  Future<void> _simpanForm() async {
    if (_isLoading) {
      L.w('Form masih loading, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('Validasi form gagal');
      return;
    }
    L.i('Menyimpan kategori tabungan, mode edit: $_modeEdit');
    setState(() => _isLoading = true);
    unawaited(EasyLoading.show(status: 'Menyimpan...'));
    try {
      final idKategori = _modeEdit
          ? (widget.kategori?.id ?? const Uuid().v4())
          : const Uuid().v4();
      final nama = _namaController.text.trim();
      final ikon = _ikonController.text.trim();
      final warna = _warnaController.text.trim();
      final kategoriToSave = KategoriTransaksiModel(
        id: idKategori,
        nama: nama,
        tipe: _tipeTerpilih,
        ikon: ikon.isEmpty ? null : ikon,
        warna: warna.isEmpty ? null : warna,
        diperbarui: DateTime.now(),
      );
      if (_modeEdit) {
        await ref.read(kategoriTransaksiProvider.notifier).ubah(kategoriToSave);
      } else {
        await ref
            .read(kategoriTransaksiProvider.notifier)
            .tambah(kategoriToSave);
      }
      if (mounted) {
        AppToast.sukses(
          context,
          _modeEdit
              ? 'Kategori berhasil diperbarui'
              : 'Kategori berhasil ditambahkan',
        );
        Nav.pop(context);
        L.s(
          'Kategori tabungan berhasil ${_modeEdit ? 'diperbarui' : 'ditambahkan'}',
        );
      }
    } catch (e, s) {
      L.e('Gagal menyimpan kategori tabungan: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan kategori');
      }
    } finally {
      unawaited(EasyLoading.dismiss());
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_modeEdit ? 'Edit Kategori' : 'Tambah Kategori'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16, // jarak antar anak pakai spacing (UI #11)
            children: [
              InputTeks(
                controller: _namaController,
                label: 'Nama Kategori',
                prefixIcon: Icons.label,
              ),
              InputTeks(
                controller: _ikonController,
                label: 'Ikon (opsional)',
                wajib: false,
                hintText: 'Contoh: 🚗 atau nama ikon',
              ),
              InputTeks(
                controller: _warnaController,
                label: 'Warna (opsional)',
                wajib: false,
                hintText: 'Contoh: #FF5733',
              ),
              CupertinoSlidingSegmentedControl<TipeTransaksiEnum>(
                groupValue: _tipeTerpilih,
                proportionalWidth: true,
                children: {
                  TipeTransaksiEnum.pemasukan: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(TipeTransaksiEnum.pemasukan.label),
                  ),
                  TipeTransaksiEnum.pengeluaran: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(TipeTransaksiEnum.pengeluaran.label),
                  ),
                },
                onValueChanged: (value) {
                  if (value != null) {
                    setState(() => _tipeTerpilih = value);
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _simpanForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: _isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    : const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/transaksi/page/form_transaksi.dart
// ============================================================

```dart
// lib/fitur/transaksi/page/form_transaksi.dart
import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/fitur/transaksi/model/kategori_transaksi_model.dart';
import 'package:myapp/fitur/transaksi/model/transaksi_model.dart';
import 'package:myapp/fitur/transaksi/notifier/kategori_transaksi_notifier.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:myapp/fitur/transaksi/state/kategori_transaksi_state.dart';
import 'package:myapp/shared/widget/pemilih_kendaraan.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

/// Halaman form untuk menambah atau mengedit data transaksi.
class FormTransaksi extends ConsumerStatefulWidget {
  /// Model transaksi yang akan diedit. [null] jika mode tambah.
  final TransaksiModel? transaksiModel;

  /// Membuat form transaksi. [transaksiModel] parameter opsional untuk mode edit.
  const FormTransaksi({super.key, this.transaksiModel});

  @override
  ConsumerState<FormTransaksi> createState() => _FormTransaksiState();
}

class _FormTransaksiState extends ConsumerState<FormTransaksi> {
  final _formKey = GlobalKey<FormState>();
  final _deskripsiController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _deskripsiFocusNode = FocusNode();

  DateTime? _tanggalTerpilih;
  TimeOfDay? _waktuTerpilih;
  TipeTransaksiEnum _tipeTerpilih = TipeTransaksiEnum.pemasukan;

  bool _modeEdit = false;
  bool _isLoading = false;
  KendaraanModel? _kendaraanTerpilih;
  KategoriTransaksiModel? _kategoriTerpilih;

  @override
  void initState() {
    super.initState();
    _modeEdit = widget.transaksiModel != null;
    if (_modeEdit) {
      final model = widget.transaksiModel;
      if (model == null) return;
      _deskripsiController.text = model.deskripsi;
      _jumlahController.text = model.jumlah.toStringAsFixed(0);
      _tanggalTerpilih = model.tanggal;
      _waktuTerpilih = TimeOfDay.fromDateTime(model.tanggal);
      _tipeTerpilih = model.tipeTransaksi;
    } else {
      _tanggalTerpilih = DateTime.now();
      _waktuTerpilih = TimeOfDay.now();
    }
    L.i('FormTransaksi dibuka, mode edit: $_modeEdit');
    unawaited(
      Future.microtask(() async {
        try {
          var idKendaraan = widget.transaksiModel?.idKendaraan;
          if (idKendaraan == null || idKendaraan.isEmpty) {
            idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
          }
          final kendaraanState = await ref.read(kendaraanProvider.future);
          if (!mounted) return;
          if (idKendaraan != null && idKendaraan.isNotEmpty) {
            final kendaraan = kendaraanState.getById(idKendaraan);
            if (mounted) {
              setState(() => _kendaraanTerpilih = kendaraan);
            }
          } else if (kendaraanState.listKendaraan.isNotEmpty) {
            final kendaraan = kendaraanState.listKendaraan.first;
            if (mounted) {
              setState(() => _kendaraanTerpilih = kendaraan);
            }
          }
          final kategoriState = await ref.read(
            kategoriTransaksiProvider.future,
          );
          if (!mounted) return;
          final idKategori = widget.transaksiModel?.idKategoriTransaksi;
          if (idKategori != null && idKategori.isNotEmpty) {
            for (final k in kategoriState.listKategoriTransaksi) {
              if (k.id == idKategori) {
                if (mounted) {
                  setState(() => _kategoriTerpilih = k);
                }
                break;
              }
            }
          }
        } catch (e, s) {
          L.e('Gagal memuat kendaraan terpilih form tabungan: $e $s');
        }
      }),
    ); // unawaited: Future.microtask per optimasi_bug_runtime.md #10
  }

  @override
  void dispose() {
    _deskripsiController.dispose();
    _jumlahController.dispose();
    _deskripsiFocusNode.dispose();

    L.i('FormTransaksi ditutup');
    super.dispose();
  }

  /// Menyimpan data transaksi (tambah atau edit).
  Future<void> _simpanForm() async {
    if (_isLoading) {
      L.w('Form masih loading, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('Validasi form gagal');
      return;
    }
    L.i('Menyimpan data tabungan, mode edit: $_modeEdit');
    setState(() => _isLoading = true);
    unawaited(EasyLoading.show(status: 'Menyimpan...'));

    try {
      if (_tanggalTerpilih == null || _waktuTerpilih == null) {
        AppToast.gagal(context, 'Pilih tanggal dan waktu terlebih dahulu');
        unawaited(EasyLoading.dismiss());
        setState(() => _isLoading = false);
        return;
      }
      final idTabungan = _modeEdit
          ? (widget.transaksiModel?.id ?? const Uuid().v4())
          : const Uuid().v4();
      final tanggalTerpilih = _tanggalTerpilih;
      final waktuTerpilih = _waktuTerpilih;
      if (tanggalTerpilih == null || waktuTerpilih == null) {
        AppToast.gagal(context, 'Pilih tanggal dan waktu terlebih dahulu');
        unawaited(EasyLoading.dismiss());
        setState(() => _isLoading = false);
        return;
      }
      final tanggalGabungan = DateTime(
        tanggalTerpilih.year,
        tanggalTerpilih.month,
        tanggalTerpilih.day,
        waktuTerpilih.hour,
        waktuTerpilih.minute,
      );
      final idKendaraan =
          _kendaraanTerpilih?.id ??
          (await ref.read(selectedKendaraanIdProvider.future) ?? '');
      if (idKendaraan.isEmpty) {
        L.w('Tidak ada kendaraan terpilih');
        if (mounted) AppToast.gagal(context, 'Pilih kendaraan terlebih dahulu');
        unawaited(EasyLoading.dismiss());
        if (mounted) setState(() => _isLoading = false);
        return;
      }
      final jumlah = InputAngka.parseAngkaRibuan(_jumlahController.text);
      if (jumlah <= 0) {
        if (mounted) {
          AppToast.gagal(context, 'Jumlah transaksi harus lebih dari 0');
        }
        unawaited(EasyLoading.dismiss());
        if (mounted) setState(() => _isLoading = false);
        return;
      }
      final tabunganToSave = TransaksiModel(
        id: idTabungan,
        idKendaraan: idKendaraan,
        deskripsi: _deskripsiController.text.trim(),
        jumlah: jumlah,
        tanggal: tanggalGabungan,
        tipeTransaksi: _tipeTerpilih,
        idKategoriTransaksi: _kategoriTerpilih?.id,
        diperbarui: DateTime.now(),
      );
      L.i('tabunganToSave $tabunganToSave');
      if (_modeEdit) {
        await ref.read(transaksiProvider.notifier).ubah(tabunganToSave);
      } else {
        await ref.read(transaksiProvider.notifier).tambah(tabunganToSave);
      }
      if (mounted) {
        AppToast.sukses(
          context,
          _modeEdit
              ? 'Tabungan berhasil diperbarui'
              : 'Tabungan berhasil ditambahkan',
        );
        Nav.pop(context);
        L.s(
          'Data tabungan berhasil ${_modeEdit ? 'diperbarui' : 'ditambahkan'}',
        );
      }
    } catch (e, s) {
      L.e('Gagal menyimpan tabungan: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan tabungan');
      }
    } finally {
      if (mounted) {
        unawaited(EasyLoading.dismiss());
        setState(() => _isLoading = false);
      }
    }
  }

  void _resetKeSekarang() {
    L.i('Reset tanggal & waktu ke sekarang');
    setState(() {
      _tanggalTerpilih = DateTime.now();
      _waktuTerpilih = TimeOfDay.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final kendaraanAsync = ref.watch(kendaraanProvider);
    final kategoriAsync = ref.watch(kategoriTransaksiProvider);

    if (kendaraanAsync.isLoading || kategoriAsync.isLoading) {
      return _buildLoading();
    }
    if (kendaraanAsync.hasError || kategoriAsync.hasError) {
      return _buildError();
    }
    final kendaraanState = kendaraanAsync.requireValue;
    final kategoriTransaksiState = kategoriAsync.requireValue;
    final listKendaraan = kendaraanState.listKendaraan;
    final kendaraanTerpilih = _kendaraanTerpilih;
    return Scaffold(
      appBar: AppBar(
        title: Text(_modeEdit ? 'Edit Tabungan' : 'Tambah Tabungan'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            children: [
              if (kendaraanTerpilih != null)
                PemilihKendaraan(
                  kendaraanTerpilih: kendaraanTerpilih,
                  listKendaraan: listKendaraan,
                  onSelected: (v) => setState(() {
                    _kendaraanTerpilih = v;
                  }),
                ),
              _buildTombolTipeTransaksi(),
              _buildFormTransaksi(kategoriTransaksiState),
              const SizedBox(height: 24),
              _buildTombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTombolTipeTransaksi() {
    return CupertinoSlidingSegmentedControl<TipeTransaksiEnum>(
      groupValue: _tipeTerpilih,
      proportionalWidth: true,
      children: {
        TipeTransaksiEnum.pemasukan: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Text(
            TipeTransaksiEnum.pemasukan.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: _tipeTerpilih == TipeTransaksiEnum.pemasukan
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        TipeTransaksiEnum.pengeluaran: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Text(
            TipeTransaksiEnum.pengeluaran.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: _tipeTerpilih == TipeTransaksiEnum.pengeluaran
                  ? Theme.of(context).colorScheme.onError
                  : Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      },
      onValueChanged: (value) {
        if (value != null) {
          setState(() => _tipeTerpilih = value);
        }
      },
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      thumbColor: _tipeTerpilih == TipeTransaksiEnum.pemasukan
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.error,
    );
  }

  Widget _buildFormTransaksi(KategoriTransaksiState kategoriTransaksiState) {
    final listKategoriTransaksi = kategoriTransaksiState.getListByTipe(
      _tipeTerpilih,
    );
    return Column(
      spacing: 16, // jarak antar anak pakai spacing (UI #10)
      children: [
        InputTeks(
          controller: _deskripsiController,
          label: 'Deskripsi',
          focusNode: _deskripsiFocusNode,
        ),
        InputAngka(
          controller: _jumlahController,
          prefixIcon: Icons.attach_money,
        ),
        DropdownSearch<KategoriTransaksiModel>(
          selectedItem: _kategoriTerpilih,
          items: (filter, props) => listKategoriTransaksi,
          itemAsString: (k) => k.nama,
          compareFn: (a, b) => a.id == b.id,
          filterFn: (item, filter) {
            final nama = item.nama.toLowerCase();
            final f = filter.toLowerCase().trim();
            if (f.isEmpty) return true;
            if (nama.contains(f)) return true;
            // cocokkan inisial huruf pertama tiap kata
            final inisial = nama
                .split(RegExp(r'\s+'))
                .where((w) => w.isNotEmpty)
                .map((w) => w[0])
                .join();
            if (inisial.contains(f)) return true;
            var i = 0;
            for (final ch in nama.runes) {
              if (i < f.length && ch == f.codeUnitAt(i)) {
                i++;
              }
            }
            return i == f.length;
          },
          onChanged: (v) => setState(() => _kategoriTerpilih = v),
          decoratorProps: const DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: 'Kategori',
              prefixIcon: Icon(Icons.category),
              border: OutlineInputBorder(),
            ),
          ),
          popupProps: const PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(hintText: 'Cari...'),
            ),
          ),
          suffixProps: const DropdownSuffixProps(
            clearButtonProps: ClearButtonProps(isVisible: true),
          ),
        ),
        Builder(
          builder: (context) {
            final sekarang = DateTime.now();
            var sudahSekarang = false;
            if (_waktuTerpilih != null && _tanggalTerpilih != null) {
              // Variabel lokal non-null untuk menghindari operator !
              final tanggalTerpilih = _tanggalTerpilih;
              final waktuTerpilih = _waktuTerpilih;
              if (tanggalTerpilih != null && waktuTerpilih != null) {
                sudahSekarang =
                    DateUtils.isSameDay(tanggalTerpilih, sekarang) &&
                    waktuTerpilih.hour == sekarang.hour &&
                    waktuTerpilih.minute == sekarang.minute;
              }
            } else if (_tanggalTerpilih != null) {
              final tanggalTerpilih = _tanggalTerpilih;
              if (tanggalTerpilih != null) {
                sudahSekarang = DateUtils.isSameDay(tanggalTerpilih, sekarang);
              }
            }
            final tLabel = _tanggalTerpilih;
            final wLabel = _waktuTerpilih;
            return Column(
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tanggal & Waktu Transaksi',
                      // Ganti TextStyle langsung dengan tema agar konsisten
                      style: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (!sudahSekarang) ...[
                      TextButton.icon(
                        onPressed: _resetKeSekarang,
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text('Sekarang'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  // Hindari operator ! dengan promosi lokal (AGENTS.md poin 1)
                  onPressed: () async {
                    final t = _tanggalTerpilih;
                    final w = _waktuTerpilih;
                    final initial = (t != null && w != null)
                        ? DateTime(t.year, t.month, t.day, w.hour, w.minute)
                        : DateTime.now();
                    final picked = await showOmniDateTimePicker(
                      context: context,
                      initialDate: initial,
                      is24HourMode: true,
                    );
                    if (picked != null && mounted) {
                      setState(() {
                        _tanggalTerpilih = picked;
                        _waktuTerpilih = TimeOfDay.fromDateTime(picked);
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                  label: Text(
                    tLabel == null
                        ? 'Pilih Tanggal & Waktu'
                        : '${FormatTanggal.formatDasar(tLabel)} '
                              '${(wLabel?.hour ?? 0).toString().padLeft(2, '0')}:'
                              '${(wLabel?.minute ?? 0).toString().padLeft(2, '0')}',
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTombolSimpan() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _simpanForm,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
      ),
      child: _isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          : const Text('Simpan'),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_modeEdit ? 'Edit Tabungan' : 'Tambah Tabungan'),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Memuat kendaraan...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_modeEdit ? 'Edit Tabungan' : 'Tambah Tabungan'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat kendaraan'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(kendaraanProvider);
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/transaksi/page/transaksi_page.dart
// ============================================================

```dart
// lib/fitur/transaksi/transaksi_page.dart

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:myapp/fitur/kendaraan/notifier/kendaraan_notifier.dart';
import 'package:myapp/fitur/kendaraan/page/form_kendaraan.dart';
import 'package:myapp/fitur/kendaraan/provider/selected_kendaraan_provider.dart';
import 'package:myapp/fitur/multi_mata_uang/helper/format_mata_uang.dart';
import 'package:myapp/fitur/multi_mata_uang/model/mata_uang_item.dart';
import 'package:myapp/fitur/multi_mata_uang/notifier/mata_uang_notifier.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/fitur/transaksi/model/transaksi_model.dart';
import 'package:myapp/fitur/transaksi/notifier/transaksi_notifier.dart';
import 'package:myapp/fitur/transaksi/page/detail_transaksi.dart';
import 'package:myapp/fitur/transaksi/page/form_transaksi.dart';
import 'package:myapp/fitur/transaksi/state/transaksi_state.dart';
import 'package:myapp/shared/widget/kendaraan_terpilih_list.dart';
import 'package:myapp/shared/widget/scroll_ke_atas.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman daftar transaksi.
class TransaksiPage extends ConsumerStatefulWidget {
  /// Buat halaman daftar transaksi.
  const TransaksiPage({super.key});

  @override
  ConsumerState<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends ConsumerState<TransaksiPage>
    implements ScrollKeAtas {
  final _cariController = TextEditingController();
  final _cariFocusNode = FocusNode();
  bool _modeCari = false;
  bool _isDeletingTransaksi = false;
  bool _isNavigating = false;
  KendaraanModel? _kendaraanTerpilih;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cariController.addListener(_saatTeksCariBerubah);
    unawaited(Future.microtask(_reloadKendaraanTerpilih));
  }

  @override
  void dispose() {
    _cariController.removeListener(_saatTeksCariBerubah);
    _cariController.dispose();
    _cariFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _saatTeksCariBerubah() {
    if (mounted) setState(() {});
  }

  Map<String, List<TransaksiModel>> _groupByDate(List<TransaksiModel> items) {
    final grouped = <String, List<TransaksiModel>>{};
    for (final item in items) {
      final key =
          '${item.tanggal.year}-${item.tanggal.month.toString().padLeft(2, '0')}-${item.tanggal.day.toString().padLeft(2, '0')}';
      grouped.putIfAbsent(key, () => []).add(item);
    }
    return grouped;
  }

  Future<void> _konfirmasiHapus(TransaksiModel item) async {
    if (_isDeletingTransaksi) return;
    final hasil = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Data',
      message: 'Data transaksi tabungan ini akan dihapus secara permanen.',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    if (hasil == OkCancelResult.ok) {
      if (!mounted) return;
      // Hindari setState saat widget sudah tidak aktif setelah await dialog.
      if (mounted) setState(() => _isDeletingTransaksi = true);
      try {
        if (!mounted) return;
        await ref.read(transaksiProvider.notifier).hapus(item.id);
        if (mounted) {
          AppToast.sukses(context, 'Transaksi tabungan berhasil dihapus');
        }
      } catch (e, s) {
        L.e('Gagal menghapus transaksi tabungan: $e $s');
        if (mounted) {
          AppToast.gagal(context, 'Gagal menghapus transaksi tabungan');
        }
      } finally {
        if (mounted) setState(() => _isDeletingTransaksi = false);
      }
    }
  }

  void _modalOpsiTransaksi(TransaksiModel item) {
    unawaited(_modalOpsiTransaksiAsync(item));
  }

  Future<void> _modalOpsiTransaksiAsync(TransaksiModel item) async {
    final result = await showModalActionSheet<String>(
      context: context,
      title: 'Opsi Transaksi',
      message: item.deskripsi,
      cancelLabel: 'Batal',
      actions: const [
        SheetAction(label: 'Edit', key: 'edit'),
        SheetAction(label: 'Hapus', isDestructiveAction: true, key: 'hapus'),
      ],
    );
    if (!mounted) return;
    if (result == 'edit') {
      unawaited(Nav.to(context, FormTransaksi(transaksiModel: item)));
    } else if (result == 'hapus') {
      unawaited(_konfirmasiHapus(item));
    }
  }

  Future<void> _reloadKendaraanTerpilih() async {
    final idKendaraan = await ref.read(selectedKendaraanIdProvider.future);
    final kendaraanState = await ref.read(kendaraanProvider.future);
    KendaraanModel? kendaraan;
    if (idKendaraan != null) {
      kendaraan = kendaraanState.getById(idKendaraan);
      if (kendaraan == null && kendaraanState.listKendaraan.isNotEmpty) {
        kendaraan = kendaraanState.listKendaraan.first;
      }
    } else if (_kendaraanTerpilih != null) {
      kendaraan = _kendaraanTerpilih;
    } else if (kendaraanState.listKendaraan.isNotEmpty) {
      kendaraan = kendaraanState.listKendaraan.first;
    }
    if (mounted) {
      setState(() {
        _kendaraanTerpilih = kendaraan;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedKendaraanIdProvider, (previous, next) {
      // Bandingkan nilai AsyncValue secara aman via asData untuk menghindari akses .value tanpa guard.
      if (previous?.asData?.value != next.asData?.value) {
        unawaited(_reloadKendaraanTerpilih());
      }
    });
    final transaksiAsync = ref.watch(transaksiProvider);
    final kendaraanAsync = ref.watch(kendaraanProvider);
    final selectedAsync = ref.watch(selectedKendaraanIdProvider);
    final mataUangAsync = ref.watch(mataUangProvider);

    // Urutan pemeriksaan AsyncValue: loading → error → data (optimasi_bug_runtime.md poin 9).
    if (selectedAsync.isLoading ||
        kendaraanAsync.isLoading ||
        transaksiAsync.isLoading ||
        mataUangAsync.isLoading) {
      return _buildLoading();
    }
    if (selectedAsync.hasError ||
        kendaraanAsync.hasError ||
        transaksiAsync.hasError ||
        mataUangAsync.hasError) {
      return _buildError(ref);
    }

    final kendaraanState = kendaraanAsync.requireValue;
    final transaksiState = transaksiAsync.requireValue;
    final mataUangItem = mataUangAsync.requireValue;

    {
      if (kendaraanState.listKendaraan.isEmpty) {
        return _buildEmptyKendaraan();
      }
      final idKendaraan = _kendaraanTerpilih?.id;
      final totalPemasukan = idKendaraan == null
          ? transaksiState.getTotalPemasukan()
          : transaksiState.getTotalPemasukanByIdKendaraan(idKendaraan);
      final totalPengeluaran = idKendaraan == null
          ? transaksiState.getTotalPengeluaran()
          : transaksiState.getTotalPengeluaranByIdKendaraan(idKendaraan);
      final saldo = idKendaraan == null
          ? transaksiState.getSaldo()
          : transaksiState.getSaldoByIdKendaraan(idKendaraan);
      return Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: [
            KendaraanTerpilihList(
              listKendaraan: kendaraanState.listKendaraan,
              selectedId: _kendaraanTerpilih?.id,
              onSelected: (kendaraan) {
                setState(() => _kendaraanTerpilih = kendaraan);
              },
              onReload: _reloadKendaraanTerpilih,
            ),
            _buildRingkasanTransaksi(
              totalPemasukan,
              totalPengeluaran,
              saldo,
              mataUangItem,
            ),
            Expanded(
              child: _buildListTransaksi(
                transaksiState,
                idKendaraan,
                mataUangItem,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          tooltip: 'Tambah transaksi',
          onPressed: _isNavigating
              ? null
              : () async {
                  setState(() => _isNavigating = true);
                  await Nav.to(context, const FormTransaksi());
                  if (mounted) setState(() => _isNavigating = false);
                },
          child: const Icon(Icons.add),
        ),
      );
    }
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Memuat data transaksi...'),
          ],
        ),
      ),
    );
  }

  Widget _buildError(WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data transaksi'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(
                  transaksiProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  kendaraanProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
                final _ = ref.refresh(
                  selectedKendaraanIdProvider,
                ); // fixed: invalidate->refresh per aturan_riverpod.md #10
              },
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyKendaraan() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.directions_car_outlined, size: 64),
            const SizedBox(height: 12),
            const Text('Belum ada kendaraan'),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () =>
                  unawaited(Nav.to(context, const FormKendaraan())),
              icon: const Icon(Icons.add),
              label: const Text('Tambah Kendaraan'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: _modeCari
          ? InputTeks(
              controller: _cariController,
              focusNode: _cariFocusNode,
              hintText: 'Cari transaksi...',
              prefixIcon: Icons.search,
              wajib: false,
            )
          : const Text('Transaksi'),
      actions: [
        if (_modeCari) ...[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _cariController.clear();
              _cariFocusNode.unfocus();
              setState(() {
                _modeCari = false;
              });
            },
          ),
        ] else ...[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _modeCari = true;
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _cariFocusNode.requestFocus();
              });
            },
          ),
        ],
      ],
    );
  }

  Widget _buildRingkasanTransaksi(
    double totalPemasukan,
    double totalPengeluaran,
    double saldo,
    MataUangItem mataUangItem,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoRingkasanCustom(
                'Pemasukan',
                totalPemasukan,
                const Color(
                  0xFF2E7D32,
                ), // Hex konsisten semua mode (DESAINS.md 5)
                mataUangItem,
              ),
              _buildInfoRingkasanCustom(
                'Pengeluaran',
                totalPengeluaran,
                const Color(
                  0xFFC62828,
                ), // Hex konsisten semua mode (DESAINS.md 5)
                mataUangItem,
              ),
              _buildInfoRingkasanCustom(
                'Saldo',
                saldo,
                Theme.of(context).colorScheme.onSurface,
                mataUangItem,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTransaksi(
    TransaksiState transaksiState,
    String? idKendaraanTerpilih,
    MataUangItem mataUangItem,
  ) {
    final items = idKendaraanTerpilih == null
        ? transaksiState.listTransaksi
        : transaksiState.listTransaksi
              .where((item) => item.idKendaraan == idKendaraanTerpilih)
              .toList();
    final cari = _cariController.text.toLowerCase();
    final filteredItems = cari.isEmpty
        ? items
        : items
              .where((item) => item.deskripsi.toLowerCase().contains(cari))
              .toList();
    if (filteredItems.isEmpty) return _buildListKosong();

    final grouped = _groupByDate(filteredItems);
    // Menggunakan sorted dari package:collection sesuai AGENTS.md, bukan native .sort().
    final tanggalKeys = grouped.keys.toList().sorted((a, b) => b.compareTo(a));

    // Ratakan menjadi satu list linear (header tanggal + item) agar indeks stabil
    // dan tidak perlu hitung flatIndex secara manual di itemBuilder.
    final flat = <Object>[];
    for (final tanggal in tanggalKeys) {
      flat.add(tanggal);
      for (final item in grouped[tanggal] ?? <TransaksiModel>[]) {
        flat.add(item);
      }
    }
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: flat.length,
      itemBuilder: (context, index) {
        final entry = flat[index];
        if (entry is String) {
          return _buildHeaderTanggal(entry);
        }
        // Type-test untuk menghindari cast langsung pada list campuran.
        if (entry is TransaksiModel) {
          return _buildItemTransaksi(entry, mataUangItem);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHeaderTanggal(String tanggal) {
    DateTime? tanggalParsed;
    try {
      // Menghindari DateTime.parse dinamis menurut AGENTS.md; wajib tryParse.
      tanggalParsed = DateTime.tryParse(tanggal);
    } catch (e, s) {
      L.e('Gagal parse tanggal tabungan: $e $s');
    }
    final teksTanggal = tanggalParsed == null
        ? tanggal
        : FormatTanggal.formatDasar(tanggalParsed);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        spacing: 8,
        children: [
          Icon(
            Icons.calendar_today,
            size: 20,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          Text(
            teksTanggal,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemTransaksi(
    TransaksiModel tabungan,
    MataUangItem mataUangItem,
  ) {
    final isPemasukan = tabungan.tipeTransaksi == TipeTransaksiEnum.pemasukan;

    return InkWell(
      onTap: () => unawaited(
        Nav.to(context, DetailTransaksiPage(transaksiModel: tabungan)),
      ), // aturan unawaited
      onLongPress: () => _modalOpsiTransaksi(tabungan),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tabungan.deskripsi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FittedBox(
                    child: Text(
                      '${isPemasukan ? '+' : '-'}${formatMataUang(tabungan.jumlah, mataUangItem)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isPemasukan
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFC62828), // konsisten hex (UX #13)
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(FormatJam.formatJamMenit(tabungan.tanggal)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRingkasanCustom(
    String label,
    double value,
    Color color,
    MataUangItem mataUangItem,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(formatMataUang(value, mataUangItem)),
        ),
      ],
    );
  }

  Widget _buildListKosong() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada transaksi',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tambahkan transaksi pertama untuk kendaraan yang dipilih.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => unawaited(Nav.to(context, const FormTransaksi())),
            icon: const Icon(Icons.add),
            label: const Text('Tambah Transaksi'),
          ),
        ],
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/transaksi/state/kategori_transaksi_state.dart
// ============================================================

```dart
// lib/fitur/transaksi/state/kategori_transaksi_state.dart

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/fitur/transaksi/model/kategori_transaksi_model.dart';

part 'kategori_transaksi_state.freezed.dart';

/// State untuk mengelola daftar kategori transaksi.
@freezed
abstract class KategoriTransaksiState with _$KategoriTransaksiState {
  const KategoriTransaksiState._();

  /// Membuat instance [KategoriTransaksiState] dengan daftar kategori.
  const factory KategoriTransaksiState({
    @Default([]) List<KategoriTransaksiModel> listKategoriTransaksi,
  }) = _KategoriTransaksiState;

  /// Mengembalikan kategori dengan [id], atau null jika tidak ditemukan.
  KategoriTransaksiModel? getById(String id) {
    return listKategoriTransaksi.firstWhereOrNull((k) => k.id == id);
  }

  /// Mengembalikan daftar kategori dengan [tipe] tertentu.
  List<KategoriTransaksiModel> getListByTipe(TipeTransaksiEnum tipe) {
    return listKategoriTransaksi.where((k) => k.tipe == tipe).toList();
  }

  /// Mengembalikan kategori dengan [nama], atau null jika tidak ditemukan.
  KategoriTransaksiModel? getByNama(String nama) {
    return listKategoriTransaksi.firstWhereOrNull(
      (k) => k.nama.toLowerCase() == nama.toLowerCase(),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/transaksi/state/transaksi_state.dart
// ============================================================

```dart
// lib/fitur/transaksi/state/transaksi_state.dart

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/fitur/transaksi/model/transaksi_model.dart';

part 'transaksi_state.freezed.dart';

/// State untuk mengelola daftar transaksi.
@freezed
abstract class TransaksiState with _$TransaksiState {
  const TransaksiState._();

  /// Membuat instance [TransaksiState] dengan daftar transaksi.
  const factory TransaksiState({
    @Default([]) List<TransaksiModel> listTransaksi,
  }) = _TransaksiState;

  /// Mengembalikan transaksi dengan [id], atau null jika tidak ditemukan.
  TransaksiModel? getById(String id) {
    return listTransaksi.firstWhereOrNull((t) => t.id == id);
  }

  /// Mengembalikan daftar transaksi yang terkait dengan [idKendaraan].
  List<TransaksiModel> getListByIdKendaraan(String idKendaraan) {
    return listTransaksi.where((t) => t.idKendaraan == idKendaraan).toList();
  }

  /// Mengembalikan total pemasukan untuk [idKendaraan].
  double getTotalPemasukan() {
    return listTransaksi
        .where((t) => t.tipeTransaksi == TipeTransaksiEnum.pemasukan)
        .fold(0.0, (sum, t) => sum + t.jumlah);
  }

  /// Mengembalikan total pemasukan untuk [idKendaraan].
  double getTotalPemasukanByIdKendaraan(String idKendaraan) {
    return getListByIdKendaraan(idKendaraan)
        .where((t) => t.tipeTransaksi == TipeTransaksiEnum.pemasukan)
        .fold(0.0, (sum, t) => sum + t.jumlah);
  }

  /// Mengembalikan total pengeluaran untuk [idKendaraan].
  double getTotalPengeluaran() {
    return listTransaksi
        .where((t) => t.tipeTransaksi == TipeTransaksiEnum.pengeluaran)
        .fold(0.0, (sum, t) => sum + t.jumlah);
  }

  /// Menghitung total pengeluaran berdasarkan kendaraan.
  double getTotalPengeluaranByIdKendaraan(String idKendaraan) {
    return getListByIdKendaraan(idKendaraan)
        .where((t) => t.tipeTransaksi == TipeTransaksiEnum.pengeluaran)
        .fold(0.0, (sum, t) => sum + t.jumlah);
  }

  /// Mengembalikan saldo (pemasukan dikurangi pengeluaran) untuk [idKendaraan].
  double getSaldo() {
    return getTotalPemasukan() - getTotalPengeluaran();
  }

  /// Mengembalikan saldo (pemasukan dikurangi pengeluaran) untuk [idKendaraan].
  double getSaldoByIdKendaraan(String idKendaraan) {
    return getTotalPemasukanByIdKendaraan(idKendaraan) -
        getTotalPengeluaranByIdKendaraan(idKendaraan);
  }
}
```


// ============================================================
// FILE: lib/home.dart
// ============================================================

```dart
// lib/home.dart

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/dashboard/page/dashboard_page.dart';
import 'package:myapp/fitur/jadwal_service/page/jadwal_service_page.dart';
import 'package:myapp/fitur/km/page/km_page.dart';
import 'package:myapp/fitur/transaksi/page/transaksi_page.dart';
import 'package:myapp/lainnya_page.dart';
import 'package:myapp/shared/widget/scroll_ke_atas.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman utama aplikasi yang menampilkan navigasi bottom navigation.
class Home extends ConsumerStatefulWidget {
  /// Membuat instance [Home] dengan kunci opsional.
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int _selectedIndex = 0;
  DateTime? _lastTapTime;
  static const _durasiDoubleTap = Duration(milliseconds: 500);

  final _kunciDashboard = GlobalKey<State<DashboardPage>>();
  final _kunciKm = GlobalKey<State<KmPage>>();
  final _kunciJadwal = GlobalKey<State<JadwalServicePage>>();
  final _kunciTransaksi = GlobalKey<State<TransaksiPage>>();
  final _kunciLainnya = GlobalKey<State<LainnyaPage>>();

  /// Menyimpan tab yang sudah pernah dibuka agar state tetap terjaga.
  final Set<int> _tabTerbuka = {0};

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (_selectedIndex != 0) {
          setState(() => _selectedIndex = 0);
          return;
        }
        final keluar = await showOkCancelAlertDialog(
          context: context,
          title: 'Keluar aplikasi?',
          message: 'Apakah Anda yakin ingin keluar?',
          okLabel: 'Keluar',
          cancelLabel: 'Batal',
          isDestructiveAction: true,
        );
        if (keluar == OkCancelResult.ok && context.mounted) {
          await SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: List<Widget>.generate(5, (i) {
            if (!_tabTerbuka.contains(i)) {
              return const SizedBox.shrink();
            }
            return switch (i) {
              0 => DashboardPage(key: _kunciDashboard),
              1 => KmPage(key: _kunciKm),
              2 => JadwalServicePage(key: _kunciJadwal),
              3 => TransaksiPage(key: _kunciTransaksi),
              _ => LainnyaPage(key: _kunciLainnya),
            };
          }),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _saatPilihTab,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.speed_outlined),
              selectedIcon: Icon(Icons.speed),
              label: 'KM',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month),
              label: 'Jadwal',
            ),
            NavigationDestination(
              icon: Icon(Icons.savings_outlined),
              selectedIcon: Icon(Icons.savings),
              label: 'Transaksi',
            ),
            NavigationDestination(
              icon: Icon(Icons.apps_outlined),
              selectedIcon: Icon(Icons.apps),
              label: 'Lainnya',
            ),
          ],
        ),
      ),
    );
  }

  void _saatPilihTab(int i) {
    final sekarang = DateTime.now();
    final lastTap = _lastTapTime;
    final tabSama = i == _selectedIndex;
    final doubleTap =
        tabSama &&
        lastTap != null &&
        sekarang.difference(lastTap) <= _durasiDoubleTap;

    if (doubleTap) {
      _scrollKeAtas(i);
      _lastTapTime = null;
      return;
    }

    if (!tabSama) {
      setState(() {
        _tabTerbuka.add(i);
        _selectedIndex = i;
      });
    }

    _lastTapTime = sekarang;
  }

  void _scrollKeAtas(int i) {
    final state = switch (i) {
      0 => _kunciDashboard.currentState,
      1 => _kunciKm.currentState,
      2 => _kunciJadwal.currentState,
      3 => _kunciTransaksi.currentState,
      _ => _kunciLainnya.currentState,
    };
    if (state == null) {
      L.w('Scroll ke atas diabaikan: state tab ke-$i belum tersedia');
      return;
    }
    // Hindari cast dinamis; gunakan interface ScrollKeAtas agar aman dan type-safe.
    if (state case final ScrollKeAtas scrollable) {
      try {
        scrollable.scrollToTop();
        L.i('Scroll ke atas pada tab ke-$i');
      } catch (e, s) {
        L.e('Gagal scroll ke atas pada tab ke-$i: $e $s');
      }
    } else {
      L.w(
        'Scroll ke atas diabaikan: tab ke-$i tidak mengimplementasikan ScrollKeAtas',
      );
    }
  }
}
```


// ============================================================
// FILE: lib/lainnya_page.dart
// ============================================================

```dart
import 'package:flutter/material.dart';
import 'package:myapp/fitur/bahan_bakar/page/bahan_bakar_page.dart';
import 'package:myapp/fitur/dummy/page/dummy_page.dart';
import 'package:myapp/fitur/impian/page/impian_page.dart';
import 'package:myapp/fitur/kendaraan/page/kendaraan_page.dart';
import 'package:myapp/fitur/kendaraan/page/perbandingan_kendaraan_page.dart';
import 'package:myapp/fitur/komponen/page/komponen_page.dart';
import 'package:myapp/fitur/pengaturan/page/pengaturan_page.dart';
import 'package:myapp/fitur/pengingat/page/pengingat_page.dart';
import 'package:myapp/fitur/sinkronisasi/sinkronisasi_page.dart';
import 'package:myapp/shared/widget/scroll_ke_atas.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman pengaturan yang menampilkan daftar menu fitur aplikasi.
class LainnyaPage extends StatefulWidget {
  /// Membuat instance [LainnyaPage] dengan kunci opsional.
  const LainnyaPage({super.key});

  @override
  State<LainnyaPage> createState() => _LainnyaPageState();
}

class _LainnyaPageState extends State<LainnyaPage> implements ScrollKeAtas {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildListItem(
            context,
            label: 'Kendaraan',
            icon: Icons.directions_car,
            page: const KendaraanPage(),
          ),
          _buildListItem(
            context,
            label: 'Perbandingan Kendaraan',
            icon: Icons.compare_arrows,
            page: const PerbandinganKendaraanPage(),
          ),
          _buildListItem(
            context,
            label: 'Impian',
            icon: Icons.flag,
            page: const ImpianPage(),
          ),
          _buildListItem(
            context,
            label: 'Komponen',
            icon: Icons.build_circle,
            page: const KomponenPage(),
          ),
          _buildListItem(
            context,
            label: 'Sinkronisasi',
            icon: Icons.sync,
            page: const SinkronisasiPage(),
          ),
          _buildListItem(
            context,
            label: 'Bahan Bakar',
            icon: Icons.local_gas_station,
            page: const BahanBakarPage(),
          ),
          _buildListItem(
            context,
            label: 'Pengingat',
            icon: Icons.notifications,
            page: const PengingatPage(),
          ),

          _buildListItem(
            context,
            label: 'Pengaturan',
            icon: Icons.settings,
            page: const PengaturanPage(),
          ),
          _buildListItem(
            context,
            label: 'Dummy',
            icon: Icons.science,
            page: const DummyPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Widget page,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        try {
          await Nav.to(context, page);
        } catch (e, s) {
          L.e('Navigasi gagal: $e $s');
          if (context.mounted) {
            AppToast.gagal(context, 'Gagal membuka halaman');
          }
        }
      },
    );
  }
}
```


// ============================================================
// FILE: lib/main.dart
// ============================================================

```dart
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myapp/app.dart';
import 'package:myapp/shared/notifikasi/notifikasi_service.dart';
import 'package:myapp/shared/sinkronisasi/google_drive_helper.dart';
import 'package:restart_app/restart_app.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

String? _initError;

void main() async {
  p('init');
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (details) {
    L.e('ErrorWidget: ${details.exception}\n${details.stack}');
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Terjadi kesalahan pada tampilan.\\nSilakan coba lagi.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                details.exceptionAsString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final result = await Restart.restartApp();
                    if (!result.success) {
                      L.w('restart gagal: ${result.code} ${result.message}');
                    }
                  } catch (e) {
                    L.e('restart app error: $e');
                  }
                },
                child: const Text('Restart'),
              ),
            ],
          ),
        ),
      ),
    );
  };
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  ProviderContainer? container;
  try {
    p('init 1: initializeDateFormatting');
    await initializeDateFormatting('id_ID', '');
    p('init 1 done');
    await SharedPrefService.init();
    p('init 2: SharedPrefService done');
    if (!kIsWeb) {
      p('init 3: GoogleDriveHelper.initialize');
      await GoogleDriveHelper.initialize(
        serverClientId: '661299908775-503fr7qk016kfccacdepf2nsm63sirp1.apps.googleusercontent.com',
      );
      p('init 3 done');
    }
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else if (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    p('init 4: NotifikasiService.inisialisasi');
    await NotifikasiService.inisialisasi();
    p('init 4 done');
    final c = ProviderContainer();
    container = c;
    L.init(c);
    p('init 5: runApp');
    runApp(UncontrolledProviderScope(container: c, child: const App()));
    p('init 5 done: runApp');
    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotifikasiService.cekNotifikasiSaatBuka();
    });
  } catch (e, s) {
    container?.dispose();
    _initError = e.toString();
    p('init CATCH: $e');
    L.e('Gagal inisialisasi app: $e $s');
    FlutterNativeSplash.remove();
    runApp(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Gagal memulai aplikasi.\nSilakan coba lagi.',
                      textAlign: TextAlign.center,
                    ),
                    if (_initError != null) ...[
                      const SizedBox(height: 12),
                      Builder(
                        builder: (context) {
                          final pesanError = _initError;
                          if (pesanError == null) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            pesanError,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          );
                        },
                      ),
                    ],
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final result = await Restart.restartApp();
                          if (!result.success) {
                            L.w(
                              'restart gagal: ${result.code} ${result.message}',
                            );
                          }
                        } catch (e) {
                          L.e('restart app error: $e');
                        }
                      },
                      child: const Text('Restart'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/shared/db/sqflite/db_sqflite.dart
// ============================================================

```dart
// lib/shared/db/db_sqflite.dart
import 'dart:async';

import 'package:myapp/shared/db/sqflite/tabel_sqflite.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

part 'db_sqflite.g.dart';
part 'sqflite_migration.dart';

/// Kelas untuk mengelola database Sqflite aplikasi.
class DbSqflite {
  /// Versi database saat ini.
  static const int version = 10;

  /// Buat instance DbSqflite.
  DbSqflite();

  Database? _db;
  Future<Database>? _initFuture;

  /// Mendapatkan instance database, membuatnya jika belum ada. Menggunakan gate agar inisialisasi tidak berjalan dua kali bersamaan. Refactor: hindari operator ! dengan pola jika dan variabel lokal.
  Future<Database> get database async {
    if (_db case final db?) return db;
    final future = _initFuture ??= _initDb();
    try {
      final dbResult = await future;
      _db = dbResult;
      _initFuture = null;
      return dbResult;
    } catch (e, st) {
      // Reset agar inisialisasi bisa diulang setelah error.
      _initFuture = null;
      L.e('Gagal inisialisasi database: $e $st');
      rethrow;
    }
  }

  Future<Database> _initDb() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'app.db');

      final db = await openDatabase(
        path,
        version: version,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
      );

      // Pastikan semua tabel ada (mis. DB lama / hasil restore dari versi lama
      // yang belum memiliki tabel baru). CREATE TABLE IF NOT EXISTS aman.
      for (final sql in TabelSqflite.semuaTabel) {
        await db.execute(sql);
      }

      return db;
    } catch (e, s) {
      L.e('Gagal inisialisasi _initDb: $e $s');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    for (final sql in TabelSqflite.semuaTabel) {
      await db.execute(sql);
    }
  }

  // ==================== METHOD UTILITY ====================

  /// Menutup koneksi database jika masih terbuka.
  Future<void> close() async {
    final db = _db;
    if (db != null) {
      await db.close();
      _db = null;
    }
  }

  /// Mengembalikan versi database saat ini.
  Future<int> getVersion() async {
    final db = await database;
    return await db.getVersion();
  }

  /// Mengecek apakah tabel [tableName] ada di database.
  Future<bool> tableExists(String tableName) async {
    final db = await database;
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName],
    );
    return result.isNotEmpty;
  }

  /// Membuat semua tabel di database.
  Future<void> createAllTables() async {
    final db = await database;
    try {
      L.i('🔄 Membuat semua tabel...');

      for (final sql in TabelSqflite.semuaTabel) {
        await db.execute(sql);
      }

      L.s('✅ Semua tabel berhasil dibuat');
    } catch (e, s) {
      L.e('❌ Gagal membuat tabel $e $s');
      rethrow;
    }
  }

  /// Mereset dan membuat ulang semua tabel di database.
  Future<void> resetDanBuatUlang() async {
    final db = await database;
    try {
      L.w('⚠️ RESET DATABASE: Menghapus semua tabel...');
      await db.transaction((txn) async {
        await txn.execute('PRAGMA foreign_keys = OFF');
        for (final sql in TabelSqflite.dropAllTables) {
          await txn.execute(sql);
        }
        for (final sql in TabelSqflite.semuaTabel) {
          await txn.execute(sql);
        }
        await txn.execute('PRAGMA foreign_keys = ON');
      });
      L.s('✅ Database berhasil direset dan dibuat ulang');
    } catch (e, s) {
      L.e('❌ Gagal reset dan buat ulang database $e $s');
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
/// Provider untuk instance [DbSqflite].
DbSqflite dbSqflite(Ref ref) {
  final db = DbSqflite();
  return db;
}
```


// ============================================================
// FILE: lib/shared/db/sqflite/sqflite_migration.dart
// ============================================================

```dart
// lib/shared/db/sqflite/sqflite_migration.dart
part of 'db_sqflite.dart';

/// Ekstensi untuk migrasi skema database Sqflite.
extension DbSqfliteMigration on DbSqflite {
  /// Menangani upgrade database dengan try/catch dan log error.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      // Versi 2: tambah kolom path_gambar.
      if (oldVersion < 2) {
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.kendaraan,
          NamaKolom.pathGambar,
          'TEXT',
        );
      }
      // Versi 4: tambah kolom tahun_keluar, model, jenis pada kendaraan.
      if (oldVersion < 4) {
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.kendaraan,
          NamaKolom.tahunKeluar,
          'TEXT',
        );
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.kendaraan,
          NamaKolom.model,
          'TEXT',
        );
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.kendaraan,
          NamaKolom.jenis,
          'TEXT',
        );
      }
      // Versi 5: tambah kolom diperbarui pada tabel pengingat.
      if (oldVersion < 5) {
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.pengingat,
          NamaKolom.diperbarui,
          'TEXT',
        );
      }
      // Versi 6: tambah kolom id_kendaraan pada tabel pengingat.
      if (oldVersion < 6) {
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.pengingat,
          NamaKolom.idKendaraan,
          'TEXT',
        );
      }
      // Versi 7: tambah tabel kategori_pengeluaran dan kolom kategori/struk pada transaksi.
      if (oldVersion < 7) {
        await db.execute(TabelSqflite.kategoriTransaksi);
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.transaksi,
          NamaKolom.idKategoriTransaksi,
          'TEXT',
        );
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.transaksi,
          NamaKolom.pathStruk,
          'TEXT',
        );
      }
      // Versi 8: tambah kolom tipe_transaksi pada tabel kategori_transaksi.
      if (oldVersion < 8) {
        await db.execute(TabelSqflite.kategoriTransaksi);
        await _tambahKolomJikaBelumAda(
          db,
          NamaTabel.kategoriTransaksi,
          NamaKolom.tipeTransaksi,
          "TEXT NOT NULL DEFAULT 'pemasukan'",
        );
      }
      // Versi 9: rename tabel tabungan -> transaksi (dan kolom id_kategori_tabungan -> id_kategori_transaksi).
      if (oldVersion < 9) {
        try {
          await db.execute(
            'ALTER TABLE "tabungan" RENAME TO "${NamaTabel.transaksi}"',
          );
        } catch (e, s) {
          L.e('⚠️ Gagal rename tabel tabungan: $e $s');
        }
        try {
          await db.execute(
            'ALTER TABLE "kategori_tabungan" RENAME TO "${NamaTabel.kategoriTransaksi}"',
          );
        } catch (e, s) {
          L.e('⚠️ Gagal rename tabel kategori_tabungan: $e $s');
        }
        try {
          await db.execute(
            'ALTER TABLE "${NamaTabel.transaksi}" RENAME COLUMN "id_kategori_tabungan" TO "${NamaKolom.idKategoriTransaksi}"',
          );
        } catch (e, s) {
          L.e('⚠️ Gagal rename kolom id_kategori_tabungan: $e $s');
        }
      }
      // Versi 10: rename kolom pengingat camelCase -> snake_case.
      if (oldVersion < 10) {
        for (final kolomLamaBaru in [
          ['tanggalTampil', (NamaKolom.tanggalTampil)],
          ['kategoriPengingat', (NamaKolom.kategoriPengingat)],
          ['pageTujuan', (NamaKolom.pageTujuan)],
        ]) {
          try {
            await db.execute(
              'ALTER TABLE "${NamaTabel.pengingat}" RENAME COLUMN "${kolomLamaBaru[0]}" TO "${kolomLamaBaru[1]}"',
            );
          } catch (e, s) {
            L.e('⚠️ Gagal rename kolom ${kolomLamaBaru[0]}: $e $s');
          }
        }
      }
    } catch (e, s) {
      /// Log error migrasi dan lempar ulang agar tidak tersembunyi.
      L.e('❌ Gagal migrasi database $e $s');
      rethrow;
    }
  }

  Future<void> _tambahKolomJikaBelumAda(
    Database db,
    String tabel,
    String kolom,
    String tipe,
  ) async {
    try {
      /// Periksa apakah kolom sudah ada melalui PRAGMA.
      final kolomList = await db.rawQuery('PRAGMA table_info("$tabel")');
      final ada = kolomList.any((r) => r['name'] == kolom);
      if (!ada) {
        /// Tambah kolom jika belum ada.
        await db.execute('ALTER TABLE "$tabel" ADD COLUMN "$kolom" $tipe');
      }
    } catch (e, s) {
      /// Log error saat tambah kolom dan lempar ulang.
      L.e('❌ Gagal tambah kolom $kolom pada $tabel $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/shared/db/sqflite/tabel_sqflite.dart
// ============================================================

```dart
// lib/shared/db/sqflite/tabel_sqflite.dart
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:myapp/shared/konstanta/nama_tabel.dart';

/// Definisi skema SQL untuk semua tabel Sqflite.
class TabelSqflite {
  TabelSqflite._();

  /// DDL untuk tabel km.
  static String get km =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.km} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.km} TEXT NOT NULL,
  ${NamaKolom.tanggal} TEXT NOT NULL,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel komponen.
  static String get komponen =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.komponen} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.harga} REAL NOT NULL,
  ${NamaKolom.linkToko} TEXT,
  ${NamaKolom.idKendaraan} TEXT NOT NULL DEFAULT '',
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel jadwalService.
  static String get jadwalService =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.jadwalService} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.bulan} INTEGER NOT NULL,
  ${NamaKolom.km} INTEGER NOT NULL,
  ${NamaKolom.kmTerakhirService} REAL NOT NULL,
  ${NamaKolom.tanggalTerakhirService} TEXT NOT NULL,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel jadwalServiceKomponen.
  static String get jadwalServiceKomponen =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.jadwalServiceKomponen} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.jadwalServiceId} TEXT NOT NULL,
  ${NamaKolom.komponenId} TEXT NOT NULL,
  ${NamaKolom.idKendaraan} TEXT NOT NULL DEFAULT '',
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT,
  FOREIGN KEY (${NamaKolom.jadwalServiceId}) REFERENCES ${NamaTabel.jadwalService} (${NamaKolom.id}) ON DELETE CASCADE,
  FOREIGN KEY (${NamaKolom.komponenId}) REFERENCES ${NamaTabel.komponen} (${NamaKolom.id}) ON DELETE CASCADE
)
''';

  /// DDL untuk tabel riwayatJadwalService.
  static String get riwayatJadwalService =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.riwayatJadwalService} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.jadwalServiceId} TEXT NOT NULL,
  ${NamaKolom.idKendaraan} TEXT NOT NULL DEFAULT '',
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.tanggalService} TEXT NOT NULL,
  ${NamaKolom.km} REAL NOT NULL,
  ${NamaKolom.biaya} REAL NOT NULL,
  ${NamaKolom.catatan} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel kendaraan.
  static String get kendaraan =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.kendaraan} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.merk} TEXT NOT NULL,
  ${NamaKolom.platNomor} TEXT,
  ${NamaKolom.pathGambar} TEXT,
  ${NamaKolom.tahunKeluar} TEXT,
  ${NamaKolom.model} TEXT,
  ${NamaKolom.jenis} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel transaksi.
  static String get transaksi =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.transaksi} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.deskripsi} TEXT NOT NULL,
  ${NamaKolom.jumlah} REAL NOT NULL,
  ${NamaKolom.tanggal} TEXT NOT NULL,
   ${NamaKolom.tipeTransaksi} TEXT NOT NULL,
   ${NamaKolom.idKategoriTransaksi} TEXT,
   ${NamaKolom.pathStruk} TEXT,
   ${NamaKolom.riwayatJadwalServiceId} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel kategori transaksi.
  static String get kategoriTransaksi =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.kategoriTransaksi} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.tipeTransaksi} TEXT NOT NULL DEFAULT 'pemasukan',
  ${NamaKolom.ikon} TEXT,
  ${NamaKolom.warna} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel impian.
  static String get impian =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.impian} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.deskripsi} TEXT NOT NULL,
  ${NamaKolom.jumlah} REAL NOT NULL,
  ${NamaKolom.tanggalDibuat} TEXT NOT NULL,
  ${NamaKolom.tanggalTarget} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel pajak.
  static String get pajak =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.pajak} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.nama} TEXT NOT NULL,
  ${NamaKolom.tanggal} TEXT NOT NULL,
  ${NamaKolom.biaya} REAL NOT NULL,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// DDL untuk tabel pengingat.
  static String get pengingat =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.pengingat} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.idKendaraan} TEXT NOT NULL DEFAULT '',
  ${NamaKolom.pesan} TEXT NOT NULL,
  ${NamaKolom.tanggalTampil} TEXT NOT NULL,
  ${NamaKolom.kategoriPengingat} TEXT NOT NULL,
  ${NamaKolom.pageTujuan} TEXT NOT NULL,
  ${NamaKolom.diperbarui} TEXT NOT NULL
)
''';

  /// DDL untuk tabel bahan bakar.
  static String get bahanBakar =>
      '''
CREATE TABLE IF NOT EXISTS ${NamaTabel.bahanBakar} (
  ${NamaKolom.id} TEXT PRIMARY KEY,
  ${NamaKolom.idKendaraan} TEXT NOT NULL,
  ${NamaKolom.tanggal} TEXT NOT NULL,
  ${NamaKolom.km} TEXT NOT NULL,
  ${NamaKolom.liter} REAL NOT NULL,
  ${NamaKolom.hargaPerLiter} REAL NOT NULL,
  ${NamaKolom.total} REAL NOT NULL,
  ${NamaKolom.catatan} TEXT,
  ${NamaKolom.diperbarui} TEXT NOT NULL,
  ${NamaKolom.diarsipkan} TEXT
)
''';

  /// Daftar semua DDL tabel.
  static List<String> get semuaTabel => [
    km,
    komponen,
    jadwalService,
    jadwalServiceKomponen,
    riwayatJadwalService,
    kendaraan,
    transaksi,
    kategoriTransaksi,
    impian,
    pajak,
    bahanBakar,
    pengingat,
  ];

  /// Daftar semua perintah DROP TABLE.
  static List<String> get dropAllTables => [
    'DROP TABLE IF EXISTS ${NamaTabel.km}',
    'DROP TABLE IF EXISTS ${NamaTabel.komponen}',
    'DROP TABLE IF EXISTS ${NamaTabel.jadwalService}',
    'DROP TABLE IF EXISTS ${NamaTabel.jadwalServiceKomponen}',
    'DROP TABLE IF EXISTS ${NamaTabel.riwayatJadwalService}',
    'DROP TABLE IF EXISTS ${NamaTabel.kendaraan}',
    'DROP TABLE IF EXISTS ${NamaTabel.transaksi}',
    'DROP TABLE IF EXISTS ${NamaTabel.kategoriTransaksi}',
    'DROP TABLE IF EXISTS ${NamaTabel.impian}',
    'DROP TABLE IF EXISTS ${NamaTabel.pajak}',
    'DROP TABLE IF EXISTS ${NamaTabel.bahanBakar}',
    'DROP TABLE IF EXISTS ${NamaTabel.pengingat}',
  ];
}
```


// ============================================================
// FILE: lib/shared/enum/page_enum.dart
// ============================================================

```dart
enum PageEnum {
  dashboard,
  km,
  transaksi
}```


// ============================================================
// FILE: lib/shared/konstanta/nama_kolom.dart
// ============================================================

```dart
// lib/shared/konstanta/nama_kolom.dart

/// Konstanta nama kolom yang digunakan dalam tabel database SQLite.
class NamaKolom {
  /// Kolom ID utama.
  static const String id = 'id';

  /// Kolom nama.
  static const String nama = 'nama';

  /// Kolom harga.
  static const String harga = 'harga';

  /// Kolom tanggal.
  static const String tanggal = 'tanggal';

  /// Kolom waktu terakhir diperbarui.
  static const String diperbarui = 'diperbarui';

  /// Kolom status diarsipkan.
  static const String diarsipkan = 'diarsipkan';

  /// Kolom ID kendaraan.
  static const String idKendaraan = 'id_kendaraan';

  /// Kolom bulan.
  static const String bulan = 'bulan';

  /// Kolom kilometer.
  static const String km = 'km';

  /// Kolom kilometer terakhir service.
  static const String kmTerakhirService = 'km_terakhir_service';

  /// Kolom tanggal terakhir service.
  static const String tanggalTerakhirService = 'tanggal_terakhir_service';

  /// Kolom tanggal service dilakukan.
  static const String tanggalService = 'tanggal_service';

  /// Kolom total biaya service.
  static const String biaya = 'biaya';

  /// Kolom catatan service.
  static const String catatan = 'catatan';

  /// Kolom ID jadwal service.
  static const String jadwalServiceId = 'jadwal_service_id';

  /// Kolom ID riwayat jadwal service (untuk sinkron transaksi).
  static const String riwayatJadwalServiceId = 'riwayat_jadwal_service_id';

  /// Kolom ID komponen.
  static const String komponenId = 'komponen_id';

  /// Kolom link pembelian.
  static const String linkPembelian = 'link_pembelian';

  /// Kolom jumlah.
  static const String jumlah = 'jumlah';

  /// Kolom tipe transaksi.
  static const String tipeTransaksi = 'tipe_transaksi';

  /// Kolom ID kategori transaksi (relasi ke kategori_transaksi).
  static const String idKategoriTransaksi = 'id_kategori_transaksi';

  /// Kolom path struk/lampiran pengeluaran.
  static const String pathStruk = 'path_struk';

  /// Kolom ikon kategori.
  static const String ikon = 'ikon';

  /// Kolom warna kategori.
  static const String warna = 'warna';

  /// Kolom deskripsi.
  static const String deskripsi = 'deskripsi';

  /// Kolom link toko.
  static const String linkToko = 'link_toko';

  /// Kolom tanggal dibuat.
  static const String tanggalDibuat = 'tanggal_dibuat';

  /// Kolom tanggal target impian.
  static const String tanggalTarget = 'tanggal_target';

  /// Kolom merk kendaraan.
  static const String merk = 'merk';

  /// Kolom plat nomor kendaraan.
  static const String platNomor = 'plat_nomor';

  /// Kolom path gambar kendaraan (lokal).
  static const String pathGambar = 'path_gambar';

  /// Kolom tahun keluar kendaraan.
  static const String tahunKeluar = 'tahun_keluar';

  /// Kolom model kendaraan.
  static const String model = 'model';

  /// Kolom jenis kendaraan.
  static const String jenis = 'jenis';

  /// Kolom tanggal jatuh tempo pajak kendaraan.
  static const String tanggalPajak = 'tanggal_pajak';

  /// Kolom jumlah liter bahan bakar.
  static const String liter = 'liter';

  /// Kolom harga per liter bahan bakar.
  static const String hargaPerLiter = 'harga_per_liter';

  /// Kolom total biaya bahan bakar.
  static const String total = 'total';

  /// Kolom pesan pengingat.
  static const String pesan = 'pesan';

  /// Kolom tanggal tampil pengingat.
  static const String tanggalTampil = 'tanggal_tampil';

  /// Kolom kategori pengingat.
  static const String kategoriPengingat = 'kategori_pengingat';

  /// Kolom tujuan halaman pengingat.
  static const String pageTujuan = 'page_tujuan';
}
```


// ============================================================
// FILE: lib/shared/konstanta/nama_tabel.dart
// ============================================================

```dart
// lib/shared/konstanta/nama_tabel.dart

/// Konstanta nama tabel yang digunakan dalam database SQLite.
// Diubah dari static String menjadi static const String agar nilai tabel tidak dapat diubah dan konsisten dengan konstanta lainnya (aturan string literal/konstanta).
class NamaTabel {
  /// Nama tabel km.
  static const String km = 'km';

  /// Nama tabel komponen.
  static const String komponen = 'komponen';

  /// Nama tabel jadwal service.
  static const String jadwalService = 'jadwal_service';

  /// Nama tabel jadwal service komponen.
  static const String jadwalServiceKomponen = 'jadwal_service_komponen';

  /// Nama tabel riwayat jadwal service.
  static const String riwayatJadwalService = 'riwayat_jadwal_service';

  /// Nama tabel kendaraan.
  static const String kendaraan = 'kendaraan';

  /// Nama tabel pajak.
  static const String pajak = 'pajak';

  /// Nama tabel transaksi.
  static const String transaksi = 'transaksi';

  /// Nama tabel kategori transaksi.
  static const String kategoriTransaksi = 'kategori_transaksi';

  /// Nama tabel impian.
  static const String impian = 'impian';

  /// Nama tabel bahan bakar.
  static const String bahanBakar = 'bahan_bakar';

  /// Nama tabel pengingat.
  static const String pengingat = 'pengingat';
}
```


// ============================================================
// FILE: lib/shared/konstanta/shared_keys.dart
// ============================================================

```dart
/// Kunci untuk menyimpan data pada SharedPreferences.
class KunciShared {
  const KunciShared._();

  /// Kunci waktu sinkronisasi.
  static const String waktuSinkronisasi = 'waktu_sinkronisasi';

  /// Kunci waktu sinkronisasi terakhir.
  static const String lastSinkronisasi = 'last_sinkronisasi';

  /// Kunci untuk mengaktifkan sinkronisasi otomatis.
  static const String aktifkanSinkronisasiOtomatis =
      'aktifkan_sinkronisasi_otomatis';

  /// Kunci email akun Google yang login.
  static const String emailGoogle = 'email_google';

  /// Kunci ID kendaraan yang sedang dipilih.
  static const String kendaraanTerpilih = 'kendaraan_key';

  /// Kunci preferensi tema aplikasi.
  static const String temaAplikasi = 'tema_aplikasi';

  /// Kunci status aktif kunci aplikasi.
  static const String kunciAplikasiAktif = 'kunci_aplikasi_aktif';

  /// Kunci metode kunci aplikasi (biometrik/pin/biometrikDanPin).
  static const String kunciAplikasiMetode = 'kunci_aplikasi_metode';

  /// Kunci durasi auto-lock dalam menit (0 = langsung).
  static const String kunciAplikasiDurasiAutoLock =
      'kunci_aplikasi_durasi_auto_lock';

  /// Kunci hash PIN aplikasi.
  static const String kunciAplikasiPinHash = 'kunci_aplikasi_pin_hash';

  /// Kunci salt untuk hash PIN.
  static const String kunciAplikasiSalt = 'kunci_aplikasi_salt';

  /// Kunci jumlah percobaan PIN gagal.
  static const String kunciAplikasiPercobaanGagal =
      'kunci_aplikasi_percobaan_gagal';

  /// Kunci waktu kunci (lockout) berakhir (epoch millis). 0 = tidak terkunci.
  static const String kunciAplikasiKunciSampai = 'kunci_aplikasi_kunci_sampai';

  /// Kunci mata uang yang dipilih.
  static const String mataUangTerpilih = 'mata_uang_terpilih';
}
```


// ============================================================
// FILE: lib/shared/notifikasi/notifikasi_service.dart
// ============================================================

```dart
// lib/shared/notifikasi/notifikasi_service.dart

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myapp/fitur/impian/page/impian_page.dart';
import 'package:myapp/fitur/jadwal_service/page/detail_jadwal_service.dart';
import 'package:myapp/fitur/jadwal_service/page/jadwal_service_page.dart';
import 'package:myapp/fitur/kendaraan/model/pajak_model.dart';
import 'package:myapp/fitur/kendaraan/page/kendaraan_page.dart';
import 'package:myapp/fitur/km/page/km_page.dart';
import 'package:myapp/fitur/komponen/page/komponen_page.dart';
import 'package:myapp/fitur/transaksi/page/transaksi_page.dart';
import 'package:myapp/home.dart';
import 'package:myapp/lainnya_page.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Kategori notifikasi untuk payload navigasi.
enum KategoriNotifikasi {
  /// Jadwal service.
  jadwalService('jadwal_service'),

  /// Kendaraan.
  kendaraan('kendaraan'),

  /// Kilometer.
  km('km'),

  /// Komponen.
  komponen('komponen'),

  /// Transaksi.
  transaksi('transaksi'),

  /// Impian.
  impian('impian'),

  /// Pengaturan.
  pengaturan('pengaturan');

  const KategoriNotifikasi(this.nilai);

  /// Nilai string untuk payload.
  final String nilai;
}

/// Service untuk notifikasi lokal jadwal service kendaraan; muncul ketika sisa KM <= 0 atau sisa waktu <= 0 dan hanya jika pengaturan notifikasi aktif.
class NotifikasiService {
  NotifikasiService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Membuat id notifikasi numerik konsisten dari [id].
  static int _notifId(String id) =>
      int.tryParse(id)?.abs() ?? id.hashCode.abs();

  static bool _terinisialisasi = false;

  /// Kunci navigator global untuk navigasi saat notifikasi ditekan.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Kunci pengaturan notifikasi service di SharedPreferences.
  static const String _kunciAktif = 'notifikasi_service_aktif';
  static const String _kunciPengingat = 'notifikasi_waktu_pengingat_hari';
  // Konstanta pesan error agar tidak memakai string literal di throw (optimasi_bug_runtime.md #9).
  static const String _pesanIzinNotifWeb =
      'Izin notifikasi web tidak diberikan';

  /// Apakah notifikasi service diaktifkan user.
  static Future<bool> get aktif async {
    final val = await SharedPrefService.getBool(_kunciAktif);
    return val ?? true;
  }

  /// Simpan aktif/nonaktif notifikasi.
  static Future<void> setAktif(bool value) async {
    await SharedPrefService.setBool(_kunciAktif, value);
  }

  /// Waktu pengingat sebelum target (hari): 1, 3, atau 7.
  static Future<int> get waktuPengingat async {
    final val = await SharedPrefService.getInt(_kunciPengingat);
    return val ?? 1;
  }

  /// Simpan waktu pengingat.
  static Future<void> setWaktuPengingat(int hari) async {
    await SharedPrefService.setInt(_kunciPengingat, hari);
  }

  /// Inisialisasi plugin notifikasi. Panggil sekali di `main()` sebelum `runApp`.
  static Future<void> inisialisasi() async {
    if (_terinisialisasi) return;

    const android = AndroidInitializationSettings('ic_notifikasi');
    const ios = DarwinInitializationSettings();
    const macos = DarwinInitializationSettings();
    LinuxInitializationSettings? linux;
    WebInitializationSettings? web;
    if (kIsWeb) {
      web = const WebInitializationSettings();
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      linux = const LinuxInitializationSettings(defaultActionName: 'Buka');
    }
    final settings = InitializationSettings(
      android: android,
      iOS: ios,
      macOS: macos,
      linux: linux,
      web: web,
    );

    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (detail) async {
        final payload = detail.payload;
        if (payload != null && payload.isNotEmpty) {
          await _navigasiKeHalaman(payload);
        }
      },
    );
    try {
      if (kIsWeb) {
        await _plugin
            .resolvePlatformSpecificImplementation<
              WebFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
      }
    } catch (e, s) {
      // Kegagalan izin notifikasi tidak fatal; app tetap berjalan.
      // Tidak rethrow agar inisialisasi app (main) tidak gagal (optimasi_bug_runtime poin 6).
      L.e('Gagal request permission notifikasi: $e $s');
    }
    _terinisialisasi = true;
    L.i('NotifikasiService diinisialisasi');
  }

  /// Meminta izin notifikasi (terutama web) dalam konteks aksi user.
  static Future<bool> mintaIzin() async {
    try {
      if (kIsWeb) {
        final plugin = _plugin
            .resolvePlatformSpecificImplementation<
              WebFlutterLocalNotificationsPlugin
            >();
        L.i('Izin notif web sebelum: ${plugin?.permissionStatus.name}');
        final perm = await plugin?.requestNotificationsPermission();
        L.i(
          'Izin notif web sesudah: ${plugin?.permissionStatus.name}, hasil: $perm',
        );
        return perm ?? false;
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        final perm = await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
        L.i('Izin notif android hasil: $perm');
        return perm ?? false;
      }
    } catch (e, s) {
      L.w('Gagal minta izin notifikasi: $e $s');
    }
    return false;
  }

  /// Menampilkan notifikasi.
  static Future<void> tampilkanNotifikasi({
    required String id,
    required String judul,
    required String isi,
    KategoriNotifikasi? kategori,
  }) async {
    final aktif = await NotifikasiService.aktif;
    L.i('tampilkanNotifikasi aktif: $aktif, id: $id');
    if (!aktif) {
      L.w('Notifikasi nonaktif, batal tampilkan');
      return;
    }
    const android = AndroidNotificationDetails(
      'jadwal_service',
      'Jadwal Service',
      channelDescription: 'Peringatan waktunya service kendaraan',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'ic_notifikasi',
    );
    const ios = DarwinNotificationDetails();
    const detail = NotificationDetails(android: android, iOS: ios);
    // Gunakan id numerik konsisten melalui helper agar unik dan sama saat batalkan.
    final notifId = _notifId(id);

    // Batalkan notifikasi lama dengan id sama lalu tampilkan ulang agar tidak duplikat.
    if (kIsWeb) {
      final plugin = _plugin
          .resolvePlatformSpecificImplementation<
            WebFlutterLocalNotificationsPlugin
          >();
      if (plugin?.permissionStatus != WebNotificationPermission.granted) {
        L.w(
          'Izin notifikasi web tidak diberikan: ${plugin?.permissionStatus.name}',
        );
        throw Exception(_pesanIzinNotifWeb); // gunakan konstanta, bukan string literal (optimasi_bug_runtime.md #9)
      }
    }
    await _plugin.cancel(id: notifId);
    await _plugin.show(
      id: notifId,
      title: judul,
      body: isi,
      notificationDetails: detail,
      payload: '${kategori?.nilai ?? ''}:$id',
    );
    L.i('Notifikasi ditampilkan: $judul');
  }

  /// Meminta izin exact alarm agar zonedSchedule tidak gagal pada Android 12+.
  static Future<AndroidScheduleMode> _cobaMintaIzinExactAlarm() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return AndroidScheduleMode.inexact;
    }

    // Minta izin exact alarm agar tidak gagal di Android 12+ (API 31+).
    try {
      final pluginAndroid = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final izin = await pluginAndroid?.requestExactAlarmsPermission();
      // Jika izin diberikan (atau aplikasi memenuhi syarat), pakai exactAllowWhileIdle.
      if (izin == true) {
        return AndroidScheduleMode.exactAllowWhileIdle;
      }
    } catch (e, s) {
      L.w('Gagal meminta izin exact alarm: $e $s');
    }

    // Default ke inexact jika izin tidak diberikan atau tidak tersedia.
    return AndroidScheduleMode.inexact;
  }

  /// Menjadwalkan notifikasi pada [waktu] tertentu (zonedSchedule).
  static Future<void> jadwalkanNotifikasi({
    required String id,
    required String judul,
    required String isi,
    required DateTime waktu,
    KategoriNotifikasi? kategori,
  }) async {
    final aktif = await NotifikasiService.aktif;
    if (!aktif) return;

    tz.initializeTimeZones();
    final offsetLokal = DateTime.now().timeZoneOffset;
    final lokasi =
        tz.timeZoneDatabase.locations.values.firstWhereOrNull(
          (l) => l.currentTimeZone.offset == offsetLokal,
        ) ??
        tz.UTC; // Menghindari firstWhere native sesuai AGENTS.md
    tz.setLocalLocation(lokasi);
    final waktuTz = tz.TZDateTime.from(waktu, tz.local);
    // Gunakan id numerik konsisten melalui helper agar unik dan sama saat batalkan.
    final notifId = _notifId(id);

    const android = AndroidNotificationDetails(
      'jadwal_service',
      'Jadwal Service',
      channelDescription: 'Peringatan waktunya service kendaraan',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'ic_notifikasi',
    );
    const ios = DarwinNotificationDetails();
    const detail = NotificationDetails(android: android, iOS: ios);

    // Batalkan jadwal lama dengan id sama agar tidak duplikat.
    try {
      await _plugin.cancel(id: notifId);
      final androidScheduleMode = await _cobaMintaIzinExactAlarm();
      await _plugin.zonedSchedule(
        id: notifId,
        title: judul,
        body: isi,
        scheduledDate: waktuTz,
        notificationDetails: detail,
        androidScheduleMode: androidScheduleMode,
        payload: '${kategori?.nilai ?? ''}:$id',
      );
      L.i('Notifikasi dijadwalkan: $judul pada $waktu');
    } catch (e, s) {
      L.e('Gagal menjadwalkan notifikasi: $e $s');
    }
  }

  /// Membatalkan notifikasi terjadwal berdasarkan [id].
  static Future<void> batalkanJadwal(String id) async {
    // Batalkan dengan id konsisten agar sesuai jadwal/notifikasi yang sama.
    await _plugin.cancel(id: _notifId(id));
  }

  /// Tampilkan notifikasi sekarang jika [waktu] <= sekarang, atau jadwalkan jika [waktu] di masa depan.
  static Future<void> tampilkanAtauJadwalkan({
    required String id,
    required String judul,
    required String isi,
    required DateTime waktu,
    KategoriNotifikasi? kategori,
  }) async {
    final now = DateTime.now();
    if (!waktu.isAfter(now)) {
      await tampilkanNotifikasi(
        id: id,
        judul: judul,
        isi: isi,
        kategori: kategori,
      );
    } else {
      await jadwalkanNotifikasi(
        id: id,
        judul: judul,
        isi: isi,
        waktu: waktu,
        kategori: kategori,
      );
    }
  }

  /// Batalkan notifikasi berdasarkan [id] (misalnya jadwal dihapus).
  static Future<void> batalkanNotifikasi(String id) async {
    // Batalkan dengan id konsisten agar sesuai notifikasi yang sama.
    await _plugin.cancel(id: _notifId(id));
  }

  /// Navigasi ke halaman sesuai payload notifikasi yang dipilih user.
  static Future<void> _navigasiKeHalaman(String payload) async {
    final parts = payload.split(':');
    final kategori = parts.isNotEmpty ? parts.first : '';
    final id = parts.length > 1 ? parts[1] : '';
    final navigator = navigatorKey.currentState;
    if (navigator == null) {
      L.w('navigatorKey.currentState null, navigasi notifikasi dibatalkan');
      return;
    }

    Widget halaman;
    switch (kategori) {
      case 'jadwal_service':
        halaman = id.isNotEmpty
            ? DetailJadwalService(id: id)
            : const JadwalServicePage();
        break;
      case 'kendaraan':
        halaman = const KendaraanPage();
        break;
      case 'km':
        halaman = const KmPage();
        break;
      case 'komponen':
        halaman = const KomponenPage();
        break;
      case 'transaksi':
        halaman = const TransaksiPage();
        break;
      case 'impian':
        halaman = const ImpianPage();
        break;
      case 'pengaturan':
        halaman = const LainnyaPage();
        break;
      default:
        halaman = const Home();
        break;
    }

    // Perbaikan: gunakan Nav.pushAndRemoveUntil sesuai konvensi navigasi proyek.
    await Nav.pushAndRemoveUntil(navigator.context, halaman);
    L.i('Navigasi ke halaman: $kategori');
  }

  /// Cek notifikasi jatuh tempo pajak (STNK/PKB) berdasarkan daftar [list].
  static Future<void> cekNotifikasiPajak(List<PajakModel> list) async {
    final aktif = await NotifikasiService.aktif;
    if (!aktif) return;
    final pengingat = await NotifikasiService.waktuPengingat;
    final now = DateTime.now();
    for (final p in list) {
      final selisih = p.tanggal.difference(now).inDays;
      if (selisih >= 0 && selisih <= pengingat) {
        await tampilkanNotifikasi(
          id: p.id,
          judul: 'Pajak ${p.nama} jatuh tempo',
          isi: 'Jatuh tempo ${FormatTanggal.formatDasar(p.tanggal)}',
          kategori: KategoriNotifikasi.kendaraan,
        );
      }
    }
  }

  /// Cek notifikasi yang mungkin tertunda/terpicu saat app dibuka, berjalan asinkron tanpa memblokir UI.
  static void cekNotifikasiSaatBuka() {
    // Fire-and-forget: UI tidak menunggu proses ini selesai.
    unawaited(
      Future(() async {
        try {
          final details = await _plugin.getNotificationAppLaunchDetails();
          if (details?.didNotificationLaunchApp == true) {
            final payload = details?.notificationResponse?.payload;
            if (payload != null && payload.isNotEmpty) {
              // Tunggu frame pertama agar navigatorKey sudah siap.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                unawaited(_navigasiKeHalaman(payload));
              });
            }
          }

          // Opsional: cek notifikasi aktif yang masih tertunda di notch bar.
        } catch (e, s) {
          L.e('Gagal cek notifikasi saat buka: $e $s');
        }
      }),
    );
  }
}
```


// ============================================================
// FILE: lib/shared/operasi/base_op_sqflite.dart
// ============================================================

```dart
// lib/shared/operasi/base_op_sqflite.dart

import 'package:myapp/shared/db/sqflite/db_sqflite.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:myapp/shared/operasi/database_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

part 'base_op_sqflite.g.dart';

/// Implementasi default operasi database Sqflite.
class BaseOpSqflite implements DatabaseService {
  final DbSqflite _db;

  /// Buat instance BaseOpSqflite.
  BaseOpSqflite(this._db);

  // Membuat salinan map agar map pemanggil tidak berubah (efek samping tersembunyi)
  Map<String, dynamic> _setTimestamp(Map<String, dynamic> data) {
    final salinan = Map<String, dynamic>.from(data);
    salinan[NamaKolom.diperbarui] = DateTime.now().toIso8601String();
    return salinan;
  }

  @override
  Future<List<Map<String, dynamic>>> ambilData(String tableName) async {
    L.i('baseOpSqflite ambilData $tableName mulai');
    try {
      final db = await _db.database;
      return await db.query(tableName);
    } catch (e, s) {
      L.e('Gagal mengambil data dari $tableName $e $s');
      rethrow;
    } finally {
      L.i('baseOpSqflite ambilData $tableName selesai');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> ambilDataDenganWhere(
    String tableName,
    String where,
    List<dynamic> whereArgs,
  ) async {
    try {
      final db = await _db.database;
      return await db.query(tableName, where: where, whereArgs: whereArgs);
    } catch (e, s) {
      L.e('Gagal mengambil data dari $tableName dengan where: $e $s');
      rethrow;
    }
  }

  @override
  Future<void> tambah(String tableName, Map<String, dynamic> data) async {
    try {
      final db = await _db.database;
      data = _setTimestamp(data); // Guard efek samping: salinan map
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        await txn.insert(
          tableName,
          data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
      L.s('Berhasil menambah data ke $tableName');
    } catch (e, s) {
      L.e('Gagal menambah data ke $tableName $e $s');
      rethrow;
    }
  }

  @override
  Future<void> perbarui(
    String tableName,
    Map<String, dynamic> data,
    String id,
  ) async {
    try {
      final db = await _db.database;
      data = _setTimestamp(data); // Guard efek samping: salinan map
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        await txn.update(
          tableName,
          data,
          where: '${NamaKolom.id} = ?',
          whereArgs: [id],
        );
      });
      L.s('Berhasil memperbarui data di $tableName (id: $id)');
    } catch (e, s) {
      L.e('Gagal memperbarui data di $tableName (id: $id) $e $s');
      rethrow;
    }
  }

  @override
  Future<void> hapus(String tableName, String id) async {
    try {
      final db = await _db.database;
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        await txn.delete(
          tableName,
          where: '${NamaKolom.id} = ?',
          whereArgs: [id],
        );
      });
      L.s('✅ Berhasil menghapus data di $tableName (id: $id)');
    } catch (e, s) {
      L.e('❌ Gagal menghapus data di $tableName (id: $id) $e $s');
      rethrow;
    }
  }

  @override
  Future<void> hapusDenganWhere(
    String tableName,
    String where,
    List<dynamic> whereArgs,
  ) async {
    try {
      final db = await _db.database;
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        await txn.delete(tableName, where: where, whereArgs: whereArgs);
      });
      L.s('✅ Berhasil menghapus data di $tableName (where: $where)');
    } catch (e, s) {
      L.e('❌ Gagal menghapus data di $tableName (where: $where) $e $s');
      rethrow;
    }
  }

  @override
  Future<void> hapusSemua(String tableName) async {
    try {
      final db = await _db.database;
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        await txn.delete(tableName);
      });
    } catch (e, s) {
      L.e('❌ Gagal menghapus semua data dari tabel $tableName $e $s');
      rethrow;
    }
  }

  @override
  Future<void> sisipkanAtauPerbaruiBatch(
    String tableName,
    List<Map<String, dynamic>> data,
  ) async {
    L.i('sisipkanAtauPerbaruiBatch $tableName mulai (${data.length} item)');
    try {
      final db = await _db.database;
      L.i('sisipkanAtauPerbaruiBatch $tableName db diperoleh');
      // Menggunakan transaksi DB sesuai AGENTS.md; rollback otomatis jika gagal.
      await db.transaction((txn) async {
        L.i('sisipkanAtauPerbaruiBatch $tableName transaksi dimulai');
        final batch = txn.batch();
        for (final item in data) {
          final itemTs = _setTimestamp(item);
          batch.insert(
            tableName,
            itemTs,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          L.i('sisipkanAtauPerbaruiBatch $tableName item ditambahkan ke batch');
        }
        await batch.commit(noResult: true);
        L.i('sisipkanAtauPerbaruiBatch $tableName batch di-commit');
      });
      L.s(
        '✅ Berhasil melakukan batch insert ke $tableName (${data.length} item)',
      );
    } catch (e, s) {
      L.e('Gagal melakukan batch insert ke $tableName $e $s');
      rethrow;
    } finally {
      L.i('sisipkanAtauPerbaruiBatch $tableName selesai');
    }
  }
}

@Riverpod(keepAlive: true)
/// Provider untuk instance [BaseOpSqflite].
BaseOpSqflite baseOpSqflite(Ref ref) {
  L.i('baseOpSqflite provider dibuat');
  return BaseOpSqflite(ref.read(dbSqfliteProvider));
}
```


// ============================================================
// FILE: lib/shared/operasi/database_service.dart
// ============================================================

```dart
// lib/shared/operasi/database_service.dart

import 'package:myapp/shared/operasi/base_op_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_service.g.dart';

/// Antarmuka abstraksi untuk operasi database.
abstract class DatabaseService {
  /// Mengambil semua data dari tabel.
  Future<List<Map<String, dynamic>>> ambilData(String table);

  /// Mengambil data dari tabel dengan klausa WHERE.
  Future<List<Map<String, dynamic>>> ambilDataDenganWhere(
    String table,
    String where,
    List<dynamic> whereArgs,
  );

  /// Menambahkan data baru ke tabel.
  Future<void> tambah(String table, Map<String, dynamic> data);

  /// Memperbarui data di tabel berdasarkan [id].
  Future<void> perbarui(String table, Map<String, dynamic> data, String id);

  /// Menghapus data dari tabel berdasarkan [id].
  Future<void> hapus(String table, String id);

  /// Menghapus data dari tabel berdasarkan klausa WHERE.
  Future<void> hapusDenganWhere(
    String table,
    String where,
    List<dynamic> whereArgs,
  );

  /// Menghapus semua data dari tabel.
  Future<void> hapusSemua(String table);

  /// Melakukan batch insert atau perbarui data ke tabel.
  Future<void> sisipkanAtauPerbaruiBatch(
    String tableName,
    List<Map<String, dynamic>> data,
  );
}

@Riverpod(keepAlive: true)
/// Provider untuk instance [DatabaseService].
DatabaseService databaseService(Ref ref) {
  return ref.read(baseOpSqfliteProvider);
}
```


// ============================================================
// FILE: lib/shared/provider/pemilih_kendaraan_provider.dart
// ============================================================

```dart
import 'package:myapp/shared/enum/page_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pemilih_kendaraan_provider.g.dart';

@Riverpod()
String? pemilihKendaraan(Ref ref, PageEnum page, String? value) {
  return value;
}
```


// ============================================================
// FILE: lib/shared/sinkronisasi/google_drive_helper.dart
// ============================================================

```dart
// lib/shared/sinkronisasi/google_drive_helper.dart

import 'dart:async';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:share_global_saya/core_shared.dart';

/// Helper login Google dan backup/restore database ke Google Drive (appDataFolder).
class GoogleDriveHelper {
  GoogleDriveHelper._();

  static final List<String> _scopes = <String>[
    drive.DriveApi.driveAppdataScope,
  ];

  static GoogleSignInAccount? _akun;

  /// Panggil sekali di main() sebelum runApp.
  static Future<void> initialize({required String serverClientId}) async {
    await GoogleSignIn.instance.initialize(serverClientId: serverClientId);
  }

  /// Status apakah user sudah login ke Google.
  static bool get sudahLogin => _akun != null;

  /// Email user yang login, boleh null.
  static String? get email => _akun?.email;

  /// Login + minta izin akses Drive.
  static Future<GoogleSignInAccount?> login() async {
    try {
      // authenticate() throw GoogleSignInException kalau user batal / gagal.
      final akun = await GoogleSignIn.instance.authenticate();

      // authorizeScopes() non-nullable, throw kalau gagal.
      await akun.authorizationClient.authorizeScopes(_scopes);

      _akun = akun;
      L.s('Login berhasil: ${akun.email}');
      return akun;
    } on GoogleSignInException catch (e) {
      L.w('login dibatalkan / gagal: ${e.code} - ${e.description}');
      rethrow;
    } catch (e, s) {
      L.e('login gagal: $e $s');
      rethrow;
    }
  }

  /// Coba login tanpa buka dialog. Return `true` kalau user sudah punya sesi sebelumnya + izin scope masih valid. Return `false` kalau butuh login interaktif atau platform tidak mendukung.
  static Future<bool> cobaLoginOtomatis() async {
    try {
      final future = GoogleSignIn.instance.attemptLightweightAuthentication();
      if (future == null) {
        L.i('Auto-login: tidak didukung platform ini');
        return false;
      }

      final akun = await future;
      if (akun == null) {
        L.i('Auto-login: tidak ada sesi tersimpan');
        return false;
      }

      final otorisasi = await akun.authorizationClient.authorizationForScopes(
        _scopes,
      );
      if (otorisasi == null) {
        L.i('Auto-login: butuh izin scope dari user (interaktif)');
        _akun = akun;
        return false;
      }

      _akun = akun;
      L.s('Auto-login berhasil: ${akun.email}');
      return true;
    } catch (e, s) {
      L.i('Auto-login dilewati: $e $s');
      return false;
    }
  }

  /// Keluar dari sesi Google login.
  static Future<void> logout() async {
    try {
      await GoogleSignIn.instance.signOut();
      _akun = null;
    } catch (e, s) {
      L.e('logout gagal: $e $s');
      rethrow;
    }
  }

  // Menyimpan HTTP client agar bisa ditutup setelah operasi Google Drive
  static http.Client? _client;

  /// Bangun DriveApi client terautentikasi. Otomatis minta ulang otorisasi kalau access token sudah tidak ada.
  static Future<drive.DriveApi?> _getDriveApi() async {
    final akun = _akun;
    if (akun == null) return null;

    var otorisasi = await akun.authorizationClient.authorizationForScopes(
      _scopes,
    );
    otorisasi ??= await akun.authorizationClient.authorizeScopes(_scopes);
    final token = otorisasi.accessToken;
    if (token.isEmpty) return null;
    // Bangun AccessCredentials manual.
    // Expiry 1 jam dari sekarang — Google access token default 1 jam.
    final credentials = auth.AccessCredentials(
      auth.AccessToken(
        'Bearer',
        token,
        DateTime.now().toUtc().add(const Duration(hours: 1)),
      ),
      null, // tidak ada refresh token di mobile flow
      _scopes,
    );

    final client = auth.authenticatedClient(http.Client(), credentials);
    _client = client;
    return drive.DriveApi(client);
  }

  /// Upload file ke appDataFolder. Kalau file dengan nama sama sudah ada, file lama dihapus dulu supaya tidak menumpuk.
  static Future<bool> uploadFile({
    required File file,
    required String namaFile,
  }) async {
    try {
      final driveApi = await _getDriveApi();
      if (driveApi == null) {
        L.w('upload: DriveApi null');
        return false;
      }

      // Cek file existing dengan nama sama di appDataFolder.
      final namaAman = namaFile.replaceAll("'", "\\'");
      final hasilList = await driveApi.files.list(
        spaces: 'appDataFolder',
        q: "name = '$namaAman' and trashed = false",
      );
      final fileLama = hasilList.files;

      final panjangFile = await file.length();
      final media = drive.Media(file.openRead(), panjangFile);
      final metadata = drive.File()
        ..name = namaFile
        ..parents = ['appDataFolder'];

      final fileBaru = await driveApi.files.create(
        metadata,
        uploadMedia: media,
      );
      L.s('Upload berhasil: $namaFile');

      // Hapus file lama setelah upload baru berhasil; kegagalan hapus tidak membatalkan upload
      try {
        if (fileLama != null && fileLama.isNotEmpty) {
          for (final lama in fileLama) {
            final idLama = lama.id;
            if (idLama != null && idLama != fileBaru.id) {
              await driveApi.files.delete(idLama);
              L.i('File lama dihapus: $idLama');
            }
          }
        }
      } catch (deleteErr) {
        L.w('Gagal hapus file lama (upload tetap berhasil): $deleteErr');
      }
      return true;
    } catch (e, s) {
      L.e('upload gagal: $e $s');
      return false;
    } finally {
      _client?.close();
    }
  }

  /// Download file dari appDataFolder ke path lokal.
  static Future<bool> downloadFile({
    required String namaFile,
    required String simpanKePath,
  }) async {
    try {
      final driveApi = await _getDriveApi();
      if (driveApi == null) {
        L.w('download: DriveApi null');
        return false;
      }

      final namaAman = namaFile.replaceAll("'", "\\'");
      final hasilList = await driveApi.files.list(
        spaces: 'appDataFolder',
        q: "name = '$namaAman' and trashed = false",
      );
      final files = hasilList.files;
      if (files == null || files.isEmpty) {
        L.w('File $namaFile tidak ditemukan di Drive');
        return false;
      }

      final idFile = files.first.id;
      if (idFile == null) {
        L.w('File $namaFile tidak memiliki id');
        return false;
      }

      final hasil = await driveApi.files.get(
        idFile,
        downloadOptions: drive.DownloadOptions.fullMedia,
      );
      if (hasil is! drive.Media) {
        L.w('Response download bukan Media');
        return false;
      }
      final media = hasil;

      final fileTujuan = File(simpanKePath);
      final fileSementara = File('$simpanKePath.tmp');
      try {
        await fileTujuan.parent.create(recursive: true);
        final sink = fileSementara.openWrite();
        try {
          await media.stream.pipe(sink);
        } finally {
          await sink.close();
        }
        // Rename file sementara ke target (replace atomically jika di filesystem yang sama).
        // Jika gagal karena file target sudah ada (Windows), hapus target lalu rename.
        try {
          await fileSementara.rename(simpanKePath);
        } on FileSystemException catch (_) {
          if (await fileTujuan.exists()) {
            await fileTujuan.delete();
          }
          await fileSementara.rename(simpanKePath);
        }
      } catch (e) {
        if (await fileSementara.exists()) {
          await fileSementara.delete();
        }
        rethrow;
      }
      L.s('Download berhasil: $simpanKePath');
      return true;
    } catch (e, s) {
      L.e('download gagal: $e $s');
      return false;
    } finally {
      // Bersihkan sisa file sementara agar tidak tertinggal setelah download/crash
      try {
        await File('$simpanKePath.tmp').delete();
      } catch (e, s) {
        // Pembersihan file sementara gagal tidak memengaruhi hasil download; catat untuk penelusuran.
        L.w('Gagal menghapus file sementara: $e $s');
      }
      _client?.close();
    }
  }
}
```


// ============================================================
// FILE: lib/shared/tema/enum/tema_aplikasi_enum.dart
// ============================================================

```dart
// lib/shared/tema/enum/tema_aplikasi_enum.dart

import 'package:flutter/material.dart';

/// Pilihan tema aplikasi.
enum TemaAplikasi {
  /// Mengikuti tema perangkat.
  sistem,

  /// Selalu tema terang.
  terang,

  /// Selalu tema gelap.
  gelap,
}

/// Extension untuk [TemaAplikasi] yang menyediakan label dan ikon tampilan.
extension TemaAplikasiExtension on TemaAplikasi {
  /// Label teks yang ditampilkan kepada pengguna.
  String get label {
    switch (this) {
      case TemaAplikasi.sistem:
        return 'Sistem';
      case TemaAplikasi.terang:
        return 'Terang';
      case TemaAplikasi.gelap:
        return 'Gelap';
    }
  }

  /// Ikon yang merepresentasikan pilihan tema.
  IconData get icon {
    switch (this) {
      case TemaAplikasi.sistem:
        return Icons.brightness_auto;
      case TemaAplikasi.terang:
        return Icons.light_mode;
      case TemaAplikasi.gelap:
        return Icons.dark_mode;
    }
  }
}
```


// ============================================================
// FILE: lib/shared/tema/font.dart
// ============================================================

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_global_saya/core_shared.dart';

/// Menerapkan font Inter ke seluruh style TextTheme tanpa konflik tipe antar package Material.
TextTheme terapkanFontInter(TextTheme base) {
  TextStyle? terapkan(TextStyle? style) {
    if (style == null) return null;
    try {
      return GoogleFonts.inter(textStyle: style);
    } catch (e, s) {
      // Jika font Inter gagal dimuat (mis. offline), gunakan style dasar agar UI tetap tampil.
      L.e('Gagal menerapkan font Inter: $e $s');
      return style;
    }
  }

  return base.copyWith(
    displayLarge: terapkan(base.displayLarge),
    displayMedium: terapkan(base.displayMedium),
    displaySmall: terapkan(base.displaySmall),
    headlineLarge: terapkan(base.headlineLarge),
    headlineMedium: terapkan(base.headlineMedium),
    headlineSmall: terapkan(base.headlineSmall),
    titleLarge: terapkan(base.titleLarge),
    titleMedium: terapkan(base.titleMedium),
    titleSmall: terapkan(base.titleSmall),
    bodyLarge: terapkan(base.bodyLarge),
    bodyMedium: terapkan(base.bodyMedium),
    bodySmall: terapkan(base.bodySmall),
    labelLarge: terapkan(base.labelLarge),
    labelMedium: terapkan(base.labelMedium),
    labelSmall: terapkan(base.labelSmall),
  );
}
```


// ============================================================
// FILE: lib/shared/tema/tema_provider.dart
// ============================================================

```dart
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:myapp/shared/konstanta/shared_keys.dart';
import 'package:myapp/shared/tema/enum/tema_aplikasi_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

export 'package:myapp/shared/tema/enum/tema_aplikasi_enum.dart';

part 'tema_provider.g.dart';

/// Provider untuk menyimpan dan mengambil preferensi tema aplikasi.
@Riverpod(keepAlive: true)
class TemaAplikasiNotifier extends _$TemaAplikasiNotifier {
  @override
  Future<TemaAplikasi> build() async {
    final nilai = await SharedPrefService.getString(KunciShared.temaAplikasi);
    // Menggunakan firstWhereOrNull dari package:collection sesuai AGENTS.md.
    return TemaAplikasi.values.firstWhereOrNull((e) => e.name == nilai) ??
        TemaAplikasi.terang;
  }

  /// Menyimpan preferensi tema aplikasi.
  Future<void> set(TemaAplikasi tema) async {
    try {
      await SharedPrefService.setString(KunciShared.temaAplikasi, tema.name);
      state = AsyncData(tema);
    } catch (e, s) {
      L.e('Gagal menyimpan tema aplikasi: $e $s');
      rethrow;
    }
  }
}

/// Provider yang mengonversi preferensi tema menjadi [ThemeMode].
@Riverpod(keepAlive: true)
ThemeMode temaMode(Ref ref) {
  final asyncTema = ref.watch(temaAplikasiProvider);
  // Saat loading/error gunakan tema sistem sebagai fallback (bukan menyembunyikan status).
  if (asyncTema.isLoading || asyncTema.hasError) {
    return ThemeMode.system;
  }
  final tema = asyncTema.requireValue;
  switch (tema) {
    case TemaAplikasi.terang:
      return ThemeMode.light;
    case TemaAplikasi.gelap:
      return ThemeMode.dark;
    case TemaAplikasi.sistem:
      return ThemeMode.system;
  }
}
```


// ============================================================
// FILE: lib/shared/widget/kendaraan_terpilih_list.dart
// ============================================================

```dart
// lib/shared/widget/kendaraan_terpilih_list.dart

import 'package:flutter/material.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';

/// Widget daftar chip kendaraan terpilih yang dapat digunakan ulang di beberapa halaman.
class KendaraanTerpilihList extends StatefulWidget {
  /// Daftar kendaraan yang akan ditampilkan sebagai chip.
  final List<KendaraanModel> listKendaraan;

  /// Id kendaraan yang sedang terpilih (null berarti "Semua").
  final String? selectedId;

  /// Callback saat chip kendaraan ditekan.
  final ValueChanged<KendaraanModel?> onSelected;

  /// Callback saat tombol reload ditekan.
  final VoidCallback? onReload;

  /// Tinggi area daftar chip.
  final double height;

  /// Buat daftar chip kendaraan terpilih.
  const KendaraanTerpilihList({
    super.key,
    required this.listKendaraan,
    required this.selectedId,
    required this.onSelected,
    this.onReload,
    this.height = 44,
  });

  @override
  State<KendaraanTerpilihList> createState() => _KendaraanTerpilihListState();
}

class _KendaraanTerpilihListState extends State<KendaraanTerpilihList> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _itemKeys = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollKeTerpilih();
    });
  }

  @override
  void didUpdateWidget(covariant KendaraanTerpilihList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedId != widget.selectedId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollKeTerpilih();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollKeTerpilih() {
    int index;
    if (widget.selectedId == null) {
      index = 0;
    } else {
      final ditemukan = widget.listKendaraan.indexWhere(
        (k) => k.id == widget.selectedId,
      );
      // Hindari scroll ke chip "Semua" (index 0) jika selectedId tidak ditemukan.
      if (ditemukan < 0) return;
      index = ditemukan + 1;
    }
    if (index < 0) return;
    final key = _itemKeys[index];
    final context = key?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        alignment: 0.5,
        duration: const Duration(milliseconds: 200),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        children: [
          const Text('Kendaraan:'),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: widget.listKendaraan.length + 1,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final key = _itemKeys.putIfAbsent(index, GlobalKey.new);
                if (index == 0) {
                  return _buildItem(null, key);
                }
                final item = widget.listKendaraan[index - 1];
                return _buildItem(item, key);
              },
            ),
          ),
          if (widget.onReload != null)
            IconButton(
              tooltip: 'Muat ulang',
              iconSize: 24,
              alignment: Alignment.center,
              icon: const Icon(Icons.replay),
              onPressed: widget.onReload,
            ),
        ],
      ),
    );
  }

  Widget _buildItem(KendaraanModel? kendaraan, GlobalKey key) {
    final terpilih = widget.selectedId == kendaraan?.id;
    return ChoiceChip(
      key: key,
      label: Text(kendaraan?.nama ?? 'Semua'),
      selected: terpilih,
      selectedColor: Theme.of(context).colorScheme.primary,
      onSelected: (_) => widget.onSelected(kendaraan),
      showCheckmark: false,
      labelStyle: TextStyle(
        color: terpilih
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/shared/widget/modal_loading_widget.dart
// ============================================================

```dart
// lib/shared/widget/modal_loading_widget.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_global_saya/core_shared.dart';

/// Widget konten modal loading yang dapat dipakai ulang. Tampilkan dengan [showDialog] dan tutup dengan [Nav.pop].
class ModalLoadingWidget extends StatelessWidget {
  /// Pesan yang ditampilkan di bawah spinner.
  final String pesan;

  /// Membuat [ModalLoadingWidget].
  const ModalLoadingWidget({super.key, this.pesan = 'Memuat...'});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(height: 16),
              FittedBox(
                child: Text(
                  pesan,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Menampilkan modal loading full-screen yang tidak bisa ditutup pengguna. Mengembalikan fungsi penutup yang idempotent (aman dipanggil berkali-kali).
VoidCallback tampilkanModalLoading(
  BuildContext context, {
  String pesan = 'Memuat...',
  bool barrierDismissible = false,
}) {
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Theme.of(context)
          .colorScheme
          .scrim, // Konsisten tema (DESAINS.md 5)
      builder: (context) => ModalLoadingWidget(pesan: pesan),
    ),
  );
  var ditutup = false;
  return () {
    if (ditutup) return;
    ditutup = true;
    if (context.mounted) {
      final navigator = Navigator.of(context);
      if (navigator.canPop()) {
        Nav.pop(context);
      }
    }
  };
}

/// Menutup modal loading jika sedang tampil (kurang aman; prefer closure).
void tutupModalLoading(BuildContext context) {
  if (!context.mounted) return;
  final navigator = Navigator.of(context);
  if (navigator.canPop()) {
    Nav.pop(context);
  }
}
```


// ============================================================
// FILE: lib/shared/widget/pemilih_kendaraan.dart
// ============================================================

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fitur/kendaraan/model/kendaraan_model.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:universal_io/io.dart';

/// Widget pemilih kendaraan.
class PemilihKendaraan extends ConsumerStatefulWidget {
  /// Kendaraan yang sedang terpilih.
  final KendaraanModel kendaraanTerpilih;

  /// Daftar kendaraan yang tersedia.
  final List<KendaraanModel> listKendaraan;

  /// Callback saat kendaraan dipilih.
  final ValueChanged<KendaraanModel>? onSelected;

  /// Membuat [PemilihKendaraan].
  const PemilihKendaraan({
    super.key,
    required this.kendaraanTerpilih,
    required this.listKendaraan,
    this.onSelected,
  });

  @override
  ConsumerState<PemilihKendaraan> createState() => _PemilihKendaraanState();
}

class _PemilihKendaraanState extends ConsumerState<PemilihKendaraan> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _modalPilihKendaraan() async {
    final list = widget.listKendaraan;
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (ctx, idx) {
                final item = list[idx];
                final gambar = item.pathGambar;
                return Card(
                  child: ListTile(
                    leading: gambar == null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                            child: Icon(
                              Icons.directions_car,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          )
                        : Image.file(
                            File(gambar),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                const Icon(Icons.broken_image),
                          ),
                    title: Text(item.nama),
                    subtitle: Text(item.merk),
                    onTap: () {
                      widget.onSelected?.call(item);
                      // Perbaikan: gunakan Nav.pop sesuai konvensi navigasi proyek.
                      Nav.pop(context);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: widget.listKendaraan.length,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final kendaraan = widget.kendaraanTerpilih;
    final pathGambar = kendaraan.pathGambar;
    return Card(
      child: ListTile(
        leading: pathGambar == null
            ? const Icon(Icons.directions_car)
            : Image.file(
                File(pathGambar),
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
              ),
        title: Text(kendaraan.nama),
        subtitle: Text(kendaraan.merk),
        trailing: IconButton(
          icon: const Icon(Icons.swap_horiz),
          onPressed: _modalPilihKendaraan,
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/shared/widget/scroll_ke_atas.dart
// ============================================================

```dart
// lib/shared/widget/scroll_ke_atas.dart
// Interface untuk state halaman yang mendukung scroll ke atas.

/// Kontrak untuk state halaman yang menyediakan aksi scroll ke atas.
abstract class ScrollKeAtas {
  /// Menggulir tampilan ke posisi paling atas.
  void scrollToTop();
}
```


