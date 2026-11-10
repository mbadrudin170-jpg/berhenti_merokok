# PRD: Satukan Perhitungan Baseline, Konsumsi Aktual, Streak, dan Tabungan

> Status: FINAL (disepakati 10 November 2026). Menunggu implementasi.
> Sumber rekomendasi: `refrensi_apk.md` baris 142–148 (bagian **B. Rekomendasi Optimasi Fitur yang Sudah Ada → Prioritas Tinggi → 1. Satukan Perhitungan Baseline, Konsumsi Aktual, Streak, dan Tabungan**), lihat juga baris 36 (Ringkasan Temuan P1) dan baris 488 (bagian F, urutan 1).
> Skill/rules yang relevan: `.agents/rules/global/format_task.md` (format dokumen), skill `ekstraksi-perhitungan-turunan`, `normalisasi-tanggal`, `riverpod-pola`, `penanganan-asyncvalue-berkali`, `model-state-freezed-abstract`.

## MASALAH

1. Counter smoke-free (`hariBerhenti`), `rokokTidakDiHisap`, dan `uangDihemat` saat ini dihitung **hanya dari biodata** (`jumlahRokokPerHari` × `hariBerhenti`), tanpa membaca log konsumsi aktual (`lib/fitur/biodata/model/biodata_model.dart:95-142`).
2. Tidak ada pemisahan antara **baseline kebiasaan**, **target tapering**, **konsumsi tercatat**, **estimasi rokok yang dihindari**, dan **uang yang secara estimatif tidak dibelanjakan**. Semuanya diringkas menjadi satu angka "uang dihemat".
3. Tidak ada definisi **streak sejak konsumsi/slip terakhir** yang terpisah dari progres kumulatif.
4. Hari tanpa catatan konsumsi dianggap sama dengan hari bebas rokok; tidak ada label "estimasi" ketika data harian belum lengkap.
5. Angka yang sama dihitung ulang di banyak tempat (Dashboard, Impian, Badge, Toxin, Biodata) dengan asumsi yang sama, sehingga berisiko bertentangan antarhalaman.
6. `KonsumsiHitungHelper.rataRataHarian` (`lib/fitur/konsumsi_rokok/helper/konsumsi_hitung_helper.dart:32-40`) menghitung rata-rata dari **hari yang punya catatan saja** (`relevantKeys = keys.take(hari)`), bukan dari 7/30 hari kalender terakhir termasuk hari tanpa catatan.

## SOLUSI

### Prinsip umum

- Satu definisi per metrik, ditulis di **satu helper bersama**; halaman lain hanya mengonsumsi, tidak menghitung ulang.
- Semua metrik berbasis tanggal dinormalisasi ke komponen tanggal saja (skill `normalisasi-tanggal`), guard pembagian nol, clamp negatif ke nol.
- Metrik yang belum didukung data lengkap diberi label **"estimasi"** di UI dan dijelaskan asumsinya.
- Tidak menganggap tidak adanya log sebagai bukti pengguna tidak merokok.
- Tidak mengubah skema database (tidak ada migrasi); semua metrik dihitung (derived) dari data yang sudah ada.

### Definisi metrik (disepakati 10 Nov 2026)

| Metrik | Definisi yang disepakati | Sumber data |
|---|---|---|
| `hariBerhenti` (baseline, kumulatif) | Hari sejak `tanggalMulaiBerhentiMerokok`, dinormalisasi tanggal, clamp ≥ 0 | biodata (sudah ada, dipertahankan) |
| `rokokTidakDiHisapEstimasi` | `jumlahRokokPerHari × hariBerhenti` (baseline), diberi label estimasi | biodata |
| `rokokDihindariAktual` | `Σ max(0, targetRokokHariIni − konsumsiHariIni)` per **hari yang punya catatan**, memakai target tapering (`targetRokokHariIni`) sebagai pembanding | konsumsi_rokok + biodata |
| `uangDihematEstimasi` | `rokokTidakDiHisapEstimasi / batangPerBungkus × hargaRokokPerBungkus` (baseline) | biodata |
| `uangDihematAktual` | `rokokDihindariAktual / batangPerBungkus × hargaRokokPerBungkus` | konsumsi_rokok + biodata |
| `streakHariIni` | Hari kalender berturut-turut tanpa catatan konsumsi/slip sampai hari ini; **slip mereset streak**, progres kumulatif **tidak** direset | konsumsi_rokok |
| `targetRokokHariIni` | Mode tapering (sudah ada di `biodata_model.dart:128-141`); dipakai sebagai pembanding aktual | biodata |
| `rataRataKonsumsi7/30Hari` | Rata-rata atas **hari kalender** 7/30 hari terakhir (hari tanpa catatan dihitung 0); tampilkan juga "hari tercatat: n" | konsumsi_rokok |

**Aturan hari tanpa catatan:** hari kalender tanpa catatan **dikecualikan** dari perhitungan aktual; aktual diberi label "berdasarkan n hari tercatat". Hari tanpa catatan tidak dianggap bukti bebas rokok.
**Aturan tampilan uang dihemat:** angka **estimasi (baseline)** dan **aktual (dari catatan)** ditampilkan **berdampingan** di Dashboard, Badge, dan Toxin. Impian **tidak disentuh** (tetap memakai getter biodata, API dipertahankan).
**Lokasi helper:** `lib/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart`.

### Fitur yang harus dibuat/diubah

#### Fitur 1: Helper bersama metrik berhenti (satu sumber perhitungan)

- Masalah yang diatasi: 1, 2, 5.
- Solusi: buat helper murni `lib/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart` (lokasi disepakati, bukan `lib/shared/helper/`) dengan method statis: `hitungHariBerhenti`, `hitungRokokDihindariAktual`, `hitungUangDihemat(Aktual|Estimasi)`, `hitungStreak`, `hitungRataRataKalender(list, hari: 7|30)`. Ekstensi `BiodataModelPerhitungan` di `biodata_model.dart` dipertahankan untuk kompatibilitas, tetapi implementasinya didelegasikan ke helper atau ditandai jelas sebagai **baseline/estimasi**.

Contoh potongan kode (ilustrasi, bukan final):

```dart
/// Helper murni metrik berhenti. Tidak bergantung pada BuildContext/provider.
class MetrikBerhentiHelper {
  const MetrikBerhentiHelper._();

  /// Streak: hari kalender berturut-turut tanpa catatan konsumsi/slip sampai hari ini.
  static int hitungStreak(List<KonsumsiRokokModel> list) {
    // cari tanggal konsumsi/slip terakhir; slip ikut mereset streak
    DateTime? terakhir;
    for (final m in list) {
      final t = m.tanggal.toLocal();
      final d = DateTime(t.year, t.month, t.day);
      if (terakhir == null || d.isAfter(terakhir)) terakhir = d;
    }
    if (terakhir == null) return 0; // belum ada catatan: bukan bukti bebas rokok
    final now = DateTime.now();
    final hariIni = DateTime(now.year, now.month, now.day);
    final selisih = hariIni.difference(terakhir).inDays;
    return selisih < 0 ? 0 : selisih;
  }
}
```

```dart
/// Rata-rata atas hari kalender, bukan hanya hari yang punya catatan.
static double rataRataKalender(List<KonsumsiRokokModel> list, {int hari = 7}) {
  if (hari <= 0) return 0.0;
  final ringkasan = KonsumsiHitungHelper.ringkasanHarian(list);
  final now = DateTime.now();
  var total = 0;
  for (var i = 0; i < hari; i++) {
    final d = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
    final key = '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    total += ringkasan[key] ?? 0;
  }
  return total / hari;
}
```

#### Fitur 2: Dashboard menampilkan baseline vs aktual dengan label estimasi

- Masalah yang diatasi: 1, 2, 4.
- Solusi: di `dashboard_screen.dart`, kartu progres menampilkan `hariBerhenti` (baseline), `rokokDihindariAktual`/`uangDihematAktual` **bila ada catatan konsumsi**, selain angka estimasi baseline yang sudah ada; keduanya diberi label eksplisit ("estimasi" vs "dari catatan"). Dashboard sudah `ref.watch(konsumsiRokokProvider)` (dashboard_screen.dart:87), jadi tidak perlu provider baru.

Contoh potongan kode (ilustrasi):

```dart
final konsumsiAsync = ref.watch(konsumsiRokokProvider);
// ...
konsumsiAsync.when(
  loading: () => const Text('Menghitung dari catatan…'),
  error: (e, s) {
    L.e('konsumsi error: $e $s');
    return const Text('Estimasi (catatan belum tersedia)');
  },
  data: (list) {
    final aktual = MetrikBerhentiHelper.hitungUangDihematAktual(biodata, list);
    return Text('± ${FormatUang.formatRupiah(aktual)} (dari catatan)');
  },
);
```

#### Fitur 3: Badge memakai metrik aktual dengan fallback baseline

- Masalah yang diatasi: 5.
- Solusi: `badge_screen.dart:113-131` dan `badge_helper.dart` menerima parameter dari helper bersama. Badge berbasis hari smoke-free tetap baseline. Badge berbasis rokok/uang memakai **angka aktual bila ada catatan**; bila belum ada catatan, **fallback ke baseline**. Progres/badge historis tidak dihapus karena slip.

#### Fitur 4: Toxin & Biodata memakai angka yang sama

- Masalah yang diatasi: 5.
- Solusi: `toxin_pelacakan_screen.dart:86` memakai `rokokTidakDiHisap` — ganti sumber ke helper bersama; tampilkan estimasi (baseline) dan aktual (dari catatan) berdampingan, konsisten dengan Dashboard/Badge. `biodata_screen.dart` **tidak diubah**.

#### Fitur 5: Ringkasan konsumsi 7/30 hari berbasis kalender

- Masalah yang diatasi: 6.
- Solusi: perbaiki `KonsumsiHitungHelper.rataRataHarian` agar berbasis hari kalender (lihat potongan di Fitur 1), atau tambahkan method baru `rataRataKalender` dan pertahankan `rataRataHarian` lama bila masih dipakai di tempat lain (cek pemanggil dulu).

### Di luar scope (tidak dikerjakan di PRD ini)

- Kalender smoke-free berbasis log → itu `refrensi_apk.md:151-156` (B.2), PRD terpisah.
- Undo/koreksi konsumsi → `refrensi_apk.md:168-174` (B.4).
- Impian/tabungan: file `lib/fitur/impian/**` **tidak diedit**; impian tetap mengonsumsi getter biodata (API dipertahankan). Definisi saldo impian dibahas di PRD impian tersendiri (`docs/PRD/impian.md`).
- Badge baru berbasis konsistensi pencatatan → `refrensi_apk.md:202-208` (B.8).

## FILE TERDAMPAK

| File | Perubahan | Status |
|---|---|---|
| `lib/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart` | **Baru** — helper murni metrik bersama | belum ada |
| `lib/fitur/konsumsi_rokok/helper/konsumsi_hitung_helper.dart` | Tambah/perbaiki rata-rata berbasis hari kalender | ada, diubah |
| `lib/fitur/biodata/model/biodata_model.dart` | Delegasikan/tandai ekstensi sebagai baseline-estimasi | ada, diubah minimal |
| `lib/fitur/dashboard/screens/dashboard_screen.dart` | Tampilkan baseline vs aktual + label estimasi | ada, diubah |
| `lib/fitur/badge/screens/badge_screen.dart` | Sumber angka dari helper bersama | ada, diubah |
| `lib/fitur/badge/helper/badge_helper.dart` | Parameter/varian metrik aktual | ada, diubah |
| `lib/fitur/toxin_pelacakan/screens/toxin_pelacakan_screen.dart` | Sumber `rokokTidakDiHisap` dari helper bersama (baseline + aktual berdampingan) | ada, diubah |
| `prd/satukan_perhitungan_baseline_aktual.md` | File PRD ini | baru |

**Tidak terdampak (sengaja):** `lib/fitur/impian/**`, `lib/fitur/kalender_smoke_free/**`, `lib/fitur/sos_craving/**`, `lib/fitur/diary_craving/**`, `docs/PRD/*`, skema DB/migrasi, `pubspec.yaml`.

**Tumpang tindih dengan PRD lain:** tidak ada. `docs/PRD/impian.md` menyentuh `impian_page.dart` (estimasi impian), `docs/PRD/tabungan.md` menyentuh `lib/fitur/tabungan/**`, `docs/PRD/notifikasi.md` menyentuh pengaturan notifikasi — tidak ada file yang sama dengan tabel di atas.

## STATUS IMPLEMENTASI (dicek 10 Nov 2026)

- **Belum diimplementasikan.** Perhitungan masih murni baseline biodata (`biodata_model.dart:95-142`), tidak ada helper metrik aktual/streak bersama, `rataRataHarian` masih berbasis hari-yang-tercatat (`konsumsi_hitung_helper.dart:32-40`). Tidak ada perubahan DB yang diperlukan.

## REFERENSI APK (sudah dibaca 10 Nov 2026)

- [SmokingYou — GitHub](https://github.com/bodyaant/SmokingYou) — timer live, counter harian vs limit, tapering, savings tracker, "cigarettes not smoked & money saved, live"; mempertahankan progres kumulatif meski slip.
- [Smoking Tracker — GitHub](https://github.com/pintargasper/SmokingTracker) — statistik harian/mingguan/bulanan, consumption analytics, forecast, notes; angka "cigarettes avoided" dan cost tracking terpisah dari log mentah.
- [SmokingWeaner — Google Play](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20) — daily totals, averages, costs, 7/30-day craving summaries, charts untuk count/cost/spacing/estimated savings.
- [Quit Smoking Go — Google Play](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) — "If you smoke again, what you achieved stays… your streak starts over, but the days since you started, the money saved and the cigarettes not smoked all stay." Pemisahan streak vs progres kumulatif eksplisit.
- [My Tracking App — GitHub](https://github.com/lorenzocaputodev/my_tracking_app) — undo setelah setiap pencatatan, history grouped per hari/minggu/bulan; referensi pemisahan estimasi vs catatan.
- `refrensi_apk.md` baris 145: pemisahan baseline / target tapering / konsumsi tercatat / estimasi yang dihindari / uang tidak dibelanjakan; baris 147: satu helper bersama untuk Dashboard, Impian, Badge, kalender, dan ringkasan.

## KEPUTUSAN YANG SUDAH DISEPAKATI (10 Nov 2026)

1. `rokokDihindariAktual` memakai **target tapering** (`targetRokokHariIni − konsumsi`) sebagai pembanding, hanya untuk hari yang punya catatan.
2. Hari tanpa catatan **dikecualikan** dari aktual; tampilkan label "berdasarkan n hari tercatat".
3. Uang dihemat ditampilkan **berdampingan** (estimasi baseline + aktual dari catatan) di Dashboard, Badge, dan Toxin.
4. Helper bersama berada di `lib/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart`.
5. **Impian tidak disentuh** (`lib/fitur/impian/**` tetap memakai getter biodata; API dipertahankan).
6. **biodata_screen.dart tidak diubah.**
7. Badge berbasis rokok/uang memakai **aktual bila ada catatan, fallback baseline**; badge hari smoke-free tetap baseline; badge historis tidak dihapus karena slip.
8. Streak = hari kalender berturut-turut tanpa catatan konsumsi/slip sampai hari ini; **slip mereset streak**; progres kumulatif tidak direset.
