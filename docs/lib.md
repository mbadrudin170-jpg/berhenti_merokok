// ============================================================
// FILE: lib/app.dart
// ============================================================

```dart
import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/fitur/tema/enum/tema_enum.dart';
import 'package:berhenti_merokok/fitur/tema/notifier/tema_notifier.dart';
import 'package:berhenti_merokok/home.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/shared/notifikasi/notifikasi_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart' as mui;
import 'package:share_global_saya/core_shared.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    L.init(ref.container);
    unawaited(
      NotifikasiService.jadwalkanUlangJikaAktif().catchError((
        Object error,
        StackTrace stackTrace,
      ) {
        L.e('Gagal menjadwalkan ulang notifikasi: $error $stackTrace');
      }),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final temaAsync = ref.watch(temaProvider);
    final tema = temaAsync.asData?.value ?? TemaEnum.sistem;

    final themeMode = switch (tema) {
      TemaEnum.terang => ThemeMode.light,
      TemaEnum.gelap => ThemeMode.dark,
      TemaEnum.sistem => ThemeMode.system,
    };

    final biodataAsync = ref.watch(biodataProvider);

    Widget home;
    if (biodataAsync.isLoading) {
      home = const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (biodataAsync.hasError) {
      home = Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gagal memuat data'),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  final _ = ref.refresh(biodataProvider);
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    } else {
      final biodata = biodataAsync.asData?.value;
      home = biodata == null
          ? const FormBiodata(buatPertama: true)
          : const Home();
    }

    final brightness = switch (themeMode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system =>
        WidgetsBinding.instance.platformDispatcher.platformBrightness,
    };
    final materialUiTheme = mui.ThemeData.from(
      colorScheme: mui.ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: brightness,
      ),
    );

    return mui.Theme(
      data: materialUiTheme,
      child: MaterialApp(
        navigatorKey: NotifikasiService.navigatorKey,
        title: 'Berhenti Merokok',
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        themeMode: themeMode,
        supportedLocales: const [Locale('id', 'ID')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          _MaterialUiLocalizationsDelegate(),
        ],
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        darkTheme: ThemeData(
          colorScheme: .fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
        ),
        home: PengelolaOverlayLogDebug(child: home),
      ),
    );
  }
}

// Delegate khusus untuk material_ui.MaterialLocalizations agar adaptive_dialog
// dapat memperoleh instance non-null pada locale 'id' (delegate bawaan
// material_ui hanya mendukung locale 'en').
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
```


// ============================================================
// FILE: lib/fitur/badge/helper/badge_helper.dart
// ============================================================

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_global_saya/core_shared.dart';

/// Representasi satu badge/pencapaian pengguna.
class BadgePencapaian {
  const BadgePencapaian({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.icon,
    required this.tercapai,
  });

  final String id;
  final String nama;
  final String deskripsi;
  final IconData icon;
  final bool tercapai;
}

/// Menghitung daftar badge berdasarkan progres smoke-free pengguna.
List<BadgePencapaian> hitungBadge({
  required int hariSmokeFree,
  required int rokokTidakDiHisap,
  required double uangDihemat,
  required int impianTercapai,
}) {
  L.i(
    'hariSmokeFree=$hariSmokeFree, rokokTidakDiHisap=$rokokTidakDiHisap, uangDihemat=$uangDihemat, impianTercapai=$impianTercapai',
  );
  final List<BadgePencapaian> daftar = <BadgePencapaian>[
    // Badge berbasis durasi smoke-free.
    BadgePencapaian(
      id: 'smoke_1',
      nama: 'Langkah Pertama',
      deskripsi: 'Berhasil berhenti merokok selama 1 hari.',
      icon: CupertinoIcons.flame,
      tercapai: hariSmokeFree >= 1,
    ),
    BadgePencapaian(
      id: 'smoke_3',
      nama: '3 Hari Kuat',
      deskripsi: 'Berhasil berhenti merokok selama 3 hari.',
      icon: CupertinoIcons.flame_fill,
      tercapai: hariSmokeFree >= 3,
    ),
    BadgePencapaian(
      id: 'smoke_7',
      nama: 'Satu Minggu',
      deskripsi: 'Berhasil berhenti merokok selama 7 hari.',
      icon: CupertinoIcons.star,
      tercapai: hariSmokeFree >= 7,
    ),
    BadgePencapaian(
      id: 'smoke_14',
      nama: 'Dua Minggu',
      deskripsi: 'Berhasil berhenti merokok selama 14 hari.',
      icon: CupertinoIcons.star_fill,
      tercapai: hariSmokeFree >= 14,
    ),
    BadgePencapaian(
      id: 'smoke_30',
      nama: 'Satu Bulan',
      deskripsi: 'Berhasil berhenti merokok selama 30 hari.',
      icon: Icons.workspace_premium,
      tercapai: hariSmokeFree >= 30,
    ),
    BadgePencapaian(
      id: 'smoke_90',
      nama: 'Tiga Bulan',
      deskripsi: 'Berhasil berhenti merokok selama 90 hari.',
      icon: CupertinoIcons.rosette,
      tercapai: hariSmokeFree >= 90,
    ),
    BadgePencapaian(
      id: 'smoke_180',
      nama: 'Enam Bulan',
      deskripsi: 'Berhasil berhenti merokok selama 180 hari.',
      icon: CupertinoIcons.rosette,
      tercapai: hariSmokeFree >= 180,
    ),
    BadgePencapaian(
      id: 'smoke_365',
      nama: 'Satu Tahun',
      deskripsi: 'Berhasil berhenti merokok selama 1 tahun.',
      icon: Icons.emoji_events,
      tercapai: hariSmokeFree >= 365,
    ),
    // Badge berbasis rokok tidak dihisap.
    BadgePencapaian(
      id: 'rokok_100',
      nama: '100 Batang Terhindar',
      deskripsi: 'Berhasil menghindari 100 batang rokok.',
      icon: CupertinoIcons.nosign,
      tercapai: rokokTidakDiHisap >= 100,
    ),
    BadgePencapaian(
      id: 'rokok_500',
      nama: '500 Batang Terhindar',
      deskripsi: 'Berhasil menghindari 500 batang rokok.',
      icon: CupertinoIcons.nosign,
      tercapai: rokokTidakDiHisap >= 500,
    ),
    BadgePencapaian(
      id: 'rokok_1000',
      nama: '1000 Batang Terhindar',
      deskripsi: 'Berhasil menghindari 1000 batang rokok.',
      icon: CupertinoIcons.shield,
      tercapai: rokokTidakDiHisap >= 1000,
    ),
    // Badge berbasis uang dihemat.
    BadgePencapaian(
      id: 'uang_100k',
      nama: 'Tabungan 100 Ribu',
      deskripsi: 'Berhasil menghemat Rp100.000 dari tidak merokok.',
      icon: CupertinoIcons.money_dollar,
      tercapai: uangDihemat >= 100000,
    ),
    BadgePencapaian(
      id: 'uang_500k',
      nama: 'Tabungan 500 Ribu',
      deskripsi: 'Berhasil menghemat Rp500.000 dari tidak merokok.',
      icon: CupertinoIcons.money_dollar,
      tercapai: uangDihemat >= 500000,
    ),
    BadgePencapaian(
      id: 'uang_1jt',
      nama: 'Tabungan 1 Juta',
      deskripsi: 'Berhasil menghemat Rp1.000.000 dari tidak merokok.',
      icon: CupertinoIcons.money_dollar_circle,
      tercapai: uangDihemat >= 1000000,
    ),
    // Badge berbasis impian tercapai.
    BadgePencapaian(
      id: 'impian_1',
      nama: 'Impian Pertama Tercapai',
      deskripsi: 'Berhasil mencapai 1 impian.',
      icon: CupertinoIcons.heart,
      tercapai: impianTercapai >= 1,
    ),
    BadgePencapaian(
      id: 'impian_3',
      nama: '3 Impian Tercapai',
      deskripsi: 'Berhasil mencapai 3 impian.',
      icon: CupertinoIcons.heart_fill,
      tercapai: impianTercapai >= 3,
    ),
  ];
  L.i('daftar.length=${daftar.length}');
  return daftar;
}
```


// ============================================================
// FILE: lib/fitur/badge/screens/badge_screen.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/badge/helper/badge_helper.dart';
import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class BadgeScreen extends ConsumerStatefulWidget {
  const BadgeScreen({super.key});

  @override
  ConsumerState<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends ConsumerState<BadgeScreen> {
  @override
  void initState() {
    super.initState();
    L.i('BadgeScreen initState');
  }

  @override
  void dispose() {
    L.i('BadgeScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    final impianAsync = ref.watch(impianProvider);
    L.i('biodataAsync=$biodataAsync, impianAsync=$impianAsync');

    if (biodataAsync.isLoading || impianAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      L.e(
        'biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}',
      );
      return Scaffold(
        appBar: AppBar(title: const Text('Pencapaian')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const Text('Gagal memuat data'),
                  OutlinedButton(
                    onPressed: () {
                      final _ = ref.refresh(biodataProvider);
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (impianAsync.hasError) {
      L.e('impianAsync error: ${impianAsync.error} ${impianAsync.stackTrace}');
      return Scaffold(
        appBar: AppBar(title: const Text('Pencapaian')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const Text('Gagal memuat data impian'),
                  OutlinedButton(
                    onPressed: () {
                      final _ = ref.refresh(impianProvider);
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final biodata = biodataAsync.requireValue;
    final impianState = impianAsync.requireValue;
    L.i('biodata=$biodata');

    if (biodata == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Pencapaian')),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Lengkapi biodata terlebih dahulu untuk melihat pencapaian.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }

    // Hitung progres smoke-free.
    final hariSmokeFree = biodata.hariBerhenti;
    final rokokTidakDiHisap = biodata.rokokTidakDiHisap;
    final uangDihemat = biodata.uangDihemat;

    // Hitung impian tercapai.
    int impianTercapai = 0;
    for (final impian in impianState.listImpian) {
      if (uangDihemat >= impian.jumlah) {
        impianTercapai++;
      }
    }
    L.i(
      'hariSmokeFree=$hariSmokeFree, rokokTidakDiHisap=$rokokTidakDiHisap, uangDihemat=$uangDihemat, impianTercapai=$impianTercapai',
    );

    final daftarBadge = hitungBadge(
      hariSmokeFree: hariSmokeFree,
      rokokTidakDiHisap: rokokTidakDiHisap,
      uangDihemat: uangDihemat,
      impianTercapai: impianTercapai,
    );
    final jumlahTercapai = daftarBadge.where((b) => b.tercapai).length;
    L.i('jumlahTercapai=$jumlahTercapai/${daftarBadge.length}');

    return Scaffold(
      appBar: AppBar(title: const Text('Pencapaian')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                '$jumlahTercapai dari ${daftarBadge.length} badge tercapai',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: daftarBadge.length,
                  itemBuilder: (context, index) {
                    final badge = daftarBadge[index];
                    return _BadgeCard(key: ValueKey(badge.id), badge: badge);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({super.key, required this.badge});

  final BadgePencapaian badge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tercapai = badge.tercapai;
    return Card(
      color: tercapai
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Icon(
              badge.icon,
              size: 32,
              color: tercapai
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            Text(
              badge.nama,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: tercapai
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              badge.deskripsi,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: tercapai
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
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
// FILE: lib/fitur/biodata/enum/mode_berhenti.dart
// ============================================================

```dart
import 'package:share_global_saya/core_shared.dart';

/// Mode berhenti merokok: seketika atau bertahap (tapering).
enum ModeBerhenti { seketika, bertahap }

/// Extension yang menyediakan label untuk [ModeBerhenti].
extension ModeBerhentiExtension on ModeBerhenti {
  String get label {
    L.i('mode=$this');
    switch (this) {
      case ModeBerhenti.seketika:
        return 'Seketika';
      case ModeBerhenti.bertahap:
        return 'Bertahap (tapering)';
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/biodata/model/biodata_model.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/biodata/enum/mode_berhenti.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'biodata_model.freezed.dart';

@freezed
abstract class BiodataModel with _$BiodataModel {
  const BiodataModel._();

  const factory BiodataModel({
    required String id,
    required String nama,
    DateTime? tanggalLahir,
    @Default(10) int jumlahRokokPerHari,
    @Default(0.0) double hargaRokokPerBungkus,
    @Default(20.0) double batangPerBungkus,
    DateTime? tanggalMulaiMerokok,
    DateTime? tanggalMulaiBerhentiMerokok,
    @Default(ModeBerhenti.seketika) ModeBerhenti modeBerhenti,
    @Default(0) int penurunanPerMinggu,
    DateTime? tanggalMulaiTapering,
  }) = _BiodataModel;

  /// Membuat [BiodataModel] dari baris database SQLite.
  factory BiodataModel.fromSqflite(Map<String, Object?> row) {
    L.i('row=$row');
    return BiodataModel(
      id: ParserUtil.parseString(row[NamaKolom.id]),
      nama: ParserUtil.parseString(row[NamaKolom.nama]),
      tanggalLahir: ParserUtil.parseDateTime(row[NamaKolom.tanggalLahir])
          ?.toLocal(),
      jumlahRokokPerHari: ParserUtil.parseInt(
        row[NamaKolom.jumlahRokokPerHari],
        defaultValue: 10,
      ),
      hargaRokokPerBungkus: ParserUtil.parseDouble(
        row[NamaKolom.hargaRokokPerBungkus],
      ),
      batangPerBungkus: ParserUtil.parseDouble(
        row[NamaKolom.batangPerBungkus],
        defaultValue: 20.0,
      ),
      tanggalMulaiMerokok: ParserUtil.parseDateTime(
        row[NamaKolom.tanggalMulaiMerokok],
      )?.toLocal(),
      tanggalMulaiBerhentiMerokok: ParserUtil.parseDateTime(
        row[NamaKolom.tanggalMulaiBerhentiMerokok],
      )?.toLocal(),
      modeBerhenti:
          ParserUtil.safeParseEnum(
            ModeBerhenti.values,
            ParserUtil.parseString(row[NamaKolom.modeBerhenti]),
          ) ??
          ModeBerhenti.seketika,
      penurunanPerMinggu: ParserUtil.parseInt(
        row[NamaKolom.penurunanPerMinggu],
      ),
      tanggalMulaiTapering: ParserUtil.parseDateTime(
        row[NamaKolom.tanggalMulaiTapering],
      )?.toLocal(),
    );
  }

  /// Mengonversi [BiodataModel] menjadi Map untuk disimpan ke SQLite.
  Map<String, Object?> toSqflite() {
    return <String, Object?>{
      NamaKolom.id: id,
      NamaKolom.nama: nama,
      NamaKolom.tanggalLahir: tanggalLahir?.toUtc().toIso8601String(),
      NamaKolom.jumlahRokokPerHari: jumlahRokokPerHari,
      NamaKolom.hargaRokokPerBungkus: hargaRokokPerBungkus,
      NamaKolom.batangPerBungkus: batangPerBungkus,
      NamaKolom.tanggalMulaiMerokok: tanggalMulaiMerokok
          ?.toUtc()
          .toIso8601String(),
      NamaKolom.tanggalMulaiBerhentiMerokok: tanggalMulaiBerhentiMerokok
          ?.toUtc()
          .toIso8601String(),
      NamaKolom.modeBerhenti: modeBerhenti.name,
      NamaKolom.penurunanPerMinggu: penurunanPerMinggu,
      NamaKolom.tanggalMulaiTapering: tanggalMulaiTapering
          ?.toUtc()
          .toIso8601String(),
    };
  }
}

/// Ekstensi perhitungan turunan dari [BiodataModel] agar logika `hariBerhenti`, `rokokTidakDiHisap`, dan `uangDihemat` hanya ditulis sekali dan konsisten di seluruh halaman (dashboard, impian, badge).
extension BiodataModelPerhitungan on BiodataModel {
  /// Hari smoke-free, dinormalisasi agar tidak terpengaruh komponen waktu.
  int get hariBerhenti {
    final tanggalBerhenti = tanggalMulaiBerhentiMerokok;
    if (tanggalBerhenti == null) return 0;
    final sekarang = DateTime.now();
    final hariIniDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final tanggalBerhentiDate = DateTime(
      tanggalBerhenti.year,
      tanggalBerhenti.month,
      tanggalBerhenti.day,
    );
    final hari = hariIniDate.difference(tanggalBerhentiDate).inDays;
    return hari < 0 ? 0 : hari;
  }

  /// Jumlah rokok yang tidak dihisap selama periode smoke-free.
  int get rokokTidakDiHisap => jumlahRokokPerHari * hariBerhenti;

  /// Uang yang dihemat dari tidak merokok.
  double get uangDihemat {
    if (batangPerBungkus == 0) return 0;
    return (rokokTidakDiHisap / batangPerBungkus) * hargaRokokPerBungkus;
  }

  /// Apakah pengguna menggunakan mode berhenti bertahap (tapering).
  bool get sedangTapering => modeBerhenti == ModeBerhenti.bertahap;

  /// Target jumlah rokok per hari saat ini untuk mode tapering.
  ///
  /// Dihitung dari [jumlahRokokPerHari] dikurangi penurunan kumulatif
  /// berdasarkan minggu yang telah berlalu sejak [tanggalMulaiTapering].
  int get targetRokokHariIni {
    L.i('sedangTapering=$sedangTapering');
    if (!sedangTapering) return jumlahRokokPerHari;
    final mulai = tanggalMulaiTapering ?? DateTime.now();
    final sekarang = DateTime.now();
    final mulaiDate = DateTime(mulai.year, mulai.month, mulai.day);
    final sekarangDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final hariBerlalu = sekarangDate.difference(mulaiDate).inDays;
    final mingguBerlalu = hariBerlalu < 0 ? 0 : hariBerlalu ~/ 7;
    final penurunan = penurunanPerMinggu * mingguBerlalu;
    final target = jumlahRokokPerHari - penurunan;
    L.i(
      'mulai=$mulai, hariBerlalu=$hariBerlalu, mingguBerlalu=$mingguBerlalu, '
      'penurunan=$penurunan, target=$target',
    );
    if (target < 0) return 0;
    if (target > jumlahRokokPerHari) return jumlahRokokPerHari;
    return target;
  }
}
```


// ============================================================
// FILE: lib/fitur/biodata/notifier/biodata_notifier.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

part 'biodata_notifier.g.dart';

@riverpod
class BiodataNotifier extends _$BiodataNotifier {
  @override
  Future<BiodataModel?> build() async {
    return await _ambilData();
  }

  Future<BiodataModel?> _ambilData() async {
    try {
      final op = const SqfliteOp();
      final row = await op.ambilSatu(NamaTabel.biodata);
      L.i('row=$row');
      if (row == null) {
        return null;
      }
      return BiodataModel.fromSqflite(row);
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data biodata: $e $s');
      rethrow;
    }
  }

  Future<void> simpan(BiodataModel biodata) async {
    L.i('biodata.id=${biodata.id}, biodata.nama=${biodata.nama}');
    try {
      final existing = await future;
      L.i('existing=${existing?.id}');
      final model = biodata.id.isEmpty
          ? biodata.copyWith(id: existing?.id ?? const Uuid().v4())
          : biodata;
      L.i('model.id=${model.id}');
      final op = const SqfliteOp();
      await op.tambah(
        NamaTabel.biodata,
        model.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      state = AsyncValue.data(model);
      L.s('Biodata berhasil disimpan');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan biodata: $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/biodata/screens/biodata_screen.dart
// ============================================================

```dart
import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/enum/mode_berhenti.dart';
import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class BiodataScreen extends ConsumerStatefulWidget {
  const BiodataScreen({super.key});

  @override
  ConsumerState<BiodataScreen> createState() => _BiodataScreenState();
}

class _BiodataScreenState extends ConsumerState<BiodataScreen> {
  @override
  void initState() {
    super.initState();
    L.i('BiodataScreen initState');
  }

  @override
  void dispose() {
    L.i('BiodataScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    L.i('biodataAsync=$biodataAsync');

    if (biodataAsync.isLoading) {
      L.w('biodataAsync loading');
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      L.e(
        'biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}',
      );
      return Scaffold(
        appBar: AppBar(title: const Text('Biodata')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gagal memuat data'),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  final _ = ref.refresh(biodataProvider);
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final biodata = biodataAsync.requireValue;
    L.i('biodata=$biodata');

    // Salin field nullable ke variabel lokal agar type promotion berlaku
    // (menghindari penggunaan operator `!`).
    final tanggalLahir = biodata?.tanggalLahir;
    final tanggalMulaiMerokok = biodata?.tanggalMulaiMerokok;
    final tanggalMulaiBerhentiMerokok = biodata?.tanggalMulaiBerhentiMerokok;
    final tanggalMulaiTapering = biodata?.tanggalMulaiTapering;
    L.i(
      'tanggalLahir=$tanggalLahir, tanggalMulaiMerokok=$tanggalMulaiMerokok, '
      'tanggalMulaiBerhentiMerokok=$tanggalMulaiBerhentiMerokok, '
      'tanggalMulaiTapering=$tanggalMulaiTapering',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Biodata')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: biodata == null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12,
                    children: [
                      const Text('Belum ada data biodata'),
                      OutlinedButton(
                        onPressed: () => unawaited(
                          Nav.to(
                            context,
                            const FormBiodata(buatPertama: false),
                          ).catchError((Object e, StackTrace s) {
                            L.e('Gagal navigasi ke Form Biodata: $e $s');
                            return null;
                          }),
                        ),
                        child: const Text('Isi Biodata'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 12,
                    children: [
                      _buildItem('Nama', biodata.nama),
                      _buildItem(
                        'Tanggal lahir',
                        tanggalLahir == null
                            ? 'Belum dipilih'
                            : FormatTanggal.formatDasar(tanggalLahir),
                      ),
                      _buildItem(
                        'Jumlah rokok per hari',
                        biodata.jumlahRokokPerHari.toString(),
                      ),
                      _buildItem(
                        'Harga rokok per bungkus',
                        biodata.hargaRokokPerBungkus.toString(),
                      ),
                      _buildItem(
                        'Batang per bungkus',
                        biodata.batangPerBungkus.toString(),
                      ),
                      _buildItem(
                        'Tanggal mulai merokok',
                        tanggalMulaiMerokok == null
                            ? 'Belum dipilih'
                            : FormatTanggal.formatDasar(tanggalMulaiMerokok),
                      ),
                      _buildItem(
                        'Tanggal mulai berhenti merokok',
                        tanggalMulaiBerhentiMerokok == null
                            ? 'Belum dipilih'
                            : FormatTanggal.formatDasar(
                                tanggalMulaiBerhentiMerokok,
                              ),
                      ),
                      _buildItem('Mode berhenti', biodata.modeBerhenti.label),
                      _buildItem(
                        'Penurunan per minggu',
                        biodata.penurunanPerMinggu.toString(),
                      ),
                      _buildItem(
                        'Target rokok per hari (saat ini)',
                        biodata.targetRokokHariIni.toString(),
                      ),
                      _buildItem(
                        'Tanggal mulai penurunan',
                        tanggalMulaiTapering == null
                            ? 'Belum dipilih'
                            : FormatTanggal.formatDasar(tanggalMulaiTapering),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () => unawaited(
                          Nav.to(
                            context,
                            FormBiodata(
                              buatPertama: false,
                              biodataModel: biodata,
                            ),
                          ).catchError((Object e, StackTrace s) {
                            L.e('Gagal navigasi ke Form Biodata: $e $s');
                            return null;
                          }),
                        ),
                        child: const Text('Ubah Biodata'),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildItem(String label, String nilai) {
    L.i('label=$label, nilai=$nilai');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(nilai, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/biodata/screens/form_biodata.dart
// ============================================================

```dart
import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/biodata/enum/mode_berhenti.dart';
import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class FormBiodata extends ConsumerStatefulWidget {
  final bool buatPertama;
  final BiodataModel? biodataModel;
  const FormBiodata({super.key, required this.buatPertama, this.biodataModel});

  @override
  ConsumerState<FormBiodata> createState() => _BiodataScreenState();
}

class _BiodataScreenState extends ConsumerState<FormBiodata> {
  final _namaController = TextEditingController();
  final _jumlahRokokController = TextEditingController();
  final _hargaRokokController = TextEditingController();
  final _batangPerBungkusController = TextEditingController();
  final _penurunanPerMingguController = TextEditingController();

  final _namaFocusNode = FocusNode();
  final _jumlahRokokFocusNode = FocusNode();
  final _hargaRokokFocusNode = FocusNode();
  final _batangPerBungkusFocusNode = FocusNode();
  final _penurunanPerMingguFocusNode = FocusNode();

  DateTime? _tanggalLahir;
  DateTime? _tanggalMulaiMerokok;
  DateTime? _tanggalMulaiBerhentiMerokok;
  DateTime? _tanggalMulaiTapering;

  ModeBerhenti _modeBerhenti = ModeBerhenti.seketika;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _sudahDiisi = false;

  ProviderSubscription<AsyncValue<BiodataModel?>>? _biodataSubscription;

  @override
  void initState() {
    super.initState();
    L.i('FormBiodata initState, buatPertama=${widget.buatPertama}');
    final modelAwal = widget.biodataModel;
    if (modelAwal != null) {
      _isiDariModel(modelAwal);
    }
    _biodataSubscription = ref.listenManual(biodataProvider, (previous, next) {
      next.whenData((biodata) {
        if (biodata != null && !_sudahDiisi && mounted) {
          _isiDariModel(biodata);
        }
      });
    });
  }

  void _isiDariModel(BiodataModel model) {
    _sudahDiisi = true;
    _namaController.text = model.nama;
    _jumlahRokokController.text = model.jumlahRokokPerHari.toString();
    _hargaRokokController.text = model.hargaRokokPerBungkus.toString();
    _batangPerBungkusController.text = model.batangPerBungkus.toString();
    _tanggalLahir = model.tanggalLahir;
    _tanggalMulaiMerokok = model.tanggalMulaiMerokok;
    _tanggalMulaiBerhentiMerokok = model.tanggalMulaiBerhentiMerokok;
    _modeBerhenti = model.modeBerhenti;
    _penurunanPerMingguController.text = model.penurunanPerMinggu.toString();
    _tanggalMulaiTapering = model.tanggalMulaiTapering;
    L.i(
      'modeBerhenti=$_modeBerhenti, '
      'penurunanPerMinggu=${_penurunanPerMingguController.text}, '
      'tanggalMulaiTapering=$_tanggalMulaiTapering',
    );
  }

  @override
  void dispose() {
    _biodataSubscription?.close();
    _namaController.dispose();
    _jumlahRokokController.dispose();
    _hargaRokokController.dispose();
    _batangPerBungkusController.dispose();
    _penurunanPerMingguController.dispose();
    _namaFocusNode.dispose();
    _jumlahRokokFocusNode.dispose();
    _hargaRokokFocusNode.dispose();
    _batangPerBungkusFocusNode.dispose();
    _penurunanPerMingguFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggalLahir() async {
    final awal = _tanggalLahir ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() => _tanggalLahir = picked);
    }
  }

  Future<void> _pilihTanggalMulaiMerokok() async {
    final awal = _tanggalMulaiMerokok ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() => _tanggalMulaiMerokok = picked);
    }
  }

  Future<void> _pilihTanggalMulaiBerhentiMerokok() async {
    final awal = _tanggalMulaiBerhentiMerokok ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() => _tanggalMulaiBerhentiMerokok = picked);
    }
  }

  Future<void> _pilihTanggalMulaiTapering() async {
    final awal = _tanggalMulaiTapering ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && mounted) {
      L.i('tanggalMulaiTapering=$picked');
      setState(() => _tanggalMulaiTapering = picked);
    }
  }

  Future<void> _simpan() async {
    if (_isLoading) {
      L.w('Form biodata masih loading, simpan diabaikan');
      return;
    }
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Simpan Biodata',
      message: 'Apakah Anda yakin ingin menyimpan data biodata ini?',
      okLabel: 'Simpan',
      cancelLabel: 'Batal',
    );
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!mounted) return;
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    if (_modeBerhenti == ModeBerhenti.bertahap &&
        _tanggalMulaiTapering == null) {
      AppToast.gagal(context, 'Tanggal mulai penurunan wajib dipilih');
      return;
    }
    setState(() => _isLoading = true);
    unawaited(
      EasyLoading.show(
        status: 'Menyimpan...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
        return null;
      }),
    );
    try {
      final model = BiodataModel(
        id: widget.biodataModel?.id ?? '',
        nama: _namaController.text.trim(),
        tanggalLahir: _tanggalLahir,
        jumlahRokokPerHari:
            int.tryParse(_jumlahRokokController.text.trim()) ?? 0,
        hargaRokokPerBungkus: _hargaRokokController.text.trim().isEmpty
            ? 0.0
            : InputRupiah.parse(_hargaRokokController.text),
        batangPerBungkus:
            double.tryParse(_batangPerBungkusController.text.trim()) ?? 20.0,
        tanggalMulaiMerokok: _tanggalMulaiMerokok,
        tanggalMulaiBerhentiMerokok: _tanggalMulaiBerhentiMerokok,
        modeBerhenti: _modeBerhenti,
        penurunanPerMinggu: int.parse(
          _penurunanPerMingguController.text.trim().replaceAll(
            RegExp(r'[^0-9]'),
            '',
          ),
        ),
        tanggalMulaiTapering: _tanggalMulaiTapering,
      );
      L.i('model=$model');
      await ref.read(biodataProvider.notifier).simpan(model);
      if (!mounted) return;
      if (widget.buatPertama) {
        unawaited(
          Nav.pushAndRemoveUntil(context, const Home()).catchError((
            Object e,
            StackTrace s,
          ) {
            L.e('Gagal navigasi ke Home: $e $s');
            return null;
          }),
        );
      } else if (Navigator.of(context).canPop()) {
        Nav.pop(context);
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan biodata: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan biodata');
      }
    } finally {
      if (mounted) {
        unawaited(
          EasyLoading.dismiss().catchError((Object e, StackTrace s) {
            L.e('Gagal menutup loading: $e $s');
            return null;
          }),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);

    if (biodataAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Biodata')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gagal memuat data'),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  final _ = ref.refresh(biodataProvider);
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Biodata')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                InputTeks(
                  controller: _namaController,
                  label: 'Nama',
                  hintText: 'Masukkan nama',
                  focusNode: _namaFocusNode,
                  nextFocusNode: _jumlahRokokFocusNode,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama wajib diisi';
                    }
                    return null;
                  },
                ),
                InputAngka(
                  controller: _jumlahRokokController,
                  label: 'Jumlah rokok per hari',
                  hintText: 'Masukkan jumlah rokok per hari',
                  focusNode: _jumlahRokokFocusNode,
                  nextFocusNode: _hargaRokokFocusNode,
                ),
                InputRupiah(
                  controller: _hargaRokokController,
                  label: 'Harga rokok per bungkus',
                  hintText: 'Masukkan harga rokok per bungkus',
                  focusNode: _hargaRokokFocusNode,
                ),
                InputAngka(
                  controller: _batangPerBungkusController,
                  label: 'Batang per bungkus',
                  hintText: 'Masukkan jumlah batang per bungkus',
                  focusNode: _batangPerBungkusFocusNode,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.cake_outlined),
                  title: const Text('Tanggal lahir'),
                  subtitle: Text(
                    _tanggalLahir == null
                        ? 'Belum dipilih'
                        : FormatTanggal.formatDasar(_tanggalLahir!),
                  ),
                  trailing: TextButton(
                    onPressed: _pilihTanggalLahir,
                    child: const Text('Pilih'),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.smoking_rooms_outlined),
                  title: const Text('Tanggal mulai merokok'),
                  subtitle: Text(
                    _tanggalMulaiMerokok == null
                        ? 'Belum dipilih'
                        : FormatTanggal.formatDasar(_tanggalMulaiMerokok!),
                  ),
                  trailing: TextButton(
                    onPressed: _pilihTanggalMulaiMerokok,
                    child: const Text('Pilih'),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_available_outlined),
                  title: const Text('Tanggal mulai berhenti merokok'),
                  subtitle: Text(
                    _tanggalMulaiBerhentiMerokok == null
                        ? 'Belum dipilih'
                        : FormatTanggal.formatDasar(
                            _tanggalMulaiBerhentiMerokok!,
                          ),
                  ),
                  trailing: TextButton(
                    onPressed: _pilihTanggalMulaiBerhentiMerokok,
                    child: const Text('Pilih'),
                  ),
                ),
                // Mode berhenti: seketika atau bertahap (tapering).
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Berhenti bertahap (tapering)'),
                  subtitle: const Text(
                    'Kurangi jumlah rokok per hari secara bertahap.',
                  ),
                  value: _modeBerhenti == ModeBerhenti.bertahap,
                  onChanged: (value) {
                    setState(() {
                      _modeBerhenti = value
                          ? ModeBerhenti.bertahap
                          : ModeBerhenti.seketika;
                      if (value && _tanggalMulaiTapering == null) {
                        _tanggalMulaiTapering = DateTime.now();
                      }
                    });
                  },
                ),
                if (_modeBerhenti == ModeBerhenti.bertahap) ...[
                  InputAngka(
                    controller: _penurunanPerMingguController,
                    label: 'Penurunan per minggu (batang)',
                    hintText: 'Masukkan jumlah penurunan per minggu',
                    focusNode: _penurunanPerMingguFocusNode,
                    validator: (value) {
                      final cleaned = (value ?? '').replaceAll(
                        RegExp(r'[^0-9]'),
                        '',
                      );
                      final n = int.tryParse(cleaned);
                      if (n == null || n <= 0) {
                        return 'Wajib bilangan bulat positif';
                      }
                      return null;
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today_outlined),
                    title: const Text('Tanggal mulai penurunan'),
                    subtitle: Text(
                      _tanggalMulaiTapering == null
                          ? 'Belum dipilih'
                          : FormatTanggal.formatDasar(_tanggalMulaiTapering!),
                    ),
                    trailing: TextButton(
                      onPressed: _pilihTanggalMulaiTapering,
                      child: const Text('Pilih'),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                OutlinedButton(onPressed: _simpan, child: const Text('Simpan')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/dashboard/notifier/dashboard_notifier.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/dashboard/state/dashboard_state.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_notifier.g.dart';

@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Future<DashboardState> build() async {
    return await _muatData();
  }

  Future<DashboardState> _muatData() async {
    await ref.watch(biodataProvider.future);
    await ref.watch(impianProvider.future);
    return DashboardState();
  }
}
```


// ============================================================
// FILE: lib/fitur/dashboard/screens/dashboard_screen.dart
// ============================================================

```dart
import 'dart:async';

import 'package:berhenti_merokok/fitur/badge/screens/badge_screen.dart';

import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart';
import 'package:berhenti_merokok/fitur/sos_craving/screens/sos_craving_screen.dart';
import 'package:berhenti_merokok/shared/konstanta/milestone_kesehatan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    L.i('DashboardScreen initState');
  }

  @override
  void dispose() {
    L.i('DashboardScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    L.i('biodataAsync=$biodataAsync');

    if (biodataAsync.isLoading) {
      L.w('biodataAsync loading');
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      L.e(
        'biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}',
      );
      return Scaffold(
        appBar: AppBar(title: const Text('Dashboard')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const Text('Gagal memuat data'),
                  OutlinedButton(
                    onPressed: () {
                      final _ = ref.refresh(biodataProvider);
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final biodata = biodataAsync.requireValue;
    L.i('biodata=$biodata');
    if (biodata == null) {
      return _buildBiodataNull();
    }
    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    final nama = biodata.nama;
    L.i('tanggalBerhenti=$tanggalBerhenti, nama=$nama');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        scrolledUnderElevation: 2,
        actions: [
          IconButton(
            tooltip: 'SOS Craving',
            icon: const Icon(Icons.sos),
            onPressed: () => unawaited(
              Nav.to(context, const SosCravingScreen()).catchError((
                Object e,
                StackTrace s,
              ) {
                L.e('Gagal navigasi ke SOS Craving: $e $s');
                return null;
              }),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        'Lama berhenti merokok',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      _DurasiBerhenti(tanggalBerhenti: tanggalBerhenti),
                      if (tanggalBerhenti != null)
                        Text(
                          'Sejak ${FormatTanggal.formatDasar(tanggalBerhenti)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      if (nama.isNotEmpty)
                        Text(
                          'Halo, $nama',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                ),
              ),
              _buildCardProgres(biodata),
              _buildCardMilestone(biodata),
              _buildCardBadge(),
              _buildInfoKerugian(biodata),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardProgres(BiodataModel biodata) {
    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    final jumlahRokokPerHari = biodata.jumlahRokokPerHari;
    final hargaPerBungkus = biodata.hargaRokokPerBungkus;

    final hariBerhenti = biodata.hariBerhenti;
    final rokokTidakDiHisap = biodata.rokokTidakDiHisap;
    final uangDihemat = biodata.uangDihemat;
    L.i(
      'tanggalBerhenti=$tanggalBerhenti, jumlahRokokPerHari=$jumlahRokokPerHari, hargaPerBungkus=$hargaPerBungkus, hariBerhenti=$hariBerhenti, rokokTidakDiHisap=$rokokTidakDiHisap, uangDihemat=$uangDihemat',
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Uang dihemat',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              FormatUang.formatRupiah(uangDihemat),
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Rokok tidak dihisap',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              '$rokokTidakDiHisap batang',
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardMilestone(BiodataModel biodata) {
    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    if (tanggalBerhenti == null) return const SizedBox.shrink();

    final durasi = DateTime.now().difference(tanggalBerhenti);
    final aman = durasi.isNegative ? Duration.zero : durasi;
    final berikutnya = milestoneBerikutnya(aman);
    L.i('milestoneBerikutnya=${berikutnya?.judul}');

    return Card(
      child: InkWell(
        onTap: () => unawaited(
          Nav.to(context, const PemulihanKesehatanScreen()).catchError((
            Object e,
            StackTrace s,
          ) {
            L.e('Gagal navigasi ke Pemulihan Kesehatan: $e $s');
            return null;
          }),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              const Icon(CupertinoIcons.heart, size: 32, color: Colors.green),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      'Pemulihan Kesehatan',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      berikutnya == null
                          ? 'Semua milestone tercapai'
                          : 'Berikutnya: ${berikutnya.judul}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (berikutnya != null)
                      Text(
                        'Tersisa ${_formatDurasiSingkat(berikutnya.target - aman)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
              const Icon(CupertinoIcons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  String _formatHariHilang(double hariHilang) {
    if (hariHilang <= 365) {
      return '${hariHilang.toStringAsFixed(1)} hari';
    }
    final totalHari = hariHilang.round();
    final tahun = totalHari ~/ 365;
    final sisaTahun = totalHari % 365;
    final bulan = sisaTahun ~/ 30;
    final hari = sisaTahun % 30;
    return '$tahun'
        'T $bulan'
        'B $hari'
        'H';
  }

  String _formatDurasiSingkat(Duration d) {
    if (d.inDays > 0) {
      final hari = d.inDays;
      final jam = d.inHours % 24;
      if (jam > 0) return '$hari hari $jam jam';
      return '$hari hari';
    }
    if (d.inHours > 0) {
      final jam = d.inHours;
      final menit = d.inMinutes % 60;
      if (menit > 0) return '$jam jam $menit menit';
      return '$jam jam';
    }
    final menit = d.inMinutes;
    final detik = d.inSeconds % 60;
    if (menit > 0) return '$menit menit $detik detik';
    return '$detik detik';
  }

  Widget _buildCardBadge() {
    return Card(
      child: InkWell(
        onTap: () => unawaited(
          Nav.to(context, const BadgeScreen()).catchError((
            Object e,
            StackTrace s,
          ) {
            L.e('Gagal navigasi ke Badge: $e $s');
            return null;
          }),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              const Icon(CupertinoIcons.rosette, size: 32, color: Colors.amber),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      'Pencapaian',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lihat badge yang telah tercapai',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(CupertinoIcons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoKerugian(BiodataModel biodata) {
    final jumlahRokokPerHari = biodata.jumlahRokokPerHari;
    final hargaPerBungkus = biodata.hargaRokokPerBungkus;
    final tanggalMulaiMerokok = biodata.tanggalMulaiMerokok;
    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;

    int totalHariMerokok = 0;
    if (tanggalMulaiMerokok != null && tanggalBerhenti != null) {
      totalHariMerokok = tanggalBerhenti.difference(tanggalMulaiMerokok).inDays;
      if (totalHariMerokok < 0) {
        totalHariMerokok = 0;
      }
    }

    final rokokDihisap = jumlahRokokPerHari * totalHariMerokok;
    final uangTerbuang = biodata.batangPerBungkus == 0
        ? 0.0
        : (rokokDihisap / biodata.batangPerBungkus) * hargaPerBungkus;
    final menitHilang = (rokokDihisap * 11).round();
    final hariHilang = menitHilang / (24 * 60);
    L.i(
      'totalHariMerokok=$totalHariMerokok, rokokDihisap=$rokokDihisap, uangTerbuang=$uangTerbuang, menitHilang=$menitHilang, hariHilang=$hariHilang',
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Kerugian saat merokok',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            _buildInfoKerugianKustom(
              CupertinoIcons.smoke,
              '$rokokDihisap batang',
              'Total rokok yang dihisap',
            ),
            _buildInfoKerugianKustom(
              CupertinoIcons.money_dollar,
              FormatUang.formatRupiah(uangTerbuang),
              'uang yang terbuang',
            ),
            _buildInfoKerugianKustom(
              CupertinoIcons.heart,
              _formatHariHilang(hariHilang),
              'hidup yang hilang',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoKerugianKustom(
    IconData icon,
    String title,
    String subtitle,
  ) {
    L.i('icon=$icon, title=$title, subtitle=$subtitle');
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildBiodataNull() {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                const Text('Belum ada data biodata'),
                OutlinedButton(
                  onPressed: () => unawaited(
                    Nav.to(
                      context,
                      const FormBiodata(buatPertama: false),
                    ).catchError((Object e, StackTrace s) {
                      L.e('Gagal navigasi ke Form Biodata: $e $s');
                      return null;
                    }),
                  ),
                  child: const Text('Isi Biodata'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget kecil yang menampilkan durasi berhenti merokok dan memperbarui tampilannya setiap detik tanpa memicu rebuild seluruh halaman.
class _DurasiBerhenti extends StatefulWidget {
  const _DurasiBerhenti({required this.tanggalBerhenti});

  final DateTime? tanggalBerhenti;

  @override
  State<_DurasiBerhenti> createState() => _DurasiBerhentiState();
}

class _DurasiBerhentiState extends State<_DurasiBerhenti> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatLamaBerhenti(widget.tanggalBerhenti),
      style: Theme.of(context).textTheme.headlineMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

/// Menghitung lama waktu (hari, jam, menit, detik) sejak [tanggalBerhenti] hingga saat ini.
String _formatLamaBerhenti(DateTime? tanggalBerhenti) {
  if (tanggalBerhenti == null) {
    return 'Belum ditentukan';
  }
  final selisih = DateTime.now().difference(tanggalBerhenti);
  L.i('tanggalBerhenti=$tanggalBerhenti, selisih=$selisih');
  if (selisih.isNegative) {
    return '0 detik';
  }

  final hari = selisih.inDays;
  final jam = selisih.inHours % 24;
  final menit = selisih.inMinutes % 60;
  final detik = selisih.inSeconds % 60;

  final bagian = <String>[];
  if (hari > 0) {
    bagian.add('$hari hari');
  }
  if (jam > 0) {
    bagian.add('$jam jam');
  }
  if (menit > 0) {
    bagian.add('$menit menit');
  }
  bagian.add('$detik detik');
  return bagian.join(' ');
}
```


// ============================================================
// FILE: lib/fitur/dashboard/state/dashboard_state.dart
// ============================================================

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const DashboardState._();

  const factory DashboardState({
    @Default(0) double totalDiHemat,
    @Default(0) double totalBatangDiAbaikan,
  }) = _DashboardState;
}
```


// ============================================================
// FILE: lib/fitur/diary_craving/enum/pemicu_enum.dart
// ============================================================

```dart
import 'package:flutter/material.dart';

/// Kategori pemicu craving.
enum PemicuEnum {
  stres,
  kopi,
  alkohol,
  sosial,
  bauRokok,
  emosi,
  lapar,
  lelah,
  lainnya,
}

/// Extension yang menyediakan label dan ikon untuk [PemicuEnum].
extension PemicuEnumExtension on PemicuEnum {
  String get label {
    switch (this) {
      case PemicuEnum.stres:
        return 'Stres';
      case PemicuEnum.kopi:
        return 'Kopi';
      case PemicuEnum.alkohol:
        return 'Alkohol';
      case PemicuEnum.sosial:
        return 'Sosial';
      case PemicuEnum.bauRokok:
        return 'Bau rokok';
      case PemicuEnum.emosi:
        return 'Emosi';
      case PemicuEnum.lapar:
        return 'Lapar';
      case PemicuEnum.lelah:
        return 'Lelah';
      case PemicuEnum.lainnya:
        return 'Lainnya';
    }
  }

  IconData get icon {
    switch (this) {
      case PemicuEnum.stres:
        return Icons.psychology_alt_outlined;
      case PemicuEnum.kopi:
        return Icons.coffee_outlined;
      case PemicuEnum.alkohol:
        return Icons.local_bar_outlined;
      case PemicuEnum.sosial:
        return Icons.people_outline;
      case PemicuEnum.bauRokok:
        return Icons.smoking_rooms_outlined;
      case PemicuEnum.emosi:
        return Icons.mood_outlined;
      case PemicuEnum.lapar:
        return Icons.restaurant_outlined;
      case PemicuEnum.lelah:
        return Icons.bedtime_outlined;
      case PemicuEnum.lainnya:
        return Icons.more_horiz;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/diary_craving/model/diary_craving_model.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'diary_craving_model.freezed.dart';

@freezed
abstract class DiaryCravingModel with _$DiaryCravingModel {
  const DiaryCravingModel._();

  const factory DiaryCravingModel({
    required String id,
    required DateTime tanggal,
    required PemicuEnum pemicu,
    @Default(3) int intensitas,
    String? catatan,
    required DateTime dibuat,
  }) = _DiaryCravingModel;

  /// Membuat [DiaryCravingModel] dari baris database SQLite.
  factory DiaryCravingModel.fromSqflite(Map<String, Object?> row) {
    return DiaryCravingModel(
      id: ParserUtil.parseString(row[NamaKolom.id]),
      tanggal:
          ParserUtil.parseDateTime(row[NamaKolom.tanggal])?.toLocal() ??
          DateTime.now(),
      pemicu:
          ParserUtil.safeParseEnum(
            PemicuEnum.values,
            ParserUtil.parseStringOrNull(row[NamaKolom.pemicu]),
          ) ??
          PemicuEnum.lainnya,
      intensitas: ParserUtil.parseInt(
        row[NamaKolom.intensitas],
        defaultValue: 3,
      ),
      catatan: ParserUtil.parseStringOrNull(row[NamaKolom.catatan]),
      dibuat:
          ParserUtil.parseDateTime(row[NamaKolom.dibuat])?.toLocal() ??
          DateTime.now(),
    );
  }

  /// Mengonversi [DiaryCravingModel] menjadi Map untuk disimpan ke SQLite.
  Map<String, Object?> toSqflite() {
    return <String, Object?>{
      NamaKolom.id: id,
      NamaKolom.tanggal: tanggal.toUtc().toIso8601String(),
      NamaKolom.pemicu: pemicu.name,
      NamaKolom.intensitas: intensitas,
      NamaKolom.catatan: catatan,
      NamaKolom.dibuat: dibuat.toUtc().toIso8601String(),
    };
  }
}
```


// ============================================================
// FILE: lib/fitur/diary_craving/notifier/diary_craving_notifier.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/diary_craving/model/diary_craving_model.dart';
import 'package:berhenti_merokok/fitur/diary_craving/state/diary_craving_state.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

part 'diary_craving_notifier.g.dart';

@Riverpod(keepAlive: true)
class DiaryCravingNotifier extends _$DiaryCravingNotifier {
  @override
  Future<DiaryCravingState> build() async {
    return await _ambilSemua();
  }

  Future<DiaryCravingState> _ambilSemua() async {
    try {
      final op = const SqfliteOp();
      final rows = await op.ambilSemua(
        NamaTabel.diaryCraving,
        orderBy: '${NamaKolom.tanggal} DESC',
      );
      final daftar = rows.map(DiaryCravingModel.fromSqflite).toList();
      L.i('daftar.length=${daftar.length}');
      return DiaryCravingState(
        listCraving: daftar,
        jumlahCraving: daftar.length,
      );
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data diary craving: $e $s');
      rethrow;
    }
  }

  Future<void> tambah(DiaryCravingModel craving) async {
    L.i('craving=$craving');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.tambah(
        NamaTabel.diaryCraving,
        craving.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      state = AsyncValue.data(
        DiaryCravingState(
          listCraving: [craving, ...dataLama.listCraving],
          jumlahCraving: dataLama.jumlahCraving + 1,
        ),
      );
      L.s('Diary craving berhasil disimpan');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan diary craving: $e $s');
      rethrow;
    }
  }

  Future<void> ubah(DiaryCravingModel craving) async {
    L.i('craving=$craving');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.ubah(
        NamaTabel.diaryCraving,
        craving.toSqflite(),
        where: '${NamaKolom.id} = ?',
        whereArgs: [craving.id],
      );
      final baru = dataLama.listCraving
          .map((e) => e.id == craving.id ? craving : e)
          .toList();
      state = AsyncValue.data(
        DiaryCravingState(listCraving: baru, jumlahCraving: baru.length),
      );
      L.s('Diary craving berhasil diubah');
    } on Exception catch (e, s) {
      L.e('Gagal mengubah diary craving: $e $s');
      rethrow;
    }
  }

  Future<void> hapus(String id) async {
    L.i('id=$id');
    try {
      final dataLama = await future;
      final op = const SqfliteOp();
      await op.hapus(
        NamaTabel.diaryCraving,
        where: '${NamaKolom.id} = ?',
        whereArgs: [id],
      );
      final baru = dataLama.listCraving.where((e) => e.id != id).toList();
      state = AsyncValue.data(
        DiaryCravingState(listCraving: baru, jumlahCraving: baru.length),
      );
      L.s('Diary craving berhasil dihapus');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus diary craving: $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/diary_craving/screens/diary_craving_screen.dart
// ============================================================

```dart
import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/model/diary_craving_model.dart';
import 'package:berhenti_merokok/fitur/diary_craving/notifier/diary_craving_notifier.dart';
import 'package:berhenti_merokok/fitur/diary_craving/screens/form_diary_craving.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class DiaryCravingScreen extends ConsumerStatefulWidget {
  const DiaryCravingScreen({super.key});

  @override
  ConsumerState<DiaryCravingScreen> createState() => _DiaryCravingScreenState();
}

class _DiaryCravingScreenState extends ConsumerState<DiaryCravingScreen> {
  @override
  void initState() {
    super.initState();
    L.i('DiaryCravingScreen initState');
  }

  @override
  void dispose() {
    L.i('DiaryCravingScreen dispose');
    super.dispose();
  }

  Future<void> _hapus(DiaryCravingModel item) async {
    L.i('item.id=${item.id}');
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Catatan',
      message:
          'Apakah Anda yakin ingin menghapus catatan craving ini '
          '(${item.pemicu.label})?',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!mounted) return;
    try {
      await ref.read(diaryCravingProvider.notifier).hapus(item.id);
      if (mounted) {
        AppToast.sukses(context, 'Catatan craving berhasil dihapus');
      }
    } on Exception catch (e, s) {
      L.e('Gagal menghapus diary craving: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menghapus catatan craving');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cravingAsync = ref.watch(diaryCravingProvider);
    L.i(
      'cravingAsync.isLoading=${cravingAsync.isLoading}, hasError=${cravingAsync.hasError}',
    );

    if (cravingAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (cravingAsync.hasError) {
      L.w('diaryCravingProvider error=${cravingAsync.error}');
      return Scaffold(
        appBar: AppBar(title: const Text('Diary Craving')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              const Text('Gagal memuat data diary craving'),
              OutlinedButton(
                onPressed: () {
                  final _ = ref.refresh(diaryCravingProvider);
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final state = cravingAsync.requireValue;
    final list = state.listCraving;
    L.i('list.length=${list.length}');

    if (list.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Diary Craving')),
        body: const _EmptyDiaryCraving(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => unawaited(Nav.to(context, const FormDiaryCraving())),
          child: const Icon(CupertinoIcons.add),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Diary Craving')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              L.i(
                'item.id=${item.id}, item.pemicu=${item.pemicu}, item.intensitas=${item.intensitas}',
              );
              return Card(
                key: ValueKey(item.id),
                child: ListTile(
                  leading: Icon(item.pemicu.icon),
                  title: Text(item.pemicu.label),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        'Intensitas: ${item.intensitas}/5  •  ${FormatWaktuLengkap.formatSingkat(item.tanggal)}',
                      ),
                      if (item.catatan != null && item.catatan!.isNotEmpty)
                        Text(item.catatan!),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Hapus',
                    onPressed: () => unawaited(_hapus(item)),
                  ),
                  onTap: () => unawaited(
                    Nav.to(context, FormDiaryCraving(craving: item)),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => unawaited(Nav.to(context, const FormDiaryCraving())),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}

class _EmptyDiaryCraving extends StatelessWidget {
  const _EmptyDiaryCraving();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(CupertinoIcons.book, size: 48),
              Text(
                'Belum ada catatan craving',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Tekan tombol + untuk mencatat craving pertama.',
                textAlign: TextAlign.center,
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
// FILE: lib/fitur/diary_craving/screens/form_diary_craving.dart
// ============================================================

```dart
import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/model/diary_craving_model.dart';
import 'package:berhenti_merokok/fitur/diary_craving/notifier/diary_craving_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

class FormDiaryCraving extends ConsumerStatefulWidget {
  final DiaryCravingModel? craving;
  const FormDiaryCraving({super.key, this.craving});

  @override
  ConsumerState<FormDiaryCraving> createState() => _FormDiaryCravingState();
}

class _FormDiaryCravingState extends ConsumerState<FormDiaryCraving> {
  final _formKey = GlobalKey<FormState>();
  final _catatanController = TextEditingController();
  final _catatanFocusNode = FocusNode();

  PemicuEnum _pemicu = PemicuEnum.stres;
  int _intensitas = 3;
  DateTime _tanggal = DateTime.now();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final craving = widget.craving;
    L.i('craving=$craving');
    if (craving != null) {
      _pemicu = craving.pemicu;
      _intensitas = craving.intensitas;
      _tanggal = craving.tanggal;
      _catatanController.text = craving.catatan ?? '';
      L.i(
        '_pemicu=$_pemicu, _intensitas=$_intensitas, _tanggal=$_tanggal, _catatanController.text=${_catatanController.text}',
      );
    }
  }

  @override
  void dispose() {
    _catatanController.dispose();
    _catatanFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final awal = _tanggal;
    L.i('awal=$awal, _tanggal=$_tanggal');
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    L.i('picked=$picked');
    if (picked != null && mounted) {
      // Gabungkan tanggal yang dipilih dengan waktu saat ini.
      final now = DateTime.now();
      setState(() {
        _tanggal = DateTime(
          picked.year,
          picked.month,
          picked.day,
          now.hour,
          now.minute,
        );
      });
      L.i('_tanggal=$_tanggal');
    }
  }

  Future<void> _pilihWaktu() async {
    final awal = TimeOfDay.fromDateTime(_tanggal);
    L.i('awal=$awal');
    final picked = await showTimePicker(context: context, initialTime: awal);
    L.i('picked=$picked');
    if (picked != null && mounted) {
      setState(() {
        _tanggal = DateTime(
          _tanggal.year,
          _tanggal.month,
          _tanggal.day,
          picked.hour,
          picked.minute,
        );
      });
      L.i('_tanggal=$_tanggal');
    }
  }

  Future<void> _simpan() async {
    if (_isLoading) {
      L.w('Form diary craving masih loading, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('validasi form gagal');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Simpan Craving',
      message: 'Apakah Anda yakin ingin menyimpan catatan craving ini?',
      okLabel: 'Simpan',
      cancelLabel: 'Batal',
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      L.w('konfirmasi bukan ok');
      return;
    }
    if (!mounted) return;

    setState(() => _isLoading = true);
    L.i('_isLoading=$_isLoading');
    unawaited(
      EasyLoading.show(
        status: 'Menyimpan...',
        maskType: EasyLoadingMaskType.black,
      ),
    );
    try {
      final model = DiaryCravingModel(
        id: widget.craving?.id ?? const Uuid().v4(),
        tanggal: _tanggal,
        pemicu: _pemicu,
        intensitas: _intensitas,
        catatan: _catatanController.text.trim().isEmpty
            ? null
            : _catatanController.text.trim(),
        dibuat: widget.craving?.dibuat ?? DateTime.now(),
      );
      L.i('model=$model');
      if (widget.craving == null) {
        L.i('widget.craving null, tambah');
        await ref.read(diaryCravingProvider.notifier).tambah(model);
      } else {
        L.i('widget.craving tidak null, ubah');
        await ref.read(diaryCravingProvider.notifier).ubah(model);
      }
      if (!mounted) return;
      if (Navigator.of(context).canPop()) {
        Nav.pop(context);
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan diary craving: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan catatan craving');
      }
    } finally {
      unawaited(EasyLoading.dismiss());
      if (mounted) {
        setState(() => _isLoading = false);
        L.i('_isLoading=$_isLoading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.craving == null ? 'Catat Craving' : 'Ubah Catatan Craving',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                InputDropdown<PemicuEnum>(
                  value: _pemicu,
                  label: 'Pemicu',
                  items: PemicuEnum.values,
                  displayString: (item) => item.label,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _pemicu = value);
                      L.i('_pemicu=$_pemicu');
                    }
                  },
                ),
                InputDropdown<int>(
                  value: _intensitas,
                  label: 'Intensitas (1-5)',
                  items: const [1, 2, 3, 4, 5],
                  displayString: (item) => '$item',
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _intensitas = value);
                      L.i('_intensitas=$_intensitas');
                    }
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_outlined),
                  title: const Text('Tanggal'),
                  subtitle: Text(FormatWaktuLengkap.formatSingkat(_tanggal)),
                  trailing: TextButton(
                    onPressed: _pilihTanggal,
                    child: const Text('Pilih'),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.access_time_outlined),
                  title: const Text('Waktu'),
                  subtitle: Text(FormatJam.formatJamMenit(_tanggal)),
                  trailing: TextButton(
                    onPressed: _pilihWaktu,
                    child: const Text('Pilih'),
                  ),
                ),
                InputTeks(
                  controller: _catatanController,
                  label: 'Catatan',
                  hintText: 'Catatan tambahan (opsional)',
                  focusNode: _catatanFocusNode,
                  wajib: false,
                  minLines: 2,
                  maxLines: 4,
                ),
                const SizedBox(height: 8),
                OutlinedButton(onPressed: _simpan, child: const Text('Simpan')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/diary_craving/state/diary_craving_state.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/diary_craving/model/diary_craving_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_craving_state.freezed.dart';

@freezed
abstract class DiaryCravingState with _$DiaryCravingState {
  const DiaryCravingState._();

  const factory DiaryCravingState({
    @Default([]) List<DiaryCravingModel> listCraving,
    @Default(0) int jumlahCraving,
  }) = _DiaryCravingState;
}
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_biodata.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_biodata.dart

import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';

/// ID dummy untuk data biodata.
class BiodataIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0001-000000000001';
}

/// Daftar data dummy biodata.
final List<BiodataModel> dummyBiodata = [
  BiodataModel(
    id: BiodataIdDummy.item1,
    nama: 'Budi Santoso',
    tanggalLahir: DateTime.now().subtract(const Duration(days: 365 * 36)),
    jumlahRokokPerHari: 12,
    hargaRokokPerBungkus: 35000.0,
    batangPerBungkus: 20.0,
    tanggalMulaiMerokok: DateTime.now().subtract(
      const Duration(days: 365 * 16),
    ),
    tanggalMulaiBerhentiMerokok: DateTime.now().subtract(
      const Duration(days: 30, hours: 7, minutes: 30),
    ),
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/dummy_data/dummy_impian.dart
// ============================================================

```dart
// lib/fitur/dummy/dummy_data/dummy_impian.dart

import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';

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
    nama: 'Beli ban baru',
    targetTanggal: DateTime.now().add(const Duration(days: 10)),
    dibuat: DateTime.now().subtract(const Duration(days: 5)),
    jumlah: 2000000.0,
  ),
  ImpianModel(
    id: ImpianIdDummy.item2,
    nama: 'Service AC mobil',
    targetTanggal: DateTime.now().add(const Duration(days: 15)),
    dibuat: DateTime.now().subtract(const Duration(days: 8)),
    jumlah: 1500000.0,
  ),
  ImpianModel(
    id: ImpianIdDummy.item3,
    nama: 'Ganti knalpot racing',
    targetTanggal: DateTime.now().add(const Duration(days: 20)),
    dibuat: DateTime.now().subtract(const Duration(days: 3)),
    jumlah: 1000000.0,
  ),
  ImpianModel(
    id: ImpianIdDummy.item4,
    nama: 'Beli helm baru',
    targetTanggal: DateTime.now().add(const Duration(days: 5)),
    dibuat: DateTime.now().subtract(const Duration(days: 6)),
    jumlah: 500000.0,
  ),
  ImpianModel(
    id: ImpianIdDummy.item5,
    nama: 'Ganti oli gardan',
    targetTanggal: DateTime.now().add(const Duration(days: 12)),
    dibuat: DateTime.now().subtract(const Duration(days: 2)),
    jumlah: 800000.0,
  ),
  ImpianModel(
    id: ImpianIdDummy.item6,
    nama: 'Pasang roof rack',
    targetTanggal: DateTime.now().add(const Duration(days: 25)),
    dibuat: DateTime.now().subtract(const Duration(days: 4)),
    jumlah: 3000000.0,
  ),
];
```


// ============================================================
// FILE: lib/fitur/dummy/helper/dummy_helper.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/dummy/dummy_data/dummy_biodata.dart';
import 'package:berhenti_merokok/fitur/dummy/dummy_data/dummy_impian.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

/// Helper untuk mengelola data dummy aplikasi.
class DummyHelper {
  /// Memasukkan seluruh data dummy ke database SQLite.
  static Future<void> insert() async {
    L.i('tes');
    L.i(
      'dummyImpian.length=${dummyImpian.length}, dummyBiodata.length=${dummyBiodata.length}',
    );
    try {
      final op = const SqfliteOp();
      await op.transaksi((txn) async {
        for (final impian in dummyImpian) {
          await txn.insert(
            NamaTabel.impian,
            impian.toSqflite(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        // Hapus biodata yang ada agar data dummy menjadi satu-satunya biodata
        // yang terbaca aplikasi (ambilSatu mengembalikan baris pertama).
        await txn.delete(NamaTabel.biodata);
        for (final biodata in dummyBiodata) {
          await txn.insert(
            NamaTabel.biodata,
            biodata.toSqflite(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      L.i('insert selesai');
    } on Exception catch (e, s) {
      L.e('Gagal memasukkan data dummy: $e $s');
      rethrow;
    }
  }

  /// Menghapus seluruh data dummy dari database SQLite.
  static Future<void> delete() async {
    L.i(
      'dummyImpian.length=${dummyImpian.length}, dummyBiodata.length=${dummyBiodata.length}',
    );
    try {
      final op = const SqfliteOp();
      await op.transaksi((txn) async {
        for (final impian in dummyImpian) {
          await txn.delete(
            NamaTabel.impian,
            where: 'id = ?',
            whereArgs: [impian.id],
          );
        }
        for (final biodata in dummyBiodata) {
          await txn.delete(
            NamaTabel.biodata,
            where: 'id = ?',
            whereArgs: [biodata.id],
          );
        }
      });
      L.i('delete selesai');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus data dummy: $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/dummy/screens/dummy_screen.dart
// ============================================================

```dart
import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/dummy/helper/dummy_helper.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class DummyScreen extends ConsumerStatefulWidget {
  const DummyScreen({super.key});

  @override
  ConsumerState<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends ConsumerState<DummyScreen> {
  bool _sedangMemuat = false;

  Future<void> _masukkanDummy(BuildContext context) async {
    L.i('_masukkanDummy _sedangMemuat=$_sedangMemuat');
    if (_sedangMemuat) {
      L.w('Dummy masih diproses, aksi diabaikan');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Masukkan Dummy',
      message:
          'Apakah Anda yakin ingin memasukkan data dummy? '
          'Biodata yang ada akan diganti dengan data dummy.',
      okLabel: 'Masukkan',
      cancelLabel: 'Batal',
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!context.mounted) return;

    setState(() => _sedangMemuat = true);
    unawaited(
      EasyLoading.show(
        status: 'Menyimpan...',
        maskType: EasyLoadingMaskType.black,
      ),
    );
    try {
      await DummyHelper.insert();
      await _refreshProvider();
      if (context.mounted) {
        AppToast.sukses(context, 'Dummy berhasil dimasukkan');
      }
    } on Exception catch (e, s) {
      L.e('Gagal memasukkan dummy: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal memasukkan dummy');
      }
    } finally {
      if (mounted) {
        unawaited(EasyLoading.dismiss());
        setState(() => _sedangMemuat = false);
      }
    }
  }

  Future<void> _hapusDummy(BuildContext context) async {
    L.i('_hapusDummy _sedangMemuat=$_sedangMemuat');
    if (_sedangMemuat) {
      L.w('Dummy masih diproses, aksi diabaikan');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Hapus Dummy',
      message: 'Apakah Anda yakin ingin menghapus data dummy?',
      okLabel: 'Hapus',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!context.mounted) return;

    setState(() => _sedangMemuat = true);
    unawaited(
      EasyLoading.show(
        status: 'Menghapus...',
        maskType: EasyLoadingMaskType.black,
      ),
    );
    try {
      await DummyHelper.delete();
      await _refreshProvider();
      if (context.mounted) {
        AppToast.sukses(context, 'Dummy berhasil dihapus');
      }
    } on Exception catch (e, s) {
      L.e('Gagal menghapus dummy: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal menghapus dummy');
      }
    } finally {
      if (mounted) {
        unawaited(EasyLoading.dismiss());
        setState(() => _sedangMemuat = false);
      }
    }
  }

  Future<void> _reset(BuildContext context) async {
    L.i('_reset _sedangMemuat=$_sedangMemuat');
    if (_sedangMemuat) {
      L.w('Dummy masih diproses, aksi diabaikan');
      return;
    }

    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Reset Dummy',
      message: 'Apakah Anda yakin ingin mereset data dummy? Data dummy akan dihapus lalu dimasukkan ulang.',
      okLabel: 'Reset',
      cancelLabel: 'Batal',
      isDestructiveAction: true,
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      return;
    }
    if (!context.mounted) return;

    setState(() => _sedangMemuat = true);
    unawaited(
      EasyLoading.show(
        status: 'Memproses...',
        maskType: EasyLoadingMaskType.black,
      ),
    );
    try {
      await DummyHelper.delete();
      await DummyHelper.insert();
      await _refreshProvider();
      if (context.mounted) {
        AppToast.sukses(context, 'Dummy berhasil direset');
      }
    } on Exception catch (e, s) {
      L.e('Gagal mereset dummy: $e $s');
      if (context.mounted) {
        AppToast.gagal(context, 'Gagal mereset dummy');
      }
    } finally {
      if (mounted) {
        unawaited(EasyLoading.dismiss());
        setState(() => _sedangMemuat = false);
      }
    }
  }

  Future<void> _refreshProvider() async {
    // Perbarui state agar UI memuat data dummy terbaru.
    L.i('_refreshProvider');
    final _ = ref.refresh(impianProvider);
    final _ = ref.refresh(biodataProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dummy')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            _buildTombolCustom(
              () => unawaited(_masukkanDummy(context)),
              'insert',
              Colors.green,
            ),
            _buildTombolCustom(
              () => unawaited(_hapusDummy(context)),
              'hapus',
              Colors.red,
            ),
            _buildTombolCustom(
              () => unawaited(_reset(context)),
              'reset',
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTombolCustom(
    void Function() onPressed,
    String value,
    Color backgroundColor,
  ) {
    L.i('value=$value, backgroundColor=$backgroundColor');
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(value),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/enum/sort_impian.dart
// ============================================================

```dart
import 'package:flutter/material.dart';

/// Opsi pengurutan daftar impian.
enum SortImpian {
  namaAz,
  namaZa,
  jumlahAz,
  jumlahZa,
  mendekatiTerkumpulAz,
  mendekatiTerkumpulZa,
}

/// Extension yang menyediakan label dan ikon untuk [SortImpian].
extension SortImpianExtension on SortImpian {
  String get label {
    switch (this) {
      case SortImpian.namaAz:
        return 'Nama A-Z';
      case SortImpian.namaZa:
        return 'Nama Z-A';
      case SortImpian.jumlahAz:
        return 'Jumlah terkecil';
      case SortImpian.jumlahZa:
        return 'Jumlah terbesar';
      case SortImpian.mendekatiTerkumpulAz:
        return 'Paling mendekati terkumpul (kecil)';
      case SortImpian.mendekatiTerkumpulZa:
        return 'Sisa terbesar';
    }
  }

  IconData get icon {
    switch (this) {
      case SortImpian.namaAz:
        return Icons.arrow_upward;
      case SortImpian.namaZa:
        return Icons.arrow_downward;
      case SortImpian.jumlahAz:
        return Icons.arrow_upward;
      case SortImpian.jumlahZa:
        return Icons.arrow_downward;
      case SortImpian.mendekatiTerkumpulAz:
        return Icons.arrow_upward;
      case SortImpian.mendekatiTerkumpulZa:
        return Icons.arrow_downward;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/model/impian_model.dart
// ============================================================

```dart
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'impian_model.freezed.dart';

@freezed
abstract class ImpianModel with _$ImpianModel {
  const ImpianModel._();

  const factory ImpianModel({
    required String id,
    required String nama,
    required DateTime targetTanggal,
    required DateTime dibuat,
    required double jumlah,
  }) = _ImpianModel;

  /// Membuat [ImpianModel] dari baris database SQLite.
  factory ImpianModel.fromSqflite(Map<String, Object?> row) {
    return ImpianModel(
      id: ParserUtil.parseString(row[NamaKolom.id]),
      nama: ParserUtil.parseString(row[NamaKolom.nama]),
      targetTanggal:
          ParserUtil.parseDateTime(row[NamaKolom.targetTanggal])?.toLocal() ??
          DateTime.now(),
      dibuat:
          ParserUtil.parseDateTime(row[NamaKolom.dibuat])?.toLocal() ??
          DateTime.now(),
      jumlah: ParserUtil.parseDouble(row[NamaKolom.jumlah]),
    );
  }

  /// Mengonversi [ImpianModel] menjadi Map untuk disimpan ke SQLite.
  Map<String, Object?> toSqflite() {
    return <String, Object?>{
      NamaKolom.id: id,
      NamaKolom.nama: nama,
      NamaKolom.targetTanggal: targetTanggal.toUtc().toIso8601String(),
      NamaKolom.dibuat: dibuat.toUtc().toIso8601String(),
      NamaKolom.jumlah: jumlah,
    };
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/notifier/impian_notifier.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
import 'package:berhenti_merokok/fitur/impian/state/impian_state.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

part 'impian_notifier.g.dart';

@Riverpod(keepAlive: true)
class ImpianNotifier extends _$ImpianNotifier {
  @override
  Future<ImpianState> build() async {
    return await _ambilSemua();
  }

  Future<ImpianState> _ambilSemua() async {
    try {
      final op = const SqfliteOp();
      final rows = await op.ambilSemua(NamaTabel.impian);
      final daftar = rows.map(ImpianModel.fromSqflite).toList();
      final totalJumlah = daftar.fold<double>(
        0,
        (previousValue, element) => previousValue + element.jumlah,
      );
      L.i('daftar.length=${daftar.length}, totalJumlah=$totalJumlah');
      return ImpianState(
        listImpian: daftar,
        jumlahImpian: daftar.length,
        totalJumlah: totalJumlah,
      );
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data impian: $e $s');
      rethrow;
    }
  }

  Future<void> tambah(ImpianModel impian) async {
    L.i(
      'impian.id=${impian.id}, impian.nama=${impian.nama}, impian.jumlah=${impian.jumlah}',
    );
    try {
      final dataLama = await future;
      L.i(
        'dataLama.jumlahImpian=${dataLama.jumlahImpian}, dataLama.totalJumlah=${dataLama.totalJumlah}',
      );
      final op = const SqfliteOp();
      await op.tambah(
        NamaTabel.impian,
        impian.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      state = AsyncValue.data(
        ImpianState(
          listImpian: [...dataLama.listImpian, impian],
          jumlahImpian: dataLama.jumlahImpian + 1,
          totalJumlah: dataLama.totalJumlah + impian.jumlah,
        ),
      );
      L.s('Impian berhasil disimpan');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan impian: $e $s');
      rethrow;
    }
  }

  /// Menambahkan banyak impian sekaligus menggunakan operasi batch.
  Future<void> tambahBanyak(List<ImpianModel> daftarImpian) async {
    L.i('daftarImpian.length=${daftarImpian.length}');
    try {
      final dataLama = await future;
      L.i(
        'dataLama.jumlahImpian=${dataLama.jumlahImpian}, dataLama.totalJumlah=${dataLama.totalJumlah}',
      );
      final op = const SqfliteOp();
      await op.batch((batch) {
        for (final impian in daftarImpian) {
          batch.insert(
            NamaTabel.impian,
            impian.toSqflite(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      final tambahanJumlah = daftarImpian.fold<double>(
        0,
        (previousValue, element) => previousValue + element.jumlah,
      );
      state = AsyncValue.data(
        ImpianState(
          listImpian: [...dataLama.listImpian, ...daftarImpian],
          jumlahImpian: dataLama.jumlahImpian + daftarImpian.length,
          totalJumlah: dataLama.totalJumlah + tambahanJumlah,
        ),
      );
      L.s('Impian berhasil disimpan (batch)');
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan impian (batch): $e $s');
      rethrow;
    }
  }

  Future<void> ubah(ImpianModel impian) async {
    L.i(
      'impian.id=${impian.id}, impian.nama=${impian.nama}, impian.jumlah=${impian.jumlah}',
    );
    try {
      final dataLama = await future;
      L.i(
        'dataLama.jumlahImpian=${dataLama.jumlahImpian}, dataLama.totalJumlah=${dataLama.totalJumlah}',
      );
      final op = const SqfliteOp();
      await op.ubah(
        NamaTabel.impian,
        impian.toSqflite(),
        where: '${NamaKolom.id} = ?',
        whereArgs: [impian.id],
      );
      final baru = dataLama.listImpian
          .map((e) => e.id == impian.id ? impian : e)
          .toList();
      final totalJumlah = baru.fold<double>(
        0,
        (previousValue, element) => previousValue + element.jumlah,
      );
      state = AsyncValue.data(
        ImpianState(
          listImpian: baru,
          jumlahImpian: baru.length,
          totalJumlah: totalJumlah,
        ),
      );
      L.s('Impian berhasil diubah');
    } on Exception catch (e, s) {
      L.e('Gagal mengubah impian: $e $s');
      rethrow;
    }
  }

  Future<void> hapus(String id) async {
    L.i('id=$id');
    try {
      final dataLama = await future;
      L.i(
        'dataLama.jumlahImpian=${dataLama.jumlahImpian}, dataLama.totalJumlah=${dataLama.totalJumlah}',
      );
      final op = const SqfliteOp();
      await op.hapus(
        NamaTabel.impian,
        where: '${NamaKolom.id} = ?',
        whereArgs: [id],
      );
      final baru = dataLama.listImpian.where((e) => e.id != id).toList();
      final totalJumlah = baru.fold<double>(
        0,
        (previousValue, element) => previousValue + element.jumlah,
      );
      state = AsyncValue.data(
        ImpianState(
          listImpian: baru,
          jumlahImpian: baru.length,
          totalJumlah: totalJumlah,
        ),
      );
      L.s('Impian berhasil dihapus');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus impian: $e $s');
      rethrow;
    }
  }

  /// Menghapus banyak impian sekaligus menggunakan operasi batch.
  Future<void> hapusBanyak(List<String> daftarId) async {
    L.i('daftarId.length=${daftarId.length}');
    try {
      final dataLama = await future;
      L.i(
        'dataLama.jumlahImpian=${dataLama.jumlahImpian}, dataLama.totalJumlah=${dataLama.totalJumlah}',
      );
      final op = const SqfliteOp();
      await op.batch((batch) {
        for (final id in daftarId) {
          batch.delete(
            NamaTabel.impian,
            where: '${NamaKolom.id} = ?',
            whereArgs: [id],
          );
        }
      });
      final baru = dataLama.listImpian
          .where((e) => !daftarId.contains(e.id))
          .toList();
      final totalJumlah = baru.fold<double>(
        0,
        (previousValue, element) => previousValue + element.jumlah,
      );
      state = AsyncValue.data(
        ImpianState(
          listImpian: baru,
          jumlahImpian: baru.length,
          totalJumlah: totalJumlah,
        ),
      );
      L.s('Impian berhasil dihapus (batch)');
    } on Exception catch (e, s) {
      L.e('Gagal menghapus impian (batch): $e $s');
      rethrow;
    }
  }

  /// Mengubah banyak impian sekaligus menggunakan operasi batch.
  Future<void> ubahBanyak(List<ImpianModel> daftarImpian) async {
    L.i('daftarImpian.length=${daftarImpian.length}');
    try {
      final dataLama = await future;
      L.i(
        'dataLama.jumlahImpian=${dataLama.jumlahImpian}, dataLama.totalJumlah=${dataLama.totalJumlah}',
      );
      final op = const SqfliteOp();
      await op.batch((batch) {
        for (final impian in daftarImpian) {
          batch.update(
            NamaTabel.impian,
            impian.toSqflite(),
            where: '${NamaKolom.id} = ?',
            whereArgs: [impian.id],
          );
        }
      });
      final baru = dataLama.listImpian.map((e) {
        final pengganti = daftarImpian.firstWhereOrNull(
          (item) => item.id == e.id,
        );
        return pengganti ?? e;
      }).toList();
      final totalJumlah = baru.fold<double>(
        0,
        (previousValue, element) => previousValue + element.jumlah,
      );
      state = AsyncValue.data(
        ImpianState(
          listImpian: baru,
          jumlahImpian: baru.length,
          totalJumlah: totalJumlah,
        ),
      );
      L.s('Impian berhasil diubah (batch)');
    } on Exception catch (e, s) {
      L.e('Gagal mengubah impian (batch): $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/screens/detail_impian_screen.dart
// ============================================================

```dart
import 'dart:async';

import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
import 'package:berhenti_merokok/fitur/impian/screens/form_impian.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class DetailImpianScreen extends ConsumerWidget {
  final String id;
  const DetailImpianScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final impianAsync = ref.watch(impianProvider);

    if (impianAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (impianAsync.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Impian')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
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
          ),
        ),
      );
    }

    final impianState = impianAsync.requireValue;
    final ImpianModel? impian = impianState.listImpian.firstWhereOrNull(
      (item) => item.id == id,
    );

    if (impian == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Impian')),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text('Impian tidak ditemukan')),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Impian'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.pencil),
            onPressed: () =>
                unawaited(Nav.to(context, FormImpian(impian: impian))),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                _buildItem(context, 'Nama', impian.nama),
                _buildItem(
                  context,
                  'Jumlah',
                  FormatUang.formatRupiah(impian.jumlah),
                ),
                _buildItem(
                  context,
                  'Target tanggal',
                  FormatTanggal.formatDasar(impian.targetTanggal),
                ),
                _buildItem(
                  context,
                  'Dibuat',
                  FormatTanggal.formatDasar(impian.dibuat),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String label, String nilai) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(nilai, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/screens/form_impian.dart
// ============================================================

```dart
import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:uuid/uuid.dart';

class FormImpian extends ConsumerStatefulWidget {
  final ImpianModel? impian;
  const FormImpian({super.key, this.impian});

  @override
  ConsumerState<FormImpian> createState() => _FormImpianState();
}

class _FormImpianState extends ConsumerState<FormImpian> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();

  final _namaFocusNode = FocusNode();
  final _jumlahFocusNode = FocusNode();

  DateTime? _targetTanggal;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final impian = widget.impian;
    L.i('impian=$impian');
    if (impian != null) {
      _namaController.text = impian.nama;
      _jumlahController.text = FormatUang.formatRupiah(impian.jumlah);
      _targetTanggal = impian.targetTanggal;
      L.i(
        '_namaController.text=${_namaController.text}, _jumlahController.text=${_jumlahController.text}, _targetTanggal=$_targetTanggal',
      );
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    _namaFocusNode.dispose();
    _jumlahFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pilihTargetTanggal() async {
    final awal = _targetTanggal ?? DateTime.now();
    L.i('awal=$awal, _targetTanggal=$_targetTanggal');
    final picked = await showDatePicker(
      context: context,
      initialDate: awal,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    L.i('picked=$picked');
    if (picked != null && mounted) {
      setState(() => _targetTanggal = picked);
      L.i('_targetTanggal=$_targetTanggal');
    }
  }

  Future<void> _simpan() async {
    if (_isLoading) {
      L.w('Form impian masih loading, simpan diabaikan');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      L.w('validasi form gagal');
      return;
    }
    if (_namaController.text.trim().isEmpty) {
      L.w('nama impian kosong');
      if (mounted) {
        AppToast.gagal(context, 'Nama impian wajib diisi');
      }
      return;
    }
    final konfirmasi = await showOkCancelAlertDialog(
      context: context,
      title: 'Simpan Impian',
      message: 'Apakah Anda yakin ingin menyimpan data impian ini?',
      okLabel: 'Simpan',
      cancelLabel: 'Batal',
    );
    L.i('konfirmasi=$konfirmasi');
    if (konfirmasi != OkCancelResult.ok) {
      L.w('konfirmasi bukan ok');
      return;
    }
    if (!mounted) return;
    setState(() => _isLoading = true);
    L.i('_isLoading=$_isLoading');
    unawaited(
      EasyLoading.show(
        status: 'Menyimpan...',
        maskType: EasyLoadingMaskType.black,
      ),
    );
    try {
      final jumlah = InputRupiah.parse(_jumlahController.text);
      L.i('jumlah=$jumlah');
      if (jumlah <= 0) {
        L.w('jumlah <= 0');
        if (mounted) {
          AppToast.gagal(context, 'Jumlah harus lebih dari 0');
        }
        return;
      }
      final model = ImpianModel(
        id: widget.impian?.id ?? const Uuid().v4(),
        nama: _namaController.text.trim(),
        targetTanggal: _targetTanggal ?? DateTime.now(),
        dibuat: widget.impian?.dibuat ?? DateTime.now(),
        jumlah: jumlah,
      );
      L.i('model=$model');
      if (widget.impian == null) {
        L.i('widget.impian null, tambah');
        await ref.read(impianProvider.notifier).tambah(model);
      } else {
        L.i('widget.impian tidak null, ubah');
        await ref.read(impianProvider.notifier).ubah(model);
      }
      if (!mounted) return;
      if (Navigator.of(context).canPop()) {
        Nav.pop(context);
      }
    } on Exception catch (e, s) {
      L.e('Gagal menyimpan impian: $e $s');
      if (mounted) {
        AppToast.gagal(context, 'Gagal menyimpan impian');
      }
    } finally {
      unawaited(EasyLoading.dismiss());
      if (mounted) {
        setState(() => _isLoading = false);
        L.i('_isLoading=$_isLoading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.impian == null ? 'Form Impian' : 'Ubah Impian'),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                InputTeks(
                  controller: _namaController,
                  label: 'Nama Impian',
                  hintText: 'Masukkan nama impian',
                  focusNode: _namaFocusNode,
                  nextFocusNode: _jumlahFocusNode,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama impian wajib diisi';
                    }
                    return null;
                  },
                ),
                InputRupiah(
                  controller: _jumlahController,
                  label: 'Jumlah',
                  hintText: 'Masukkan jumlah',
                  focusNode: _jumlahFocusNode,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_outlined),
                  title: const Text('Target tanggal'),
                  subtitle: Text(
                    _targetTanggal == null
                        ? 'Belum dipilih'
                        : FormatTanggal.formatDasar(_targetTanggal!),
                  ),
                  trailing: TextButton(
                    onPressed: _pilihTargetTanggal,
                    child: const Text('Pilih'),
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton(onPressed: _simpan, child: const Text('Simpan')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/impian/screens/impian_screen.dart
// ============================================================

```dart
import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/enum/sort_impian.dart';
import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:berhenti_merokok/fitur/impian/screens/detail_impian_screen.dart';
import 'package:berhenti_merokok/fitur/impian/screens/form_impian.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

class ImpianScreen extends ConsumerStatefulWidget {
  const ImpianScreen({super.key});

  @override
  ConsumerState<ImpianScreen> createState() => _ImpianScreenState();
}

class _ImpianScreenState extends ConsumerState<ImpianScreen> {
  SortImpian _sortImpian = SortImpian.mendekatiTerkumpulAz;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showModalSort() {
    L.i('sortImpian=$_sortImpian');
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Text(
                  'Urutkan',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                ...SortImpian.values.map((sort) {
                  return ListTile(
                    leading: Icon(sort.icon),
                    title: Text(sort.label),
                    trailing: _sortImpian == sort
                        ? const Icon(Icons.check)
                        : null,
                    onTap: () {
                      setState(() => _sortImpian = sort);
                      Nav.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final impianAsync = ref.watch(impianProvider);
    final biodataAsync = ref.watch(biodataProvider);
    L.i(
      'impianAsync.isLoading=${impianAsync.isLoading}, hasError=${impianAsync.hasError}',
    );

    if (impianAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (impianAsync.hasError) {
      L.w('impianProvider error=${impianAsync.error}');
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
    final List<ImpianModel> listImpianAsli = impianState.listImpian;
    L.i(
      'listImpian.length=${listImpianAsli.length}, totalJumlah=${impianState.totalJumlah}',
    );

    // Saldo terkumpul = uang yang dihemat dari tidak merokok (berdasarkan biodata).
    BiodataModel? biodata;
    if (biodataAsync.isLoading) {
      L.w('biodataAsync loading');
    } else if (biodataAsync.hasError) {
      L.w('biodataAsync error=${biodataAsync.error}');
    } else {
      biodata = biodataAsync.requireValue;
    }
    final uangDihemat = biodata?.uangDihemat ?? 0;
    L.i('uangDihemat=$uangDihemat');

    final List<ImpianModel> listImpian = listImpianAsli.sorted((a, b) {
      switch (_sortImpian) {
        case SortImpian.namaAz:
          return a.nama.compareTo(b.nama);
        case SortImpian.namaZa:
          return b.nama.compareTo(a.nama);
        case SortImpian.jumlahAz:
          return a.jumlah.compareTo(b.jumlah);
        case SortImpian.jumlahZa:
          return b.jumlah.compareTo(a.jumlah);
        case SortImpian.mendekatiTerkumpulAz:
          final sisaA = (a.jumlah - uangDihemat).clamp(0.0, double.infinity);
          final sisaB = (b.jumlah - uangDihemat).clamp(0.0, double.infinity);
          return sisaA.compareTo(sisaB);
        case SortImpian.mendekatiTerkumpulZa:
          final sisaA = (a.jumlah - uangDihemat).clamp(0.0, double.infinity);
          final sisaB = (b.jumlah - uangDihemat).clamp(0.0, double.infinity);
          return sisaB.compareTo(sisaA);
      }
    });
    final jumlahTercapai = listImpian
        .where((item) => uangDihemat >= item.jumlah)
        .length;
    L.i('jumlahTercapai=$jumlahTercapai/${listImpian.length}');

    if (listImpian.isEmpty) {
      L.w('listImpian kosong');
      return Scaffold(
        appBar: AppBar(
          title: const Text('Impian'),
          scrolledUnderElevation: 2,
        ),
        body: const _EmptyImpian(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => unawaited(Nav.to(context, const FormImpian())),
          child: const Icon(CupertinoIcons.add),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impian'),
        scrolledUnderElevation: 2,
        actions: [
          IconButton(
            tooltip: 'Urutkan',
            icon: const Icon(CupertinoIcons.sort_up),
            onPressed: () => _showModalSort(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 8,
            children: [
              _buildSaldoTerkumpul(uangDihemat),
              Text(
                '$jumlahTercapai dari ${listImpian.length} impian tercapai',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: listImpian.length,
                  itemBuilder: (context, index) {
                    final ImpianModel item = listImpian[index];
                    L.i(
                      'item.id=${item.id}, item.nama=${item.nama}, item.jumlah=${item.jumlah}',
                    );
                    return Card(
                      key: ValueKey(item.id),
                      child: ListTile(
                        onTap: () => unawaited(
                          Nav.to(context, DetailImpianScreen(id: item.id)),
                        ),
                        title: Text(item.nama),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            LinearProgressIndicator(
                              value: uangDihemat <= 0 || item.jumlah <= 0
                                  ? 0
                                  : (uangDihemat / item.jumlah).clamp(0.0, 1.0),
                            ),
                            // Bungkus Text dengan Flexible agar tidak overflow pada layar sempit.
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Sisa: ${FormatUang.formatRupiah((item.jumlah - uangDihemat).clamp(0.0, double.infinity))}',
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Target: ${FormatUang.formatRupiah(item.jumlah)}',
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => unawaited(Nav.to(context, const FormImpian())),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }

  Widget _buildSaldoTerkumpul(double saldoTerkumpul) {
    L.i('saldoTerkumpul=$saldoTerkumpul');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Saldo terkumpul'),
            Text(
              '${FormatUang.formatRupiah(saldoTerkumpul)}',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget untuk state kosong daftar impian.
class _EmptyImpian extends StatelessWidget {
  const _EmptyImpian();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(CupertinoIcons.star, size: 48),
              Text(
                'Belum ada impian',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Tekan tombol + untuk menambah impian pertama.',
                textAlign: TextAlign.center,
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
// FILE: lib/fitur/impian/state/impian_state.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'impian_state.freezed.dart';

@freezed
abstract class ImpianState with _$ImpianState {
  const ImpianState._();

  const factory ImpianState({
    @Default([]) List<ImpianModel> listImpian,
    @Default(0) int jumlahImpian,
    @Default(0) double totalJumlah,
  }) = _ImpianState;
}
```


// ============================================================
// FILE: lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart
// ============================================================

```dart
import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman kalender smoke-free.
///
/// Menampilkan kalender bulanan yang menandai hari-hari smoke-free sejak
/// tanggal mulai berhenti merokok, beserta ringkasan progres.
class KalenderSmokeFreeScreen extends ConsumerStatefulWidget {
  const KalenderSmokeFreeScreen({super.key});

  @override
  ConsumerState<KalenderSmokeFreeScreen> createState() =>
      _KalenderSmokeFreeScreenState();
}

class _KalenderSmokeFreeScreenState
    extends ConsumerState<KalenderSmokeFreeScreen> {
  DateTime _bulanDitampilkan = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  );

  static const List<String> _namaHari = [
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min',
  ];

  @override
  void initState() {
    super.initState();
    L.i('KalenderSmokeFreeScreen initState');
  }

  @override
  void dispose() {
    L.i('KalenderSmokeFreeScreen dispose');
    super.dispose();
  }

  void _bulanSebelumnya() {
    setState(() {
      _bulanDitampilkan = DateTime(
        _bulanDitampilkan.year,
        _bulanDitampilkan.month - 1,
      );
    });
  }

  void _bulanBerikutnya() {
    setState(() {
      _bulanDitampilkan = DateTime(
        _bulanDitampilkan.year,
        _bulanDitampilkan.month + 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);

    if (biodataAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      L.e(
        'biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}',
      );
      return Scaffold(
        appBar: AppBar(title: const Text('Kalender Smoke-Free')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const Text('Gagal memuat data'),
                  OutlinedButton(
                    onPressed: () {
                      final _ = ref.refresh(biodataProvider);
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final biodata = biodataAsync.requireValue;
    if (biodata == null) {
      return _buildBiodataNull();
    }

    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    if (tanggalBerhenti == null) {
      return _buildBelumBerhenti();
    }

    final hariIni = DateTime.now();
    final hariIniDate = DateTime(hariIni.year, hariIni.month, hariIni.day);
    final tanggalBerhentiDate = DateTime(
      tanggalBerhenti.year,
      tanggalBerhenti.month,
      tanggalBerhenti.day,
    );

    final totalSmokeFree =
        hariIniDate.difference(tanggalBerhentiDate).inDays + 1;
    final totalSmokeFreeAman = totalSmokeFree < 0 ? 0 : totalSmokeFree;

    return Scaffold(
      appBar: AppBar(title: const Text('Kalender Smoke-Free')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RingkasanSmokeFree(
                tanggalBerhenti: tanggalBerhentiDate,
                totalSmokeFree: totalSmokeFreeAman,
              ),
              _NavigasiBulan(
                bulan: _bulanDitampilkan,
                onSebelumnya: _bulanSebelumnya,
                onBerikutnya: _bulanBerikutnya,
              ),
              _HeaderHari(namaHari: _namaHari),
              Expanded(
                child: _GridKalender(
                  bulan: _bulanDitampilkan,
                  tanggalBerhenti: tanggalBerhentiDate,
                  hariIni: hariIniDate,
                ),
              ),
              const _Legenda(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBiodataNull() {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalender Smoke-Free')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                const Text('Belum ada data biodata'),
                OutlinedButton(
                  onPressed: () => unawaited(
                    Nav.to(context, const FormBiodata(buatPertama: false)),
                  ),
                  child: const Text('Isi Biodata'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBelumBerhenti() {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalender Smoke-Free')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                const Icon(CupertinoIcons.calendar, size: 48),
                const Text(
                  'Belum ada tanggal mulai berhenti merokok.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Isi tanggal mulai berhenti pada biodata untuk melihat '
                  'kalender smoke-free.',
                  textAlign: TextAlign.center,
                ),
                OutlinedButton(
                  onPressed: () => unawaited(
                    Nav.to(context, const FormBiodata(buatPertama: false)),
                  ),
                  child: const Text('Isi Biodata'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RingkasanSmokeFree extends StatelessWidget {
  const _RingkasanSmokeFree({
    required this.tanggalBerhenti,
    required this.totalSmokeFree,
  });

  final DateTime tanggalBerhenti;
  final int totalSmokeFree;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(
              'Total hari smoke-free',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$totalSmokeFree hari',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              'Sejak ${FormatTanggal.formatDasar(tanggalBerhenti)}',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigasiBulan extends StatelessWidget {
  const _NavigasiBulan({
    required this.bulan,
    required this.onSebelumnya,
    required this.onBerikutnya,
  });

  final DateTime bulan;
  final VoidCallback onSebelumnya;
  final VoidCallback onBerikutnya;

  static const List<String> _namaBulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onSebelumnya,
          icon: const Icon(CupertinoIcons.chevron_left),
          tooltip: 'Bulan sebelumnya',
        ),
        Text(
          '${_namaBulan[bulan.month - 1]} ${bulan.year}',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: onBerikutnya,
          icon: const Icon(CupertinoIcons.chevron_right),
          tooltip: 'Bulan berikutnya',
        ),
      ],
    );
  }
}

class _HeaderHari extends StatelessWidget {
  const _HeaderHari({required this.namaHari});

  final List<String> namaHari;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final h in namaHari)
          Expanded(
            child: Center(
              child: Text(
                h,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}

class _GridKalender extends StatelessWidget {
  const _GridKalender({
    required this.bulan,
    required this.tanggalBerhenti,
    required this.hariIni,
  });

  final DateTime bulan;
  final DateTime tanggalBerhenti;
  final DateTime hariIni;

  @override
  Widget build(BuildContext context) {
    final tahun = bulan.year;
    final bulanIndex = bulan.month;
    final hariPertama = DateTime(tahun, bulanIndex, 1);
    // Monday=1..Sunday=7. Grid Monday-first.
    final offset = (hariPertama.weekday - 1) % 7;
    final jumlahHari = DateTime(tahun, bulanIndex + 1, 0).day;

    final cells = <Widget>[];
    for (int i = 0; i < offset; i++) {
      cells.add(const SizedBox.shrink());
    }
    for (int hari = 1; hari <= jumlahHari; hari++) {
      final tanggal = DateTime(tahun, bulanIndex, hari);
      cells.add(
        _SelHari(
          tanggal: tanggal,
          tanggalBerhenti: tanggalBerhenti,
          hariIni: hariIni,
        ),
      );
    }
    // Pad to multiple of 7.
    while (cells.length % 7 != 0) {
      cells.add(const SizedBox.shrink());
    }

    return GridView.count(
      crossAxisCount: 7,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      physics: const NeverScrollableScrollPhysics(),
      children: cells,
    );
  }
}

class _SelHari extends StatelessWidget {
  const _SelHari({
    required this.tanggal,
    required this.tanggalBerhenti,
    required this.hariIni,
  });

  final DateTime tanggal;
  final DateTime tanggalBerhenti;
  final DateTime hariIni;

  @override
  Widget build(BuildContext context) {
    final sebelumBerhenti = tanggal.isBefore(tanggalBerhenti);
    final setelahHariIni = tanggal.isAfter(hariIni);
    final hariIniFlag = tanggal == hariIni;

    Color? warnaLatar;
    if (sebelumBerhenti) {
      warnaLatar = null;
    } else if (setelahHariIni) {
      warnaLatar = null;
    } else {
      warnaLatar = Colors.green.withValues(alpha: 0.25);
    }

    return Container(
      decoration: BoxDecoration(
        color: warnaLatar,
        borderRadius: BorderRadius.circular(8),
        border: hariIniFlag
            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '${tanggal.day}',
        style: TextStyle(
          fontWeight: hariIniFlag ? FontWeight.bold : FontWeight.normal,
          color: sebelumBerhenti
              ? Theme.of(context).disabledColor
              : (setelahHariIni
                    ? Theme.of(context).disabledColor
                    : Colors.green.shade800),
        ),
      ),
    );
  }
}

class _Legenda extends StatelessWidget {
  const _Legenda();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      spacing: 16,
      children: [
        _ItemLegenda(
          warna: Colors.green.withValues(alpha: 0.25),
          label: 'Smoke-free',
          textTheme: textTheme,
        ),
        _ItemLegenda(
          warna: null,
          label: 'Belum/Lainnya',
          textTheme: textTheme,
          border: true,
        ),
      ],
    );
  }
}

class _ItemLegenda extends StatelessWidget {
  const _ItemLegenda({
    required this.warna,
    required this.label,
    required this.textTheme,
    this.border = false,
  });

  final Color? warna;
  final String label;
  final TextTheme textTheme;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: warna,
            borderRadius: BorderRadius.circular(4),
            border: border
                ? Border.all(color: Theme.of(context).disabledColor)
                : null,
          ),
        ),
        Text(label, style: textTheme.bodySmall),
      ],
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart
// ============================================================

```dart
import 'dart:async';

import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/shared/konstanta/milestone_kesehatan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman pemulihan kesehatan (milestone) berdasarkan durasi smoke-free.
///
/// Menampilkan daftar milestone kesehatan yang dicapai seiring waktu tanpa
/// rokok, beserta status tercapai/belum.
class PemulihanKesehatanScreen extends ConsumerStatefulWidget {
  const PemulihanKesehatanScreen({super.key});

  @override
  ConsumerState<PemulihanKesehatanScreen> createState() =>
      _PemulihanKesehatanScreenState();
}

class _PemulihanKesehatanScreenState
    extends ConsumerState<PemulihanKesehatanScreen> {
  @override
  void initState() {
    super.initState();
    L.i('PemulihanKesehatanScreen initState');
  }

  @override
  void dispose() {
    L.i('PemulihanKesehatanScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);

    if (biodataAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (biodataAsync.hasError) {
      L.e(
        'biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}',
      );
      return Scaffold(
        appBar: AppBar(title: const Text('Pemulihan Kesehatan')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const Text('Gagal memuat data'),
                  OutlinedButton(
                    onPressed: () {
                      final _ = ref.refresh(biodataProvider);
                    },
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final biodata = biodataAsync.requireValue;
    if (biodata == null) {
      return _buildBiodataNull();
    }

    final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
    if (tanggalBerhenti == null) {
      return _buildBelumBerhenti();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pemulihan Kesehatan')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderPemulihan(tanggalBerhenti: tanggalBerhenti),
              Expanded(
                child: ListView.separated(
                  itemCount: daftarMilestoneKesehatan.length,
                  itemBuilder: (context, index) {
                    final m = daftarMilestoneKesehatan[index];
                    final durasi = DateTime.now().difference(tanggalBerhenti);
                    final aman = durasi.isNegative ? Duration.zero : durasi;
                    final tercapai = aman >= m.target;
                    return Card(
                      key: ValueKey(m.judul),
                      child: ListTile(
                        leading: Icon(
                          tercapai
                              ? CupertinoIcons.check_mark_circled_solid
                              : CupertinoIcons.clock,
                          color: tercapai ? Colors.green : null,
                        ),
                        title: Text(
                          m.judul,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: tercapai ? Colors.green : null,
                              ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(m.deskripsi),
                            Text(
                              'Target: ${_formatTarget(m.target)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBiodataNull() {
    return Scaffold(
      appBar: AppBar(title: const Text('Pemulihan Kesehatan')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                const Text('Belum ada data biodata'),
                OutlinedButton(
                  onPressed: () => unawaited(
                    Nav.to(context, const FormBiodata(buatPertama: false)),
                  ),
                  child: const Text('Isi Biodata'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBelumBerhenti() {
    return Scaffold(
      appBar: AppBar(title: const Text('Pemulihan Kesehatan')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                const Icon(CupertinoIcons.heart, size: 48),
                const Text(
                  'Belum ada tanggal mulai berhenti merokok.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Isi tanggal mulai berhenti pada biodata untuk melihat '
                  'pemulihan kesehatan.',
                  textAlign: TextAlign.center,
                ),
                OutlinedButton(
                  onPressed: () => unawaited(
                    Nav.to(context, const FormBiodata(buatPertama: false)),
                  ),
                  child: const Text('Isi Biodata'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _formatTarget(Duration d) {
    if (d.inDays >= 365) {
      final tahun = (d.inDays / 365).round();
      if (tahun == 1) return '1 tahun';
      return '$tahun tahun';
    }
    if (d.inDays >= 30) {
      final bulan = (d.inDays / 30).round();
      if (bulan == 1) return '1 bulan';
      return '$bulan bulan';
    }
    if (d.inDays >= 7) {
      final minggu = (d.inDays / 7).round();
      if (minggu == 1) return '1 minggu';
      return '$minggu minggu';
    }
    if (d.inDays >= 1) {
      if (d.inDays == 1) return '1 hari';
      return '${d.inDays} hari';
    }
    if (d.inHours >= 1) {
      if (d.inHours == 1) return '1 jam';
      return '${d.inHours} jam';
    }
    return '${d.inMinutes} menit';
  }
}

/// Widget header yang menampilkan durasi smoke-free dan milestone berikutnya.
///
/// Menggunakan [Timer] sendiri agar hanya widget ini yang rebuild setiap detik,
/// bukan seluruh halaman.
class _HeaderPemulihan extends StatefulWidget {
  const _HeaderPemulihan({required this.tanggalBerhenti});

  final DateTime tanggalBerhenti;

  @override
  State<_HeaderPemulihan> createState() => _HeaderPemulihanState();
}

class _HeaderPemulihanState extends State<_HeaderPemulihan> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    L.i('HeaderPemulihan initState');
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    L.i('HeaderPemulihan dispose');
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final durasiSmokeFree = DateTime.now().difference(widget.tanggalBerhenti);
    final durasi = durasiSmokeFree.isNegative ? Duration.zero : durasiSmokeFree;
    final berikutnya = milestoneBerikutnya(durasi);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Lama smoke-free',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _formatDurasi(durasi),
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Sejak ${FormatTanggal.formatDasar(widget.tanggalBerhenti)}',
              style: textTheme.bodySmall,
            ),
            if (berikutnya != null) ...[
              const SizedBox(height: 4),
              Text(
                'Milestone berikutnya: ${berikutnya.judul}',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Tersisa ${_formatDurasi(berikutnya.target - durasi)}',
                style: textTheme.bodySmall,
              ),
            ] else
              Text(
                'Semua milestone tercapai. Selamat!',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDurasi(Duration d) {
    if (d.inDays > 0) {
      final hari = d.inDays;
      final jam = d.inHours % 24;
      final menit = d.inMinutes % 60;
      final bagian = <String>['$hari hari'];
      if (jam > 0) bagian.add('$jam jam');
      if (menit > 0) bagian.add('$menit menit');
      return bagian.join(' ');
    }
    if (d.inHours > 0) {
      final jam = d.inHours;
      final menit = d.inMinutes % 60;
      final detik = d.inSeconds % 60;
      final bagian = <String>['$jam jam'];
      if (menit > 0) bagian.add('$menit menit');
      bagian.add('$detik detik');
      return bagian.join(' ');
    }
    final menit = d.inMinutes;
    final detik = d.inSeconds % 60;
    if (menit > 0) return '$menit menit $detik detik';
    return '$detik detik';
  }
}
```


// ============================================================
// FILE: lib/fitur/pengaturan/screens/pengaturan_screen.dart
// ============================================================

```dart
import 'dart:async';

import 'package:berhenti_merokok/fitur/tema/enum/tema_enum.dart';
import 'package:berhenti_merokok/fitur/tema/notifier/tema_notifier.dart';
import 'package:berhenti_merokok/shared/notifikasi/notifikasi_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  bool _sedangMemproses = false;

  @override
  void initState() {
    super.initState();
    unawaited(
      Future.microtask(_muatPreferensiNotifikasi)
          .catchError((Object e, StackTrace s) {
            L.e('Gagal memuat preferensi notifikasi: $e $s');
          }),
    );
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
    if (_sedangMemproses) return;
    L.i('value=$value');
    setState(() {
      _sedangMemproses = true;
      _notifikasiAktif = value;
    });
    unawaited(
      EasyLoading.show(
        status: 'Memproses...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
      }),
    );
    try {
      if (value) {
        final izin = await NotifikasiService.mintaIzin();
        if (!mounted) return;
        if (!izin) {
          setState(() {
            _notifikasiAktif = false;
          });
          AppToast.gagal(context, 'Izin notifikasi tidak diberikan');
          return;
        }
        await NotifikasiService.jadwalkanPengingatHarian(
          jam: _jam,
          menit: _menit,
        );
        if (!mounted) return;
        AppToast.sukses(context, 'Pengingat harian diaktifkan');
      } else {
        await NotifikasiService.batalkanPengingatHarian();
        if (!mounted) return;
        AppToast.info(context, 'Pengingat harian dinonaktifkan');
      }
    } on Exception catch (e, s) {
      L.e('Gagal mengubah notifikasi: $e $s');
      if (mounted) {
        final isIzin = e is IzinNotifikasiTidakDiberikanException;
        try {
          final aktifSekarang = await NotifikasiService.aktif();
          if (!mounted) return;
          setState(() {
            _notifikasiAktif = aktifSekarang;
          });
        } on Exception catch (e2, s2) {
          L.e('Gagal membaca status aktif notifikasi: $e2 $s2');
        }
        if (isIzin) {
          if (mounted) {
            AppToast.gagal(context, 'Izin notifikasi tidak tersedia');
          }
          try {
            await _muatPreferensiNotifikasi();
          } on Exception catch (e2, s2) {
            L.e('Gagal memuat preferensi notifikasi: $e2 $s2');
          }
          if (!mounted) return;
        } else if (mounted) {
          AppToast.gagal(context, 'Gagal mengubah pengingat harian');
        }
      }
    } on UnsupportedError catch (e, s) {
      L.e('Platform tidak mendukung notifikasi: $e $s');
      if (mounted) {
        setState(() {
          _notifikasiAktif = false;
        });
        AppToast.gagal(context, 'Platform tidak mendukung pengingat harian');
      }
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  Future<void> _pilihWaktu() async {
    if (_sedangMemproses) return;
    L.i('jam=$_jam, menit=$_menit');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _jam, minute: _menit),
    );
    if (!mounted) return;
    if (picked == null) return;
    L.i('picked=${picked.hour}:${picked.minute}');
    final jamLama = _jam;
    final menitLama = _menit;
    final jamBaru = picked.hour;
    final menitBaru = picked.minute;
    setState(() {
      _sedangMemproses = true;
    });
    unawaited(
      EasyLoading.show(
        status: 'Memproses...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
      }),
    );
    try {
      if (_notifikasiAktif) {
        await NotifikasiService.jadwalkanPengingatHarian(
          jam: jamBaru,
          menit: menitBaru,
        );
        if (!mounted) return;
        setState(() {
          _jam = jamBaru;
          _menit = menitBaru;
        });
        AppToast.sukses(context, 'Waktu pengingat diperbarui');
      } else {
        await NotifikasiService.setWaktu(jamBaru, menitBaru);
        if (!mounted) return;
        setState(() {
          _jam = jamBaru;
          _menit = menitBaru;
        });
      }
    } on Exception catch (e, s) {
      L.e('Gagal memperbarui waktu pengingat: $e $s');
      if (mounted) {
        setState(() {
          _jam = jamLama;
          _menit = menitLama;
        });
        AppToast.gagal(context, 'Gagal memperbarui waktu pengingat');
      }
    } on UnsupportedError catch (e, s) {
      L.e('Platform tidak mendukung notifikasi: $e $s');
      if (mounted) {
        setState(() {
          _jam = jamLama;
          _menit = menitLama;
        });
        AppToast.gagal(context, 'Platform tidak mendukung pengingat harian');
      }
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  Future<void> _ujiNotifikasi() async {
    if (_sedangMemproses) return;
    L.i('uji notifikasi');
    setState(() {
      _sedangMemproses = true;
    });
    unawaited(
      EasyLoading.show(
        status: 'Memproses...',
        maskType: EasyLoadingMaskType.black,
      ).catchError((Object e, StackTrace s) {
        L.e('Gagal menampilkan loading: $e $s');
      }),
    );
    try {
      await NotifikasiService.tampilkanSekarang();
      if (!mounted) return;
      AppToast.info(context, 'Notifikasi uji coba ditampilkan');
    } on Exception catch (e, s) {
      L.e('Gagal menampilkan notifikasi uji coba: $e $s');
      if (!mounted) return;
      AppToast.gagal(context, 'Gagal menampilkan notifikasi');
    } finally {
      unawaited(
        EasyLoading.dismiss().catchError((Object e, StackTrace s) {
          L.e('Gagal menutup loading: $e $s');
        }),
      );
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
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
    // Platform yang tidak mendukung notifikasi terjadwal (Web, Linux, Windows).
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows) {
      return const SizedBox.shrink();
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
              onChanged: _sedangMemproses
                  ? null
                  : (value) {
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
              onPressed: _sedangMemproses
                  ? null
                  : () {
                      unawaited(_pilihWaktu());
                    },
              child: const Text('Ubah waktu'),
            ),
          ],
        ),
        OutlinedButton(
          onPressed: _sedangMemproses
              ? null
              : () {
                  unawaited(_ujiNotifikasi());
                },
          child: const Text('Uji coba notifikasi'),
        ),
      ],
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/sos_craving/screens/sos_craving_screen.dart
// ============================================================

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';

/// Halaman bantuan cepat saat craving (SOS Craving).
///
/// Menyediakan latihan napas 4-7-8, timer craving 3 menit, dan daftar
/// distraksi untuk membantu pengguna melewati dorongan merokok.
class SosCravingScreen extends ConsumerStatefulWidget {
  const SosCravingScreen({super.key});

  @override
  ConsumerState<SosCravingScreen> createState() => _SosCravingScreenState();
}

class _SosCravingScreenState extends ConsumerState<SosCravingScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    L.i('SosCravingScreen initState');
  }

  @override
  void dispose() {
    L.i('SosCravingScreen dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SOS Craving'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Napas 4-7-8'),
              Tab(text: 'Timer 3 Menit'),
              Tab(text: 'Distraksi'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _Napas478View(textTheme: textTheme),
              const _TimerCravingView(),
              const _DistraksiView(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Latihan napas 4-7-8: tarik 4 detik, tahan 7 detik, hembuskan 8 detik.
class _Napas478View extends StatefulWidget {
  const _Napas478View({required this.textTheme});

  final TextTheme textTheme;

  @override
  State<_Napas478View> createState() => _Napas478ViewState();
}

class _Napas478ViewState extends State<_Napas478View> {
  Timer? _timer;
  bool _berjalan = false;
  int _faseIndex = 0; // 0 tarik, 1 tahan, 2 hembus
  int _sisaFase = 4;
  int _siklus = 0;

  static const List<({String label, int durasi})> _fase = [
    (label: 'Tarik napas', durasi: 4),
    (label: 'Tahan', durasi: 7),
    (label: 'Hembuskan', durasi: 8),
  ];

  static const int _targetSiklus = 4;

  @override
  void initState() {
    super.initState();
    L.i('Napas478View initState');
  }

  @override
  void dispose() {
    L.i('Napas478View dispose');
    _timer?.cancel();
    super.dispose();
  }

  void _mulai() {
    if (_berjalan) return;
    L.i('mulai napas 4-7-8');
    setState(() {
      _berjalan = true;
      _faseIndex = 0;
      _sisaFase = _fase[0].durasi;
      _siklus = 0;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void _tick(Timer _) {
    if (!mounted) return;
    setState(() {
      _sisaFase--;
      if (_sisaFase <= 0) {
        _faseIndex++;
        if (_faseIndex >= _fase.length) {
          _faseIndex = 0;
          _siklus++;
          if (_siklus >= _targetSiklus) {
            _selesai();
            return;
          }
        }
        _sisaFase = _fase[_faseIndex].durasi;
      }
    });
  }

  void _selesai() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
    });
    L.i('napas 4-7-8 selesai, siklus=$_siklus');
    AppToast.sukses(context, 'Latihan napas selesai. Anda hebat!');
  }

  void _henti() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
    });
    L.i('napas 4-7-8 dihentikan');
  }

  void _reset() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
      _faseIndex = 0;
      _sisaFase = _fase[0].durasi;
      _siklus = 0;
    });
    L.i('napas 4-7-8 reset');
  }

  double get _skalaLingkaran {
    if (!_berjalan) return 0.6;
    switch (_faseIndex) {
      case 0: // tarik: membesar
        final durasi = _fase[0].durasi;
        final progres = 1 - (_sisaFase / durasi);
        return 0.6 + (0.4 * progres);
      case 1: // tahan
        return 1.0;
      case 2: // hembus: mengecil
        final durasi = _fase[2].durasi;
        final progres = 1 - (_sisaFase / durasi);
        return 1.0 - (0.4 * progres);
      default:
        return 0.6;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fase = _fase[_faseIndex];
    final warna = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Latihan Napas 4-7-8',
            style: widget.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Tarik napas 4 detik, tahan 7 detik, hembuskan 8 detik. '
            'Ulangi $_targetSiklus kali.',
            textAlign: TextAlign.center,
            style: widget.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            width: 200 * _skalaLingkaran,
            height: 200 * _skalaLingkaran,
            decoration: BoxDecoration(
              color: warna.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: warna, width: 3),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _berjalan ? fase.label : 'Siap',
                  style: widget.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _berjalan ? '$_sisaFase' : '$_targetSiklus siklus',
                  style: widget.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (_berjalan)
            Text(
              'Siklus ${_siklus + 1} dari $_targetSiklus',
              style: widget.textTheme.bodyMedium,
            ),
          const SizedBox(height: 8),
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_berjalan)
                FilledButton.icon(
                  onPressed: _mulai,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Mulai'),
                )
              else
                FilledButton.icon(
                  onPressed: _henti,
                  icon: const Icon(Icons.pause),
                  label: const Text('Jeda'),
                ),
              OutlinedButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Timer craving 3 menit.
class _TimerCravingView extends StatefulWidget {
  const _TimerCravingView();

  @override
  State<_TimerCravingView> createState() => _TimerCravingViewState();
}

class _TimerCravingViewState extends State<_TimerCravingView> {
  static const int _durasiAwal = 3 * 60;
  Timer? _timer;
  bool _berjalan = false;
  int _sisa = _durasiAwal;

  @override
  void initState() {
    super.initState();
    L.i('TimerCravingView initState');
  }

  @override
  void dispose() {
    L.i('TimerCravingView dispose');
    _timer?.cancel();
    super.dispose();
  }

  void _mulai() {
    if (_berjalan) return;
    if (_sisa <= 0) {
      _sisa = _durasiAwal;
    }
    L.i('timer craving mulai, sisa=$_sisa');
    setState(() {
      _berjalan = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void _tick(Timer _) {
    if (!mounted) return;
    setState(() {
      _sisa--;
      if (_sisa <= 0) {
        _selesai();
      }
    });
  }

  void _selesai() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
      _sisa = 0;
    });
    L.i('timer craving selesai');
    AppToast.sukses(
      context,
      '3 menit berlalu. Craving biasanya singkat. Anda berhasil!',
    );
  }

  void _jeda() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
    });
    L.i('timer craving dijeda');
  }

  void _reset() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _berjalan = false;
      _sisa = _durasiAwal;
    });
    L.i('timer craving reset');
  }

  String get _teksWaktu {
    final menit = (_sisa ~/ 60).toString().padLeft(2, '0');
    final detik = (_sisa % 60).toString().padLeft(2, '0');
    return '$menit:$detik';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final progres = 1 - (_sisa / _durasiAwal);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Timer Craving',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Craving biasanya berlangsung sekitar 3 menit. '
            'Tahan dorongan hingga waktu habis.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progres.clamp(0.0, 1.0),
                  strokeWidth: 12,
                ),
                Center(
                  child: Text(
                    _teksWaktu,
                    style: textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_berjalan)
                FilledButton.icon(
                  onPressed: _mulai,
                  icon: const Icon(Icons.play_arrow),
                  label: Text(_sisa == 0 ? 'Ulangi' : 'Mulai'),
                )
              else
                FilledButton.icon(
                  onPressed: _jeda,
                  icon: const Icon(Icons.pause),
                  label: const Text('Jeda'),
                ),
              OutlinedButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Daftar distraksi sederhana.
class _DistraksiView extends StatefulWidget {
  const _DistraksiView();

  @override
  State<_DistraksiView> createState() => _DistraksiViewState();
}

class _DistraksiViewState extends State<_DistraksiView> {
  int _berhasil = 0;

  static const List<String> _aktivitas = [
    'Minum segelas air putih',
    'Jalan kaki 5 menit',
    'Makan permen atau buah',
    'Cuci muka dengan air dingin',
    'Telepon teman atau keluarga',
    'Dengarkan musik favorit',
    'Lakukan 10 kali push-up ringan',
    'Baca 1 halaman buku',
  ];

  @override
  void initState() {
    super.initState();
    L.i('DistraksiView initState');
  }

  @override
  void dispose() {
    L.i('DistraksiView dispose, berhasil=$_berhasil');
    super.dispose();
  }

  void _tandaiBerhasil() {
    setState(() {
      _berhasil++;
    });
    L.i('distraksi berhasil, total=$_berhasil');
    AppToast.sukses(context, 'Craving berhasil dilewati!');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Distraksi',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Pilih aktivitas untuk mengalihkan perhatian dari craving.',
            style: textTheme.bodyMedium,
          ),
          if (_berhasil > 0)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Craving dilewati: $_berhasil kali',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Expanded(
            child: ListView.separated(
              itemCount: _aktivitas.length,
              itemBuilder: (context, index) {
                final aktivitas = _aktivitas[index];
                return ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(aktivitas),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    L.i('distraksi dipilih: $aktivitas');
                    AppToast.info(context, aktivitas);
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 4),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _tandaiBerhasil,
              icon: const Icon(Icons.verified),
              label: const Text('Saya berhasil melewati craving'),
            ),
          ),
        ],
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/tema/enum/tema_enum.dart
// ============================================================

```dart
import 'package:flutter/material.dart';

/// Enum mode tema aplikasi.
enum TemaEnum { sistem, terang, gelap }

/// Extension yang menyediakan label dan ikon untuk [TemaEnum].
extension TemaEnumExtension on TemaEnum {
  String get label {
    switch (this) {
      case TemaEnum.sistem:
        return 'Sistem';
      case TemaEnum.terang:
        return 'Terang';
      case TemaEnum.gelap:
        return 'Gelap';
    }
  }

  IconData get icon {
    switch (this) {
      case TemaEnum.sistem:
        return Icons.brightness_auto;
      case TemaEnum.terang:
        return Icons.light_mode;
      case TemaEnum.gelap:
        return Icons.dark_mode;
    }
  }
}
```


// ============================================================
// FILE: lib/fitur/tema/notifier/tema_notifier.dart
// ============================================================

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:berhenti_merokok/fitur/tema/enum/tema_enum.dart';
import 'package:berhenti_merokok/shared/helper/shared_keys.dart';

part 'tema_notifier.g.dart';

// Pengecualian aturan Freezed untuk state sederhana berbasis enum:
// state tema hanya menyimpan satu nilai TemaEnum, sehingga tidak
// memerlukan state Freezed tersendiri, konsisten dengan BiodataNotifier
// yang juga menggunakan model nullable langsung sebagai state.
@Riverpod(keepAlive: true)
class TemaNotifier extends _$TemaNotifier {
  @override
  Future<TemaEnum> build() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(SharedKeys.tema);
    return TemaEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TemaEnum.sistem,
    );
  }

  Future<void> set([TemaEnum? tema]) async {
    final nilai = tema ?? state.asData?.value ?? TemaEnum.sistem;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedKeys.tema, nilai.name);
    state = AsyncValue.data(nilai);
  }
}
```


// ============================================================
// FILE: lib/home.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/biodata/screens/biodata_screen.dart';
import 'package:berhenti_merokok/fitur/dashboard/screens/dashboard_screen.dart';
import 'package:berhenti_merokok/fitur/impian/screens/impian_screen.dart';
import 'package:berhenti_merokok/lainnya_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int _selectedIndex = 0;

  // Tab yang sudah pernah dibuka; awalnya hanya tab 0 (Dashboard).
  final Set<int> _tabTerbuka = {0};

  // GlobalKey per tab agar currentState tetap dapat diakses untuk
  // fitur scroll-to-top setelah tab dibuka. LainnyaScreen adalah
  // StatelessWidget sehingga key-nya tidak bertipe State.
  final GlobalKey _kunciDashboard = GlobalKey();
  final GlobalKey _kunciBiodata = GlobalKey();
  final GlobalKey _kunciImpian = GlobalKey();
  final GlobalKey _kunciLainnya = GlobalKey();

  // Waktu tap terakhir untuk deteksi double-tap pada tab aktif.
  DateTime? _lastTapTime;
  static const Duration _durasiDoubleTap = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
    // Periksa state == null terlebih dahulu (tab belum dibuka) agar tidak crash.
    final state = switch (i) {
      0 => _kunciDashboard.currentState,
      1 => _kunciBiodata.currentState,
      2 => _kunciImpian.currentState,
      _ => _kunciLainnya.currentState,
    };
    if (state == null) {
      return;
    }
    // Hanya panggil scrollToTop() apabila state mengimplementasikan
    // ScrollKeAtas; pada proyek ini layar tab belum menyediakannya.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea dan Padding tepi layar pada lapisan container halaman
      // agar konten tidak tertutup notch/status bar/navigation bar
      // dan tidak menempel pada tepi layar.
      body: IndexedStack(
        index: _selectedIndex,
        children: List<Widget>.generate(4, (i) {
          if (!_tabTerbuka.contains(i)) {
            return const SizedBox.shrink();
          }
          return switch (i) {
            0 => DashboardScreen(key: _kunciDashboard),
            1 => BiodataScreen(key: _kunciBiodata),
            2 => ImpianScreen(key: _kunciImpian),
            _ => LainnyaScreen(key: _kunciLainnya),
          };
        }),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _saatPilihTab,
        destinations: [
          NavigationDestination(
            icon: const Icon(CupertinoIcons.home),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: const Icon(CupertinoIcons.person),
            label: 'Biodata',
          ),
          NavigationDestination(
            icon: const Icon(CupertinoIcons.star),
            label: 'Impian',
          ),
          NavigationDestination(
            icon: const Icon(CupertinoIcons.ellipsis),
            label: 'Lainnya',
          ),
        ],
      ),
    );
  }
}
```


// ============================================================
// FILE: lib/lainnya_screen.dart
// ============================================================

```dart
import 'package:berhenti_merokok/fitur/diary_craving/screens/diary_craving_screen.dart';
import 'package:berhenti_merokok/fitur/dummy/screens/dummy_screen.dart';
import 'package:berhenti_merokok/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart';
import 'package:berhenti_merokok/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart';
import 'package:berhenti_merokok/fitur/pengaturan/screens/pengaturan_screen.dart';
import 'package:berhenti_merokok/fitur/sos_craving/screens/sos_craving_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_global_saya/core_shared.dart';

class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lainnya')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildTombolCustom(
              () => Nav.to(context, const PengaturanScreen()),
              'Pengaturan',
            ),
            _buildTombolCustom(() => Nav.to(context, DummyScreen()), 'Dummy'),
            _buildTombolCustom(
              () => Nav.to(context, const SosCravingScreen()),
              'SOS Craving',
            ),
            _buildTombolCustom(
              () => Nav.to(context, const PemulihanKesehatanScreen()),
              'Pemulihan Kesehatan',
            ),
            _buildTombolCustom(
              () => Nav.to(context, const DiaryCravingScreen()),
              'Diary Craving',
            ),
            _buildTombolCustom(
              () => Nav.to(context, const KalenderSmokeFreeScreen()),
              'Kalender Smoke-Free',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTombolCustom(VoidCallback ontap, String title) {
    return ListTile(
      onTap: ontap,
      title: Text(title),
      trailing: Icon(CupertinoIcons.chevron_right),
    );
  }
}
```


// ============================================================
// FILE: lib/main.dart
// ============================================================

```dart
import 'package:berhenti_merokok/app.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite.dart';
import 'package:berhenti_merokok/shared/notifikasi/notifikasi_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

export 'package:berhenti_merokok/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  try {
    await AppDatabase.database;
  } on Exception catch (e, s) {
    p('Gagal inisialisasi database: $e $s');
    rethrow;
  }
  try {
    await NotifikasiService.inisialisasi();
  } on Exception catch (e, s) {
    p('Gagal inisialisasi notifikasi: $e $s');
  } on UnsupportedError catch (e, s) {
    p('Platform tidak mendukung notifikasi: $e $s');
  }
  runApp(const ProviderScope(child: App()));
  WidgetsBinding.instance.addPostFrameCallback((_) {
    NotifikasiService.cekNotifikasiSaatBuka();
  });
}
```


// ============================================================
// FILE: lib/shared/db/sqflite/sqflite.dart
// ============================================================

```dart
import 'package:flutter/foundation.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Konfigurasi dan akses database SQLite untuk aplikasi berhenti_merokok.
///
/// Database menggunakan factory default sqflite yang didukung Android.
class AppDatabase {
  AppDatabase._();

  static Database? _database;

  /// Nama file database SQLite.
  static const String _namaDatabase = 'berhenti_merokok.db';

  /// Versi skema database.
  static const int _versiDatabase = 6;

  /// Mengembalikan instance database, membuatnya jika belum tersedia.
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _inisialisasiDatabase();
    return _database!;
  }

  /// Membuka dan menginisialisasi database SQLite.
  static Future<Database> _inisialisasiDatabase() async {
    final pathDatabase = await getDatabasesPath();
    final path = join(pathDatabase, _namaDatabase);

    return await openDatabase(
      path,
      version: _versiDatabase,
      onCreate: _buatTabel,
      onUpgrade: _onUpgrade,
    );
  }

  /// Membuat tabel-tabel saat database pertama kali dibuat.
  static Future<void> _buatTabel(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${NamaTabel.biodata}(
        ${NamaKolom.id} TEXT PRIMARY KEY,
        ${NamaKolom.nama} TEXT NOT NULL,
        ${NamaKolom.tanggalLahir} TEXT,
        ${NamaKolom.jumlahRokokPerHari} INTEGER,
        ${NamaKolom.hargaRokokPerBungkus} REAL,
        ${NamaKolom.batangPerBungkus} REAL,
        ${NamaKolom.tanggalMulaiMerokok} TEXT,
        ${NamaKolom.tanggalMulaiBerhentiMerokok} TEXT,
        ${NamaKolom.modeBerhenti} TEXT,
        ${NamaKolom.penurunanPerMinggu} INTEGER,
        ${NamaKolom.tanggalMulaiTapering} TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${NamaTabel.impian}(
        ${NamaKolom.id} TEXT PRIMARY KEY,
        ${NamaKolom.nama} TEXT NOT NULL,
        ${NamaKolom.targetTanggal} TEXT,
        ${NamaKolom.dibuat} TEXT,
        ${NamaKolom.jumlah} REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${NamaTabel.diaryCraving}(
        ${NamaKolom.id} TEXT PRIMARY KEY,
        ${NamaKolom.tanggal} TEXT,
        ${NamaKolom.pemicu} TEXT NOT NULL,
        ${NamaKolom.intensitas} INTEGER,
        ${NamaKolom.catatan} TEXT,
        ${NamaKolom.dibuat} TEXT
      )
    ''');
  }

  /// Memperbarui skema database saat versi meningkat.
  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (kDebugMode) {
      debugPrint('oldVersion=$oldVersion, newVersion=$newVersion');
    }
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${NamaTabel.impian}(
          ${NamaKolom.id} TEXT PRIMARY KEY,
          ${NamaKolom.nama} TEXT NOT NULL,
          ${NamaKolom.targetTanggal} TEXT,
          ${NamaKolom.dibuat} TEXT,
          ${NamaKolom.jumlah} REAL
        )
      ''');
    }
    if (oldVersion < 3) {
      await db.execute(
        'ALTER TABLE ${NamaTabel.biodata} '
        'ADD COLUMN ${NamaKolom.tanggalMulaiBerhentiMerokok} TEXT',
      );
    }
    if (oldVersion < 4) {
      await db.execute(
        'ALTER TABLE ${NamaTabel.biodata} '
        'ADD COLUMN ${NamaKolom.batangPerBungkus} REAL',
      );
    }
    if (oldVersion < 5) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${NamaTabel.diaryCraving}(
          ${NamaKolom.id} TEXT PRIMARY KEY,
          ${NamaKolom.tanggal} TEXT,
          ${NamaKolom.pemicu} TEXT NOT NULL,
          ${NamaKolom.intensitas} INTEGER,
          ${NamaKolom.catatan} TEXT,
          ${NamaKolom.dibuat} TEXT
        )
      ''');
    }
    if (oldVersion < 6) {
      await db.execute(
        'ALTER TABLE ${NamaTabel.biodata} '
        'ADD COLUMN ${NamaKolom.modeBerhenti} TEXT',
      );
      await db.execute(
        'ALTER TABLE ${NamaTabel.biodata} '
        'ADD COLUMN ${NamaKolom.penurunanPerMinggu} INTEGER',
      );
      await db.execute(
        'ALTER TABLE ${NamaTabel.biodata} '
        'ADD COLUMN ${NamaKolom.tanggalMulaiTapering} TEXT',
      );
    }
  }

  /// Menutup database jika sedang terbuka.
  static Future<void> tutupDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
```


// ============================================================
// FILE: lib/shared/db/sqflite/sqflite_op.dart
// ============================================================

```dart
import 'package:berhenti_merokok/shared/db/sqflite/sqflite.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';

/// Operasi CRUD generik untuk database SQLite aplikasi.
///
/// Kelas ini membungkus akses ke [AppDatabase] dan menyediakan
/// metode standar untuk menambah, membaca, mengubah, dan menghapus
/// baris pada tabel yang ditentukan.
class SqfliteOp {
  const SqfliteOp();

  /// Menambahkan satu baris baru ke [tabel].
  ///
  /// Mengembalikan ID baris yang baru dimasukkan.
  Future<int> tambah(
    String tabel,
    Map<String, Object?> data, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    try {
      final db = await AppDatabase.database;
      final hasil = await db.insert(
        tabel,
        data,
        nullColumnHack: nullColumnHack,
        conflictAlgorithm: conflictAlgorithm,
      );
      L.s('Berhasil menambahkan data ke tabel $tabel');
      return hasil;
    } on Exception catch (e, s) {
      L.e('Gagal menambahkan data ke tabel $tabel: $e $s');
      rethrow;
    }
  }

  /// Mengambil seluruh baris dari [tabel].
  Future<List<Map<String, Object?>>> ambilSemua(
    String tabel, {
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    try {
      final db = await AppDatabase.database;
      return await db.query(
        tabel,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data dari tabel $tabel: $e $s');
      rethrow;
    }
  }

  /// Mengambil baris dari [tabel] dengan filter opsional.
  Future<List<Map<String, Object?>>> ambil(
    String tabel, {
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
    List<String>? columns,
    String? groupBy,
    String? having,
    bool? distinct,
  }) async {
    try {
      final db = await AppDatabase.database;
      return await db.query(
        tabel,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
        distinct: distinct,
      );
    } on Exception catch (e, s) {
      L.e('Gagal mengambil data dari tabel $tabel: $e $s');
      rethrow;
    }
  }

  /// Mengambil satu baris pertama dari [tabel] dengan filter opsional.
  Future<Map<String, Object?>?> ambilSatu(
    String tabel, {
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    List<String>? columns,
  }) async {
    try {
      final db = await AppDatabase.database;
      final rows = await db.query(
        tabel,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: 1,
      );
      if (rows.isEmpty) {
        return null;
      }
      return rows.first;
    } on Exception catch (e, s) {
      L.e('Gagal mengambil satu data dari tabel $tabel: $e $s');
      rethrow;
    }
  }

  /// Mengubah baris pada [tabel] sesuai filter [where].
  ///
  /// Mengembalikan jumlah baris yang terpengaruh.
  Future<int> ubah(
    String tabel,
    Map<String, Object?> data, {
    String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    try {
      final db = await AppDatabase.database;
      final hasil = await db.update(
        tabel,
        data,
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: conflictAlgorithm,
      );
      L.s('Berhasil mengubah $hasil baris pada tabel $tabel');
      return hasil;
    } on Exception catch (e, s) {
      L.e('Gagal mengubah data pada tabel $tabel: $e $s');
      rethrow;
    }
  }

  /// Menghapus baris pada [tabel] sesuai filter [where].
  ///
  /// Mengembalikan jumlah baris yang terhapus.
  Future<int> hapus(
    String tabel, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      final db = await AppDatabase.database;
      final hasil = await db.delete(tabel, where: where, whereArgs: whereArgs);
      L.s('Berhasil menghapus $hasil baris pada tabel $tabel');
      return hasil;
    } on Exception catch (e, s) {
      L.e('Gagal menghapus data pada tabel $tabel: $e $s');
      rethrow;
    }
  }

  /// Menghitung jumlah baris pada [tabel] dengan filter opsional.
  Future<int> hitung(
    String tabel, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      final db = await AppDatabase.database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) AS jumlah FROM $tabel'
        '${where == null ? '' : ' WHERE $where'}',
        whereArgs,
      );
      final jumlah = Sqflite.firstIntValue(result) ?? 0;
      return jumlah;
    } on Exception catch (e, s) {
      L.e('Gagal menghitung baris pada tabel $tabel: $e $s');
      rethrow;
    }
  }

  /// Menjalankan beberapa operasi dalam satu transaksi.
  Future<T> transaksi<T>(Future<T> Function(Transaction txn) aksi) async {
    try {
      final db = await AppDatabase.database;
      final hasil = await db.transaction(aksi);
      L.i('Transaksi pada database berhasil');
      return hasil;
    } on Exception catch (e, s) {
      L.e('Transaksi pada database gagal: $e $s');
      rethrow;
    }
  }

  /// Menjalankan SQL mentah (SELECT) dan mengembalikan hasilnya.
  Future<List<Map<String, Object?>>> queryRaw(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    try {
      final db = await AppDatabase.database;
      return await db.rawQuery(sql, arguments);
    } on Exception catch (e, s) {
      L.e('Gagal menjalankan query mentah: $e $s');
      rethrow;
    }
  }

  /// Menjalankan SQL mentah (INSERT/UPDATE/DELETE) dan mengembalikan
  /// jumlah baris yang terpengaruh.
  Future<int> executeRaw(String sql, [List<Object?>? arguments]) async {
    try {
      final db = await AppDatabase.database;
      return await db.rawUpdate(sql, arguments);
    } on Exception catch (e, s) {
      L.e('Gagal menjalankan perintah mentah: $e $s');
      rethrow;
    }
  }

  /// Menjalankan beberapa operasi dalam satu [Batch].
  ///
  /// Callback [isiBatch] digunakan untuk mengisi batch (insert/update/delete).
  /// Mengembalikan daftar hasil operasi.
  Future<List<Object?>> batch(
    void Function(Batch batch) isiBatch, {
    bool? noResult,
    bool? continueOnError,
  }) async {
    try {
      final db = await AppDatabase.database;
      final b = db.batch();
      isiBatch(b);
      final hasil = await b.commit(
        noResult: noResult,
        continueOnError: continueOnError,
      );
      L.i('Batch pada database berhasil dijalankan');
      return hasil;
    } on Exception catch (e, s) {
      L.e('Batch pada database gagal: $e $s');
      rethrow;
    }
  }
}
```


// ============================================================
// FILE: lib/shared/helper/shared_keys.dart
// ============================================================

```dart
/// Kunci penyimpanan yang digunakan bersama oleh aplikasi.
///
/// Kunci-kunci ini dipakai untuk mengakses nilai pada penyimpanan lokal
/// (misalnya `SharedPreferences`) secara konsisten di seluruh fitur.
class SharedKeys {
  SharedKeys._();

  /// Kunci untuk menyimpan preferensi tema aplikasi.
  static const String tema = 'tema';

  /// Kunci untuk menyimpan status aktif pengingat harian.
  static const String notifikasiHarian = 'notifikasi_harian';

  /// Kunci untuk menyimpan jam pengingat harian.
  static const String notifikasiJam = 'notifikasi_jam';

  /// Kunci untuk menyimpan menit pengingat harian.
  static const String notifikasiMenit = 'notifikasi_menit';
}
```


// ============================================================
// FILE: lib/shared/konstanta/milestone_kesehatan.dart
// ============================================================

```dart
/// Data satu milestone pemulihan kesehatan berdasarkan durasi smoke-free.
class MilestoneKesehatan {
  const MilestoneKesehatan({
    required this.target,
    required this.judul,
    required this.deskripsi,
  });

  final Duration target;
  final String judul;
  final String deskripsi;
}

/// Daftar milestone pemulihan kesehatan berdasarkan durasi smoke-free.
const List<MilestoneKesehatan> daftarMilestoneKesehatan = [
  MilestoneKesehatan(
    target: Duration(minutes: 20),
    judul: '20 Menit',
    deskripsi:
        'Tekanan darah dan denyut jantung mulai kembali ke tingkat normal.',
  ),
  MilestoneKesehatan(
    target: Duration(hours: 8),
    judul: '8 Jam',
    deskripsi:
        'Kadar karbon monoksida dalam darah turun ke tingkat normal, '
        'oksigen dalam darah meningkat.',
  ),
  MilestoneKesehatan(
    target: Duration(hours: 24),
    judul: '24 Jam',
    deskripsi: 'Risiko serangan jantung mulai menurun.',
  ),
  MilestoneKesehatan(
    target: Duration(hours: 48),
    judul: '48 Jam',
    deskripsi:
        'Ujung saraf mulai tumbuh kembali, indra pengecapan dan '
        'penciuman membaik.',
  ),
  MilestoneKesehatan(
    target: Duration(hours: 72),
    judul: '72 Jam',
    deskripsi:
        'Bronkus rileks, kapasitas paru meningkat, energi tubuh bertambah.',
  ),
  MilestoneKesehatan(
    target: Duration(days: 14),
    judul: '2 Minggu',
    deskripsi:
        'Sirkulasi darah membaik, fungsi paru meningkat, berjalan kaki '
        'menjadi lebih mudah.',
  ),
  MilestoneKesehatan(
    target: Duration(days: 90),
    judul: '3 Bulan',
    deskripsi: 'Batuk dan sesak napas berkurang, paru-paru mulai pulih.',
  ),
  MilestoneKesehatan(
    target: Duration(days: 270),
    judul: '9 Bulan',
    deskripsi:
        'Paru-paru telah pulih secara signifikan, energi dan stamina '
        'meningkat.',
  ),
  MilestoneKesehatan(
    target: Duration(days: 365),
    judul: '1 Tahun',
    deskripsi:
        'Risiko penyakit jantung koroner turun setengah dibanding perokok.',
  ),
  MilestoneKesehatan(
    target: Duration(days: 1825),
    judul: '5 Tahun',
    deskripsi: 'Risiko stroke setara dengan orang yang tidak merokok.',
  ),
  MilestoneKesehatan(
    target: Duration(days: 3650),
    judul: '10 Tahun',
    deskripsi: 'Risiko kanker paru turun setengah dibanding perokok aktif.',
  ),
  MilestoneKesehatan(
    target: Duration(days: 5475),
    judul: '15 Tahun',
    deskripsi:
        'Risiko penyakit jantung koroner setara dengan orang yang tidak '
        'merokok.',
  ),
];

/// Mengembalikan milestone berikutnya yang belum tercapai berdasarkan durasi
/// smoke-free. Mengembalikan null jika semua milestone sudah tercapai.
MilestoneKesehatan? milestoneBerikutnya(Duration durasi) {
  for (final m in daftarMilestoneKesehatan) {
    if (durasi < m.target) return m;
  }
  return null;
}
```


// ============================================================
// FILE: lib/shared/konstanta/nama_kolom.dart
// ============================================================

```dart
/// Nama-nama kolom database SQLite aplikasi.
class NamaKolom {
  NamaKolom._();

  /// Kolom id biodata.
  static const String id = 'id';

  /// Kolom nama biodata.
  static const String nama = 'nama';

  /// Kolom tanggal lahir biodata.
  static const String tanggalLahir = 'tanggal_lahir';

  /// Kolom jumlah rokok per hari biodata.
  static const String jumlahRokokPerHari = 'jumlah_rokok_per_hari';

  /// Kolom harga rokok per bungkus biodata.
  static const String hargaRokokPerBungkus = 'harga_rokok_per_bungkus';

  /// Kolom batang rokok per bungkus biodata.
  static const String batangPerBungkus = 'batang_per_bungkus';

  /// Kolom tanggal mulai merokok biodata.
  static const String tanggalMulaiMerokok = 'tanggal_mulai_merokok';

  /// Kolom tanggal mulai berhenti merokok biodata.
  static const String tanggalMulaiBerhentiMerokok =
      'tanggal_mulai_berhenti_merokok';

  /// Kolom mode berhenti biodata (seketika/bertahap).
  static const String modeBerhenti = 'mode_berhenti';

  /// Kolom penurunan rokok per minggu untuk mode bertahap.
  static const String penurunanPerMinggu = 'penurunan_per_minggu';

  /// Kolom tanggal mulai rencana penurunan (tapering).
  static const String tanggalMulaiTapering = 'tanggal_mulai_tapering';

  // Kolom tabel impian.
  /// Kolom target tanggal impian.
  static const String targetTanggal = 'target_tanggal';

  /// Kolom tanggal dibuat impian.
  static const String dibuat = 'dibuat';

  /// Kolom jumlah impian.
  static const String jumlah = 'jumlah';

  // Kolom tabel diary craving.
  /// Kolom tanggal kejadian craving.
  static const String tanggal = 'tanggal';

  /// Kolom kategori pemicu craving.
  static const String pemicu = 'pemicu';

  /// Kolom intensitas craving (1-5).
  static const String intensitas = 'intensitas';

  /// Kolom catatan craving.
  static const String catatan = 'catatan';
}
```


// ============================================================
// FILE: lib/shared/konstanta/nama_tabel.dart
// ============================================================

```dart
/// Nama-nama tabel database SQLite aplikasi.
class NamaTabel {
  NamaTabel._();

  /// Tabel biodata.
  static const String biodata = 'biodata';

  /// Tabel impian.
  static const String impian = 'impian';

  /// Tabel diary craving (pemicu).
  static const String diaryCraving = 'diary_craving';
}
```


// ============================================================
// FILE: lib/shared/notifikasi/notifikasi_service.dart
// ============================================================

```dart
import 'dart:async';

import 'package:berhenti_merokok/home.dart';
import 'package:berhenti_merokok/shared/helper/shared_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Exception khusus ketika izin notifikasi tidak diberikan oleh sistem.
class IzinNotifikasiTidakDiberikanException implements Exception {
  const IzinNotifikasiTidakDiberikanException();
  @override
  String toString() => 'Izin notifikasi tidak diberikan';
}

/// Layanan notifikasi lokal untuk pengingat harian aplikasi.
class NotifikasiService {
  NotifikasiService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// ID notifikasi pengingat harian.
  static const int _idPengingatHarian = 1001;

  /// ID notifikasi uji coba (terpisah dari pengingat utama).
  static const int _idUjiCoba = 1002;

  /// GlobalKey navigator untuk navigasi saat notifikasi ditekan.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Inisialisasi plugin notifikasi dan zona waktu.
  static Future<void> inisialisasi() async {
    L.i('NotifikasiService inisialisasi');
    // Bungkus inisialisasi database zona waktu dalam try/catch agar
    // kegagalan (termasuk Error/ArgumentError) tercatat dan tidak
    // menjadi unhandled error.
    try {
      tz.initializeTimeZones();
    } on Error catch (e, s) {
      L.e('Gagal inisialisasi zona waktu: $e $s');
    } on Exception catch (e, s) {
      L.e('Gagal inisialisasi zona waktu: $e $s');
    }
    // Deteksi zona waktu perangkat (WIB/WITA/WIT/dll.) agar pengingat
    // mengikuti waktu lokal pengguna. Package timezone tidak otomatis
    // mendeteksi zona waktu perangkat, sehingga gunakan flutter_timezone.
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      final identifier = info.identifier;
      L.i('zonaWaktuPerangkat=$identifier');
      // Validasi hasil sebelum penggunaan: identifier tidak boleh kosong.
      if (identifier.isEmpty) {
        throw ArgumentError('Identifier zona waktu kosong');
      }
      try {
        tz.setLocalLocation(tz.getLocation(identifier));
      } on Error catch (e, s) {
        L.w(
          'Identifier zona waktu tidak ditemukan di database tz, fallback Asia/Jakarta: $e $s',
        );
        try {
          tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
        } on Error catch (e2, s2) {
          L.w('Gagal set lokasi zona waktu fallback: $e2 $s2');
        } on Exception catch (e2, s2) {
          L.w('Gagal set lokasi zona waktu fallback: $e2 $s2');
        }
      } on Exception catch (e, s) {
        L.w(
          'Identifier zona waktu tidak ditemukan di database tz, fallback Asia/Jakarta: $e $s',
        );
        try {
          tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
        } on Error catch (e2, s2) {
          L.w('Gagal set lokasi zona waktu fallback: $e2 $s2');
        } on Exception catch (e2, s2) {
          L.w('Gagal set lokasi zona waktu fallback: $e2 $s2');
        }
      }
    } on Error catch (e, s) {
      L.w(
        'Gagal mendeteksi zona waktu perangkat, fallback Asia/Jakarta: $e $s',
      );
      try {
        tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
      } on Error catch (e2, s2) {
        L.w('Gagal set lokasi zona waktu: $e2 $s2');
      } on Exception catch (e2, s2) {
        L.w('Gagal set lokasi zona waktu: $e2 $s2');
      }
    } on Exception catch (e, s) {
      L.w(
        'Gagal mendeteksi zona waktu perangkat, fallback Asia/Jakarta: $e $s',
      );
      try {
        tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
      } on Error catch (e2, s2) {
        L.w('Gagal set lokasi zona waktu: $e2 $s2');
      } on Exception catch (e2, s2) {
        L.w('Gagal set lokasi zona waktu: $e2 $s2');
      }
    }

    const android = AndroidInitializationSettings('ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestSoundPermission: false,
      requestBadgePermission: false,
    );
    const settings = InitializationSettings(
      android: android,
      iOS: darwin,
      macOS: darwin,
    );

    try {
      await _plugin.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: _onTapNotifikasi,
      );
      L.s('Plugin notifikasi berhasil diinisialisasi');
    } on UnsupportedError catch (e, s) {
      L.e('Platform tidak mendukung inisialisasi notifikasi: $e $s');
    } on Exception catch (e, s) {
      L.e('Gagal inisialisasi plugin notifikasi: $e $s');
      rethrow;
    }
  }

  static void _onTapNotifikasi(NotificationResponse response) {
    L.i('payload=${response.payload}');
    _navigasiDariPayload(response.payload);
  }

  /// Navigasi berdasarkan payload notifikasi (foreground/background).
  static void _navigasiDariPayload(String? payload, {int percobaan = 0}) {
    final navigator = navigatorKey.currentState;
    if (navigator == null) {
      if (percobaan < 3) {
        L.w('navigator null saat navigasi notifikasi, coba lagi');
        Future.delayed(const Duration(milliseconds: 100), () {
          _navigasiDariPayload(payload, percobaan: percobaan + 1);
        });
      } else {
        L.w('navigator null saat navigasi notifikasi, batalkan');
      }
      return;
    }

    String? kategori;
    String? id;
    if (payload != null) {
      for (final part in payload.split('&')) {
        final kv = part.split('=');
        if (kv.length == 2) {
          if (kv[0] == 'kategori') kategori = kv[1];
          if (kv[0] == 'id') id = kv[1];
        }
      }
    }
    L.i('kategori=$kategori, id=$id');

    final context = navigator.context;
    if (kategori == 'pengingat_harian') {
      unawaited(
        Nav.pushAndRemoveUntil(context, const Home()).catchError((
          Object e,
          StackTrace s,
        ) {
          L.e('Gagal navigasi dari notifikasi: $e $s');
          return null;
        }),
      );
    } else {
      L.w('kategori notifikasi tidak dikenal: $kategori');
    }
  }

  /// Menangani kondisi aplikasi diluncurkan dari keadaan terminated
  /// melalui notifikasi.
  static void cekNotifikasiSaatBuka() {
    // Platform yang tidak mendukung notifikasi terjadwal/launch details.
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows) {
      L.w('platform tidak mendukung cek notifikasi saat buka');
      return;
    }
    unawaited(
      Future(() async {
        try {
          final details = await _plugin.getNotificationAppLaunchDetails();
          if (details?.didNotificationLaunchApp ?? false) {
            final payload = details?.notificationResponse?.payload;
            if (payload != null && payload.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _navigasiDariPayload(payload);
              });
            }
          }
        } on UnsupportedError catch (e, s) {
          L.e('Platform tidak mendukung cek notifikasi saat buka: $e $s');
        } on Exception catch (e, s) {
          L.e('Gagal cek notifikasi saat buka: $e $s');
        }
      }).catchError((Object e, StackTrace s) {
        L.e('Gagal cek notifikasi saat buka: $e $s');
      }),
    );
  }

  /// Meminta izin notifikasi sesuai platform.
  /// Mengembalikan true jika izin diberikan.
  static Future<bool> mintaIzin() async {
    if (kIsWeb) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            WebFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      return granted ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      return granted ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    }
    return true;
  }

  /// Menjadwalkan pengingat harian pada jam dan menit tertentu.
  static Future<void> jadwalkanPengingatHarian({
    required int jam,
    required int menit,
  }) async {
    L.i('jam=$jam, menit=$menit');
    // Platform yang tidak mendukung notifikasi terjadwal (Web, Linux, Windows).
    // macOS didukung plugin flutter_local_notifications v22.3.3 via zonedSchedule.
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows) {
      L.w('platform tidak mendukung penjadwalan terjadwal');
      throw UnsupportedError('Platform tidak mendukung notifikasi terjadwal');
    }
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      jam,
      menit,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'pengingat_harian',
        'Pengingat Harian',
        channelDescription: 'Pengingat harian berhenti merokok',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        icon: 'ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );

    try {
      await _plugin.zonedSchedule(
        id: _idPengingatHarian,
        scheduledDate: scheduled,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        title: 'Berhenti Merokok',
        body: 'Jaga semangat! Cek progres smoke-free Anda hari ini.',
        payload: 'kategori=pengingat_harian&id=$_idPengingatHarian',
        matchDateTimeComponents: DateTimeComponents.time,
      );
      // Periksa izin sebelum menyimpan status aktif.
      final izinDiberikan = await _periksaIzinSistem();
      if (!izinDiberikan) {
        L.w('izin notifikasi tidak diberikan, batalkan penjadwalan');
        await _plugin.cancel(id: _idPengingatHarian);
        await setAktif(false);
        throw const IzinNotifikasiTidakDiberikanException();
      }
      // Simpan nilai lama untuk rollback bila penyimpanan gagal.
      final aktifLama = await aktif();
      final jamLama = await NotifikasiService.jam();
      final menitLama = await NotifikasiService.menit();
      // Urutan: setWaktu terlebih dahulu, lalu setAktif, agar status
      // aktif tidak tersimpan tanpa waktu yang sesuai. Bungkus keduanya
      // dengan rollback saat gagal agar preferensi tetap konsisten.
      try {
        await setWaktu(jam, menit);
        await setAktif(true);
      } on Exception catch (e, s) {
        L.e('Gagal menyimpan preferensi pengingat, rollback: $e $s');
        try {
          await setWaktu(jamLama, menitLama);
          await setAktif(aktifLama);
        } on Exception catch (e2, s2) {
          L.e('Gagal rollback preferensi pengingat: $e2 $s2');
        }
        // Batalkan jadwal sistem agar konsisten dengan preferensi.
        try {
          await _plugin.cancel(id: _idPengingatHarian);
        } on Exception catch (e2, s2) {
          L.e('Gagal membatalkan jadwal saat rollback: $e2 $s2');
        }
        rethrow;
      }
      L.s('Pengingat harian dijadwalkan jam=$jam:$menit');
    } on Exception catch (e, s) {
      L.e('Gagal menjadwalkan pengingat harian: $e $s');
      rethrow;
    }
  }

  /// Membatalkan pengingat harian.
  static Future<void> batalkanPengingatHarian() async {
    try {
      await _plugin.cancel(id: _idPengingatHarian);
      await setAktif(false);
      L.s('Pengingat harian dibatalkan');
    } on Exception catch (e, s) {
      L.e('Gagal membatalkan pengingat harian: $e $s');
      rethrow;
    }
  }

  /// Menampilkan notifikasi langsung (untuk uji coba).
  static Future<void> tampilkanSekarang() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'pengingat_harian',
        'Pengingat Harian',
        channelDescription: 'Pengingat harian berhenti merokok',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        icon: 'ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );
    try {
      await _plugin.show(
        id: _idUjiCoba,
        title: 'Berhenti Merokok',
        body: 'Jaga semangat! Cek progres smoke-free Anda hari ini.',
        notificationDetails: details,
        payload: 'kategori=pengingat_harian&id=$_idUjiCoba',
      );
      L.s('Notifikasi langsung ditampilkan');
    } on Exception catch (e, s) {
      L.e('Gagal menampilkan notifikasi: $e $s');
      rethrow;
    }
  }

  // --- Preferensi SharedPreferences ---

  static Future<bool> aktif() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedKeys.notifikasiHarian) ?? false;
  }

  static Future<void> setAktif(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedKeys.notifikasiHarian, value);
  }

  static Future<int> jam() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedKeys.notifikasiJam) ?? 8;
  }

  static Future<int> menit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedKeys.notifikasiMenit) ?? 0;
  }

  static Future<void> setWaktu(int jam, int menit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(SharedKeys.notifikasiJam, jam);
    await prefs.setInt(SharedKeys.notifikasiMenit, menit);
  }

  /// Jadwalkan ulang pengingat jika aktif (dipanggil saat app start).
  static Future<void> jadwalkanUlangJikaAktif() async {
    try {
      final isAktif = await aktif();
      L.i('isAktif=$isAktif');
      if (!isAktif) return;
      // Periksa izin sistem; pengguna dapat mencabutnya melalui pengaturan.
      final izinDiberikan = await _periksaIzinSistem();
      if (!izinDiberikan) {
        L.w('izin notifikasi tidak diberikan, nonaktifkan pengingat');
        await setAktif(false);
        return;
      }
      final j = await jam();
      final m = await menit();
      await jadwalkanPengingatHarian(jam: j, menit: m);
    } on Exception catch (e, s) {
      L.e('Gagal menjadwalkan ulang pengingat harian: $e $s');
    } on UnsupportedError catch (e, s) {
      L.e('Platform tidak mendukung penjadwalan ulang: $e $s');
    }
  }

  /// Memeriksa status izin notifikasi pada sistem tanpa meminta.
  static Future<bool> _periksaIzinSistem() async {
    if (kIsWeb) {
      // Web tidak mendukung pengecekan izin tanpa prompt; anggap tersedia.
      return true;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final impl = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final enabled = await impl?.areNotificationsEnabled();
      return enabled ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final impl = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      final settings = await impl?.checkPermissions();
      return settings?.isEnabled ?? false;
    }
    return true;
  }
}
```


