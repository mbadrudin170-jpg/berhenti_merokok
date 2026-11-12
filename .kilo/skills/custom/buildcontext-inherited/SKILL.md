---
name: buildcontext-inherited
description: Panduan penggunaan BuildContext untuk akses widget induk - Theme.of, MediaQuery.of, dependOnInheritedWidgetOfExactType, findAncestorWidgetOfExactType, findAncestorStateOfType.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  diperbarui: "Thu Nov 12 06:27:35 WIB 2026"
  sumber-terakhir: "perintah pengguna: perbarui skill index"
  model: "kilo-auto/free"
---

# BuildContext dan Akses Widget Induk (InheritedWidget)

Menggunakan `BuildContext` untuk mengakses `Theme`, `MediaQuery`, `Navigator`, dan widget induk lainnya melalui `InheritedWidget`.

## Cakupan yang Di-Cover

- Package: `package:flutter` (file `lib/src/widgets/framework.dart`)
- Class: `BuildContext`, `Element`, `InheritedWidget`, `InheritedElement`, `Theme`, `MediaQuery`, `Navigator`, `Localizations`
- Method: `dependOnInheritedWidgetOfExactType`, `getInheritedWidgetOfExactType`, `getElementForInheritedWidgetOfExactType`, `findAncestorWidgetOfExactType`, `findAncestorStateOfType`, `findAncestorRenderObjectOfType`, `visitAncestorElements`, `dispatchNotification`
- Getter: `mounted`, `widget`, `size`, `renderObject`, `owner`
- Fungsi statis: `Theme.of(context)`, `MediaQuery.of(context)`, `Navigator.of(context)`, `Localizations.of(context)`

## Aturan

1. `Theme.of(context)` mengakses `ThemeData` terdekat dari widget `Theme` atau `MaterialApp` di atas di tree.
2. `MediaQuery.of(context)` mengakses ukuran layar, inset, textScaleFactor, platformBrightness.
3. `Navigator.of(context)` mengakses `NavigatorState` terdekat. Gunakan `Navigator.maybeOf(context)` jika tidak yakin `Navigator` ada.
4. `dependOnInheritedWidgetOfExactType<T>` mendaftarkan context sebagai dependent, sehingga widget akan rebuild saat `InheritedWidget` berubah.
5. `getInheritedWidgetOfExactType<T>` mengambil nilai tanpa mendaftarkan dependency (tidak akan rebuild saat berubah).
6. `findAncestorWidgetOfExactType<T>` mencari widget induk tipe tertentu, tapi tidak memicu rebuild saat berubah.
7. `findAncestorStateOfType<T>` mendapatkan `State` dari `StatefulWidget` induk, berguna untuk memanggil metode state secara imperatif.
8. `context.mounted` harus dicek sebelum operasi async setelah gap (await).
9. Jangan panggil `dependOnInheritedWidgetOfExactType` di constructor atau `initState`. Gunakan `didChangeDependencies` atau `build`.
10. Jangan panggil `dependOnInheritedWidgetOfExactType` di `dispose` (element tree tidak stabil).
11. `BuildContext` tidak boleh disimpan di variabel class atau melewati asynchronous gap tanpa cek `mounted`.

## Larangan

- `Theme.of(context)` di constructor widget (context belum terpasang).
- `dependOnInheritedWidgetOfExactType` di `initState` atau constructor.
- Menyimpan `BuildContext` di field class untuk digunakan setelah build selesai.
- Memanggil method context setelah `mounted == false`.
- `Navigator.of(context)` dengan context di atas Navigator (bukan di bawah).

## Contoh Benar

```dart
@override
Widget build(BuildContext context) {
  final tema = Theme.of(context); // aman di build
  final media = MediaQuery.of(context);
  return Scaffold(
    appBar: AppBar(
      title: Text('Judul', style: tema.textTheme.titleLarge),
      backgroundColor: tema.colorScheme.primaryContainer,
    ),
    body: Center(
      child: Text('Lebar layar: ${media.size.width}'),
    ),
  );
}

// cek mounted setelah async
void _loadData() async {
  await repo.fetch();
  if (mounted) {
    setState(() {});
  }
}
```

## Contoh Salah

```dart
// Theme.of di constructor
class MyWidget extends StatelessWidget {
  MyWidget({super.key}) {
    final tema = Theme.of(context); // ERROR: context tidak tersedia di constructor
  }
}
```

```dart
// menyimpan context di field
class _MyState extends State<MyWidget> {
  late BuildContext _savedContext;

  @override
  Widget build(BuildContext context) {
    _savedContext = context; // DILARANG
    return Container();
  }
}
```

## Sumber Evaluasi

- File: `/google/flutter/packages/flutter/lib/src/widgets/framework.dart`
- Class terkait: `BuildContext`, `Element`, `InheritedElement`, `Theme`, `MediaQuery`
