import 'package:berhenti_merokok/fitur/tema/enum/tema_enum.dart';
import 'package:berhenti_merokok/fitur/tema/notifier/tema_notifier.dart';
import 'package:berhenti_merokok/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart' as mui;

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<App> {
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

    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const Home(),
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
