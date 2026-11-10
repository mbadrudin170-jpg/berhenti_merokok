# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Final

**Status Implementasi:** Sedang Diimplementasikan

---

## 1. Informasi Produk

**Konteks penggunaan:**
Digunakan untuk mengidentifikasi produk dan memberikan gambaran umum proyek. Informasi ini menjadi identitas utama PRD.

**Informasi:**
- Nama aplikasi: Berhenti Merokok
- Deskripsi produk: Aplikasi Flutter pendamping proses berhenti merokok yang membantu pengguna mencatat data pribadi, memantau progres *smoke-free*, mencatat dorongan merokok, mengelola impian, serta mengakses dukungan cepat saat muncul keinginan untuk merokok. Pendekatan *offline-first* dengan penyimpanan lokal (SQLite dan preferensi lokal).
- Platform: Android (APK); kode proyek juga mendukung web/desktop secara teknis, tetapi target riset dan pengembangan adalah Android.
- Versi: 1.0.0+1
- Status pengembangan: Internal / pra-rilis (belum dipublikasikan)

## 2. Latar Belakang

**Isi:**
Aplikasi Berhenti Merokok sudah memiliki navigasi empat tab utama (Dashboard, Biodata, Impian, Lainnya) dan beberapa *empty state* pada layar daftar (Impian, Diary Craving, Alasan Berhenti, Konsumsi Rokok). Namun ada celah konsistensi:

- Halaman `Lainnya` menampilkan fitur sekunder sebagai daftar datar tanpa pengelompokan, padahal jumlah modul terus bertambah (Pengaturan, Dummy, SOS Craving, Pemulihan Kesehatan, Diary Craving, Alasan Berhenti, Kalender Smoke-Free, Konsumsi Rokok, Pelacakan Toxin).
- Beberapa layar belum memiliki *empty state* yang informatif atau CTA yang relevan, misalnya layar pemulihan kesehatan dan kalender *smoke-free* yang hanya menampilkan teks "Belum ada data biodata" tanpa tindakan berikutnya.
- Ada layar yang menyembunyikan konten kosong tanpa penjelasan (mis. kartu motivasi SOS Craving disembunyikan saat alasan kosong) atau menampilkan *empty state* tanpa CTA.
- Beberapa *empty state* sudah ada tetapi belum konsisten dalam pola (ikon, judul, deskripsi, CTA) dan belum memakai komponen bersama.

Masalah ini bertentangan dengan prinsip navigasi yang mudah dipelajari dan bertentangan dengan kebutuhan pengguna pemula yang butuh tahu "apa yang harus dilakukan selanjutnya" saat layar kosong.

## 3. Tujuan Produk

**Isi:**
- Menjaga navigasi utama tetap terbatas pada empat tab dan mudah dipelajari pengguna baru.
- Mengelompokkan fitur sekunder pada halaman `Lainnya` secara konsisten sehingga pengguna dapat menemukan alat dan pengaturan tanpa menebak.
- Memastikan setiap layar yang dapat kosong menampilkan *empty state* yang menjelaskan tujuan halaman dan menawarkan tindakan relevan (bukan *dead end*).
- Menyeragamkan pola *empty state* di seluruh aplikasi (ikon, judul, deskripsi, CTA) agar perilaku dan tampilan konsisten.

## 4. Target Pengguna

**Isi:**
Pengguna aplikasi Berhenti Merokok: perokok dewasa (khususnya pengguna Android di Indonesia) yang sedang atau berencana berhenti merokok, termasuk pengguna mode berhenti seketika maupun bertahap (tapering). Mereka membutuhkan:

- Akses cepat ke fitur utama tanpa belajar navigasi yang rumit.
- Panduan saat layar kosong (belum ada data) agar tahu langkah berikutnya, misalnya menekan tombol tambah untuk mencatat data pertama.
- Pengelompokan fitur sekunder yang jelas agar alat pendukung (SOS, kalender, diary, pengaturan) mudah ditemukan.

## 5. Ruang Lingkup

### Termasuk
- Mempertahankan empat tab utama (`Dashboard`, `Biodata`, `Impian`, `Lainnya`) tanpa menambah tab baru.
- Pengelompokan fitur sekunder di halaman `Lainnya` ke dalam 4 grup berlabel: **Dukungan** (SOS Craving, Alasan Berhenti), **Riwayat & Data** (Konsumsi Rokok, Diary Craving, Kalender Smoke-Free), **Alat** (Pemulihan Kesehatan, Pelacakan Toxin), **Pengaturan** (Pengaturan; Dummy hanya pada build debug/development).
- Standarisasi *empty state* pada seluruh layar yang dapat kosong: ikon, judul, deskripsi singkat, dan CTA yang relevan; dibungkus `SafeArea` + padding tepi layar.
- Penambahan/penyelarasan *empty state* pada layar yang belum memilikinya atau yang belum konsisten.
- Komponen *empty state* bersama di `lib/shared/` (`EmptyStateView`) agar pola tidak diduplikasi.

### Tidak Termasuk
- Menambah tab navigasi utama baru.
- Mengubah urutan atau ikon empat tab utama yang sudah ada.
- Mendesain ulang layar yang datanya selalu terisi (mis. Dashboard).
- Mengubah logika bisnis, perhitungan metrik, atau skema database.
- Menambah fitur baru di luar navigasi dan penanganan kondisi kosong.

## 6. Daftar Fitur

| Fitur | Deskripsi | Prioritas |
|---|---|---|
| Pertahankan empat tab utama | NavigationBar dengan 4 destinasi (Dashboard, Biodata, Impian, Lainnya) tetap dipertahankan; modul baru tidak menambah tab. | Must Have |
| Pengelompokan halaman `Lainnya` | Fitur sekunder dikelompokkan menjadi 4 grup berlabel: Dukungan (SOS Craving, Alasan Berhenti), Riwayat & Data (Konsumsi Rokok, Diary Craving, Kalender Smoke-Free), Alat (Pemulihan Kesehatan, Pelacakan Toxin), Pengaturan (Pengaturan; Dummy hanya di build debug). | Must Have |
| Standarisasi `EmptyState` | Pola tunggal: ikon + judul + deskripsi + CTA; `SafeArea` + padding; memakai `ColorScheme`/`textTheme`. | Must Have |
| CTA pada setiap *empty state* | Setiap *empty state* memiliki tombol CTA di dalamnya yang memicu aksi yang sama dengan FAB bila layar memiliki FAB. | Should Have |
| Komponen `EmptyStateView` bersama | Widget reusable di `lib/shared/` untuk menggantikan widget privat per layar. | Should Have |
| Penyelarasan layar non-daftar | Layar yang kondisinya "data belum ada" (kalender, pemulihan kesehatan, toxin, detail impian, sos craving, badge) ikut pola standar. | Should Have |

## 7. Detail Persyaratan Fitur

### 7.1 Nama fitur: Pertahankan empat tab utama

- **Tujuan:** Navigasi utama tetap sederhana dan mudah dipelajari.
- **Deskripsi:** `lib/home.dart` memakai `IndexedStack` + `NavigationBar` dengan empat destinasi: Dashboard (`CupertinoIcons.home`), Biodata (`CupertinoIcons.person`), Impian (`CupertinoIcons.star`), Lainnya (`CupertinoIcons.ellipsis`). Perilaku yang ada (tab malas dimuat, double-tap scroll-to-top) dipertahankan.
- **Data masukan:** Ketukan pengguna pada destinasi tab.
- **Proses:** Ketukan → `_saatPilihTab` → tab dibuka (malas) → `IndexedStack` menampilkan tab terpilih.
- **Aturan bisnis:**
  - Tidak boleh ada destinasi kelima pada `NavigationBar`.
  - Fitur/modul baru yang belum punya tab masuk ke grup yang sesuai di halaman `Lainnya`.
  - Modul baru tidak boleh menambah tab hanya karena "ada modul baru".
- **Validasi:** Jumlah `NavigationDestination` harus tetap 4; setiap modul baru terdaftar di salah satu grup `Lainnya`.
- **Kondisi berhasil:** Pengguna berpindah antar empat tab tanpa hambatan; modul baru ditemukan lewat `Lainnya`.
- **Kondisi gagal:** Penambahan tab kelima, atau modul baru tidak terdaftar di `Lainnya` (menjadi *dead end*).
- **Respons sistem:** Navigasi berpindah tab; modul baru tampil sebagai item grup di `Lainnya`.
- **Kriteria penerimaan:**
  - `NavigationBar` memiliki tepat 4 destinasi.
  - Seluruh modul yang dapat diakses pengguna terdaftar di `Lainnya` atau salah satu tab utama.

### 7.2 Nama fitur: Pengelompokan halaman `Lainnya`

- **Tujuan:** Fitur sekunder mudah dipindai dan ditemukan.
- **Deskripsi:** `lib/lainnya_screen.dart` yang saat ini menampilkan `ListView` datar berisi `ListTile` dikelompokkan menjadi beberapa grup dengan header berlabel. Urutan grup dan item konsisten.
- **Data masukan:** Tidak ada input pengguna; struktur grup statis di kode.
- **Proses:** Halaman dibuka → menampilkan grup berlabel → ketukan item → `Nav.to(...)` ke layar tujuan.
- **Aturan bisnis:**
  - Grup final (keputusan diskusi 2026-11-10):
    - **Dukungan**: SOS Craving, Alasan Berhenti.
    - **Riwayat & Data**: Konsumsi Rokok, Diary Craving, Kalender Smoke-Free.
    - **Alat**: Pemulihan Kesehatan, Pelacakan Toxin.
    - **Pengaturan**: Pengaturan; Dummy hanya tampil pada build debug/development (disembunyikan pada rilis).
  - Setiap item memakai `ListTile` dengan ikon + label + `chevron_right`, konsisten dengan pola saat ini.
  - Urutan grup dan item stabil; penambahan item baru masuk ke grup yang sesuai, bukan di akhir daftar tanpa aturan.
  - `DummyScreen` tidak muncul pada build rilis (keputusan diskusi 2026-11-10).
- **Validasi:** Setiap modul yang sebelumnya ada di daftar datar harus tetap terdaftar tepat satu kali di salah satu grup; tidak ada item hilang atau duplikat.
- **Kondisi berhasil:** Semua modul lama tetap dapat diakses; pengguna memahami pengelompokan tanpa penjelasan tambahan.
- **Kondisi gagal:** Modul hilang dari halaman setelah pengelompokan; urutan grup tidak konsisten.
- **Respons sistem:** Halaman `Lainnya` menampilkan grup berlabel; ketukan item membuka layar tujuan.
- **Kriteria penerimaan:**
  - Semua rute/modul yang sebelumnya terdaftar di `LainnyaScreen` masih terdaftar setelah pengelompokan (diverifikasi dengan daftar centang).
  - Grup memiliki header yang terlihat dan berbeda dari item.
  - Tidak ada modul baru yang menambah tab utama.

### 7.3 Nama fitur: Standarisasi `EmptyState`

- **Tujuan:** Kondisi kosong selalu informatif dan menawarkan tindakan.
- **Deskripsi:** Pola tunggal untuk kondisi "belum ada data": `SafeArea` + `Padding(EdgeInsets.all(16))` + `Center` + `Column` (ikon, judul bold, deskripsi singkat, opsional tombol CTA). Mengikuti skill proyek `empty-state-daftar`.
- **Data masukan:** Status daftar (kosong/tidak) dari state/provider layar.
- **Proses:** Layar memuat data → bila kosong, render *empty state* alih-alih daftar/konten kosong.
- **Aturan bisnis:**
  - Wajib menampilkan: ikon, judul, deskripsi; CTA bila ada tindakan yang relevan.
  - CTA berupa tombol di dalam *empty state* (`OutlinedButton`/`FilledButton.tonal`) yang memicu aksi yang sama dengan FAB bila layar memiliki FAB (keputusan diskusi 2026-11-10).
  - Judul dan deskripsi menjelaskan tujuan halaman, bukan sekadar "data kosong".
  - Warna dari `ColorScheme`/`textTheme`; bukan hardcode kecuali status semantik.
- **Validasi:** Setiap layar berbasis daftar memiliki cabang `isEmpty` yang merender *empty state*; teks tidak kosong; CTA (bila ada) memicu aksi yang benar.
- **Kondisi berhasil:** Pengguna paham mengapa layar kosong dan tahu tindakan pertama.
- **Kondisi gagal:** Layar kosong polos (`SizedBox.shrink`) tanpa informasi; CTA tidak melakukan apa-apa.
- **Respons sistem:** *Empty state* tampil; ketukan CTA membuka form/aksi terkait.
- **Kriteria penerimaan:**
  - Tidak ada layar berbasis daftar yang merender konten kosong tanpa informasi.
  - Setiap *empty state* memuat ikon + judul + deskripsi.
  - *Empty state* dibungkus `SafeArea` + padding tepi layar.

### 7.4 Nama fitur: Penyelarasan layar non-daftar / kondisi data belum siap

- **Tujuan:** Layar yang datanya belum tersedia tidak menjadi *dead end*.
- **Deskripsi:** Layar yang kondisinya "belum ada data biodata / belum ada tanggal mulai / belum ada catatan" ikut pola standar: penjelasan + CTA yang relevan (mis. CTA ke form biodata, atau penjelasan bahwa data akan muncul setelah pencatatan pertama).
- **Data masukan:** Status provider (biodata, konsumsi, impian, dll.).
- **Proses:** Provider kosong/belum siap → tampilkan pesan + CTA alih-alih konten kosong atau konten disembunyikan tanpa penjelasan.
- **Aturan bisnis:**
  - Layar yang CTA-nya mengarah ke pengisian biodata menautkan ke `FormBiodata`/layar biodata sesuai alur aplikasi.
  - Kartu motivasi SOS Craving yang sebelumnya disembunyikan saat alasan kosong diganti dengan pesan singkat "Belum ada alasan berhenti" + CTA "Tambah alasan" yang membuka layar Alasan Berhenti (keputusan diskusi 2026-11-10).
  - Layar kalkulasi (toxin, pemulihan kesehatan) menjelaskan bahwa data akan muncul setelah biodata/konsumsi tercatat, dengan CTA bila relevan.
- **Validasi:** Tidak ada teks "belum ada data" tanpa penjelasan lanjutan atau CTA; tidak ada `SizedBox.shrink` untuk kondisi data kosong pada layar utama.
- **Kondisi berhasil:** Pengguna di setiap layar tahu apa yang belum tersedia dan langkah berikutnya.
- **Kondisi gagal:** Layar tampak kosong/rusak tanpa penjelasan.
- **Respons sistem:** Pesan + CTA tampil konsisten dengan *empty state* standar.
- **Kriteria penerimaan:**
  - Seluruh kemunculan teks "Belum ada ..." pada layar memiliki penjelasan lanjutan atau CTA.
  - Tidak ada kondisi "data belum ada" yang hanya merender `SizedBox.shrink` tanpa keterangan.

### 7.5 Nama fitur: Komponen *empty state* bersama (`EmptyStateView`)

- **Status:** Disetujui pada diskusi 2026-11-10.
- **Tujuan:** Menghilangkan duplikasi widget `_Empty*` per layar.
- **Deskripsi:** Widget reusable (mis. `EmptyStateView` di `lib/shared/`) dengan parameter: ikon, judul, deskripsi, label CTA opsional, aksi CTA opsional. Layar pemanggil cukup mengisi parameter.
- **Data masukan:** Parameter widget.
- **Proses:** Layar memanggil `EmptyStateView(...)` pada cabang kosong.
- **Aturan bisnis:**
  - Widget bersifat *pure* (tidak membaca provider); pemanggil yang menyediakan teks dan aksi.
  - Mengikuti `widget-custom`: StatelessWidget, theme-safe (ColorScheme), aman untuk light/dark.
- **Validasi:** Tidak ada logika bisnis di dalam widget; semua parameter bertipe jelas.
- **Kondisi berhasil:** Widget privat `_Empty*` dapat dihapus/digantikan tanpa perubahan perilaku.
- **Kondisi gagal:** Widget menjadi terlalu generik sehingga teks menjadi tidak kontekstual.
- **Respons sistem:** *Empty state* seragam di seluruh layar.
- **Kriteria penerimaan:**
  - Minimal 4 layar memakai komponen bersama (Impian, Diary Craving, Alasan Berhenti, Konsumsi Rokok).
  - Tidak ada duplikasi pola SafeArea/Padding/Column di layar yang memakainya.

## 8. Alur Pengguna

**Isi:**
1. Pengguna membuka aplikasi → tab Dashboard tampil (tab pertama).
2. Pengguna mengetuk salah satu dari empat destinasi → tab berpindah.
3. Pengguna membuka tab Lainnya → melihat grup berlabel (mis. Dukungan, Riwayat & Data, Alat, Pengaturan) → mengetuk item → layar tujuan terbuka.
4. Pengguna membuka layar daftar (mis. Impian) yang datanya kosong → melihat *empty state* (ikon, judul, deskripsi, CTA) → mengetuk FAB/CTA → form tambah terbuka → data pertama tersimpan → daftar tampil.
5. Pengguna membuka layar yang datanya belum tersedia (mis. Pemulihan Kesehatan tanpa biodata) → melihat penjelasan + CTA ke pengisian biodata/pencatatan pertama.
6. Kondisi akhir: pengguna tidak pernah berhenti di layar kosong tanpa tahu langkah berikutnya.

Percabangan:
- Bila data sudah ada, daftar/konten tampil normal tanpa *empty state*.
- Bila terjadi error provider, layar menampilkan pesan gagal + tombol "Coba lagi" (pola yang sudah ada dipertahankan).

## 9. Persyaratan UI/UX

**Isi:**
- Navigasi utama: `NavigationBar` (Material 3) dengan 4 destinasi; ikon dan label tetap (`Dashboard`, `Biodata`, `Impian`, `Lainnya`).
- Halaman `Lainnya`: `Scaffold` + `AppBar('Lainnya')` + `SafeArea` + `ListView` dengan header grup (`Text` dengan `textTheme.titleSmall`/`labelLarge` berwarna `onSurfaceVariant`) diikuti `ListTile` (ikon + label + `chevron_right`).
- *Empty state*: `SafeArea` + `Padding(16)` + `Center` + `Column(spacing: 8)` — ikon 48px, judul `fontWeight: bold` (boleh lewat `textTheme`), deskripsi `textAlign: center`, tombol CTA di dalam *empty state* (`OutlinedButton`/`FilledButton.tonal`) yang memicu aksi yang sama dengan FAB bila ada (keputusan diskusi 2026-11-10).
- Konsistensi warna: gunakan `ColorScheme`/`textTheme`; hindari hardcode kecuali status semantik.
- Spacing mengikuti properti `spacing` pada `Column`/`Row` (bukan `SizedBox` berulang), sesuai skill `spacing`.
- Aksesibilitas: ikon dekoratif boleh tanpa label, tetapi CTA harus memiliki label teks yang jelas.

## 10. Ringkasan Kode Contoh Singkat

**Informasi:**
- Nama fitur: Standarisasi `EmptyState` / Pengelompokan `Lainnya`
- Bahasa pemrograman: Dart (Flutter)
- Tujuan kode: Menggambarkan bentuk *empty state* standar dan header grup pada `Lainnya`.

**Contoh kode:**

```dart
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
              Text('Belum ada impian',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Tekan tombol + untuk menambah impian pertama.',
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
```

```dart
// Pola header grup pada LainnyaScreen
Text('Dukungan',
    style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        )),
```

**Penjelasan:**
Contoh pertama adalah pola *empty state* yang sudah dipakai pada `ImpianScreen` dan menjadi acuan standarisasi. Contoh kedua menggambarkan header grup pada halaman `Lainnya` agar pengelompokan terlihat jelas tanpa menambah tab.

**Catatan:** Kode hanya sebagai ilustrasi, bukan ketentuan implementasi atau kode produksi.

## 11. Hak Akses Pengguna

| Jenis Pengguna | Hak Akses | Batasan |
|---|---|---|
| Pengguna aplikasi (satu-satunya peran) | Mengakses seluruh tab dan modul di `Lainnya`; melihat *empty state* dan CTA-nya | Tidak ada batasan peran; tidak ada konten berbayar/terkunci dalam ruang lingkup PRD ini |

Aplikasi hanya memiliki satu jenis pengguna tanpa pembatasan akses khusus.

## 12. Persyaratan Data

**Informasi yang perlu dijelaskan:**
- Jenis data: tidak ada data baru yang disimpan. Fitur ini hanya mengubah struktur navigasi dan tampilan kondisi kosong.
- Data yang harus disimpan: tidak ada.
- Hubungan antar-data: tidak ada.
- Aturan tambah/baca/ubah/hapus: tidak berubah; *empty state* hanya membaca status daftar/provider yang sudah ada.
- Validasi dan integritas: tidak ada perubahan skema; status "kosong" dideteksi dari state yang sudah ada (`list.isEmpty`, `AsyncValue`, dsb.).
- Kebutuhan sinkronisasi: tidak ada; aplikasi *offline-first* dengan penyimpanan lokal.

## 13. Persyaratan Nonfungsional

- **Performa:** Pengelompokan `Lainnya` tidak boleh menambah *build* berlebihan; `ListView` tetap lazy; widget `const` bila memungkinkan.
- **Keandalan:** *Empty state* tidak boleh memunculkan exception saat provider error; cabang error tetap memakai pola "Coba lagi" yang sudah ada.
- **Kompatibilitas:** Berjalan pada target Android proyek; tidak bergantung pada API khusus platform.
- **Kemudahan pemeliharaan:** Penambahan *empty state* baru cukup lewat parameter `EmptyStateView`, bukan menyalin widget.
- **Privasi:** Tidak ada data baru yang dikumpulkan atau ditampilkan di luar yang sudah ada.

## 14. Kriteria Penerimaan

**Isi:**
1. `NavigationBar` pada `lib/home.dart` memiliki tepat 4 destinasi dan tidak ada tab baru untuk modul baru.
2. Halaman `Lainnya` menampilkan 4 grup berlabel (Dukungan, Riwayat & Data, Alat, Pengaturan); seluruh modul yang sebelumnya terdaftar tetap terdaftar tepat satu kali.
3. Tidak ada layar berbasis daftar yang merender konten kosong tanpa ikon + judul + deskripsi.
4. Setiap *empty state* dibungkus `SafeArea` + padding tepi layar.
5. Layar dengan kondisi "data belum tersedia" (kalender, pemulihan kesehatan, toxin, detail impian, sos craving, badge) menampilkan penjelasan + CTA atau penjelasan lanjutan yang jelas; tidak ada `SizedBox.shrink` tanpa keterangan untuk kondisi tersebut.
6. Tidak ada perubahan pada skema database dan logika perhitungan metrik.
7. `dart analyze` tidak menghasilkan error baru pada file yang diubah.

## 15. Prioritas Pengembangan

- **Must Have:** Pertahankan empat tab; pengelompokan `Lainnya`; standarisasi `EmptyState` untuk layar daftar (Impian, Diary Craving, Alasan Berhenti, Konsumsi Rokok).
- **Should Have:** CTA pada *empty state*; penyelarasan layar non-daftar/kondisi data belum siap.
- **Could Have:** — (komponen `EmptyStateView` bersama disetujui dan menjadi Should Have).
- **Won't Have:** Tab navigasi kelima; redesign Dashboard; modul baru di luar navigasi/empty state.

## 16. Risiko dan Ketergantungan

**Isi:**
- **Risiko regresi navigasi:** Pengelompokan `Lainnya` berisiko menghilangkan rute yang jarang dipakai; mitigasi dengan daftar centang modul sebelum/sesudah.
- **Risiko inkonsistensi:** Standarisasi yang setengah jalan membuat dua pola hidup berdampingan; mitigasi dengan checklist layar + migrasi ke `EmptyStateView` bersama.
- **Ketergantungan:** Alur `Nav.to` dari `share_global_saya`; state Riverpod tiap layar; skill proyek (`empty-state-daftar`, `spacing`, `widget-custom`, `scaffold-struktur-layar`).
- **Asumsi yang sudah terverifikasi (diskusi 2026-11-10):** Struktur grup `Lainnya`; `DummyScreen` disembunyikan di rilis; `EmptyStateView` bersama disetujui; SOS Craving tanpa alasan memakai pesan + CTA.
- **Asumsi yang belum terverifikasi:** Tidak ada; seluruh keputusan terbuka pada draf awal sudah diputuskan pada diskusi 2026-11-10.
- **Batasan:** Tidak ada emulator/perangkat fisik pada lingkungan proyek; verifikasi visual akhir memerlukan pengujian di perangkat Android.

## 17. Rencana Pengembangan

| Tahap | Fitur | Target |
|---|---|---|
| Tahap 1 | Standarisasi `EmptyState` layar daftar yang sudah ada + verifikasi | Setelah PRD final |
| Tahap 2 | Pengelompokan `LainnyaScreen` + daftar centang modul | Setelah Tahap 1 |
| Tahap 3 | Penyelarasan layar non-daftar (kalender, pemulihan, toxin, detail impian, sos craving, badge) | Setelah Tahap 2 |
| Tahap 4 | Ekstraksi komponen `EmptyStateView` bersama + migrasi layar daftar | Setelah Tahap 3 |

## 18. Ketentuan Tambahan

**Isi:**
- PRD ini hanya mengubah navigasi dan tampilan kondisi kosong; tidak ada perubahan pada penyimpanan, notifikasi, atau perhitungan metrik.
- Mengubah `refrensi_apk.md` hanya pada penandaan bahwa section 7 sudah memiliki PRD; isi sumber tidak dihapus.
- Keputusan diskusi 2026-11-10:
  - Struktur grup `Lainnya`: Dukungan / Riwayat & Data / Alat / Pengaturan (urutan dan isi item sesuai bagian 7.2).
  - `DummyScreen` disembunyikan pada build rilis (hanya debug/development).
  - Komponen `EmptyStateView` bersama di `lib/shared/` disetujui.
  - Kartu motivasi SOS Craving saat alasan kosong: pesan singkat + CTA "Tambah alasan" ke layar Alasan Berhenti.
  - Gaya CTA *empty state*: tombol di dalam *empty state* (`OutlinedButton`/`FilledButton.tonal`), memicu aksi yang sama dengan FAB bila layar memiliki FAB.
  - `badge_screen.dart` dan `detail_impian_screen.dart` tetap diselaraskan dalam ruang lingkup PRD ini.

## 19. Riwayat Perubahan

| Tanggal | Perubahan | Keterangan |
|---|---|---|
| 2026-11-10 | Draf awal PRD dibuat dari `refrensi_apk.md` section 7 | Sumber: `refrensi_apk.md:236-244` |
| 2026-11-10 | Keputusan diskusi: struktur grup `Lainnya` (Dukungan / Riwayat & Data / Alat / Pengaturan), `DummyScreen` disembunyikan di rilis, `EmptyStateView` bersama disetujui, SOS Craving tanpa alasan memakai pesan + CTA | Empat pertanyaan diskusi dijawab pengguna |
| 2026-11-10 | Keputusan diskusi lanjutan: CTA *empty state* berupa tombol di dalam *empty state* (bukan hanya mengandalkan FAB); `badge_screen.dart` dan `detail_impian_screen.dart` tetap diselaraskan; status dokumen ditandai Final | Tiga pertanyaan diskusi dijawab pengguna |

## 20. File-File Terdampak

| Lokasi File | Status Perubahan | Deskripsi Perubahan |
|---|---|---|
| `lib/home.dart` | Diubah (minimal) | Verifikasi tetap 4 tab; tidak ada penambahan destinasi; mungkin hanya penyesuaian bila ditemukan ketidaksesuaian |
| `lib/lainnya_screen.dart` | Diubah | Pengelompokan item menjadi 4 grup berlabel (Dukungan, Riwayat & Data, Alat, Pengaturan); `DummyScreen` hanya tampil pada build debug/development |
| `lib/fitur/impian/screens/impian_screen.dart` | Diubah | `_EmptyImpian` diselaraskan ke `EmptyStateView` + tombol CTA |
| `lib/fitur/diary_craving/screens/diary_craving_screen.dart` | Diubah | `_EmptyDiaryCraving` diselaraskan ke `EmptyStateView` + tombol CTA |
| `lib/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart` | Diubah | `_EmptyAlasanBerhenti` diselaraskan ke `EmptyStateView` + tombol CTA |
| `lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart` | Diubah | `_EmptyKonsumsiRokok` diselaraskan ke `EmptyStateView` + tombol CTA (aksi sama dengan FAB `catatCepat`) |
| `lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart` | Diubah | Kondisi "Belum ada data biodata" / "Belum ada tanggal mulai berhenti merokok" diberi penjelasan + CTA |
| `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart` | Diubah | Kondisi "Belum ada data biodata" / "tanggal mulai belum ada" diberi penjelasan + CTA |
| `lib/fitur/toxin_pelacakan/screens/toxin_pelacakan_screen.dart` | Diubah | Kondisi "Belum ada catatan konsumsi" diberi CTA/penjelasan yang jelas |
| `lib/fitur/impian/screens/detail_impian_screen.dart` | Diubah | Kondisi "Impian tidak ditemukan" dan "Belum ada catatan" diselaraskan |
| `lib/fitur/sos_craving/screens/sos_craving_screen.dart` | Diubah | Kartu motivasi saat alasan kosong diganti pesan singkat "Belum ada alasan berhenti" + CTA "Tambah alasan" ke AlasanBerhentiScreen |
| `lib/fitur/badge/screens/badge_screen.dart` | Diubah | Catatan "Belum ada catatan konsumsi" diberi penjelasan/CTA bila relevan |
| `lib/shared/` (mis. `lib/shared/widget/empty_state_view.dart`) | Dibuat | Komponen `EmptyStateView` bersama |
| `refrensi_apk.md` | Diubah | Penandaan section 7 bahwa PRD sudah dibuat (tanpa menghapus isi sumber) |
| `prd/navigasi_dan_empty_state.md` | Dibuat | Dokumen PRD ini |

## 21. Referensi dari refrensi_apk.md

**Sumber:** `refrensi_apk.md` baris 236-244 (section "#### 7. Navigasi dan Empty State", prioritas Rendah).

### 21.1 Referensi Fitur

- **Referensi:** [Quitter](https://github.com/brandonp2412/quitter), [SmokingYou](https://github.com/bodyaant/SmokingYou), dan [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke).
- **Pola UI (dari referensi):** Beberapa area utama di navigasi bawah; pengaturan dan alat sekunder ditempatkan di halaman terkelompok.
- **Kondisi proyek (dari referensi):** Navigasi empat tab sudah ada dan beberapa empty state sudah disiapkan.
- **Saran (dari referensi):** Jangan menambah tab hanya karena ada modul baru. Setiap empty state perlu menjelaskan tujuan halaman dan menawarkan tindakan yang relevan.
- **Tujuan (dari referensi):** Menjaga navigasi mudah dipelajari dan mengurangi dead end.

Konteks penggunaan referensi fitur:
- Quitter (Flutter, open-source, MIT): tracker pemulihan offline dengan milestone, journaling, notifikasi, dan quit journey kustom; navigasi bawah dengan area utama terbatas dan pengaturan/alat sekunder di halaman terkelompok. Dapat digunakan sebagai gambaran interaksi navigasi bawah + pengelompokan sekunder, bukan sebagai sumber kode yang ditiru.
- SmokingYou (Kotlin/Compose, GPL-3.0): tracker minimalis berbasis Material 3 Expressive dengan one-tap logging, speed dial, widget, dan analitik pemicu; menunjukkan bahwa modul utama ditempatkan di navigasi utama sementara alat tambahan berada di luar navigasi utama.
- H2M Quit Smoking (Android, Play Store): timer quit, milestone kesehatan, SOS craving, statistik & kalender, pengingat pintar, dan tema; menunjukkan pengelompokan fitur (statistik/kalender/pengingat/tema) sebagai alat sekunder terpisah dari area utama.

### 21.2 Referensi UI/UX

- **Pola UI (dari referensi):** Beberapa area utama di navigasi bawah; pengaturan dan alat sekunder ditempatkan di halaman terkelompok.
- **Pola UX (dari referensi):** Jumlah pilihan utama tetap terbatas; halaman kosong memberi tahu tindakan berikutnya.
- **Pola layout (dari referensi):** Pertahankan empat tab utama saat ini dan kelompokkan fitur tambahan secara konsisten.
- Catatan: Nama grup dan detail visual `Lainnya` tidak ditentukan oleh referensi; ditentukan proyek ini saat diskusi PRD.

### 21.3 Referensi Alur Pengguna

- Tidak ada alur pengguna langkah-demi-langkah pada sumber; alur pada bagian 8 PRD ini disusun dari pola referensi (navigasi bawah terbatas + empty state yang memberi tahu tindakan berikutnya) dan kondisi proyek yang ada.

### 21.4 Referensi Lainnya

- **Prioritas pada sumber:** Rendah (section 7 berada di bawah "### Prioritas Rendah" pada `refrensi_apk.md:214`).
- **Kepastian sumber:** Ketiga tautan diperiksa pada 2026-11-10; Quitter dan SmokingYou adalah repositori publik (keberadaan repo tidak otomatis membuktikan aplikasi masih aktif dipelihara); H2M adalah halaman Google Play (klaim pengembang, bukan hasil pengujian perangkat).
- Referensi hanya inspirasi; bukan kewajiban meniru tampilan atau fitur referensi.
