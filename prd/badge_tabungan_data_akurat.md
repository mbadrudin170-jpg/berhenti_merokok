# PRD: Badge dan Tabungan — Dasarkan pada Data yang Akurat

> Status: FINAL (disepakati 10 November 2026). Menunggu implementasi.
> Sumber rekomendasi: `refrensi_apk.md` baris 179–185 (bagian **B. Rekomendasi Optimasi Fitur yang Sudah Ada → Prioritas Tinggi → 6. Badge dan Tabungan — Dasarkan pada Data yang Akurat**).
> Skill/rules yang relevan: `.agents/rules/global/format_task.md` (format dokumen), skill `ekstraksi-perhitungan-turunan`, `visualisasi-progres-impian`, `riverpod-pola`, `penanganan-asyncvalue-berkali`, `model-state-freezed-abstract`, `gaya`, `penamaan-konvensi`.
> Dependensi: PRD `prd/satukan_perhitungan_baseline_aktual.md` (B.1) mendefinisikan helper bersama `MetrikBerhentiHelper` dan metrik `rokokDihindariAktual`, `uangDihematAktual`, `streakHariIni`. Badge dan Tabungan **wajib** mengonsumsi helper tersebut agar tidak ada duplikasi perhitungan.

## MASALAH

1. **Badge hanya menggunakan metrik baseline (estimasi)** — `BadgeScreen` dan `badge_helper.dart` membaca `hariBerhenti`, `rokokTidakDiHisap`, `uangDihemat` dari ekstensi `BiodataModelPerhitungan` (`biodata_model.dart:95-119`). Angka-angka ini dihitung **hanya dari biodata** (`jumlahRokokPerHari × hariBerhenti`), **tanpa** membaca log konsumsi aktual. Pengguna yang mencatat konsumsi (tapering/slip) mendapat badge yang tidak mencerminkan usaha aktual.

2. **Tabungan/saldo impian hanya menampilkan estimasi baseline** — `ImpianScreen` dan `DetailImpianScreen` menggunakan `biodata.uangDihemat` sebagai "saldo terkumpul" (baris 155, 251-258 di `impian_screen.dart`). Ini adalah angka estimasi `jumlahRokokPerHari × hariBerhenti / batangPerBungkus × hargaRokokPerBungkus`, **bukan** uang yang sebenarnya tidak dibelanjakan berdasarkan catatan konsumsi harian.

3. **Tidak ada pembedaan label "estimasi" vs "dari catatan"** — UI tidak pernah menampilkan keterangan bahwa angka uang dihemat/rokok terhindar bersifat estimasi ketika tidak ada/mengandalkan log konsumsi lengkap. Ini melanggar prinsip kejujuran data (refrensi_apk.md:202: "Tunjukkan bahwa tabungan bersifat estimasi bila tidak benar-benar memindahkan uang").

4. **Tidak ada badge untuk konsistensi pencatatan, strategi craving, target tapering** — Rekomendasi `refrensi_apk.md:202` menyebutkan peluang: "tambahkan pencapaian untuk konsistensi pencatatan, strategi craving yang dicoba, atau target tapering yang tercapai". Saat ini badge hanya berbasis durasi (hari smoke-free), rokok terhindar (baseline), uang dihemat (baseline), dan jumlah impian tercapai.

5. **Risiko badge/progres hilang karena slip** — Meskipun `refrensi_apk.md:202` menyarankan "Jangan menghapus badge atau progres historis hanya karena slip", implementasi saat ini tidak eksplisit melindungi badge historis. Badge berbasis `hariBerhenti` (kumulatif) aman, tetapi badge berbasis `rokokTidakDiHisap`/`uangDihemat` (baseline) akan naik meski slip, sedangkan badge berbasis metrik aktual (bila diimplementasikan) berisih dihapus bila tidak ditangani dengan benar.

6. **Gamifikasi berpotensi mempermalukan** — Badge yang hanya naik/turun berdasarkan slip tanpa konteks bisa menciptakan tekanan negatif. Perlu desain yang menghargai usaha tanpa menghukum kegagalan.

## SOLUSI

### Prinsip umum

- **Satu sumber perhitungan**: Semua metrik turunan (badge, tabungan, streak, rata-rata) **wajib** mengonsumsi `MetrikBerhentiHelper` dari PRD B.1 (`lib/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart`). Tidak ada perhitungan inline di layar.
- **Dua kolom tampilan (baseline + aktual)**: Di Dashboard, Badge, Impian, dan Toxin, tampilkan **estimasi baseline** dan **aktual dari catatan** berdampingan dengan label eksplisit ("estimasi" vs "dari catatan").
- **Fallback graceful**: Bila belum ada catatan konsumsi sama sekali, gunakan baseline sebagai fallback dan beri label "estimasi (belum ada catatan)".
- **Badge historis tidak dihapus**: Badge yang sudah tercapai (berbasis baseline atau aktual) **tidak pernah dicoret/dihapus** karena slip. Progres kumulatif dihormati.
- **Label estimasi wajib**: Setiap angka uang dihemat/rokok terhindar yang bersumber dari baseline wajib diberi label "estimasi" di UI.
- **Tambah badge baru non-pemalukan**: Badge konsistensi pencatatan, strategi craving, target tapering dirancang sebagai **penghargaan usaha** (additif), bukan hukuman kegagalan.

### Definisi metrik yang dipakai (dari PRD B.1, disepakati 10 Nov 2026)

| Metrik | Definisi | Sumber data |
|---|---|---|
| `hariBerhenti` (baseline, kumulatif) | Hari sejak `tanggalMulaiBerhentiMerokok`, normalisasi tanggal, clamp ≥ 0 | biodata |
| `rokokTidakDiHisapEstimasi` | `jumlahRokokPerHari × hariBerhenti` (baseline), label estimasi | biodata |
| `rokokDihindariAktual` | `Σ max(0, targetRokokHariIni − konsumsiHariIni)` per hari yang punya catatan, pakai target tapering | konsumsi_rokok + biodata |
| `uangDihematEstimasi` | `rokokTidakDiHisapEstimasi / batangPerBungkus × hargaRokokPerBungkus` | biodata |
| `uangDihematAktual` | `rokokDihindariAktual / batangPerBungkus × hargaRokokPerBungkus` | konsumsi_rokok + biodata |
| `streakHariIni` | Hari kalender berturut-turut tanpa catatan konsumsi/slip sampai hari ini; slip mereset streak, progres kumulatif tidak direset | konsumsi_rokok |
| `targetRokokHariIni` | Mode tapering (sudah ada di `biodata_model.dart:128-141`) | biodata |
| `rataRataKonsumsi7/30Hari` | Rata-rata atas hari kalender 7/30 hari terakhir (hari tanpa catatan = 0), tampilkan "hari tercatat: n" | konsumsi_rokok |

**Aturan hari tanpa catatan:** Dikecualikan dari perhitungan aktual; aktual diberi label "berdasarkan n hari tercatat". Hari tanpa catatan **tidak** dianggap bukti bebas rokok.

### Fitur yang harus dibuat/diubah

#### Fitur 1: Badge mengonsumsi MetrikBerhentiHelper (baseline + aktual)

- Masalah yang diatasi: 1, 3, 5.
- Solusi: `badge_screen.dart` dan `badge_helper.dart` diganti untuk menerima parameter dari `MetrikBerhentiHelper` (PRD B.1).
  - Badge berbasis **durasi smoke-free** (`hariBerhenti`) → tetap pakai baseline (kumulatif, tidak direset slip).
  - Badge berbasis **rokok terhindar** → pakai **aktual (`rokokDihindariAktual`) bila ada catatan konsumsi**, fallback ke baseline (`rokokTidakDiHisapEstimasi`). Label di UI: "dari catatan" vs "estimasi".
  - Badge berbasis **uang dihemat** → pakai **aktual (`uangDihematAktual`) bila ada catatan**, fallback ke baseline (`uangDihematEstimasi`). Label wajib.
  - Badge berbasis **impian tercapai** → tetap pakai logika sekarang (bandingkan `uangDihematAktual`/`Estimasi` dengan target impian).
  - **Badge historis tidak dihapus**: sekali `tercapai == true`, tetap `true` selamanya (tidak dihitung ulang setiap build). Simpan status tercapai ke local storage (SharedPreferences) atau hitung dari data historis yang tidak berubah.

Contoh potongan kode (ilustrasi, bukan final):

```dart
// lib/fitur/badge/helper/badge_helper.dart (diperbarui)
/// Menghitung daftar badge berdasarkan progres aktual + baseline.
List<BadgePencapaian> hitungBadge({
  required int hariSmokeFree,           // baseline (kumulatif)
  required int rokokDihindariAktual,    // dari catatan (bisa 0)
  required int rokokTidakDiHisapEstimasi, // baseline
  required double uangDihematAktual,    // dari catatan (bisa 0)
  required double uangDihematEstimasi,  // baseline
  required int impianTercapai,
  required int streakHariIni,           // dari catatan (reset saat slip)
  required int hariTercatat,            // jumlah hari yang punya catatan konsumsi
  required bool sedangTapering,
  required int targetRokokHariIni,
}) {
  final rokokUntukBadge = rokokDihindariAktual > 0 || hariTercatat > 0
      ? rokokDihindariAktual
      : rokokTidakDiHisapEstimasi;
  final uangUntukBadge = uangDihematAktual > 0 || hariTercatat > 0
      ? uangDihematAktual
      : uangDihematEstimasi;
  final labelRokok = rokokDihindariAktual > 0 || hariTercatat > 0
      ? 'dari catatan'
      : 'estimasi';
  final labelUang = uangDihematAktual > 0 || hariTercatat > 0
      ? 'dari catatan'
      : 'estimasi';

  final daftar = <BadgePencapaian>[
    // Badge durasi (baseline kumulatif, tidak direset slip)
    BadgePencapaian(id: 'smoke_1', nama: 'Langkah Pertama', deskripsi: 'Berhasil berhenti merokok selama 1 hari.', icon: CupertinoIcons.flame, tercapai: hariSmokeFree >= 1),
    // ... badge durasi lain sama ...

    // Badge rokok terhindar (pakai aktual/fallback baseline)
    BadgePencapaian(id: 'rokok_100', nama: '100 Batang Terhindar', deskripsi: 'Berhasil menghindari 100 batang rokok ($labelRokok).', icon: CupertinoIcons.nosign, tercapai: rokokUntukBadge >= 100),
    BadgePencapaian(id: 'rokok_500', nama: '500 Batang Terhindar', deskripsi: 'Berhasil menghindari 500 batang rokok ($labelRokok).', icon: CupertinoIcons.nosign, tercapai: rokokUntukBadge >= 500),
    BadgePencapaian(id: 'rokok_1000', nama: '1000 Batang Terhindar', deskripsi: 'Berhasil menghindari 1000 batang rokok ($labelRokok).', icon: CupertinoIcons.shield, tercapai: rokokUntukBadge >= 1000),

    // Badge uang dihemat (pakai aktual/fallback baseline, label wajib)
    BadgePencapaian(id: 'uang_100k', nama: 'Tabungan 100 Ribu', deskripsi: 'Berhasil menghemat Rp100.000 ($labelUang).', icon: CupertinoIcons.money_dollar, tercapai: uangUntukBadge >= 100000),
    // ... badge uang lain ...

    // Badge impian (pakai uangUntukBadge sebagai saldo)
    BadgePencapaian(id: 'impian_1', nama: 'Impian Pertama Tercapai', deskripsi: 'Berhasil mencapai 1 impian.', icon: CupertinoIcons.heart, tercapai: impianTercapai >= 1),
    // ... badge impian lain ...

    // BARU: Badge streak (dari catatan, reset saat slip)
    BadgePencapaian(id: 'streak_7', nama: 'Streak 7 Hari', deskripsi: '7 hari berturut-turut tanpa rokok (dari catatan).', icon: CupertinoIcons.flame_fill, tercapai: streakHariIni >= 7),
    BadgePencapaian(id: 'streak_30', nama: 'Streak 30 Hari', deskripsi: '30 hari berturut-turut tanpa rokok (dari catatan).', icon: CupertinoIcons.star_fill, tercapai: streakHariIni >= 30),

    // BARU: Badge konsistensi pencatatan
    BadgePencapaian(id: 'catat_7', nama: 'Pencatat 7 Hari', deskripsi: 'Mencatat konsumsi 7 hari berturut-turut.', icon: CupertinoIcons.doc_on_clipboard, tercapai: hariTercatat >= 7),
    BadgePencapaian(id: 'catat_30', nama: 'Pencatat 30 Hari', deskripsi: 'Mencatat konsumsi 30 hari berturut-turut.', icon: CupertinoIcons.doc_on_clipboard_fill, tercapai: hariTercatat >= 30),

    // BARU: Badge target tapering tercapai
    if (sedangTapering) ...[
      BadgePencapaian(id: 'tapering_1', nama: 'Target Minggu 1 Tercapai', deskripsi: 'Konsumsi hari ini ≤ target tapering minggu pertama.', icon: CupertinoIcons.arrow_down_circle, tercapai: _cekTaperingMinggu(1)),
      BadgePencapaian(id: 'tapering_4', nama: 'Target Minggu 4 Tercapai', deskripsi: 'Konsumsi hari ini ≤ target tapering minggu ke-4.', icon: CupertinoIcons.arrow_down_circle_fill, tercapai: _cekTaperingMinggu(4)),
    ],
  ];
  return daftar;
}
```

```dart
// lib/fitur/badge/screens/badge_screen.dart (diperbarui)
@override
Widget build(BuildContext context, WidgetRef ref) {
  final biodataAsync = ref.watch(biodataProvider);
  final konsumsiAsync = ref.watch(konsumsiRokokProvider);
  final impianAsync = ref.watch(impianProvider);

  // ... loading/error handling sama ...

  final biodata = biodataAsync.requireValue!;
  final konsumsiList = konsumsiAsync.asData?.value?.listKonsumsi ?? const <KonsumsiRokokModel>[];
  final impianState = impianAsync.requireValue;

  // Hitung metrik via helper bersama (PRD B.1)
  final metrik = MetrikBerhentiHelper.hitungSemua(biodata, konsumsiList);
  final hariTercatat = metrik.hariTercatat; // jumlah hari yang punya catatan
  final streakHariIni = metrik.streakHariIni;

  // Hitung impian tercapai pakai saldo aktual/estimasi
  final saldoUntukImpian = metrik.uangDihematAktual > 0 || hariTercatat > 0
      ? metrik.uangDihematAktual
      : metrik.uangDihematEstimasi;
  int impianTercapai = 0;
  for (final impian in impianState.listImpian) {
    if (saldoUntukImpian >= impian.jumlah) impianTercapai++;
  }

  final daftarBadge = hitungBadge(
    hariSmokeFree: metrik.hariBerhenti,
    rokokDihindariAktual: metrik.rokokDihindariAktual,
    rokokTidakDiHisapEstimasi: metrik.rokokTidakDiHisapEstimasi,
    uangDihematAktual: metrik.uangDihematAktual,
    uangDihematEstimasi: metrik.uangDihematEstimasi,
    impianTercapai: impianTercapai,
    streakHariIni: streakHariIni,
    hariTercatat: hariTercatat,
    sedangTapering: biodata.sedangTapering,
    targetRokokHariIni: biodata.targetRokokHariIni,
  );
  // ... render grid ...
}
```

#### Fitur 2: Impian/Tabungan menampilkan baseline vs aktual berdampingan

- Masalah yang diatasi: 2, 3.
- Solusi: `ImpianScreen`, `DetailImpianScreen`, dan `VisualTabunganImpian` diperbarui untuk menampilkan **dua angka saldo**: "Estimasi (baseline)" dan "Dari catatan (aktual)".
  - Saldo baseline: `uangDihematEstimasi` (dari biodata).
  - Saldo aktual: `uangDihematAktual` (dari helper B.1, hanya bila ada catatan konsumsi; jika tidak ada catatan sama sekali, tampilkan "—" atau 0 dengan label "belum ada catatan").
  - Progress impian (`VisualTabunganImpian`) dihitung dari **saldo aktual bila ada catatan**, fallback ke baseline. Rasio tetap clamp 0.0–1.0.
  - Label wajib: "estimasi" pada angka baseline, "dari catatan" pada angka aktual.
  - Tooltip/penjelasan singkat: "Estimasi berdasarkan kebiasaan harian. Angka dari catatan lebih akurat bila Anda mencatat konsumsi setiap hari."

Contoh potongan kode (ilustrasi):

```dart
// lib/fitur/impian/screens/impian_screen.dart (diperbarui)
@override
Widget build(BuildContext context, WidgetRef ref) {
  final biodataAsync = ref.watch(biodataProvider);
  final konsumsiAsync = ref.watch(konsumsiRokokProvider);
  final impianAsync = ref.watch(impianProvider);

  // ... loading/error ...

  final biodata = biodataAsync.requireValue!;
  final konsumsiList = konsumsiAsync.asData?.value?.listKonsumsi ?? const <KonsumsiRokokModel>[];
  final metrik = MetrikBerhentiHelper.hitungSemua(biodata, konsumsiList);

  final uangEstimasi = metrik.uangDihematEstimasi;
  final uangAktual = metrik.uangDihematAktual;
  final hariTercatat = metrik.hariTercatat;
  final pakaiAktual = hariTercatat > 0;

  // Saldo untuk progress impian: aktual bila ada catatan, fallback estimasi
  final saldoProgress = pakaiAktual ? uangAktual : uangEstimasi;

  // ... sort, filter, render ...

  // Di _buildSaldoTerkumpul: tampilkan kedua angka
  Widget _buildSaldoTerkumpul(double estimasi, double aktual, bool pakaiAktual) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                _SaldoItem(label: 'Estimasi', nilai: FormatUang.formatRupiah(estimasi), isEstimasi: true),
                if (pakaiAktual)
                  _SaldoItem(label: 'Dari catatan', nilai: FormatUang.formatRupiah(aktual), isEstimasi: false)
                else
                  _SaldoItem(label: 'Dari catatan', nilai: 'Belum ada catatan', isEstimasi: false),
              ],
            ),
            Text(
              pakaiAktual
                  ? 'Angka aktual berdasarkan $hariTercatat hari tercatat. Estimasi dari kebiasaan harian.'
                  : 'Belum ada catatan konsumsi. Tampilkan estimasi dari kebiasaan harian.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
```

#### Fitur 3: Dashboard menampilkan baseline vs aktual di kartu progres (sudah tercakup PRD B.1 Fitur 2)

- PRD B.1 sudah mensyaratkan Dashboard menampilkan `uangDihematEstimasi` dan `uangDihematAktual` berdampingan dengan label. PRD ini **tidak mengubah Dashboard** lagi, hanya memastikan konsistensi label "estimasi" / "dari catatan" di Badge dan Impian.

#### Fitur 4: Toxin memakai helper bersama (sudah tercakup PRD B.1 Fitur 4)

- PRD B.1 sudah mensyaratkan Toxin menampilkan `rokokTidakDiHisapEstimasi` dan `rokokDihindariAktual` berdampingan. PRD ini tidak mengubah Toxin.

#### Fitur 5: Penandaan badge historis (tidak hilang karena slip)

- Masalah yang diatasi: 5.
- Solusi: Simpan `Set<String> badgeTercapaiHistoris` di `SharedPreferences` (key: `badge_tercapai_historis`). Saat `hitungBadge` dijalankan, **gabungkan** badge yang tercapai saat ini dengan yang sudah tersimpan historis → hasilnya `tercapai = true` untuk yang pernah tercapai.
- Alternatif (lebih sederhana, tanpa storage tambahan): Badge berbasis **durasi kumulatif** (`hariBerhenti`) dan **impian** sudah aman (tidak turun). Badge berbasis **rokok/uang aktual** bisa turun bila slip, tetapi **wajib** diberi label "dari catatan" dan **tidak** dihapus dari daftar pencapaian pengguna — UI tetap menampilkan badge sebagai "tercapai" dengan catatan "pada tanggal X". Implementasi paling ringan: sekali `tercapai == true` di sesi, jangan set `false` lagi sampai restart aplikasi (atau simpan ke prefs).

> Keputusan implementasi diserahkan pada tahap coding, namun **wajib** memenuhi: badge yang pernah tercapai tidak hilang dari tampilan pencapaian pengguna.

#### Fitur 6: Badge baru — konsistensi pencatatan, streak, target tapering

- Masalah yang diatasi: 4.
- Solusi: Tambahkan badge baru (additif, tidak mengganti yang lama) di `badge_helper.dart`:
  1. **Streak** (berbasis `streakHariIni` dari helper B.1): 7, 30, 90 hari tanpa catatan konsumsi/slip. Reset saat slip — ini **by design** (streak memang reset), tapi badge streak yang sudah tercapai **tetap ditampilkan** sebagai pencapaian historis.
  2. **Konsistensi pencatatan** (`hariTercatat`): 7, 30, 90 hari berturut-turut mencatat konsumsi (tanpa hari kosong). Menghargai kebiasaan mencatat, bukan hasil bebas rokok.
  3. **Target tapering tercapai** (hanya jika `sedangTapering`): Minggu 1, 2, 3, 4 tercapai (konsumsi hari ini ≤ `targetRokokHariIni` minggu tersebut). Menggunakan logika tapering yang sudah ada di `biodata_model.dart:128-141`.

> Badge baru ini **penghargaan usaha**, bukan hukuman. Tidak ada badge "gagal", "slip", atau "kembali ke nol".

### Di luar scope (tidak dikerjakan di PRD ini)

- Unifikasi helper metrik (`metrik_berhenti_helper.dart`) → itu PRD B.1 (`prd/satukan_perhitungan_baseline_aktual.md`).
- Kalender smoke-free berbasis log → PRD terpisah (`prd/kalender_smoke_free_log_konsumsi.md`).
- Quick log +1, undo, koreksi entri konsumsi → `refrensi_apk.md:170-176` (B.4), PRD terpisah.
- Impian form/detail/visual widget struktur → tidak diubah, hanya sumber saldo dan label.
- Skema database / migrasi → tidak ada perubahan DB, semua metrik derived.
- Notifikasi/pengingat badge → PRD terpisah.

## FILE TERDAMPAK

| File | Perubahan | Status |
|---|---|---|
| `lib/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart` | **Baru (PRD B.1)** — helper murni `hitungSemua`, `hitungStreak`, `hitungRokokDihindariAktual`, `hitungUangDihematAktual/Estimasi`, `hitungRataRataKalender` | belum ada (PRD B.1) |
| `lib/fitur/badge/helper/badge_helper.dart` | Terima parameter dari `MetrikBerhentiHelper`; tambah badge streak, konsistensi pencatatan, target tapering; label estimasi/aktual; proteksi badge historis | ada, diubah |
| `lib/fitur/badge/screens/badge_screen.dart` | Watch `konsumsiRokokProvider`, hitung metrik via helper B.1, render badge dengan label | ada, diubah |
| `lib/fitur/impian/screens/impian_screen.dart` | Watch `konsumsiRokokProvider`, tampilkan saldo estimasi + aktual berdampingan, progress pakai aktual fallback estimasi, label wajib | ada, diubah |
| `lib/fitur/impian/screens/detail_impian_screen.dart` | Sama seperti `impian_screen.dart`: tampilkan dua saldo, label estimasi/aktual | ada, diubah |
| `lib/fitur/impian/widget/visual_tabungan_impian.dart` | Terima parameter `bool pakaiAktual` dan `String labelSaldo` untuk tooltip/aksesibilitas; warna progress tetap dari `ImpianProgresHelper.rasio(saldoProgress, target)` | ada, diubah minimal |
| `lib/fitur/impian/helper/impian_progres_helper.dart` | Tidak diubah (hanya dipakai dengan saldo yang benar) | tidak diubah |
| `prd/badge_tabungan_data_akurat.md` | File PRD ini | baru |

**Tidak terdampak (sengaja):** `lib/fitur/dashboard/**` (sudah PRD B.1), `lib/fitur/toxin_pelacakan/**` (sudah PRD B.1), `lib/fitur/kalender_smoke_free/**`, `lib/fitur/sos_craving/**`, `lib/fitur/diary_craving/**`, `lib/fitur/biodata/**` (hanya dibaca), skema DB/migrasi, `pubspec.yaml`, `docs/PRD/*`.

**Tumpang tindih dengan PRD lain:**
- PRD B.1 (`prd/satukan_perhitungan_baseline_aktual.md`) **juga mengubah** `badge_screen.dart` dan `badge_helper.dart` untuk mengganti sumber data ke `MetrikBerhentiHelper`. PRD ini **melanjutkan** perubahan tersebut: setelah B.1 selesai, PRD ini menambah badge baru (streak, konsistensi, tapering), label estimasi/aktual, dan proteksi historis pada file yang sama.
- PRD B.1 menyatakan `lib/fitur/impian/**` **tidak terdampak** (baris 149), tetapi PRD ini **mengubah** `impian_screen.dart`, `detail_impian_screen.dart`, `visual_tabungan_impian.dart` untuk menampilkan dual saldo (estimasi + aktual). **Ini sengaja** — PRD B.1 fokus pada helper metrik, PRD ini fokus pada UI impian/tabungan yang mengkonsumsi helper tersebut.
- `docs/PRD/impian.md` (jika ada) menyentuh `impian_page.dart` — tidak ada file yang sama dengan tabel di atas.
- `docs/PRD/tabungan.md` (jika ada) menyentuh `lib/fitur/tabungan/**` — folder ini tidak ada di proyek.

**Urutan implementasi yang disarankan:**
1. **PRD B.1 dulu** — buat `MetrikBerhentiHelper`, ubah `badge_screen.dart` & `badge_helper.dart` ke helper baru, update Dashboard & Toxin.
2. **PRD ini (Badge & Tabungan) kedua** — pada file `badge_screen.dart` & `badge_helper.dart` yang sudah diubah B.1, tambahkan badge baru, label estimasi/aktual, proteksi historis; ubah `impian_screen.dart`, `detail_impian_screen.dart`, `visual_tabungan_impian.dart` untuk dual saldo.

## STATUS IMPLEMENTASI (dicek 10 Nov 2026)

- **Belum diimplementasikan.** Badge dan Impian masih memakai `BiodataModelPerhitungan` (baseline saja). Tidak ada `MetrikBerhentiHelper` (PRD B.1). Tidak ada label "estimasi"/"dari catatan". Tidak ada badge streak/konsistensi/tapering. Badge historis tidak dilindungi eksplisit.

## REFERENSI APK (sudah dibaca 10 Nov 2026)

- [QuitSave — Google Play](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke) — savings tracker, "money saved" live, milestones, achievements.
- [Quitchi — Google Play](https://play.google.com/store/apps/details?id=com.quitchi.app) — badges for days, money saved, cigarettes avoided; streak tracking; "achievements don't disappear if you slip".
- [Quitrise — Google Play](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise) — "cigarettes not smoked & money saved" split into estimated vs tracked; badges for consistency, craving resistance; no shame gamification.
- [RootedLife — Google Play](https://play.google.com/store/apps/details?id=com.neonbug.rootedlife) — milestones, savings goals, "your progress stays even after a slip"; daily logging streaks rewarded.
- `refrensi_apk.md` baris 202: pencapaian konsistensi pencatatan, strategi craving, target tapering; baris 202: label estimasi, jangan hapus badge historis, hindari gamifikasi memalukan.

## KEPUTUSAN YANG SUDAH DISEPAKATI (10 Nov 2026)

1. Badge berbasis rokok/uang: **aktual bila ada catatan, fallback baseline**; label wajib "dari catatan" / "estimasi".
2. Badge durasi (hari smoke-free): **tetap baseline kumulatif** (tidak direset slip).
3. Badge streak: **dari catatan (reset saat slip)**, tapi badge streak yang pernah tercapai **tetap ditampilkan** sebagai pencapaian historis (dengan label tanggal tercapai).
4. Badge baru: **streak (7/30/90), konsistensi pencatatan (7/30/90), target tapering (minggu 1-4)** — additif, non-pemalukan.
5. Impian/Tabungan: tampilkan **dua saldo berdampingan** (estimasi baseline + aktual dari catatan), progress pakai aktual fallback estimasi, label wajib.
6. Badge historis tidak dihapus: **simpan ke SharedPreferences `badge_tercapai_historis`** (persisten lintas sesi).
7. `MetrikBerhentiHelper` dari PRD B.1 **wajib** dipakai; tidak ada perhitungan inline di Badge/Impian.
8. Warna/status semantic: gunakan `ColorScheme` + `withValues(alpha:)` (skill `gaya`); status sukses hijau, error merah, warning kuning boleh hardcode.
9. **Badge target tapering**: tercapai jika `konsumsiHariIni <= targetRokokHariIni` pada minggu ke-N (berdasarkan `tanggalMulaiTapering`).
10. **Badge strategi craving**: **di-defer** (belum ada tracking strategi di `diary_craving`; buat PRD terpisah jika diperlukan).
11. **Impian tanpa catatan**: progress pakai **estimasi baseline** + label "estimasi (belum ada catatan)"; jangan tampilkan 0%.

## CATATAN UNTUK IMPLEMENTASI

- Urutan implementasi yang disarankan: **PRD B.1 dulu** (buat `MetrikBerhentiHelper`), baru PRD ini (Badge & Impian konsumsi helper).
- Semua perhitungan turunan **wajib** melalui helper murni (skill `ekstraksi-perhitungan-turunan`).
- UI wajib menggunakan `Theme.of(context).colorScheme` dan `withValues(alpha:)` (skill `gaya`).
- Identifier bahasa Indonesia, file snake_case, class PascalCase, konstanta SCREAMING_SNAKE_CASE (skill `penamaan-konvensi`).
- AsyncValue handling: `isLoading` → `hasError` → `requireValue` / `asData?.value` (skill `riverpod-pola`, `penanganan-asyncvalue-berkali`).
- `unawaited` navigasi/toast wajib `.catchError((e,s) => L.e(...))` (skill `penanganan-error-unawaited`).
- Visual progress impian pakai `VisualTabunganImpian` (skill `visualisasi-progres-impian`).