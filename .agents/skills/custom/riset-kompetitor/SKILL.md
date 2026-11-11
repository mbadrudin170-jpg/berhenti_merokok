---
name: riset-kompetitor
description: Panduan melakukan riset kompetitor aplikasi berhenti merokok - mencatat daftar aplikasi serupa di berbagai store (Google Play, Apple App Store, F-Droid, GitHub, Amazon Appstore, APKPure, Aptoide, SlideME, Tencent MyApp, Huawei AppGallery, Samsung Galaxy Store, Uptodown, IzzyOnDroid), menyertakan ringkasan fitur relevan, link store/repositori yang terverifikasi otomatis (curl HTTP 200, iTunes lookup), mengikuti format tabel yang terstandarisasi di apk_serupa.md, serta menyusun laporan referensi mendalam refrensi_apk.md (fitur baru mobile, optimasi fitur eksisting, pola UI/UX/layout, rekomendasi ber-prioritas) dan menandai listing yang sudah dianalisa fitur-fiturnya di section `# Status Analisa Fitur` pada apk_serupa.md. Gunakan saat menambah/memperbarui apk_serupa.md, saat diminta mencari referensi fitur/UI/UX dari seluruh APK yang terdaftar di apk_serupa.md (perintah seperti `.kilo/commands/riset_kompetitor.md`), atau saat diminta menambah aplikasi baru (perintah seperti `.kilo/commands/cari_apk_kompetitor.md`).
metadata:
  kategori: "custom"
  versi: "1.3.0"
  commit-terakhir: "belum-ada-commit"
  model: "openrouter/thinkingmachines/inkling-2-small:free"
---

# Riset Kompetitor Aplikasi Berhenti Merokok

Mengumpulkan dan mendokumentasikan daftar aplikasi kompetitor (serupa) untuk analisis fitur, positioning, dan celah pasar. Hasil riset disimpan dalam format tabel standar di `apk_serupa.md` untuk referensi tim dan stakeholder. Tugas lanjutan "mencarikan referensi dari seluruh APK di apk_serupa.md" menghasilkan dokumen analisis mendalam `refrensi_apk.md` (bukan daftar baru); setelah analisa, listing yang tercakup ditandai lewat section `# Status Analisa Fitur` di akhir `apk_serupa.md` — listing yang ditambahkan setelah tanggal status dianggap belum dianalisa.

## Cakupan yang Di-Cover

- Package: `tidak ada` (dokumentasi non-kode)
- File: `apk_serupa.md` (root proyek) — katalog daftar aplikasi per store, diakhiri section `# Status Analisa Fitur (per YYYY-MM-DD)` sebagai penanda listing yang sudah/belum dianalisa fitur-fiturnya
- File: `refrensi_apk.md` (root proyek) — laporan referensi mendalam dari seluruh APK di `apk_serupa.md`
- Perintah terkait: `.kilo/commands/cari_apk_kompetitor.md` untuk menambah listing baru; `.kilo/commands/riset_kompetitor.md` untuk analisa fitur dari seluruh APK terdaftar
- File wajib dibaca sebelum mengerjakan tugas riset: `README.md`, `AGENTS.md`, `apk_serupa.md`
- Kolom tabel: `Nama Aplikasi`, `Ringkasan Singkat`, `Store`, `Link`
- Struktur `refrensi_apk.md`: informasi riset + cara membaca → ringkasan temuan terbesar → kondisi fitur aktual proyek → A. Rekomendasi fitur baru → B. Optimasi fitur eksisting → C. UI/UX & Layout → D. Katalog semua listing → E. Prioritas gabungan → F. Verifikasi & keterbatasan → G. Sumber
- Store yang didukung: Google Play Store, Apple App Store, F-Droid, GitHub, Samsung Galaxy Store, Uptodown, IzzyOnDroid, Amazon Appstore, APKPure, Aptoide, SlideME, Tencent MyApp, Huawei AppGallery
- Toko yang sering memblokir/menyulitkan akses langsung (Xiaomi GetApps, Oppo App Market, Vivo App Store, Huawei AppGallery, Baidu Mobile Assistant): hanya sertakan aplikasi bila link halaman aplikasi spesifik dapat diverifikasi.
- Kategori relevansi: pelacakan progres, penghematan uang, milestone kesehatan, mode tapering, diary craving, SOS craving, lencana/badge, widget, komunitas, CBT/AI coach, offline-first, backup/restore, gamifikasi

## Aturan

1. Setiap aplikasi **wajib** memiliki nama, ringkasan singkat (maks 2-3 kalimat), nama store/sumber, dan link yang valid.
2. Ringkasan singkat **wajib** menyebutkan fitur-fitur utama yang relevan dengan proyek ini (smoke-free tracking, savings, milestones, tapering, craving diary, badges, widgets, community, CBT, offline-first, dll).
3. Format tabel **wajib** mengikuti standar Markdown pipe (`| Kolom 1 | Kolom 2 | ... |`) dengan header dan separator baris kedua (`| --- | --- | ... |`).
4. Aplikasi dari store yang sama **dikelompokkan** secara berurutan (Google Play → Apple App Store → F-Droid → GitHub → Lainnya).
5. Duplikat nama aplikasi di store berbeda **diperbolehkan** (mis. Kwit di Play Store dan App Store) dengan baris terpisah.
6. Link **wajib** mengarah ke halaman resmi store/repositori (bukan pencarian umum), gunakan format `[Buka Aplikasi](url)`, `[Buka Repositori](url)`, `[Unduh APK](url)`, atau `[Cari Aplikasi](url)` sesuai jenis store.
7. Setiap penambahan/perubahan **wajib** di-commit dengan pesan `docs: ...` dan referensi ke skill ini.
8. **Wajib** verifikasi link masih aktif sebelum commit (cek manual atau otomatis).
9. Untuk riset massal lintas-store, delegasikan pencarian per-store ke subagen paralel, lalu **gabungkan dan verifikasi ulang secara independen** (subagen terbukti dapat mengarang link detail yang 404). Jangan percaya temuan subagen tanpa probe ulang.
10. Verifikasi otomatis dengan: `curl -s -o /dev/null -w "%{http_code}" -A "Mozilla/5.0 (X11; Linux x86_64) Chrome/120.0" -L <url>`. HTTP **200** = valid; HTTP **404** = buang entri; HTTP **403** dari APKPure/Aptoide/SlideME = anti-bot (bukan link mati) — verifikasi via websearch/webfetch, jangan dibuang otomatis.
11. Untuk id aplikasi Apple App Store, gunakan lookup `https://itunes.apple.com/lookup?id=<id>`; `resultCount: 0` berarti aplikasi tidak ada dan **tidak boleh** disertakan. Link per-region (`us`/`gb`/`id`/dst.) boleh dipakai bila mengembalikan 200.
12. Aplikasi Tionghoa/Regional tanpa link halaman aplikasi spesifik yang terverifikasi (mis. 戒烟军团, 今日抽烟, 自律戒烟, 戒烟小目标, 决心戒烟) **tidak boleh** disertakan; keberadaan di store saja (dari sumber sekunder) tidak cukup.
13. Periksa duplikat exact berdasarkan `package id` sebelum menambah baris (mis. `com.siwooeo.quitday` dan `com.siwooeo.quitsmoke` di Samsung Galaxy Store sudah tercatat sebagai QuitDay/QuitSave).
14. Untuk batch besar, tambahkan section `# Tambahan Riset (YYYY-MM-DD)` dengan sub-section `## <Store>`; setiap tabel tetap wajib punya header + separator (tabel yang kehilangan header rusak saat dirender).
15. Untuk tugas "mencarikan referensi dari seluruh APK di `apk_serupa.md`": baca `README.md`, `AGENTS.md`, dan `apk_serupa.md` lebih dulu; **lingkup hanya APK yang terdaftar di `apk_serupa.md`** — jangan menambah aplikasi baru ke daftar tanpa perintah eksplisit. Hasil ditulis/diperbarui di `refrensi_apk.md`.
16. `refrensi_apk.md` wajib memuat: link referensi pada tiap rekomendasi, pengelompokan per fitur (A), optimasi fitur eksisting (B), dan UI/UX/layout (C), penjelasan **tujuan** tiap item, serta **prioritas** (Tinggi/Sedang/Rendah) untuk penyortiran pengguna. Pengguna menyortir sendiri; dokumen ini riset pembanding, bukan keputusan implementasi.
17. Untuk `refrensi_apk.md`: hanya rekomendasikan fitur yang dapat berjalan di mobile. Fitur khusus iOS (Apple Watch, Live Activities, WidgetKit, Wear-only tanpa padanan Android) dicatat sebagai referensi pola saja, bukan rekomendasi. Fitur yang butuh backend/akun (AI coach, komunitas) ditandai jelas dan ditempatkan pada prioritas rendah; proyek ini offline-first.
18. Klasifikasikan status verifikasi listing dengan tiga tingkat: **terverifikasi** (halaman/README/mirror terbaca, atau iTunes `resultCount > 0`, atau curl 200 dengan isi terbaca), **verifikasi ringan** (Samsung Galaxy Store: curl 200 tetapi hanya judul halaman tampil, atau Amazon Appstore tanpa isi detail — cukup untuk ketersediaan, tidak cukup untuk rekomendasi fitur), **tidak terverifikasi** (HTTP 404, 403 tanpa sumber alternatif, halaman kosong, atau listing tidak ditemukan). Cantumkan jumlah perkiraan ("sekitar N dari 159") karena tidak semua listing bisa dibaca; listing tidak terverifikasi (Breev, Quit Smoking Tracker: Stop it App Store, ZeroSmoke, Smoker Reducer, QuitSM SlideME, Flamy Aptoide) tidak dijadikan dasar rekomendasi.
19. Uptodown bisa berputar antara HTTP 410 dan 404 untuk URL yang sama — treat sebagai flaky/rotasi; tandai tidak terverifikasi kecuali ada mirror resmi yang menyebut package id sama (mis. `com.despdev.quitsmoking` di Play Store). Smoke Reducer (`com.java.SmokeReducer`) hanya tersedia sebagai arsip IzzyOnDroid, bukan listing eksak.
20. Temuan cacat kode yang ditemukan saat riset (mis. `buatCadanganJson()` hanya menulis 4 dari 6 tabel yang terdaftar pada `tabelCadangan`) **didokumentasikan di `refrensi_apk.md` dengan prioritas dan path file, tidak diperbaiki** sebagai bagian dari tugas riset. Perbaikan kode adalah tugas terpisah.
21. Sebelum memperbarui `refrensi_apk.md`, periksa `git diff` working tree/staged — jangan menimpa, membangkitkan kembali, atau menggabungkan ulang bagian yang sudah dihapus pengguna (mis. usulan fitur yang dibatalkan); hilangkan pula tautan ke dokumen yang sudah dihapus (mis. `prd/*.md` yang dihapus) dari teks referensi.
22. Amazon Appstore dan Samsung Galaxy Store dapat mengembalikan HTTP 200 langsung pada curl dengan user agent Chrome; Galaxy Store tetap hanya menampilkan judul halaman, sehingga tetap diklasifikasi **verifikasi ringan**. APKPure/Aptoide/SlideME tetap 403 (anti-bot) — verifikasi via websearch/webfetch, bukan dibuang otomatis.
23. Untuk perintah seperti `.kilo/commands/riset_kompetitor.md` (analisa fitur dari seluruh APK terdaftar di `apk_serupa.md`, hasil ditulis ke `refrensi_apk.md`): setelah analisa selesai, **wajib** membuat atau memperbarui section `# Status Analisa Fitur (per YYYY-MM-DD)` di **akhir** `apk_serupa.md`. Section wajib memuat: tanggal analisa, cakupan listing yang dianalisa (total tautan dan section/tambahan yang tercakup), pernyataan bahwa hasil analisa didokumentasikan di `refrensi_apk.md`, dan catatan bahwa listing yang ditambahkan setelah tanggal tersebut belum dianalisa. Format section konsisten dengan section `# Tambahan Riset (YYYY-MM-DD)` (heading `#` di akhir file, tanpa kolom/tabel baru).
24. Untuk perintah seperti `.kilo/commands/cari_apk_kompetitor.md` (menambah listing baru ke `apk_serupa.md`): listing yang baru ditambahkan **wajib** dianggap **belum dianalisa fitur-fiturnya**, meskipun `refrensi_apk.md` sudah ada. Perbarui section `# Status Analisa Fitur` agar menyebutkan bahwa listing baru tersebut menunggu analisa (atau biarkan tanggal status sebagaimana adanya — jangan dimundurkan); jangan pernah menandai listing baru sebagai sudah dianalisa tanpa analisa ulang.
25. Saat menjalankan perintah referensi/analisa, listing yang sudah tercakup section `# Status Analisa Fitur` (tanggal status terakhir) tidak perlu dianalisa ulang kecuali pengguna secara eksplisit meminta analisa ulang; fokus pada listing yang ditambahkan setelah tanggal status terakhir. `refrensi_apk.md` tetap memuat katalog lengkap (seksi D) — perbarui hanya bagian yang terdampak oleh listing baru, jangan tulis ulang dari nol kecuali diminta.
26. Section `# Status Analisa Fitur` tidak pernah dihapus; ini satu-satunya mekanisme penandaan — jangan tambah kolom status ke tabel `apk_serupa.md` dan jangan menyisipkan penanda ke sel tabel.

## Larangan

- DILARANG menambah aplikasi tanpa ringkasan fitur relevan (hanya nama dan link).
- DILARANG menggunakan format tabel non-standar (mis. daftar bullet, JSON, CSV).
- DILARANG mengubah urutan kolom tabel yang sudah ditetapkan.
- DILARANG menghapus aplikasi yang sudah tercatat kecuali aplikasi benar-benar tidak lagi tersedia/tersedia di store resmi.
- DILARANG menyalin ringkasan dari deskripsi store tanpa disesuaikan dengan konteks proyek ini.
- DILARANG menambah kolom baru tanpa memperbarui skill ini dan seluruh baris tabel.
- DILARANG mempercayai link hasil subagen tanpa verifikasi independen (curl / iTunes lookup / webfetch) sebelum commit.
- DILARANG menyertakan aplikasi hanya dari sumber sekunder (situs agregator) tanpa link halaman aplikasi resmi yang terverifikasi.
- DILARANG menganggap HTTP 403 dari APKPure/Aptoide/SlideME sebagai link mati (itu anti-bot); sebaliknya DILARANG menyertakan link ber-HTTP 404 atau id App Store dengan `resultCount: 0`.
- DILARANG menambah tabel tanpa header/separator, atau menumpuk baris batch riset di bawah tabel yang sudah ada tanpa header baru.
- DILARANG merekomendasikan fitur yang tidak dapat berjalan di mobile (Apple Watch, Live Activities, WidgetKit-only) sebagai rekomendasi utama `refrensi_apk.md`.
- DILARANG menganggap Samsung Galaxy Store HTTP 200 + judul halaman sebagai verifikasi penuh isi fitur; hanya ketersediaan (verifikasi ringan).
- DILARANG memperluas lingkup tugas referensi di luar daftar `apk_serupa.md` tanpa perintah eksplisit dari pengguna.
- DILARANG menimpa/membangkitkan kembali bagian `refrensi_apk.md` yang sudah dihapus pengguna, atau menyisakan tautan ke PRD/dokumen yang sudah dihapus, tanpa diminta.
- DILARANG memperbaiki kode aplikasi sebagai bagian dari tugas riset; dokumentasikan temuan dengan path file dan prioritas.
- DILARANG menjadikan listing tidak terverifikasi (atau verifikasi ringan) sebagai dasar rekomendasi fitur atau angka prioritas.
- DILARANG menandai listing sebagai "sudah dianalisa fitur-fiturnya" (atau memajukan tanggal section `# Status Analisa Fitur`) sebelum analisa benar-benar dijalankan dan didokumentasikan di `refrensi_apk.md`.
- DILARANG menambah kolom status ke tabel `apk_serupa.md` atau menyisipkan penanda ke sel tabel; penanda analisa hanya section `# Status Analisa Fitur` di akhir file.
- DILARANG menghapus atau memundurkan tanggal section `# Status Analisa Fitur` karena merugikan pengguna (menyembunyikan fakta bahwa listing baru belum dianalisa); listing baru wajib tetap dianggap belum dianalisa sampai analisa benar-benar dijalankan.
- DILARANG menandai listing yang baru ditambahkan via `cari_apk_kompetitor.md` sebagai sudah dianalisa hanya karena `refrensi_apk.md` versi sebelumnya sudah mencantumkan listing lama.

## Contoh Benar

```markdown
| Nama Aplikasi | Ringkasan Singkat                                                                                                                                                                                 | Store             | Link                                                                                  |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- | ------------------------------------------------------------------------------------- |
| SmokeStop     | Aplikasi berhenti merokok dengan fitur "Savings Goals" yang membiayai target personal dari uang rokok yang dihemat. Relevan dengan fitur impian/target dan progress bar berbasis saldo terkumpul. | Google Play Store | [Buka Aplikasi](https://play.google.com/store/apps/details?id=com.smokestop.tracker)  |
| Kwit          | Aplikasi berhenti merokok berbasis CBT dengan pelacakan progres, penghematan uang, jurnal perjalanan, dan dukungan komunitas. Relevan dengan pelacakan progres, penghematan, dan jurnal craving.  | Google Play Store | [Buka Aplikasi](https://play.google.com/store/apps/details?id=fr.kwit.android)        |
| Kwit          | Aplikasi berhenti merokok berbasis CBT dengan pelacakan progres, penghematan uang, jurnal perjalanan, dan dukungan komunitas. Relevan dengan pelacakan progres, penghematan, dan jurnal craving.  | Apple App Store   | [Buka Aplikasi](https://apps.apple.com/gb/app/quit-smoking-for-good-kwit/id525441365) |
| TrackLess     | Pelacak kebiasaan offline dan privat dengan timer pantang, milestone kesehatan, dan pencadangan JSON lokal. Relevan dengan pendekatan offline-first dan pemantauan progres smoke-free.            | GitHub            | [Buka Repositori](https://github.com/poorangryman/trackless-public)                   |
```

Contoh verifikasi otomatis sebelum commit (riset massal lintas-store):

```bash
# Google Play / Apple App Store / GitHub / F-Droid (200 = valid, 404 = buang)
for u in "<url1>" "<url2>"; do
  code=$(curl -s -o /dev/null -w "%{http_code}" -A "Mozilla/5.0 (X11; Linux x86_64) Chrome/120.0" --max-time 15 -L "$u"); echo "$code  $u"
done

# App Store: cek keberadaan app (resultCount: 0 = tidak ada, jangan sertakan)
curl -s "https://itunes.apple.com/lookup?id=<app_id>" | head -c 300

# APKPure / Aptoide / SlideME sering 403 (anti-bot, bukan mati) -> verifikasi via websearch/webfetch

# Samsung Galaxy Store: curl bisa 200 tetapi hanya judul halaman -> "verifikasi ringan"
curl -s -o /dev/null -w "%{http_code}\n" -L "https://galaxystore.samsung.com/detail/<package>?cntyCd=IDN"
webfetch "https://galaxystore.samsung.com/detail/<package>?cntyCd=IDN"  # baca judul halaman saja
```

Contoh item pada `refrensi_apk.md` (fitur/optimasi/UI-UX diberi tujuan + link + prioritas):

```markdown
#### B1. Ekspor Cadangan Hilangkan Data Konsumsi & Intervensi SOS (bug)

- **Temuan:** `lib/fitur/cadangan/helper/cadangan_helper.dart` — `tabelCadangan`
  mendaftarkan 6 tabel, `buatCadanganJson()` hanya menulis 4 tabel.
- **Tujuan perbaikan:** keamanan data pengguna; konsisten dengan validasi.
- **Referensi:** [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) · [TrackLess](https://github.com/poorangryman/trackless-public)
- **Saran:** tambahkan `konsumsi_rokok` & `sos_intervensi` ke payload ekspor; uji kontrak ekspor↔pulihkan.
- **Prioritas:** Tinggi (integritas data; kerugian senyap).
```

Klasifikasi verifikasi listing:

```text

terverifikasi   -> isi terbaca / iTunes resultCount>0 / mirror resmi package id sama
verifikasi ringan -> Galaxy Store 200 + judul halaman saja; Amazon tanpa isi detail
tidak terverifikasi -> 404/403 tanpa alternatif (Breev, ZeroSmoke, Smoker Reducer,
                      QuitSM SlideME, Flamy Aptoide, Quit Tracker Uptodown 410/404)
```

Contoh section `# Status Analisa Fitur` di akhir `apk_serupa.md` (dibuat/diperbarui setelah menjalankan perintah seperti `riset_kompetitor.md`):

```markdown
# Status Analisa Fitur (per 2026-11-11)

- Seluruh listing yang tercatat di file ini per 2026-11-11 (daftar awal 79 + Tambahan Riset 2026-11-10 + lanjutan 2026-11-10 + 2026-11-11; total 352 tautan) **sudah dianalisa fitur-fiturnya**. Hasil analisa didokumentasikan di `refrensi_apk.md` di root proyek (seksi A–G; katalog listing di seksi D).
- Listing yang ditambahkan setelah 2026-11-11 **belum dianalisa fitur-fiturnya** sampai perintah `riset_kompetitor.md` (atau perintah serupa) dijalankan dan section ini diperbarui dengan tanggal dan cakupan terbaru.
- Perintah `cari_apk_kompetitor.md` hanya menambah listing baru; listing baru tersebut dianggap **belum dianalisa** sampai seksi ini diperbarui setelah analisa dijalankan.
- Saat menjalankan analisa, listing yang sudah tercakup tanggal status ini tidak perlu dianalisa ulang kecuali pengguna meminta analisa ulang; fokus pada listing yang ditambahkan setelah tanggal status terakhir.
```

Alur kerja kedua perintah:

```text
cari_apk_kompetitor.md      -> tambah listing baru ke apk_serupa.md (status: BELUM dianalisa)
riset_kompetitor.md -> analisa fitur listing belum dianalisa -> perbarui refrensi_apk.md
                           -> perbarui section `# Status Analisa Fitur (per <tanggal>)` di akhir apk_serupa.md
```

## Contoh Salah

```markdown
// DILARANG: Ringkasan tidak menyebutkan fitur relevan proyek
| Nama Aplikasi | Ringkasan Singkat | Store | Link |
| ------------- | ----------------- | ----- | ---- |
| SmokeStop | Aplikasi populer untuk berhenti merokok. | Google Play Store | [Buka Aplikasi](https://play.google.com/store/apps/details?id=com.smokestop.tracker) |

// DILARANG: Format link tidak standar
| QuitNow! | Aplikasi dengan komunitas dan milestone. | Google Play Store | https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa |

// DILARANG: Kolom tidak lengkap
| EasyQuit | Mode tapering dan statistik. | Google Play Store | |

// DILARANG: Tabel tidak menggunakan format pipe Markdown

- SmokeFree: Quit smoking slowly - Mode bertahap, notifikasi - Google Play Store - [Link](...)

// DILARANG: Menandai listing baru sebagai sudah dianalisa hanya karena refrensi_apk.md sudah ada
# Status Analisa Fitur (per 2026-11-12)
- Seluruh listing termasuk yang baru ditambahkan hari ini sudah dianalisa.  // BELUM: analisa belum dijalankan

// DILARANG: Menambah kolom status ke tabel apk_serupa.md
| Nama Aplikasi | ... | Analisa |
| --- | --- | --- |
| SmokeStop | ... | ✅ |

// DILARANG: Memajukan tanggal status tanpa analisa, atau menghapus section status
```

## Sumber Evaluasi

- File: `apk_serupa.md` (root proyek), `refrensi_apk.md` (root proyek), `.kilo/commands/riset_kompetitor.md`, `.kilo/commands/cari_apk_kompetitor.md`, `gpt/referensi_apk_sejenis.md`, `gpt/cari_apk_serupa.md`
- Commit rujukan: `a6f3020` — Tambah daftar aplikasi berhenti merokok serupa (85+ aplikasi)
- Commit rujukan: `d174c1b` — Revisi instruksi riset aplikasi sejenis
- Commit rujukan: `f6ad391` — Delegasi pencarian aplikasi serupa ke berkas panduan
- Commit rujukan: `3af4f53` — Tambah riset aplikasi serupa lintas-store (delegasi subagen paralel, verifikasi curl/HTTP 200 + iTunes lookup, 403 anti-bot APKPure/Aptoide/SlideME, section `# Tambahan Riset (2026-11-10)`)
- Commit rujukan: `7cb9c64` — Perbarui skill riset-kompetitor dengan pengetahuan riset lintas-store (kerangka ref. aturan-pembuatan-skill); commit ini memperbarui isi skill tetapi menyisakan metadata `commit-terakhir` menunjuk `3af4f53` (dibawa hingga v1.1.0); diperbaiki pada v1.2.0
- Commit rujukan: `b7f455c` — Perbarui refrensi_apk.md: cakupan 159 tautan listing, hasil verifikasi sumber, metodologi verifikasi, dan analisis referensi (dasar struktur `refrensi_apk.md`, aturan 15–21, contoh item B1, klasifikasi verifikasi)
- Catatan sumber langsung (2026-11-10, probe mandiri, belum di-commit pada `refrensi_apk.md`): Samsung Galaxy Store `com.siwooeo.quitday` & `com.siwooeo.quitsmoke` mengembalikan HTTP 200 dengan judul halaman tampil; Quit Tracker Uptodown berubah dari HTTP 410 menjadi 404; Amazon Appstore mengembalikan 200 langsung dengan UA Chrome
- Instruksi langsung pengguna (2026-11-11, belum di-commit): jika perintah pengguna seperti `.kilo/commands/riset_kompetitor.md`, tandai listing sebagai sudah dianalisa fitur-fiturnya. Diimplementasikan sebagai aturan 23–26 + section `# Status Analisa Fitur (per YYYY-MM-DD)` di akhir `apk_serupa.md` (section dibuat 2026-11-11, mencakup 352 listing) — penanda per-section, bukan kolom tabel
- v1.3.0 (2026-11-11): tambah aturan 23–26, penanda status analisa fitur via section `# Status Analisa Fitur` di `apk_serupa.md`, aturan perintah `cari_apk_kompetitor.md` (listing baru = belum dianalisa), contoh status section, larangan penandaan palsu/kolom status; metadata `commit-terakhir` diset `belum-ada-commit` karena belum di-commit
