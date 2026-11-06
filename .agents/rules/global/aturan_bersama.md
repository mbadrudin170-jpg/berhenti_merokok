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