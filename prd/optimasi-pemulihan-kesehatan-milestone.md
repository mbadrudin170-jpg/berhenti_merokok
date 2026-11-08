# PRODUCT REQUIREMENTS DOCUMENT

## 1. Identitas Fitur

- **Nama fitur:** Optimasi Pemulihan Kesehatan (Milestone)
- **Jenis fitur:** Pembaruan fitur (penyempurnaan fitur yang sudah ada)
- **Status PRD:** Draft (menunggu persetujuan final)
- **Status persetujuan:** Belum disetujui
- **Status implementasi:** Belum dimulai
- **Tanggal pembaruan:** 2026-11-08

## 2. Referensi APK

- **Nama aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); Smoke Free (Portable Pixels)
- **URL:**
  - https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke
  - https://play.google.com/store/apps/details?id=com.portablepixels.smokefree
- **Path file sumber:** `refrensi_apk.md`
- **Nomor baris awal dan akhir:** 279–291
- **Nama entri:** 8. Pemulihan Kesehatan (Milestone)
- **Link bukti (sesuai entri):** Deskripsi resmi Google Play Store.
- **Catatan pengamatan:** Akses langsung ke halaman/visual Google Play Store tidak dilakukan melalui tools pada sesi diskusi ini. Informasi referensi di PRD mengikuti entri yang tercatat di `refrensi_apk.md:279-291`. Perlu verifikasi visual/fitur referensi sebelum implementasi jika dianggap kritis.

## 3. Latar Belakang

Aplikasi Berhenti Merokok sudah memiliki layar Pemulihan Kesehatan yang menampilkan daftar milestone kesehatan berdasarkan durasi smoke-free, status tercapai/belum, dan informasi milestone berikutnya. Entri referensi menilai fitur dasar sudah tersedia, tetapi masih ada peluang optimasi: menambahkan metrik "hari hidup yang diperoleh" dan/atau visual progress bar per milestone yang lebih detail (`refrensi_apk.md:286-287`).

## 4. Tujuan Fitur

- Memperjelas manfaat kesehatan berhenti merokok bagi pengguna (`refrensi_apk.md:288`).
- Menampilkan progres pemulihan secara lebih konkret dan mudah dipahami.
- Menjaga motivasi pengguna melalui visual status milestone yang informatif.
- Menyempurnakan fitur yang sudah ada tanpa mengubah ruang lingkup utama aplikasi (pelacakan berhenti merokok, offline-first, Android-first).

## 5. Masalah yang Diselesaikan

- Status milestone saat ini bersifat biner (tercapai/belum) dan belum menampilkan progres menuju milestone berikutnya/tiap milestone secara visual.
- Pengguna mungkin kesulitan memahami seberapa dekat mereka dengan milestone tertentu.
- Entri referensi mengusulkan metrik "hari hidup yang diperoleh", tetapi proyek belum memiliki definisi, sumber data, atau formula yang disepakati untuk metrik tersebut.

## 6. Target Pengguna

- Pengguna yang sudah mengisi biodata.
- Pengguna yang memiliki `tanggalMulaiBerhentiMerokok` dan ingin melihat pemulihan kesehatan.
- Pengguna yang membutuhkan motivasi berbasis progres konkret.

## 7. Ruang Lingkup

### 7.1. Termasuk (disepakati)

- Menambahkan visual progress bar per milestone pada daftar pemulihan kesehatan (detail progres menuju target durasi milestone).
- Menampilkan informasi progres per milestone berupa **persentase + sisa waktu** menuju target (keputusan pengguna, 2026-11-08).
- Mempertahankan perilaku existing: loading, error + retry, biodata null, belum berhenti merokok, daftar milestone, header durasi, milestone berikutnya.
- Menjaga konsistensi dengan arsitektur proyek, aturan logging, null safety, normalisasi tanggal/durasi, dan UX global.

### 7.2. Tidak termasuk

- **Metrik "hari hidup yang diperoleh" ditunda** dari ruang lingkup PRD/implementasi ini sampai ada definisi, formula, sumber, dan lokasi tampilan yang disepakati (keputusan pengguna, 2026-11-08).
- Implementasi kode Dart (PRD ini adalah dokumen analisis/rancangan).
- Perubahan skema database, migrasi sqflite, atau penyimpanan data baru.
- Perubahan notifikasi, badge, dashboard, kalender, atau fitur lain di luar Pemulihan Kesehatan.
- Klaim medis yang tidak memiliki sumber/definisi yang disepakati pengguna.
- Penambahan dependensi baru tanpa kebutuhan yang terbukti.

## 8. Kondisi Implementasi Saat Ini

**Status implementasi:** Sudah diimplementasikan (metrik dasar); optimasi referensi belum lengkap (`refrensi_apk.md:282`).

| Komponen | Bukti (path:baris) | Kondisi aktual |
|---|---|---|
| Halaman pemulihan | `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart:15-345` | `PemulihanKesehatanScreen` (ConsumerStatefulWidget) menampilkan pemulihan berbasis biodata. |
| Penanganan async state | `pemulihan_kesehatan_screen.dart:39-71` | Loading, error dengan retry `ref.refresh(biodataProvider)`, logging error. |
| Kondisi data tidak lengkap | `pemulihan_kesehatan_screen.dart:73-81,143-203` | Biodata null → CTA isi biodata; belum berhenti → CTA isi tanggal berhenti. |
| Header durasi | `pemulihan_kesehatan_screen.dart:92,233-345` | `_HeaderPemulihan` terisolasi dengan `Timer.periodic` 1 detik; menampilkan lama smoke-free, sejak tanggal, milestone berikutnya/sisa waktu. |
| Daftar milestone | `pemulihan_kesehatan_screen.dart:94-135` | `ListView.separated`, `ValueKey(m.judul)`, ikon check/clock, hijau jika tercapai, judul/deskripsi/target. **Belum ada progress bar per item.** |
| Status tercapai | `pemulihan_kesehatan_screen.dart:98-100` | `aman >= m.target` dengan durasi negatif diklem ke `Duration.zero`. |
| Data milestone | `lib/shared/konstanta/milestone_kesehatan.dart:2-89` | `MilestoneKesehatan {target, judul, deskripsi}` dan 12 milestone (20 menit–15 tahun). **Belum ada field/metrik hari hidup diperoleh.** |
| Helper milestone berikutnya | `milestone_kesehatan.dart:93-98` | `milestoneBerikutnya(Duration durasi)`. |
| Metrik hari hidup diperoleh | (belum ditemukan) | Tidak ditemukan perhitungan/label "hari hidup yang diperoleh/life gained" pada modul pemulihan/konstanta. |

## 9. Kebutuhan Fungsional

**Kebutuhan wajib:**

1. **KF-01 Progress per milestone:** Setiap item milestone menampilkan progres visual menuju target durasi milestone tersebut (mis. progress bar), dengan nilai terklam pada rentang valid (0–1 / 0%–100%).
2. **KF-02 Status tetap benar:** Milestone dengan durasi smoke-free >= target tetap ditandai tercapai; milestone belum tercapai tetap menunjukkan progres parsial.
3. **KF-03 Informasi progres jelas:** Pengguna dapat memahami progres milestone melalui **persentase + sisa waktu** menuju target (keputusan pengguna, 2026-11-08). Format label final (mis. pemisah, pembulatan, teks “Tersisa…”) mengikuti `optimasi_ui.md`/bahasa Indonesia formal saat implementasi, tanpa mengubah makna.
4. **KF-04 Kondisi existing tidak regresi:** Loading, error + retry, biodata null, belum berhenti, header, daftar milestone, dan navigasi CTA biodata tetap berfungsi.
5. **KF-05 Perhitungan waktu aman:** Durasi/tanggal dinormalisasi sesuai aturan proyek; nilai negatif durasi tidak menghasilkan progres/tampilan yang tidak valid.
6. **KF-06 Milestone tercapai:** Milestone tercapai menampilkan progres penuh (100%) dan status tercapai tetap jelas (ikon/warna/teks sesuai desain existing). Sisa waktu tidak ditampilkan sebagai nilai negatif; dapat ditampilkan sebagai “Tercapai” atau label setara (detail implementasi mengikuti UI yang disepakati saat coding, selama maknanya jelas).

**Kebutuhan ditunda (bukan ruang lingkup saat ini):**

7. **KF-D1 Metrik "hari hidup yang diperoleh":** Ditunda sampai ada definisi, formula, sumber, dan lokasi tampilan yang disepakati (keputusan pengguna, 2026-11-08). Tidak diimplementasikan dalam PRD ini.

## 10. Kebutuhan Nonfungsional

- **Kompatibilitas:** Android-first; implementasi harus kompatibel dengan Android.
- **Performa:** Hindari pekerjaan berat di `build`; pertimbangkan isolasi rebuild jika progress dihitung dari timer per detik.
- **Konsistensi:** Ikuti `Nav` (`core_shared`), logging `L`, Freezed/model patterns bila relevan, import `package:`, urutan import, dan aturan proyek.
- **Null safety:** Salin field nullable ke lokal sebelum type promotion; hindari `!` yang tidak perlu.
- **UX:** Bahasa Indonesia formal/baku; `SafeArea`; padding tepi layar di parent; `ValueKey` stabil; empty/error state informatif; aksesibilitas label/tooltip bila relevan.
- **Keandalan:** Guard pembagian nol pada perhitungan progres; clamp progres; jangan tampilkan nilai NaN/Infinity.

## 11. Alur Penggunaan

1. Pengguna membuka Pemulihan Kesehatan dari navigasi aplikasi.
2. Sistem memuat biodata (`biodataProvider`).
3. Jika loading: tampilkan indikator.
4. Jika error: tampilkan pesan dan tombol "Coba lagi".
5. Jika biodata null: tampilkan ajakan isi biodata.
6. Jika tanggal mulai berhenti null: tampilkan ajakan isi tanggal berhenti.
7. Jika data lengkap: tampilkan header durasi smoke-free dan daftar milestone.
8. Untuk setiap milestone, pengguna melihat status tercapai/belum dan (jika disepakati) progress bar/detail progres.
9. Jika metrik "hari hidup diperoleh" disepakati: pengguna melihat metrik pada lokasi yang disepakati (header/ringkasan/card) dengan label dan sumber/definisi yang jelas.

## 12. Rancangan Antarmuka

**Existing (dipertahankan):** AppBar, header durasi, kartu milestone, ikon status, judul/deskripsi/target.

**Perubahan konseptual (perlu keputusan):**

- **Progress bar per item:** `LinearProgressIndicator` (atau komponen setara Material) di dalam kartu/ListTile milestone, dengan spacing dan label sesuai `optimasi_ui.md`/tema.
- **Detail progres:** pilihan — persentase, sisa durasi, "tercapai pada...", atau kombinasi (keputusan pengguna).
- **Hari hidup diperoleh (opsional):** lokasi dan format belum disepakati; tidak boleh ditampilkan tanpa definisi yang disetujui.

## 13. Rancangan Teknis

- **Lapisan UI:** `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart` (existing). Pertimbangkan widget kecil terpisah untuk item milestone/progress agar rebuild terkontrol.
- **Data milestone:** `lib/shared/konstanta/milestone_kesehatan.dart` (existing). Perubahan model konstanta hanya jika benar-benar diperlukan; default: tambah helper murni untuk progres.
- **Helper murni (kandidat):** `lib/fitur/pemulihan_kesehatan/helper/` (file baru rencana) untuk `progresMilestone(durasi, target)` dengan guard/clamp. Tidak bergantung `BuildContext`/provider.
- **Perhitungan turunan biodata (hanya jika relevan):** jika "hari hidup diperoleh" memakai biodata dan dipakai lintas layar, pertimbangkan ekstensi `BiodataModelPerhitungan` (`lib/fitur/biodata/model/biodata_model.dart`) sesuai aturan ekstraksi perhitungan. **Saat ini belum disepakati.**
- **State/data source:** tetap `biodataProvider`; tidak ada perubahan notifier/DB kecuali disepakati.
- **Logging:** `L.i/w/e/s` pada titik non-frekuensi tinggi; hindari log berulang di `build()`/timer.

**Contoh kode konseptual (ilustrasi saja, tidak diterapkan):**

```dart
/// Konseptual: helper murni.
double progresMilestone(Duration durasi, Duration target) {
  if (target.inSeconds <= 0) return 1.0;
  final v = durasi.inSeconds / target.inSeconds;
  if (v < 0) return 0.0;
  if (v > 1) return 1.0;
  return v;
}
```

## 14. File Terdampak

| Path | Status | Fungsi | Alasan terdampak | Wajib/Opsional |
|---|---|---|---|---|
| `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart` | Existing | UI pemulihan kesehatan | Tambah progress bar/detail per milestone; integrasi metrik baru jika disepakati. | Wajib (untuk progress bar) |
| `lib/shared/konstanta/milestone_kesehatan.dart` | Existing | Konstanta milestone | Hanya jika struktur data milestone perlu diperluas; default tidak berubah. | Opsional / belum pasti |
| `lib/fitur/pemulihan_kesehatan/helper/progres_milestone_helper.dart` | New (rencana) | Helper progres murni | Memusatkan perhitungan progres + guard/clamp. | Opsional (disarankan) |
| `lib/fitur/biodata/model/biodata_model.dart` | Existing | Model + ekstensi perhitungan | Hanya jika metrik "hari hidup diperoleh" adalah turunan biodata lintas layar. | Opsional / tergantung keputusan |
| `test/pemulihan_kesehatan_*_test.dart` atau `test/*progres_milestone*_test.dart` | New (rencana) | Unit test helper | Verifikasi clamp, batas target, durasi negatif. | Opsional |
| `prd/optimasi-pemulihan-kesehatan-milestone.md` | New | PRD | Dokumentasi kebutuhan. | Wajib (sesi ini) |
| `refrensi_apk.md` | Existing | Referensi APK | Hanya penanda status PRD pada entri baris 279–291 setelah PRD Final dan jika izin pengeditan memperbolehkan. | Tergantung izin/persetujuan final |

## 15. Kriteria Penerimaan

1. Setiap milestone menampilkan progress visual yang sesuai durasi smoke-free terhadap target.
2. Milestone tercapai menampilkan progres penuh (100%) dan status tercapai tetap benar.
3. Milestone belum tercapai menampilkan progres parsial terklam (0–<100%).
4. Setiap item milestone menampilkan **persentase + sisa waktu** menuju target (atau label “Tercapai”/setara untuk milestone tercapai) sesuai KF-03/KF-06.
5. Target/durasi nol atau data tidak valid tidak menyebabkan crash/NaN/Infinity.
6. Kondisi loading, error+retry, biodata null, dan belum berhenti tetap berperilaku benar.
7. UI tetap memiliki `SafeArea`, padding parent, dan `ValueKey` stabil.
8. `dart format`/`flutter analyze` sesuai aturan proyek (dijalankan saat implementasi, bukan pada sesi PRD ini).

**Di luar ruang lingkup penerimaan saat ini:** metrik "hari hidup diperoleh" (ditunda).

## 16. Risiko dan Ketergantungan

- **Risiko formula medis:** "Hari hidup diperoleh" dapat menjadi klaim kesehatan jika tidak didefinisikan hati-hati. Risiko mitigasi: jangan implementasikan tanpa definisi/sumber yang disetujui; beri label jelas.
- **Risiko performa:** timer per detik pada header dapat memicu rebuild; progress per item harus dirancang agar tidak menambah beban berlebihan.
- **Ketergantungan data:** bergantung pada `biodataProvider` dan `tanggalMulaiBerhentiMerokok`.
- **Ketergantungan UX:** keputusan visual (persen/sisa/lokasi) memengaruhi implementasi.
- **Keterbatasan verifikasi:** referensi visual Google Play Store tidak diverifikasi langsung di sesi ini; pengujian Android terbatas (aturan proyek).

## 17. Pertanyaan Terbuka

**Keputusan yang telah disepakati (2026-11-08):**

1. **Metrik "hari hidup yang diperoleh":** **A — Ditunda**. Tidak masuk ruang lingkup PRD/implementasi ini sampai ada definisi, formula, sumber, dan lokasi tampilan yang disepakati.
2. **Detail progress bar per milestone:** **C — Persentase + sisa waktu** menuju target.

**Pertanyaan terbuka yang tidak menghambat finalisasi (dapat diputuskan saat implementasi, selama tidak mengubah ruang lingkup):**

- Format label final persentase/sisa waktu (pemisah, pembulatan, kapitalisasi) mengikuti `optimasi_ui.md` dan bahasa Indonesia formal.
- Apakah milestone tercapai menampilkan bar penuh + indikator tercapai (default direkomendasikan: **ya**, sesuai KF-06) atau hanya indikator tercapai.
- Penempatan helper murni (mis. `lib/fitur/pemulihan_kesehatan/helper/progres_milestone_helper.dart`) dan kebutuhan unit test helper.
- Apakah header perlu menampilkan progres keseluruhan semua milestone (di luar KF saat ini).

**Tidak ada pertanyaan terbuka yang menghambat finalisasi PRD** berdasarkan keputusan pengguna saat ini.

## 18. Rekomendasi

- **Rekomendasi 1 (utama):** Tetapkan ruang lingkup awal pada **KF-01 s.d. KF-05 (progress bar per milestone)** dan tunda "hari hidup diperoleh" sampai ada definisi/sumber yang disepakati. Ini sesuai status referensi "bersifat tambahan" dan menghindari klaim medis tanpa dasar.
- **Rekomendasi 2:** Ekstrak perhitungan progres ke helper murni (`lib/fitur/pemulihan_kesehatan/helper/`) dengan guard pembagian nol dan clamp; tambahkan unit test sederhana bila diminta.
- **Rekomendasi 3:** Pastikan progress bar mematuhi tema Material dan tidak menyebabkan rebuild seluruh halaman (pertahankan isolasi timer pada header; evaluasi item widget saat implementasi).
- **Rekomendasi 4:** Jika metrik "hari hidup diperoleh" disetujui, dokumentasikan sebagai "estimasi" dengan formula eksplisit di PRD/kode komentar yang sesuai aturan proyek.

## 19. Riwayat Perubahan

| Tanggal | Perubahan | Oleh |
|---|---|---|
| 2026-11-08 | PRD draft awal dibuat berdasarkan `refrensi_apk.md:279-291`, pemeriksaan read-only implementasi aktual, dan analisis file terdampak. Status: Draft, belum disetujui. | AI (analisis/diskusi) |
| 2026-11-08 | Keputusan pengguna dicatat: (1) metrik "hari hidup diperoleh" **ditunda**; (2) progress bar menampilkan **persentase + sisa waktu**. Ruang lingkup, KF, kriteria penerimaan, dan pertanyaan terbuka diperbarui. Menunggu persetujuan final. | AI berdasarkan keputusan pengguna |
