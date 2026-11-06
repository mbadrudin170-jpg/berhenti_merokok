# Aturan Bersama Seluruh Proyek Flutter

File ini menyimpan standar implementasi yang berlaku lintas proyek Flutter pengguna. Aturan di sini tidak bergantung pada kebutuhan bisnis satu proyek dan dapat digunakan kembali pada berbagai proyek.

## Penanganan AsyncValue (Riverpod) untuk ID Terpilih

Ketentuan berikut wajib diterapkan agar kesalahan runtime terkait `selectedId`/ID terpilih tidak terulang:

1. **Jangan gunakan `.value` atau `.valueOrNull` pada `AsyncValue` hasil `ref.watch(...)` di dalam `build` maupun di dalam builder widget (mis. `itemBuilder` `ListView.builder`).**
   - Gunakan `.asData?.value` atau `.maybeWhen(data: (id) => id, orElse: () => null)` untuk membaca nilai dengan aman terhadap status loading/error.
   - Contoh benar: `ref.watch(selectedKendaraanIdProvider).asData?.value`
   - Contoh salah: `ref.watch(selectedKendaraanIdProvider).value`

2. **Setiap `AsyncValue` yang di-`watch` wajib diperiksa statusnya dengan urutan: `.isLoading` terlebih dahulu, lalu `.hasError`, baru `.requireValue`.**
   - Gabungkan pemeriksaan loading/error untuk semua provider yang digunakan di `build`.

3. **Jangan memanggil `ref.watch(...)` di dalam `itemBuilder`, `builder`, atau callback widget.**
   - Baca `AsyncValue` sekali di awal `build`, lalu teruskan nilainya melalui parameter ke widget/fungsi builder.

4. **Gunakan `ref.read(...)` (bukan `ref.watch`) di dalam callback aksi (mis. `onTap`) ketika hanya membutuhkan nilai sekali.**

5. **Pastikan `flutter analyze` bersih sebelum menyatakan perubahan selesai.**

## Registrasi Delegate Lokalisasi `material_ui` untuk `adaptive_dialog`

Proyek yang menggunakan paket `adaptive_dialog` (yang secara internal bergantung pada paket `material_ui`) wajib mendaftarkan delegate lokalisasi khusus untuk `material_ui.MaterialLocalizations` selain tiga delegate global Flutter.

**Aturan wajib:**

1. `MaterialApp` wajib mendaftarkan delegate lokalisasi khusus untuk `material_ui.MaterialLocalizations`.
2. Delegate khusus tersebut wajib memiliki `isSupported` yang mengembalikan `true` untuk locale yang didukung aplikasi, karena delegate bawaan `material_ui` (`DefaultMaterialLocalizations.delegate`) hanya mendukung `locale.languageCode == 'en'`.
3. Metode `load` delegate khusus wajib memanggil `material_ui.DefaultMaterialLocalizations.load(locale)`.
4. Jangan menghapus delegate khusus ini meskipun tidak ada error analyzer, karena error hanya muncul pada runtime saat dialog ditampilkan.

**Larangan:**

- Jangan mengandalkan `material_ui.DefaultMaterialLocalizations.delegate` langsung pada `MaterialApp.localizationsDelegates`.
- Jangan mengganti delegate khusus dengan delegate Flutter bawaan.

## Padding Tepi Layar

Seluruh konten utama halaman wajib memiliki jarak yang sesuai dari tepi layar. Padding tepi layar merupakan tanggung jawab container pada tingkat halaman atau parent yang menyusun konten halaman.

**Aturan wajib:**

1. Terapkan padding pada container yang menjadi batas utama konten halaman.
2. Widget reusable/shared tidak boleh memasukkan padding tepi layar ke dalam dirinya sendiri.
3. Widget reusable tetap boleh mempunyai padding internal untuk kebutuhan desain komponennya sendiri.
4. Apabila parent sudah memberikan padding tepi layar, jangan menambahkan padding tepi layar yang sama lagi pada setiap anak.
5. Nilai padding wajib mengikuti referensi desain. Dilarang menentukan nilai sendiri tanpa dasar referensi desain.

**Larangan:**

- Jangan menempatkan widget reusable langsung di dalam `Column`/`Row` halaman tanpa pembungkus `Padding` (jika widget tidak menyertakan padding tepi layar).
- Jangan memodifikasi widget reusable untuk menambahkan padding tepi layar, karena akan menyebabkan padding ganda.

## Navigasi Tab Utama — Inisialisasi Lazy dan Retensi State

Gunakan `IndexedStack` dengan daftar yang dibangun secara lazy: tab hanya dibuat saat pertama kali dipilih, lalu tetap dipertahankan (state tidak dibuang).

**Aturan wajib:**

1. Simpan tab yang sudah pernah dibuka dalam `Set<int> _tabTerbuka` (awalnya `{0}`).
2. Setiap tab yang belum pernah dibuka direpresentasikan sebagai `SizedBox.shrink()` pada slot IndexedStack-nya.
3. Pertahankan `GlobalKey<State<...>>` per tab agar `currentState` tetap dapat diakses untuk fitur scroll-to-top.
4. Deteksi double-tap pada tab yang sedang aktif dengan jendela waktu `<= 500ms`, lalu panggil scroll-to-top dan reset waktu tap.
5. Pada scroll-to-top, periksa `state == null` terlebih dahulu (tab belum dibuka) dan log + return (jangan crash).
6. Hanya panggil `scrollToTop()` apabila state mengimplementasikan `ScrollKeAtas`.

**Larangan:**

- Jangan membangun semua tab sekaligus sejak awal.
- Jangan menghapus `_tabTerbuka` / lazy loading.
- Jangan menghapus `GlobalKey` per tab.
- Jangan memanggil `scrollToTop()` tanpa memeriksa `state == null` dan tipe `ScrollKeAtas`.

## Kelengkapan Refresh pada `_buildError` (Halaman Multi-Provider)

Setiap provider yang di-`watch` di `build` (dan diperiksa loading/error-nya) wajib ikut di-`refresh` pada handler retry di `_buildError`.

**Aturan wajib:**

1. Refresh seluruh provider yang di-`watch`, termasuk provider sekunder.
2. Jangan melewatkan provider hanya karena tidak menjadi fokus utama halaman.
3. Urutan pemeriksaan `AsyncValue` tetap loading → error → data.

**Larangan:**

- Jangan refresh sebagian provider saja di `_buildError`.
- Jangan menambah provider baru ke `build` tanpa menambahkan refresh-nya di `_buildError`.

## Penempatan Metode `_buildLoading` dan `_buildError` di Bagian Bawah Kelas State

Tempatkan metode `_buildLoading()` dan `_buildError()` di bagian paling bawah kelas State, setelah metode-metode lain.

**Aturan wajib:**

1. Urutan internal: `_buildLoading()` terlebih dahulu, kemudian `_buildError()`, sebelum penutup kelas `}`.
2. Pastikan metode tetap berada pada level anggota kelas (bukan metode lokal/nested).
3. Setelah memindahkan metode, jalankan `dart format` dan `flutter analyze`.

**Larangan:**

- Jangan menempatkan `_buildLoading()`/`_buildError()` tepat setelah `build()` atau di tengah metode lain.
- Jangan memindahkan metode tanpa memeriksa penutupan kurung kurawal (`}`).

## Penempatan Metode `scrollToTop` pada Kelas State

Tempatkan metode `scrollToTop()` (implementasi interface `ScrollKeAtas`) di bagian atas kelas State, sebelum metode `build()`.

**Aturan wajib:**

1. Metode interface dipanggil dari luar (via `GlobalKey.currentState`), bukan dari dalam `build()`.
2. Berbeda dari `_buildLoading`/`_buildError` yang ditempatkan di bawah.

**Larangan:**

- Jangan menempatkan `scrollToTop()` di bagian bawah kelas State.

## Family Provider (Riverpod)

Gunakan family provider (`@Riverpod` dengan parameter pada `build`) ketika provider bergantung pada parameter eksternal.

**Aturan wajib:**

1. Pastikan file `.g.dart` dihasilkan ulang setelah menambah/mengubah parameter `build`.
2. Berikan nama kelas Notifier yang konsisten (mis. `DashboardNotifier`, bukan `Dashboard`).
3. Gunakan `keepAlive: true` jika state perlu dipertahankan.
4. Gunakan `@Riverpod()` (auto-dispose) jika state tidak perlu dipertahankan.
5. Jangan menggunakan functional provider jika state perlu dimutasi melalui metode.

## Penggunaan EasyLoading Overlay pada Aksi Simpan

Gunakan `flutter_easyloading` untuk loading overlay pada aksi simpan sesuai pola implementasi proyek.

**Aturan wajib:**

1. Tampilkan overlay loading melalui `unawaited(EasyLoading.show(status: 'Menyimpan...'))` segera setelah flag `_isLoading` diaktifkan.
2. Sembunyikan overlay melalui `unawaited(EasyLoading.dismiss())` di dalam blok `finally`.
3. Pertahankan guard double-submit di awal metode: `if (_isLoading) { L.w(...); return; }`.
4. Tombol simpan tidak perlu menampilkan spinner sendiri maupun dinonaktifkan; cukup panggil `_simpanForm` langsung.
5. Pastikan `_isLoading` dikembalikan ke `false` pada semua jalur, dengan pemeriksaan `mounted` sebelum `setState`.

**Larangan:**

- Jangan menampilkan spinner di dalam tombol sekaligus overlay EasyLoading untuk aksi yang sama.
- Jangan menghilangkan guard `_isLoading` di awal metode.
- Jangan memanggil `EasyLoading.dismiss()` tanpa `unawaited` atau di luar `finally`.

## Preferensi State Lokal daripada Re-watch Provider pada Halaman

Jika nilai yang dibutuhkan sudah tersedia dalam state lokal widget, gunakan nilai tersebut langsung sebagai argumen provider, tanpa me-`watch` provider async yang menyediakan nilai yang sama.

**Aturan wajib:**

1. Jangan menambahkan pemeriksaan `isLoading`/`hasError`/`requireValue` untuk provider yang tidak lagi di-`watch`.
2. Jika sebuah provider dihapus dari `build`, pastikan juga dihapus dari daftar refresh pada `_buildError`.

**Larangan:**

- Jangan me-`watch` provider async yang nilainya sudah tersedia di state lokal.

## Pengurutan Koleksi dengan `sorted`

Gunakan `list.sorted(...)` langsung dari `package:collection`, karena `sorted` sudah mengembalikan list baru tanpa memutasi list asli.

**Larangan:**

- Jangan menulis `[...list].sorted(...)`.

## Penggunaan `maxBy` untuk Nilai Maksimum

Gunakan `maxBy` dari `package:collection` untuk mengambil item dengan nilai maksimum berdasarkan kriteria.

**Larangan:**

- Jangan menggunakan `firstWhereOrNull` atau loop manual untuk kebutuhan ini.

## Ekstraksi Fungsi ke Helper untuk Menghilangkan Duplikasi

Pindahkan fungsi/logika yang digunakan di banyak tempat ke file helper khusus. Gunakan fungsi helper tersebut di semua tempat yang membutuhkan.

**Larangan:**

- Jangan menyalin logika yang sama ke beberapa file.
- Jangan membuat fungsi duplikat dengan nama berbeda.

## Anotasi Tipe Eksplisit pada Variabel State dan List

Gunakan anotasi tipe eksplisit pada variabel yang menyimpan state atau list. Ini meningkatkan type safety dan keterbacaan kode.

**Larangan:**

- Jangan menggunakan `var` atau `final` tanpa anotasi tipe untuk variabel state/list jika tipe dapat ditentukan secara jelas.

## Penanganan Async di Luar Build (Riverpod)

Untuk mengambil hasil provider asynchronous di luar `build`, gunakan `.future` dan `await`. Jangan menangani status `.isLoading` dan `.hasError` secara manual.

**Aturan wajib:**

1. Gunakan `await ref.read(provider.future)` untuk mengambil nilai.
2. Tangani error dengan try/catch.
3. Pastikan flag loading direset di blok `finally`.

**Larangan:**

- Jangan menggunakan `ref.read(provider)` tanpa `.future` untuk provider asynchronous.

## Filter Data Berdasarkan Rentang Tanggal

Gunakan fungsi filter yang konsisten untuk memfilter data berdasarkan rentang tanggal. Ekstrak logika filter ke helper jika digunakan di banyak tempat.

**Aturan wajib:**

1. Gunakan `maxBy` dari `package:collection` untuk menentukan item dengan nilai maksimum dalam rentang.
2. Gunakan `fold` untuk agregasi data.
3. Gunakan `sorted` dari `package:collection` untuk pengurutan sebelum perhitungan.

## Hierarki Tipografi pada Tabel

Pada tabel yang menyajikan informasi berjenjang, gunakan hierarki tipografi yang jelas:

1. Header kolom menggunakan `Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)`.
2. Label baris menggunakan `Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)`.
3. Nilai data cell menggunakan `Theme.of(context).textTheme.bodySmall`.

**Larangan:**

- Jangan menggunakan ukuran yang sama untuk header, label, dan nilai.
- Jangan menggunakan `const TextStyle(fontWeight: FontWeight.bold)` tanpa acuan tema.
## Penyusunan Dependensi pada `pubspec.yaml`

Jaga konsistensi urutan entri dependensi pada `pubspec.yaml` agar perubahan lebih mudah ditinjau.

**Aturan:**

1. Susun nama paket pada kelompok `dependencies` secara konsisten (misalnya alfabetis A–Z).
2. Susun nama paket pada kelompok `dev_dependencies` secara konsisten (misalnya alfabetis A–Z), terpisah dari `dependencies`.
3. Pertahankan kelompok dependensi asal setiap paket; jangan memindahkan paket antar kelompok.
4. Pertahankan sumber dan versi dependensi yang sudah ditetapkan; penyusunan ulang urutan tidak boleh mengubah konfigurasi dependensi.

**Contoh benar:**
```yaml
dependencies:
  cupertino_icons: ^2.0.0
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_lints: ^6.0.0
  flutter_test:
    sdk: flutter
```

**Contoh salah:**
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^2.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

**Alasan:**
Urutan yang konsisten memudahkan peninjauan diff pada `pubspec.yaml` dan mencegah perubahan urutan yang tidak perlu saat instalasi ulang paket.

## Pemisahan Titik Masuk dan Widget Aplikasi

Jaga agar entry point aplikasi (`main()`) tetap minimal dan pisahkan definisi widget root (`MyApp`) ke file tersendiri.

**Aturan:**

1. `main.dart` hanya memuat `main()` yang memanggil `runApp(const MyApp())`, serta re-export file yang memuat `MyApp`.
2. Definisi kelas `MyApp` dan logika widget root ditempatkan di file terpisah (mis. `app.dart`).
3. Jangan menempatkan logika UI, state, atau konfigurasi yang kompleks di dalam `main()`.

**Contoh benar:**
```dart
// main.dart
import 'package:aplikasi/app.dart';
import 'package:flutter/material.dart';

export 'package:aplikasi/app.dart';

void main() {
  runApp(const MyApp());
}
```

**Contoh salah:**
```dart
// main.dart berisi seluruh definisi MyApp dan logika UI.
class MyApp extends StatelessWidget { ... }
void main() => runApp(const MyApp());
```

**Alasan:**
Pemisahan ini menjaga entry point tetap minimal dan memudahkan pengujian serta pemeliharaan.

## Root Widget sebagai ConsumerStatefulWidget ketika Membutuhkan Provider

Gunakan `ConsumerStatefulWidget` pada widget root hanya ketika root perlu mengamati provider (misalnya tema atau locale).

**Aturan:**

1. Jika `MyApp` perlu mengamati provider, gunakan `ConsumerStatefulWidget` alih-alih `StatelessWidget`.
2. Sertakan `debugShowCheckedModeBanner: false` pada `MaterialApp` untuk build pengembangan yang lebih bersih.
3. Jangan mengubah root widget menjadi `ConsumerStatefulWidget` jika tidak membutuhkan akses provider.

**Contoh benar:**
```dart
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(),
    );
  }
}
```

**Contoh salah:**
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: const Home(),
    );
  }
}
```

**Alasan:**
Menggunakan `ConsumerStatefulWidget` pada root hanya saat dibutuhkan menjaga widget tetap sederhana, sementara `debugShowCheckedModeBanner: false` menjaga tampilan pengembangan tetap bersih.

## Layar dengan Siklus Hidup Menggunakan ConsumerStatefulWidget

Gunakan `ConsumerStatefulWidget` untuk layar yang membutuhkan akses provider dan pengelolaan siklus hidup (`initState`/`dispose`).

**Aturan:**

1. Gunakan `ConsumerStatefulWidget` untuk layar yang membutuhkan `ref` dan pengelolaan siklus hidup widget.
2. Implementasikan `initState` dan `dispose` sesuai kebutuhan, dengan pemanggilan `super` yang benar.
3. Hindari meninggalkan `TODO` pada `initState`/`dispose` setelah implementasi selesai.

**Contoh benar:**
```dart
class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Home')));
  }
}
```

**Contoh salah:**
```dart
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Tidak dapat mengakses ref atau lifecycle.
    return const Scaffold(body: Center(child: Text('Home')));
  }
}
```

**Alasan:**
Pola ini mempersiapkan layar untuk integrasi provider dan pengelolaan resource dengan lifecycle yang benar.

## Pengelolaan Tema melalui Notifier (Riverpod)

Kelola state tema aplikasi melalui Notifier yang dibuat dengan `riverpod_generator`, bukan nilai hardcode di widget.

**Aturan:**

1. Buat Notifier tema sebagai kelas dengan anotasi `@riverpod`.
2. Gunakan `build()` untuk mengembalikan nilai tema awal.
3. Jangan meng-hardcode tema final di widget; biarkan Notifier menjadi sumber kebenaran.

**Contoh benar:**
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tema_notifier.g.dart';

@riverpod
class TemaNotifier extends _$TemaNotifier {
  @override
  String build() {
    return '';
  }
}
```

**Contoh salah:**
```dart
// Tema ditentukan langsung di widget tanpa Notifier.
MaterialApp(theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)));
```

**Alasan:**
Memisahkan pengelolaan tema dari widget presentasi memungkinkan tema diubah dan diamati secara terpusat.

## Penyediaan ProviderScope pada Titik Masuk

Setiap aplikasi yang menggunakan Riverpod wajib membungkus widget root dengan `ProviderScope` pada titik masuk `main()`.

**Aturan:**

1. Bungkus `MyApp` dengan `ProviderScope` di dalam `main()`.
2. Impor `flutter_riverpod` di `main.dart` untuk menggunakan `ProviderScope`.
3. Jangan memanggil `runApp(const MyApp())` tanpa `ProviderScope` jika aplikasi menggunakan Riverpod.

**Contoh benar:**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

**Contoh salah:**
```dart
void main() {
  runApp(const MyApp()); // Tidak ada ProviderScope
}
```

**Alasan:**
Tanpa `ProviderScope`, pemanggilan provider di widget akan gagal saat runtime.

## Sentralisasi Kunci Penyimpanan

Sentralisasikan kunci penyimpanan lokal dalam satu kelas dengan konstruktor privat dan konstanta `static const`, hindari string literal yang tersebar.

**Aturan:**

1. Definisikan seluruh kunci penyimpanan (mis. `SharedPreferences`) dalam kelas khusus dengan konstruktor privat.
2. Gunakan konstanta `static const String` untuk setiap kunci.
3. Jangan menulis string kunci langsung di berbagai tempat.

**Contoh benar:**
```dart
class SharedKeys {
  SharedKeys._();

  static const String tema = 'tema';
}
```

**Contoh salah:**
```dart
await prefs.setString('tema', value); // string literal tersebar
```

**Alasan:**
Sentralisasi menjaga konsistensi dan memudahkan pemeliharaan.

## Pertahankan State Persisten dengan `keepAlive`

Gunakan `keepAlive: true` pada provider yang state-nya harus persisten sepanjang siklus hidup aplikasi, dan auto-dispose untuk state sementara.

**Aturan:**

1. Gunakan `@Riverpod(keepAlive: true)` untuk state yang harus tetap hidup (misalnya tema).
2. Gunakan `@riverpod` (auto-dispose) untuk state sementara.
3. Jangan menggunakan auto-dispose untuk state yang harus persisten.

**Contoh benar:**
```dart
@Riverpod(keepAlive: true)
class TemaNotifier extends _$TemaNotifier {
  @override
  String build() {
    return '';
  }
}
```

**Contoh salah:**
```dart
@riverpod
class TemaNotifier extends _$TemaNotifier {
  @override
  String build() {
    return '';
  }
}
```

**Alasan:**
Auto-dispose akan menghapus state ketika tidak ada listener, yang tidak diinginkan untuk state persisten seperti tema.

## Inisialisasi State dari Penyimpanan Lokal via AsyncNotifier

Saat state bergantung pada data asynchronous dari penyimpanan lokal (mis. `SharedPreferences`), gunakan `AsyncNotifier` dan baca nilai dengan fallback yang aman.

**Aturan:**

1. Gunakan `AsyncNotifier<T>` dengan `build()` mengembalikan `Future<T>`.
2. Baca nilai tersimpan dan konversi ke tipe state dengan fallback ke nilai default.
3. Metode mutasi menyimpan ke penyimpanan lokal dan memperbarui `state` dengan `AsyncValue.data(...)`.
4. Sediakan parameter opsional dengan fallback ke state saat ini.

**Contoh benar:**
```dart
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

**Contoh salah:**
```dart
@Riverpod(keepAlive: true)
class TemaNotifier extends _$TemaNotifier {
  @override
  String build() {
    return '';
  }

  void set() {}
}
```

**Alasan:**
Pola ini memastikan state persisten antar sesi dan aman terhadap nilai null.

## Parameter Opsional dengan Fallback ke State Saat Ini

Metode mutasi state yang menerima input opsional sebaiknya memiliki fallback ke state saat ini agar aman terhadap pemanggilan tanpa argumen.

**Aturan:**

1. Jadikan parameter mutasi opsional (`[TemaEnum? tema]`).
2. Gunakan fallback `tema ?? state.asData?.value ?? nilaiDefault` sebelum memproses.

**Contoh benar:**
```dart
Future<void> set([TemaEnum? tema]) async {
  final nilai = tema ?? state.asData?.value ?? TemaEnum.sistem;
}
```

**Contoh salah:**
```dart
Future<void> set(TemaEnum tema) async {
  // tema bisa null di runtime jika dipanggil tanpa argumen
}
```

**Alasan:**
Fallback mencegah null error saat metode dipanggil tanpa argumen.

## Penerapan Mode Tema Dinamis pada MaterialApp

Saat mengamati state async di widget, gunakan `.asData?.value` untuk membaca nilai dengan aman; sediakan `theme`, `darkTheme`, dan `themeMode` agar tema dapat berubah dinamis.

**Aturan:**

1. Baca provider dengan `ref.watch` dan ambil nilai aman melalui `.asData?.value`.
2. Petakan enum tema ke `ThemeMode` menggunakan switch expression.
3. Sediakan `theme`, `darkTheme`, dan `themeMode` pada `MaterialApp`.
4. Gunakan `.asData?.value` (bukan `.value`) untuk membaca `AsyncValue` secara aman.

**Contoh benar:**
```dart
final temaAsync = ref.watch(temaProvider);
final tema = temaAsync.asData?.value ?? TemaEnum.sistem;

final themeMode = switch (tema) {
  TemaEnum.terang => ThemeMode.light,
  TemaEnum.gelap => ThemeMode.dark,
  TemaEnum.sistem => ThemeMode.system,
};

MaterialApp(
  themeMode: themeMode,
  theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
  darkTheme: ThemeData(
    colorScheme: .fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
  ),
);
```

**Contoh salah:**
```dart
final tema = ref.watch(temaProvider).value; // unsafe
MaterialApp(
  theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
);
```

**Alasan:**
Pola ini menjaga konsistensi tampilan pada mode terang/gelap/sistem dan menghindari null error.

## Validasi Form Mengembalikan `String?`

Validator form harus mengembalikan `String?` sesuai kontrak `FormFieldValidator`; null berarti valid.

**Aturan:**

1. Validator wajib mengembalikan `String?` (null berarti valid, string berarti pesan error).
2. Jangan menggunakan `() {}` (void) sebagai validator.
3. Gunakan `() { return null; }` atau ekspresi yang mengembalikan `String?`.

**Contoh benar:**
```dart
validator: (value) {
  return null;
},
```

**Contoh salah:**
```dart
validator: (value) {},
```

**Alasan:**
Pola ini mencegah type mismatch pada `FormField`/widget input.

## Manfaatkan Widget dan Helper Reusable dari Paket Shared

Manfaatkan widget dan helper reusable dari paket shared yang tersedia sebelum membuat implementasi sendiri.

**Aturan:**

1. Periksa apakah widget/helper yang dibutuhkan sudah tersedia di paket shared (mis. `core_shared`).
2. Gunakan widget reusable tersebut alih-alih membuat ulang.
3. Jangan menduplikasi implementasi yang sudah tersedia.

**Contoh benar:**
```dart
import 'package:share_global_saya/core_shared.dart';
```

**Contoh salah:**
```dart
// Membuat InputTeks sendiri padahal sudah tersedia di core_shared.
```

**Alasan:**
Menggunakan widget reusable menjaga konsistensi dan mengurangi duplikasi.

## Side Effect di dalam `build()`

Hindari memutasi state, controller, atau data di dalam metode `build()`.

**Aturan:**
1. Jangan memanggil `setState`, menulis ke `TextEditingController`, atau memutasi variabel state di dalam `build()`.
2. Jangan menggunakan callback seperti `whenData`/`when` untuk menjalankan side effect (mis. mengisi controller) langsung di `build()`.
3. Jika data async perlu disalin ke state lokal (mis. controller), lakukan pada `initState`, `ref.listen`, atau `addPostFrameCallback`, dengan pengecekan `mounted`.
4. `build()` harus bersifat idempoten dan hanya membangun UI berdasarkan state yang sudah tersedia.

**Contoh benar:**
```dart
@override
void initState() {
  super.initState();
  ref.listenManual(biodataProvider, (previous, next) {
    next.whenData((biodata) {
      if (biodata != null && !_sudahDiisi) {
        _sudahDiisi = true;
        _namaController.text = biodata.nama;
      }
    });
  });
}
```

**Contoh salah:**
```dart
@override
Widget build(BuildContext context) {
  final biodataAsync = ref.watch(biodataProvider);
  biodataAsync.whenData((biodata) {
    if (biodata != null && !_sudahDiisi) {
      _sudahDiisi = true;
      _namaController.text = biodata.nama; // side effect di build
    }
  });
  return Scaffold(/* ... */);
}
```

**Alasan:**
Side effect di `build()` dapat menyebabkan loop rebuild, inkonsistensi state, dan perilaku yang sulit diprediksi karena `build()` dapat dipanggil berkali-kali.

## Parameter Binding pada SQL Mentah

Saat menjalankan SQL mentah atau query dengan filter, gunakan parameter binding.

**Aturan:**
1. Gunakan `whereArgs` (atau argumen parameter) untuk nilai dinamis/filter.
2. Jangan menginterpolasi nilai pengguna atau variabel dinamis ke dalam string SQL.
3. Nama tabel dan kolom boleh ditulis langsung hanya jika merupakan konstanta yang terverifikasi, bukan input pengguna.

**Contoh benar:**
```dart
final rows = await db.query(
  'biodata',
  where: 'id = ?',
  whereArgs: [id],
);
```

**Contoh salah:**
```dart
final rows = await db.rawQuery(
  "SELECT * FROM biodata WHERE id = '$id'", // interpolasi -> risiko SQL injection
);
```

**Alasan:**
Parameter binding mencegah SQL injection dan kesalahan parsing nilai (mis. tanda kutip) pada data dinamis.