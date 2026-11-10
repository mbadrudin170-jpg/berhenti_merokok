# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Final

**Status Implementasi:** Belum Diimplementasikan (dicek 10 November 2026)

---

## 1. Informasi Produk

- Nama aplikasi: Berhenti Merokok
- Deskripsi produk: Aplikasi Flutter untuk membantu pengguna berhenti merokok — counter smoke-free, tapering, pencatatan konsumsi, diary craving, SOS Craving, kalender, badge, tabungan impian, pengingat, dan backup lokal.
- Platform: Android, iOS, Web, Desktop (Flutter multi-platform; data lokal via sqflite)
- Versi: mengikuti versi aplikasi saat ini di `pubspec.yaml`
- Status pengembangan: Aktif — fondasi utama sudah tersedia; fitur ini adalah optimasi lanjutan

## 2. Latar Belakang

SOS Craving pada aplikasi ini sudah menyediakan tiga intervensi: latihan napas 4-7-8, timer craving 3 menit, dan daftar distraksi. Namun **tidak ada riwayat permanen** mengenai intervensi mana yang dipilih pengguna, kapan dilakukan, dan apakah intervensi tersebut membantu meredakan dorongan merokok. Akibatnya, pengguna tidak bisa mengetahui teknik mana yang paling efektif untuk dirinya, dan aplikasi tidak bisa menyempurnakan dukungan berbasis data pribadi.

Sumber: `refrensi_apk.md:182-188` (bagian B.5 Prioritas Sedang), `refrensi_apk.md:40` (P2 — Simpan hasil intervensi SOS dan check-in singkat), `refrensi_apk.md:59` (tabel fitur yang sudah tersedia — SOS Craving), `refrensi_apk.md:499` (roadmap, butir 6: "Simpan hasil penggunaan SOS dan check-in singkat").

## 3. Tujuan Produk

- Mengetahui teknik intervensi SOS mana yang paling membantu pengguna secara pribadi.
- Menyempurnakan dukungan aplikasi berdasarkan data pribadi pengguna, bukan asumsi.
- Menjaga SOS tetap satu tindakan cepat — tidak ada form panjang saat craving.

## 4. Target Pengguna

Pengguna aplikasi Berhenti Merokok yang mengalami craving dan membuka SOS Craving. Kebutuhan: bantuan cepat yang tidak menambah beban kognitif saat dorongan sedang kuat, serta (opsional) kesempatan mencatat apakah intervensi berhasil. Masalah yang diselesaikan: intervensi yang dilakukan "hilang" begitu saja tanpa jejak, sehingga tidak ada pembelajaran personal.

## 5. Ruang Lingkup

### Termasuk

- Satu pertanyaan opsional setelah latihan selesai: "Apakah dorongan merokok berkurang?"
- Penyimpanan jenis intervensi, waktu, dan hasil ke database lokal.
- Opsi menautkan hasil intervensi ke pemicu diary craving (hanya bila pengguna setuju).

### Tidak Termasuk

- Menambah katalog aktivitas/distraksi baru.
- Mini-game, AI coach, artikel, atau konten edukasi (lihat `refrensi_apk.md:112-131`).
- Perubahan pada alur latihan napas 4-7-8, timer 3 menit, dan daftar distraksi itu sendiri.
- Notifikasi/pengingat adaptif berbasis hasil SOS.
- Perubahan pada layar Dashboard (kartu SOS tetap apa adanya).
- Ringkasan "teknik paling membantu" — Could Have, **ditunda ke versi berikutnya**.
- Intervensi di luar tiga tab yang ada (kartu alasan berhenti tidak dicatat).
- Pencatatan penyelesaian parsial seperti Jeda/Reset tanpa selesai — tidak dicatat.

## 6. Daftar Fitur

| Fitur | Deskripsi | Prioritas |
| ----- | --------- | --------- |
| Pertanyaan hasil pasca-intervensi | Satu pertanyaan opsional setelah latihan selesai | Must Have |
| Penyimpanan hasil intervensi | Jenis intervensi, waktu, hasil disimpan ke SQLite (selalu disimpan saat intervensi selesai) | Must Have |
| Tautan ke diary craving | Tautkan hasil intervensi ke entri diary hari ini bila pengguna setuju | Should Have |
| Ringkasan teknik paling membantu | Tampilkan teknik dengan hasil terbaik | Won't Have (v1) — ditunda ke versi berikutnya |

## 7. Detail Persyaratan Fitur

### Fitur 1 — Pertanyaan hasil pasca-intervensi

- Nama fitur: Pertanyaan hasil SOS
- Tujuan: Mengukur apakah intervensi membantu meredakan craving.
- Deskripsi: Setelah latihan (napas 4-7-8 selesai / timer 3 menit habis / pengguna menekan "Saya berhasil melewati craving" pada distraksi), tampilkan satu pertanyaan opsional: "Apakah dorongan merokok berkurang?"
- Data masukan: Pilihan pengguna (satu ketukan) atau lewati.
- Proses: Latihan selesai → tampilkan pertanyaan → simpan jawaban (atau lewati) → kembali ke layar SOS.
- Aturan bisnis:
  - Pertanyaan muncul sekali per penyelesaian intervensi, tidak setiap detik.
  - Pertanyaan bersifat opsional; menolak/melewati tidak menghalangi apa pun.
  - Tidak boleh meminta form panjang saat/selesai craving.
  - Ditampilkan sebagai **bottom sheet satu pertanyaan** ("Apakah dorongan merokok berkurang?") dengan 3 opsi: **Berkurang / Tetap / Belum selesai**, plus aksi **Lewati**.
- Validasi: Jawaban harus salah satu dari enum hasil (`berkurang`, `tetap`, `belum_selesai`), atau dilewati (`hasil_intervensi` = null).
- Kondisi berhasil: Jawaban tersimpan; toast/konfirmasi singkat.
- Kondisi gagal: Penyimpanan gagal → log `L.e`, tampilkan toast error, jangan crash, jangan blokir pengguna.
- Respons sistem: `AppToast.sukses` singkat; layar kembali ke tab SOS.
- Kriteria penerimaan: Setelah setiap jenis intervensi selesai, bottom sheet pertanyaan tampil; memilih jawaban menyimpan satu baris `sos_intervensi` dengan `hasil_intervensi` terisi; menekan Lewati tetap menyimpan satu baris dengan `hasil_intervensi` = null.

### Fitur 2 — Penyimpanan hasil intervensi

- Nama fitur: Riwayat intervensi SOS
- Tujuan: Riwayat permanen jenis intervensi, waktu, dan hasil.
- Deskripsi: Setiap penyelesaian intervensi (dengan/ tanpa jawaban pertanyaan) dicatat. Baris **selalu** disimpan saat intervensi selesai; `hasil_intervensi` = null bila pertanyaan dilewati.
- Data masukan: `jenisIntervensi` (enum: `napas_478`, `timer_3_menit`, `distraksi`), `detail` (nama aktivitas distraksi yang dipilih, nullable untuk tab lain), `hasil` (enum: `berkurang`, `tetap`, `belum_selesai`; opsional), `dibuat` (timestamp UTC).
- Proses: Insert baris baru ke tabel `sos_intervensi`.
- Aturan bisnis:
  - Waktu disimpan sebagai UTC (`toUtc().toIso8601String()`), konsisten dengan pola proyek.
  - Data lama tidak ada (tabel baru) — tidak perlu backfill.
  - Yang dicatat hanya penyelesaian tiga intervensi (napas 4-7-8, timer 3 menit, distraksi). Jeda/Reset tanpa selesai tidak dicatat. Kartu alasan berhenti tidak dicatat.
  - Untuk tab Distraksi, `detail` berisi nama aktivitas yang dipilih pengguna (mis. "Minum segelas air putih").
- Validasi: `jenisIntervensi` wajib valid enum; `dibuat` wajib.
- Kondisi berhasil: Baris tersimpan; dapat dibaca kembali.
- Kondisi gagal: Exception ditangkap, di-log, ditampilkan sebagai toast error.
- Respons sistem: Toast sukses/gagal.
- Kriteria penerimaan: Baris tersimpan dapat diverifikasi via query DB; jumlah baris bertambah satu per penyelesaian.

### Fitur 3 — Tautan ke diary craving

- Nama fitur: Tautan diary
- Tujuan: Menghubungkan intervensi dengan pemicu craving yang mendasarinya.
- Deskripsi: Bila pengguna setuju, hasil intervensi ditautkan ke entri diary craving **hari ini** (entri terbaru hari itu).
- Data masukan: Persetujuan pengguna + referensi entri diary hari ini.
- Proses: Setelah simpan hasil → bila ada entri diary hari ini, tawarkan "Tautkan ke catatan craving?" → bila ya, isi `diary_craving_id` pada baris `sos_intervensi` dengan entri diary hari ini yang terbaru.
- Aturan bisnis:
  - Tautan hanya bila pengguna setuju; tidak pernah otomatis.
  - Tawaran hanya muncul bila ada entri diary hari ini; bila kosong, opsi tidak ditampilkan.
  - `diary_craving_id` adalah **FK logis tanpa constraint** — entri diary yang dihapus tidak memblokir/menghapus riwayat SOS.
- Validasi: `diary_craving_id` harus merujuk entri yang ada.
- Kondisi berhasil: Tautan tersimpan.
- Kondisi gagal: Entri diary tidak ditemukan → simpan tanpa tautan, log `L.w`.
- Respons sistem: Toast konfirmasi.
- Kriteria penerimaan: Baris `sos_intervensi` memiliki `diary_craving_id` yang valid bila pengguna menyetujui.

### Fitur 4 — Ringkasan teknik paling membantu (Won't Have v1 — ditunda ke versi berikutnya)

- Nama fitur: Wawasan teknik SOS
- Tujuan: Menunjukkan teknik dengan tingkat keberhasilan tertinggi.
- Deskripsi: Hitung rasio hasil "berkurang" per `jenisIntervensi`; tampilkan bila data memadai (minimal 3 entri per teknik). **Ditunda ke versi berikutnya; tidak dikerjakan pada v1.**
- Data masukan: Agregasi tabel `sos_intervensi`.
- Proses: Query agregat → tampilkan kartu/teks ringkas di layar SOS.
- Aturan bisnis: Jangan tampilkan wawasan bila data < ambang; jangan menghakimi pengguna.
- Validasi: Guard pembagian nol; ambang minimal entri.
- Kondisi berhasil: Wawasan tampil akurat.
- Kondisi gagal: Data tidak memadai → sembunyikan wawasan (`SizedBox.shrink`).
- Respons sistem: Widget ringkasan informatif.
- Kriteria penerimaan: Wawasan hanya tampil bila ambang data terpenuhi.

## 8. Alur Pengguna

1. Pengguna membuka SOS Craving (dari Dashboard atau menu Lainnya).
2. Pengguna memilih tab: Napas 4-7-8 / Timer 3 Menit / Distraksi.
3. Pengguna menjalankan intervensi.
4. Intervensi selesai (napas: 4 siklus rampung; timer: 00:00; distraksi: tombol "Saya berhasil melewati craving").
5. Muncul bottom sheet satu pertanyaan opsional: "Apakah dorongan merokok berkurang?" — opsi: **Berkurang / Tetap / Belum selesai**, plus aksi "Lewati".
6. Baris `sos_intervensi` **selalu** disimpan saat intervensi selesai (dengan `hasil_intervensi` = null bila dilewati).
7. Bila ada entri diary hari ini, tawarkan "Tautkan ke catatan craving?" — bila pengguna setuju, `diary_craving_id` diisi dengan entri diary hari ini yang terbaru; pengguna boleh tolak.
8. Kembali ke layar SOS dengan toast singkat.

## 9. Persyaratan UI/UX

- Pertahankan prinsip dari referensi: **satu tindakan mulai yang mudah terlihat**, **opsi keluar/reset yang tidak membingungkan**, **jangan meminta form panjang saat craving** (`refrensi_apk.md:187`).
- Pertanyaan hasil tampil sebagai **bottom sheet satu pertanyaan** satu ketukan, bukan halaman form.
- Gunakan `AppToast` untuk umpan balik (konsisten dengan pola proyek).
- Warna dari `Theme.of(context).colorScheme`; opacity pakai `withValues(alpha:)`; spacing seragam via properti `spacing`.
- Wawasan "teknik paling membantu" di luar scope v1; bila dikerjakan di versi berikutnya, letakkan sebagai kartu ringkas di layar SOS (bukan Dashboard) dan sembunyikan bila data tidak memadai.

## 10. Ringkasan Kode Contoh Singkat

- Nama fitur: Penyimpanan hasil intervensi SOS
- Bahasa pemrograman: Dart (Flutter)
- Tujuan kode: Ilustrasi penyimpanan satu baris hasil intervensi setelah latihan selesai.

**Contoh kode:**

```dart
Future<void> simpanHasilIntervensi({
  required JenisIntervensiSos jenis,
  String? detail,
  HasilIntervensiSos? hasil, // null bila dilewati
  String? diaryCravingId,
}) async {
  final db = await SqfliteHelper.database;
  await db.insert(
    NamaTabel.sosIntervensi,
    {
      NamaKolom.id: const Uuid().v4(),
      NamaKolom.jenisIntervensi: jenis.name,
      NamaKolom.detail: detail,
      NamaKolom.hasilIntervensi: hasil?.name,
      NamaKolom.diaryCravingId: diaryCravingId,
      NamaKolom.dibuat: DateTime.now().toUtc().toIso8601String(),
    },
    conflictAlgorithm: ConflictAlgorithm.abort,
  );
}
```

**Penjelasan:**

Ilustrasi penyimpanan satu baris hasil intervensi ke tabel `sos_intervensi`. `hasil` nullable karena pertanyaan bersifat opsional. `diaryCravingId` nullable (FK logis tanpa constraint) karena tautan hanya bila pengguna setuju. Pola timestamp UTC konsisten dengan `DiaryCravingModel.toSqflite()`.

Contoh kedua — pertanyaan opsional pasca-intervensi:

```dart
Future<HasilIntervensiSos?> tanyaHasil(BuildContext context) {
  return showModalBottomSheet<HasilIntervensiSos>(
    context: context,
    builder: (_) => const _SheetHasilIntervensi(), // Berkurang / Tetap / Belum selesai / Lewati
  );
}
```

Catatan: Kode hanya sebagai ilustrasi, bukan ketentuan implementasi atau kode produksi.

## 11. Hak Akses Pengguna

| Jenis Pengguna | Hak Akses | Batasan |
| -------------- | --------- | ------- |
| Pengguna (pemilik data) | Membaca/menulis riwayat intervensi miliknya sendiri | Tidak ada akses lintas pengguna; data lokal di perangkat |
| Aplikasi | Insert/select tabel `sos_intervensi` | Tidak ada penghapusan otomatis data historis |

## 12. Persyaratan Data

- Jenis data: lokal (SQLite via sqflite), UUID string sebagai PK, timestamp ISO-8601 UTC.
- Data yang disimpan (tabel `sos_intervensi`):
  - `id` TEXT PRIMARY KEY
  - `jenis_intervensi` TEXT NOT NULL (enum: `napas_478`, `timer_3_menit`, `distraksi`)
  - `detail` TEXT (nullable — mis. nama aktivitas distraksi yang dipilih)
  - `hasil_intervensi` TEXT (nullable — enum: `berkurang`, `tetap`, `belum_selesai`; null bila pertanyaan dilewati)
  - `diary_craving_id` TEXT (nullable — FK logis ke `diary_craving.id`; hanya bila pengguna setuju)
  - `dibuat` TEXT NOT NULL (UTC ISO-8601)
- Hubungan antar-data: `sos_intervensi.diary_craving_id` → `diary_craving.id` (opsional, FK logis tanpa constraint — entri diary yang dihapus tidak memblokir/menghapus riwayat SOS).
- Aturan tambah/baca/ubah/hapus: insert-only untuk riwayat; tidak ada edit UI pada v1; hapus mengikuti backup/restore JSON yang sudah ada (kolom baru otomatis ikut — lihat catatan cadangan).
- Validasi dan integritas: enum divalidasi di lapisan Dart; `dibuat` selalu UTC.
- Sinkronisasi: tidak ada — data tetap lokal.

## 13. Persyaratan Nonfungsional

- Performa: penyimpanan satu baris, < 50 ms; tidak ada query agregat berat di jalur kritis craving.
- Keamanan: tidak ada data sensitif baru; jangan bocorkan isi catatan ke log (`L.i` hanya log metadata, bukan isi).
- Privasi: data craving bersifat pribadi dan tetap di perangkat; tidak dikirim ke jaringan.
- Keandalan: kegagalan simpan tidak boleh menggagalkan alur intervensi; exception ditangkap dan di-log.
- Kompatibilitas: sqflite di Android/iOS/desktop sesuai setup proyek; web via sqflite_common_ffi_web sudah ada.
- Skalabilitas: ratusan–ribuan baris per tahun; tidak perlu indeks khusus di v1 (pertimbangkan indeks `dibuat` bila query wawasan lambat).
- Kemudahan pemeliharaan: enum di file terpisah di `lib/fitur/sos_craving/enum/`, konstanta kolom di `nama_kolom.dart`, konstanta tabel di `nama_tabel.dart`.

## 14. Kriteria Penerimaan

1. Setiap penyelesaian intervensi SOS menawarkan satu pertanyaan opsional satu ketukan.
2. Melewati pertanyaan tetap menyimpan baris `sos_intervensi` dengan `hasil_intervensi` = null, dan tidak menghalangi pengguna.
3. Memilih jawaban menyimpan tepat satu baris `sos_intervensi` dengan `jenis_intervensi`, `dibuat` (UTC), dan `hasil_intervensi` yang benar.
4. Baris `sos_intervensi` selalu disimpan saat intervensi (napas/timer/distraksi) selesai, termasuk bila dilewati; Jeda/Reset tanpa selesai tidak menyimpan apa pun.
5. Tautan diary hanya tersimpan bila pengguna menyetujui dan entri diary tersedia.
6. Migrasi DB menaikkan `_versiDatabase` dengan benar dan tidak merusak data lama.
7. Backup/restore JSON tetap berfungsi; data `sos_intervensi` ikut ter-backup (verifikasi).
8. `flutter analyze` bersih; tidak ada file `.freezed.dart`/`.g.dart` yang diedit manual.

## 15. Prioritas Pengembangan

- Must Have: Pertanyaan hasil opsional + penyimpanan jenis/waktu/hasil.
- Should Have: Tautan ke diary craving.
- Could Have: Ringkasan teknik paling membantu — ditunda ke versi berikutnya (tidak termasuk v1).
- Won't Have: Mini-game, AI coach, konten edukasi, notifikasi adaptif, perubahan Dashboard, ringkasan wawasan pada v1.

## 16. Risiko dan Ketergantungan

- **Ketergantungan pada PRD Diary Craving** (`prd/diary_craving_strategi_durasi_hasil.md`): PRD tersebut berencana migrasi `_versiDatabase` 9 → 10 menambah kolom `durasiMenit`, `mood`, `strategi`, `hasil` pada tabel `diary_craving`. PRD ini memakai tabel baru `sos_intervensi` dengan migrasi `10 → 11`, **diterapkan setelah PRD Diary** (atau digabung menjadi satu migrasi bila keduanya dikerjakan bersamaan).
- **Overlap file:** `lib/shared/db/sqflite/sqflite.dart`, `lib/shared/konstanta/nama_kolom.dart`, `lib/shared/konstanta/nama_tabel.dart`, dan `lib/fitur/cadangan/helper/cadangan_helper.dart` (verifikasi) juga disentuh PRD Diary. Koordinasi urutan penerapan diperlukan.
- **Risiko semantik ganda:** bila `strategi`/`hasil` milik diary dipakai ulang untuk SOS, makna `hasil` bisa ambigu. Dimitigasi dengan tabel `sos_intervensi` terpisah.
- **Risiko UX:** pertanyaan setelah craving bisa terasa mengganggu; mitigasi: satu tap, opsi Lewati, tidak muncul bila pengguna baru saja melewati.
- **Asumsi:** data diary yang ada (sebelum PRD Diary diimplementasikan) tidak punya kolom `strategi`/`hasil`; tautan diary tetap valid karena hanya menyimpan referensi `id`.

## 17. Rencana Pengembangan

| Tahap | Fitur | Target |
| ----- | ----- | ------ |
| 1 | Migrasi DB + model + enum + notifier/repository `sos_intervensi` | v11 (setelah PRD Diary v10) |
| 2 | Pertanyaan hasil pasca-intervensi di ketiga tab SOS | v11 |
| 3 | Tautan ke diary (opsional) | v11 |
| 4 | Ringkasan teknik paling membantu (Could Have) | v12 / terpisah |

## 18. Ketentuan Tambahan

- Ikuti skill: `migrasi-skema-sqlite`, `penamaan-konstanta-snake-case`, `model-state-freezed-abstract`, `notifier-crud-database`, `penanganan-error-unawaited`, `gaya` (withValues), `spacing`, `tipografi`, `widget-custom` (bila membuat widget ringkasan), `logging-debug`, `validasi-platform-izin` (tidak relevan — tidak ada izin baru).
- Jangan mengubah kode Dart sebelum PRD final dan disetujui.
- File `.freezed.dart`/`.g.dart` hanya diregenerasi via `build_runner`.
- Pertanyaan hasil: teks persis — "Apakah dorongan merokok berkurang?"

## 19. Riwayat Perubahan

| Tanggal | Perubahan | Keterangan |
| ------- | --------- | ---------- |
| 10 Nov 2026 | Draft awal dibuat | Status: Draft, menunggu diskusi/keputusan |
| 10 Nov 2026 | Keputusan disepakati via diskusi; status → Final | Lihat bagian KEPUTUSAN YANG SUDAH DISEPAKATI |

## 20. File-File Terdampak

| Lokasi File | Status Perubahan | Deskripsi Perubahan |
| ----------- | ---------------- | ------------------- |
| `lib/shared/db/sqflite/sqflite.dart` | Diubah | `_versiDatabase` 10 → 11; blok `oldVersion < 11`; `_buatTabel` tambah `sos_intervensi` |
| `lib/shared/konstanta/nama_tabel.dart` | Diubah | Konstanta `sosIntervensi = 'sos_intervensi'` |
| `lib/shared/konstanta/nama_kolom.dart` | Diubah | Konstanta `jenisIntervensi`, `detail`, `hasilIntervensi`, `diaryCravingId` (snake_case) |
| `lib/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart` | Dibuat | Enum `napas_478`, `timer_3_menit`, `distraksi` |
| `lib/fitur/sos_craving/enum/hasil_intervensi_sos_enum.dart` | Dibuat | Enum `berkurang`, `tetap`, `belum_selesai` |
| `lib/fitur/sos_craving/model/sos_intervensi_model.dart` | Dibuat | Model Freezed + `fromSqflite`/`toSqflite` (UTC) |
| `lib/fitur/sos_craving/model/sos_intervensi_model.freezed.dart` | Dibuat (generate) | Regenerasi build_runner; jangan edit manual |
| `lib/fitur/sos_craving/notifier/sos_intervensi_notifier.dart` | Dibuat | CRUD insert + stream/list sederhana (keepAlive) |
| `lib/fitur/sos_craving/screens/sos_craving_screen.dart` | Diubah | Panggil pertanyaan hasil saat intervensi selesai di ketiga tab; tawaran tautan diary |
| `lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart` | Dibuat | Bottom sheet satu pertanyaan opsional |
| `lib/fitur/cadangan/helper/cadangan_helper.dart` | Diverifikasi, diubah bila perlu | Pastikan tabel baru ikut backup/restore JSON |
| `prd/sos_craving_simpan_hasil_intervensi.md` | Dibuat | File PRD ini |

**Tidak terdampak (sengaja):** `lib/fitur/diary_craving/**` (kecuali verifikasi FK logis), `lib/fitur/dashboard/**`, `lib/fitur/impian/**`, `lib/fitur/konsumsi_rokok/**`, `lib/fitur/kalender_smoke_free/**`, `pubspec.yaml` (tidak ada dependency baru).

**Tumpang tindih dengan PRD lain:** `sqflite.dart`, `nama_kolom.dart`, `nama_tabel.dart`, dan `cadangan_helper.dart` juga disentuh `prd/diary_craving_strategi_durasi_hasil.md` (v10). Mitigasi: PRD ini memakai v11 dan diterapkan setelah PRD Diary, atau digabung dalam satu migrasi bila dikerjakan bersamaan. `prd/satukan_perhitungan_baseline_aktual.md` dan `prd/kalender_smoke_free_log_konsumsi.md` tidak menyentuh file-file ini.

## 21. Referensi dari refrensi_apk.md

### 21.1 Referensi Fitur

> `refrensi_apk.md:182-188` (bagian B.5 — Prioritas Sedang):
>
> #### 5. SOS Craving — Simpan Hasil Intervensi
>
> - **Kondisi proyek:** Napas 4-7-8, timer tiga menit, dan distraksi sudah tersedia. Riwayat permanen mengenai intervensi yang dipilih dan apakah berhasil belum tampak pada model diary saat ini.
> - **Referensi:** [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [QUIT SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking), [Quit Smoking Now – Tracker](https://play.google.com/store/apps/details?id=com.mifasuse.quitsmokingnow), dan [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy).
> - **Peluang optimasi:** Setelah latihan selesai, tawarkan satu pertanyaan opsional: “Apakah dorongan merokok berkurang?” Simpan jenis intervensi, waktu, dan hasil; tautkan ke pemicu diary bila pengguna setuju.
> - **Saran:** Jangan meminta form panjang saat craving. Pertahankan satu tindakan mulai yang mudah terlihat dan sediakan opsi keluar/reset yang tidak membingungkan.
> - **Tujuan:** Mengetahui teknik apa yang paling membantu pengguna dan menyempurnakan dukungan berdasarkan data pribadi.

> `refrensi_apk.md:40` (P2 — urutan prioritas):
> **P2 — Simpan hasil intervensi SOS dan check-in singkat.** SOS sudah tersedia; nilai tambahnya adalah mengingat teknik yang dicoba dan apakah membantu, bukan menambah katalog aktivitas panjang. Check-in mood harian dapat bersifat opsional dan singkat. Referensi: [Quit Smoking Now – Tracker](https://play.google.com/store/apps/details?id=com.mifasuse.quitsmokingnow), [Qwit](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny), dan [Nonic](https://github.com/bllfoad/nonic).

> `refrensi_apk.md:59` (tabel fitur yang sudah tersedia):
> | SOS Craving | Kartu akses di Dashboard; layar memiliki napas 4-7-8, timer tiga menit, distraksi, serta pengingat alasan berhenti. | `lib/fitur/sos_craving/screens/sos_craving_screen.dart`; `lib/fitur/dashboard/screens/dashboard_screen.dart` | Optimalkan kecepatan akses dan pencatatan hasil strategi. Jangan membangun ulang SOS. |

> `refrensi_apk.md:499` (tabel roadmap, butir 6):
> | 6 | Simpan hasil penggunaan SOS dan check-in singkat | Optimasi/fitur baru | Mengetahui dukungan yang benar-benar membantu. | Model lokal dan form minimal. |

### 21.2 Referensi UI/UX

> `refrensi_apk.md:466` (pola dari QUIT Smoking SOS):
> | [QUIT Smoking SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking) | Menggabungkan beberapa teknik breathing, mini-game, artikel, dan coach di dalam ruang SOS. | Bantuan dapat dikelompokkan per jenis intervensi; pengguna tetap perlu dapat memulai teknik tanpa membaca katalog panjang. |

> `refrensi_apk.md:460` (pola dari H2M):
> | [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke) | Menawarkan timer, statistik, kalender, SOS, dan pilihan tema/widget. | Akses aksi utama melalui dashboard/shortcuts dan kelompokkan statistik berdasarkan tujuan. |

### 21.3 Referensi Alur Pengguna

- Alur selesai-intervensi → pertanyaan opsional satu tap → (opsional) tautan diary → kembali ke SOS; sejalan dengan pola "satu tindakan mulai yang mudah terlihat" (`refrensi_apk.md:187`).

### 21.4 Referensi Lainnya

Sorotan dari aplikasi referensi (dibaca 10 Nov 2026):

- **H2M** — "SOS Craving Relief: 3-Minute Timer … 4-7-8 Breathing … Craving Patterns: Understand when your cravings occur." Tidak ada pertanyaan hasil eksplisit; pola "craving patterns" relevan untuk wawasan (Could Have).
- **QUIT Smoking SOS** — "SOS mode turns a sudden urge into a short action plan"; banyak teknik (10 breathing, mini-games, artikel, AI coach). Referensi mendukung pengelompokan bantuan per jenis intervensi tanpa mewajibkan katalog panjang.
- **Quit Smoking Now – Tracker** — "One tap logs a craving and starts a 5-minute timer"; "Quick actions: drink a glass of water or write a note"; "See how many cravings you had today and over the past 7 days." Mendukung pencatatan ringan per-intervensi + agregasi sederhana.
- **Flamy** — "Log cravings and slips honestly. SOS support gives you quick access to breathing exercises, distractions, motivation, and practical coping strategies. Your entries can also help you recognize recurring situations and personal patterns." Mendukung penyimpanan hasil untuk pengenalan pola pribadi.

---

## KEPUTUSAN YANG SUDAH DISEPAKATI (10 Nov 2026)

1. **Penyimpanan:** tabel baru `sos_intervensi` (terpisah dari `diary_craving`).
2. **Opsi jawaban pertanyaan hasil:** `berkurang` / `tetap` / `belum_selesai` (3 nilai enum `HasilIntervensiSos`, selaras gaya `HasilCravingEnum` milik PRD Diary).
3. **Kapan baris disimpan:** selalu saat intervensi selesai; `hasil_intervensi` = null bila pertanyaan dilewati.
4. **Integritas tautan diary:** FK logis tanpa constraint (`diary_craving_id` hanya referensi; entri diary yang dihapus tidak memblokir/menghapus riwayat SOS).
5. **Nomor migrasi DB:** `_versiDatabase` `10 → 11`, diterapkan setelah PRD Diary (v10). Bila dikerjakan bersamaan, boleh digabung jadi satu migrasi.
6. **Wawasan "teknik paling membantu":** Could Have, **ditunda ke versi berikutnya**; di luar scope v1.
7. **Cakupan pencatatan:** hanya tiga intervensi yang ada — napas 4-7-8, timer 3 menit, distraksi. Kartu alasan berhenti tidak dicatat; Jeda/Reset tanpa selesai tidak dicatat.
8. **Bentuk pertanyaan:** bottom sheet satu pertanyaan ("Apakah dorongan merokok berkurang?") — 3 opsi + aksi Lewati.
9. **Detail distraksi:** `detail` menyimpan nama aktivitas yang dipilih pengguna (mis. "Minum segelas air putih").
10. **Alur tautan diary:** tawaran "Tautkan ke catatan craving?" hanya muncul bila ada entri diary hari ini; bila pengguna setuju, `diary_craving_id` diisi entri diary hari ini yang terbaru.

## CATATAN IMPLEMENTASI

- Kode Dart belum boleh diubah sampai implementasi fitur ini dimulai (di luar scope pembuatan PRD).
- Ikuti skill `migrasi-skema-sqlite`, `penamaan-konstanta-snake-case`, `model-state-freezed-abstract`, `notifier-crud-database`, `penanganan-error-unawaited`, `gaya`, `spacing`, `tipografi`, `logging-debug`.
- Regenerasi `.freezed.dart` via `build_runner`; jangan edit manual.
- Verifikasi `cadangan_helper.dart` mencakup tabel baru agar backup/restore JSON tetap lengkap.
