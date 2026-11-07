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

1. Tampilkan overlay loading melalui `unawaited(EasyLoading.show(status: 'Menyimpan...', maskType: EasyLoadingMaskType.black))` segera setelah flag `_isLoading` diaktifkan.
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
  unawaited(EasyLoading.show(status: 'Menyimpan...', maskType: EasyLoadingMaskType.black));
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

## Penggunaan maskType Hitam pada EasyLoading Overlay

**Cakupan:**

- `lib/fitur/biodata/screens/form_biodata.dart` — `_BiodataScreenState._simpan`.
- `lib/fitur/dummy/screens/dummy_screen.dart` — `_masukkanDummy`, `_hapusDummy`, `_reset`.
- Seluruh pemanggilan `EasyLoading.show` di proyek ini.

**Aturan wajib:**

1. Setiap pemanggilan `EasyLoading.show` wajib menyertakan `maskType: EasyLoadingMaskType.black`.
2. Mask type hitam memblokir interaksi UI di belakang overlay sehingga pengguna tidak dapat menekan tombol lain selama proses berlangsung.
3. Pertahankan konsistensi mask type pada semua overlay EasyLoading, jangan mencampur mask type berbeda untuk aksi yang sama.

**Larangan:**

- Jangan memanggil `EasyLoading.show` tanpa `maskType: EasyLoadingMaskType.black`.
- Jangan menggunakan mask type lain (mis. `none`, `clear`, `custom`) tanpa alasan yang jelas dan persetujuan pengguna.

**Alasan:**

Commit `53d7a0e` menambahkan `EasyLoadingMaskType.black` pada pemanggilan `EasyLoading.show` di `form_biodata.dart` dan `dummy_screen.dart` (3 tempat). Pola ini memastikan overlay memblokir interaksi UI di belakangnya secara konsisten, sehingga pengguna tidak dapat menekan tombol lain selama proses simpan/hapus berlangsung.

**Dampak apabila dilanggar:**

- Overlay tidak memblokir interaksi UI, sehingga pengguna dapat menekan tombol lain selama proses berlangsung (double-submit, race condition).
- Tampilan loading tidak konsisten antar halaman.

**Rujukan implementasi:**

- `lib/fitur/biodata/screens/form_biodata.dart` — `unawaited(EasyLoading.show(status: 'Menyimpan...', maskType: EasyLoadingMaskType.black))`.
- `lib/fitur/dummy/screens/dummy_screen.dart` — tiga pemanggilan `EasyLoading.show` dengan `maskType: EasyLoadingMaskType.black`.
- `.agents/rules/global/aturan_bersama.md` — "Penggunaan EasyLoading Overlay pada Aksi Simpan".

**Contoh benar:**

```dart
unawaited(
  EasyLoading.show(
    status: 'Menyimpan...',
    maskType: EasyLoadingMaskType.black,
  ),
);
```

**Contoh salah:**

```dart
unawaited(EasyLoading.show(status: 'Menyimpan...')); // tanpa maskType
```

**Sumber evaluasi:**

- Commit: `53d7a0e77ad68752a2a8c90d4bc92b92ea73aec0`
- File: `lib/fitur/biodata/screens/form_biodata.dart`, `lib/fitur/dummy/screens/dummy_screen.dart`

## Inisialisasi EasyLoading pada App

**Cakupan:**
- `lib/app.dart` — `_MyAppState.build`, khususnya `MaterialApp.builder`.

**Aturan wajib:**
1. Inisialisasi `flutter_easyloading` pada `MaterialApp.builder` menggunakan `EasyLoading.init()`.
2. Jangan memanggil `EasyLoading.init()` di tempat lain atau menggantinya dengan widget loading custom.

**Contoh benar:**
```dart
MaterialApp(
  builder: EasyLoading.init(),
  /* ... */
);
```

**Contoh salah:**
```dart
MaterialApp(
  // EasyLoading.init() tidak didaftarkan -> overlay tidak tampil.
  /* ... */
);
```

**Alasan:**
`EasyLoading.init()` mendaftarkan overlay builder yang diperlukan agar `EasyLoading.show()` dapat menampilkan loading overlay di atas seluruh UI.

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

## Pewarnaan Semantik pada Tombol Aksi

**Cakupan:**
- `lib/fitur/dummy/screens/dummy_screen.dart` — `_DummyScreenState._buildTombolCustom` dan pemanggilannya.

**Aturan wajib:**
1. Tombol aksi dengan fungsi berbeda wajib dibedakan warnanya agar pengguna dapat mengenali tindakan berdasarkan warna, bukan hanya label teks.
2. Gunakan warna semantik yang konsisten: hijau untuk tindakan penambahan/insert, merah untuk tindakan penghapusan/destruktif, oranye untuk tindakan reset/peringatan.
3. Terapkan warna melalui parameter `backgroundColor` pada builder tombol (mis. `_buildTombolCustom`), bukan dengan membuat widget tombol terpisah per warna.
4. Atur `foregroundColor` teks menjadi putih (`Colors.white`) agar kontras dengan background berwarna tetap terjaga.
5. Jika tombol baru ditambahkan dengan fungsi yang berbeda, pilih warna yang sesuai dengan kategori semantiknya; jangan menggunakan warna yang sama untuk fungsi yang berbeda.

**Larangan:**
- Jangan menggunakan warna default (tanpa `backgroundColor`) untuk semua tombol aksi yang memiliki fungsi berbeda, karena pengguna sulit membedakan tindakan.
- Jangan membuat widget tombol terpisah (`_buildTombolHijau`, `_buildTombolMerah`) hanya untuk perbedaan warna; gunakan parameter `backgroundColor`.
- Jangan menggunakan warna yang kontras rendah (mis. teks gelap pada background gelap) yang menyulitkan pembacaan.

**Alasan:**
Commit `f220f801` menambahkan parameter `backgroundColor` pada `_buildTombolCustom` dan mewarnai tombol insert (hijau), hapus (merah), dan reset (oranye) dengan `foregroundColor: Colors.white`. Pola ini membantu pengguna membedakan tindakan berdasarkan warna, terutama pada layar dummy yang sering dipakai untuk pengujian data. Penggunaan parameter tunggal menjaga konsistensi implementasi dan menghindari duplikasi widget tombol.

**Dampak apabila dilanggar:**
- Pengguna sulit membedakan tombol aksi yang berbeda fungsi, meningkatkan risiko tindakan tidak sengaja (mis. menekan hapus alih-alih insert).
- Tampilan tombol tidak konsisten antar layar yang menggunakan pola serupa.
- Duplikasi widget tombol yang sulit dipelihara.

**Rujukan implementasi:**
- `lib/fitur/dummy/screens/dummy_screen.dart` — `_buildTombolCustom(void Function() onPressed, String value, Color backgroundColor)`.

**Contoh benar:**
```dart
Widget _buildTombolCustom(
  void Function() onPressed,
  String value,
  Color backgroundColor,
) {
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

// Penggunaan dengan warna semantik.
_buildTombolCustom(() => unawaited(_masukkanDummy(context)), 'insert', Colors.green),
_buildTombolCustom(() => unawaited(_hapusDummy(context)), 'hapus', Colors.red),
_buildTombolCustom(() => unawaited(_reset(context)), 'reset', Colors.orange),
```

**Contoh salah:**
```dart
// Semua tombol menggunakan warna default, sulit dibedakan.
_buildTombolCustom(() => unawaited(_masukkanDummy(context)), 'insert'),
_buildTombolCustom(() => unawaited(_hapusDummy(context)), 'hapus'),
_buildTombolCustom(() => unawaited(_reset(context)), 'reset'),

Widget _buildTombolCustom(void Function() onPressed, String value) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(onPressed: onPressed, child: Text(value)),
  );
}
```

**Sumber evaluasi:**
- Commit: `f220f801d5b5aaa25db8bbf5124af44572708be2`
- File: `lib/fitur/dummy/screens/dummy_screen.dart`

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Pewarnaan semantik pada tombol aksi (hijau=insert, merah=hapus, oranye=reset) bersifat khusus proyek karena pilihan warna dan kategori tindakan bergantung pada konteks aplikasi. Namun, prinsip umum "gunakan warna berbeda untuk tombol dengan fungsi berbeda agar pengguna dapat membedakan tindakan" dapat diterapkan pada proyek Flutter lainnya sebagai panduan UX.

## Rujukan Implementasi Khusus Proyek

Aturan berikut merupakan penerapan dari aturan bersama (`aturan_bersama.md`) pada proyek ini. Prinsip umum tersimpan di aturan bersama; detail implementasi dan rujukan file tersimpan di sini.

- **Pengurutan Koleksi dengan `sorted`** — Rujukan: `lib/fitur/dashboard/provider/dashboard_provider.dart` (`_jadwalTerdekat`).
- **Penggunaan `maxBy`** — Rujukan: `lib/fitur/kendaraan/page/perbandingan_kendaraan_page.dart` (`maxBy(kmList, (km) => km.tanggal)`).
- **Ekstraksi Fungsi ke Helper** — Rujukan: `lib/fitur/bahan_bakar/helper/filter_bahan_bakar.dart` (`hitungJarakTempuh`), `lib/fitur/bahan_bakar/state/bahan_bakar_state.dart` (`_hitungSelisihKm`), `lib/fitur/kendaraan/page/perbandingan_kendaraan_page.dart`.
- **Anotasi Tipe Eksplisit** — Rujukan: `lib/fitur/kendaraan/page/perbandingan_kendaraan_page.dart` (`final BahanBakarState bahanBakarState = ...`, `final List<BahanBakarModel> bahanBakarList = ...`).

## Penyusunan Abjad Dependensi pada `pubspec.yaml`

**Tujuan:**
Menjaga konsistensi urutan dependensi agar perubahan pada `pubspec.yaml` mudah ditinjau dan dibandingkan.

**Aturan:**
1. Susun nama paket pada kelompok `dependencies` secara alfabetis (A–Z).
2. Susun nama paket pada kelompok `dev_dependencies` secara alfabetis (A–Z), terpisah dari `dependencies`.
3. Pertahankan kelompok dependensi asal setiap paket; jangan memindahkan paket dari `dependencies` ke `dev_dependencies` atau sebaliknya.
4. Penyusunan alfabetis hanya dilakukan setelah seluruh proses instalasi paket selesai.

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
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

**Alasan:**
Commit `e8b8ace` menyusun ulang dependensi `pubspec.yaml` secara alfabetis, dan perintah `install_ulang_paket.md` mewajibkan penyusunan alfabetis setelah instalasi. Pengurutan yang konsisten memudahkan peninjauan diff dan mencegah perubahan urutan yang tidak perlu.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Jaga konsistensi urutan entri dependensi pada `pubspec.yaml` (misalnya alfabetis) agar perubahan lebih mudah ditinjau, tanpa mengubah kelompok atau sumber dependensi yang sudah ditetapkan.

## Pemisahan Titik Masuk (main.dart) dan Widget Aplikasi (app.dart)

**Tujuan:**
Menjaga entry point aplikasi tetap minimal dan memisahkan tanggung jawab antara peluncuran aplikasi (`main()`) dan definisi widget root (`App`).

**Aturan:**
1. `main.dart` hanya memuat `main()` yang memanggil `runApp(const App())`, serta re-export `app.dart` agar `App` tetap dapat diimpor dari entry point.
2. Definisi kelas `App` dan logika widget root ditempatkan di `app.dart`.
3. Jangan menempatkan logika UI, state, atau konfigurasi tema yang kompleks di dalam `main()`.

**Contoh benar:**
```dart
// main.dart
import 'package:berhenti_merokok/app.dart';
import 'package:flutter/material.dart';

export 'package:berhenti_merokok/app.dart';

void main() {
  runApp(const App());
}
```

**Contoh salah:**
```dart
// main.dart berisi seluruh definisi App dan logika UI.
class App extends StatelessWidget { ... }
void main() => runApp(const App());
```

**Alasan:**
Commit `32967bb` memindahkan definisi `App` dari `main.dart` ke `app.dart` dan menyisakan `main()` di `main.dart` dengan re-export. Pemisahan ini memudahkan pengujian dan pemeliharaan entry point.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Pisahkan titik masuk aplikasi (`main()`) yang hanya menjalankan `runApp` dari definisi widget root (`App`) agar tanggung jawab setiap file jelas dan entry point tetap minimal.

## Root App Widget sebagai ConsumerStatefulWidget

**Tujuan:**
Memungkinkan widget root mengakses dan mengamati provider (misalnya tema) melalui Riverpod, serta menyembunyikan banner debug pada build non-debug.

**Aturan:**
1. Jika `App` perlu mengamati provider (misalnya `TemaNotifier`), gunakan `ConsumerStatefulWidget` alih-alih `StatelessWidget`.
2. Sertakan `debugShowCheckedModeBanner: false` pada `MaterialApp` untuk build pengembangan yang lebih bersih.
3. Jangan mengubah root widget menjadi `ConsumerStatefulWidget` jika tidak membutuhkan akses provider.

**Contoh benar:**
```dart
class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
ConsumerState<App> createState() => _MyAppState();
}
class _MyAppState extends ConsumerState<App> {
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

**Contoh salah:**
```dart
class App extends StatelessWidget {
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
Commit `38219ec` mengonversi `App` menjadi `ConsumerStatefulWidget` dan menambahkan `debugShowCheckedModeBanner: false`. Commit `e38d1c0` kemudian menerapkan mode tema dinamis: `ref.watch(temaProvider)` dibaca dengan `.asData?.value`, lalu `TemaEnum` dipetakan ke `ThemeMode` melalui switch expression, dan `MaterialApp` menyediakan `theme`, `darkTheme`, serta `themeMode`. Pola ini memungkinkan tema dan konfigurasi aplikasi dikendalikan oleh provider di root.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Gunakan `ConsumerStatefulWidget` pada widget root hanya ketika root perlu mengamati provider (misalnya tema/locale); pertahankan `debugShowCheckedModeBanner: false` pada build pengembangan.

## Layar Home sebagai ConsumerStatefulWidget dengan Siklus Hidup

**Tujuan:**
Memastikan layar utama yang membutuhkan akses provider dan pengelolaan siklus hidup (`initState`/`dispose`) menggunakan `ConsumerStatefulWidget`.

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
    return Scaffold(
      appBar: AppBar(title: const Text('data')),
      body: const Center(child: Text('Home')),
    );
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
Commit `0a6e373` menambahkan `Home` sebagai `ConsumerStatefulWidget` dengan `initState` dan `dispose`. Pola ini mempersiapkan layar untuk integrasi provider dan pengelolaan resource.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Gunakan `ConsumerStatefulWidget` untuk layar yang membutuhkan akses provider dan pengelolaan siklus hidup; pastikan `initState`/`dispose` memanggil `super` dengan benar.

## Pengelolaan Tema melalui TemaNotifier (Riverpod Generator)

**Tujuan:**
Mengelola state tema aplikasi melalui Notifier yang dibuat dengan `riverpod_generator`, bukan nilai hardcode di widget.

**Aturan:**
1. Buat `TemaNotifier` sebagai kelas `Notifier` dengan anotasi `@riverpod`.
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
Commit `4498593` menambahkan `TemaNotifier` menggunakan `riverpod_generator`. Pola ini memisahkan pengelolaan tema dari widget presentasi.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Kelola state tema aplikasi melalui Notifier (Riverpod Generator) agar tema dapat diubah dan diamati secara terpusat, bukan di-hardcode di widget.

## Penyediaan ProviderScope pada `main()`

**Tujuan:**
Memastikan root widget memiliki scope Riverpod yang valid sehingga provider dapat diakses dari seluruh aplikasi.

**Aturan:**
1. Bungkus `App` dengan `ProviderScope` di dalam `main()`.
2. Impor `flutter_riverpod` di `main.dart` untuk menggunakan `ProviderScope`.
3. Jangan memanggil `runApp(const App())` tanpa `ProviderScope` jika aplikasi menggunakan Riverpod.

**Contoh benar:**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}
```

**Contoh salah:**
```dart
void main() {
  runApp(const App()); // Tidak ada ProviderScope
}
```

**Alasan:**
Commit `38219ec` mengubah `runApp(const App())` menjadi `runApp(const ProviderScope(child: App()))`. Tanpa `ProviderScope`, pemanggilan provider di widget akan gagal saat runtime.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Setiap aplikasi yang menggunakan Riverpod wajib membungkus widget root dengan `ProviderScope` pada titik masuk `main()`.

## Sentralisasi Kunci Penyimpanan di `SharedKeys`

**Tujuan:**
Menghindari penggunaan string literal yang tersebar untuk kunci penyimpanan lokal.

**Aturan:**
1. Definisikan seluruh kunci penyimpanan (mis. `SharedPreferences`) dalam kelas `SharedKeys` dengan konstruktor privat.
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
Commit `fd2a129` menambahkan `SharedKeys` dengan kunci `tema`. Sentralisasi ini menjaga konsistensi dan memudahkan pemeliharaan.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Sentralisasikan kunci penyimpanan lokal dalam satu kelas dengan konstruktor privat dan konstanta `static const`, hindari string literal yang tersebar.

## Pertahankan State Tema dengan `keepAlive`

**Tujuan:**
Memastikan state tema tetap hidup selama aplikasi berjalan dan tidak di-dispose otomatis.

**Aturan:**
1. Gunakan `@Riverpod(keepAlive: true)` pada `TemaNotifier` agar state tema tidak hilang.
2. Jangan menggunakan `@riverpod` (auto-dispose) untuk state yang harus persisten sepanjang siklus hidup aplikasi.

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
Commit `14ee623` mengubah anotasi menjadi `@Riverpod(keepAlive: true)` agar `TemaNotifier` tetap hidup. Auto-dispose akan menghapus state tema ketika tidak ada listener.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Gunakan `keepAlive: true` pada provider yang state-nya harus persisten sepanjang siklus hidup aplikasi (misalnya tema), dan auto-dispose untuk state sementara.

## Enum Mode Tema (`TemaEnum`)

**Tujuan:**
Mengelola pilihan mode tema aplikasi (sistem, terang, gelap) menggunakan enum yang type-safe, bukan string literal.

**Aturan:**
1. Definisikan `TemaEnum` dengan nilai `sistem`, `terang`, dan `gelap`.
2. Gunakan `TemaEnum` sebagai tipe state `TemaNotifier` (bukan `String`).
3. Setiap nilai enum yang ditampilkan ke pengguna wajib memiliki getter `label` melalui extension.

**Contoh benar:**
```dart
enum TemaEnum { sistem, terang, gelap }

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
}
```

**Contoh salah:**
```dart
enum TemaEnum { sistem, terang, gelap } // tanpa extension label
// atau menggunakan String mentah sebagai state tema
```

**Alasan:**
Commit `206deca` menambahkan `TemaEnum` dan `riverpod_generator`; commit `eb762fe` memformat ulang enum. Enum memberikan type safety dan konsistensi dengan aturan enum yang ditampilkan ke pengguna.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Tidak terdapat prinsip umum baru yang layak dijadikan aturan bersama; aturan enum yang ditampilkan ke pengguna sudah tercakup di `optimasi_boilerplate.md`.

## Persistensi Tema melalui AsyncNotifier dan SharedPreferences

**Tujuan:**
Memuat preferensi tema tersimpan dari `SharedPreferences` saat inisialisasi dan menyimpannya setiap kali tema diubah.

**Aturan:**
1. `TemaNotifier` menggunakan `AsyncNotifier<TemaEnum>` dengan `build()` mengembalikan `Future<TemaEnum>`.
2. Baca nilai tersimpan via `prefs.getString(SharedKeys.tema)` dan konversi ke `TemaEnum` dengan fallback `TemaEnum.sistem`.
3. Metode `set([TemaEnum? tema])` menyimpan nilai ke `SharedPreferences` dan memperbarui `state` dengan `AsyncValue.data(...)`.
4. Gunakan fallback `tema ?? state.asData?.value ?? TemaEnum.sistem` untuk parameter opsional.

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
Commit `e61c6fb` memigrasikan `TemaNotifier` ke `AsyncNotifier` dan memuat tema tersimpan dari `SharedPreferences`; commit `94ffb11` membuat parameter `set` opsional dengan fallback ke state saat ini. Pola ini memastikan tema persisten antar sesi dan aman terhadap nilai null.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Saat state bergantung pada data asynchronous dari penyimpanan lokal, gunakan `AsyncNotifier` dan baca nilai dengan fallback yang aman; sediakan metode mutasi dengan parameter opsional yang fallback ke state saat ini.

## Parameter Opsional dengan Fallback ke State Saat Ini

**Tujuan:**
Mencegah null error saat metode mutasi state dipanggil tanpa argumen.

**Aturan:**
1. Jadikan parameter mutasi opsional (`[TemaEnum? tema]`).
2. Gunakan fallback `tema ?? state.asData?.value ?? nilaiDefault` sebelum memproses.

**Contoh benar:**
```dart
Future<void> set([TemaEnum? tema]) async {
  final nilai = tema ?? state.asData?.value ?? TemaEnum.sistem;
  // gunakan nilai
}
```

**Contoh salah:**
```dart
Future<void> set(TemaEnum tema) async {
  // tema bisa null di runtime jika dipanggil tanpa argumen
}
```

**Alasan:**
Commit `94ffb11` memperbaiki `set()` agar tidak gagal saat dipanggil tanpa argumen dengan fallback ke state saat ini.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Metode mutasi state yang menerima input opsional sebaiknya memiliki fallback ke state saat ini agar aman terhadap pemanggilan tanpa argumen.

## Penerapan Mode Tema Dinamis pada MaterialApp

**Tujuan:**
Menerapkan mode tema (terang/gelap/sistem) secara dinamis dari `TemaNotifier` ke `MaterialApp`.

**Aturan:**
1. Baca `temaProvider` dengan `ref.watch` dan ambil nilai aman melalui `.asData?.value`.
2. Petakan `TemaEnum` ke `ThemeMode` menggunakan switch expression.
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
  // tanpa darkTheme/themeMode
);
```

**Alasan:**
Commit `e38d1c0` menerapkan mode tema dinamis dari `TemaNotifier` ke `MaterialApp` dengan dukungan dark theme. Pola ini menjaga konsistensi tampilan pada mode terang/gelap/sistem.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Saat mengamati state async di widget, gunakan `.asData?.value` untuk membaca nilai dengan aman; sediakan `theme`, `darkTheme`, dan `themeMode` agar tema dapat berubah dinamis.

## Sinkronisasi Tema Material UI dengan Mode Terang/Gelap pada `App`
**Cakupan:**
- `lib/app.dart` — `_MyAppState` (WidgetsBindingObserver), `build`.
- Paket `material_ui` (`mui.Theme`, `mui.ThemeData`, `mui.ColorScheme`).
**Aturan wajib:**
1. `_MyAppState` wajib mengimplementasikan `WidgetsBindingObserver` dan mendaftarkan observer pada `initState` serta melepasnya pada `dispose`.
2. Implementasikan `didChangePlatformBrightness` yang memanggil `setState(() {})` agar UI membangun ulang saat kecerahan platform berubah.
3. Hitung `Brightness` aktif berdasarkan `ThemeMode` (terang → light, gelap → dark, sistem → `platformDispatcher.platformBrightness`).
4. Bangun `mui.ThemeData` dari `mui.ColorScheme.fromSeed` dengan brightness aktif, lalu bungkus `MaterialApp` dengan `mui.Theme(data: materialUiTheme, child: ...)`.
5. Pertahankan `theme`, `darkTheme`, dan `themeMode` pada `MaterialApp` agar tema Flutter tetap sinkron.
**Larangan:**
- Jangan membungkus `MaterialApp` dengan `mui.Theme` tanpa menyesuaikan brightness dengan `ThemeMode` aktif.
- Jangan lupa mendaftarkan/menlepas `WidgetsBindingObserver`.
**Alasan:**
Commit `b55fc5d` menambahkan observer dan membangun `mui.ThemeData` berdasarkan brightness aktif, sehingga komponen `material_ui` (termasuk `adaptive_dialog`) mengikuti mode tema terang/gelap. Pola ini mencegah tampilan dialog yang tidak sesuai dengan tema aplikasi.
**Contoh benar:**
```dart
class _MyAppState extends ConsumerState<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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

  @override
  Widget build(BuildContext context) {
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
        themeMode: themeMode,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        darkTheme: ThemeData(
          colorScheme: .fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
        ),
        home: const Home(),
      ),
    );
  }
}
```
**Contoh salah:**
```dart
class _MyAppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: themeMode,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const Home(),
    ); // material_ui tidak mengikuti tema aktif
  }
}
```
**Sumber evaluasi:**
- Commit: `b55fc5da9382f50b5fb49d23309c85e345f0299b`
- File: `lib/app.dart`

## Pemilihan Tema pada `PengaturanScreen`
**Cakupan:**
- `lib/fitur/pengaturan/screens/pengaturan_screen.dart` — `_PengaturanScreenState._buildTema`, `_ubahTema`.
- `lib/fitur/tema/enum/tema_enum.dart` — `TemaEnum`, `TemaEnumExtension` (label, icon).
**Aturan wajib:**
1. Gunakan `PopupMenuButton<TemaEnum>` dengan `initialValue` dari state tema saat ini untuk memilih tema.
2. Baca `temaProvider` dengan `ref.watch` dan periksa `.isLoading`/`.hasError` sebelum `.requireValue`, sesuai aturan AsyncValue.
3. Tampilkan ikon dan label pada setiap `PopupMenuItem` serta pada tombol pemilih.
4. Panggil `ref.read(temaProvider.notifier).set(tema)` melalui metode async terpisah (`_ubahTema`) yang dibungkus `try/catch`, dicatat dengan `L.e`, dan dijalankan dengan `unawaited`.
5. Gunakan `MainAxisAlignment.spaceBetween` pada baris label dan pemilih agar tata letak rapi.
**Larangan:**
- Jangan memanggil `set` langsung di `onSelected` tanpa penanganan error.
- Jangan membaca `temaProvider` dengan `.value`/`.valueOrNull`.
**Alasan:**
Commit `682d50e` menambahkan `PengaturanScreen` dengan pemilihan tema via `PopupMenuButton`, menambahkan getter `icon` pada `TemaEnumExtension`, dan navigasi dari `LainnyaScreen`. Pola ini menjaga konsistensi penanganan AsyncValue dan error pada aksi ubah tema.
**Contoh benar:**
```dart
Widget _buildTema() {
  final temaAsync = ref.watch(temaProvider);
  if (temaAsync.isLoading) return const SizedBox.shrink();
  if (temaAsync.hasError) return const SizedBox.shrink();
  final temaSaatIni = temaAsync.requireValue;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Tema', style: Theme.of(context).textTheme.bodyMedium),
      PopupMenuButton<TemaEnum>(
        initialValue: temaSaatIni,
        onSelected: (tema) => unawaited(_ubahTema(tema)),
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

Future<void> _ubahTema(TemaEnum tema) async {
  try {
    await ref.read(temaProvider.notifier).set(tema);
  } on Exception catch (e, s) {
    L.e('Gagal mengubah tema: $e $s');
  }
}
```
**Contoh salah:**
```dart
Widget _buildTema() {
  final temaSaatIni =
      ref.watch(temaProvider).asData?.value ?? TemaEnum.sistem; // tanpa status check
  return Row(
    children: [
      PopupMenuButton<TemaEnum>(
        onSelected: (tema) {
          unawaited(ref.read(temaProvider.notifier).set(tema)); // tanpa try/catch
        },
        // ...
      ),
    ],
  );
}
```
**Sumber evaluasi:**
- Commit: `682d50ef3c412feaac27f2bba37de4148b2ef8f5`
- File: `lib/fitur/pengaturan/screens/pengaturan_screen.dart`, `lib/fitur/tema/enum/tema_enum.dart`, `lib/lainnya_screen.dart`

## Validasi Form Mengembalikan `String?`

**Tujuan:**
Memastikan validator input form mengembalikan nilai yang sesuai dengan kontrak `FormFieldValidator` (`String?`).

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
Commit `f596872` memperbaiki validator dari `() {}` (void) menjadi `{ return null; }` (String?). Pola ini mencegah type mismatch pada `InputTeks`/`FormField`.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Validator form harus mengembalikan `String?` sesuai kontrak `FormFieldValidator`; null berarti valid.

## Penggunaan Paket Lokal `share_global_saya`

**Tujuan:**
Memastikan widget dan helper reusable dari paket lokal `share_global_saya` digunakan secara konsisten.

**Aturan:**
1. Impor `package:share_global_saya/core_shared.dart` untuk mengakses `InputTeks`, `Nav`, `SharedKeys`-serupa, dan helper lainnya.
2. Gunakan widget reusable dari `core_shared` alih-alih membuat ulang.
3. Dependensi dideklarasikan sebagai path dependency: `share_global_saya: path: ../share_global_saya`.

**Contoh benar:**
```dart
import 'package:share_global_saya/core_shared.dart';
```

**Contoh salah:**
```dart
// Membuat InputTeks sendiri padahal sudah tersedia di core_shared.
```

**Alasan:**
Commit `e451a54` menambahkan layar biodata yang menggunakan `InputTeks` dari `share_global_saya`; commit `f596872` menambahkan impor `core_shared`. Pola ini menjaga konsistensi dengan shared library.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Manfaatkan widget dan helper reusable dari paket shared yang tersedia sebelum membuat implementasi sendiri.

## Persistensi Biodata via sqflite pada `BiodataNotifier`

**Tujuan:**
Menstandarkan cara memuat dan menyimpan data biodata ke SQLite agar konsisten dengan pola notifier asynchronous proyek.

**Cakupan:**
- `lib/fitur/biodata/notifier/biodata_notifier.dart` — `BiodataNotifier.build`, `_ambilData`, dan `simpan`.
- `lib/shared/db/sqflite/sqflite_op.dart` — `SqfliteOp` (operasi CRUD generik).
- `lib/shared/konstanta/nama_tabel.dart` — `NamaTabel`.
- `lib/shared/konstanta/nama_kolom.dart` — `NamaKolom`.
- `lib/fitur/biodata/model/biodata_model.dart` — `BiodataModel` (termasuk `fromSqflite` dan `toSqflite`).

**Aturan:**
1. `BiodataNotifier` menggunakan `AsyncNotifier<BiodataModel?>` dengan `build()` mengembalikan `Future<BiodataModel?>`.
2. Pemuatan data dilakukan melalui `SqfliteOp` (`const SqfliteOp().ambilSatu(NamaTabel.biodata)`), bukan pemanggilan `AppDatabase.database` langsung di notifier. Jika hasilnya `null`, kembalikan `null`.
3. Parsing nilai `dynamic` dari baris database wajib dilakukan di dalam model melalui factory `BiodataModel.fromSqflite(row)`, dengan `ParserUtil` (`parseString`, `parseDateTime`, `parseIntOrNull`, `parseDoubleOrNull`), bukan cast langsung atau parsing manual di notifier.
4. Konversi tanggal dari UTC (string ISO8601 di database) ke waktu lokal menggunakan `.toLocal()` setelah parsing (di dalam `fromSqflite`).
5. Serialisasi model ke Map untuk penyimpanan wajib dilakukan melalui metode `toSqflite()`, yang menggunakan konstanta `NamaKolom` dan konversi tanggal ke UTC ISO8601 string.
6. Nama tabel dan nama kolom wajib menggunakan konstanta `NamaTabel` dan `NamaKolom`, bukan string literal di notifier maupun model.
7. Penyimpanan menggunakan `SqfliteOp.tambah(..., conflictAlgorithm: ConflictAlgorithm.replace)` untuk upsert berdasarkan primary key.
8. Tanggal disimpan sebagai UTC ISO8601 string (`tanggal?.toUtc().toIso8601String()`).
9. Perbarui `state` menjadi `AsyncValue.data(biodata)` hanya setelah operasi database berhasil.
10. Bungkus operasi database dengan `try/catch`, catat error menggunakan `L.e`, dan teruskan menggunakan `rethrow`.
11. Catat keberhasilan penyimpanan menggunakan `L.s`.
12. Saat menyimpan, ambil data tersimpan melalui `final existing = await future;` sebelum operasi database; pertahankan ID yang sudah ada bila tersedia (`existing?.id`); buat ID baru dengan `const Uuid().v4()` hanya jika `existing?.id` null dan `biodata.id` kosong. Jangan selalu membuat ID baru pada setiap simpan.
13. Setelah simpan berhasil dan sebelum navigasi kembali, periksa `Navigator.of(context).canPop()`; panggil `Nav.pop(context)` hanya jika dapat pop. Jangan memanggil `Nav.pop` tanpa guard ketika halaman mungkin menjadi root (misalnya setelah routing berbasis biodata).

**Contoh benar:**
```dart
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
    try {
      final existing = await future;
      final model = biodata.id.isEmpty
          ? biodata.copyWith(id: existing?.id ?? const Uuid().v4())
          : biodata;
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

**Contoh salah:**
```dart
@riverpod
class BiodataNotifier extends _$BiodataNotifier {
  @override
  String build() {
    return '';
  }

  Future<void> simpan(BiodataModel biodata) async {
    final db = await AppDatabase.database;
    await db.insert('biodata', <String, Object?>{
      'tanggal_lahir': biodata.tanggalLahir?.toIso8601String(), // tanpa UTC
    });
    state = AsyncValue.data(biodata); // state diperbarui tanpa jaminan DB sukses
  }
}
```

**Alasan:**
Commit `398993d` mengonversi `BiodataNotifier` dari placeholder `String` menjadi `AsyncNotifier<BiodataModel?>` dengan persistensi sqflite. Pola ini memastikan data biodata persisten antar sesi, aman terhadap nilai null, dan konsisten dengan aturan penanganan error serta penyimpanan waktu UTC.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Prinsip umum (AsyncNotifier, UTC storage, ParserUtil, try/catch, rethrow) sudah tercakup pada aturan bersama yang ada; detail implementasi (SqfliteOp, ConflictAlgorithm.replace, NamaTabel/NamaKolom, fromSqflite/toSqflite, skema tabel biodata) bersifat khusus proyek.

## Penggunaan `SqfliteOp` untuk Operasi CRUD Generik

**Tujuan:**
Menstandarkan operasi database SQLite agar notifier dan service tidak memanggil `AppDatabase.database` secara langsung untuk CRUD umum.

**Cakupan:**
- `lib/shared/db/sqflite/sqflite_op.dart` — kelas `SqfliteOp`.
- `lib/shared/db/sqflite/sqflite.dart` — `AppDatabase.database` (akses dasar, tetap tersedia untuk kasus khusus).

**Aturan:**
1. Untuk operasi tambah, baca, ubah, hapus, dan hitung pada tabel, gunakan `SqfliteOp` (`const SqfliteOp()`) alih-alih memanggil `db.insert/query/update/delete/rawQuery` langsung.
2. Gunakan metode yang sesuai: `tambah`, `ambilSemua`, `ambil`, `ambilSatu`, `ubah`, `hapus`, `hitung`.
3. Transaksi multi-operasi wajib menggunakan `SqfliteOp.transaksi(...)` agar commit/rollback terpusat.
4. Batch multi-operasi wajib menggunakan `SqfliteOp.batch(...)`.
5. SQL mentah (SELECT) gunakan `SqfliteOp.queryRaw(...)` dan (INSERT/UPDATE/DELETE) gunakan `SqfliteOp.executeRaw(...)`.
6. Operasi database tetap dibungkus `try/catch`, catat error dengan `L.e`, dan teruskan dengan `rethrow` (sudah dilakukan di dalam `SqfliteOp`).
7. Keberhasilan operasi dicatat dengan `L.s`/`L.i` di dalam `SqfliteOp`; jangan mencatat ulang di notifier untuk operasi yang sama.
8. Jangan memanggil `AppDatabase.database` langsung di notifier/fitur apabila `SqfliteOp` sudah dapat menangani kebutuhan tersebut.

**Larangan:**
- Jangan menduplikasi logika CRUD di banyak notifier; gunakan `SqfliteOp`.
- Jangan melakukan interpolasi nama tabel/kolom dinamis dari input pengguna ke SQL (tetap gunakan konstanta `NamaTabel`/`NamaKolom` dan parameter binding untuk nilai).

**Alasan:**
Commit `1bb1c7b` menambahkan `SqfliteOp` sebagai lapisan CRUD generik, dan commit `01e6f20` memigrasikan `BiodataNotifier` untuk menggunakan `SqfliteOp` alih-alih akses database langsung. Pola ini menjaga konsistensi penanganan error, logging, dan parameter binding di seluruh fitur.

**Sumber evaluasi:**
Commit: `1bb1c7bf8d1cbdd9aab17aae153893714655ae4f`, `01e6f20a0442e809a6c936391b2fa9fd37ceda6d`
File: `lib/shared/db/sqflite/sqflite_op.dart`, `lib/fitur/biodata/notifier/biodata_notifier.dart`

## Konstanta Skema Database (`NamaTabel` dan `NamaKolom`)

**Tujuan:**
Menghindari string literal nama tabel dan kolom yang tersebar di kode database.

**Cakupan:**
- `lib/shared/konstanta/nama_tabel.dart` — `NamaTabel`.
- `lib/shared/konstanta/nama_kolom.dart` — `NamaKolom`.
- `lib/shared/db/sqflite/sqflite.dart` — `_buatTabel` (DDL).
- `lib/fitur/biodata/model/biodata_model.dart` — `fromSqflite`/`toSqflite`.

**Aturan:**
1. Setiap nama tabel wajib didefinisikan sebagai konstanta `static const String` dalam kelas `NamaTabel` dengan konstruktor privat.
2. Setiap nama kolom wajib didefinisikan sebagai konstanta `static const String` dalam kelas `NamaKolom` dengan konstruktor privat.
3. Gunakan konstanta tersebut pada DDL pembuatan tabel, query `SqfliteOp`, dan serialisasi model (`fromSqflite`/`toSqflite`).
4. Jangan menulis string nama tabel/kolom langsung di notifier, model, atau DDL.

**Alasan:**
Commit `01e6f20` memperkenalkan `NamaTabel` dan `NamaKolom` serta memigrasikan DDL dan `BiodataModel` untuk menggunakan konstanta tersebut. Sentralisasi ini mencegah typo nama kolom dan memudahkan refactoring skema.

**Sumber evaluasi:**
Commit: `01e6f20a0442e809a6c936391b2fa9fd37ceda6d`
File: `lib/shared/konstanta/nama_tabel.dart`, `lib/shared/konstanta/nama_kolom.dart`, `lib/shared/db/sqflite/sqflite.dart`, `lib/fitur/biodata/model/biodata_model.dart`

## Inisialisasi Database sqflite pada Platform Web di `main.dart`

**Cakupan:**
- `lib/main.dart` — `main()`.
- `lib/shared/db/sqflite/sqflite.dart` — `AppDatabase.database`.

**Aturan wajib:**
1. `main()` wajib asynchronous (`Future<void> main() async`) dan memanggil `WidgetsFlutterBinding.ensureInitialized()` sebelum mengakses database atau platform channel.
2. Pada platform web (`kIsWeb`), atur `databaseFactory = databaseFactoryFfiWeb` sebelum membuka database.
3. Buka `AppDatabase.database` sebelum `runApp` untuk memastikan skema siap; bungkus dengan `try/catch`, catat kegagalan dengan logger (`p`), dan `rethrow` agar kegagalan tidak diabaikan.
4. Jangan memanggil `runApp` sebelum inisialisasi database selesai pada jalur yang membutuhkannya.

**Larangan:**
- Jangan mengatur `databaseFactory` FFI web setelah database dibuka.
- Jangan mengabaikan exception inisialisasi database.

**Alasan:**
Commit `69715cd` mengaktifkan dukungan SQLite web dengan inisialisasi `databaseFactoryFfiWeb` di `main.dart` dan pre-open database sebelum `runApp`, agar routing berbasis `biodataProvider` dapat membaca data dengan aman.

**Contoh benar:**
```dart
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
  runApp(const ProviderScope(child: App()));
}
```

**Contoh salah:**
```dart
void main() {
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  runApp(const ProviderScope(child: App())); // DB belum dibuka
}
```

**Sumber evaluasi:**
Commit: `69715cd3b115a6ad9233e77881fe91f272b59dc1`
File: `lib/main.dart`

## Routing Awal Aplikasi Berdasarkan State Biodata pada `App`

**Cakupan:**
- `lib/app.dart` — `_MyAppState.build`.
- `lib/fitur/biodata/notifier/biodata_notifier.dart` — `biodataProvider`.
- `lib/fitur/biodata/screens/form_biodata.dart` — `FormBiodata`.

**Aturan wajib:**
1. `App` me-`watch` `biodataProvider` dan menentukan halaman awal: tampilkan loading saat `isLoading`, pesan error dengan tombol "Coba lagi" saat `hasError`, `FormBiodata` jika biodata `null`, dan `Home` jika biodata tersedia.
2. Gunakan `biodataAsync.asData?.value` (bukan `.value`) untuk membaca nilai aman.
3. Tombol retry memanggil `ref.refresh(biodataProvider)`.
4. Bungkus halaman awal dengan `PengelolaOverlayLogDebug` (atau pembungkus overlay log debug proyek) agar overlay debug tetap tersedia.

**Larangan:**
- Jangan langsung menampilkan `Home` tanpa memeriksa state biodata.
- Jangan mengabaikan status loading/error pada `biodataProvider` di root.

**Alasan:**
Commit `69715cd` mengubah `MaterialApp.home` dari `const Home()` menjadi halaman yang dipilih berdasarkan `biodataProvider`, sehingga pengguna baru diarahkan ke `FormBiodata` sebelum masuk aplikasi.

**Contoh benar:**
```dart
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
  home = biodata == null ? const FormBiodata() : const Home();
}
MaterialApp(
  home: PengelolaOverlayLogDebug(child: home),
);
```

**Contoh salah:**
```dart
MaterialApp(
  home: const Home(), // mengabaikan biodata dan form awal
);
```

**Sumber evaluasi:**
Commit: `69715cd3b115a6ad9233e77881fe91f272b59dc1`
File: `lib/app.dart`

## Pengisian Form Biodata via Listener Manual dan Alur Simpan Awal vs Edit

**Cakupan:**
- `lib/fitur/biodata/screens/form_biodata.dart` — `_BiodataScreenState`, khususnya `initState`, `dispose`, dan `_simpan`.
- `lib/fitur/biodata/notifier/biodata_notifier.dart` — `biodataProvider`.

**Aturan wajib:**

1. Pengisian controller form dari data async wajib dilakukan melalui `ref.listenManual` di `initState`, bukan melalui `whenData`/`when` di dalam `build()`.
2. Simpan `ProviderSubscription` yang dikembalikan `ref.listenManual` ke field state, lalu panggil `close()` pada `dispose()` agar subscription tidak bocor.
3. Gunakan flag `_sudahDiisi` (atau sejenis) agar pengisian controller hanya terjadi sekali, meskipun listener menerima pembaruan berikutnya.
4. Periksa `mounted` di dalam callback listener sebelum memutasi state/controller.
5. FormBiodata menerima parameter `buatPertama` (wajib) untuk membedakan alur:
   - `buatPertama == true` (pengguna baru, biodata belum ada): setelah simpan berhasil, navigasi dengan `Nav.pushAndRemoveUntil(context, const Home())` agar FormBiodata tidak dapat dikembalikan.
   - `buatPertama == false` (edit biodata): setelah simpan berhasil, gunakan guard `Navigator.of(context).canPop()` lalu `Nav.pop(context)` bila dapat pop.
6. Pada callback aksi (`_simpan`), baca nilai provider dengan `ref.read(biodataProvider).asData?.value` (bukan `ref.watch`), sesuai aturan AsyncValue.
7. Saat menyimpan, gunakan ID yang sudah ada bila data tersimpan (`existing?.id`); buat ID baru dengan `const Uuid().v4()` hanya untuk data baru.
8. Bungkus operasi simpan dengan `try/catch`, catat error dengan `L.e`, tampilkan feedback dengan `AppToast.gagal`, dan sembunyikan overlay EasyLoading di `finally`.

**Larangan:**

- Jangan memanggil `biodataAsync.whenData(...)` di dalam `build()` untuk mengisi controller (side effect di build).
- Jangan membiarkan `ProviderSubscription` dari `ref.listenManual` tidak ditutup di `dispose()`.
- Jangan memanggil `Nav.pop(context)` tanpa guard `canPop()` pada alur edit, karena halaman bisa menjadi root.
- Jangan memanggil `Nav.pushAndRemoveUntil` pada alur edit, dan jangan memanggil `Nav.pop` pada alur simpan awal.

**Alasan:**

Sebelumnya form diisi melalui `biodataAsync.whenData(...)` di dalam `build()`, yang merupakan side effect di build dan dapat menyebabkan loop rebuild serta inkonsistensi state. Perubahan memindahkan pengisian ke `ref.listenManual` di `initState` dengan flag `_sudahDiisi` dan pengecekan `mounted`, serta menyimpan subscription untuk ditutup di `dispose()`. Alur navigasi pasca-simpan juga dibedakan: simpan awal mengarahkan ke `Home` dengan `pushAndRemoveUntil`, sedangkan edit kembali dengan `Nav.pop` yang di-guard `canPop()`.

**Dampak apabila dilanggar:**

- Side effect di `build()` menyebabkan loop rebuild dan controller tertimpa berulang.
- Subscription yang tidak ditutup menyebabkan memory leak dan callback aktif setelah halaman ditutup.
- Navigasi yang salah (pop pada root atau kembali ke form awal) merusak alur onboarding.

**Rujukan implementasi:**

- `lib/fitur/biodata/screens/form_biodata.dart` — `_BiodataScreenState.initState`, `dispose`, `_simpan`, parameter `buatPertama`.
- `.agents/rules/global/optimasi_bug_runtime.md` §4 (mounted) dan §6 (try/catch).
- `.agents/rules/global/optimasi_ux.md` §5 (status operasi) dan §12 (loading).

**Contoh benar:**

```dart
class FormBiodata extends ConsumerStatefulWidget {
  final bool buatPertama;
  const FormBiodata({super.key, required this.buatPertama});
  // ...
}

class _BiodataScreenState extends ConsumerState<FormBiodata> {
  bool _sudahDiisi = false;
  ProviderSubscription<AsyncValue<BiodataModel?>>? _biodataSubscription;

  @override
  void initState() {
    super.initState();
    _biodataSubscription = ref.listenManual(biodataProvider, (previous, next) {
      next.whenData((biodata) {
        if (biodata != null && !_sudahDiisi && mounted) {
          _sudahDiisi = true;
          _namaController.text = biodata.nama;
        }
      });
    });
  }

  @override
  void dispose() {
    _biodataSubscription?.close();
    _namaController.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    // ... guard, konfirmasi, EasyLoading.show ...
    await ref.read(biodataProvider.notifier).simpan(model);
    if (!mounted) return;
    if (widget.buatPertama) {
      unawaited(Nav.pushAndRemoveUntil(context, const Home()));
    } else if (Navigator.of(context).canPop()) {
      Nav.pop(context);
    }
  }
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

**Sumber evaluasi:**
Commit: `791e578a7d4fb4d436908afb06423ed930915ca9`
File: `lib/fitur/biodata/screens/form_biodata.dart`

## Migrasi Skema SQLite saat Penambahan Tabel atau Kolom

**Cakupan:**
- `lib/shared/db/sqflite/sqflite.dart` — `AppDatabase` (`_versiDatabase`, `_buatTabel`, `_onUpgrade`).
- `lib/shared/konstanta/nama_tabel.dart` — `NamaTabel`.
- `lib/shared/konstanta/nama_kolom.dart` — `NamaKolom`.

**Aturan wajib:**
1. Setiap penambahan tabel atau kolom baru wajib menaikkan nilai `_versiDatabase`.
2. Registrasi callback `onUpgrade: _onUpgrade` pada `openDatabase` wajib ada agar skema lama dapat dimigrasikan.
3. Pada `_onUpgrade`, gunakan guard versi (`if (oldVersion < N)`) untuk setiap perubahan skema, sehingga migrasi dapat berjalan bertahap dan aman.
4. Tabel baru pada `_buatTabel` (untuk database baru) wajib juga dibuat pada `_onUpgrade` (untuk database lama) agar skema konsisten antara instalasi baru dan lama.
5. Gunakan `CREATE TABLE IF NOT EXISTS` pada `_onUpgrade` untuk mencegah error apabila tabel sudah ada.
6. Nama tabel dan kolom baru wajib menggunakan konstanta `NamaTabel`/`NamaKolom`, bukan string literal.
7. Jangan mengandalkan `onCreate` saja untuk database yang sudah terpasang di perangkat pengguna.

**Larangan:**
- Jangan menambah tabel/kolom tanpa menaikkan versi database.
- Jangan menghapus callback `onUpgrade` dari `openDatabase`.
- Jangan melakukan migrasi destruktif (drop tabel) tanpa alasan dan penanganan data yang jelas.
- Jangan menulis DDL migrasi dengan string literal nama tabel/kolom.

**Alasan:**
Commit `822e2f9` menambah tabel `impian` dengan menaikkan `_versiDatabase` dari 1 ke 2, menambahkan `_onUpgrade` dengan guard `if (oldVersion < 2)`, serta memastikan `_buatTabel` dan `_onUpgrade` sama-sama membuat tabel `impian`. Pola ini menjaga konsistensi skema antara instalasi baru dan perangkat yang sudah memiliki database versi lama.

**Contoh benar:**
```dart
static const int _versiDatabase = 2;

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

static Future<void> _onUpgrade(
  Database db,
  int oldVersion,
  int newVersion,
) async {
  if (oldVersion < 2) {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${NamaTabel.impian}(
        ${NamaKolom.id} TEXT PRIMARY KEY,
        ${NamaKolom.nama} TEXT NOT NULL
      )
    ''');
  }
}
```

**Contoh salah:**
```dart
static const int _versiDatabase = 1; // tidak dinaikkan
// Hanya menambah tabel pada _buatTabel, tanpa onUpgrade.
// Database lama di perangkat pengguna tidak akan memiliki tabel baru.
```

**Sumber evaluasi:**
Commit: `822e2f94b3bdc7c2a460c01b48c3902a96fa0bf9`
File: `lib/shared/db/sqflite/sqflite.dart`

## Batch Operations pada Notifier (CRUD Massal)

**Tujuan:**
Menstandarkan operasi CRUD massal (tambah, ubah, hapus banyak) pada notifier agar konsisten dengan pola optimistic update dan penanganan error proyek.

**Cakupan:**
- `lib/fitur/impian/notifier/impian_notifier.dart` — `tambahBanyak`, `ubahBanyak`, `hapusBanyak`.
- Notifier lain yang memerlukan operasi CRUD massal.

**Aturan:**
1. Operasi CRUD massal wajib menggunakan `SqfliteOp.batch(...)` agar seluruh perubahan berada dalam satu batch yang efisien.
2. Gunakan `batch.insert` dengan `conflictAlgorithm: ConflictAlgorithm.replace` untuk operasi tambah massal (upsert).
3. Gunakan `batch.update` dengan `where` dan `whereArgs` untuk operasi ubah massal, serta `conflictAlgorithm: ConflictAlgorithm.replace` apabila diperlukan.
4. Gunakan `batch.delete` dengan `where` dan `whereArgs` untuk operasi hapus massal.
5. Setelah operasi database berhasil, perbarui `state` secara optimistic dengan menggabungkan data lama dan data baru (tambah), memetakan pengganti (ubah), atau menyaring data yang dihapus (hapus).
6. Gunakan `firstWhereOrNull` dari `package:collection` untuk mencari item pengganti pada operasi ubah massal, bukan loop manual.
7. Bungkus seluruh operasi dengan `try/catch`, catat error dengan `L.e`, dan teruskan dengan `rethrow`.
8. Catat keberhasilan operasi dengan `L.s`.
9. Ambil data lama melalui `await future` sebelum blok `try`, agar data yang digunakan untuk pembaruan state adalah data terbaru yang sudah resolved (bukan `state.asData?.value` yang berpotensi stale/null).

**Larangan:**
- Jangan menggunakan loop `for` dengan `await` per item untuk operasi massal; gunakan `batch` untuk efisiensi.
- Jangan memperbarui state sebelum operasi database berhasil.
- Jangan menggunakan `batch.insert` untuk operasi ubah massal; gunakan `batch.update` dengan `where`/`whereArgs`.
- Jangan menggunakan loop manual untuk mencari item pengganti; gunakan `firstWhereOrNull`.
- Jangan membaca data lama melalui `state.asData?.value` di dalam blok `try` setelah operasi database; ambil sebelumnya via `await future`.

**Alasan:**
Commit `bc75a4a` memperbaiki `tambahBanyak` dari `batch.insert` menjadi `batch.update` (karena data sudah ada dan perlu di-upsert), serta menambahkan `hapusBanyak` dan `ubahBanyak` yang menggunakan `batch.delete` dan `batch.update`. Commit `56d2ad1` kemudian memindahkan pengambilan `dataLama` dari `state.asData?.value` (di dalam `try`) ke `await future` (sebelum `try`), agar data yang dipakai untuk optimistic update selalu data terbaru yang sudah resolved dan tidak stale. Pola ini menjaga konsistensi operasi massal dan efisiensi database.

**Contoh benar:**
```dart
/// Menambahkan banyak impian sekaligus menggunakan operasi batch (upsert).
Future<void> tambahBanyak(List<ImpianModel> daftarImpian) async {
  final dataLama = await future;
  try {
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
    state = AsyncValue.data([...dataLama, ...daftarImpian]);
    L.s('Impian berhasil disimpan (batch)');
  } on Exception catch (e, s) {
    L.e('Gagal menyimpan impian (batch): $e $s');
    rethrow;
  }
}

/// Mengubah banyak impian sekaligus.
Future<void> ubahBanyak(List<ImpianModel> daftarImpian) async {
  final dataLama = await future;
  try {
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
    state = AsyncValue.data(
      dataLama.map((e) {
        final pengganti = daftarImpian.firstWhereOrNull(
          (item) => item.id == e.id,
        );
        return pengganti ?? e;
      }).toList(),
    );
    L.s('Impian berhasil diubah (batch)');
  } on Exception catch (e, s) {
    L.e('Gagal mengubah impian (batch): $e $s');
    rethrow;
  }
}

/// Menghapus banyak impian sekaligus.
Future<void> hapusBanyak(List<String> daftarId) async {
  final dataLama = await future;
  try {
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
    state = AsyncValue.data(
      dataLama.where((e) => !daftarId.contains(e.id)).toList(),
    );
    L.s('Impian berhasil dihapus (batch)');
  } on Exception catch (e, s) {
    L.e('Gagal menghapus impian (batch): $e $s');
    rethrow;
  }
}
```

**Contoh salah:**
```dart
// Menggunakan await per item (tidak efisien).
Future<void> tambahBanyak(List<ImpianModel> daftarImpian) async {
  for (final impian in daftarImpian) {
    await op.tambah(NamaTabel.impian, impian.toSqflite());
  }
  state = AsyncValue.data(daftarImpian); // state tidak menggabungkan data lama
}

// Loop manual untuk mencari pengganti (tidak konsisten).
for (final e in dataLama) {
  ImpianModel? pengganti;
  for (final item in daftarImpian) {
    if (item.id == e.id) {
      pengganti = item;
      break;
    }
  }
  result.add(pengganti ?? e);
}
```

**Sumber evaluasi:**
- Commit: `bc75a4a098ae904736d8ef79e5277a7f6fae45bc`
- File: `lib/fitur/impian/notifier/impian_notifier.dart`

## Sinkronkan State dari Future Sebelum Mutasi pada Notifier

**Tujuan:**
Memastikan metode mutasi pada `AsyncNotifier` menggunakan data state terbaru yang sudah resolved, bukan data stale yang mungkin didapat dari `state.asData?.value`.

**Cakupan:**
- `lib/fitur/impian/notifier/impian_notifier.dart` — `tambah`, `tambahBanyak`, `ubah`, `hapus`, `hapusBanyak`, `ubahBanyak`.
- `lib/fitur/biodata/notifier/biodata_notifier.dart` — `simpan`.
- Notifier lain yang melakukan mutasi state berbasis data lama.

**Aturan:**
1. Pada metode mutasi notifier async, ambil data lama melalui `final dataLama = await future;` (atau `final existing = await future;`) **sebelum** blok `try`.
2. Gunakan `dataLama`/`existing` tersebut untuk membangun state baru setelah operasi database berhasil.
3. Jangan membaca data lama melalui `state.asData?.value` atau `state.asData?.value ?? <Model>[]` di dalam blok `try` setelah operasi database.
4. Pada `simpan` biodata, pertahankan ID yang sudah ada di database bila tersedia (`existing?.id`); buat ID baru dengan `const Uuid().v4()` hanya jika `existing?.id` null dan `biodata.id` kosong.
5. Jika `biodata.id` sudah terisi, gunakan id tersebut apa adanya (jangan ditimpa).

**Larangan:**
- Jangan menggunakan `state.asData?.value` untuk mendapatkan data lama di metode mutasi, karena nilainya dapat stale atau null jika state belum resolved.
- Jangan mengambil data lama setelah operasi database berhasil.
- Jangan mengabaikan `existing?.id` yang sudah tersimpan hanya karena `biodata.id` kosong.

**Alasan:**
Sebelumnya metode mutasi membaca data lama via `state.asData?.value ?? <Model>[]` di dalam blok `try` setelah operasi database. Commit `56d2ad1` memindahkan pengambilan data lama ke `await future` sebelum blok `try`, agar data yang dipakai untuk optimistic update selalu data terbaru yang sudah resolved. Hal yang sama diterapkan pada `BiodataNotifier.simpan` dengan `final existing = await future;`, sehingga ID yang sudah tersimpan dipertahankan (`existing?.id`) alih-alih selalu membuat ID baru. Pola ini mencegah data stale dan kehilangan ID yang sudah ada.

**Contoh benar:**
```dart
Future<void> tambah(ImpianModel impian) async {
  final dataLama = await future;
  try {
    final op = const SqfliteOp();
    await op.tambah(
      NamaTabel.impian,
      impian.toSqflite(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    state = AsyncValue.data([...dataLama, impian]);
    L.s('Impian berhasil disimpan');
  } on Exception catch (e, s) {
    L.e('Gagal menyimpan impian: $e $s');
    rethrow;
  }
}

Future<void> simpan(BiodataModel biodata) async {
  try {
    final existing = await future;
    final model = biodata.id.isEmpty
        ? biodata.copyWith(id: existing?.id ?? const Uuid().v4())
        : biodata;
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
```

**Contoh salah:**
```dart
Future<void> tambah(ImpianModel impian) async {
  try {
    final op = const SqfliteOp();
    await op.tambah(NamaTabel.impian, impian.toSqflite());
    final dataLama = state.asData?.value ?? <ImpianModel>[]; // stale/null
    state = AsyncValue.data([...dataLama, impian]);
  } on Exception catch (e, s) {
    L.e('Gagal menyimpan impian: $e $s');
    rethrow;
  }
}

Future<void> simpan(BiodataModel biodata) async {
  try {
    final model = biodata.id.isEmpty
        ? biodata.copyWith(id: const Uuid().v4()) // selalu buat ID baru
        : biodata;
    final op = const SqfliteOp();
    await op.tambah(NamaTabel.biodata, model.toSqflite());
    state = AsyncValue.data(model);
  } on Exception catch (e, s) {
    L.e('Gagal menyimpan biodata: $e $s');
    rethrow;
  }
}
```

**Sumber evaluasi:**
- Commit: `56d2ad1ee82fdd78e24a2d88874bccdf014be843`
- File: `lib/fitur/impian/notifier/impian_notifier.dart`, `lib/fitur/biodata/notifier/biodata_notifier.dart`

## Segarkan Provider Setelah Operasi Dummy

**Tujuan:**
Memastikan layar yang bergantung pada data dummy memperbarui state setelah operasi insert/delete/reset, agar UI menampilkan data terbaru.

**Cakupan:**
- `lib/fitur/dummy/screens/dummy_screen.dart` — `_DummyScreenState._masukkanDummy`, `_hapusDummy`, `_reset`, `_refreshProvider`.
- `lib/fitur/dummy/helper/dummy_helper.dart` — `insert`, `delete`.

**Aturan:**
1. Setelah `DummyHelper.insert()`, `DummyHelper.delete()`, atau kombinasi reset berhasil, panggil `_refreshProvider()` (atau mekanisme refresh setara) yang me-refresh `impianProvider` dan `biodataProvider`.
2. Gunakan `ref.refresh(provider)` (bukan `ref.invalidate`) agar provider langsung dievaluasi ulang.
3. Bungkus operasi dummy dengan `try/catch`, catat error dengan `L.e`, tampilkan feedback dengan `AppToast`, dan sembunyikan overlay EasyLoading di `finally`.

**Larangan:**
- Jangan membiarkan UI menampilkan data lama setelah operasi dummy berhasil.
- Jangan menggunakan `ref.invalidate` untuk refresh setelah operasi dummy.

**Alasan:**
Commit `56d2ad1` menambahkan `_refreshProvider()` pada `DummyScreen` yang memanggil `ref.refresh(impianProvider)` dan `ref.refresh(biodataProvider)` setelah insert/delete/reset dummy, agar UI langsung memuat data dummy terbaru. Pola ini menjaga konsistensi tampilan setelah perubahan data massal.

**Contoh benar:**
```dart
Future<void> _refreshProvider() async {
  final _ = ref.refresh(impianProvider);
  final _ = ref.refresh(biodataProvider);
}

Future<void> _masukkanDummy(BuildContext context) async {
  unawaited(EasyLoading.show(status: 'Menyimpan...', maskType: EasyLoadingMaskType.black));
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
    if (context.mounted) {
      unawaited(EasyLoading.dismiss());
    }
  }
}
```

**Contoh salah:**
```dart
Future<void> _masukkanDummy(BuildContext context) async {
  await DummyHelper.insert();
  // Provider tidak direfresh -> UI menampilkan data lama.
  AppToast.sukses(context, 'Dummy berhasil dimasukkan');
}
```

**Sumber evaluasi:**
- Commit: `56d2ad1ee82fdd78e24a2d88874bccdf014be843`
- File: `lib/fitur/dummy/screens/dummy_screen.dart`

## Transaksi Multi-Tabel pada Helper

**Tujuan:**
Menstandarkan penggunaan transaksi SQLite untuk operasi yang melibatkan lebih dari satu tabel agar konsistensi data terjaga.

**Cakupan:**
- `lib/fitur/dummy/helper/dummy_helper.dart` — `insert()` dan `delete()`.
- Helper lain yang melakukan operasi multi-tabel.

**Aturan:**
1. Operasi yang melibatkan lebih dari satu tabel wajib menggunakan `SqfliteOp.transaksi(...)` agar seluruh perubahan berada dalam satu transaksi (commit/rollback terpusat).
2. Gunakan `txn.insert`, `txn.delete`, `txn.update` (bukan `batch`) di dalam callback transaksi, karena transaksi memerlukan await per operasi.
3. Jika salah satu operasi gagal, seluruh transaksi di-rollback otomatis oleh Sqflite.
4. Jangan menggunakan `batch` untuk operasi multi-tabel yang memerlukan konsistensi antar tabel; gunakan `transaksi`.
5. Gunakan `batch` hanya untuk operasi massal pada satu tabel yang tidak memerlukan konsistensi antar tabel.

**Larangan:**
- Jangan melakukan insert/delete ke beberapa tabel secara terpisah tanpa transaksi.
- Jangan mencampurkan `batch` dan `transaksi` untuk operasi yang sama.

**Alasan:**
Commit `bc75a4a` mengubah `DummyHelper.insert()` dan `delete()` dari `batch` ke `transaksi`, karena operasi tersebut melibatkan dua tabel (impian dan biodata) yang harus konsisten. Penggunaan `transaksi` memastikan jika insert ke tabel kedua gagal, insert ke tabel pertama di-rollback.

**Contoh benar:**
```dart
static Future<void> insert() async {
  final op = const SqfliteOp();
  await op.transaksi((txn) async {
    for (final impian in dummyImpian) {
      await txn.insert(
        NamaTabel.impian,
        impian.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    for (final biodata in dummyBiodata) {
      await txn.insert(
        NamaTabel.biodata,
        biodata.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  });
}
```

**Contoh salah:**
```dart
// Menggunakan batch untuk operasi multi-tabel (tidak menjamin konsistensi antar tabel).
static Future<void> insert() async {
  final op = const SqfliteOp();
  await op.batch((batch) {
    for (final impian in dummyImpian) {
      batch.insert(NamaTabel.impian, impian.toSqflite());
    }
    for (final biodata in dummyBiodata) {
      batch.insert(NamaTabel.biodata, biodata.toSqflite());
    }
  });
}
```

**Sumber evaluasi:**
- Commit: `bc75a4a098ae904736d8ef79e5277a7f6fae45bc`
- File: `lib/fitur/dummy/helper/dummy_helper.dart`

## Penambahan Tab Baru pada Navigasi Lazy (Home)

**Cakupan:**
- `lib/home.dart` — `_HomeState` (GlobalKey, `_scrollKeAtas`, `IndexedStack`, `NavigationDestination`).
- Tab aktual: Dashboard, Biodata, Lainnya (jumlah mengikuti tab yang terdaftar di `home.dart`).

**Aturan wajib:**
1. Saat menambah tab baru, tambahkan `GlobalKey` khusus untuk tab tersebut (mis. `_kunciBiodata`).
2. Tambahkan entri pada `switch (i)` di `_scrollKeAtas` agar state tab baru dapat diakses untuk scroll-to-top.
3. Tambahkan entri pada `switch (i)` di dalam `IndexedStack` (`List.generate(N, ...)`) untuk membangun widget tab baru secara lazy.
4. Tambahkan `NavigationDestination` baru pada `NavigationBar`/`BottomNavigationBar` dengan ikon dan label yang sesuai.
5. Sesuaikan jumlah `List.generate(N, ...)` dengan jumlah tab aktual.
6. Pertahankan pola lazy: tab baru hanya dibangun saat pertama kali dipilih, dan state tetap dipertahankan.

**Larangan:**
- Jangan menambah tab tanpa menambah `GlobalKey`-nya, karena fitur scroll-to-top akan kehilangan referensi state.
- Jangan membangun tab baru sekaligus sejak awal (melanggar lazy loading).
- Jangan mengubah jumlah `List.generate` tanpa menambahkan entri `switch` yang sesuai.

**Alasan:**
Commit `9dd29089` menambahkan tab Biodata pada `Home` dengan menambahkan `_kunciBiodata`, entri `switch` pada `_scrollKeAtas` dan `IndexedStack`, serta `NavigationDestination` baru. Pola ini konsisten dengan aturan navigasi tab utama yang sudah ada, dan menjaga lazy loading tetap berlaku meskipun tab bertambah.

**Dampak apabila dilanggar:**
- State tab baru tidak dapat diakses untuk scroll-to-top (crash/null).
- Tab baru dibangun sekaligus sejak awal (lag dan beban memori tinggi).
- Inkonsistensi antara jumlah tab, `GlobalKey`, dan entri `switch`.

**Rujukan implementasi:**
- `lib/home.dart` — commit `9dd29089` (penambahan tab Biodata).
- `.agents/rules/proyek/aturan_khusus.md` — aturan Navigasi Tab Utama (Home).

**Contoh benar:**
```dart
final GlobalKey _kunciBiodata = GlobalKey();

final state = switch (i) {
  0 => _kunciDashboard.currentState,
  1 => _kunciBiodata.currentState,
  _ => _kunciLainnya.currentState,
};

children: List<Widget>.generate(3, (i) {
  if (!_tabTerbuka.contains(i)) return const SizedBox.shrink();
  return switch (i) {
    0 => DashboardScreen(key: _kunciDashboard),
    1 => BiodataScreen(key: _kunciBiodata),
    _ => LainnyaScreen(key: _kunciLainnya),
  };
}),
```

**Contoh salah:**
```dart
// Tab baru ditambahkan tanpa GlobalKey dan tanpa entri switch.
children: List<Widget>.generate(3, (i) {
  if (!_tabTerbuka.contains(i)) return const SizedBox.shrink();
  return switch (i) {
    0 => DashboardScreen(key: _kunciDashboard),
    // entri Biodata hilang -> tab tidak dibangun
    _ => LainnyaScreen(key: _kunciLainnya),
  };
}),
```

**Sumber evaluasi:**
- Commit: `9dd290894c133aed166035542a972bf696b7fd79`
- File: `lib/home.dart`

## Data Dummy dengan Tanggal Dinamis

**Cakupan:**
- `lib/fitur/dummy/dummy_data/dummy_biodata.dart` — data dummy biodata.

**Aturan wajib:**
1. Data dummy yang memuat tanggal wajib menggunakan nilai relatif terhadap waktu sekarang (`DateTime.now().subtract(...)` / `DateTime.now().add(...)`), bukan tanggal statis (mis. `DateTime(1990, 5, 15)`).
2. Saat menambah field tanggal baru pada model (mis. `tanggalMulaiBerhentiMerokok`), tambahkan nilai dummy yang sesuai agar data dummy tetap lengkap dan konsisten.
3. Nilai relatif wajib realistis (mis. umur dalam tahun, durasi merokok dalam tahun, durasi berhenti dalam hari/bulan).

**Larangan:**
- Jangan menggunakan tanggal statis pada data dummy, karena seiring waktu data menjadi tidak realistis (mis. tanggal lahir tetap 1990).
- Jangan menambah field model baru tanpa menambahkan nilai dummy yang sesuai.

**Alasan:**
Commit `f9af412c` mengganti tanggal lahir dan mulai merokok dari nilai statis (`DateTime(1990, 5, 15)`, `DateTime(2010, 1, 1)`) ke nilai relatif terhadap waktu sekarang, serta menambahkan `tanggalMulaiBerhentiMerokok`. Pola ini menjaga data dummy tetap realistis sepanjang waktu dan konsisten dengan skema model terbaru.

**Dampak apabila dilanggar:**
- Data dummy menjadi tidak realistis seiring waktu (mis. umur pengguna dummy tidak berubah).
- Data dummy tidak lengkap (field baru bernilai null) sehingga tampilan fitur tidak dapat diuji dengan baik.

**Rujukan implementasi:**
- `lib/fitur/dummy/dummy_data/dummy_biodata.dart` — commit `f9af412c`.

**Contoh benar:**
```dart
BiodataModel(
  id: BiodataIdDummy.item1,
  nama: 'Budi Santoso',
  tanggalLahir: DateTime.now().subtract(const Duration(days: 365 * 36)),
  tanggalMulaiMerokok: DateTime.now().subtract(
    const Duration(days: 365 * 16),
  ),
  tanggalMulaiBerhentiMerokok: DateTime.now().subtract(
    const Duration(days: 30),
  ),
)
```

**Contoh salah:**
```dart
BiodataModel(
  id: BiodataIdDummy.item1,
  nama: 'Budi Santoso',
  tanggalLahir: DateTime(1990, 5, 15), // statis
  tanggalMulaiMerokok: DateTime(2010, 1, 1), // statis
  // tanggalMulaiBerhentiMerokok tidak diisi -> null
)
```

**Sumber evaluasi:**
- Commit: `f9af412cbd090ad4e6023298cc3b76ec42c80446`
- File: `lib/fitur/dummy/dummy_data/dummy_biodata.dart`

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Data dummy sebaiknya menggunakan nilai relatif terhadap waktu sekarang (bukan tanggal statis) agar tetap realistis sepanjang waktu; field baru pada model wajib diisi pada data dummy agar pengujian mencakup data lengkap.

## Penambahan Field Baru pada Model (Vertical Slice)

**Cakupan:**
- `lib/fitur/biodata/model/biodata_model.dart` — `BiodataModel` (Freezed).
- `lib/fitur/biodata/model/biodata_model.freezed.dart` — file generated.
- `lib/shared/konstanta/nama_kolom.dart` — `NamaKolom`.
- `lib/shared/db/sqflite/sqflite.dart` — `_buatTabel`, `_onUpgrade`, `_versiDatabase`.
- `lib/fitur/biodata/screens/form_biodata.dart` — `_BiodataScreenState`.
- `lib/fitur/biodata/screens/biodata_screen.dart` — `_BiodataScreenState`.
- `lib/fitur/dummy/dummy_data/dummy_biodata.dart` — data dummy.

**Aturan wajib:**
1. Tambahkan field baru pada model (Freezed) beserta pemetaan pada `fromSqflite` (parsing via `ParserUtil`, konversi UTC→lokal dengan `.toLocal()`) dan `toSqflite` (konversi lokal→UTC ISO8601 string).
2. Tambahkan konstanta kolom baru pada `NamaKolom` (atau konstanta skema yang relevan), jangan gunakan string literal.
3. Naikkan `_versiDatabase`, tambahkan kolom pada `CREATE TABLE` di `_buatTabel`, dan tambahkan migrasi pada `_onUpgrade` dengan guard `if (oldVersion < N)` (gunakan `ALTER TABLE ... ADD COLUMN` untuk kolom baru).
4. Tambahkan input pada form yang relevan: variabel state, pengisian dari data tersimpan (listener), pemilih (mis. date picker), dan penyertaan nilai pada model saat simpan.
5. Tambahkan tampilan field pada layar baca (display screen) yang relevan.
6. Tambahkan nilai dummy yang sesuai pada data dummy, menggunakan nilai relatif terhadap waktu sekarang untuk field tanggal.
7. Regenerasi file hasil generator (`.freezed.dart`, `.g.dart`) melalui generator; jangan edit manual.
8. Jika field baru memerlukan tab/navigasi baru, ikuti aturan "Penambahan Tab Baru pada Navigasi Lazy (Home)".

**Larangan:**
- Jangan menambah field pada model tanpa memperbarui parsing/serialisasi, konstanta kolom, migrasi DB, form, tampilan, dan dummy data.
- Jangan menaikkan versi database tanpa menambahkan migrasi yang sesuai.
- Jangan mengedit file `.freezed.dart`/`.g.dart` secara manual.
- Jangan menambah field model baru tanpa nilai dummy yang sesuai.

**Alasan:**
Commit `9dd29089` menambahkan field `tanggalMulaiBerhentiMerokok` pada `BiodataModel` dan memperbarui seluruh lapisan yang bergantung padanya: model (parsing/serialisasi), `NamaKolom`, skema database (versi 2→3 dengan `ALTER TABLE`), form (state, listener, date picker, simpan), tampilan (`BiodataScreen`), serta data dummy (commit `f9af412c`). Pola vertical slice ini memastikan tidak ada lapisan yang tertinggal saat field baru ditambahkan, yang dapat menyebabkan data tidak tersimpan, tidak tampil, atau migrasi gagal pada perangkat lama.

**Dampak apabila dilanggar:**
- Field baru tidak tersimpan/ditampilkan (data hilang atau null).
- Migrasi skema gagal pada perangkat dengan database lama.
- Dummy data tidak lengkap sehingga pengujian tidak mencakup field baru.
- File generated tidak sinkron dengan sumber, menyebabkan error kompilasi.

**Rujukan implementasi:**
- `lib/fitur/biodata/model/biodata_model.dart` — commit `9dd29089`.
- `lib/shared/konstanta/nama_kolom.dart` — commit `9dd29089`.
- `lib/shared/db/sqflite/sqflite.dart` — commit `9dd29089`.
- `lib/fitur/biodata/screens/form_biodata.dart` — commit `9dd29089`.
- `lib/fitur/biodata/screens/biodata_screen.dart` — commit `9dd29089`.
- `lib/fitur/dummy/dummy_data/dummy_biodata.dart` — commit `f9af412c`.

**Contoh benar:**
```dart
// 1. Model: tambah field + parsing + serialisasi.
@freezed
abstract class BiodataModel with _$BiodataModel {
  const factory BiodataModel({
    required String id,
    required String nama,
    DateTime? tanggalMulaiBerhentiMerokok,
  }) = _BiodataModel;

  factory BiodataModel.fromSqflite(Map<String, dynamic> row) => BiodataModel(
        id: ParserUtil.parseString(row[NamaKolom.id]),
        nama: ParserUtil.parseString(row[NamaKolom.nama]),
        tanggalMulaiBerhentiMerokok: ParserUtil.parseDateTime(
          row[NamaKolom.tanggalMulaiBerhentiMerokok],
        )?.toLocal(),
      );
}

Map<String, dynamic> toSqflite() => {
      NamaKolom.id: id,
      NamaKolom.nama: nama,
      NamaKolom.tanggalMulaiBerhentiMerokok:
          tanggalMulaiBerhentiMerokok?.toUtc().toIso8601String(),
    };
}

// 2. Konstanta kolom.
class NamaKolom {
  static const String tanggalMulaiBerhentiMerokok =
      'tanggal_mulai_berhenti_merokok';
}

// 3. Migrasi: naikkan versi + ALTER TABLE.
static const int _versiDatabase = 3;
// onCreate: ... ${NamaKolom.tanggalMulaiBerhentiMerokok} TEXT
// onUpgrade:
if (oldVersion < 3) {
  await db.execute(
    'ALTER TABLE ${NamaTabel.biodata} '
    'ADD COLUMN ${NamaKolom.tanggalMulaiBerhentiMerokok} TEXT',
  );
}
```

**Contoh salah:**
```dart
// Hanya menambah field pada model, tanpa memperbarui lapisan lain.
@freezed
abstract class BiodataModel with _$BiodataModel {
  const factory BiodataModel({
    required String id,
    required String nama,
    DateTime? tanggalMulaiBerhentiMerokok, // field baru
  }) = _BiodataModel;
}
// NamaKolom tidak ditambahkan -> parsing pakai string literal atau null.
// Versi database tidak dinaikkan -> perangkat lama tidak punya kolom.
// Form tidak menambah input -> field tidak dapat diisi.
// Dummy data tidak diisi -> field null pada pengujian.
```

**Sumber evaluasi:**
- Commit: `9dd290894c133aed166035542a972bf696b7fd79`
- Commit: `f9af412cbd090ad4e6023298cc3b76ec42c80446`
- File: `lib/fitur/biodata/model/biodata_model.dart`, `lib/shared/konstanta/nama_kolom.dart`, `lib/shared/db/sqflite/sqflite.dart`, `lib/fitur/biodata/screens/form_biodata.dart`, `lib/fitur/biodata/screens/biodata_screen.dart`, `lib/fitur/dummy/dummy_data/dummy_biodata.dart`

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Saat menambah field pada model, pastikan seluruh lapisan yang bergantung (parsing, serialisasi, konstanta skema, migrasi database, form, tampilan, dan data dummy) diperbarui secara konsisten agar tidak ada data yang hilang atau tidak tersimpan. Prinsip umum ini sudah tercakup pada aturan bersama yang ada (Serialisasi Model, Konstanta Skema, Migrasi Skema, Data Dummy Tanggal Relatif); detail checklist vertical slice bersifat khusus proyek.

## State Impian dengan Field Turunan (Freezed)

**Cakupan:**
- `lib/fitur/impian/state/impian_state.dart` — `ImpianState`.
- `lib/fitur/impian/notifier/impian_notifier.dart` — `ImpianNotifier` (build, tambah, ubah, hapus, batch).
- `lib/fitur/impian/screens/impian_screen.dart` — `_ImpianScreenState.build`.
- `lib/fitur/impian/notifier/impian_notifier.g.dart` — file generated.

**Aturan wajib:**
1. `ImpianState` (Freezed) memuat `listImpian`, `jumlahImpian`, dan `totalJumlah`.
2. `jumlahImpian` = jumlah item dalam `listImpian`; `totalJumlah` = agregasi `fold<double>` dari `element.jumlah` pada `listImpian`.
3. Setiap mutasi (tambah, ubah, hapus, batch) wajib membangun `ImpianState` baru dengan `listImpian` hasil mutasi dan `jumlahImpian`/`totalJumlah` yang dihitung ulang dari list tersebut.
4. Gunakan `fold<double>(0, (prev, e) => prev + e.jumlah)` untuk menghitung `totalJumlah`.
5. Gunakan `@Default([])` untuk `listImpian` dan `@Default(0)` untuk `jumlahImpian`/`totalJumlah`.
6. Screen wajib me-`watch` `impianProvider`, menangani `.isLoading`/`.hasError`/`.requireValue`, dan menyediakan tombol retry yang memanggil `ref.refresh(impianProvider)`.
7. Navigasi ke form wajib menggunakan `const FormImpian()`.

**Larangan:**
- Jangan membangun `ImpianState` baru tanpa menghitung ulang `jumlahImpian` dan `totalJumlah` dari `listImpian` hasil mutasi.
- Jangan menyimpan nilai turunan yang stale (tidak dihitung ulang) pada state.
- Jangan menghitung `jumlahImpian`/`totalJumlah` di UI; hitung di notifier.
- Jangan me-`watch` provider lama (`List<ImpianModel>`) setelah migrasi ke `ImpianState`.

**Alasan:**
Commit `4aaa5a3` memigrasikan state impian dari `List<ImpianModel>` ke `ImpianState` yang memuat `listImpian`, `jumlahImpian`, dan `totalJumlah`. Seluruh mutasi (tambah, ubah, hapus, batch) membangun `ImpianState` baru dengan agregat yang dihitung ulang via `fold<double>`, sehingga nilai turunan tidak stale. Screen juga diperbarui untuk menangani loading/error/retry sesuai pola AsyncValue.

**Dampak apabila dilanggar:**
- Nilai turunan (jumlah, total) stale setelah mutasi, menyebabkan tampilan tidak konsisten.
- Screen tidak menangani loading/error, sehingga pengguna tidak mendapat feedback saat gagal memuat.
- File generated (`.g.dart`) tidak sinkron dengan sumber, menyebabkan error kompilasi.

**Rujukan implementasi:**
- `lib/fitur/impian/state/impian_state.dart` — definisi Freezed.
- `lib/fitur/impian/notifier/impian_notifier.dart` — semua mutasi membangun `ImpianState` dengan agregat dihitung ulang.
- `lib/fitur/impian/screens/impian_screen.dart` — loading/error/retry + `const FormImpian()`.
- `lib/fitur/impian/notifier/impian_notifier.g.dart` — file generated.

**Contoh benar:**
```dart
state = AsyncValue.data(
  ImpianState(
    listImpian: [...dataLama.listImpian, impian],
    jumlahImpian: dataLama.jumlahImpian + 1,
    totalJumlah: dataLama.totalJumlah + impian.jumlah,
  ),
);
// Atau hitung ulang dari list hasil:
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
```

**Contoh salah:**
```dart
// State lama: hanya list, tanpa agregat.
state = AsyncValue.data([...dataLama, impian]);

// State baru tapi agregat tidak dihitung ulang (stale).
state = AsyncValue.data(
  ImpianState(
    listImpian: [...dataLama.listImpian, impian],
    jumlahImpian: dataLama.jumlahImpian, // stale
    totalJumlah: dataLama.totalJumlah,   // stale
  ),
);
```

**Sumber evaluasi:**
- Commit: `4aaa5a31f14c948e5b71281c20978139a52e1028`
- File: `lib/fitur/impian/state/impian_state.dart`, `lib/fitur/impian/notifier/impian_notifier.dart`, `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/impian/notifier/impian_notifier.g.dart`

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Ketika state menyimpan koleksi sekaligus nilai turunan (jumlah, total, agregat lainnya), setiap mutasi wajib membangun state baru dengan koleksi hasil mutasi dan nilai turunan yang dihitung ulang dari koleksi tersebut. Jangan menyimpan nilai turunan yang stale, dan jangan menghitung nilai turunan di UI (hitung di notifier). Prinsip ini dapat diterapkan pada seluruh proyek Flutter yang menggunakan immutable state (Freezed) dengan field turunan.

## Penanganan State Kosong (Empty State) pada Daftar Impian

**Cakupan:**
- `lib/fitur/impian/screens/impian_screen.dart` — `_ImpianScreenState.build`.
- `lib/fitur/impian/screens/form_impian.dart` — `FormImpian` (tujuan navigasi dari empty state).

**Aturan wajib:**
1. Jika daftar impian kosong (`listImpian.isEmpty`), tampilkan pesan state kosong yang jelas (mis. `'Belum ada impian'`) di tengah layar, dibungkus `Padding` dengan screen-edge padding yang konsisten (mis. `EdgeInsets.all(16)`).
2. Tetap sediakan `FloatingActionButton` dengan ikon tambah (`CupertinoIcons.add`) pada state kosong agar pengguna dapat menambah impian pertama.
3. Navigasi ke form wajib menggunakan `Nav.to(context, const FormImpian())`.
4. Pada state tidak kosong, gunakan `ListView.separated` dengan `separatorBuilder` berupa `SizedBox(height: 8)` (atau spacing konsisten) untuk menjaga jarak antar item.
5. Setiap item daftar wajib memiliki `Key` stabil (`ValueKey(item.id)`) agar posisi scroll dan identitas item tetap konsisten saat mutasi.
6. Pertahankan pola loading/error/retry (`isLoading` → `hasError` → `requireValue`) pada screen sebelum mengevaluasi empty state.

**Larangan:**
- Jangan menampilkan daftar kosong tanpa pesan atau tanpa aksi tambah.
- Jangan menghilangkan `FloatingActionButton` pada state kosong.
- Jangan menggunakan `ListView(children: ...)` untuk daftar yang berpotensi melebihi 20 item; gunakan `ListView.separated`/`ListView.builder`.
- Jangan membuat key baru setiap rebuild untuk item daftar.

**Alasan:**
Commit `f72bf35` mengimplementasikan daftar impian dengan state kosong: saat `listImpian` kosong, tampil pesan `'Belum ada impian'` di tengah layar dengan `Padding` screen-edge 16 dan `FloatingActionButton` tambah; saat tidak kosong, gunakan `ListView.separated` dengan separator `SizedBox(height: 8)` dan `Card` dengan `ValueKey(item.id)`. Pola ini menjaga konsistensi dengan aturan padding tepi layar, performa key stabil, dan UX kejelasan tampilan.

**Dampak apabila dilanggar:**
- Pengguna tidak mendapat feedback bahwa daftar kosong atau cara menambah data pertama.
- Posisi scroll dan identitas item tidak stabil saat mutasi.
- Daftar panjang tidak efisien (rebuild semua item sekaligus).

**Rujukan implementasi:**
- `lib/fitur/impian/screens/impian_screen.dart` — empty state + `ListView.separated` + `ValueKey`.
- `.agents/rules/global/optimasi_ux.md` §10 — padding tepi layar.
- `.agents/rules/global/optimasi_performa.md` §1 — Key stabil dan posisi scroll.

**Contoh benar:**
```dart
final List<ImpianModel> listImpian = impianState.listImpian;
if (listImpian.isEmpty) {
  return Scaffold(
    appBar: AppBar(title: const Text('Impian')),
    body: const Padding(
      padding: EdgeInsets.all(16),
      child: Center(child: Text('Belum ada impian')),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => unawaited(Nav.to(context, const FormImpian())),
      child: const Icon(CupertinoIcons.add),
    ),
  );
}
return Scaffold(
  appBar: AppBar(title: const Text('Impian')),
  body: Padding(
    padding: const EdgeInsets.all(16),
    child: ListView.separated(
      itemCount: listImpian.length,
      itemBuilder: (context, index) {
        final ImpianModel item = listImpian[index];
        return Card(
          key: ValueKey(item.id),
          child: ListTile(title: Text(item.nama)),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    ),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () => unawaited(Nav.to(context, const FormImpian())),
    child: const Icon(CupertinoIcons.add),
  ),
);
```

**Contoh salah:**
```dart
// Tidak ada pesan empty state dan tidak ada FAB.
return Scaffold(
  appBar: AppBar(title: const Text('Impian')),
  body: ListView(
    children: listImpian.map((e) => ListTile(title: Text(e.nama))).toList(),
  ),
);
```

**Sumber evaluasi:**
- Commit: `f72bf351dc279641ddacdddcb0f5a46fb7c5b4d5`
- File: `lib/fitur/impian/screens/impian_screen.dart`

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**
Saat daftar kosong, tampilkan pesan state kosong yang jelas di tengah layar dengan screen-edge padding dan sediakan aksi tambah (mis. FAB) agar pengguna dapat menambah data pertama. Gunakan `ListView.separated`/`ListView.builder` dengan `Key` stabil untuk daftar yang berpotensi panjang, dan pertahankan pola loading/error/retry sebelum mengevaluasi empty state. Prinsip ini dapat diterapkan pada seluruh proyek Flutter.
