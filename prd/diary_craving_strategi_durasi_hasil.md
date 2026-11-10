# PRD: Diary Craving — Catat Strategi, Durasi, dan Hasil

> Status: FINAL (disepakati 10 November 2026). Menunggu implementasi.
> Sumber rekomendasi: `refrensi_apk.md` baris 162–168 (bagian **B. Rekomendasi Optimasi Fitur yang Sudah Ada → Prioritas Sedang → 3. Diary Craving — Catat Strategi, Durasi, dan Hasil**), lihat juga baris 38 (Ringkasan Temuan P1 no. 3) dan baris 60 (catatan "Diary Craving" pada inventaris proyek).
> Skill/rules yang relevan: `.agents/rules/global/format_task.md`, skill `migrasi-skema-sqlite` (wajib — PRD ini menambah kolom), `model-state-freezed-abstract`, `penamaan-konstanta-snake-case`, `ekstraksi-perhitungan-turunan`, `pola-ux`, `text-form-field-validasi`, `konfirmasi-sebelum-simpan`, `penanganan-error-unawaited`, `notifier-crud-database`.

## MASALAH

1. Model diary craving saat ini hanya menyimpan `tanggal`, `pemicu`, `intensitas` (1–5), `catatan` bebas, `dibuat` (`lib/fitur/diary_craving/model/diary_craving_model.dart:12-19`). Tidak ada **durasi craving**, **suasana hati**, **tindakan/strategi yang dicoba**, maupun **hasil**.
2. Analisis pola terbatas pada jam teratas setelah minimal tiga entri (`pola_craving_helper.dart:9-38`); tidak ada pola 7/30 hari, jam rawan, pemicu berulang, atau strategi yang paling sering membantu.
3. Pengguna tidak bisa melihat apakah strategi tertentu (mis. napas 4-7-8, minum air, jalan) efektif berdasarkan riwayat mereka sendiri.
4. Form utama berisiko menjadi panjang bila semua field ditambahkan sekaligus — harus tetap singkat dengan detail opsional.
5. Data lama (sebelum penambahan kolom) tidak boleh rusak dan backup yang sudah ada tetap kompatibel.

## SOLUSI

### Prinsip umum

- **Form utama tetap singkat**: pemicu, intensitas, tanggal/waktu, catatan — seperti sekarang. Detail tambahan (durasi, mood, strategi, hasil) bersifat **opsional** di section terpisah/expandable dan tidak wajib diisi.
- Pengguna boleh menyimpan tanpa menulis catatan panjang; semua field tambahan opsional.
- Insight hanya ditampilkan bila data memadai (minimal entri, sama seperti pola jam teratas: 3 entri, atau ambang lebih tinggi untuk strategi).
- Migrasi DB via `ALTER TABLE ... ADD COLUMN` (semua nullable), tanpa kehilangan data lama; versi DB naik dari 9 → 10 (skill `migrasi-skema-sqlite`).

### Skema data baru (usulan)

Kolom baru di tabel `diary_craving` (semua nullable / default aman):

| Kolom (snake_case) | Tipe | Deskripsi |
|---|---|---|
| `durasi_menit` | INTEGER | Durasi craving dalam menit (opsional, ≥ 0) |
| `mood` | TEXT | Suasana hati saat craving — enum baru `MoodCravingEnum`: `senang`, `netral`, `sedih`, `cemas`, `marah`, `stres` |
| `strategi` | TEXT | Strategi yang dicoba (**satu pilihan**) — enum baru `StrategiCravingEnum`: `napas_478`, `minum_air`, `jalan`, `alih_aktivitas`, `tunda_5_menit`, `lainnya` |
| `hasil` | TEXT | Hasil — enum baru `HasilCravingEnum` (3 nilai): `berhasil_menahan`, `tetap_merokok`, `belum_selesai` |

**Keputusan field:** `strategi` **satu pilihan** per entri (disimpan sebagai nama enum). Semua field tambahan opsional; entri lama bernilai null untuk kolom baru.

### Fitur yang harus dibuat/diubah

#### Fitur 1: Migrasi DB + model baru

- Masalah yang diatasi: 1, 5.
- Solusi: naikkan `_versiDatabase` ke 10 di `lib/shared/db/sqflite/sqflite.dart:19`; tambah blok `if (oldVersion < 10)` berisi empat `ALTER TABLE ${NamaTabel.diaryCraving} ADD COLUMN ...`. Update `onCreate` (`_buatTabel`) juga agar instalasi baru langsung punya kolom. Tambah konstanta kolom di `nama_kolom.dart` (snake_case: `durasiMenit`, `mood`, `strategi`, `hasil`). Update `DiaryCravingModel` (freezed): field baru opsional; `fromSqflite`/`toSqflite` dengan `parseIntOrNull`/`parseStringOrNull`/`safeParseEnum`. Jalankan `build_runner` untuk regenerasi `.freezed.dart` (jangan edit manual).
- Backup: `cadangan_helper.dart` mengoleksi seluruh tabel `diary_craving` apa adanya, jadi kolom baru otomatis ikut cadangan — diverifikasi, tidak perlu diubah.

Contoh potongan kode (ilustrasi):

```dart
if (oldVersion < 10) {
  await db.execute(
    'ALTER TABLE ${NamaTabel.diaryCraving} ADD COLUMN ${NamaKolom.durasiMenit} INTEGER',
  );
  await db.execute(
    'ALTER TABLE ${NamaTabel.diaryCraving} ADD COLUMN ${NamaKolom.mood} TEXT',
  );
  await db.execute(
    'ALTER TABLE ${NamaTabel.diaryCraving} ADD COLUMN ${NamaKolom.strategi} TEXT',
  );
  await db.execute(
    'ALTER TABLE ${NamaTabel.diaryCraving} ADD COLUMN ${NamaKolom.hasil} TEXT',
  );
}
```

```dart
const factory DiaryCravingModel({
  required String id,
  required DateTime tanggal,
  required PemicuEnum pemicu,
  @Default(3) int intensitas,
  String? catatan,
  int? durasiMenit,
  MoodCravingEnum? mood,
  StrategiCravingEnum? strategi,
  HasilCravingEnum? hasil,
  required DateTime dibuat,
}) = _DiaryCravingModel;
```

#### Fitur 2: Form diary tetap singkat, detail opsional di section "Detail tambahan"

- Masalah yang diatasi: 1, 4.
- Solusi: di `form_diary_craving.dart`, pertahankan field utama (pemicu, intensitas, tanggal, waktu, catatan). Tambah **`ExpansionTile` "Detail tambahan (opsional)"** di form yang sama berisi: durasi (menit, angka), mood (dropdown `MoodCravingEnum`), strategi (dropdown `StrategiCravingEnum`), hasil (dropdown `HasilCravingEnum`). Semua default kosong; simpan tetap berhasil tanpa mengisinya.

Contoh potongan kode (ilustrasi):

```dart
ExpansionTile(
  title: const Text('Detail tambahan (opsional)'),
  children: [
    InputDropdown<MoodCravingEnum?>(
      value: _mood,
      label: 'Suasana hati',
      items: const [null, ...MoodCravingEnum.values],
      displayString: (m) => m?.label ?? 'Tidak diisi',
      onChanged: (v) => setState(() => _mood = v),
    ),
    // durasi (InputTeks angka, wajib: false), strategi, hasil ...
  ],
),
```

#### Fitur 3: Insight pola 7/30 hari

- Masalah yang diatasi: 2, 3.
- Solusi: perluas `pola_craving_helper.dart` (atau tambah helper baru `wawasan_craving_helper.dart`) dengan method murni: `pola7Hari`, `pola30Hari`, `jamRawan` (sudah ada: `jamTeratas`), `pemicuBerulang(list, {minimumEntri})`, `strategiPalingMembantu(list)` (strategi dengan rasio `berhasil_menahan` tertinggi, **minimal 3 entri per strategi**), `rataRataIntensitas`. Semua guard list kosong & ambang minimum; tidak menulis DB.

Contoh potongan kode (ilustrasi):

```dart
/// Strategi dengan rasio berhasil tertinggi (minimal [minimumEntri] entri).
static StrategiCravingEnum? strategiPalingMembantu(
  List<DiaryCravingModel> list, {
  int minimumEntri = 3,
}) {
  final Map<StrategiCravingEnum, List<DiaryCravingModel>> grup = {};
  for (final c in list) {
    final s = c.strategi;
    if (s != null) grup.putIfAbsent(s, () => []).add(c);
  }
  StrategiCravingEnum? terbaik;
  var rasioTerbaik = -1.0;
  grup.forEach((s, entries) {
    if (entries.length < minimumEntri) return;
    final sukses = entries.where((e) => e.hasil == HasilCravingEnum.berhasilMenahan).length;
    final rasio = sukses / entries.length;
    if (rasio > rasioTerbaik) {
      rasioTerbaik = rasio;
      terbaik = s;
    }
  });
  return terbaik;
}
```

#### Fitur 4: Layar Diary — wawasan hanya di layar Diary

- Masalah yang diatasi: 2, 3.
- Solusi: di `diary_craving_screen.dart`, di bawah `_RingkasanPemicu` tambahkan `_RingkasanWawasan`: rata-rata intensitas 7/30 hari, jam rawan, dan (bila data cukup) strategi paling membantu. Tampilkan hanya bila entri ≥ ambang; jika belum cukup, tampilkan placeholder kecil "Catat minimal 3 craving untuk melihat wawasan". Item list menampilkan penanda mood/hasil bila terisi. **Dashboard tidak diubah** — wawasan hanya di layar Diary.

#### Fitur 5: Backup & konsistensi data lama

- Masalah yang diatasi: 5.
- Solusi: kolom baru ikut `toSqflite`/`fromSqflite` otomatis → ikut cadangan JSON. Entri lama bernilai null untuk kolom baru; UI menangani null dengan aman (jangan `requireValue`/`!`). Tidak ada backfill.

### Di luar scope (tidak dikerjakan di PRD ini)

- Undo/koreksi konsumsi harian → B.4 (`refrensi_apk.md:170-176`).
- SOS Craving menyimpan hasil intervensi → B.5 (`refrensi_apk.md:178-184`); PRD ini tidak menyentuh `sos_craving`.
- Kalender menandai hari craving → eksplisit ditolak di PRD kalender (`prd/kalender_smoke_free_log_konsumsi.md`).
- Badge konsistensi pencatatan → B.8 (`refrensi_apk.md:202-208`).

## FILE TERDAMPAK

| File | Perubahan | Status |
|---|---|---|
| `lib/shared/db/sqflite/sqflite.dart` | `_versiDatabase` 9 → 10; blok `oldVersion < 10`; update `_buatTabel` | ada, diubah |
| `lib/shared/konstanta/nama_kolom.dart` | Konstanta `durasiMenit`, `mood`, `strategi`, `hasil` (snake_case) | ada, diubah |
| `lib/fitur/diary_craving/model/diary_craving_model.dart` | Field baru opsional + konversi | ada, diubah |
| `lib/fitur/diary_craving/model/diary_craving_model.freezed.dart` | Regenerasi build_runner (jangan edit manual) | ada, di-generate |
| `lib/fitur/diary_craving/enum/mood_craving_enum.dart` | **Baru** (atau pakai enum mood yang sudah ada bila ada — cek dulu) | baru |
| `lib/fitur/diary_craving/enum/strategi_craving_enum.dart` | **Baru** | baru |
| `lib/fitur/diary_craving/enum/hasil_craving_enum.dart` | **Baru** | baru |
| `lib/fitur/diary_craving/screens/form_diary_craving.dart` | Section "Detail tambahan (opsional)" | ada, diubah |
| `lib/fitur/diary_craving/screens/diary_craving_screen.dart` | `_RingkasanWawasan` + tampilan mood/hasil di item | ada, diubah |
| `lib/fitur/diary_craving/helper/pola_craving_helper.dart` | Perluas wawasan 7/30 hari & strategi (atau helper baru) | ada, diubah/baru |
| `lib/fitur/diary_craving/notifier/diary_craving_notifier.dart` | Tidak diubah (CRUD generik) | tidak diubah |
| `lib/fitur/cadangan/helper/cadangan_helper.dart` | Tidak diubah (kolom baru otomatis ikut) | diverifikasi, tidak diubah |
| `prd/diary_craving_strategi_durasi_hasil.md` | File PRD ini | baru |

**Tidak terdampak (sengaja):** `lib/fitur/sos_craving/**`, `lib/fitur/konsumsi_rokok/**`, `lib/fitur/kalender_smoke_free/**`, `lib/fitur/impian/**`, `pubspec.yaml` (tidak ada dependency baru), `docs/PRD/*`.

**Tumpang tindih dengan PRD lain:** tidak ada. `prd/satukan_perhitungan_baseline_aktual.md` (B.1) tidak menyentuh diary; `prd/kalender_smoke_free_log_konsumsi.md` (B.2) eksplisit tidak membaca diary; `docs/PRD/*` tidak menyebut diary.

## STATUS IMPLEMENTASI (dicek 10 Nov 2026)

- **Belum diimplementasikan.** Model tidak punya durasi/mood/strategi/hasil; insight hanya `jamTeratas`; tidak ada migrasi v10. Sumber kebenaran: file-file di atas.

## REFERENSI APK (sudah dibaca 10 Nov 2026)

- [SmokingWeaner — Google Play](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20) — "Record craving intensity, duration, triggers, coping actions, and outcomes. Review 7-day, 30-day, and all-time craving summaries… Record which coping strategies helped."
- [Quit Smoking Go — Google Play](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) — "Log the craving you beat, and see how many you have beaten this week"; cravings menandai "resisted or smoked"; diary dengan lima mood dan angka harian.
- [TrackLess — GitHub](https://github.com/poorangryman/trackless-public) — "circadian pattern breakdown (Morning/Day/Evening/Night), and context triggers"; craving SOS sebagai tindakan koping.
- [Nonic — GitHub](https://github.com/bllfoad/nonic) — "Cravings log: record intensity, triggers, and strategies"; "one-per-day upserted storage" untuk check-in.
- `refrensi_apk.md` baris 166–167: durasi, suasana hati, tindakan yang dicoba, hasil sebagai data opsional; pola 7/30 hari, jam rawan, pemicu berulang, strategi paling sering membantu; form utama singkat; insight hanya bila data memadai.

## KEPUTUSAN YANG SUDAH DISEPAKATI (10 Nov 2026)

1. `strategi` **satu pilihan** per entri — enum `StrategiCravingEnum`: `napas_478`, `minum_air`, `jalan`, `alih_aktivitas`, `tunda_5_menit`, `lainnya`.
2. `mood` — enum baru `MoodCravingEnum`: `senang`, `netral`, `sedih`, `cemas`, `marah`, `stres` (proyek belum punya mood enum; dibuat baru).
3. `hasil` — enum baru `HasilCravingEnum`, **3 nilai**: `berhasil_menahan`, `tetap_merokok`, `belum_selesai`.
4. Detail opsional di form memakai **`ExpansionTile`** "Detail tambahan (opsional)" di form yang sama; form utama tetap singkat.
5. Ambang wawasan strategi: **minimal 3 entri per strategi**; jam rawan tetap 3 entri total.
6. Wawasan (rata-rata intensitas 7/30 hari, jam rawan, strategi paling membantu) ditampilkan **hanya di layar Diary**; dashboard tidak diubah.
7. Migrasi DB: `_versiDatabase` 9 → 10, semua kolom baru nullable via `ALTER TABLE ADD COLUMN`; entri lama tidak di-backfill; `cadangan_helper.dart` tidak diubah (kolom baru otomatis ikut).

## CATATAN IMPLEMENTASI

- Regenerate `diary_craving_model.freezed.dart` via `build_runner`; jangan edit file `.freezed.dart` manual.
- Ikuti skill `migrasi-skema-sqlite`: naikkan versi, update `onCreate` dan `onUpgrade` dengan kondisi `oldVersion < 10`, pakai konstanta `NamaKolom`/`NamaTabel`.
- Ikuti skill `penamaan-konstanta-snake-case` untuk nama kolom.
