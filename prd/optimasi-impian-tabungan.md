# PRD: Optimasi Impian (Goals/Tabungan)

## 1. Informasi Dokumen

- **Nama fitur:** Optimasi Impian (Goals/Tabungan) — visualisasi progres tabungan (piggy bank) dan perayaan saat impian tercapai.
- **Jenis pengembangan:** Pembaruan fitur (fitur inti impian sudah tersedia; peningkatan visual/motivasi belum).
- **Status implementasi:** Sebagian (CRUD impian, progress bar berbasis saldo terkumpul, empty state, dan detail sudah tersedia; visual piggy bank/reward belum).
- **Status PRD:** Dalam Diskusi (keputusan visual/posisi ikon dan perayaan notifikasi dicatat; detail/scope masih perlu konfirmasi).
- **Tanggal pembuatan/pembaruan:** 2026-11-08 (dibuat; diperbarui keputusan visual/posisi ikon).
- **Sumber referensi:** `refrensi_apk.md` (riset referensi APK sejenis, 2026-11-08), bagian B.2 dan C.3; halaman resmi Flamy dan Quit It di Google Play; `docs/PRD/impian.md` (PRD lama, konteks berbeda — tidak diubah oleh dokumen ini).

## 2. Tujuan Fitur

Tujuan utama optimasi ini adalah membantu pengguna *melihat* dan *merasakan* kemajuan tabungan dari uang yang dihemat karena tidak merokok, sehingga impian finansial terasa lebih konkret dan memotivasi pengguna tetap smoke-free.

## 3. Latar Belakang dan Permasalahan

Fitur Impian saat ini sudah menampilkan daftar impian, target jumlah, target tanggal, progress bar, sisa target, dan saldo terkumpul berbasis `uangDihemat` dari biodata. Namun:

1. Progres masih ditampilkan terutama sebagai progress bar linear; belum ada visualisasi tabungan yang kuat (mis. piggy bank) seperti pada referensi.
2. Belum ada perayaan/pesan apresiasi yang jelas saat saldo terkumpul mencapai target impian (reward moment).
3. `DetailImpianScreen` belum menampilkan progres, sisa, atau status tercapai; pengguna harus kembali ke daftar untuk melihat konteks progres.

Masalah pengguna: progres finansial terasa abstrak, sehingga motivasi untuk menjaga konsistensi berhenti merokok dapat menurun.

## 4. Target Pengguna

- Pengguna aplikasi Berhenti Merokok yang sudah mengisi biodata (sehingga `uangDihemat` dapat dihitung).
- Pengguna yang membuat impian/tujuan finansial dari uang hasil tidak merokok.
- Pengguna yang membutuhkan dorongan motivasi visual saat progres bertambah atau impian tercapai.

## 5. Manfaat Fitur

- **Manfaat utama:** Memperjelas progres menuju tujuan finansial dan meningkatkan motivasi berhenti merokok.
- **Manfaat tambahan:** Memberikan momen penghargaan saat impian tercapai; meningkatkan keterbacaan status impian pada daftar dan detail.
- **Dampak terhadap pengguna:** Pengguna lebih mudah memahami seberapa dekat impian tercapai tanpa menghitung manual.
- **Dampak terhadap aplikasi:** Memperkuat keterkaitan antara metrik smoke-free (`uangDihemat`) dan fitur impian yang sudah ada; tidak mengubah sumber kebenaran saldo.

## 6. Referensi Aplikasi

### 6.1 Aplikasi Pembanding (dari `refrensi_apk.md`)

- **Breev (Aura App Studio)** — Piggy bank visual dengan tema.
  - Link: https://play.google.com/store/apps/details?id=com.aura.stopsmoking
  - Status akses saat pemeriksaan (2026-11-08): halaman mengembalikan status non-2xx (404) saat diambil via `webfetch`; detail visual **belum terverifikasi** dari halaman langsung.
- **Flamy (Good to Me / Offlinefirst)** — Savings goals dengan item keinginan, money saved, dan visual progres/motivasi.
  - Link: https://play.google.com/store/apps/details?id=net.offlinefirst.flamy
  - Link situs: https://flamy.co/
- **Quit It (Antonis Evmorfopoulos)** — Savings goals dan rewards; milestone/motivasi personal.
  - Link: https://play.google.com/store/apps/details?id=com.quititapp
  - Link situs: https://quit-it-web.com/

### 6.2 Gambaran Tampilan (berdasarkan sumber yang dapat diperiksa)

- **Teramati (Flamy, deskripsi Play Store 2026-11-08):** Flamy menampilkan "money saved and personal savings goals", "achievements, streaks, and motivating statistics", serta personal motivation/rewards/goals. Deskripsi menegaskan pelacakan progres dan tujuan tabungan; detail tata letak piggy bank spesifik tidak terlihat dari teks deskripsi saja.
- **Teramati (Quit It, deskripsi Play Store 2026-11-08):** Quit It menampilkan "money saved", "Savings goals and rewards", "Shareable milestone cards", dan statistik/milestone. Ini mengonfirmasi pola *reward* dan *savings goal*.
- **Terkonfirmasi (ringkasan riset internal):** `refrensi_apk.md` merangkum pola piggy bank visual (Breev), savings goals dengan item keinginan (Flamy), dan savings goals dengan reward (Quit It).

### 6.3 Gambaran Cara Kerja (referensi)

- **Teramati/Terkonfirmasi:** Pengguna melihat uang yang dihemat dan tujuan tabungan; progres ditampilkan sebagai metrik/milestone/savings goal. Saat tujuan tercapai, aplikasi referensi memberi penguatan motivasi (reward/achievement/milestone).
- **Belum terverifikasi:** Implementasi internal (alokasi dana per goal, akun/cloud sync, logika reward server-side, bentuk visual piggy bank spesifik Breev) tidak dapat dibuktikan dari deskripsi publik.

### 6.4 Informasi yang Belum Terverifikasi

- Bentuk visual piggy bank Breev dan interaksinya (halaman Play Store tidak dapat diambil saat pemeriksaan).
- Screenshot/alur transisi animasi pada Flamy/Quit It/Breev.
- Apakah aplikasi referensi mengalokasikan tabungan per goal atau menggunakan total tabungan global; proyek saat ini menggunakan **saldo global** `uangDihemat` dari biodata.

## 7. Sumber Referensi Internal

- **Nama file:** `refrensi_apk.md`
- **Path:** `refrensi_apk.md`
- **Referensi B.2 (Optimasi Fitur — Impian):** `refrensi_apk.md:L192-L204`
  - Nama data: "2. Impian (Goals/Tabungan)"
  - Link aplikasi: https://play.google.com/store/apps/details?id=com.aura.stopsmoking ; https://play.google.com/store/apps/details?id=net.offlinefirst.flamy ; https://play.google.com/store/apps/details?id=com.quititapp
- **Referensi C.3 (UI/UX/Layout — Visualisasi Piggy Bank):** `refrensi_apk.md:L356-L368`
  - Nama data: "3. Visualisasi Tabungan (Piggy Bank)"
  - Link aplikasi: https://play.google.com/store/apps/details?id=com.aura.stopsmoking ; https://play.google.com/store/apps/details?id=com.quititapp

Rentang `L192-L204` mencakup judul, kondisi proyek, status implementasi, path implementasi, pembanding, implementasi referensi, peluang/saran optimasi, tujuan/manfaat, link, bukti, dan alasan prioritas. Rentang `L356-L368` mencakup pola UI/UX/layout piggy bank, kondisi proyek, saran, link, dan prioritas.

## 8. Kondisi Implementasi Saat Ini

### 8.1 Status Implementasi

**Sudah diimplementasikan sebagian.** Fitur inti Impian (CRUD data dasar, daftar, detail, form, state/notifier, sorting, progress berbasis saldo) sudah ada. Optimasi visual piggy bank dan reward/celebration belum ada.

### 8.2 Fungsi yang Sudah Tersedia (berdasarkan pemeriksaan kode)

- **Model impian:** `ImpianModel` (Freezed, `abstract class`) memiliki `id`, `nama`, `targetTanggal`, `dibuat`, `jumlah`; konversi SQLite via `fromSqflite`/`toSqflite` menggunakan `ParserUtil` dan UTC (`lib/fitur/impian/model/impian_model.dart:L1-L44`).
- **State/notifier:** `ImpianState` menyimpan `listImpian` dan `totalJumlah`; `ImpianNotifier` (`@Riverpod(keepAlive: true)`) melakukan load/tambah/ubah/hapus dengan logging `L`, update state setelah operasi DB berhasil, dan `rethrow` pada error (`lib/fitur/impian/state/*`, `lib/fitur/impian/notifier/impian_notifier.dart`).
- **Daftar impian:** menampilkan saldo terkumpul (`uangDihemat` dari `biodataProvider`), jumlah impian tercapai, sorting, progress bar per item, sisa, dan target; memiliki empty state dengan CTA dan FAB tambah (`lib/fitur/impian/screens/impian_screen.dart:L16-L297`).
- **Form impian:** validasi nama/jumlah, konfirmasi simpan (`adaptive_dialog`), loading `EasyLoading`, penanganan error, `mounted` check, input tanggal target (`lib/fitur/impian/screens/form_impian.dart:L12-L210`). Catatan: `targetTanggal` saat simpan default ke `DateTime.now()` jika belum dipilih (`form_impian.dart:L122`).
- **Detail impian:** menampilkan nama, jumlah, target tanggal, dibuat; ada aksi edit; menangani loading/error/data tidak ditemukan (`lib/fitur/impian/screens/detail_impian_screen.dart:L12-L124`).
- **Sumber saldo:** `BiodataModelPerhitungan.uangDihemat` dihitung dari biodata (normalisasi tanggal, guard pembagian nol) dan dipakai sebagai saldo global (`lib/fitur/biodata/model/biodata_model.dart:L90-L114`; konsumsi di `impian_screen.dart:L114-L124`).

### 8.3 Fungsi yang Belum Tersedia / Belum Sesuai

- Visualisasi piggy bank atau ilustrasi tabungan yang terisi sesuai progres.
- Pesan perayaan/penghargaan (reward moment) saat impian tercapai.
- Tampilan progres/sisa/status tercapai pada `DetailImpianScreen`.
- Indikator "tercapai" yang eksplisit pada item daftar (selain implisit dari progres/sisa).

### 8.4 Bukti Pemeriksaan (path)

- `lib/fitur/impian/screens/impian_screen.dart`
- `lib/fitur/impian/screens/form_impian.dart`
- `lib/fitur/impian/screens/detail_impian_screen.dart`
- `lib/fitur/impian/model/impian_model.dart`
- `lib/fitur/impian/state/impian_state.dart`
- `lib/fitur/impian/notifier/impian_notifier.dart`
- `lib/fitur/impian/enum/sort_impian.dart`
- `lib/fitur/biodata/model/biodata_model.dart` (ekstensi `uangDihemat`)

## 9. Ruang Lingkup

### 9.1 Termasuk (usulan, belum disetujui)

- Visualisasi progres tabungan pada fitur impian (daftar dan/atau detail) yang merepresentasikan `saldoTerkumpul / target` per impian, dengan pendekatan visual sederhana (mis. ilustrasi/ikon + fill/progress) yang konsisten dengan tema.
- Status impian tercapai yang jelas (badge/label/ikon) saat `uangDihemat >= jumlah`.
- Perayaan ringan saat impian tercapai (mis. dialog/snackbar/banner lokal yang tidak mengganggu), dengan aturan agar tidak muncul berulang tanpa kendali.
- Penambahan informasi progres pada `DetailImpianScreen` (progres, sisa, status tercapai) menggunakan data yang sudah tersedia.

### 9.2 Tidak Termasuk

- Implementasi kode pada command ini.
- Alokasi tabungan per impian (saldo saat ini global dari `uangDihemat`).
- Backend/cloud sync, akun, komunitas, atau AI coach.
- Widget home screen Android.
- Perubahan dependensi tanpa keputusan (contoh ilustrasi di bawah **tidak** menambah package).
- Perubahan PRD lain (`docs/PRD/impian.md` tetap tidak diubah).

## 10. Alur Penggunaan

### 10.1 Kondisi Awal

- Pengguna memiliki biodata dengan `uangDihemat` terhitung (atau 0 jika biodata/tanggal berhenti belum lengkap).
- Pengguna membuka layar Impian.

### 10.2 Alur Utama (daftar)

1. Pengguna membuka Impian.
2. Aplikasi memuat `impianProvider` dan `biodataProvider` (menangani loading/error sesuai pola saat ini).
3. Aplikasi menghitung `uangDihemat` sebagai saldo terkumpul global.
4. Setiap item impian menampilkan target, sisa, progres, dan visualisasi tabungan (usulan) yang mencerminkan `clamp(uangDihemat / jumlah, 0, 1)`.
5. Jika `uangDihemat >= jumlah`, item ditandai tercapai.

### 10.3 Alur Detail

1. Pengguna mengetuk item impian.
2. Detail menampilkan data impian dan ringkasan progres (usulan): saldo, progres, sisa, status tercapai.

### 10.4 Alur Perayaan (usulan, perlu keputusan)

1. Saat layar mendeteksi impian yang baru mencapai target, aplikasi menampilkan perayaan ringan.
2. Perayaan tidak boleh berulang setiap rebuild; perlu mekanisme penanda lokal (mis. SharedPreferences/flag per impian) — **keputusan teknis belum disepakati**.

### 10.5 Kondisi Khusus/Kegagalan

- Biodata loading/error: saldo diperlakukan 0 (pola saat ini tetap).
- `jumlah <= 0`: progres ditampilkan 0/aman (pola saat ini).
- Data impian tidak ditemukan di detail: tampilkan pesan "Impian tidak ditemukan" (pola saat ini).

## 11. Persyaratan Fungsional (usulan)

- **PF-1:** Layar Impian menampilkan visualisasi progres tabungan per item menggunakan komponen Flutter bawaan (tanpa Lottie/CSV/aset gambar baru kecuali disepakati), konsisten dengan `uangDihemat` global dan `item.jumlah`. Visual menggunakan `Stack` (ikon tabungan dilapis di area progres), bersifat inline, **bukan FAB/overlay melayang**.
- **PF-1a (usulan):** Ikon tabungan tampil konsisten (disarankan selalu tampil); state visual membedakan belum tercapai dan tercapai (mis. outlined/filled + warna tema).
- **PF-2:** Item impian menampilkan status "tercapai" secara jelas ketika `uangDihemat >= item.jumlah` dan `item.jumlah > 0`.
- **PF-3:** `DetailImpianScreen` menampilkan progres, sisa, dan status tercapai menggunakan sumber data yang sama dengan daftar (jika disetujui masuk ruang lingkup).
- **PF-4 (opsional, keputusan pengguna):** Saat impian tercapai, pengguna menerima perayaan ringan yang tidak mengganggu dan tidak berulang tanpa kontrol.
- **PF-5:** Optimasi tidak mengubah perhitungan `uangDihemat`/`hariBerhenti` di `BiodataModelPerhitungan`.
- **PF-6:** Semua perubahan UI mengikuti tema (`textTheme`/`colorScheme`), aksesibilitas, dan aturan padding/spacing proyek.

## 12. Persyaratan Nonfungsional (relevan)

- **Performa:** Visualisasi harus ringan; hindari komputasi berat di `build`; tidak memicu rebuild seluruh halaman tanpa kebutuhan.
- **Keandalan:** Perhitungan progres harus aman terhadap `jumlah == 0`, nilai negatif, dan biodata null.
- **Kegunaan:** Status tercapai/progres dapat dipahami tanpa teks ambigu; gunakan bahasa Indonesia formal.
- **Konsistensi:** Gunakan `Nav`, `L`, pola Riverpod (`isLoading`/`hasError`/`requireValue`), dan konstanta desain proyek.
- **Offline-first:** Tidak bergantung pada jaringan.

## 13. File yang Terdampak

### 13.1 File yang Sudah Menangani Fitur (Terbukti Terkait)

- `lib/fitur/impian/screens/impian_screen.dart` — daftar, saldo, progress bar, sorting, empty state.
- `lib/fitur/impian/screens/form_impian.dart` — tambah/ubah impian.
- `lib/fitur/impian/screens/detail_impian_screen.dart` — detail impian.
- `lib/fitur/impian/model/impian_model.dart` — model data impian.
- `lib/fitur/impian/state/impian_state.dart` — state daftar/total.
- `lib/fitur/impian/notifier/impian_notifier.dart` — CRUD SQLite.
- `lib/fitur/impian/enum/sort_impian.dart` — opsi urutan.
- `lib/fitur/biodata/model/biodata_model.dart` — `BiodataModelPerhitungan.uangDihemat` (sumber saldo).

### 13.2 File yang Mungkin Perlu Diubah (Diperkirakan Terdampak, usulan)

- `lib/fitur/impian/screens/impian_screen.dart` — menambah visual piggy bank/status tercapai pada item/saldo; potensi pemicu perayaan terkontrol.
- `lib/fitur/impian/screens/detail_impian_screen.dart` — menambah progres/sisa/status tercapai; mungkin perlu akses `biodataProvider`/parameter saldo.
- `lib/fitur/impian/screens/form_impian.dart` — hanya jika diputuskan ada field reward/hadiah (belum disepakati; saat ini **tidak** direkomendasikan sebagai langkah awal).

### 13.3 File Baru yang Mungkin Diperlukan (Belum Dapat Dipastikan)

- `lib/fitur/impian/widget/visual_tabungan_impian.dart` *(usulan nama/path; harus mengikuti pola aktual proyek)* — widget visual progres tabungan/piggy bank yang reusable di dalam fitur impian.
- `lib/fitur/impian/helper/impian_progres_helper.dart` *(usulan)* — helper murni untuk status tercapai/progres/sisa (menghindari duplikasi formula di daftar/detail).

**Catatan struktur:** Folder `widget/` atau `helper/` di dalam `lib/fitur/impian/` harus disesuaikan dengan `docs/struktur_rules.md` dan pola aktual proyek sebelum implementasi. Status: **Diperkirakan/Belum Dapat Dipastikan**.

## 14. Gambaran Teknis

Pendekatan usulan (tidak diimplementasikan): gunakan saldo global `uangDihemat` yang sudah ada, hitung progres per impian secara lokal (`item.jumlah`), tampilkan visual sederhana berbasis **komponen Flutter bawaan** (`Stack` + `ClipRRect`/`LinearProgressIndicator` + ikon `Icons.savings*`) tanpa Lottie, CSV, atau aset gambar baru kecuali disetujui, dan beri label "Tercapai" saat progres >= 1. Ikon bersifat **inline (di dalam kartu/item)**, **tidak melayang** sebagai FAB/overlay halaman (FAB tambah impian sudah ada di `impian_screen.dart`). **Keputusan (2026-11-08):** ikon **selalu tampil**; pembedaan state terutama pada **ikon** (`Icons.savings_outlined` saat belum tercapai → `Icons.savings` saat tercapai; dapat dipertegas warna `colorScheme`/label). **Posisi (keputusan):** (1) **item daftar** Impian (Stack di atas progress), (2) **halaman detail** Impian, (3) **kartu saldo terkumpul**. **Perayaan/feedback tercapai (keputusan, 2026-11-08):** cukup tampilkan **notifikasi (toast)** saat impian tercapai; gunakan utilitas proyek `AppToast` (bukan `Fluttertoast` langsung), jangan tampilkan berulang akibat rebuild/navigasi — mekanisme pencegahan duplikasi (mis. penanda lokal per impian) **perlu diputuskan saat implementasi**.

### Contoh 1 — Helper progres impian (ilustrasi)

**Path (usulan):** `lib/fitur/impian/helper/impian_progres_helper.dart`

```dart
// Ilustrasi saja — jangan disimpan/diterapkan dari command ini.
// Helper murni: tanpa BuildContext/provider.

class ImpianProgres {
  const ImpianProgres._();

  static double rasio(double saldo, double target) {
    if (target <= 0) return 0;
    return (saldo / target).clamp(0.0, 1.0);
  }

  static double sisa(double saldo, double target) {
    final nilai = target - saldo;
    return nilai < 0 ? 0 : nilai;
  }

  static bool tercapai(double saldo, double target) {
    if (target <= 0) return false;
    return saldo >= target;
  }
}
```

**Tujuan:** Menyatukan rumus progres/sisa/tercapai agar daftar dan detail tidak menduplikasi logika.
**Hubungan:** Dipakai oleh widget visual (Contoh 2) dan layar detail (Contoh 3).

### Contoh 2 — Visual tabungan dengan `Stack` (ikon dilapis, inline)

**Path (usulan):** `lib/fitur/impian/widget/visual_tabungan_impian.dart`

```dart
// Ilustrasi saja — jangan disimpan/diterapkan dari command ini.
// Komponen bawaan Flutter (tanpa Lottie/CSV/aset gambar baru).
// Ikon inline di dalam kartu/item; BUKAN FAB/overlay melayang.

import 'package:flutter/material.dart';

class VisualTabunganImpian extends StatelessWidget {
  const VisualTabunganImpian({
    super.key,
    required this.rasio,
    required this.tercapai,
  });

  final double rasio; // 0..1
  final bool tercapai;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final aman = rasio.clamp(0.0, 1.0);
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: aman,
              minHeight: 40,
              backgroundColor: cs.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                tercapai ? cs.primary : cs.secondary,
              ),
            ),
          ),
          Icon(
            tercapai ? Icons.savings : Icons.savings_outlined,
            color: tercapai ? cs.onPrimary : cs.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
```

**Tujuan:** Menampilkan ikon tabungan yang *dilapis* di atas progres (gaya piggy-bank/progres terisi) menggunakan `Stack`, tetap inline.
**Hubungan:** Menerima nilai dari `ImpianProgres.rasio/tercapai` (Contoh 1). Dipasang di item daftar (Contoh 4) dan/atau detail/saldo. Kontras warna ikon harus diuji pada tema terang/gelap.

### Contoh 3 — Penambahan progres pada detail (ilustrasi)

**Path:** `lib/fitur/impian/screens/detail_impian_screen.dart` *(file terbukti terkait; perubahan hanya usulan)*

```dart
// Ilustrasi potongan — jangan disimpan/diterapkan dari command ini.
// Detail dapat berubah ke ConsumerWidget/Stateful agar bisa membaca biodataProvider.
// Pastikan pola Riverpod (isLoading/hasError/requireValue) diikuti.

final biodataAsync = ref.watch(biodataProvider);
if (biodataAsync.isLoading) {
  return const Scaffold(body: Center(child: CircularProgressIndicator()));
}
if (biodataAsync.hasError) {
  // tampilkan error + tombol ref.refresh(biodataProvider)
}
final uangDihemat = biodataAsync.requireValue?.uangDihemat ?? 0.0;

final rasio = ImpianProgres.rasio(uangDihemat, impian.jumlah);
final sudahTercapai = ImpianProgres.tercapai(uangDihemat, impian.jumlah);
final sisa = ImpianProgres.sisa(uangDihemat, impian.jumlah);

// Usulan penempatan: blok visual (Stack, inline) di atas/bersama field detail.
VisualTabunganImpian(rasio: rasio, tercapai: sudahTercapai);
_buildItem(context, 'Status', sudahTercapai ? 'Tercapai' : 'Belum tercapai');
_buildItem(context, 'Progres', '${(rasio * 100).toStringAsFixed(0)}%');
_buildItem(context, 'Sisa', FormatUang.formatRupiah(sisa));
```

**Tujuan:** Menjadikan detail impian informatif tanpa harus kembali ke daftar.
**Hubungan:** Menggunakan `ImpianProgres` (Contoh 1), `VisualTabunganImpian` (Contoh 2), dan sumber saldo `uangDihemat` yang sama dengan daftar. Notifikasi/celebration (jika disetujui) **tidak** ditambahkan di sini.

### Contoh 4 — Posisi visual di daftar impian (ilustrasi, inline)

**Path:** `lib/fitur/impian/screens/impian_screen.dart` *(file terbukti terkait; perubahan hanya usulan)*

```dart
// Ilustrasi potongan — jangan disimpan/diterapkan dari command ini.
// Mengganti/menyertai LinearProgressIndicator pada subtitle item (sekitar L201-L209).
// Ikon TIDAK melayang: berada di dalam Stack kartu item. FAB tambah (L241-L244) tetap.

final rasio = ImpianProgres.rasio(uangDihemat, item.jumlah);
final sudahTercapai = ImpianProgres.tercapai(uangDihemat, item.jumlah);

ListTile(
  key: ValueKey(item.id),
  title: Text(item.nama),
  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 4),
      VisualTabunganImpian(rasio: rasio, tercapai: sudahTercapai),
      const SizedBox(height: 4),
      if (sudahTercapai) const Text('Tercapai'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'Sisa: ${FormatUang.formatRupiah(ImpianProgres.sisa(uangDihemat, item.jumlah))}',
            ),
          ),
          Flexible(
            child: Text(
              'Target: ${FormatUang.formatRupiah(item.jumlah)}',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    ],
  ),
);
```

**Tujuan:** Menunjukkan posisi visual tabungan per item (Stack/ikon dilapis di area progres) tanpa FAB/overlay.
**Hubungan:** Memakai `ImpianProgres` (Contoh 1) dan `VisualTabunganImpian` (Contoh 2). Saldo tetap `uangDihemat` global dari `biodataProvider` (pola existing `impian_screen.dart`).

### Contoh 5 — Posisi ikon pada kartu saldo terkumpul (ilustrasi, opsional)

**Path:** `lib/fitur/impian/screens/impian_screen.dart` *(file terbukti terkait; `_buildSaldoTerkumpul` sekitar L248-L265; perubahan hanya usulan)*

```dart
// Ilustrasi potongan — ikon inline di header saldo, bukan melayang.
Widget _buildSaldoTerkumpul(double saldoTerkumpul) {
  L.i('saldoTerkumpul=$saldoTerkumpul');
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.savings_outlined),
          const SizedBox(width: 8),
          Column(
            children: [
              const Text('Saldo terkumpul'),
              Text(
                FormatUang.formatRupiah(saldoTerkumpul),
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
```

**Tujuan:** Memberi konteks tabungan di header secara konsisten; ikon selalu tampil.
**Hubungan:** Melengkapi visual per item (Contoh 4). Tidak menggantikan FAB tambah.

## 15. Kriteria Penerimaan (usulan, dapat diperiksa saat implementasi)

- [ ] **PF-1:** Item daftar impian, halaman detail impian, dan kartu “Saldo terkumpul” menampilkan visual progres tabungan menggunakan komponen Flutter bawaan (tanpa Lottie/CSV/aset gambar baru kecuali disetujui), konsisten dengan `uangDihemat` global dan `item.jumlah`. Visual menggunakan `Stack` (ikon tabungan dilapis di area progres), inline, **bukan FAB/overlay melayang**. (Posisi opsi 3, 2026-11-08)
- [ ] **PF-1a:** Ikon tabungan **selalu tampil** (0–100%); state visual membedakan belum tercapai dan tercapai terutama pada **ikon** (`Icons.savings_outlined` → `Icons.savings`; warna `colorScheme`/label “Tercapai” dapat dipertegas). (2026-11-08)
- [ ] **PF-2:** Impian dengan `uangDihemat >= jumlah` (dan `jumlah > 0`) ditandai tercapai secara jelas.
- [ ] **PF-3:** `DetailImpianScreen` menampilkan progres, sisa, dan status tercapai menggunakan sumber data yang sama dengan daftar (selaras opsi 3).
- [ ] **PF-4 (opsional, keputusan pengguna):** Saat impian tercapai, pengguna menerima **notifikasi (toast)** via `AppToast` (cukup notif; bukan dialog/banner/animasi berat). Notifikasi tidak boleh berulang tanpa kontrol (mekanisme pencegahan duplikasi ditentukan saat implementasi). (2026-11-08)
- [ ] **PF-5:** Optimasi tidak mengubah perhitungan `uangDihemat`/`hariBerhenti` di `BiodataModelPerhitungan`.
- [ ] **PF-6:** Semua perubahan UI mengikuti tema (`textTheme`/`colorScheme`), aksesibilitas, dan aturan padding/spacing proyek.

## 16. Risiko dan Ketergantungan

- **Ketergantungan data:** Progres bergantung pada `biodataProvider`/`uangDihemat`; jika biodata belum lengkap, progres 0 dapat membingungkan — perlu pesan konteks yang jelas.
- **Semantik saldo:** Saldo saat ini global; beberapa pengguna mungkin mengira saldo dialokasikan per impian. Perubahan ke alokasi per impian adalah ruang lingkup berbeda dan berisiko.
- **Perayaan berulang:** Jika reward moment tidak dikendalikan, dapat muncul berulang pada rebuild/navigasi.
- **Aset visual:** Piggy bank bergaya ilustrasi/asset dapat menambah pekerjaan desain; pendekatan ikon/progress lebih aman untuk tahap awal.
- **PRD lama:** `docs/PRD/impian.md` berisi ruang lingkup berbeda (konteks kendaraan/tabungan harian). Dokumen ini tidak mengubahnya; implementasi harus menghindari mencampur asumsi.

## 17. Keputusan dan Hal yang Belum Ditentukan

### Keputusan yang Sudah Disetujui

- **Visual:** komponen Flutter bawaan, `Stack` inline (progress bar layer bawah, ikon tabungan layer atas/center), **bukan FAB/overlay melayang**, bukan Lottie/CSV/aset gambar baru kecuali disetujui kemudian (2026-11-08).
- **Visibilitas ikon:** ikon **selalu tampil** (0–100%).
- **Pembedaan state:** saat tercapai, bedakan **ikon** (`Icons.savings_outlined` → `Icons.savings`); warna `colorScheme`/label teks “Tercapai” dapat dipertegas saat implementasi (2026-11-08).
- **Posisi ikon:** opsi **3** — **item daftar Impian** (Stack di atas progress), **halaman detail Impian**, dan **kartu “Saldo terkumpul”** (inline) (2026-11-08).

- **Perayaan/feedback tercapai:** cukup **notifikasi (toast)** saat impian tercapai, menggunakan `AppToast` sesuai pola proyek; tidak menampilkan dialog/banner/animasi berat kecuali disetujui kemudian. Perlu mekanisme agar tidak muncul berulang tanpa kendali (2026-11-08).

### Rekomendasi yang Belum Disetujui

- Mulai dari visualisasi sederhana berbasis komponen Flutter bawaan (`Stack` + ikon + progress, tanpa Lottie/CSV/aset gambar baru) sebelum piggy bank ilustratif.
- Ikon **tidak melayang** (bukan FAB/overlay); posisikan inline di **item daftar (Stack di atas progress)**, opsional di **kartu saldo**, dan opsional di **detail** bila progres detail disetujui.
- Ikon disarankan **selalu tampil**; bedakan state tercapai/belum tercapai lewat ikon/warna/label.
- Tunda "reward/hadiah" kompleks; jika ada perayaan, gunakan mekanisme lokal yang idempotent.

### Asumsi yang Belum Diverifikasi

- Bentuk piggy bank Breev dan detail implementasi reward Flamy/Quit It.
- Kebutuhan pengguna terhadap perayaan (apakah dianggap membantu atau mengganggu).
- Kontras warna ikon yang dilapis di atas `LinearProgressIndicator` pada tema terang/gelap (perlu verifikasi visual saat implementasi).

1. ~~Perayaan saat impian tercapai~~ — **diputuskan (2026-11-08):** cukup tampilkan **notifikasi (toast)** via `AppToast`. Rincian: kapan dianggap “baru tercapai” dan pencegahan duplikasi (sekali per impian/sesi/penanda lokal) **perlu dirinci saat implementasi**.
2. Apakah `DetailImpianScreen` harus menampilkan progres/sisa/status tercapai pada pembaruan yang sama dengan penambahan ikon Stack (selaras opsi 3)?
3. Apakah ruang lingkup ini fokus pada optimasi impian berbasis `uangDihemat` global saat ini (tidak mengadopsi scope `docs/PRD/impian.md` kendaraan/tabungan harian)?

## 18. Riwayat Perubahan PRD

| Tanggal | Bagian | Alasan |
| --- | --- | --- |
| 2026-11-08 | Seluruh dokumen (awal) | Pembuatan PRD awal hasil diskusi referensi `refrensi_apk.md` B.2/C.3 dan pemeriksaan implementasi aktual fitur impian. |
| 2026-11-08 | §14 Gambaran Teknis, §11 PF, §17 | Menambahkan contoh kode ilustratif `Stack` inline (ikon tidak melayang), klarifikasi bukan Lottie/CSV/gambar, posisi ikon (item/saldo/detail), dan pertanyaan keputusan visibilitas/posisi. |
| 2026-11-08 | §1, §14, §17 | Mencatat keputusan pengguna: **opsi 3** (posisi item daftar + detail + kartu saldo), ikon **selalu tampil**, pembedaan state terutama pada **ikon** (`savings_outlined` → `savings`). |
