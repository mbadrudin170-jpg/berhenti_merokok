// ============================================================
// FILE: lib/app.dart
// ============================================================

```dart
import 'package:berhenti_merokok/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(),
    );
  }
}
```


// ============================================================
// FILE: lib/fitur/tema/enum/tema_enum.dart
// ============================================================

```dart
enum TemaEnum { sistem, terang, gelap }
```


// ============================================================
// FILE: lib/fitur/tema/tema_notifier.dart
// ============================================================

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tema_notifier.g.dart';

@Riverpod(keepAlive: true)
class TemaNotifier extends _$TemaNotifier {
  @override
  String build() {
    return "";
  }
}
```


// ============================================================
// FILE: lib/home.dart
// ============================================================

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('data')),
      body: Center(child: Text('Home')),
    );
  }
}
```


// ============================================================
// FILE: lib/main.dart
// ============================================================

```dart
import 'package:berhenti_merokok/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:berhenti_merokok/app.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
}
```


