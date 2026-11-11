# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Final

**Status Implementasi:** Sedang Dikerjakan

---

## 1. Informasi Produk

**Informasi:**
- Nama aplikasi: Berhenti Merokok
- Deskripsi produk: Aplikasi Flutter offline-first untuk membantu pengguna berhenti merokok, mencatat konsumsi, craving, progres kesehatan, dan tabungan impian.
- Platform: Android (Flutter; kode juga berjalan di iOS/desktop/web, tetapi sasaran fitur ini adalah Android mobile)
- Versi: 1.0.0+1
- Status pengembangan: Aktif dikembangkan (fitur SOS Craving sudah tersedia dengan 3 teknik: Napas 4-7-8, Timer 3 Menit, Distraksi)

## 2. Latar Belakang

Pengguna yang sedang craving membutuhkan lebih dari satu teknik coping. Teknik yang membantu satu pengguna belum tentu membantu pengguna lain, dan intensitas craving bervariasi. Riset kompetitor (`refrensi_apk.md` bagian A4, baris 94–104) menunjukkan aplikasi sejenis menyediakan beragam tool SOS tambahan yang terbukti dipakai pengguna: napas box breathing, napas 90 detik, grounding 5-4-3-2-1, urge surfing 10–20 menit, dan timer 5/10 menit.

Kondisi proyek saat ini (diperiksa pada `master`, 10 November 2026):

- Layar SOS Craving (`lib/fitur/sos_craving/screens/sos_craving_screen.dart`) hanya menyediakan 3 teknik dalam bentuk 3 tab: `Napas 4-7-8`, `Timer 3 Menit`, `Distraksi`.
- Enum `JenisIntervensiSos` (`lib/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart`) hanya berisi `napas_478`, `timer_3_menit`, `distraksi`.
- Riwayat intervensi tersimpan di tabel `sos_intervensi` (kolom `jenis_intervensi` TEXT, tanpa CHECK constraint) sehingga penambahan jenis baru tidak memerlukan migrasi skema.
- Semua teknik baru harus tetap offline, cepat, tanpa iklan, dan hasilnya tercatat ke `sos_intervensi` seperti teknik yang sudah ada.

Masalah yang ingin diselesaikan: pilihan coping pengguna terlalu sempit; tidak ada teknik berbasis grounding (tubuh/indra), tidak ada urge surfing, dan tidak ada variasi durasi timer selain 3 menit.

## 3. Tujuan Produk

- Memperluas menu coping pada SOS Craving tanpa mengubah inti yang sudah ada (Napas 4-7-8 + Timer 3 Menit tetap tersedia).
- Menyediakan teknik berbasis napas alternatif (box breathing 4-4-4, napas 90 detik).
- Menyediakan teknik grounding 5-4-3-2-1 interaktif langkah demi langkah.
- Menyediakan urge surfing timer dengan durasi 10/15/20 menit.
- Menyediakan variasi timer 5 dan 10 menit selain 3 menit.
- Setiap teknik baru tercatat ke `sos_intervensi` agar riwayat intervensi tetap satu sumber.
- Seluruh teknik berjalan offline, tanpa iklan, tanpa akun, tanpa pengiriman data ke luar perangkat.

## 4. Target Pengguna

- Pengguna aplikasi Berhenti Merokok yang sedang mengalami craving dan membutuhkan bantuan segera (hitungan menit).
- Pengguna yang teknik Napas 4-7-8 atau Timer 3 Menit tidak cocok untuknya dan membutuhkan pendekatan lain (grounding, urge surfing, atau napas lain).
- Pengguna yang ingin memahami teknik mana yang paling membantunya lewat riwayat `sos_intervensi`.

## 5. Ruang Lingkup

### Termasuk
- Teknik napas box breathing (4-4-4-4) dengan panduan siklus dan penghitung.
- Teknik napas 90 detik (latihan napas singkat satu tarikan panjang, sesuai pola kompetitor).
- Teknik grounding 5-4-3-2-1 interaktif (5 lihat, 4 sentuh, 3 dengar, 2 cium, 1 kecap) dengan langkah yang bisa dicentang.
- Urge surfing timer dengan pilihan durasi 10 / 15 / 20 menit.
- Timer craving dengan pilihan durasi 3 / 5 / 10 menit (memperluas timer 3 menit yang sudah ada).
- Pencatatan setiap teknik baru ke `sos_intervensi` melalui alur `tampilkanDanSimpanHasilIntervensi()` yang sudah ada.
- Penyesuaian enum `JenisIntervensiSos` dan labelnya untuk jenis teknik baru.

### Tidak Termasuk
- Mini-game distraksi (A7 pada `refrensi_apk.md` baris 122–127) — PRD terpisah bila dikerjakan.
- AI coach / Quity-style chatbot (A8 pada `refrensi_apk.md` baris 129–134).
- Implementation Intentions / "Rencana Darurat Saya" (A10 pada `refrensi_apk.md` baris 143–148).
- Perubahan logika bisnis, rumus, atau skema database (tidak ada migrasi; kolom `jenis_intervensi` TEXT tanpa CHECK).
- Perubahan pada cadangan/ekspor (`cadangan_helper.dart`) — di luar ruang lingkup.
- Skor "intervensi yang benar-benar membantu" / personalisasi urutan menu SOS (B4 lanjutan, `refrensi_apk.md` baris 208–212) — ruang lingkup lanjutan terpisah.
- Notifikasi atau pengingat baru.

## 6. Daftar Fitur

| Fitur | Deskripsi | Prioritas |
|---|---|---|
| Box breathing 4-4-4 | Latihan napas kotak: tarik 4 detik, tahan 4 detik, hembus 4 detik, tahan 4 detik | Must Have |
| Napas 90 detik | Latihan napas singkat ±90 detik untuk meredakan craving akut | Should Have |
| Grounding 5-4-3-2-1 | Teknik grounding interaktif 5 langkah (lihat/sentuh/dengar/cium/kecap) | Must Have |
| Urge surfing timer | Timer 10/15/20 menit dengan panduan "menunggangi" gelombang craving | Must Have |
| Timer 5/10 menit | Pilihan durasi 3/5/10 menit pada timer craving yang sudah ada | Must Have |
| Pencatatan ke `sos_intervensi` | Semua teknik baru menyimpan riwayat intervensi | Must Have |

## 7. Detail Persyaratan Fitur

### 7.1 Box Breathing 4-4-4

- Nama fitur: Box Breathing
- Tujuan: alternatif napas terstruktur bagi pengguna yang tidak cocok dengan pola 4-7-8.
- Deskripsi: latihan napas kotak 4 fase seimbang (tarik 4, tahan 4, hembus 4, tahan 4) dengan animasi lingkaran membesar/mengecil dan penghitung fase.
- Data masukan: tidak ada input teks; pengguna menekan Mulai/Jeda/Reset.
- Proses: tampilkan fase aktif dan sisa detik per fase; setelah N siklus (default 4), tandai selesai dan panggil alur `tampilkanDanSimpanHasilIntervensi()` dengan `JenisIntervensiSos.napas_box`.
- Aturan bisnis: durasi fase selalu 4 detik; jumlah siklus default 4; timer berhenti saat pengguna menekan Jeda/Reset; tidak ada data yang dikirim keluar perangkat.
- Validasi: tidak ada input bebas.
- Kondisi berhasil: siklus selesai → toast sukses + bottom sheet hasil intervensi tampil dan tersimpan.
- Kondisi gagal: penyimpanan gagal → toast gagal (pola `SheetHasilIntervensi` yang sudah ada); teknik tetap bisa diulang.
- Respons sistem: identik dengan teknik Napas 4-7-8 yang sudah ada.
- Kriteria penerimaan: pengguna dapat menjalankan box breathing dari layar SOS; setelah selesai, baris baru muncul di riwayat `sos_intervensi` dengan jenis `napas_box`.

### 7.2 Napas 90 Detik

- Nama fitur: Napas 90 Detik
- Tujuan: teknik napas sangat singkat untuk craving akut yang tidak butuh waktu lama.
- Deskripsi: latihan napas terpandu ±90 detik (mis. tarik napas dalam 4 detik, hembuskan perlahan 6–8 detik, diulang hingga 90 detik berlalu) dengan penghitung mundur total.
- Data masukan: Mulai/Jeda/Reset.
- Proses: hitung mundur 90 detik dengan panduan fase napas; saat mencapai 0, tandai selesai dan simpan dengan `JenisIntervensiSos.napas_90_detik`.
- Aturan bisnis: total durasi 90 detik; fase napas boleh sederhana (tarik 4 / hembus 6); tidak memerlukan input pengguna selain kontrol timer.
- Validasi: tidak ada input bebas.
- Kondisi berhasil: 90 detik berlalu → toast + bottom sheet hasil intervensi.
- Kondisi gagal: penyimpanan gagal → toast gagal; teknik tetap bisa diulang.
- Respons sistem: sama seperti teknik napas lainnya.
- Kriteria penerimaan: pengguna dapat menyelesaikan napas 90 detik dan hasilnya tercatat dengan jenis `napas_90_detik`.

### 7.3 Grounding 5-4-3-2-1

- Nama fitur: Grounding 5-4-3-2-1
- Tujuan: mengalihkan perhatian dari craving ke sensasi tubuh/indra saat ini.
- Deskripsi: layar interaktif 5 langkah berurutan: 5 hal yang dilihat → 4 hal yang disentuh → 3 hal yang didengar → 2 hal yang dicium → 1 hal yang dikecap. Setiap langkah berisi instruksi singkat dan tombol "Sudah" untuk lanjut; progres terlihat jelas.
- Data masukan: tidak ada input teks; setiap langkah hanya berisi instruksi + tombol "Sudah" (keputusan disepakati 2026-11-10 untuk v1).
- Proses: tampilkan langkah 1..5 secara berurutan; pengguna menekan "Sudah" untuk maju; setelah langkah 5 selesai, tandai selesai dan simpan dengan `JenisIntervensiSos.grounding_54321`.
- Aturan bisnis: langkah tidak boleh dilompati ke depan; pengguna boleh kembali ke langkah sebelumnya; keluar di tengah = tidak ada penyimpanan (keputusan disepakati 2026-11-10).
- Validasi: tidak ada input bebas.
- Kondisi berhasil: 5 langkah selesai → toast + bottom sheet hasil intervensi.
- Kondisi gagal: penyimpanan gagal → toast gagal.
- Respons sistem: mengikuti pola bottom sheet hasil intervensi yang sudah ada.
- Kriteria penerimaan: pengguna dapat menyelesaikan 5 langkah berurutan; hasil tercatat dengan jenis `grounding_54321`.

### 7.4 Urge Surfing Timer

- Nama fitur: Urge Surfing
- Tujuan: membantu pengguna "menunggangi" gelombang craving hingga reda, berbasis teknik mindfulness yang dipakai kompetitor (Craving To Quit, QuitNow Medicon).
- Deskripsi: timer dengan pilihan durasi 10 / 15 / 20 menit; menampilkan teks fase gelombang (naik → puncak → reda) dan lingkaran progres (`CircularProgressIndicator`) plus timer mundur; afirmasi singkat per fase; tanpa musik/audio eksternal; tanpa grafik kustom; tidak ada klaim medis (keputusan visual disepakati 2026-11-10).
- Data masukan: pilihan durasi (10/15/20), Mulai/Jeda/Reset/Selesai.
- Proses: pengguna memilih durasi → timer berjalan dengan fase gelombang (mis. 3 fase: naik, puncak, reda) → saat waktu habis, tandai selesai dan simpan dengan `JenisIntervensiSos.urge_surfing` dan `detail` berisi durasi yang dipilih (mis. `'10 menit'`).
- Aturan bisnis: durasi hanya 10/15/20 menit; craving tidak dipaksa "hilang", hanya ditemani hingga berlalu; tidak ada klaim medis.
- Validasi: durasi wajib salah satu dari 10/15/20.
- Kondisi berhasil: waktu habis atau pengguna menekan Selesai → toast + bottom sheet hasil intervensi.
- Kondisi gagal: penyimpanan gagal → toast gagal.
- Respons sistem: sama seperti teknik lainnya.
- Kriteria penerimaan: pengguna dapat menjalankan urge surfing dengan 3 pilihan durasi; hasil tercatat dengan jenis `urge_surfing` dan detail durasi.

### 7.5 Timer Craving 5/10 Menit

- Nama fitur: Variasi Durasi Timer
- Tujuan: memperluas timer 3 menit yang sudah ada agar sesuai kebutuhan pengguna (Cut Smoking & H2M sama-sama punya variasi durasi).
- Deskripsi: pada layar Timer Craving, pengguna dapat memilih durasi 3 / 5 / 10 menit sebelum memulai; perilaku lain (lingkaran progres, Mulai/Jeda/Reset, penyimpanan) tetap sama.
- Data masukan: pilihan durasi (3/5/10).
- Proses: durasi terpilih menjadi `_durasiAwal`; timer berjalan seperti sebelumnya; setelah selesai, simpan dengan jenis baru `JenisIntervensiSos.timer_craving` dan `detail` berisi durasi (mis. `'3 menit'`, `'5 menit'`, `'10 menit'`).
- Keputusan (sudah disepakati 2026-11-10): **satu jenis baru `timer_craving` + `detail` durasi** dipakai untuk semua durasi (3/5/10). Nilai enum `timer_3_menit` tetap ada demi kompatibilitas data lama, tetapi tidak dipakai untuk penyimpanan baru.
- Aturan bisnis: tidak boleh ada durasi di luar 3/5/10 menit pada v1.
- Validasi: durasi hanya 3/5/10.
- Kondisi berhasil: timer selesai → toast + bottom sheet hasil intervensi.
- Kondisi gagal: penyimpanan gagal → toast gagal.
- Respons sistem: sama seperti timer 3 menit yang sudah ada.
- Kriteria penerimaan: pengguna dapat memilih 3/5/10 menit; perilaku identik dengan timer 3 menit yang sudah ada; hasil tercatat di `sos_intervensi`.

### 7.6 Pencatatan Riwayat Intervensi

- Nama fitur: Pencatatan Teknik Baru
- Tujuan: menjaga satu sumber riwayat intervensi.
- Deskripsi: semua teknik baru memanggil `tampilkanDanSimpanHasilIntervensi()` dengan `jenisIntervensi` yang sesuai; enum `JenisIntervensiSos` diperluas.
- Aturan bisnis:
  - Enum baru: `napas_box`, `napas_90_detik`, `grounding_54321`, `urge_surfing`, `timer_craving`.
  - `label` extension wajib diisi untuk setiap nilai enum baru (`timer_craving` → `'Timer Craving'`); `detail` menyimpan durasi terpilih.
  - `timer_3_menit` tetap ada di enum untuk kompatibilitas data lama; penyimpanan baru memakai `timer_craving`.
  - Kolom `jenis_intervensi` TEXT tanpa CHECK → tidak perlu migrasi skema; `fromSqflite` memakai `safeParseEnum` dengan fallback yang sudah ada (fallback tetap `napas_478`).
- Kriteria penerimaan: setelah teknik baru selesai, baris `sos_intervensi` baru terbaca di riwayat dengan label Indonesia yang benar.

## 8. Alur Pengguna

Alur umum (berlaku untuk semua teknik):

1. Pengguna membuka SOS Craving (dari Dashboard / Lainnya / notifikasi bila ada).
2. Pengguna memilih teknik dari menu kartu (bagian 9).
3. Pengguna menjalankan teknik (Mulai/Jeda/Reset atau langkah interaktif).
4. Teknik selesai → toast sukses → bottom sheet "Apakah dorongan merokok berkurang?" (Berkurang / Tetap / Belum selesai / Lewati).
5. Hasil tersimpan ke `sos_intervensi`; bila ada entri diary craving hari ini, tawarkan tautan (perilaku yang sudah ada, tidak berubah).
6. Pengguna kembali ke layar SOS atau keluar.

Alur alternatif:
- Pengguna keluar di tengah teknik → **tidak ada penyimpanan** (keputusan disepakati 2026-11-10; konsisten dengan perilaku saat ini).
- Penyimpanan gagal → toast gagal, teknik tetap boleh diulang.

## 9. Persyaratan UI/UX

Keputusan struktur layar (disepakati 2026-11-10): **Opsi A — Menu kartu teknik**, sesuai `refrensi_apk.md:103` ("satu tab SOS dengan kartu pilihan teknik").

- Layar SOS diubah dari `TabBar` 3 tab menjadi menu kartu teknik (grid 2 kolom, `GridView`/`Wrap` sesuai kebutuhan): setiap kartu berisi ikon, nama teknik, dan deskripsi 1 baris.
- Kartu inti tetap di urutan pertama, diikuti teknik baru (keputusan disepakati 2026-11-10): **Napas 4-7-8 → Timer Craving (3/5/10) → Box Breathing → Napas 90 Detik → Grounding 5-4-3-2-1 → Distraksi → Urge Surfing**.
- Kartu "Ingat alasanmu" (kartu alasan berhenti yang sudah ada) **tetap tampil di atas** grid kartu, seperti perilaku layar saat ini (keputusan disepakati 2026-11-10).
- Mengetuk kartu membuka tampilan detail teknik (implementasi bebas: halaman/route terpisah atau `IndexedStack` seperti pola proyek — keputusan detail diserahkan ke tahap implementasi, tidak mengubah perilaku).
- Opsi B (gabung 3 tab) dan Opsi C (tab ke-4) **tidak dipilih**.

Persyaratan tampilan:
- Semua teknik baru: offline, tanpa iklan, tanpa akun.
- Kartu/tombol menyentuh target ≥48dp; teks terbaca pada lebar ≤320dp dan skala teks besar (tidak overflow).
- Grounding 5-4-3-2-1 menampilkan progres langkah (mis. "Langkah 2 dari 5") dan daftar yang bisa dicentang.
- Urge surfing menampilkan fase gelombang dengan teks sederhana; tidak ada klaim medis.
- Warna dari `ColorScheme`/tema; tidak hardcode warna di luar status semantic (hijau sukses / merah error).
- Spacing mengikuti `Column`/`Row` `spacing`; `SizedBox` hanya bila perlu.
- Label hasil intervensi tetap dari `HasilIntervensiSosExtension.label`.

## 10. Ringkasan Kode Contoh Singkat

- Nama fitur: Pencatatan teknik baru
- Bahasa pemrograman: Dart (Flutter)
- Tujuan kode: menunjukkan perluasan enum + penyimpanan tanpa migrasi DB.

```dart
/// Jenis intervensi yang tersedia pada SOS Craving.
enum JenisIntervensiSos {
  napas_478,
  timer_3_menit,
  distraksi,
  napas_box,
  napas_90_detik,
  grounding_54321,
  urge_surfing,
  timer_craving,
}
```

```dart
// Saat teknik selesai (contoh: box breathing):
unawaited(
  tampilkanDanSimpanHasilIntervensi(
    context: context,
    ref: ref,
    jenisIntervensi: JenisIntervensiSos.napas_box,
  ).catchError((Object e, StackTrace s) {
    L.e('Gagal menampilkan sheet hasil box breathing: $e $s');
    return null;
  }),
);
```

**Penjelasan:** kolom `jenis_intervensi` di `sos_intervensi` adalah TEXT tanpa CHECK constraint, jadi nilai enum baru langsung tersimpan tanpa migrasi. `fromSqflite` sudah memakai `safeParseEnum` dengan fallback.

**Catatan:** Kode hanya sebagai ilustrasi, bukan ketentuan implementasi atau kode produksi.

## 11. Hak Akses Pengguna

| Jenis Pengguna | Hak Akses | Batasan |
|---|---|---|
| Pengguna aplikasi (single user, offline) | Menjalankan semua teknik SOS, melihat riwayat intervensi miliknya sendiri | Tidak ada akses multi-user; tidak ada data yang dikirim ke pihak lain |

Aplikasi hanya memiliki satu jenis pengguna tanpa pembatasan khusus.

## 12. Persyaratan Data

- Jenis data: enum jenis intervensi (TEXT), hasil intervensi (TEXT, nullable), detail (TEXT, nullable), timestamp UTC (TEXT).
- Data yang harus disimpan: setiap penyelesaian teknik baru → 1 baris `sos_intervensi` (id, jenis_intervensi, detail?, hasil_intervensi?, diary_craving_id?, dibuat).
- Hubungan antar-data: `sos_intervensi.diary_craving_id` → `diary_craving.id` (opsional, perilaku yang sudah ada).
- Aturan CRUD: tambah (via notifier `simpan`), baca (riwayat), ubah terbatas (`ubahDiaryCravingId`), tidak ada hapus pada v1.
- Validasi & integritas: `jenis_intervensi` wajib nilai enum valid; `dibuat` UTC; id unik.
- Sinkronisasi: tidak ada (offline-first, lokal).
- Kebutuhan data produk vs implementasi DB: kebutuhan produk = riwayat intervensi per teknik; implementasi memakai tabel yang sudah ada, tanpa perubahan skema.

## 13. Persyaratan Nonfungsional

- Performa: teknik terbuka dalam <1 detik dari layar SOS; tidak ada jank pada animasi napas/grounding (60fps); timer akurat ±1 detik.
- Keamanan: tidak ada data yang keluar perangkat; tidak ada izin baru; tidak ada logging data sensitif.
- Privasi: riwayat intervensi hanya di perangkat; tidak ada analytics/telemetry.
- Keandalan: penyimpanan gagal tidak memblokir penggunaan teknik; fallback toast gagal.
- Kompatibilitas: Android (target utama); layar ≤320dp dan skala teks besar tidak overflow.
- Kemudahan pemeliharaan: enum + label terpusat; setiap teknik widget terpisah (`StatefulWidget`/`StatelessWidget` sesuai pola proyek); log dengan `L.i/L.w/L.e`.
- Aksesibilitas: label semantik pada tombol interaktif; target sentuh ≥48dp.

## 14. Kriteria Penerimaan

1. Layar SOS menampilkan teknik baru sesuai struktur UI final (bagian 9) tanpa overflow pada lebar 320dp / skala teks besar.
2. Box breathing berjalan 4 fase × 4 detik dengan penghitung dan (opsional) target siklus; selesai → tersimpan `napas_box`.
3. Napas 90 detik berjalan mundur 90 detik dengan panduan; selesai → tersimpan `napas_90_detik`.
4. Grounding 5-4-3-2-1 menampilkan 5 langkah berurutan dengan progres; selesai → tersimpan `grounding_54321`.
5. Urge surfing dapat dipilih 10/15/20 menit dan berjalan; selesai → tersimpan `urge_surfing` dengan `detail` durasi.
6. Timer craving dapat memilih 3/5/10 menit; perilaku sama seperti sebelumnya; tersimpan sesuai keputusan 7.5.
7. Riwayat `sos_intervensi` menampilkan semua teknik baru dengan label Indonesia yang benar.
8. `dart analyze` tidak menghasilkan error baru; tidak ada file yang diubah di luar ruang lingkup.
9. Tidak ada regresi pada teknik yang sudah ada (Napas 4-7-8, Timer 3 Menit, Distraksi) dan alur tautan diary.
10. Semua teknik berfungsi tanpa koneksi internet.

## 15. Prioritas Pengembangan

- Must Have: Box breathing, Grounding 5-4-3-2-1, Urge surfing, Timer 5/10 menit, pencatatan ke `sos_intervensi`.
- Should Have: Napas 90 detik.
- Could Have: Opsi "hanya tampilkan teknik yang paling sering berhasil" (butuh B4 lanjutan) — tidak pada v1.
- Won't Have: Mini-game (A7), AI coach (A8), implementation intentions (A10), notifikasi baru, migrasi skema, ekspor CSV/cadangan.

## 16. Risiko dan Ketergantungan

- Risiko: penambahan teknik membuat layar SOS padat/membingungkan → mitigasi: menu kartu teknik 2 kolom (Opsi A) dengan ikon + nama + deskripsi 1 baris; teknik inti di urutan pertama.
- Risiko: enum fallback `safeParseEnum` menyembunyikan nilai tak dikenal → mitigasi: label wajib diisi; fallback tetap ada demi kompatibilitas data lama.
- Risiko: pengguna salah mengira teknik sebagai pengganti nasihat medis → mitigasi: teks "bukan pengganti nasihat medis" pada layar SOS/hint; hindari klaim "menyembuhkan".
- Risiko: urge surfing disalahartikan sebagai janji craving pasti reda → mitigasi: bahasa "menunggangi gelombang", bukan "menghilangkan".
- Ketergantungan: `tampilkanDanSimpanHasilIntervensi()` (sheet_hasil_intervensi.dart), `sosIntervensiProvider`, enum `JenisIntervensiSos`, tabel `sos_intervensi`.
- Keputusan struktur UI sudah disepakati (Opsi A, menu kartu teknik) pada 2026-11-10; detail implementasi route/halaman diserahkan ke tahap implementasi.
- Tidak ada layanan eksternal / backend.

## 17. Rencana Pengembangan

| Tahap | Fitur | Target |
|---|---|---|
| 1 | Perluasan enum + label | Bersama tahap 2 |
| 2 | Timer 5/10 menit + Box breathing | Tahap pertama implementasi |
| 3 | Grounding 5-4-3-2-1 interaktif | Tahap kedua |
| 4 | Urge surfing + Napas 90 detik | Tahap ketiga |
| 5 | Audit overflow ≤320dp + `dart analyze` + uji manual | Sebelum selesai |

## 18. Ketentuan Tambahan

- Tidak boleh mengubah logika bisnis/rumus/notifier yang sudah ada di luar penambahan enum.
- Tidak boleh menambah dependency baru (timer/animasi memakai API Flutter yang sudah ada).
- Tidak boleh menambah izin Android/iOS baru.
- Bahasa Indonesia untuk seluruh teks UI, sesuai kebiasaan proyek.
- Perubahan hanya pada file di bagian 20; jangan menyentuh `other` screen di luar SOS.

## 19. Riwayat Perubahan

| Tanggal | Perubahan | Keterangan |
|---|---|---|
| 2026-11-10 | Draf awal PRD dibuat dari `refrensi_apk.md` bagian A4 (baris 94–104) | Menunggu diskusi final dengan pengguna |
| 2026-11-10 | Keputusan diskusi: Opsi A (menu kartu teknik) dipilih; cakupan v1 = semua 5 tool (box breathing, napas 90 detik, grounding 5-4-3-2-1, urge surfing, timer 5/10 menit); pencatatan timer memakai `timer_craving` + `detail` durasi; keluar di tengah teknik = tidak ada penyimpanan | Status dokumen tetap Draft sampai diskusi selesai |
| 2026-11-10 | Keputusan diskusi lanjutan: kartu "Ingat alasanmu" tetap di atas grid; Grounding 5-4-3-2-1 tanpa input teks (tombol "Sudah" saja); urge surfing memakai teks fase + lingkaran progres (tanpa CustomPainter); urutan kartu: Napas 4-7-8 → Timer Craving → Box Breathing → Napas 90 Detik → Grounding 5-4-3-2-1 → Distraksi → Urge Surfing | Status dokumen tetap Draft |
| 2026-11-10 | PRD ditandai **Final** setelah diskusi selesai | Belum Diimplementasikan |

## 20. File-File Terdampak

| Lokasi File | Status Perubahan | Deskripsi Perubahan |
|---|---|---|
| `lib/fitur/sos_craving/screens/sos_craving_screen.dart` | Diubah | Struktur layar menjadi menu kartu teknik (Opsi A); integrasi teknik baru |
| `lib/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart` | Diubah | Tambah `napas_box`, `napas_90_detik`, `grounding_54321`, `urge_surfing` (+ jenis timer baru sesuai keputusan 7.5) dan labelnya |
| `lib/fitur/sos_craving/widgets/` (mis. `box_breathing_view.dart`, `grounding_54321_view.dart`, `urge_surfing_view.dart`, `napas_90_detik_view.dart`) | Dibuat | Widget per teknik, dipisah agar tidak membengkakkan `sos_craving_screen.dart` |
| `lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart` | Tidak berubah (opsional) | Sudah generik; hanya dipakai apa adanya |
| `lib/fitur/sos_craving/notifier/sos_intervensi_notifier.dart` | Tidak berubah | `simpan()` sudah menerima enum apa pun |
| `lib/fitur/sos_craving/model/sos_intervensi_model.dart` | Tidak berubah | Kolom TEXT tanpa CHECK; `safeParseEnum` sudah fallback |
| `lib/shared/db/sqflite/sqflite.dart` | Tidak berubah | Tidak ada migrasi skema |
| `prd/sos_craving_tool_tambahan.md` | Dibuat | Dokumen ini |
| `refrensi_apk.md` | Diubah (tandai) | Bagian A4 ditandai sudah dibuatkan PRD |

Catatan: daftar mengikuti keputusan diskusi 2026-11-10 (Opsi A; `timer_craving` + detail durasi; keluar di tengah = tidak ada penyimpanan). Tidak ada kode Dart yang diubah pada tahap PRD ini.

## 21. Referensi dari refrensi_apk.md

Sumber: `refrensi_apk.md` di root proyek (baris dibaca pada 10–11 November 2026).

### 21.1 Referensi Fitur

- **`refrensi_apk.md:94-104` (A4. SOS Craving — Tool Tambahan)** — inti PRD ini. Dikutip relevansinya:
  - Tujuan: memperluas menu coping tanpa mengubah inti (napas 4-7-8 + timer 3 menit tetap).
  - Tool tambahan yang terbukti di kompetitor dan mobile-capable:
    - Napas **box breathing** (4-4-4) dan **napas 90 detik** ([ZenQuit](https://play.google.com/store/apps/details?id=com.zenquit.habit), [Nicotine Free](https://apps.apple.com/us/app/nicotine-free-quit-vape-zyn/id6810766797)).
    - **Grounding 5-4-3-2-1** ([Pace Android](https://github.com/ravipurohit1991/pace), [Quit Smoking: Progress Tracker](https://play.google.com/store/apps/details?id=com.inspectorstudios.quitsmokingprogresstracker)).
    - **Urge surfing timer 10–20 menit** ([Craving To Quit](https://play.google.com/store/apps/details?id=com.claritasmindsciences.CravingToQuit), [QuitNow Medicon](https://apps.apple.com/us/app/quitnow-stop-smoking/id6768372199)).
    - **Timer 5/10 menit** selain 3 menit ([Cut Smoking](https://play.google.com/store/apps/details?id=com.nfm.aval024), [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke)).
  - Saran sumber: satu tab SOS dengan kartu pilihan teknik; tetap offline, cepat, tanpa iklan; catat teknik yang dipakai ke `sos_intervensi` (sudah ada).
  - Prioritas sumber: Sedang.
- **Referensi store yang dibaca ulang untuk PRD ini (11 Nov 2026):**
  - PuffGone ([link](https://play.google.com/store/apps/details?id=com.puffgone.app)): SOS toolkit — 4-7-8 (3 siklus), 5-4-3-2-1 interaktif langkah demi langkah, tap challenge 15 detik, brain math, exercise timer, power words, gratitudes, memory match, urge surfing, reaction time; 100% offline, tanpa akun. Mengonfirmasi pola 5-4-3-2-1 interaktif dan urge surfing sebagai tool SOS yang lazim.
  - ZenQuit ([link](https://play.google.com/store/apps/details?id=com.zenquit.habit)): guided breathing 4-7-8 dan box breathing dengan haptic guidance; SQLite offline; backup file.
  - QUIT SOS ([link](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking)): SOS satu tombol; guided breathing 10 teknik termasuk box breathing dan alternate nostril; mini-game; artikel; Quity AI (di luar ruang lingkup PRD ini).
  - Pace Android ([repo](https://github.com/ravipurohit1991/pace)): "An offline toolkit: 5-4-3-2-1 grounding, a scene-change reset, sequence and memory games, a share-sheet message to a trusted person, and vetted puzzle links plus the plain timer as a fallback. All of it works with no network and no AI key." Mengonfirmasi grounding 5-4-3-2-1 sebagai tool offline yang layak.
  - Craving To Quit ([link](https://play.google.com/store/apps/details?id=com.claritasmindsciences.CravingToQuit)): program 21 hari berbasis Yale; menyebut urge surfing/mindfulness sebagai inti metode (klaim toko; bukan acuan medis).
- **`refrensi_apk.md:29` (Ringkasan Temuan Terbesar)** — menyebut SOS yang ada (napas 4-7-8, timer 3 menit, distraksi, kartu "ingat alasanmu") sebagai fondasi; menambah tool baru adalah perluasan, bukan penggantian.
- **`refrensi_apk.md:51` (Kondisi Fitur Aktual — SOS)** — "Napas 4-7-8, timer 3 menit, distraksi, hasil intervensi tersimpan di `sos_intervensi` | Hasil intervensi tidak diekspor ke cadangan". Catatan: ekspor cadangan di luar ruang lingkup PRD ini (lihat B1, `refrensi_apk.md:184-189`).
- **`refrensi_apk.md:208-212` (B4. SOS Craving — Hasil Intervensi)** — fitur penyimpanan hasil intervensi sudah diimplementasikan; lanjutan "skor intervensi yang benar-benar membantu" adalah ruang lingkup terpisah, bukan PRD ini.

### 21.2 Referensi UI/UX

- **`refrensi_apk.md:103`** — saran pola: "satu tab SOS dengan kartu pilihan teknik; tetap offline, cepat, tanpa iklan". Menjadi dasar Opsi A pada bagian 9.
- **`refrensi_apk.md:99-102`** — daftar tool beserta aplikasi perujuknya (box breathing, 90 detik, 5-4-3-2-1, urge surfing 10–20 menit, timer 5/10 menit).
- Tidak ada referensi tampilan visual (screenshot) yang disalin; pola disimpulkan dari deskripsi toko/README yang terbaca.

### 21.3 Referensi Alur Pengguna

- **`refrensi_apk.md:103`** — pola "pilih teknik → jalankan → selesai → catat ke `sos_intervensi`" diadopsi di bagian 8.
- **`refrensi_apk.md:209-210`** — alur penyimpanan hasil intervensi yang sudah ada (sheet "Apakah dorongan merokok berkurang?" + opsi tautan diary) dipertahankan, tidak diubah.

### 21.4 Referensi Lainnya

- **`refrensi_apk.md:122-127` (A7. Mini-game Distraksi Offline)** — disebut sebagai fitur berdekatan; **tidak termasuk** ruang lingkup PRD ini.
- **`refrensi_apk.md:143-148` (A10. Implementation Intentions)** — berdekatan dengan SOS ("Rencana Darurat Saya"); **tidak termasuk** ruang lingkup PRD ini.
- **`refrensi_apk.md:82` (bagian A8 AI Coach)** — QUIT SOS/Quity disebut; **tidak termasuk** ruang lingkup PRD ini.
- Prioritas sumber A4 adalah **Sedang**; PRD ini tidak menaikkan/menurunkan prioritas tanpa keputusan pengguna.
