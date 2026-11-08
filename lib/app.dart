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
