# PRD: Hubungkan Kalender Smoke-Free dengan Log Konsumsi dan Penanda Slip

> Status: FINAL (disepakati 10 November 2026). Menunggu implementasi.
> Sumber rekomendasi: `refrensi_apk.md` baris 152–158 (bagian **B. Rekomendasi Optimasi Fitur yang Sudah Ada → Prioritas Tinggi → 2. Hubungkan Kalender Smoke-Free dengan Log Konsumsi dan Penanda Slip**).
> Skill/rules yang relevan: `.agents/rules/global/format_task.md` (format dokumen), skill `ekstraksi-perhitungan-turunan`, `normalisasi-tanggal`, `penanganan-asyncvalue-berkali`, `pola-ux`, `tipografi`, `gaya`.
> Dependensi: PRD `prd/satukan_perhitungan_baseline_aktual.md` (B.1) mendefinisikan `streakHariIni` dan helper bersama `metrik_berhenti_helper.dart`. Kalender memakai helper yang sama bila B.1 sudah diimplementasikan; bila belum, streak dihitung lokal sementara dan didelegasikan nanti.

## MASALAH

1. Kalender smoke-free (`lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart`) hanya membaca `biodata.tanggalMulaiBerhentiMerokok` dan menandai **semua** hari sejak tanggal itu sebagai hijau — tanpa membaca `konsumsiRokokProvider` sama sekali.
2. Model `KonsumsiRokokModel` sudah mendukung `isSlip` (`lib/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart:15`), tetapi slip **tidak tercermin** di kalender: hari slip tetap tampil hijau.
3. Tidak ada perbedaan status antara: hari terkonfirmasi bebas rokok, hari dengan catatan konsumsi/slip, hari tanpa catatan, dan hari dalam rencana tapering (target > 0).
4. Tidak ada pemisahan antara **streak sejak konsumsi/slip terakhir** dan **jumlah hari/progres kumulatif** — keduanya "Total hari smoke-free" yang sama (`kalender_smoke_free_screen.dart:123-125, 244-255`).
5. Mengetuk tanggal tidak menampilkan catatan yang mendasari statusnya.
6. Hari tanpa log diperlakukan sebagai bebas rokok, sehingga kalender menggambarkan riwayat yang terlalu optimis dan mendorong rasa tidak jujur terhadap data sendiri.

## SOLUSI

### Prinsip umum

- Kalender harus **jujur**: tidak pernah memberi status "bebas rokok" pada tanggal yang tidak punya catatan dan belum ada konfirmasi.
- Slip **tidak menghukum**: progres kumulatif (hari sejak tanggal berhenti) tetap ditampilkan terpisah dari streak.
- Ketukan pada tanggal menampilkan detail: jumlah batang tercatat, apakah slip, catatan, dan target tapering hari itu.

### Status kalender per tanggal (disepakati 10 Nov 2026)

| Status | Kondisi | Visual yang disepakati |
|---|---|---|
| `adaKonsumsi` | Ada catatan konsumsi `jumlah > 0` dan `isSlip == false` | kuning/oranye |
| `slip` | Ada catatan dengan `isSlip == true` di tanggal tersebut | merah (alpha 0.25) + angka batang slip |
| `tanpaCatatan` | Tidak ada catatan konsumsi sama sekali (tanggal ≤ hari ini dan ≥ tanggal berhenti) | netral (abu/putih) + teks penjelas |
| `tapering` | Mode tapering aktif dan `targetRokokHariIni > 0` (info tambahan, bukan pengganti status) | border/outline khusus |
| `belumMulai` | Tanggal sebelum tanggal berhenti | disabled (seperti sekarang) |
| `mendatang` | Tanggal setelah hari ini | disabled (seperti sekarang) |

**Tidak ada status "terkonfirmasi" tersendiri** — PRD ini hanya membaca log konsumsi yang ada; hari tanpa catatan selalu netral.

### Fitur yang harus dibuat/diubah

#### Fitur 1: Kalender membaca log konsumsi

- Masalah yang diatasi: 1, 2, 3.
- Solusi: `KalenderSmokeFreeScreen` menambahkan `ref.watch(konsumsiRokokProvider)`; gabungkan dengan biodata. Kelompokkan konsumsi per tanggal lokal (pakai `KonsumsiHitungHelper.ringkasanHarian` dari `lib/fitur/konsumsi_rokok/helper/konsumsi_hitung_helper.dart:12`), lalu petakan tiap sel ke status di tabel atas.

Contoh potongan kode (ilustrasi):

```dart
final konsumsiAsync = ref.watch(konsumsiRokokProvider);
// ... setelah biodata lolos null-check
final ringkasan = konsumsiAsync.asData?.value != null
    ? KonsumsiHitungHelper.ringkasanHarian(konsumsiAsync.requireValue)
    : const <String, int>{};
final slipDates = konsumsiAsync.asData?.value
        .where((m) => m.isSlip)
        .map((m) => _keyTanggal(m.tanggal))
        .toSet() ??
    {};

// di _SelHari:
final status = _statusTanggal(
  tanggal: tanggal,
  tanggalBerhenti: tanggalBerhentiDate,
  ringkasan: ringkasan,
  slipDates: slipDates,
  biodata: biodata,
);
```

```dart
enum StatusKalender {
  adaKonsumsi,
  slip,
  tanpaCatatan,
  belumMulai,
  mendatang,
}
```

#### Fitur 2: Ketuk tanggal → detail catatan

- Masalah yang diatasi: 5.
- Solusi: `_SelHari` dibungkus `InkWell`/`GestureDetector`; onTap membuka **bottom sheet** berisi: tanggal, status, daftar catatan konsumsi hari itu (jumlah, `isSlip`, catatan), target tapering hari itu bila mode tapering. Hanya untuk tanggal ≤ hari ini dan ≥ tanggal berhenti.

Contoh potongan kode (ilustrasi):

```dart
onTap: () => showModalBottomSheet<void>(
  context: context,
  builder: (_) => _DetailTanggal(
    tanggal: tanggal,
    catatanHariIni: listKonsumsiHariIni,
    targetTapering: biodata.targetRokokHariIni,
    modeTapering: biodata.sedangTapering,
  ),
);
```

#### Fitur 3: Ringkasan terpisah — streak vs progres kumulatif

- Masalah yang diatasi: 4.
- Solusi: `_RingkasanSmokeFree` menampilkan dua angka: **"Streak saat ini"** (hari kalender berturut-turut tanpa catatan konsumsi/slip sampai hari ini — definisi sama dengan B.1) dan **"Total hari sejak berhenti"** (kumulatif, seperti sekarang). Streak diambil dari `MetrikBerhentiHelper.hitungStreak` (helper B.1, `lib/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart`). Bila B.1 belum diimplementasikan, kalender menghitung streak lokal sementara dan wajib ditandai TODO untuk didelegasikan ke helper B.1 setelah tersedia.

#### Fitur 4: Legenda & warna sesuai status

- Masalah yang diatasi: 3, 6.
- Solusi: `_Legenda` diperbarui sesuai status baru: kuning/oranye = ada konsumsi, merah = slip, netral (abu/putih) = tanpa catatan, outline = tapering. Hijau tidak lagi dipakai untuk hari tanpa catatan. Warna semantic (merah/kuning) boleh hardcode sesuai skill `gaya`; warna netral dari `ColorScheme`.

#### Fitur 5: Kejujuran tanpa hukuman

- Masalah yang diatasi: 6.
- Solusi: teks bantuan kecil di bawah kalender, mis. "Hari tanpa catatan tidak dihitung sebagai bebas rokok. Catat konsumsi agar kalender akurat." Tidak ada reset/hukuman; progres kumulatif tidak pernah berkurang.

### Di luar scope (tidak dikerjakan di PRD ini)

- Quick log +1, undo, koreksi entri konsumsi → `refrensi_apk.md:170-176` (B.4), PRD terpisah.
- Unifikasi helper metrik (`metrik_berhenti_helper.dart`) → B.1, `prd/satukan_perhitungan_baseline_aktual.md`.
- Check-in harian "bebas rokok hari ini" — **tidak ditambahkan**; PRD ini hanya membaca log konsumsi yang ada.
- Kalender **tidak** menandai hari dengan catatan craving dari `diary_craving`; sumber data tetap konsumsi/slip saja.
- Impian, Badge, Toxin, Dashboard — tidak disentuh.

## FILE TERDAMPAK

| File | Perubahan | Status |
|---|---|---|
| `lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart` | Baca konsumsi, status per sel, bottom sheet detail, ringkasan streak vs kumulatif, legenda | ada, diubah |
| `lib/fitur/konsumsi_rokok/helper/konsumsi_hitung_helper.dart` | Dipakai apa adanya (`ringkasanHarian`, `konsumsiTanggal`); kemungkinan penambahan helper kecil `slipPadaTanggal` | ada, mungkin diubah minimal |
| `lib/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart` | Tidak diubah (dibaca via provider) | tidak diubah |
| `lib/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart` | Tidak diubah (`isSlip` sudah ada) | tidak diubah |
| `prd/satukan_perhitungan_baseline_aktual.md` | Tidak diubah; kalender mengonsumsi helper B.1 bila tersedia | referensi |
| `prd/kalender_smoke_free_log_konsumsi.md` | File PRD ini | baru |

**Tidak terdampak (sengaja):** `lib/fitur/impian/**`, `lib/fitur/badge/**`, `lib/fitur/dashboard/**`, `lib/fitur/biodata/**`, skema DB/migrasi, `pubspec.yaml`, `docs/PRD/*`.

**Tumpang tindih dengan PRD lain:** tidak ada. B.1 (`prd/satukan_perhitungan_baseline_aktual.md`) menyentuh `konsumsi_hitung_helper.dart` (rata-rata kalender) — perubahan B.2 di file itu terbatas pada penambahan helper kecil (atau tidak sama sekali bila memakai method yang ada); tidak mengubah kontrak `ringkasanHarian`. `docs/PRD/*` tidak menyentuh kalender.

## STATUS IMPLEMENTASI (dicek 10 Nov 2026)

- **Belum diimplementasikan.** Kalender hanya memakai `biodataProvider` (`kalender_smoke_free_screen.dart:71`); tidak ada `ref.watch(konsumsiRokokProvider)`; tidak ada status slip; ketuk tanggal tidak melakukan apa pun; ringkasan hanya "Total hari smoke-free" kumulatif.

## REFERENSI APK (sudah dibaca 10 Nov 2026)

- [Quit Smoking Go — Google Play](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) — "Smoking days, beaten cravings and diary pages together in one calendar", heat-map calendar; streak direset tapi progres & money saved tetap.
- [H2M Quit Smoking — Google Play](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke) — "Current streak / Longest record / Cumulative achievements", "Monthly and yearly calendar views", "Failure analysis with prevention tips"; menekankan kumulatif tidak hilang meski gagal.
- [NoMore — Google Play](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) — "A live clean-time counter… slip log you can undo… Streak, best record, total clean days", "A slip is information about your day, not a verdict on you", 30-day heatmap.
- [ClearStack SmokeFree](https://clearstackapps.com/apps/smokefree) — "Not smoked… minus every unit you have logged as a slip since the quit date. It is a net figure", slip tidak mereset quit clock; "a slip is just information… streak continues".
- `refrensi_apk.md` baris 156–157: bedakan hari terkonfirmasi bebas rokok / hari dengan catatan / hari tanpa catatan / hari tapering; pisahkan streak dari progres kumulatif; jangan otomatis status bebas rokok tanpa log; ketuk tanggal → tampilkan catatan.

## KEPUTUSAN YANG SUDAH DISEPAKATI (10 Nov 2026)

1. Hari tanpa catatan tampil **netral (abu/putih) + teks penjelas**; hijau tidak dipakai untuk hari tanpa catatan.
2. **Tidak** menambahkan tombol check-in "bebas rokok hari ini"; PRD hanya membaca log konsumsi yang ada.
3. Hari slip tampil **merah (alpha 0.25) + angka batang slip**.
4. Streak di kalender diambil dari **`MetrikBerhentiHelper.hitungStreak`** (PRD B.1); bila B.1 belum diimplementasikan, hitung lokal sementara + TODO untuk didelegasikan.
5. Ketuk tanggal membuka **bottom sheet** berisi tanggal, status, daftar catatan hari itu (jumlah/slip/catatan), dan target tapering bila mode tapering aktif.
6. Kalender **tidak** menandai hari dengan craving; craving tetap hanya di diary_craving.

## CATATAN DEPENDENSI

- PRD ini bergantung pada helper dari B.1 (`prd/satukan_perhitungan_baseline_aktual.md`) untuk streak. Urutan implementasi yang disarankan: **B.1 dulu, baru PRD ini**.
- PRD ini **tidak** mengubah `KonsumsiHitungHelper.ringkasanHarian`; hanya mengonsumsinya.
