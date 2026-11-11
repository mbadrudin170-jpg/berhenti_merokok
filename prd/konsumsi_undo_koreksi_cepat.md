# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Final

**Status Implementasi:** Belum Diimplementasikan

---

## 1. Informasi Produk

**Informasi:**
- Nama aplikasi: Berhenti Merokok
- Deskripsi produk: Aplikasi Flutter pendamping berhenti merokok — melacak konsumsi rokok aktual, menghitung metrik (uang dihemat, rokok tidak dihisap, streak smoke-free), tapering, dan dukungan craving.
- Platform: Android, iOS, Web, desktop (sesuai target proyek)
- Versi: 1.0.0+1
- Status pengembangan: Dalam pengembangan (fitur konsumsi rokok sudah tersedia; fitur undo/koreksi cepat belum)

## 2. Latar Belakang

Saat ini pencatatan konsumsi rokok dilakukan lewat dua jalur:

1. **Quick log (+1)** melalui FAB "Catat Rokok (+1)" di `KonsumsiRokokScreen` (`lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart:22-39`, FAB di `:92-96`). Setelah tersimpan, aplikasi hanya menampilkan `AppToast.sukses(context, 'Rokok dicatat (+1)')` — tidak ada cara langsung membatalkan entri yang salah.
2. **Form konsumsi** (`lib/fitur/konsumsi_rokok/screens/form_konsumsi_rokok.dart`) — bottom sheet `FormKonsumsiRokok` untuk menambah/mengubah catatan. Riwayat di `_DaftarKonsumsi` (`konsumsi_rokok_screen.dart:102-176`) dikelompokkan per tanggal, dan ketukan pada kartu hari itu hanya membuka form dengan `entriHari.first` — entri lain pada hari yang sama tidak bisa dipilih.
3. Notifier sudah menyediakan `hapus(String id)` (`konsumsi_rokok_notifier.dart:131-154`) dan `ubah` (`:103-129`), tetapi **tidak ada UI yang memanggil `hapus`** untuk konsumsi, dan tidak ada mekanisme undo/urungkan di mana pun (`grep` kata `undo`/`urungkan` pada `lib/` nihil).

Kesalahan input quick log (ketukan ganda, salah pencet) secara permanen menambah jumlah konsumsi hari itu, sehingga metrik uang dihemat, rokok tidak dihisap, tapering (target vs aktual), dan kalender smoke-free ikut bias tanpa bisa diperbaiki dengan cepat. Pengguna harus masuk ke form, mengubah nilai, lalu menyimpan — langkah yang terlalu panjang untuk koreksi satu ketuk.

## 3. Tujuan Produk

- Mengurangi dampak kesalahan input quick log (+1) dengan opsi pembatalan sesaat setelah pencatatan.
- Memungkinkan koreksi/penghapusan per entri langsung dari riwayat tanpa membuka form panjang.
- Melindungi integritas metrik yang terikat konsumsi dengan konfirmasi singkat sebelum perubahan yang mengubah jumlah.

## 4. Target Pengguna

Pengguna aplikasi Berhenti Merokok yang mencatat konsumsi aktual harian, terutama pengguna mode **tapering** (target vs aktual) dan pengguna yang mengandalkan quick log (+1) harian. Kebutuhan mereka: koreksi cepat dan tanpa rasa menyalahkan saat salah pencet, tanpa alur panjang.

## 5. Ruang Lingkup

### Termasuk
- Snackbar "Urungkan" setelah quick log (+1) selama ±10 detik.
- Snackbar "Urungkan" setelah penghapusan entri konsumsi dari riwayat.
- Riwayat: setiap entri pada hari yang sama dapat diketuk untuk diedit/dihapus (koreksi per entri, bukan hanya `entriHari.first`).
- Tombol hapus per entri (menghubungkan UI ke `notifier.hapus` yang sudah ada).
- Konfirmasi singkat sebelum menyimpan perubahan `jumlah` atau menghapus entri (karena metrik uang dihemat / rokok tidak dihisap / tapering bersumber dari konsumsi).

### Tidak Termasuk
- Perubahan rumus metrik (di luar ruang lingkup; lihat `MetrikBerhentiHelper`).
- Preview dampak slip / bahasa netral slip (itu ranah B5, `refrensi_apk.md:179-184`).
- Undo untuk penghapusan massal / impor cadangan.
- Undo pada level widget home-screen atau notifikasi.
- Perubahan skema database.

## 6. Daftar Fitur

| Fitur | Deskripsi | Prioritas |
|---|---|---|
| U1. Undo quick log | Snackbar "Urungkan (10 detik)" muncul setelah quick log (+1); mengetuknya menghapus entri yang baru dibuat | Must Have |
| U2. Undo hapus entri | Snackbar "Urungkan" setelah entri dihapus dari riwayat; mengetuknya mengembalikan entri yang sama | Should Have |
| U3. Koreksi per entri di riwayat | Riwayat menampilkan entri individual; ketukan pada entri membuka `FormKonsumsiRokok` untuk entri itu | Must Have |
| U4. Hapus per entri | Aksi hapus pada setiap entri riwayat dengan konfirmasi | Should Have |
| U5. Konfirmasi perubahan terikat metrik | Dialog konfirmasi singkat sebelum menyimpan bila `jumlah` berubah (atau entri dihapus), menyebut dampak ke metrik | Should Have |

## 7. Detail Persyaratan Fitur

### U1. Undo quick log

- **Nama fitur:** Undo quick log (+1)
- **Tujuan:** Membatalkan ketukan quick log yang keliru.
- **Deskripsi:** Sesudah `konsumsiRokokProvider.notifier.catatCepat()` berhasil, tampilkan Snackbar dengan aksi "Urungkan" berdurasi ±10 detik. Mengetuk aksi menghapus entri yang baru dibuat melalui `notifier.hapus(id)`.
- **Data masukan:** id entri yang baru dibuat (`catatCepat()` perlu mengembalikan model/id — saat ini `Future<void>`, menjadi `Future<KonsumsiRokokModel>` atau `Future<String>`).
- **Proses:**
  1. Pengguna mengetuk FAB "Catat Rokok (+1)" / CTA empty state.
  2. `catatCepat()` menyimpan entri dan mengembalikan id entri.
  3. Layar menampilkan Snackbar: pesan "Rokok dicatat (+1)" + tombol aksi "Urungkan", durasi ±10 detik.
  4. Jika pengguna mengetuk "Urungkan": panggil `notifier.hapus(id)`; jika gagal, tampilkan toast gagal.
  5. Jika Snackbar kedaluwarsa tanpa aksi: entri tetap tersimpan (tidak ada auto-delete).
- **Aturan bisnis:** Undo hanya berlaku untuk entri quick log yang baru dibuat pada sesi tampilan Snackbar tersebut. Tidak ada undo berantai (undo hanya untuk aksi terakhir).
- **Validasi:** id yang dikembalikan harus ada di state sebelum dihapus; bila entri sudah terhapus oleh jalur lain, aksi undo mengabaikan secara diam-diam dengan log `L.w`.
- **Kondisi berhasil:** entri hilang dari DB dan state; metrik ter-refresh.
- **Kondisi gagal:** DB error → Snackbar/toast "Gagal membatalkan catatan"; state tidak berubah.
- **Respons sistem:** Toast tidak digunakan untuk aksi undo (perlu tombol aksi) → gunakan `SnackBar` + `SnackBarAction` atau widget serupa yang mendukung aksi.
- **Kriteria penerimaan:** Quick log salah pencet dapat dibatalkan dalam 10 detik tanpa membuka form; metrik langsung berkurang 1 setelah undo.

### U2. Undo hapus entri

- **Nama fitur:** Undo hapus entri konsumsi
- **Tujuan:** Mengembalikan entri yang tidak sengaja dihapus dari riwayat.
- **Deskripsi:** Setelah `notifier.hapus(id)` berhasil dari aksi hapus di riwayat, tampilkan Snackbar "Catatan dihapus" + "Urungkan" ±10 detik. Mengetuknya mengembalikan entri dengan id, tanggal, jumlah, isSlip, catatan, dan dibuat yang sama persis (`notifier.tambah(model)` dengan model lama).
- **Proses:**
  1. Pengguna mengetuk ikon hapus pada entri riwayat.
  2. Dialog konfirmasi (lihat U5) → setuju.
  3. Simpan salinan model di memori, panggil `notifier.hapus(id)`.
  4. Tampilkan Snackbar "Urungkan". Bila diketuk → `notifier.tambah(salinan)`; entri muncul kembali dengan id yang sama.
- **Aturan bisnis:** Restore mempertahankan id asli agar relasi (slip/kalender) tetap konsisten; hanya satu level undo.
- **Kondisi gagal:** Restore gagal → toast gagal; data hilang dari state, perlu masuk form untuk mencatat ulang manual.
- **Kriteria penerimaan:** Hapus lalu undo dalam 10 detik mengembalikan entri identik (id sama) termasuk jumlah dan status slip.

### U3. Koreksi per entri di riwayat

- **Nama fitur:** Koreksi per entri di riwayat
- **Tujuan:** Mengoreksi entri tertentu tanpa memaksa edit `entriHari.first`.
- **Deskripsi:** Bagian riwayat (`_DaftarKonsumsi`) dikelompokkan per tanggal; ketukan pada kartu tanggal membuka bottom sheet "Catatan tanggal X" berisi daftar entri individual hari itu (jam, jumlah, SLIP bila ada, catatan). Setiap entri dapat diketuk untuk membuka `FormKonsumsiRokok(konsumsi: entri)`, atau dihapus via ikon hapus (U4).
- **Status keputusan:** opsi (b) — bottom sheet daftar entri (dipilih 2026-11-11).
- **Proses:**
  1. Pengguna mengetuk kartu tanggal.
  2. Tampil bottom sheet "Catatan tanggal X": daftar entri (jam, jumlah, SLIP bila ada, catatan).
  3. Ketuk entri → `FormKonsumsiRokok(konsumsi: entri)`.
  4. Ikon hapus pada entri → konfirmasi → `notifier.hapus` + Snackbar undo (U2).
- **Aturan bisnis:** Data grup per hari dipertahankan; tidak ada perubahan pada penyortiran (`ringkasanHarian` DESC).
- **Kriteria penerimaan:** Pada hari dengan ≥2 entri, pengguna dapat memilih entri kedua dan mengubah jumlahnya tanpa mengubah entri pertama.

### U4. Hapus per entri

- **Nama fitur:** Hapus entri konsumsi
- **Tujuan:** Menghubungkan UI ke `notifier.hapus` yang sudah ada.
- **Proses:** ikon hapus (mis. `CupertinoIcons.trash`) pada setiap baris entri di bottom sheet U3 → dialog konfirmasi (pola `showOkCancelAlertDialog`) → hapus + Snackbar undo (U2).
- **Aturan bisnis:** Penghapusan memerhatikan U5 (konfirmasi bila metrik terikat).
- **Kriteria penerimaan:** Menghapus satu entri tidak menghapus entri lain di hari yang sama; undo mengembalikan entri.

### U5. Konfirmasi sebelum perubahan terikat metrik

- **Nama fitur:** Konfirmasi perubahan yang mengubah metrik
- **Tujuan:** Mencegah perubahan jumlah/penghapusan yang diam-diam mengubah metrik turunan.
- **Deskripsi:** Saat `jumlah` pada entri yang sudah tersimpan berubah, atau entri dihapus, tampilkan dialog ringkas sebelum eksekusi. Form konsumsi sudah memiliki dialog "Simpan Konsumsi" generik (`form_konsumsi_rokok.dart:93-104`); dialog ini **dipertegas** hanya ketika `jumlah` berubah: judul "Ubah Jumlah", pesan menyertakan "Metrik uang dihemat, rokok tidak dihisap, dan target tapering akan ikut menyesuaikan." Ok/Cancel.
- **Aturan bisnis:** Konfirmasi tambahan hanya bila nilai `jumlah` berbeda dari nilai tersimpan atau entri dihapus; perubahan catatan/tanggal/slip saja tidak memunculkan dialog tambahan (tetap melewati dialog simpan generik yang sudah ada). **Keputusan (2026-11-11):** dialog hanya saat jumlah berubah/hapus — opsi "setiap penyimpanan" dan "khusus tapering" tidak dipakai.
- **Kriteria penerimaan:** Mengubah jumlah memunculkan dialog yang menyebut metrik; membatalkan dialog tidak mengubah data.

## 8. Alur Pengguna

**Alur A — Quick log salah pencet:**
1. Pengguna mengetuk FAB "+1". 2. Entri tersimpan, Snackbar muncul. 3. Pengguna sadar salah → mengetuk "Urungkan" ≤10 detik → entri dihapus → Snackbar "Catatan dibatalkan". 4. Metrik kembali seperti sebelum entri.

**Alur B — Koreksi jumlah entri tertentu:**
1. Pengguna membuka layar Konsumsi Rokok → mengetuk kartu tanggal. 2. Bottom sheet daftar entri hari itu. 3. Mengetuk entri yang keliru → form terbuka dengan data entri itu. 4. Mengubah jumlah → Simpan → dialog konfirmasi menyebut metrik → Ok. 5. Entry tersimpan; riwayat dan metrik refresh.

**Alur C — Hapus entri keliru:**
1. Pada bottom sheet entri, pengguna mengetuk ikon hapus. 2. Dialog konfirmasi ("Metrik akan menyesuaikan") → Ok. 3. Entri terhapus; Snackbar "Catatan dihapus — Urungkan". 4. Jika keliru → "Urungkan" → entri kembali.

## 9. Persyaratan UI/UX

- Semua aksi undo memakai **Snackbar dengan aksi** (`SnackBar` + `SnackBarAction` via `ScaffoldMessenger`), bukan `AppToast` (AppToast tidak mendukung tombol aksi — lihat `share_global_saya` `toast_widget.dart`: hanya `sukses/gagal/info/warning(context, message)`). **Keputusan (2026-11-11):** hapus/tambah langsung ke DB, undo = tulis ulang; `AppToast` tidak diperluas.
- Durasi Snackbar ±10 detik; teks aksi "Urungkan" (keputusan: 10 detik).
- Bottom sheet daftar entri mengikuti pola bottom sheet lain (`FormKonsumsiRokok` sudah memakai `showModalBottomSheet isScrollControlled: true`).
- Ikon hapus per entri: `CupertinoIcons.trash` dengan warna error semantic (`ColorScheme.error`), bukan merah hardcode kecuali status semantic yang diizinkan aturan styling.
- Warna slip tetap `Color(0xFFEF5350)` sesuai kode yang ada (semantic sukses/error diizinkan hardcode per skill styling).
- Tidak ada perubahan pada `EMPTY state` dan layout kartu tanggal selain yang diperlukan U3.
- Teks, label, dan bahasa Indonesia mengikuti konvensi proyek (identifier dan UI berbahasa Indonesia).

## 10. Ringkasan Kode Contoh Singkat

- Nama fitur: U1 — Undo quick log
- Bahasa pemrograman: Dart (Flutter)
- Tujuan kode: Menggambarkan pola Snackbar aksi undo; bukan ketentuan implementasi.

```dart
// catatCepat() mengembalikan id entri baru (mis. Future<KonsumsiRokokModel>)
final entri = await ref.read(konsumsiRokokProvider.notifier).catatCepat();
if (!context.mounted) return;
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text('Rokok dicatat (+1)'),
    action: SnackBarAction(
      label: 'Urungkan',
      onPressed: () => unawaited(
        ref.read(konsumsiRokokProvider.notifier).hapus(entri.id).catchError(
          (Object e, StackTrace s) => L.e('Gagal undo quick log: $e $s'),
        ),
      ),
    ),
    duration: const Duration(seconds: 10),
  ),
);
```

**Penjelasan:** Entri quick log dihapus ulang oleh aksi Snackbar dalam 10 detik; setelah kedaluwarsa, entri dianggap disengaja.

- Nama fitur: U2 — Undo hapus entri
- Bahasa pemrograman: Dart (Flutter)
- Tujuan kode: Restore entri yang baru dihapus dengan id yang sama.

```dart
final salinan = entri; // model yang baru dihapus
await ref.read(konsumsiRokokProvider.notifier).hapus(salinan.id);
// ... tampilkan SnackBar "Urungkan"; bila diketuk:
await ref.read(konsumsiRokokProvider.notifier).tambah(salinan); // id sama
```

**Penjelasan:** `tambah` yang sudah ada menulis ulang baris dengan id sama; metrik dihitung ulang dari daftar.

**Catatan:** Kode hanya sebagai ilustrasi, bukan ketentuan implementasi atau kode produksi.

## 11. Hak Akses Pengguna

Aplikasi hanya memiliki satu jenis pengguna tanpa pembatasan khusus. Setiap pengguna dapat mencatat, mengoreksi, dan menghapus catatan konsumsi miliknya sendiri di perangkat yang sama.

| Jenis Pengguna | Hak Akses | Batasan |
|---|---|---|
| Pengguna aplikasi | Catat, ubah, hapus, dan undo catatan konsumsi | Tidak ada lintas-pengguna; data lokal di perangkat |

## 12. Persyaratan Data

- Jenis data: entri konsumsi (`KonsumsiRokokModel` / tabel `konsumsi_rokok`): `id` (uuid), `tanggal` (UTC), `jumlah` (int ≥ 0), `isSlip` (bool), `catatan` (opsional), `dibuat` (UTC).
- Data yang harus disimpan: tidak ada data baru; undo mengandalkan `id` dan salinan model di memori selama Snackbar aktif.
- Hubungan antar-data: entri konsumsi menjadi sumber metrik turunan (`MetrikBerhentiHelper`: uang dihemat aktual, rokok dihindari aktual), kalender smoke-free, dan target tapering — perubahan entri otomatis terefleksi karena metrik dihitung ulang dari state.
- Aturan ubah/hapus: hapus fisik baris (`notifier.hapus`); restore menulis baris dengan id sama via `tambah` (`ConflictAlgorithm.replace`).
- Validasi dan integritas: `jumlah ≥ 0` (form sudah memvalidasi), restore tidak boleh mengubah `dibuat` asli.
- Sinkronisasi: tidak ada (data lokal SQLite).

## 13. Persyaratan Nonfungsional

- Undo harus selesai ≤1 detik pada perangkat umum (operasi DB lokal single-row).
- Snackbar tidak boleh tertimbun toast lain; pengguna tetap dapat melihat konten di belakangnya.
- Tidak menambah dependency grafik atau paket baru.
- `dart analyze` tanpa error baru pada file yang disentuh.
- Tidak overflow pada lebar ≤320 dp / skala teks besar untuk baris entri dan bottom sheet.

## 14. Kriteria Penerimaan

1. Setelah quick log (+1), Snackbar "Urungkan" tampil ±10 detik; mengetuknya menghapus entri dan mengembalikan metrik.
2. Setelah Snackbar kedaluwarsa, entri tersimpan permanen.
3. Riwayat mengelompokkan per tanggal; mengetuk kartu tanggal membuka daftar entri individual; entri ke-2+ dapat diedit/dihapus.
4. Mengubah jumlah pada entri tersimpan memunculkan dialog yang menyebut metrik; Cancel tidak mengubah data.
5. Menghapus entri menampilkan Snackbar "Urungkan"; undo mengembalikan entri dengan id, jumlah, isSlip, catatan yang sama.
6. Undo tidak memengaruhi entri lain (hanya baris dengan id terkait).
7. Tidak ada error `dart analyze` baru; tidak ada overflow ≤320 dp.

## 15. Prioritas Pengembangan

U1 (Undo quick log) = Must Have; U3 (Koreksi per entri) = Must Have; U5 (Konfirmasi terikat metrik) = Should Have; U2 (Undo hapus) = Should Have; U4 (Hapus per entri) = Should Have. Semuanya berada pada satu iterasi kecil; U1 dikerjakan lebih dulu karena dampaknya paling langsung pada kesalahan input.

## 16. Risiko dan Ketergantungan

- **Risiko:** Snackbar bertabrakan dengan `AppToast`/EasyLoading yang sering dipakai proyek — dimitigasi dengan menggunakan satu mekanisme (ScaffoldMessenger) untuk aksi undo saja.
- **Risiko:** Restore (`tambah` dengan id sama) memakai `ConflictAlgorithm.replace`; bila baris belum benar-benar hilang (race), replace aman, tetapi perlu pastikan `hapus` selesai sebelum restore mungkin terjadi (undo hanya bisa setelah Snackbar muncul, yaitu setelah `hapus` selesai).
- **Cakupan disepakati (2026-11-11):** U2 (undo hapus entri) termasuk lingkup.
- **Risiko:** `catatCepat` saat ini `Future<void>`; mengubah signature ke mengembalikan model menyentuh call site — hanya satu call site (`konsumsi_rokok_screen.dart`), risiko rendah.
- **Ketergantungan:** `KonsumsiRokokNotifier` (`konsumsi_rokok_notifier.dart`), `FormKonsumsiRokok`, `_DaftarKonsumsi`, `SqfliteOp`, `MetrikBerhentiHelper` (tidak diubah), pola dialog `showOkCancelAlertDialog` (adaptive_dialog).
- **Asumsi belum terverifikasi:** tidak ada mekanisme undo global di aplikasi; undo diimplementasikan lokal per aksi.

## 17. Rencana Pengembangan

| Tahap | Fitur | Target |
|---|---|---|
| 1 | U1 Undo quick log + ubah signature `catatCepat` | Iterasi 1 |
| 2 | U3 + U4 koreksi & hapus per entri (bottom sheet entri) | Iterasi 2 |
| 3 | U2 undo hapus + U5 konfirmasi perubahan jumlah | Iterasi 3 |

## 18. Ketentuan Tambahan

- `AppToast` tidak digunakan untuk aksi undo; bila di kemudian hari `AppToast` diperluas mendukung tombol aksi, migrasi opsional.
- Dialog "konfirmasi sebelum mengubah jumlah" dibuat minimal: judul, satu kalimat dampak metrik, Ok/Cancel — tanpa preview angka (preview slip adalah ranah B5).
- Teks aksi konsisten: "Urungkan" (bukan "Undo") sesuai konvensi bahasa Indonesia proyek.

## 19. Riwayat Perubahan

| Tanggal | Perubahan | Keterangan |
|---|---|---|
| 2026-11-11 | Draf awal dibuat dari `refrensi_apk.md` B3 (baris 166–172) | Menunggu diskusi/penyempurnaan |
| 2026-11-11 | Ditetapkan Final setelah diskusi (durasi undo 10 detik; riwayat opsi b bottom sheet; mekanisme hapus langsung + undo tulis ulang; U5 hanya saat jumlah berubah/hapus; U2 masuk lingkup) | Status Dokumen: Draft → Final |

## 20. File-File Terdampak

| Lokasi File | Status Perubahan | Deskripsi Perubahan |
|---|---|---|
| `lib/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart` | Diubah | `catatCepat()` mengembalikan entri/id baru; tidak ada method baru wajib (restore memakai `tambah`, undo quick log memakai `hapus`) |
| `lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart` | Diubah | Quick log menampilkan Snackbar aksi "Urungkan" (U1); `_DaftarKonsumsi` diubah agar ketukan kartu tanggal membuka bottom sheet daftar entri (U3); integrasi aksi hapus per entri (U4) |
| `lib/fitur/konsumsi_rokok/screens/form_konsumsi_rokok.dart` | Diubah | Dialog simpan dipertegas saat `jumlah` berubah (U5) — pesan menyebut metrik; aksi hapus entri (bila ditempatkan di form) |
| `lib/fitur/konsumsi_rokok/screens/` (file baru, mis. `daftar_entri_konsumsi_sheet.dart`) | Dibuat | Bottom sheet daftar entri per tanggal untuk U3/U4 |
| `lib/fitur/konsumsi_rokok/state/konsumsi_rokok_state.dart` | Diubah (opsional) | Hanya bila perlu helper daftar entri per tanggal; `ringkasanHarian` sudah tersedia |
| `lib/shared/widget/` (opsional) | Dibuat/Diubah (opsional) | Helper Snackbar undo bila ingin dipakai ulang; bila tidak, lokal di layar |

Dikecualikan (tidak disentuh): `metrik_berhenti_helper.dart`, kalender smoke-free, tapering, impian, SOS, alasan_berhenti, cadangan.

## 21. Referensi dari refrensi_apk.md

Sumber: `refrensi_apk.md:166-172` — bagian "#### B3. Konsumsi — Undo & Koreksi Cepat".

### 21.1 Referensi Fitur

- **Tujuan (sumber):** mengurangi kesalahan input quick log; koreksi tidak menjangkau form panjang.
- **Saran (sumber):** snackbar "Urungkan (10 detik)" setelah quick log; entri dapat diedit dari ketuk item riwayat; konfirmasi sebelum mengubah jumlah bila metrik terikat.
- **Prioritas (sumber):** Sedang.
- Referensi kompetitor yang tercantum di sumber:
  - [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app) — undo entri/penghapusan; README menyebut "Annulla dopo ogni registrazione e ogni cancellazione" (batal setelah setiap pencatatan dan setiap penghapusan). Relevan untuk U1 dan U2.
  - [Pace Android](https://github.com/ravipurohit1991/pace) — "One tap logs a cigarette, with a 12-second undo from the app"; juga ledger yang dapat diedit dan hapus duplikat. Relevan untuk U1 (durasi undo) dan U3 (koreksi entri).
  - [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) — "a slip log you can undo". Relevan untuk undo pada catatan slip.
  - [Breathing Room](https://github.com/anindya127/Breathing-Room) — pelacak dual-mode dengan quick counter; tidak menyebut mekanisme undo secara eksplisit pada README; dicatat sebagai contoh quick-counter tanpa detail undo.
  - [SmokingYou](https://f-droid.org/en/packages/com.smokingtracker/) — log satu ketuk, quick-add widget; tidak menyebut undo secara eksplisit; dicatat sebagai contoh pencatatan cepat.

### 21.2 Referensi UI/UX

- Snackbar dengan aksi "Urungkan" (10–12 detik) adalah pola UI utama pada kompetitor (My Tracking App, Pace).
- Riwayat dapat diedit (Pace: "Editable ledger"; ketuk untuk koreksi).
- Bottom sheet daftar entri mengikuti pola bottom sheet proyek yang sudah ada (`FormKonsumsiRokok`).

### 21.3 Referensi Alur Pengguna

- Alur singkat: quick log → Snackbar undo → (opsional) batalkan; riwayat → ketuk entri → edit → konfirmasi metrik → simpan; hapus entri → Snackbar undo → restore. (Selaras dengan bagian 8.)

### 21.4 Referensi Lainnya

- Bagian B3 berada pada kelompok "B. Optimasi Fitur yang Sudah Ada — Prioritas Sedang" di `refrensi_apk.md:154-156`; fitur ini memperbaiki fitur konsumsi yang sudah ada, bukan fitur baru.
- Catatan sumber: tidak ada grafik/dependency baru yang diperlukan; fitur memakai mekanisme yang sudah tersedia (Sqflite, Riverpod, Snackbar).
