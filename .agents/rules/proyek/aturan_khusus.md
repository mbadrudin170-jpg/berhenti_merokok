# Aturan Khusus Proyek

## Penanganan AsyncValue (Riverpod) untuk ID Terpilih

Ketentuan berikut wajib diterapkan agar kesalahan runtime terkait `selectedId`/ID terpilih tidak terulang:

1. **Jangan gunakan `.value` atau `.valueOrNull` pada `AsyncValue` hasil `ref.watch(...)` di dalam `build` maupun di dalam builder widget (mis. `itemBuilder` `ListView.builder`).**
   - Gunakan `.asData?.value` atau `.maybeWhen(data: (id) => id, orElse: () => null)` untuk membaca nilai dengan aman terhadap status loading/error.
   - Contoh benar: `ref.watch(selectedKendaraanIdProvider).asData?.value`
   - Contoh salah: `ref.watch(selectedKendaraanIdProvider).value`

2. **Setiap `AsyncValue` yang di-`watch` wajib diperiksa statusnya dengan urutan: `.isLoading` terlebih dahulu, lalu `.hasError`, baru `.requireValue`.**
   - Gabungkan pemeriksaan loading/error untuk semua provider yang digunakan di `build`.
   - Contoh:
     ```dart
     if (kmAsync.isLoading || kendaraanAsync.isLoading || selectedKendaraanIdAsync.isLoading) {
       return const _LoadingView();
     }
     if (kmAsync.hasError || kendaraanAsync.hasError || selectedKendaraanIdAsync.hasError) {
       return _buildError();
     }
     kmAsync.requireValue;
     kendaraanAsync.requireValue;
     selectedKendaraanIdAsync.requireValue;
     ```

3. **Jangan memanggil `ref.watch(...)` di dalam `itemBuilder`, `builder`, atau callback widget.**
   - Baca `AsyncValue` sekali di awal `build`, lalu teruskan nilainya melalui parameter ke widget/fungsi builder.
   - Contoh: `_buildDrawer(kendaraanState, selectedKendaraanIdAsync.asData?.value)` dan gunakan parameter di dalam `itemBuilder`.

4. **Gunakan `ref.read(...)` (bukan `ref.watch`) di dalam callback aksi (mis. `onTap`) ketika hanya membutuhkan nilai sekali.**

5. **Pastikan `flutter analyze` bersih sebelum menyatakan perubahan selesai.**

## Registrasi Delegate Lokalisasi `material_ui` untuk `adaptive_dialog`

Proyek menggunakan paket `adaptive_dialog` (mandat Aturan 4.5 `aturan_pemanfaatan_sdk_dan_paket.md`) yang secara internal bergantung pada paket `material_ui`. Paket `material_ui` mendefinisikan kelas `MaterialLocalizations` miliknya sendiri (berbeda dari `MaterialLocalizations` milik Flutter SDK). Komponen `adaptive_dialog` mencari `MaterialLocalizations` dari `material_ui` melalui `Localizations.of<material_ui.MaterialLocalizations>(context)`. Jika delegate untuk tipe tersebut tidak terdaftar di `MaterialApp.localizationsDelegates`, nilai yang dikembalikan adalah `null`, dan pemanggilan berikutnya menggunakan null-check operator (`!`) sehingga aplikasi melempar `Null check operator used on a null value` saat dialog ditampilkan.

**Cakupan:**

- `lib/app.dart` — `App.build`, khususnya `MaterialApp.localizationsDelegates` dan `supportedLocales`.
- Kelas `_MaterialUiLocalizationsDelegate` di `lib/app.dart`.
- Setiap penggunaan `adaptive_dialog` (`showOkCancelAlertDialog`, `showModalActionSheet`, dan sejenisnya) di seluruh fitur.

**Aturan wajib:**

1. `MaterialApp` wajib mendaftarkan delegate lokalisasi khusus untuk `material_ui.MaterialLocalizations` selain tiga delegate global Flutter (`GlobalMaterialLocalizations`, `GlobalWidgetsLocalizations`, `GlobalCupertinoLocalizations`).
2. Delegate khusus tersebut wajib memiliki `isSupported` yang mengembalikan `true` untuk locale yang didukung aplikasi (proyek ini menggunakan `Locale('id', 'ID')`), karena delegate bawaan `material_ui` (`DefaultMaterialLocalizations.delegate`) hanya mendukung `locale.languageCode == 'en'`.
3. Metode `load` delegate khusus wajib memanggil `material_ui.DefaultMaterialLocalizations.load(locale)`.
4. `supportedLocales` wajib tetap memuat `Locale('id', 'ID')` agar delegate global Flutter dan delegate `material_ui` selaras.
5. Jangan menghapus delegate khusus ini meskipun tidak ada error analyzer, karena error hanya muncul pada runtime saat dialog ditampilkan.

**Larangan:**

- Jangan mengandalkan `material_ui.DefaultMaterialLocalizations.delegate` langsung pada `MaterialApp.localizationsDelegates`, karena `isSupported`-nya hanya `true` untuk locale `en`, sehingga pada locale `id` delegate tidak dimuat dan `Localizations.of` mengembalikan `null`.
- Jangan menghapus `_MaterialUiLocalizationsDelegate` dari `localizationsDelegates` untuk "merapikan" kode, meskipun analyzer tidak melaporkan masalah.
- Jangan mengganti delegate khusus dengan delegate Flutter bawaan (`GlobalMaterialLocalizations.delegate`) karena tipe `MaterialLocalizations` yang dicari `adaptive_dialog`/`material_ui` berbeda dari tipe Flutter.

**Alasan:**

Paket `material_ui` (versi terpasang `^1.10.0`) mendefinisikan kelas `MaterialLocalizations` tersendiri yang tidak identik dengan `MaterialLocalizations` milik Flutter SDK. Delegate bawaan paket tersebut (`_MaterialLocalizationsDelegate`) hanya mengembalikan `true` pada `isSupported` untuk `locale.languageCode == 'en'`. Aplikasi ini mendukung `Locale('id', 'ID')`, sehingga pada runtime delegate bawaan tidak dimuat, `Localizations.of<material_ui.MaterialLocalizations>(context)` mengembalikan `null`, dan `adaptive_dialog` memanggil null-check operator pada nilai tersebut → `Null check operator used on a null value`. Delegate khusus dengan `isSupported => true` memastikan `DefaultMaterialLocalizations` selalu dimuat untuk locale apa pun yang didukung aplikasi.

**Dampak apabila dilanggar:**

- `adaptive_dialog` melempar `Null check operator used on a null value` saat `showOkCancelAlertDialog`/`showModalActionSheet` dipanggil.
- Dialog konfirmasi (termasuk konfirmasi penghapusan data yang diwajibkan oleh Aturan UX 1) gagal ditampilkan, sehingga pengguna tidak dapat memberikan konfirmasi sebelum operasi destruktif.
- Error bersifat runtime dan tidak terdeteksi oleh `flutter analyze`, sehingga berpotensi lolos ke APK.

**Rujukan implementasi:**

- `lib/app.dart` — kelas `_MaterialUiLocalizationsDelegate` dan pendaftarannya pada `MaterialApp.localizationsDelegates`.
- `pubspec.yaml` — `adaptive_dialog: ^3.0.1`, `material_ui: ^1.10.0`, `flutter_localizations` (SDK).
- Source paket: `~/.pub-cache/hosted/pub.dev/material_ui-1.10.0/lib/src/material_localizations.dart` — kelas `MaterialLocalizations`, `DefaultMaterialLocalizations`, dan `_MaterialLocalizationsDelegate.isSupported` (`locale.languageCode == 'en'`).
- Aturan global: `aturan_lainnya.md` poin 33 (Lokalisasi Aplikasi), `aturan_pemanfaatan_sdk_dan_paket.md` bagian 4.5 (adaptive_dialog).

**Contoh benar:**

```dart
import 'package:material_ui/material_ui.dart' as mui;

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
  ) =>
      false;
}

MaterialApp(
  supportedLocales: const [Locale('id', 'ID')],
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    _MaterialUiLocalizationsDelegate(),
  ],
);
```

**Contoh salah:**

```dart
MaterialApp(
  supportedLocales: const [Locale('id', 'ID')],
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    // material_ui.DefaultMaterialLocalizations.delegate tidak didaftarkan.
    // Delegate bawaan material_ui hanya isSupported untuk locale 'en'.
  ],
);
```

**Penjelasan perbedaan:**

Contoh benar mendaftarkan delegate khusus dengan `isSupported => true` sehingga `material_ui.DefaultMaterialLocalizations` selalu dimuat untuk locale `id`, dan `adaptive_dialog` memperoleh instance `MaterialLocalizations` yang tidak `null`. Contoh salah mengandalkan delegate global Flutter atau delegate bawaan `material_ui`; pada locale `id` delegate bawaan `material_ui` tidak dimuat, `Localizations.of<material_ui.MaterialLocalizations>(context)` mengembalikan `null`, dan `adaptive_dialog` melempar `Null check operator used on a null value` saat dialog ditampilkan.

## Padding Tepi Layar pada `KendaraanTerpilihList`

`KendaraanTerpilihList` (`lib/shared/widget/kendaraan_terpilih_list.dart`) merupakan widget reusable yang menampilkan daftar chip kendaraan secara horizontal. Widget ini **tidak** menyertakan padding tepi layar di dalam dirinya sendiri (sesuai `optimasi_ux.md` §10 — padding tepi layar merupakan tanggung jawab container halaman). Jika halaman tidak membungkus widget ini dengan `Padding`, chip paling kiri/kanan akan menempel pada batas layar.

**Cakupan:**

- `lib/shared/widget/kendaraan_terpilih_list.dart` — widget reusable.
- Seluruh halaman yang menggunakan widget ini: `bahan_bakar_page.dart`, `km_page.dart`, `impian_page.dart`, `transaksi_page.dart`, `dashboard_page.dart`, `pengingat_page.dart`, `jadwal_service_page.dart`, `komponen_page.dart`, `statistik_bahan_bakar.dart`.

**Aturan wajib:**

1. Setiap halaman yang menggunakan `KendaraanTerpilihList` wajib membungkusnya dengan `Padding` (screen-edge padding) pada lapisan halaman.
2. Nilai padding mengikuti standar horizontal yang sudah digunakan halaman tersebut (mis. `EdgeInsets.all(12)` pada `bahan_bakar_page.dart`, `EdgeInsets.all(16)` pada `km_page.dart`). Jangan memaksakan satu nilai universal yang bertentangan dengan standar halaman.
3. Jangan menambahkan padding tepi layar di dalam widget `KendaraanTerpilihList` itu sendiri.

**Larangan:**

- Jangan menempatkan `KendaraanTerpilihList` langsung di dalam `Column`/`Row` halaman tanpa pembungkus `Padding`, karena chip akan menempel pada tepi layar.
- Jangan memodifikasi `KendaraanTerpilihList` untuk menambahkan padding tepi layar, karena akan menyebabkan padding ganda pada halaman yang sudah membungkusnya.

**Alasan:**

Widget ini reusable dan dipakai di banyak halaman dengan konteks padding yang berbeda. Tanggung jawab screen-edge padding berada pada container halaman (per `optimasi_ux.md` §10). Sebelumnya `bahan_bakar_page.dart` menempatkan widget ini langsung di `Column` tanpa `Padding`, sehingga chip menempel pada tepi layar.

**Dampak apabila dilanggar:**

- Chip kendaraan menempel pada batas kiri/kanan layar, melanggar aturan padding tepi layar (`optimasi_ux.md` §10).
- Inconsistent dengan halaman lain (`km_page.dart`) yang sudah membungkus widget ini dengan `Padding`.

**Rujukan implementasi:**

- `lib/fitur/bahan_bakar/page/bahan_bakar_page.dart` — `Padding(padding: const EdgeInsets.all(12), child: KendaraanTerpilihList(...))`.
- `lib/fitur/km/page/km_page.dart` — pola yang sama (`Padding` + `KendaraanTerpilihList`).
- `lib/shared/widget/kendaraan_terpilih_list.dart` — widget reusable tanpa screen-edge padding.
- `.agents/rules/global/optimasi_ux.md` §10 — aturan padding tepi layar.

**Contoh benar:**

```dart
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
    Expanded(child: _buildListBbm(context, bahanBakarState, kendaraanState)),
  ],
),
```

**Contoh salah:**

```dart
body: Column(
  children: [
    KendaraanTerpilihList(
      listKendaraan: kendaraanState.listKendaraan,
      selectedId: selectedId,
      onSelected: (kendaraan) {
        setState(() => _kendaraanTerpilih = kendaraan);
      },
      onReload: _reloadKendaraanTerpilih,
    ),
    Expanded(child: _buildListBbm(context, bahanBakarState, kendaraanState)),
  ],
),
```

## Navigasi Tab Utama (Home) — Inisialisasi Lazy dan Retensi State

**Cakupan:**

- `lib/home.dart` — kelas `Home` / `_HomeState`, khususnya `build` (IndexedStack), `_saatPilihTab`, dan `_scrollKeAtas`.
- Kelima tab: Dashboard, KM, Jadwal Service, Transaksi, Lainnya, beserta `GlobalKey` masing-masing (`_kunciDashboard`, `_kunciKm`, `_kunciJadwal`, `_kunciTransaksi`, `_kunciLainnya`).

**Aturan wajib:**

1. Gunakan `IndexedStack` dengan daftar yang dibangun secara **lazy**: tab hanya dibuat saat pertama kali dipilih, lalu tetap dipertahankan (state tidak dibuang).
2. Simpan tab yang sudah pernah dibuka dalam `Set<int> _tabTerbuka` (awalnya `{0}`). Tambahkan indeks ke set ini sebelum mengubah `_selectedIndex` ke tab baru.
3. Setiap tab yang belum pernah dibuka direpresentasikan sebagai `SizedBox.shrink()` pada slot IndexedStack-nya, sehingga tidak membangun widget/provider tab tersebut.
4. Pertahankan `GlobalKey<State<...>>` per tab agar `currentState` tetap dapat diakses untuk fitur scroll-to-top setelah tab dibuka.
5. Deteksi double-tap pada tab yang sedang aktif dengan jendela waktu `<= 500ms` (`_durasiDoubleTap`), lalu panggil `_scrollKeAtas(i)` dan reset `_lastTapTime = null`.
6. Pada `_scrollKeAtas`, periksa `state == null` terlebih dahulu (tab belum dibuka) dan log `L.w` + `return` (jangan crash/cast).
7. Hanya panggil `scrollToTop()` dan log sukses apabila state mengimplementasikan `ScrollKeAtas`; log `L.w` jika tidak.

**Larangan:**

- Jangan kembali ke pola `IndexedStack` dengan kelima halaman selalu dibangun sekaligus (menyebabkan lag saat pindah tab dan beban awal tinggi).
- Jangan menghapus `_tabTerbuka` / lazy loading dengan alasan "merapikan", karena itu akan memicu rebuild/provider tab yang belum dikunjungi.
- Jangan menghapus `GlobalKey` per tab, karena fitur double-tap scroll-to-top bergantung pada `currentState`.
- Jangan memanggil `scrollToTop()` tanpa memeriksa `state == null` dan tipe `ScrollKeAtas`.
- Jangan log "scroll berhasil" tanpa benar-benar memanggil `scrollToTop()`.

**Alasan:**

Sebelumnya semua tab dibangun dan tetap hidup sejak awal, sehingga perubahan data/provider di tab lain dapat memicu rebuild dan beban memori tinggi, menyebabkan pindah tab terasa berat. Lazy loading mengurangi beban awal dan beban tab yang belum dikunjungi, sambil tetap mempertahankan state tab yang sudah dibuka. Double-tap scroll-to-top bergantung pada `GlobalKey.currentState`; tab yang belum dibuka memiliki state `null` dan harus ditangani agar tidak crash.

**Dampak apabila dilanggar:**

- Lag saat pindah tab dan saat pertama membuka aplikasi.
- State tab (scroll position, filter, input) hilang atau dibangun ulang.
- Crash null saat double-tap pada tab yang belum pernah dibuka.
- Log menyesatkan yang menyatakan scroll berhasil padahal tidak dieksekusi.

**Rujukan implementasi:**

- `lib/home.dart` — `_tabTerbuka`, `IndexedStack` + `List.generate`, `_saatPilihTab`, `_scrollKeAtas`.
- `lib/shared/widget/scroll_ke_atas.dart` — interface `ScrollKeAtas`.
- Halaman tab yang mengimplementasikan `ScrollKeAtas`: `dashboard_page.dart`, `km_page.dart`, `jadwal_service_page.dart`, `transaksi_page.dart`, `lainnya_page.dart`.

**Contoh benar:**

```dart
final Set<int> _tabTerbuka = {0};

IndexedStack(
  index: _selectedIndex,
  children: List<Widget>.generate(5, (i) {
    if (!_tabTerbuka.contains(i)) {
      return const SizedBox.shrink();
    }
    return switch (i) {
      0 => DashboardPage(key: _kunciDashboard),
      1 => KmPage(key: _kunciKm),
      _ => LainnyaPage(key: _kunciLainnya),
    };
  }),
)

void _saatPilihTab(int i) {
  final sekarang = DateTime.now();
  final lastTap = _lastTapTime;
  final tabSama = i == _selectedIndex;
  final doubleTap =
      tabSama && lastTap != null && sekarang.difference(lastTap) <= _durasiDoubleTap;

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
    _ => _kunciLainnya.currentState,
  };
  if (state == null) {
    L.w('Scroll ke atas diabaikan: state tab ke-$i belum tersedia');
    return;
  }
  if (state case final ScrollKeAtas scrollable) {
    try {
      scrollable.scrollToTop();
      L.i('Scroll ke atas pada tab ke-$i');
    } catch (e, s) {
      L.e('Gagal scroll ke atas pada tab ke-$i: $e $s');
    }
  } else {
    L.w('Scroll ke atas diabaikan: tab ke-$i tidak mengimplementasikan ScrollKeAtas');
  }
}
```

**Contoh salah:**

```dart
// Semua tab selalu dibangun sejak awal.
IndexedStack(
  index: _selectedIndex,
  children: const [
    DashboardPage(key: _kunciDashboard),
    KmPage(key: _kunciKm),
    JadwalServicePage(key: _kunciJadwal),
    TransaksiPage(key: _kunciTransaksi),
    LainnyaPage(key: _kunciLainnya),
  ],
)

// Deteksi double-tap tidak reset dan log sukses tanpa memanggil scroll.
void _saatPilihTab(int i) {
  final sekarang = DateTime.now();
  final lastTap = _lastTapTime;
  final doubleTap =
      i == _selectedIndex && lastTap != null && sekarang.difference(lastTap) < _durasiDoubleTap;

  if (doubleTap) {
    _scrollKeAtas(i);
  } else {
    setState(() => _selectedIndex = i);
  }
  _lastTapTime = sekarang;
}

void _scrollKeAtas(int i) {
  final state = ...;
  if (state case final ScrollKeAtas scrollable) {
    try {
      scrollable.scrollToTop();
    } catch (e, s) {
      L.e('Gagal scroll ke atas pada tab ke-$i: $e $s');
    }
  }
  L.i('Scroll ke atas pada tab ke-$i'); // log menyesatkan
}
```

**Penjelasan perbedaan:**

Contoh benar membangun tab secara lazy (hanya saat pertama dipilih) dan tetap mempertahankan state, mendeteksi double-tap dengan reset waktu, serta hanya log sukses setelah `scrollToTop()` benar-benar dipanggil. Contoh salah membangun semua tab sejak awal (menyebabkan lag), tidak reset waktu setelah double-tap, dan log sukses meski scroll tidak dieksekusi (menyesatkan debugging).

## Kelengkapan Refresh pada `_buildError` (Halaman Multi-Provider)

**Cakupan:**

- Halaman yang me-`watch` lebih dari satu provider dan memiliki tombol "Coba lagi" / refresh, khususnya `DashboardPage` (`lib/fitur/dashboard/page/dashboard_page.dart`), `JadwalServicePage` (`lib/fitur/jadwal_service/page/jadwal_service_page.dart`), `KmPage`, dan `TransaksiPage`.

**Aturan wajib:**

1. Setiap provider yang di-`watch` di `build` (dan diperiksa loading/error-nya) wajib ikut di-`refresh` pada handler retry di `_buildError`.
2. Jangan melewatkan provider yang "sekunder" (mis. `mataUangProvider`, `kmProvider`) hanya karena tidak menjadi fokus utama halaman.
3. Urutan pemeriksaan `AsyncValue` tetap loading → error → data untuk semua provider terkait.

**Larangan:**

- Jangan refresh sebagian provider saja di `_buildError` (mis. refresh `kendaraanProvider`, `kmProvider`, `jadwalServiceProvider`, `transaksiProvider`, `impianProvider` tetapi lupa `mataUangProvider`).
- Jangan menambah provider baru ke `build` tanpa menambahkan refresh-nya di `_buildError`.

**Alasan:**

`DashboardPage` sebelumnya me-`watch` `mataUangProvider` dan menanganinya di loading/error, tetapi handler retry tidak me-refresh-nya. Akibatnya saat retry, data mata uang lama/stale tetap dipakai dan tampilan saldo bisa tidak konsisten. Hal serupa berlaku untuk `JadwalServicePage` yang me-`watch` `kmProvider` (dipakai untuk skor urgensi) tetapi tidak me-refresh-nya saat retry.

**Dampak apabila dilanggar:**

- Data stale setelah retry (mis. saldo/mata uang atau skor urgensi jadwal tidak terbarui).
- Inconsistent state antara provider yang direfresh dan yang tidak.

**Rujukan implementasi:**

- `lib/fitur/dashboard/page/dashboard_page.dart` — `_buildError` (refresh `kendaraanProvider`, `kmProvider`, `jadwalServiceProvider`, `transaksiProvider`, `impianProvider`, `mataUangProvider`).
- `lib/fitur/jadwal_service/page/jadwal_service_page.dart` — `_buildError` (refresh `jadwalServiceProvider`, `riwayatJadwalServiceProvider`, `kendaraanProvider`, `kmProvider`).

**Contoh benar:**

```dart
onPressed: () {
  final _ = ref.refresh(kendaraanProvider);
  final _ = ref.refresh(kmProvider);
  final _ = ref.refresh(jadwalServiceProvider);
  final _ = ref.refresh(transaksiProvider);
  final _ = ref.refresh(impianProvider);
  final _ = ref.refresh(mataUangProvider); // jangan lupa provider sekunder
},
```

**Contoh salah:**

```dart
onPressed: () {
  final _ = ref.refresh(kendaraanProvider);
  final _ = ref.refresh(kmProvider);
  final _ = ref.refresh(jadwalServiceProvider);
  final _ = ref.refresh(transaksiProvider);
  final _ = ref.refresh(impianProvider);
   // mataUangProvider tidak direfresh -> data mata uang stale
 },
 ```

**Penjelasan perbedaan:**

Contoh benar me-refresh seluruh provider yang di-`watch` (termasuk `mataUangProvider`), sehingga retry menghasilkan state konsisten. Contoh salah melewatkan provider sekunder, menyebabkan data stale setelah retry.

## Penempatan Metode `_buildLoading` dan `_buildError` di Bagian Bawah Kelas State

**Cakupan:**

- Seluruh halaman yang menggunakan `ConsumerState`/`State` dengan metode `_buildLoading()` dan/atau `_buildError()` (mis. `dashboard_page.dart`, `km_page.dart`, dan halaman serupa).

**Aturan wajib:**

1. Tempatkan metode `_buildLoading()` dan `_buildError()` di **bagian paling bawah** kelas State, setelah metode-metode lain (mis. `_buildForm`, `_buildList`, helper).
2. Pertahankan urutan internal yang konsisten: `_buildLoading()` terlebih dahulu, kemudian `_buildError()`, sebelum penutup kelas `}`.
3. Pastikan metode tetap berada pada level anggota kelas (bukan metode lokal/nested di dalam metode lain).
4. Setelah memindahkan metode, jalankan `dart format` dan `flutter analyze` untuk memastikan tidak ada kesalahan kompilasi (mis. `undefined_method` akibat nesting).

**Larangan:**

- Jangan menempatkan `_buildLoading()`/`_buildError()` tepat setelah `build()` atau di tengah metode lain sehingga batas blok menjadi ambigu.
- Jangan memindahkan metode dengan memotong/memindahkan blok tanpa memeriksa penutupan kurung kurawal (`}`), karena metode dapat tidak sengaja tersarang di dalam metode lain.

**Alasan:**

Penempatan di bawah kelas memudahkan navigasi (UI utama di atas, fallback UI di bawah) dan mengikuti konvensi yang telah diterapkan pada halaman seperti `DashboardPage` dan `KmPage`. Pemindahan manual dengan edit tool berisiko merusak batas blok jika kurung kurawal tidak diperiksa.

**Dampak apabila dilanggar:**

- Struktur kelas tidak konsisten antar halaman.
- Risiko metode menjadi lokal/nested, menyebabkan `undefined_method` saat dipanggil dari `build()`.

**Rujukan implementasi:**

- `lib/fitur/dashboard/page/dashboard_page.dart` — `_buildLoading()` dan `_buildError()` di bagian bawah `_DashboardPageState`.
- `lib/fitur/km/page/km_page.dart` — `_buildError()` di bagian bawah `_KmPageState`.

**Contoh benar:**

```dart
class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    if (isLoading) return _buildLoading();
    if (hasError) return _buildError();
    return Scaffold(/* ... */);
  }

  Widget _buildCardKm(KmModel? kmTerbaru) { /* ... */ }

  Widget _buildLoading() {
    return Scaffold(/* ... */);
  }

  Widget _buildError() {
    return Scaffold(/* ... */);
  }
}
```

**Contoh salah:**

```dart
class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    if (isLoading) return _buildLoading();
    if (hasError) return _buildError();
    return Scaffold(/* ... */);
  }

  Widget _buildLoading() { /* ... */ } // terlalu atas
  Widget _buildError() { /* ... */ }

  Future<void> _simpan() async {
    Widget _buildError() { // tersarang (metode lokal) — SALAH
      return Scaffold(/* ... */);
    }
  }
}
```

**Penjelasan perbedaan:**

Contoh benar menempatkan `_buildLoading()` dan `_buildError()` di bawah kelas sebagai metode anggota (dapat dipanggil dari `build`). Contoh salah menempatkannya terlalu atas dan, pada kasus kedua, secara tidak sengaja menjadikannya metode lokal di dalam `_simpan()` sehingga tidak dapat dipanggil dari `build()` (`undefined_method`).

## Konsolidasi Pemuatan Data Dashboard ke Provider Async

**Cakupan:**

- `lib/fitur/dashboard/provider/dashboard_provider.dart` — `DashboardNotifier` (kelas Notifier).
- `lib/fitur/dashboard/page/dashboard_page.dart` — `_DashboardPageState.build`.
- Provider yang dikonsolidasi: `impianProvider`, `kmProvider`, `transaksiProvider`, `jadwalServiceProvider`.

**Aturan wajib:**

1. Gunakan satu provider async (`dashboardProvider`) sebagai sumber data tunggal untuk halaman dashboard, bukan me-`watch` banyak provider secara terpisah di `build`.
2. Pindahkan logika perhitungan (sorting, scoring, pemilihan item terdekat) dari page ke provider/notifier. Page hanya mengonsumsi state yang sudah diproses.
3. Di dalam notifier, gunakan `ref.watch(provider.future)` (bukan `ref.watch(provider)`) untuk sumber data asynchronous, sesuai aturan Riverpod.
4. Pastikan provider yang dikonsolidasi tetap memeriksa loading/error semua sumber data di dalam `_muatData`, dan page menangani loading/error dari `dashboardProvider` saja.
5. Jangan duplikasi logika perhitungan antara page dan provider.

**Larangan:**

- Jangan me-`watch` `kmProvider`, `jadwalServiceProvider`, `transaksiProvider`, `impianProvider` secara terpisah di `build` halaman dashboard setelah konsolidasi.
- Jangan menyimpan logika sorting/scoring di page setelah dipindahkan ke provider.
- Jangan menggunakan `ref.watch(provider)` (tanpa `.future`) di dalam notifier untuk sumber data async.

**Alasan:**

Sebelum konsolidasi, `DashboardPage` me-`watch` 5 provider secara terpisah dan melakukan perhitungan `_jadwalTerdekat`, `_skorUrgensi`, `_rasioKm`, `_rasioHari` di page. Hal ini menyebabkan page menjadi berat dan logika bisnis bercampur dengan UI. Setelah konsolidasi, page hanya me-`watch` `dashboardProvider(selectedKendaraanIdState)` dan provider menangani seluruh pemuatan dan perhitungan.

**Dampak apabila dilanggar:**

- Page menjadi berat dan sulit dipelihara.
- Duplikasi logika antara page dan provider.
- Risiko state tidak konsisten karena perhitungan di dua tempat.
- Rebuild yang tidak perlu karena page bergantung pada banyak provider.

**Rujukan implementasi:**

- `lib/fitur/dashboard/provider/dashboard_provider.dart` — `_muatData`, `_jadwalTerdekat`, `_skorUrgensi`, `_rasioKm`, `_rasioHari`.
- `lib/fitur/dashboard/page/dashboard_page.dart` — `build` yang hanya me-`watch` `dashboardProvider`.

**Contoh benar:**

```dart
// Provider: konsolidasi semua data dan perhitungan.
@Riverpod(keepAlive: true)
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Future<DashboardState> build(String? idKendaraan) async =>
      await _muatData(idKendaraan);

  Future<DashboardState> _muatData(String? idKendaraan) async {
    final impianState = await ref.watch(impianProvider.future);
    final kmState = await ref.watch(kmProvider.future);
    final transaksiState = await ref.watch(transaksiProvider.future);
    final jadwalState = await ref.watch(jadwalServiceProvider.future);
    // ... perhitungan di sini ...
    return DashboardState(/* ... */);
  }
}

// Page: hanya konsumsi provider tunggal.
final dashboardAsync = ref.watch(dashboardProvider(selectedKendaraanIdState));
if (dashboardAsync.isLoading) return _buildLoading();
if (dashboardAsync.hasError) return _buildError();
final dashboardState = dashboardAsync.requireValue;
```

**Contoh salah:**

```dart
// Page: me-watch banyak provider dan hitung di page (sebelum konsolidasi).
final kmAsync = ref.watch(kmProvider);
final jadwalAsync = ref.watch(jadwalServiceProvider);
final transaksiAsync = ref.watch(transaksiProvider);
final impianAsync = ref.watch(impianProvider);
// ... perhitungan _jadwalTerdekat, _skorUrgensi di page ...
```

**Penjelasan perbedaan:**

Contoh benar mengonsolidasi pemuatan dan perhitungan ke provider, sehingga page hanya mengonsumsi state yang sudah diproses. Contoh salah menyebarkan pemuatan dan perhitungan di page, menyebabkan page berat dan logika bercampur dengan UI.

## Migrasi State Dashboard dari List ke Field Scalar (Freezed)

**Cakupan:**

- `lib/fitur/dashboard/state/dashboard_state.dart` — `DashboardState`.
- `lib/fitur/dashboard/provider/dashboard_provider.dart` — `DashboardNotifier`.

**Aturan wajib:**

1. Gunakan field scalar yang spesifik (`kmTerbaru`, `saldo`, `jadwalServiceTerdekat`, `jumlahImpian`, `impianTercapai`) alih-alih `List<DashboardModel>` pada state dashboard.
2. Gunakan tipe model nullable (`KmModel?`, `JadwalServiceModel?`) untuk field yang mungkin tidak tersedia, bukan `double` dengan default 0.
3. Gunakan `@Default(0)` untuk field numerik yang selalu ada.
4. Perbarui file `.freezed.dart` melalui generator setelah mengubah state (jangan edit manual).

**Larangan:**

- Jangan menggunakan `List<DashboardModel>` untuk state dashboard jika data yang dibutuhkan hanya ringkasan (km terbaru, saldo, jadwal terdekat, jumlah impian).
- Jangan menggunakan `double` dengan default 0 untuk field yang seharusnya model (mis. `kmTerbaru` sebagai `double`).
- Jangan mengedit file `.freezed.dart` secara manual.

**Alasan:**

State dashboard awalnya menggunakan `List<DashboardModel> listDashboard`, kemudian dimigrasikan ke field scalar yang lebih spesifik. `kmTerbaru` awalnya `double` (nilai km saja), kemudian diubah ke `KmModel?` agar menyimpan model lengkap. Ini lebih type-safe dan menyederhanakan akses data di UI.

**Dampak apabila dilanggar:**

- State menjadi tidak type-safe (mis. `kmTerbaru` sebagai `double` kehilangan informasi model).
- UI harus melakukan pencarian/filter pada list untuk mendapatkan data yang dibutuhkan.
- Risiko error runtime karena data tidak sesuai tipe.

**Rujukan implementasi:**

- `lib/fitur/dashboard/state/dashboard_state.dart` — definisi Freezed.
- `lib/fitur/dashboard/state/dashboard_state.freezed.dart` — file generated.

**Contoh benar:**

```dart
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

**Contoh salah:**

```dart
@freezed
abstract class DashboardState with _$DashboardState {
  const DashboardState._();

  const factory DashboardState({
    @Default([]) List<DashboardModel> listDashboard,
    @Default(0) double kmTerbaru, // seharusnya KmModel?
  }) = _DashboardState;
}
```

**Penjelasan perbedaan:**

Contoh benar menggunakan field scalar yang type-safe (`KmModel?`, `JadwalServiceModel?`) dan default value yang sesuai. Contoh salah menggunakan list yang memerlukan filter tambahan dan tipe `double` untuk km yang kehilangan informasi model.

## Family Provider untuk Parameter idKendaraan

**Cakupan:**

- `lib/fitur/dashboard/provider/dashboard_provider.dart` — `DashboardNotifier` dengan parameter `idKendaraan`.
- `lib/shared/provider/pemilih_kendaraan_provider.dart` — `pemilihKendaraan` dengan parameter `page` dan `value`.

**Aturan wajib:**

1. Gunakan family provider (`@Riverpod` dengan parameter pada `build`) ketika provider bergantung pada parameter eksternal (mis. `idKendaraan`).
2. Pastikan file `.g.dart` dihasilkan ulang setelah menambah/mengubah parameter `build`.
3. Berikan nama kelas Notifier yang konsisten (mis. `DashboardNotifier`, bukan `Dashboard`).
4. Gunakan `keepAlive: true` jika state perlu dipertahankan (mis. dashboard).
5. Gunakan `@Riverpod()` (auto-dispose) jika state tidak perlu dipertahankan (mis. pemilih kendaraan).

**Larangan:**

- Jangan menggunakan functional provider (`int dashboard(Ref ref)`) jika state perlu dimutasi melalui metode (gunakan Notifier kelas).
- Jangan menambah parameter pada `build` tanpa meregenerasi file `.g.dart`.
- Jangan menggunakan nama kelas Notifier yang tidak konsisten.

**Alasan:**

Dashboard provider awalnya adalah functional provider sederhana (`int dashboard(Ref ref) => 0`), kemudian dimigrasikan ke Notifier kelas, dan akhirnya menjadi family provider dengan parameter `idKendaraan`. Ini menunjukkan evolusi dari provider sederhana ke provider yang lebih kompleks dan reusable.

**Dampak apabila dilanggar:**

- Provider tidak dapat menerima parameter, sehingga tidak reusable untuk kendaraan berbeda.
- File `.g.dart` tidak sinkron dengan sumber, menyebabkan error kompilasi.
- Inconsistent naming menyebabkan kebingungan.

**Rujukan implementasi:**

- `lib/fitur/dashboard/provider/dashboard_provider.dart` — `DashboardNotifier` dengan `build(String? idKendaraan)`.
- `lib/fitur/dashboard/provider/dashboard_provider.g.dart` — file generated.

**Contoh benar:**

```dart
@Riverpod(keepAlive: true)
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Future<DashboardState> build(String? idKendaraan) async =>
      await _muatData(idKendaraan);
}
```

**Contoh salah:**

```dart
// Functional provider tanpa parameter (tidak bisa menerima idKendaraan).
@Riverpod(keepAlive: true)
int dashboard(Ref ref) {
  return 0;
}
```

**Penjelasan perbedaan:**

Contoh benar menggunakan Notifier kelas dengan parameter, sehingga provider dapat menerima `idKendaraan` dan menghasilkan state yang berbeda per kendaraan. Contoh salah menggunakan functional provider tanpa parameter, sehingga tidak dapat menerima input dan tidak dapat dimutasi.

## Penempatan Metode scrollToTop pada Kelas State

**Cakupan:**

- Halaman yang mengimplementasikan interface `ScrollKeAtas` (mis. `dashboard_page.dart`, `km_page.dart`).
- Metode `scrollToTop()`.

**Aturan wajib:**

1. Tempatkan metode `scrollToTop()` (implementasi interface `ScrollKeAtas`) di bagian **atas** kelas State, sebelum metode `build()`.
2. Pastikan metode tetap berada pada level anggota kelas.
3. Jangan menempatkan `scrollToTop()` di bagian bawah kelas (berbeda dari `_buildLoading`/`_buildError` yang ditempatkan di bawah).

**Larangan:**

- Jangan menempatkan `scrollToTop()` di bagian bawah kelas State (setelah `build()` dan helper lain).
- Jangan memindahkan metode tanpa memeriksa batas blok kurung kurawal.

**Alasan:**

Metode `scrollToTop()` adalah implementasi interface yang dipanggil dari luar (via `GlobalKey.currentState`), bukan dari dalam `build()`. Penempatannya di atas kelas (sebelum `build()`) memudahkan navigasi dan konsisten dengan pola yang diterapkan pada `DashboardPage`. Berbeda dari `_buildLoading`/`_buildError` yang ditempatkan di bawah karena merupakan fallback UI yang jarang dirujuk.

**Dampak apabila dilanggar:**

- Struktur kelas tidak konsisten antar halaman.
- Metode interface sulit ditemukan karena tercampur dengan helper internal.

**Rujukan implementasi:**

- `lib/fitur/dashboard/page/dashboard_page.dart` — `scrollToTop()` di atas `build()`.

**Contoh benar:**

```dart
class _DashboardPageState extends ConsumerState<DashboardPage>
    implements ScrollKeAtas {
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
    // ...
  }
}
```

**Contoh salah:**

```dart
class _DashboardPageState extends ConsumerState<DashboardPage>
    implements ScrollKeAtas {
  @override
  Widget build(BuildContext context) {
    // ...
  }

  // scrollToTop di bawah — tidak konsisten.
  @override
  void scrollToTop() {
    // ...
  }
}
```

**Penjelasan perbedaan:**

Contoh benar menempatkan `scrollToTop()` di atas `build()` sehingga metode interface mudah ditemukan. Contoh salah menempatkannya di bawah, tidak konsisten dengan pola yang diterapkan pada halaman lain.

## Nonaktifkan Konfigurasi Linter pada analysis_options.yaml

**Cakupan:**

- `analysis_options.yaml` — seluruh konfigurasi linter dan analyzer.

**Status:** Keputusan pengguna (sementara), bukan aturan wajib.

**Temuan:**

Pada commit `4cfa0c83`, seluruh konfigurasi linter dan analyzer pada `analysis_options.yaml` di-comment out (termasuk `include: package:flutter_lints/flutter.yaml`, rules linter, plugins riverpod_lint, dan analyzer exclude/language).

**Alasan pengguna:**

Linter dinonaktifkan untuk sementara karena berat ke device. Ini adalah keputusan pengguna yang perlu dihormati selama pengembangan.

**Dampak:**

- Analyzer tidak lagi melaporkan error/warning/info pada kode.
- Temuan potensial bug (null safety, unawaited futures, dll.) tidak terdeteksi.
- Kode dapat memiliki masalah yang tidak terdeteksi.

**Rekomendasi (ketika linter diaktifkan kembali):**

- Aktifkan kembali konfigurasi linter dan analyzer.
- Jika terdapat konflik dengan kode yang ada, perbaiki kode agar sesuai dengan rules, bukan menonaktifkan rules.
- Jika rules tertentu memang tidak sesuai, nonaktifkan secara selektif dengan alasan yang jelas, bukan seluruhnya.

**Catatan:**

Keputusan ini bersifat sementara. Ketika device sudah mampu menangani analyzer, linter sebaiknya diaktifkan kembali untuk mendeteksi potensi bug. AI tidak boleh mengubah `analysis_options.yaml` melalui command ini tanpa persetujuan pengguna.

## Penggunaan EasyLoading Overlay pada Aksi Simpan (Form Jadwal Service)

**Cakupan:**

- `lib/fitur/jadwal_service/page/form_jadwal_service.dart` — `_FormJadwalServiceState._simpanForm` dan `_buildTombolSimpan`.
- Aksi simpan lain yang menggunakan `flutter_easyloading` sebagai overlay loading (sesuai `optimasi_ux.md` §12).

**Aturan wajib:**

1. Tampilkan overlay loading melalui `unawaited(EasyLoading.show(status: 'Menyimpan...'))` segera setelah flag `_isLoading` diaktifkan.
2. Sembunyikan overlay melalui `unawaited(EasyLoading.dismiss())` di dalam blok `finally`, sebelum mengembalikan `_isLoading` ke `false`.
3. Pertahankan guard double-submit di awal metode: `if (_isLoading) { L.w(...); return; }`.
4. Karena loading ditangani oleh overlay, tombol simpan tidak perlu menampilkan spinner sendiri maupun dinonaktifkan melalui `onPressed: _isLoading ? null : _simpanForm`; cukup panggil `_simpanForm` langsung.
5. Pastikan `_isLoading` dikembalikan ke `false` pada semua jalur (sukses, error, dan finally), dengan pemeriksaan `mounted` sebelum `setState`.

**Larangan:**

- Jangan menampilkan spinner di dalam tombol sekaligus overlay EasyLoading untuk aksi yang sama (redundan).
- Jangan menghilangkan guard `_isLoading` di awal metode ketika overlay digunakan, karena tombol tetap dapat ditekan berulang.
- Jangan memanggil `EasyLoading.dismiss()` tanpa `unawaited` atau di luar `finally`, karena overlay dapat tertinggal saat terjadi exception.

**Alasan:**

Pada form jadwal service, loading awalnya ditampilkan di dalam tombol (`CircularProgressIndicator` + `onPressed: _isLoading ? null : _simpanForm`). Setelah ditambahkan overlay EasyLoading, spinner di tombol menjadi redundan dan tombol dinonaktifkan secara manual tidak lagi diperlukan, karena guard `_isLoading` di awal `_simpanForm` sudah mencegah double-submit, sementara overlay memberikan feedback visual kepada pengguna.

**Dampak apabila dilanggar:**

- Overlay loading tertinggal (tidak hilang) ketika terjadi exception, sehingga UI terkunci.
- Double-submit dapat terjadi jika guard `_isLoading` dihilangkan.
- Tampilan loading ganda (spinner di tombol + overlay) yang tidak konsisten.

**Rujukan implementasi:**

- `lib/fitur/jadwal_service/page/form_jadwal_service.dart` — `_simpanForm` (guard, `EasyLoading.show`, `EasyLoading.dismiss` di `finally`).
- `.agents/rules/global/optimasi_ux.md` §12 — loading dan penguncian aksi.

**Contoh benar:**

```dart
Future<void> _simpanForm() async {
  if (_isLoading) {
    L.w('Form masih loading, simpan diabaikan');
    return;
  }
  // ... validasi ...
  setState(() => _isLoading = true);
  unawaited(EasyLoading.show(status: 'Menyimpan...'));
  try {
    // ... operasi simpan ...
  } on Exception catch (e, s) {
    L.e('Gagal menyimpan: $e $s');
    if (mounted) AppToast.gagal(context, 'Gagal menyimpan');
  } finally {
    if (mounted) {
      unawaited(EasyLoading.dismiss());
      setState(() => _isLoading = false);
    }
  }
}

Widget _buildTombolSimpan() {
  return OutlinedButton(
    onPressed: _simpanForm,
    child: const Text('Simpan'),
  );
}
```

**Contoh salah:**

```dart
Widget _buildTombolSimpan() {
  // Loading ganda: spinner di tombol + overlay EasyLoading.
  return OutlinedButton(
    onPressed: _isLoading ? null : _simpanForm,
    child: _isLoading
        ? const CircularProgressIndicator(strokeWidth: 2)
        : const Text('Simpan'),
  );
}

Future<void> _simpanForm() async {
  // Guard dihilangkan -> double-submit.
  setState(() => _isLoading = true);
  EasyLoading.show(status: 'Menyimpan...'); // tanpa unawaited
  try {
    // ...
  } finally {
    setState(() => _isLoading = false); // dismiss tidak dipanggil -> overlay tertinggal
  }
}
```

**Penjelasan perbedaan:**

Contoh benar menggunakan guard `_isLoading` di awal metode, overlay EasyLoading dengan `unawaited`, dan `EasyLoading.dismiss()` di `finally`, sehingga loading selalu dihentikan meskipun terjadi exception. Contoh salah menampilkan loading ganda, menghilangkan guard, dan tidak menjamin dismiss overlay.

## Hierarki Tipografi pada Tabel Perbandingan Kendaraan

**Cakupan:**

- `lib/fitur/kendaraan/page/perbandingan_kendaraan_page.dart` — DataTable dengan header kolom, label baris, dan nilai data.

**Aturan wajib:**

1. Header kolom (nama kendaraan dan 'Metrik') menggunakan `Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)`.
2. Label baris menggunakan `Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)`.
3. Nilai data cell menggunakan `Theme.of(context).textTheme.bodySmall`.
4. Hierarki ukuran: header (bodyLarge) > label (bodyMedium) > nilai (bodySmall).

**Larangan:**

- Jangan menggunakan ukuran yang sama untuk header, label, dan nilai, karena hierarki visual tidak terlihat.
- Jangan menggunakan `const TextStyle(fontWeight: FontWeight.bold)` tanpa acuan tema untuk warna dan ukuran.

**Alasan:**

Pada tabel perbandingan kendaraan, header kolom paling besar (bodyLarge bold), label baris sedang (bodyMedium bold), nilai data terkecil (bodySmall). Ini memberikan hierarki visual yang jelas sesuai aturan tipografi (hierarki visual label, sub-label, dan nilai).

**Dampak apabila dilanggar:**

- Hierarki visual tidak terlihat, pengguna sulit membedakan header, label, dan nilai.
- Tidak konsisten dengan standar tipografi proyek.

**Rujukan implementasi:**

- `lib/fitur/kendaraan/page/perbandingan_kendaraan_page.dart` — DataTable dengan tipografi hierarkis.

**Contoh benar:**

```dart
DataTable(
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
);
```

**Contoh salah:**

```dart
DataTable(
  columns: [
    const DataColumn(label: Text('Metrik')),
    ...data.map(
      (d) => DataColumn(
        label: Text(d.kendaraan.nama, overflow: TextOverflow.ellipsis),
      ),
    ),
  ],
  rows: rows.map((r) {
    return DataRow(
      cells: [
        DataCell(Text(r.label)),
        ...data.map((d) => DataCell(Text(r.nilai(d)))),
      ],
    );
  }).toList(),
);
```

**Penjelasan perbedaan:**

Contoh benar menggunakan hierarki tipografi yang jelas: header (bodyLarge bold), label (bodyMedium bold), nilai (bodySmall). Contoh salah menggunakan ukuran default yang sama untuk semua, sehingga hierarki visual tidak terlihat.

## Rujukan Implementasi Khusus Proyek

Aturan berikut merupakan penerapan dari aturan bersama (`aturan_bersama.md`) pada proyek ini. Prinsip umum tersimpan di aturan bersama; detail implementasi dan rujukan file tersimpan di sini.

- **Pengurutan Koleksi dengan `sorted`** — Rujukan: `lib/fitur/dashboard/provider/dashboard_provider.dart` (`_jadwalTerdekat`).
- **Penggunaan `maxBy`** — Rujukan: `lib/fitur/kendaraan/page/perbandingan_kendaraan_page.dart` (`maxBy(kmList, (km) => km.tanggal)`).
- **Ekstraksi Fungsi ke Helper** — Rujukan: `lib/fitur/bahan_bakar/helper/filter_bahan_bakar.dart` (`hitungJarakTempuh`), `lib/fitur/bahan_bakar/state/bahan_bakar_state.dart` (`_hitungSelisihKm`), `lib/fitur/kendaraan/page/perbandingan_kendaraan_page.dart`.
- **Anotasi Tipe Eksplisit** — Rujukan: `lib/fitur/kendaraan/page/perbandingan_kendaraan_page.dart` (`final BahanBakarState bahanBakarState = ...`, `final List<BahanBakarModel> bahanBakarList = ...`).

## Preferensi State Lokal daripada Re-watch Provider pada Halaman

