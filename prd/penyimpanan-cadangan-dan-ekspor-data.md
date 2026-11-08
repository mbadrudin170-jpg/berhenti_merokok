# PRD: Penyimpanan Cadangan dan Ekspor Data (Lokal)

## 1. Informasi Dokumen

- **Nama fitur:** Penyimpanan Cadangan dan Ekspor Data (Lokal)
- **Jenis pengembangan:** Fitur baru (belum ada implementasi di proyek)
- **Status implementasi:** Belum ditemukan (belum ada mekanisme cadangan/ekspor)
- **Status PRD:** Draft
- **Tanggal pembuatan/pembaruan:** 2026-11-08
- **Sumber referensi:** `refrensi_apk.md`

## 2. Tujuan Fitur

Melindungi data pengguna (biodata, impian, diary craving, alasan berhenti) dari kehilangan saat ganti perangkat, reset, atau kerusakan, dengan menyediakan mekanisme pencadangan dan ekspor data lokal yang dapat dikendalikan pengguna, tanpa mewajibkan akun atau backend, sesuai prinsip offline-first aplikasi.

## 3. Latar Belakang dan Permasalahan

Data aplikasi saat ini hanya tersimpan lokal di SQLite (`berhenti_merokok.db`) pada perangkat. Tidak ada mekanisme ekspor atau pencadangan. Jika pengguna kehilangan perangkat, melakukan reset, atau berganti perangkat, seluruh riwayat (biodata, impian, diary craving, alasan berhenti) hilang. Referensi aplikasi kompetitor (Smoke Tracker, Quitzilla, Quit Tracker) menyediakan pencadangan terenkripsi (Google Drive), ekspor CSV, atau berkas cadangan lokal yang dapat dipulihkan.

## 4. Target Pengguna

Pengguna aplikasi yang telah mencatat data (biodata, impian, diary craving, alasan berhenti) dan ingin melindungi atau memindahkan data tersebut ke perangkat baru, atau membagikannya (mis. ke tenaga kesehatan) tanpa kehilangan riwayat.

## 5. Manfaat Fitur

- **Manfaat utama:** Mencegah kehilangan data saat ganti perangkat/reset; memungkinkan pemulihan data.
- **Manfaat tambahan:** Meningkatkan kepercayaan pengguna terhadap data pribadi; mendukung prinsip offline-first; memungkinkan arsip pribadi atau berbagi dengan tenaga kesehatan (ekspor).
- **Dampak terhadap pengguna:** Kendali penuh atas data; tanpa akun wajib.
- **Dampak terhadap aplikasi:** Memanfaatkan tabel dan model yang sudah ada; tidak mengubah skema database.

## 6. Referensi Aplikasi

- **Nama aplikasi:** Smoke Tracker: Track & Pace (Codeas); Quitzilla (despdev); Quit Tracker (despDev)
- **Link aplikasi:**
  - https://play.google.com/store/apps/details?id=com.smoketracker.app
  - https://quitzilla.com/
  - https://quittracker.app/
- **Screenshot/demonstrasi:** Screenshot resmi tersedia pada halaman Google Play Store (Smoke Tracker, Quit Tracker); situs resmi Quitzilla menjelaskan fitur ekspor CSV dan pencadangan Google Drive.
- **Gambaran tampilan:** Pengaturan/Settings berisi opsi "Backup & Restore" / "Export data"; dialog pemilihan lokasi berkas.
- **Gambaran cara kerja:** Ekspor data ke berkas (CSV/JSON) yang dapat disimpan pengguna, atau pencadangan ke penyimpanan lokal/awan pilihan pengguna (tanpa akun wajib). Pemulihan melalui berkas cadangan yang dipilih pengguna.
- **Informasi yang belum terverifikasi:** Detail format berkas (CSV/JSON), struktur kolom, apakah pencadangan terenkripsi, serta alur pemulihan (merge/replace) tidak dapat diverifikasi secara langsung; hanya deskripsi fitur yang dapat dikonfirmasi dari sumber resmi.

## 7. Sumber Referensi Internal

- Nama file: `refrensi_apk.md`
- Path: `refrensi_apk.md`
- Baris: `L36-L46` (entri "#### 2. Penyimpanan Cadangan dan Ekspor Data (Lokal)")
- Referensi lengkap: `refrensi_apk.md:L36-L46`
- Nama data: Penyimpanan Cadangan dan Ekspor Data (Lokal)
- Link aplikasi: https://play.google.com/store/apps/details?id=com.smoketracker.app ; https://quitzilla.com/ ; https://quittracker.app/

## 8. Kondisi Implementasi Saat Ini

- **Status implementasi:** Belum ditemukan
- **Fungsi yang sudah tersedia:**
  - Penyimpanan data lokal di SQLite dengan tabel `biodata`, `impian`, `diary_craving`, `alasan_berhenti` (`lib/shared/db/sqflite/sqflite.dart`).
  - Akses CRUD generik via `SqfliteOp` (`lib/shared/db/sqflite/sqflite_op.dart`).
  - Model dengan `fromSqflite`/`toSqflite` (mis. `BiodataModel`, `ImpianModel`, `DiaryCravingModel`, `AlasanBerhentiModel`).
  - Halaman Pengaturan (`lib/fitur/pengaturan/screens/pengaturan_screen.dart`) untuk tema dan notifikasi.
- **Fungsi yang belum tersedia:**
  - Ekspor data ke berkas (CSV/JSON).
  - Pencadangan (backup) ke penyimpanan lokal/awan.
  - Pemulihan (restore) dari berkas cadangan.
  - Pemilihan lokasi/berkas (file picker) dan penanganan izin penyimpanan.
  - Validasi integritas berkas cadangan.
- **Bagian yang sudah sesuai:** Struktur data dan lapisan akses database sudah siap digunakan sebagai sumber ekspor.
- **Bagian yang belum sesuai:** Tidak ada UI, service, atau alur untuk cadangan/ekspor/pemulihan.
- **Bukti:** Pencarian kode (`backup`, `ekspor`, `export`, `csv`, `file_picker`, `path_provider`) tidak menemukan implementasi; `pubspec.yaml` tidak memuat dependensi terkait berkas.

## 9. Ruang Lingkup

- **Termasuk (usulan):**
  - Layar khusus cadangan (`cadangan_screen.dart`) sebagai tujuan navigasi dari Pengaturan; Pengaturan hanya menyediakan entri navigasi (tidak menampung tombol aksi langsung).
  - Ekspor data lokal ke berkas (format JSON, dengan opsi CSV untuk data tabular) yang dapat disimpan pengguna.
  - Pencadangan lokal (berkas cadangan) yang dapat dipulihkan (restore) dengan konfirmasi.
  - Validasi berkas cadangan (versi skema, integritas minimal) sebelum restore.
  - Penanganan izin penyimpanan berkas sesuai platform (Android).
- **Tidak termasuk:**
  - Pencadangan otomatis ke cloud/Google Drive (dapat dipertimbangkan tahap lanjut).
  - Enkripsi berkas cadangan (dapat dipertimbangkan tahap lanjut; data sensitif saat ini terbatas pada biodata non-kredensial).
  - Sinkronisasi multi-perangkat atau backend.
  - Perubahan skema database atau migrasi.
  - Widget beranda dan fitur lain.

## 10. Alur Penggunaan

### Ekspor
1. Pengguna membuka Pengaturan.
2. Pengguna menekan entri "Cadangan & Ekspor Data" → navigasi ke layar khusus cadangan.
3. Pada layar cadangan, pengguna menekan "Ekspor data".
4. Aplikasi menampilkan konfirmasi dan indikator loading.
5. Aplikasi mengumpulkan data dari seluruh tabel (`biodata`, `impian`, `diary_craving`, `alasan_berhenti`).
6. Aplikasi menulis berkas cadangan (JSON) ke lokasi yang dipilih pengguna (atau direktori dokumen aplikasi).
7. Aplikasi menampilkan feedback sukses/gagal dan path berkas.

### Pemulihan (Restore)
1. Pengguna membuka Pengaturan.
2. Pengguna menekan entri "Cadangan & Ekspor Data" → navigasi ke layar khusus cadangan.
3. Pada layar cadangan, pengguna menekan "Pulihkan data".
4. Pengguna memilih berkas cadangan.
5. Aplikasi memvalidasi berkas (format, versi skema).
6. Aplikasi menampilkan konfirmasi (data akan diganti/ditambahkan).
7. Aplikasi memulihkan data dalam transaksi.
8. Aplikasi menampilkan feedback dan memperbarui tampilan.

## 11. Persyaratan Fungsional

1. Ekspor menghasilkan berkas yang memuat seluruh data dari tabel `biodata`, `impian`, `diary_craving`, dan `alasan_berhenti`.
2. Format berkas wajib dapat dibaca kembali untuk pemulihan (JSON direkomendasikan; CSV opsional untuk data tabular).
3. Pemulihan wajib memvalidasi berkas sebelum menulis ke database.
4. Pemulihan wajib menggunakan transaksi agar konsisten.
5. Operasi ekspor/pemulihan wajib menampilkan indikator loading dan mencegah double submit.
6. Konfirmasi pengguna wajib sebelum pemulihan (karena menimpa data).
7. Feedback sukses/gagal wajib ditampilkan (AppToast).
8. Izin penyimpanan berkas ditangani sesuai platform (Android).
9. Setelah restore, state in-memory disinkronkan (refresh provider terkait) agar tampilan konsisten; restart aplikasi (via paket `restart_app`) merupakan opsi alternatif. Referensi kompetitor tidak menyebutkan restart eksplisit.
10. Jika restart gagal (`RestartResult.success == false`), catat `code`/`message` melalui `L.e`, tampilkan feedback kegagalan, dan lakukan fallback dengan refresh provider terkait. Data tetap aman di database; hanya state in-memory yang mungkin perlu dimuat ulang secara manual atau saat peluncuran berikutnya.
11. Ekspor dan restore wajib atomik: ekspor yang gagal di tengah jalan wajib menghapus berkas parsial dan tidak menyisakan berkas korup; restore wajib berjalan dalam transaksi sehingga kegagalan pada salah satu tahap melakukan rollback dan tidak meninggalkan data setengah pulih. Validasi berkas (format/versi) wajib dilakukan sebelum menulis ke database. Kegagalan dicatat melalui `L.e` dan ditampilkan ke pengguna.

## 12. Persyaratan Nonfungsional

- **Performa:** Ekspor/pemulihan berjalan di background (hindari memblokir UI); untuk data besar pertimbangkan isolate.
- **Keamanan:** Tidak menyimpan kredensial; data tetap lokal; berkas cadangan tidak wajib terenkripsi pada tahap awal (dapat ditambahkan kemudian).
- **Keandalan:** Kegagalan dicatat melalui `L.e` dan ditampilkan ke pengguna; transaksi rollback pada kegagalan.
- **Kemudahan penggunaan:** Label jelas; area sentuh minimal 48x48 dp; konsisten dengan tema.
- **Kompatibilitas:** Android-first; penanganan platform yang tidak mendukung (Web) secara eksplisit.

## 13. File yang Terdampak

### File yang sudah menangani fitur (sumber data)
- `lib/shared/db/sqflite/sqflite.dart` — `AppDatabase`, skema tabel.
- `lib/shared/db/sqflite/sqflite_op.dart` — `SqfliteOp`, akses CRUD/transaksi.
- `lib/shared/konstanta/nama_tabel.dart` — `NamaTabel`.
- `lib/shared/konstanta/nama_kolom.dart` — `NamaKolom`.
- `lib/fitur/biodata/model/biodata_model.dart` — `BiodataModel` (`fromSqflite`/`toSqflite`).
- `lib/fitur/impian/model/impian_model.dart` — `ImpianModel`.
- `lib/fitur/diary_craving/model/diary_craving_model.dart` — `DiaryCravingModel`.
- `lib/fitur/alasan_berhenti/model/alasan_berhenti_model.dart` — `AlasanBerhentiModel`.
- `lib/fitur/pengaturan/screens/pengaturan_screen.dart` — UI Pengaturan (tempat entri navigasi).

### File yang perlu diubah (usulan)
- `lib/fitur/pengaturan/screens/pengaturan_screen.dart` — Tambah entri navigasi "Cadangan & Ekspor Data" ke layar khusus cadangan (Pengaturan hanya menavigasi, tidak menampung tombol aksi langsung).
- `android/app/src/main/AndroidManifest.xml` — Izin penyimpanan berkas (jika diperlukan).
- `pubspec.yaml` — Tambah dependensi `file_picker`/`path_provider`/`share_plus` (melalui `flutter pub add`).

### File baru yang mungkin diperlukan (usulan)
- `lib/fitur/cadangan/screens/cadangan_screen.dart` — Layar khusus cadangan (ekspor/pulihkan + loading + feedback).
- `lib/fitur/cadangan/helper/cadangan_helper.dart` — Logika ekspor/pemulihan.
- `lib/fitur/cadangan/state/cadangan_state.dart` + `.freezed.dart` — State loading/sukses/gagal (opsional).

## 14. Gambaran Teknis

Pendekatan: kumpulkan seluruh baris dari setiap tabel menggunakan `SqfliteOp.ambilSemua`, serialisasi ke JSON (map tabel → list row), tulis ke berkas. Pemulihan: baca berkas, validasi, lalu tulis ulang dalam transaksi (replace). Gunakan `path_provider` untuk direktori dokumen dan `file_picker`/`share_plus` untuk berbagi/penyimpanan. Tidak mengubah skema database.

### Contoh 1 — Kumpulkan Data untuk Ekspor

**Path:** `lib/fitur/cadangan/helper/cadangan_helper.dart` (usulan)

```dart
import 'dart:convert';

import 'package:berhenti_merokok/shared/db/sqflite/sqflite_op.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_tabel.dart';

Future<String> buatCadanganJson() async {
  final op = const SqfliteOp();
  final biodata = await op.ambilSemua(NamaTabel.biodata);
  final impian = await op.ambilSemua(NamaTabel.impian);
  final diary = await op.ambilSemua(NamaTabel.diaryCraving);
  final alasan = await op.ambilSemua(NamaTabel.alasanBerhenti);

  final payload = <String, Object?>{
    'versi': 1,
    'biodata': biodata,
    'impian': impian,
    'diary_craving': diary,
    'alasan_berhenti': alasan,
  };
  return jsonEncode(payload);
}
```

**Tujuan:** Mengumpulkan seluruh data dari tabel yang ada menjadi satu payload JSON.

**Hubungan:** Menggunakan `SqfliteOp` dan `NamaTabel` yang sudah tersedia; tidak mengubah skema.

### Contoh 2 — Pulihkan Data dalam Transaksi

**Path:** `lib/fitur/cadangan/helper/cadangan_helper.dart` (usulan)

```dart
Future<void> pulihkanDariJson(String json) async {
  final data = jsonDecode(json) as Map<String, dynamic>;
  final op = const SqfliteOp();
  await op.transaksi((txn) async {
    // Hapus data lama agar restore bersifat replace (opsional, per keputusan).
    await txn.delete(NamaTabel.biodata);
    await txn.delete(NamaTabel.impian);
    await txn.delete(NamaTabel.diaryCraving);
    await txn.delete(NamaTabel.alasanBerhenti);

    for (final row in (data['biodata'] as List)) {
      await txn.insert(NamaTabel.biodata, Map<String, Object?>.from(row));
    }
    // ... ulangi untuk impian, diary_craving, alasan_berhenti
  });
}
```

**Tujuan:** Memulihkan data dari berkas cadangan secara atomik.

**Hubungan:** Menggunakan transaksi `SqfliteOp.transaksi`; konsisten dengan pola CRUD proyek.

### Contoh 3 — Entri Navigasi pada Pengaturan

**Path:** `lib/fitur/pengaturan/screens/pengaturan_screen.dart`

```dart
// Pada Column build Pengaturan (setelah _buildNotifikasi()):
ListTile(
  title: const Text('Cadangan & Ekspor Data'),
  trailing: const Icon(CupertinoIcons.chevron_right),
  onTap: () => unawaited(
    Nav.to(context, const CadanganScreen()).catchError((
      Object e,
      StackTrace s,
    ) {
      L.e('Gagal navigasi ke Cadangan: $e $s');
      return null;
    }),
  ),
),
```

**Tujuan:** Pengaturan hanya menavigasi ke layar khusus cadangan; tombol aksi ekspor/pulihkan berada di `CadanganScreen`.

**Hubungan:** Konsisten dengan pola navigasi proyek (`Nav`, `unawaited` + `.catchError`, `L`).

## 15. Kriteria Penerimaan

1. Tombol "Ekspor data" tersedia pada Pengaturan dan menghasilkan berkas cadangan yang dapat dibuka kembali.
2. Tombol "Pulihkan data" tersedia dan memulihkan data setelah validasi berkas.
3. Data yang diekspor mencakup seluruh tabel (`biodata`, `impian`, `diary_craving`, `alasan_berhenti`).
4. Pemulihan tidak merusak konsistensi data (transaksi).
5. Loading dan feedback ditampilkan untuk kedua operasi.
6. Kegagalan dicatat melalui `L.e` dan ditampilkan ke pengguna.
7. `flutter analyze` tidak menemukan error baru (saat implementasi).
8. Tidak ada perubahan skema database.

## 16. Risiko dan Ketergantungan

- **Risiko:** Format berkas yang tidak kompatibel antar versi; kehilangan data jika restore menimpa tanpa konfirmasi; izin penyimpanan pada Android.
- **Ketergantungan:** Membutuhkan dependensi baru (`file_picker`/`path_provider`/`share_plus`) yang belum tersedia; perlu uji coba pada perangkat Android.

## 17. Keputusan dan Hal yang Belum Ditentukan

- **Keputusan yang sudah disetujui:** Belum ada (Draft).
- **Rekomendasi yang belum disetujui:** Format JSON sebagai format utama; ekspor juga menyediakan CSV opsional; restore bersifat replace (timpa data lama) dengan konfirmasi.
- **Asumsi yang belum diverifikasi:** Ketersediaan dan perilaku `file_picker`/`path_provider` pada Android; kebutuhan izin penyimpanan pada Android 13+.
- **Pertanyaan yang memerlukan keputusan pengguna:** Format berkas utama (JSON vs CSV); lokasi penyimpanan default; apakah restore menimpa atau menggabungkan data; apakah pencadangan cloud diperlukan pada tahap awal.

## 18. Riwayat Perubahan PRD

- 2026-11-08: Draft awal dibuat berdasarkan diskusi entri `refrensi_apk.md:L36-L46`.
- 2026-11-08: Diperbarui: Pengaturan hanya menavigasi ke layar khusus cadangan; tombol aksi berada di `CadanganScreen`.

