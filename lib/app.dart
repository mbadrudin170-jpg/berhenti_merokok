import 'package:berhenti_merokok/fitur/tema/enum/tema_enum.dart';
import 'package:berhenti_merokok/fitur/tema/notifier/tema_notifier.dart';
import 'package:berhenti_merokok/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      themeMode: themeMode,
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
