# Referensi APK Sejenis

## Informasi Riset

- **Nama proyek:** Berhenti Merokok.
- **Repositori:** [mbadrudin170-jpg/berhenti_merokok](https://github.com/mbadrudin170-jpg/berhenti_merokok).
- **Branch yang diteliti:** `master`.
- **Path dokumen ini:** `refrensi_apk.md` di root proyek.
- **Tanggal penelitian:** 10 November 2026.
- **Cakupan sumber:** seluruh **159 tautan listing** pada `apk_serupa.md` di root proyek (bukan hanya daftar awal 79 entri). Setiap listing diperiksa via `webfetch`/`websearch` pada 10–11 November 2026: Google Play, Apple App Store, F-Droid/IzzyOnDroid, GitHub, Samsung Galaxy Store, Uptodown, Amazon Appstore, APKPure, Aptoide, SlideME, Tencent MyApp, Huawei AppGallery.
- **Hasil verifikasi:** sekitar **142 dari 159 listing berhasil dibaca/diverifikasi isinya**. Sisanya ditandai **tidak terverifikasi** (tautan mati/403/halaman kosong) dan tidak dijadikan dasar rekomendasi: Breev (404), Quit Smoking Tracker: Stop it App Store KW (404), ZeroSmoke (404), Smoker Reducer (listing eksak tidak ditemukan), QuitSM SlideME (403), Flamy Aptoide (403), Quit Tracker Uptodown (404). Verifikasi ulang sampel tautan pada 10 November 2026: Galaxy Store (#74 QuitDay & #75 QuitSave) kini mengembalikan HTTP 200 dan judul halaman tampil ("QuitDay: Quit Smoking & Drink" / "QuitSave: Quit Smoking Tracker") — diverifikasi ringan (ketersediaan + nama aplikasi), detail fitur tidak terbaca penuh.
- **Platform sasaran:** Android (APK/Flutter). Fitur yang hanya berjalan di Apple Watch, Live Activities, WidgetKit iOS, dan macOS **tidak** dijadikan rekomendasi implementasi. Referensi lintas platform tetap dicatat karena polanya dapat memberi ide produk.
- **Metode:** webfetch langsung ke halaman toko/repositori/README; halaman yang gagal diakses diganti sumber alternatif (situs resmi pengembang, mirror store, pencarian web). Fitur iOS yang lolos disaring ke relevansi mobile/Android.

### Cara membaca dokumen ini

1. Dokumen ini adalah **riset pembanding, bukan keputusan implementasi**. Pengguna menyortir sendiri rekomendasi mana yang diterapkan.
2. **Prioritas** mengukur nilai terhadap tujuan aplikasi + kesesuaian Android/offline-first + biaya pemeliharaan. Prioritas bukan perintah mengerjakan.
3. Setiap temuan menyertakan **link referensi**, **tujuan** (fitur/UI/UX), dan **tingkat prioritas**.
4. Klaim angka unduhan/rating pada toko adalah potret sesaat, bukan ukuran kualitas.
5. Deskripsi toko adalah klaim pengembang; data kesehatan wajib diverifikasi ke sumber resmi (WHO/CDC/NHS/AHA) sebelum ditampilkan.
6. **Semua fitur yang disarankan dapat berjalan di perangkat mobile.** Fitur yang membutuhkan backend/komunitas tetap mobile-capable tetapi butuh infrastruktur tambahan — ditandai jelas.
7. Penelitian ini tidak memasang aplikasi kompetitor; pola UI/UX disimpulkan dari deskripsi toko, README, dan screenshot publik.

---

## Ringkasan Temuan Terbesar

Proyek sudah memiliki fondasi yang lebih lengkap daripada quit-tracker dasar: biodata + tapering, dashboard, konsumsi quick log + penanda slip, diary craving + pola jam, SOS (napas 4-7-8, timer 3 menit, distraksi, kartu "ingat alasanmu"), kalender, milestone WHO, badge, impian/tabungan, pengingat harian/check-in pagi/pola craving, backup JSON, pencatat hasil SOS. Karena itu, menambah halaman yang mengulang kemampuan tersebut bukan prioritas.

Peluang terbesar hasil riset terhadap **semua 159 listing**:

1. **Temuan kritis (P Tinggi) — Backup tidak menyertakan data konsumsi dan intervensi SOS.** `CadanganHelper.tabelCadangan` mendaftarkan 6 tabel, tetapi `buatCadanganJson()` hanya menulis 4 tabel (`biodata`, `impian`, `diary_craving`, `alasan_berhenti`). Tabel `konsumsi_rokok` (quick log + slip) dan `sos_intervensi` (riwayat intervensi) **tidak ikut diekspor**. Pengguna yang memulihkan cadangan kehilangan seluruh riwayat konsumsi dan hasil SOS. Perbaikan hanya di sisi ekspor/baca, tanpa migrasi data.
2. **P Tinggi — Widget Android.** Kompetitor dengan tema serupa (SmokingYou, TrackLess, H2M, Flamy, My Tracking App, Quit Smoking Go, ZenQuit, Quitrise, Puff Counter) semuanya punya widget: satu ukuran untuk counter/timer, satu ukuran untuk ringkasan. Akses 1–2 ketuk dari home screen.
3. **P Sedang — Hubungkan konsumsi aktual ke hitungan progres.** Hampir semua kompetitor menghitung progres dari *log aktual*; slip tidak menghapus seluruh progres (anti-shame), tapi yang dihisap tetap mengurangi akumulasi. Proyek saat ini menghitung dari biodata saja; slip belum terhubung.
4. **P Sedang — Pembagian/"share progress card"** (Flamy, Cut Smoking, Quitrise, Quit Smoking Vaping & Nicotine, Stoppy): gambar progres yang dibagikan lewat Android Sharesheet. `share_plus` sudah ada di `pubspec.yaml`.
5. **P Sedang — Check-in pagi mood singkat** (Flamy, ZenQuit, BreatheStreak, Quit Smoking Go, quitSTART): 1 layar, beberapa pilihan, cepat; bukan pengulangan diary.
6. **P Rendah — Anti-shame & pembeda "streak vs perjalanan"** (semua kompetitor modern: Flamy, ClearStack, Stoppy, Nixotine, TrackLess, NoMore, Quit Smoking Vaping & Nicotine soft/hard mode).

---

## Kondisi Fitur Aktual Proyek (ringkas, diperiksa pada `master`)

| Area | Kondisi | Catatan riset |
|---|---|---|
| Navigasi | 4 tab: Dashboard, Biodata, Impian, Lainnya; lazy + IndexedStack (`lib/home.dart`) | Pertahankan; kompetitor juga membatasi destinasi utama |
| Dashboard | Counter, kartu SOS, uang dihemat, target, impian, milestone, badge (`lib/fitur/dashboard/...`) | Audit kepadatan; 1 metrik dominan |
| Biodata/tapering | Dua mode; target harian dari penurunan per minggu; tidak terhubung ke konsumsi aktual | Peluang integrasi |
| Konsumsi | Model `jumlah`, `isSlip`, `catatan`; quick log +1; ringkasan harian | Tidak terhubung ke counter/tapering; tidak diekspor ke cadangan |
| Impian | CRUD, visual tabungan, sorting | Sudah setara kompetitor |
| SOS | Napas 4-7-8, timer 3 menit, distraksi, hasil intervensi tersimpan di `sos_intervensi` | Hasil intervensi tidak diekspor ke cadangan |
| Diary craving | Pemicu, intensitas, `PolaCravingHelper` → jam teratas + pengingat pola | Belum ada heatmap jam/trigger |
| Notifikasi | Harian, check-in pagi, pola craving (platform terbatas) | Pengaturan OK |
| Cadangan | Ekspor/pemulihan JSON, validasi versi, transaksi atomik | **Ekspor tidak menulis `konsumsi_rokok` & `sos_intervensi`** |
| Milestone/badge | Milestone WHO 20 menit s/d 15 tahun; badge durasi/rokok/uang/impian | Label sumber perlu jelas |
| Tema | Sistem/terang/gelap | OK |
| Teknologi | Riverpod, Freezed, sqflite, `share_plus`, **tanpa fl_chart/grafik** | Grafik butuh dependency baru |

---

## A. Rekomendasi Fitur Baru (yang dapat berjalan di mobile)

Setiap item: **Fitur → Tujuan → Referensi (link) → Saran implementasi (offline-first jika memungkinkan) → Prioritas.**
Fitur yang hanya berjalan di Apple Watch/iOS Live Activities dilewatkan. Semua rekomendasi dapat berjalan di Android; sebagian juga di iOS.

### Prioritas Tinggi

#### A1. Widget Home Screen Android

- **Tujuan fitur:** akses progres dan tindakan kritis (SOS/log) tanpa membuka aplikasi.
- **Referensi:** [SmokingYou](https://f-droid.org/en/packages/com.smokingtracker) · [TrackLess](https://github.com/poorangryman/trackless-public) · [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke) · [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) · [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app) · [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) · [ZenQuit](https://play.google.com/store/apps/details?id=com.zenquit.habit) · [Quitrise](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise) · [Stop Smoking Day Counter](https://play.google.com/store/apps/details?id=smokefree.daycounter.quitsmoking) · [Qwit Nicotine (Wear OS tile)](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny).
- **Pola referensi:** dua ukuran (kecil = satu tindakan/angka; besar = ringkasan timer + uang + rokok dihindari), tema terang/gelap, widget 1×1/2×1 untuk tombol cepat. Pace Android juga punya widget dengan glass panel (Material You).
- **Saran:** mulai dari widget kecil (buka SOS + log +1); ikuti tema aplikasi; data dibagikan lewat saluran native (AppWidget/Glance), bukan dialog Flutter; jangan tampilkan nama/data sensitif. Baru tambahkan widget statistik di tahap kedua.
- **Catatan:** membutuhkan kode native Android — satu-satunya fitur baru yang menuntut lapisan non-Dart.
- **Prioritas:** Tinggi.

### Prioritas Sedang

#### A2. Kartu Progres yang Dapat Dibagikan (shareable card)

- **Tujuan fitur:** merayakan progres atau meminta dukungan; pengguna memilih elemen yang terlihat.
- **Referensi:** [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) · [Cut Smoking](https://play.google.com/store/apps/details?id=com.nfm.aval024) · [Quitrise](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise) · [Quit Smoking Vaping & Nicotine](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) · [Stoppy](https://apps.apple.com/us/app/stoppy-quit-smoking-vaping/id6771973568) · [Quit Save](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke) · [Smoke Free (Portable Pixels)](https://play.google.com/store/apps/details?id=com.portablepixels.smokefree) · [QuitPath](https://play.google.com/store/apps/details?id=com.hernanmr.QuitSmoking).
- **Pola referensi:** kartu berisi hari smoke-free + uang dihemat (label estimasi) + badge; dibagikan melalui Android Sharesheet. `share_plus` sudah tersedia.
- **Saran:** elemen default minimal (tanpa nama, tanpa tanggal persis); tawarkan opsi tampilkan/sembunyikan uang; beri watermark kecil nama aplikasi; jelaskan uang = estimasi lokal.
- **Prioritas:** Sedang.

#### A3. Check-in Harian Singkat (mood/kondisi, ≤10 detik)

- **Tujuan fitur:** refleksi harian dan deteksi dini hari yang berisiko craving; bukan menggantikan diary.
- **Referensi:** [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) (check-in setelah slip 24/72 jam) · [ZenQuit](https://play.google.com/store/apps/details?id=com.zenquit.habit) · [BreatheStreak](https://play.google.com/store/apps/details?id=com.breathe.streak.app.breathqxa) · [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) (5 mood + diary) · [quitSTART](https://play.google.com/store/apps/details?id=com.mmgct.quitstart) · [Quit Smoking Vaping & Nicotine](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) (daily check-in mood) · [QuitPath](https://play.google.com/store/apps/details?id=com.hernanmr.QuitSmoking) · [Stosmok](https://play.google.com/store/apps/details?id=com.anggastudio.stosmok).
- **Saran:** 3–5 pilihan mood + craving hari ini (ya/tidak/intensitas), tampil sesaat setelah buka aplikasi pada hari tertentu, bisa dilewati; simpan sebagai tabel ringan `check_in_harian`; jangan memaksa setiap hari.
- **Prioritas:** Sedang.

#### A5. Grafik & Heatmap Tren (Statistik Konsumsi/Craving)

- **Tujuan fitur:** tren 7/30/90 hari menggantikan angka statis; heatmap jam craving; donut pemicu.
- **Referensi:** [TrackLess](https://github.com/poorangryman/trackless-public) (analisis 14 hari, pola pagi/siang/sore/malam) · [Smoking Tracker](https://f-droid.org/en/packages/com.gasperpintar.smokingtracker) · [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app) (chart + forecast) · [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20) (7/30 hari, mingguan) · [LastCig](https://play.google.com/store/apps/details?id=com.lastcig.app) (heatmap, 12 sistem tubuh) · [Wah: SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20) · [Quit Smoking Vaping & Nicotine](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) (heatmap 365 hari) · [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) (heatmap 30 hari) · [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) (heatmap kalender).
- **Saran:** layar Analitik terpisah dari Dashboard; butuh `fl_chart`/`fl_heatmap` (belum ada di `pubspec.yaml` — dependency baru); tampilkan empty state minimum 3 data; beri judul + satuan + rentang tanggal di tiap grafik.
- **Prioritas:** Sedang (menunggu data cukup & definisi metrik stabil).

#### A6. Anti-Shame / Streak Shield (tidak reset progres setelah slip)

- **Tujuan fitur:** pengguna melaporkan slip jujur tanpa kehilangan seluruh progres; bahasa suportif.
- **Referensi:** [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) · [ClearStack](https://play.google.com/store/apps/details?id=com.clearstackapps.smokefree) · [Stoppy](https://apps.apple.com/us/app/stoppy-quit-smoking-vaping/id6771973568) (best streak dipertahankan) · [Nixotine](https://apps.apple.com/us/app/nixotine-quit-vaping/id6788731578) · [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) · [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) (undo slip) · [QuitWin](https://play.google.com/store/apps/details?id=com.elevatedev.quitwin) · [No Smoke](https://play.google.com/store/apps/details?id=com.havabee.nosmoke) (Streak Shield) · [NicoQuit](https://play.google.com/store/apps/details?id=com.nicoquit.nico_quit) (streak shield) · [Quit Smoking Vaping & Nicotine](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) (mode soft = streak dipertahankan / hard = reset).
- **Saran:** dipisahkan antara **streak saat ini** dan **perjalanan kumulatif** (hari total + uang dihemat tidak terhapus). Mode default anti-shame; opsi reset eksplisit bila pengguna ingin.
- **Prioritas:** Sedang (bersamaan dengan B2/B5).

### Prioritas Rendah

#### A7. Mini-game Distraksi Offline

- **Tujuan fitur:** variasi coping 3–5 menit saat craving; offline, tanpa iklan.
- **Referensi:** [QUIT SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking) (mini-game) · [EasyQuit](https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking) (matching pairs) · [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) · [Quitrise](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise) · [Pace Android](https://github.com/ravipurohit1991/pace) (arcade + trivia + emoji) · [NicoQuit](https://play.google.com/store/apps/details?id=com.nicoquit.nico_quit) (boss battle) · [Quit Smoking Vaping & Nicotine](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) (idle clicker "Crush Addiction") · [PuffGone](https://play.google.com/store/apps/details?id=com.puffgone.app) (tap game) · [Stop Smoking Day Counter](https://play.google.com/store/apps/details?id=smokefree.daycounter.quitsmoking).
- **Saran:** mulai dari **1 game** (matching pairs, efektif, sudah terbukti EasyQuit); jangan menutup akses napas/timer; pertimbangkan dari aspek aksesibilitas dan performa.
- **Prioritas:** Rendah.

#### A8. AI Coach (opsional, berbasis skenario terbatas)

- **Tujuan fitur:** dukungan personal saat craving/motivasi; harus ada fallback offline.
- **Referensi:** [Qwit](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny) (AI quit coach) · [QUIT SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking) (Quity) · [QuitNic AI](https://play.google.com/store/apps/details?id=store.evsi.quitsmoke) · [Pace Android](https://github.com/ravipurohit1991/pace) (Ollama Cloud, user API key) · [Jones](https://play.google.com/store/apps/details?id=com.jonesforquitters.app) (Coach Jones + Quittle game) · [Quit Smoking Now AI Buddy](https://apps.apple.com/us/app/quit-smoking-now-ai-buddy/id6449152501) · [Quit Smoking: Progress Tracker](https://play.google.com/store/apps/details?id=com.inspectorstudios.quitsmokingprogresstracker) · [Ouiquit](https://apps.apple.com/fr/app/ouiquit/id1482743031) (coach Pierre) · [Kick It](https://apps.apple.com/us/app/kick-it-quit-smoking-vaping/id6473648667) (human coach via telepon/chat — bukan AI, alternatif).
- **Saran:** **bukan chatbot bebas.** Rancang basis konten CBT yang ditinjau (hal serupa QUIT SOS/QuitSure), batasan medis eksplisit, fallback ke SOS saat offline, jangan kirim data diary sensitif tanpa persetujuan, dan hitung biaya backend. Fitur ini bertentangan dengan prinsip offline-first tanpa keputusan sadar.
- **Prioritas:** Rendah.

#### A9. Gamifikasi Lanjutan (level, misi harian, opsional)

- **Tujuan fitur:** memperpanjang retensi; **harus opt-in dan bisa dinonaktifkan.**
- **Referensi:** [Quitrise](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise) (50 level + 65 badge + misi harian) · [NicoQuit](https://play.google.com/store/apps/details?id=com.nicoquit.nico_quit) (XP + boss battle) · [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) · [Lungo](https://trylungo.com/) (maskot katak + XP) · [Cut Smoking](https://play.google.com/store/apps/details?id=com.nfm.aval024) · [RootedLife](https://play.google.com/store/apps/details?id=com.neonbug.rootedlife) (hutan virtual tumbuh) · [Stosmok](https://play.google.com/store/apps/details?id=com.anggastudio.stosmok) (naga 6 tahap) · [PuffGone](https://play.google.com/store/apps/details?id=com.puffgone.app) (virtual garden Seed→Legend) · [Smoke Tracker freedom_from_smoke](https://play.google.com/store/apps/details?id=com.trifoiltrailblazer.freedom_from_smoke) (taman visual) · [Ouiquit](https://apps.apple.com/fr/app/ouiquit/id1482743031) (tanaman totem).
- **Saran:** proyek sudah punya badge; tambahkan sparingly: misi harian 1 baris + XP sederhana; jangan tambahkan lebih dari satu sistem reward; opsi "Mode Minimal" untuk pengguna yang tidak suka gamifikasi.
- **Prioritas:** Rendah.

#### A10. Implementation Intentions (Jika–Maka) untuk Craving

- **PRD:** [prd/implementation_intention_craving.md](prd/implementation_intention_craving.md) (Draft, dibuat 2026-11-10, belum diimplementasikan)
- **Tujuan fitur:** pengguna menulis rencana "jika craving saat X, maka saya lakukan Y"; dibuktikan menurunkan slip dalam studi kebiasaan.
- **Referensi:** [Pace Android](https://github.com/ravipurohit1991/pace) (Playbook if-then plans) · [Flamy — SOS Emergency Setup](https://apps.apple.com/us/app/quit-smoking-smoke-free-flamy/id1462887052) · [Intervensi CBT Craving To Quit](https://play.google.com/store/apps/details?id=com.claritasmindsciences.CravingToQuit) · [QuitNow Medicon — 9 hari, 8 latihan CBT](https://apps.apple.com/us/app/quitnow-stop-smoking/id6768372199).
- **Saran:** layar kecil "Rencana Darurat Saya" (Jika …, Maka …) ditampilkan di kartu SOS; disimpan lokal; maks 3 rencana.
- **Prioritas:** Rendah.

#### A11. Letters to Future Self

- **Tujuan fitur:** surat motivasi yang muncul otomatis pada milestone (7/30/90 hari).
- **Referensi:** [Nicotine Free](https://apps.apple.com/us/app/nicotine-free-quit-vape-zyn/id6810766797) · [Ouiquit — journal envies/relapse](https://apps.apple.com/fr/app/ouiquit/id1482743031) · inspirasi umum dari "Stop Smoking Day Counter" (AI plan + daily check-in).
- **Saran:** teks disimpan lokal; tampil sekali pada milestone; bisa diedit sebelum/sesudah; tanpa pengiriman eksternal.
- **Prioritas:** Rendah.

#### A12. NRT / Terapi Pengganti Nikotin Tracker

- **Tujuan fitur:** mencatat patch/permen/inhaler dan jadwal pengurangannya; pengguna tapering yang juga memakai NRT.
- **Referensi:** [Kwit](https://play.google.com/store/apps/details?id=fr.kwit.android) (NRT + gum/patch + e-cig) · [Qwit Nicotine](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny) · [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) (tracking NRT) · [Smoke Tracker freedom_from_smoke](https://play.google.com/store/apps/details?id=com.trifoiltrailblazer.freedom_from_smoke) (NRT & obat) · [Jones](https://play.google.com/store/apps/details?id=com.jonesforquitters.app) (NRT mints 4→2→0 mg).
- **Saran:** daftar produk + jadwal pengurangan; model lokal `nrt_entri`; notifikasi jadwal; tampil di layar Lainnya.
- **Prioritas:** Rendah.

#### A13. Pengingat 30 Menit Sebelum Jam Rawan Craving

- **Tujuan fitur:** mengingatkan sebelum jendela risiko berdasarkan pola jam pengguna (hanya jika data cukup).
- **Referensi:** [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) (30-minute heads-up sebelum time-of-day rentan) · [quitSTART](https://play.google.com/store/apps/details?id=com.mmgct.quitstart) (drop-a-pin trigger lokasi) · proyek sudah punya pengingat pola craving — ini memperluas konsepnya.
- **Saran:** gunakan `PolaCravingHelper`; syarat ≥5 entri pada jam yang sama; tawarkan opt-in; tampilkan sekali/hari maks; jangan membuat keputusan medis.
- **Prioritas:** Rendah.

#### A14. Mode Multi-Kebiasaan (opsional, di luar inti)

- **Tujuan fitur:** melacak kebiasaan lain (vape, gula, alkohol, kopi) pada mesin streak yang sama.
- **Referensi:** [Quitzilla](https://apps.apple.com/us/app/quitzilla-quit-tracker/id1533076568) · [Qit](https://play.google.com/store/apps/details?id=org.buldev.qit.androidApp) · [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) · [Sobriety](https://f-droid.org/packages/com.katiearose.sobriety/) · [QuitStreak](https://play.google.com/store/apps/details?id=com.mintsoft.quitstreak) · [iQuit](https://apps.apple.com/us/app/iquit-smoking-quit-plan/id6504419691) · [Nicotine Free](https://apps.apple.com/us/app/nicotine-free-quit-vape-zyn/id6810766797).
- **Saran:** jangan memperluas v1; catat sebagai ide arsitektur (model generik `kebiasaan`) untuk jangka panjang; banyak kompetitor kecil gagal karena scope terlalu luas.
- **Prioritas:** Rendah.

---

## B. Optimasi Fitur yang Sudah Ada (sama seperti proyek, tapi bisa diperbaiki)

### Prioritas Tinggi

#### B1. **Ekspor Cadangan Hilangkan Data Konsumsi & Intervensi SOS (bug)**

- **Temuan:** `lib/fitur/cadangan/helper/cadangan_helper.dart` — `tabelCadangan` mendaftarkan 6 tabel, tetapi `buatCadanganJson()` hanya menulis 4 (`biodata`, `impian`, `diary_craving`, `alasan_berhenti`). Tabel `konsumsi_rokok` (quick log + slip) dan `sos_intervensi` tidak diekspor. Validasi memperlakukan tabel kosong sebagai wajar, sehingga pemulihan tidak error — hanya data hilang senyap.
- **Tujuan perbaikan:** keamanan data pengguna; konsisten dengan validasi dan README teknis.
- **Saran:** tambahkan kedua tabel ke payload ekspor dan catat ukurannya di log; tambahkan uji kontrak ekspor↔pulihkan; tampilkan ringkasan isi cadangan (jumlah baris per tabel) di layar Cadangan. Juga pertimbangkan pratinjau isi/versi sebelum memulihkan.
- **Prioritas:** Tinggi (integritas data; kerugian senyap).

### Prioritas Sedang

#### B2. Hubungkan Konsumsi Aktual ke Counter, Tapering, dan Tabungan

- **Tujuan:** satu sumber kebenaran; slip mengurangi akumulasi tanpa menghapus perjalanan; tapering membandingkan target vs aktual.
- **Referensi (semua kompetitor dengan pola serupa):** [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) · [QuitSave](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke) · [Smoking Tracker](https://f-droid.org/en/packages/com.gasperpintar.smokingtracker) · [Pace Android](https://github.com/ravipurohit1991/pace) · [Smoke Tracker freedom_from_smoke](https://play.google.com/store/apps/details?id=com.trifoiltrailblazer.freedom_from_smoke) · [Breathing Room](https://github.com/anindya127/Breathing-Room) · [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20).
- **Pola:** baseline awal → target harian (tapering) → log aktual → sisa di atas baseline = "uang tidak dihemat lagi"; slip = rokok aktual mengurangi `rokokTidakDiHisap`/`uangDihemat` secara proporsional, bukan reset.
- **Saran:** definisikan rumus bersama di satu helper; tampilkan "estimasi" vs "aktual" pada Dashboard; metrik tapering menampilkan target hari ini vs aktual.
- **Prioritas:** Sedang.

#### B3. Konsumsi — Undo & Koreksi Cepat

- **Tujuan:** mengurangi kesalahan input quick log; koreksi tidak menjangkau form panjang.
- **Referensi:** [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app) (undo entri/penghapusan) · [Pace Android](https://github.com/ravipurohit1991/pace) (undo 12 detik) · [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) (undo slip) · [Breathing Room](https://github.com/anindya127/Breathing-Room) · [SmokingYou](https://f-droid.org/en/packages/com.smokingtracker).
- **Saran:** snackbar "Urungkan (10 detik)" setelah quick log; entri dapat diedit dari ketuk item riwayat; konfirmasi sebelum mengubah jumlah bila metrik terikat.
- **Prioritas:** Sedang.

#### B4. SOS Craving — Hasil Intervensi (sudah diimplementasikan)

- **Status:** tabel `sos_intervensi` tersedia (migrasi v11), riwayat intervensi tersimpan setelah penyelesaian SOS, opsi tautan ke diary. Tetap cantumkan sebagai fitur selesai; target lanjutan: **skor "intervensi yang benar-benar membantu"** untuk personalisasi urutan menu SOS.
- **Referensi:** [SmartQuit](https://github.com/ShreyNagda/smartquit) (efektivitas intervensi dari statistik craving) · [Quit Smoking: Progress Tracker](https://play.google.com/store/apps/details?id=com.inspectorstudios.quitsmokingprogresstracker) · [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20) (hasil coping) · [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke) (analisis pola craving).
- **Prioritas:** Rendah (lanjutan).

#### B5. Slip — Tampilkan Dampak Sebelum Simpan + Bahasa Netral

- **Tujuan:** preview perubahan metrik sebelum pengguna menyimpan slip; hapus bahasa menyalahkan.
- **Referensi:** [Nixotine](https://apps.apple.com/us/app/nixotine-quit-vaping/id6788731578) (slip tanpa malu) · [Flamy — check-in 24/72 jam setelah slip](https://apps.apple.com/us/app/quit-smoking-smoke-free-flamy/id1462887052) · [ClearStack](https://play.google.com/store/apps/details?id=com.clearstackapps.smokefree) · [TrackLess](https://github.com/poorangryman/trackless-public) · [Quit Smoking Vaping & Nicotine — soft/hard mode](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) · [QuitWin](https://play.google.com/store/apps/details?id=com.elevatedev.quitwin).
- **Saran:** dialog ringkasan "Setelah ini: streak → 0, uang dihemat −X, perjalanan tetap" sebelum simpan; ganti warna merah dengan info + ikon netral; sertakan teks dukungan ("slip bukan kegagalan…").
- **Prioritas:** Sedang.

#### B6. Diary Craving — Heatmap Jam & Pemicu

- **Tujuan:** visualisasi kapan dan karena apa craving muncul; memakai data yang sudah dikumpulkan.
- **Referensi:** [TrackLess](https://github.com/poorangryman/trackless-public) (pola pagi/siang/sore/malam) · [LastCig](https://play.google.com/store/apps/details?id=com.lastcig.app) (heatmap) · [QuitPath](https://play.google.com/store/apps/details?id=com.hernanmr.QuitSmoking) (heatmap craving) · [Quit Smoking Vaping & Nicotine](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) (365-day heatmap) · [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) (time/day) · [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20) (trigger analytics) · [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) (calendar heat-map) · [Ouiquit](https://apps.apple.com/fr/app/ouiquit/id1482743031) (analisis jam).
- **Saran:** tambahkan heatmap 24 jam (grid 7×24) dan donut pemicu; butuh grafik (dependency baru); gabungkan dengan pengingat pola (A13) bila data ≥10 entri.
- **Prioritas:** Sedang.

### Prioritas Rendah

#### B7. Notifikasi — Jam Tenang & Batas Frekuensi

- **Tujuan:** tidak membanjiri; tenang pada jam tidur; adaptif hanya dengan data cukup.
- **Referensi:** [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) · [Pace Android](https://github.com/ravipurohit1991/pace) (morning hold, quiet hours) · [SmokingYou](https://f-droid.org/en/packages/com.smokingtracker) · [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) · [quitSTART](https://play.google.com/store/apps/details?id=com.mmgct.quitstart).
- **Saran:** jam tenang global; maks 1 notifikasi/hari per kategori; opsi pengingat adaptif opt-in.
- **Prioritas:** Rendah.

#### B8. Backup — Impor/Ekspor CSV + Pratinjau

- **Tujuan:** analisis di luar aplikasi; portabilitas.
- **Referensi:** [Quitrise (Pro CSV export)](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise) · [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20) (CSV export + backup preview + merge/replace) · [PuffGone](https://play.google.com/store/apps/details?id=com.puffgone.app) (CSV lokal) · [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app) (CSV backup/restore) · [Quitzilla](https://apps.apple.com/us/app/quitzilla-quit-tracker/id1533076568) · [ClearStack](https://play.google.com/store/apps/details?id=com.clearstackapps.smokefree) (JSON + hapus semua) · [Pace Android](https://github.com/ravipurohit1991/pace) · [TrackLess](https://github.com/poorangryman/trackless-public) · [SmokingYou](https://f-droid.org/en/packages/com.smokingtracker) · [Breathing Room](https://github.com/anindya127/Breathing-Room) · [Sobriety](https://f-droid.org/packages/com.katiearose.sobriety/).
- **Saran:** mulai dari **ekspor CSV** (sisi baca saja, risiko rendah); merge/replace opsional dengan aturan konflik eksplisit; pratinjau isi backup sebelum pulihkan.
- **Prioritas:** Rendah.

#### B9. Impian — Visual yang Tidak Menyesatkan

- **Tujuan:** menjaga motivasi tanpa memberi kesan uang sudah "masuk rekening".
- **Referensi:** [Quitchi](https://play.google.com/store/apps/details?id=com.quitchi.app) (tanaman tumbuh + wishlist) · [RootedLife](https://play.google.com/store/apps/details?id=com.neonbug.rootedlife) (hutan virtual) · [Stosmok](https://play.google.com/store/apps/details?id=com.anggastudio.stosmok) (naga) · [PuffGone](https://play.google.com/store/apps/details?id=com.puffgone.app) (virtual garden) · [QuitSave](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke) (toples piggy bank) · [Breev](https://play.google.com/store/apps/details?id=com.aura.stopsmoking) (tidak terverifikasi — 404) · [ZenQuit](https://play.google.com/store/apps/details?id=com.zenquit.habit) (hints leveling).
- **Saran:** pertahankan progress bar yang ada; label "estimasi uang dihemat" wajib; metafora visual (mis. toples/progress) boleh ditambah opsional; jangan menyatakan uang benar-benar tertabung.
- **Prioritas:** Rendah.

#### B10. Pemulihan Kesehatan & Badge — Label Sumber Jelas

- **Tujuan:** menghindari klaim medis berlebihan.
- **Referensi (apps yang mencantumkan sumber dengan baik):** [ClearStack](https://play.google.com/store/apps/details?id=com.clearstackapps.smokefree) (milestone NHS/CDC dengan kutipan) · [My Last Cigarette](https://apps.apple.com/gb/app/my-last-cigarette/id639202516) (CO, risiko jantung — sedari 1999) · [LastCig](https://play.google.com/store/apps/details?id=com.lastcig.app) · [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) · [QuitNow Medicon](https://apps.apple.com/us/app/quitnow-stop-smoking/id6768372199) (CDC/Cochrane).
- **Saran:** tampilkan "bersumber WHO/CDC/NHS, perkiraan ilustratif"; jangan menaikkan angka personil; hindari istilah "menyembuhkan".
- **Prioritas:** Rendah.

---

## C. UI, UX & Layout — Kompetitor dengan Fitur Serupa + Pola yang Teridentifikasi

Setiap pola menyertakan **aplikasi kompetitor yang punya fitur serupa dengan proyek**, **pola UI/UX/layout**, **tujuan**, dan **saran**. Pengguna menyortir sendiri.

### Prioritas Tinggi

#### C2. Log Konsumsi Satu Ketukan dengan Undo yang Terjangkau

- **Aplikasi serupa:** [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app) (quick log + undo) · [SmokingYou](https://f-droid.org/en/packages/com.smokingtracker) · [Smoking Tracker](https://f-droid.org/en/packages/com.gasperpintar.smokingtracker) · [Pace Android](https://github.com/ravipurohit1991/pace) (undo 12 detik, catatan quick) · [TrackLess](https://github.com/poorangryman/trackless-public) · [Cut Smoking](https://play.google.com/store/apps/details?id=com.nfm.aval024).
- **Pola UI:** tombol +1 menonjol (FAB); umpan balik instan setelah log; opsi undo langsung; detail jumlah/tanggal/catatan di layar terpisah.
- **Pola UX:** tidak menuntut form untuk pencatatan harian; kesalahan dapat dibatalkan seketika.
- **Pola layout:** FAB utama di Dashboard dan tab Konsumsi; bottom sheet umpan balik berisi tombol "Urungkan".
- **Kondisi proyek:** quick log +1 ada; koreksi lewat form; undo belum ada (B3).
- **Tujuan pola:** data akurat → metrik lain bisa dipercaya.
- **Prioritas:** Tinggi.

### Prioritas Sedang

#### C4. Anti-Shame Slip & Pembedaan Streak vs Perjalanan

- **Aplikasi serupa:** [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) · [ClearStack](https://play.google.com/store/apps/details?id=com.clearstackapps.smokefree) · [Stoppy](https://apps.apple.com/us/app/stoppy-quit-smoking-vaping/id6771973568) · [Nixotine](https://apps.apple.com/us/app/nixotine-quit-vaping/id6788731578) · [Quit Smoking Vaping & Nicotine](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) · [TrackLess](https://github.com/poorangryman/trackless-public) · [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) · [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) · [Quit Smoking — Stop Tracker](https://play.google.com/store/apps/details?id=com.buggedapps.quitsmoking).
- **Pola UI:** slip dicatat sebagai peristiwa, bukan "kegagalan"; penanda warna tidak hanya merah; label "perjalanan kumulatif" terpisah dari "streak saat ini"; check-in setelah slip (Flamy: 24/72 jam).
- **Pola UX:** pengguna terdorong melaporkan honest state tanpa malu; keterlibatan meningkat.
- **Pola layout:** dialog sebelum simpan slip (lihat B5); penjelasan singkat dampak metrik.
- **Kondisi proyek:** slip belum memengaruhi metrik; bahasa perlu diaudit.
- **Prioritas:** Sedang.

#### C5. Widget Android Sederhana & Adaptif

- **Aplikasi serupa:** [SmokingYou](https://f-droid.org/en/packages/com.smokingtracker) · [TrackLess](https://github.com/poorangryman/trackless-public) · [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app) · [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke) · [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) · [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) · [ZenQuit](https://play.google.com/store/apps/details?id=com.zenquit.habit) · [Quitrise](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise) · [QuitSave](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke) · [Stop Smoking Day Counter](https://play.google.com/store/apps/details?id=smokefree.daycounter.quitsmoking) · [Qwit (Wear OS)](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny) · [Flamy (Wear OS tile)](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy).
- **Pola UI:** 1×1 (satu angka/tindakan), 2×1/4×2 (ringkasan), tema gelap/terang; teks besar terbaca; touch target ≥48dp.
- **Pola UX:** informasi utama tanpa membuka aplikasi; tidak bocor data sensitif di lock screen.
- **Pola layout:** widget menampilkan: timer smoke-free + uang + tombol SOS (atau tombol log +1).
- **Kondisi proyek:** belum ada widget.
- **Prioritas:** Sedang-tinggi (bersamaan A1).

#### C6. Kalender & Heatmap Progress

- **Aplikasi serupa:** [QuitSave](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke) · [Cut Smoking](https://play.google.com/store/apps/details?id=com.nfm.aval024) · [Quit Smoking Vaping & Nicotine](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) (365-day) · [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) (heat-map) · [QuitPath](https://play.google.com/store/apps/details?id=com.hernanmr.QuitSmoking) · [Smoke Tracker freedom_from_smoke](https://play.google.com/store/apps/details?id=com.trifoiltrailblazer.freedom_from_smoke) (kalender penuh) · [Breath](https://play.google.com/store/apps/details?id=com.aydemir.breath) (calendar color-coded) · [Quit Smoking Go — victory calendar](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) · [Smoke Free (AntoTech)](https://play.google.com/store/apps/details?id=com.antotech.smokefree) (victory calendar).
- **Pola UI:** kalender bulan dengan penanda hari bersih; heatmap tahun (grid 7×53); tanggal interaktif; legenda jelas.
- **Pola UX:** progres terlihat sekilas; motivasi visual; juga menyediakan "hari kembali setelah slip" tanpa menghapus histori.
- **Pola layout:** kalender bulanan di halaman khusus; heatmap 30/365 hari di Analitik.
- **Kondisi proyek:** kalender smoke-free sudah ada; heatmap belum.
- **Prioritas:** Sedang.

### Prioritas Rendah

#### C7. Impian/Tabungan dengan Metafora Visual Opposional

- **Aplikasi serupa:** [Quitchi](https://play.google.com/store/apps/details?id=com.quitchi.app) · [RootedLife](https://play.google.com/store/apps/details?id=com.neonbug.rootedlife) · [PuffGone](https://play.google.com/store/apps/details?id=com.puffgone.app) · [Stosmok](https://play.google.com/store/apps/details?id=com.anggastudio.stosmok) · [ZenQuit](https://play.google.com/store/apps/details?id=com.zenquit.habit) · [Quit Smoking Vaping & Nicotine](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) (idle clicker) · [LungO](https://trylungo.com/) (maskot).
- **Pola UI:** objek tumbuh mengikuti progres; wishlist; warna sejuk; tidak ramai.
- **Pola UX:** tujuan abstrak terasa konkret; tetap transparan (label "estimasi").
- **Pola layout:** kartu impian + objek visual kecil; detail terpisah.
- **Saran:** pertahankan progress bar; tambah opsi tema visual (mis. "Toples"/"Pohon"); jangan menggantikan data dengan dekorasi.
- **Prioritas:** Rendah.

---

## D. Katalog Semua 159 Listing pada `apk_serupa.md`

Keterangan: **Platform** = Android / iOS / keduanya. **✓** = halaman/repositori dapat diakses & dibaca; **✗** = tidak terverifikasi (404/403/kosong); **Duplikat** = listing toko lain dari produk yang sama (bukan kompetitor baru). Kolom "Fitur terverifikasi" ringkas; detail bukan pengganti membaca sumber asli.

### D.1 Google Play Store (66 listing: 59 halaman detail + 7 tautan pencarian, nomor 4–11, 24–32, 48–54, 55–73, 80–103)

| No. | Aplikasi (link) | Platform | Fitur terverifikasi (ringkas) | Kegunaan |
|---|---|---|---|---|
| 4 | [SmokeStop](https://play.google.com/store/apps/details?id=com.smokestop.tracker) | Android | Timer, kalkulator uang + savings goal, timeline WHO/AHA, SOS 60 detik, widget, kartu progres, tips harian | Widget, share card |
| 5 | [Quitchi](https://play.google.com/store/apps/details?id=com.quitchi.app) | Android | Timer, wishlist + tanaman virtual, breathing SOS, komunitas, jurnal (Pro) | Impian visual |
| 6 | [EasyQuit](https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking) | Android | Slow mode tapering, statistik uang + trigger pie chart, matching game, badge | Tapering, mini-game |
| 7 | [Kwit](https://play.google.com/store/apps/details?id=fr.kwit.android) (duplikat iOS #8) | Android | CBT, diary craving/relapse, NRT tracker, 9 hari prep, akun/cloud | CBT, NRT |
| 9 | [Quit Tracker (despDev)](https://play.google.com/store/apps/details?id=com.despdev.quitsmoking) (duplikat #78, #151, #155) | Android | Waktu/uang/rokok dihindari, timeline kesehatan, kartu share | Counter, share card |
| 10 | [SmokeFree: Quit smoking slowly](https://play.google.com/store/apps/details?id=com.motivebite.smokefree.free) | Android | Tapering personal + notifikasi interval, motivasi, sinkron multi-perangkat (cloud) | Tapering |
| 11 | [QuitNow!](https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa) | Android | Status ex-smoker, 80 milestone, chat komunitas, AI, live ahli, Wear OS | Milestone, komunitas |
| 24 | [No Smoke](https://play.google.com/store/apps/details?id=com.havabee.nosmoke) | Android | Skor paru, savings goal, streak + Streak Shield, pursed-lip breathing, delay 5 menit | Anti-shame, SOS |
| 25 | [QuitSave](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke) | Android | Toples tabungan, baseline/actual log (harm reduction), 2 streak, WHO/CDC, backup zip, reminder | Impian, anti-shame |
| 26 | [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke) | Android | Timer + widget, 24 milestone, SOS 4-7-8 + timer 3 menit, analisis pola craving, 16 tema | Widget, SOS, analitik |
| 27 | [QUIT Smoking SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking) | Android | SOS (breathe/play/read/talk), 10 teknik napas, Quity AI coach, kuis, widget | SOS, AI coach |
| 28 | [Burnout](https://play.google.com/store/apps/details?id=app.burnout.quit.smoking) | Android | Pile counter, craving room, jamur risiko, taper/cold-turkey, slip tanpa reset, export 1 file | Anti-shame, pile |
| 29 | [Breev](https://play.google.com/store/apps/details?id=com.aura.stopsmoking) | Android | **✗ 404 — tidak terverifikasi** | — |
| 30 | [SWay](https://play.google.com/store/apps/details?id=com.stopsmoke.metodshamana) | Android | Timer jeda antarrokok (tapering), 3 skenario, dark theme, widget, klaim 44% efisiensi | Tapering, timer |
| 31 | [Smoke Free (Portable Pixels)](https://play.google.com/store/apps/details?id=com.portablepixels.smokefree) (duplikat #40, #149) | Android | 40+ teknik, coach, badges, diary, health bars, uang, share kemenangan, 1M+ unduhan | Teknik berhenti, share |
| 32 | [ClearStack Log](https://play.google.com/store/apps/details?id=com.clearstackapps.smokefree) | Android | Live clock, harga historis, milestone NHS/CDC, craving log (intensitas/trigger/coping), NOPE pledge, NRT, JSON export, heatmap 24j | Anti-shame, heatmap |
| 55 | [Quitrise](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise) | Android | Live counter, 12 milestone, 50 level + 65 badge, misi harian, SOS, journal, wallet goal, share card, dark mode | Gamifikasi, share |
| 56 | [Cut Smoking](https://play.google.com/store/apps/details?id=com.nfm.aval024) | Android | Geser-gunting cut-to-log, grafik bulanan, simpan kartu progres sebagai image, offline | Micro-log, share card |
| 57 | [Quit Smoking Now – Tracker](https://play.google.com/store/apps/details?id=com.mifasuse.quitsmokingnow) | Android | Counter, life regained, badge, 7-day craving chart, AI coach (opsional), 33 bahasa | Counter, analitik |
| 58 | [NicoQuit](https://play.google.com/store/apps/details?id=com.nicoquit.nico_quit) | Android/ID | XP, boss battle, kuis harian, napas 4-7-8, 100% offline, Bahasa Indonesia | Gamifikasi |
| 59 | [Stop Smoking: Quit Tracker](https://play.google.com/store/apps/details?id=com.stopcig) | Android | Counter, uang, widget, trigger log, mini-game, SOS napas | Widget, analitik |
| 60 | [Breath (aydemir)](https://play.google.com/store/apps/details?id=com.aydemir.breath) | Android | Prep phase, 4-7-8, urge-surfing 100 exercise, wishlist, kalender, 100% offline | Persiapan, wishlist |
| 61 | [ZenQuit](https://play.google.com/store/apps/details?id=com.zenquit.habit) | Android | Counter, 4-7-8/box breathing, smoke catcher game, 7-day mini calendar, SQLite offline, backup, 3 bahasa | Tapering, game |
| 62 | [PuffGone](https://play.google.com/store/apps/details?id=com.puffgone.app) | Android/ID | SOS toolkit (4-7-8, 5-4-3-2-1, tap game), virtual garden, 15 artikel + 71 kuis, mood 5×, CSV export | SOS toolkit, gamifikasi |
| 63 | [SmokeFree: Quit Smoking (Ging Studio)](https://play.google.com/store/apps/details?id=com.gingstudio.smokefree) | Android | Timer, craving log, Google Sign-In sync, email, offline core | Counter, sync opsional |
| 64 | [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) | Android | Cut-down 15%, rescue timer 1/3/5 menit, widget 3 ukuran, heat-map, mood 5×, export/import | Widget, cut-down |
| 65 | [RootedLife](https://play.google.com/store/apps/details?id=com.neonbug.rootedlife) | Android | Hutan virtual tumbuh, Wise Squirrel, toples piggy bank, 15 milestone, Storm Mode, jurnal | Impian visual, anti-shame |
| 66 | [Qit](https://play.google.com/store/apps/details?id=org.buldev.qit.androidApp) | Android | Multi-habit, personal best, craving log (tempat/emosi), badge, sync opsional | Multi-kebiasaan |
| 67 | [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) | Android | Check-in + slip undo, 30-day heatmap, pola waktu + heads-up 30 menit, kumulatif | Undo, pengingat pola |
| 68 | [Quit Smoking — Stop Tracker](https://play.google.com/store/apps/details?id=com.buggedapps.quitsmoking) | Android | 19 milestone, box breathing, Gemini AI (opsional), progress attempts, offline-first | SOS, AI opsional |
| 69 | [BreatheStreak](https://play.google.com/store/apps/details?id=com.breathe.streak.app.breathqxa) | Android | Check-in harian, badge, estimasi rokok/uang, data lokal | Check-in |
| 70 | [QuitPath](https://play.google.com/store/apps/details?id=com.hernanmr.QuitSmoking) | Android/ES | 35+ milestone, 20+ bahasa, transformasi tubuh, heatmap craving, Smoke Tracker pra-quit | Milestone, pra-quit |
| 71 | [Stosmok](https://play.google.com/store/apps/details?id=com.anggastudio.stosmok) | Android/ID | Naga 6 tahap, 40+ badge, SOS (napas, 60 detik game, alasan, jalan 5 menit), mood chart, EN/ID/7 bahasa, transfer file iPhone↔Android | SOS, gamifikasi, ID |
| 72 | [Smoke Free (AntoTech)](https://play.google.com/store/apps/details?id=com.antotech.smokefree) | Android | SOS Calm (4-7-8 + toolkit), victory calendar, share image, goals, PRO one-time purchase | SOS, share card |
| 73 | [QuitStreak](https://play.google.com/store/apps/details?id=com.mintsoft.quitstreak) | Android | Multi-habit (rokok/alkohol/gula/vape/kopi), streak + relapse history, 25 bahasa | Multi-kebiasaan |
| 80 | [quitSTART](https://play.google.com/store/apps/details?id=com.mmgct.quitstart) | Android | Tips personal dari riwayat, badge, mini-game pengalih, Quit Kit, pin lokasi trigger, pemerintah US (NCI/FDA) | Pemerintah, games |
| 81 | [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) | Android/iOS | Tapering/cold turkey, NRT tracking, SOS invalid 24/72j, if-then setup, widget + Wear OS, komunitas/challenge, offline-first, 1M+ | Tapering, SOS, referensi utama |
| 82 | [QuitSure](https://play.google.com/store/apps/details?id=org.instaquit.app) | Android | Program 6 hari CBT/REBT, coach pakar + AI, video harian, komunitas, money-back | CBT |
| 83 | [My QuitBuddy](https://play.google.com/store/apps/details?id=com.theprojectfactory.quitbuddy) | Android | Hari 1–30 tips, danger times, catatan komunitas, transfer profil, pemerintah Australia | Tips 30 hari |
| 84 | [Qwit Nicotine](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny) | Android + Wear | SOS one-tap, AI coach, token NRT, Wear OS tile, ally + komunitas anonim, no account | Widget, Wear OS |
| 85 | [Stop Smoking Day Counter](https://play.google.com/store/apps/details?id=smokefree.daycounter.quitsmoking) | Android | Detik-per-detik, AI plan, daily check-in mood/kecemasan, PIN/biometrik, 100K+ | PIN, check-in |
| 86 | [Quit Vaping Tracker (puff_count)](https://play.google.com/store/apps/details?id=com.frostrabbitcompany.puff_count) | Android | Puff counter, histori streak, trigger + device, themes + widget | Vape-spesifik |
| 87 | [Jones](https://play.google.com/store/apps/details?id=com.jonesforquitters.app) | Android | Komunitas 70K+, Coach Jones AI, NRT mints, Quittle game, milestone, tanpa paywall | AI, NRT, komunitas |
| 88 | [Quit Smoking Gradually (Android)](https://play.google.com/store/apps/details?id=com.franciscogaribay.quitsmokingalive) | Android/iOS | Tapering mingguan, pause/resume, statistik, 50K+ | Tapering |
| 89 | [Smoke Tracker freedom_from_smoke](https://play.google.com/store/apps/details?id=com.trifoiltrailblazer.freedom_from_smoke) | Android | 3 mode counter (auto/check-in/hardcore), taman visual, 7 hari review, vape/pouch, 10K+ | Logging fleksibel |
| 90 | [LastCig](https://play.google.com/store/apps/details?id=com.lastcig.app) | Android | 12 sistem tubuh + 44 milestone, heatmap, pelacakan toksin, multi-valuta, privacy-first | Milestone mendalam |
| 91 | [Stop Smoking (injunchoi)](https://play.google.com/store/apps/details?id=com.injunchoi.habit) | Android | Widget, 4D gejala penarikan, statistik mingguan/bulanan, populer Korea | Widget |
| 92 | [NoSmoke](https://play.google.com/store/apps/details?id=com.quitsmoking.nosmoke) | Android | Counter per menit, streak, kalkulator uang, dialog progres sederhana | Counter ringan |
| 93 | [Smoxy](https://play.google.com/store/apps/details?id=net.offlinefirst.smoxy) | Android | OFFLINEFIRST LTD (developer Flamy), superpowers coping, interactive body 0–100%, komunitas feed | Interaktif |
| 94 | [Craving To Quit](https://play.google.com/store/apps/details?id=com.claritasmindsciences.CravingToQuit) | Android | Program 21 hari Yale (Dr. Jud Brewer), audio/video, refleksi malam, $24,99/bulan | CBT/mindfulness |
| 95 | [Sober Time](https://play.google.com/store/apps/details?id=com.sociosoft.sobertime) | Android | Multi-addiction, komunitas AA/NA, jurnal, cloud sync, relapse reset | Multi-kebiasaan |
| 96 | [Quit Vaping (coddykit)](https://play.google.com/store/apps/details?id=com.coddykit.quitvaping) | Android | Puff dihindari, log slip + trigger, jurnal check-in mood, planner penurunan nikotin (Pro) | Tapering vape |
| 97 | [Puff Counter](https://play.google.com/store/apps/details?id=app.puffcounter.free.kwit.flamy.ecigtracker.quitvaping.smokefree.quitnow) | Android | One-tap puff, target penurunan, wawasan craving, widget | Vape-spesifik |
| 98 | [QuitHaven](https://play.google.com/store/apps/details?id=au.com.ycreative.quithaven) | Android | Dunia 3D XP, SOS (box breathing, urge-surfing, arcade), paru + timeline, share kode snapshot | Gamifikasi 3D |
| 99 | [Pelago](https://play.google.com/store/apps/details?id=co.digithera.v2.quitgenius) | Android | Virtual care (spesialis video), AI Sona 24/7, HIPAA/HITRUST, employer plan, 100K+ | Layanan klinis, bukan tracker |
| 100 | [Quash](https://play.google.com/store/apps/details?id=com.innovasium.Quash) | Android | Dashboard streak/uang/badge, kalender statistik, log craving (intensitas/mood), Ontario Lung Association (Kanada) | Verifikasi publik, gratis |
| 101 | [Quit Smoking Hero](https://play.google.com/store/apps/details?id=jp.co.nakashin.quitsmokinghero) | Android | Pixel game, karakter berkembang, Tobacco Man, log berat badan, Jepang | Gamifikasi |
| 102 | [Quit smoking Tracker - Stop it](https://play.google.com/store/apps/details?id=com.belapplications.quit.smoking.stoppen.met.roken) | Android | Dashboard, uang/rokok, jurnal tak terbatas (Pro), 100% offline, 100+ unduhan | Dashboard Pro |
| 103 | [Quit Smoking: Progress Tracker](https://play.google.com/store/apps/details?id=com.inspectorstudios.quitsmokingprogresstracker) | Android | 7 hari prep, CBT toolkit (napas/grounding), if-then vault, laporan mingguan, $13,98→$6,98 | CBT, if-then |

**Pencarian (bukan listing langsung):** [Qwit](https://play.google.com/store/search?q=Qwit%20Nicotine&c=apps) → listing langsung ditemukan (#84). [QuitNic AI](https://play.google.com/store/search?q=QuitNic%20AI&c=apps) → [store.evsi.quitsmoke](https://play.google.com/store/apps/details?id=store.evsi.quitsmoke) (SOS AI, CBT pelajaran, 4D/HALT/urge surfing, slip tanpa reset, premium 14-hari tren). [Lungo](https://play.google.com/store/search?q=Lungo%20quit%20smoking&c=apps) → [trylungo.com](https://trylungo.com/) (maskot katak, XP, Fly Hunt game, insight pemicu). [SmokingWeaner](https://play.google.com/store/search?q=SmokingWeaner&c=apps) → [smoking.android.smokingweaner20](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20) (catat + interval, 7/30-hari, coping/outcome, backup preview + CSV). [QuitWin](https://play.google.com/store/search?q=QuitWin&c=apps) → [com.elevatedev.quitwin](https://play.google.com/store/apps/details?id=com.elevatedev.quitwin) (PIN/biometrik, mode "Notes" disamarkan, panic button, Drive folder backup). [Weanie](https://play.google.com/store/search?q=Weanie%20quit%20smoking&c=apps) → [com.weanie.weanieapp](https://play.google.com/store/apps/details?id=com.weanie.weanieapp) (rencana weaning bertahap, push jadwal, 500+ unduhan). [Smoker Reducer](https://play.google.com/store/search?q=Smoker%20Reducer&c=apps) → **✗ listing eksak tidak ditemukan — tidak terverifikasi**.

### D.2 Apple App Store (47 listing: nomor 8, 33–46, 104–135)

| No. | Aplikasi (link) | Platform | Fitur terverifikasi (ringkas) | Kegunaan |
|---|---|---|---|---|
| 8 | [Kwit (iOS)](https://apps.apple.com/gb/app/quit-smoking-for-good-kwit/id525441365) (duplikat #7) | iOS | = Kwit Android | CBT |
| 33 | [Quit Smoking: Smoke-Free (kazuhiro)](https://apps.apple.com/sa/app/quit-smoking-smoke-free/id6753927307) | iOS | Live counter, quit diary + grafik emosi, crisis support (4-4-4-4), komunitas anonim | Diary emosi |
| 34 | [Quit Smoking —~ Smoke Free](https://apps.apple.com/us/app/quit-smoking-smoke-free/id1185502772) | iOS+Watch | 100 alasan, Apple Watch app, widget, top 10 tips | Watch |
| 35 | [Quit Smoking Tracker: Stop it](https://apps.apple.com/kw/app/quit-smoking-tracker-stop-it/id6444747858) | iOS | **✗ 404 — tidak terverifikasi** | — |
| 36 | [Quit Smoking Tracker - Quittt](https://apps.apple.com/pl/app/quit-smoking-tracker-quittt/id6751553594) | iOS | Counter + milestone, journal refleksi, countdown harian | Journal |
| 37 | [Quit Smoking Vaping & Nicotine](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) | iOS | 12 milestone, 6 psikologis, idle clicker, 365-day heatmap, soft/hard slip mode, 3 widget | Heatmap, soft/hard |
| 38 | [Smoke Free: Quit Tracker](https://apps.apple.com/us/app/smoke-free-quit-tracker/id6759697339) | iOS | Real-time counter, milestone WHO/USSG, shareable cards, 100% private, 5,0★ | Share card |
| 39 | [Quit It](https://apps.apple.com/us/app/quit-it-quit-smoking-tracker/id6758652819) | iOS | CBT support + napas/grounding, journal check-in, tabungan + rewards, taper plan, SOS page | SOS page + taper |
| 40 | [Smoke Free - 23 Ltd](https://apps.apple.com/us/app/smoke-free-quit-smoking-now/id577767592) (duplikat #31) | iOS+Watch | 40+ teknik, missions, AI coach, blitz program, sertifikat, komunitas; 57K ulasan | Missions kelas dunia |
| 41 | [Quit Smoking Gradually: Alive](https://apps.apple.com/ca/app/quit-smoking-gradually-alive/id1539249881) (duplikat #88) | iOS/iPad | Tapering non cold-turkey, withdrawal support, pause kapan saja, 283 ulasan | Tapering |
| 42 | [Stop Smoking Habit Tracker](https://apps.apple.com/ca/app/stop-smoking-habit-tracker/id1565965165) | iOS/Watch | Readout paru/jantung/CO/WHO, lock screen + Control Center widget | Readout |
| 43 | [Quit Smoking Tracker: QuitDate](https://apps.apple.com/us/app/quit-smoking-tracker-quitdate/id6748999711) | iOS | Set quit date masa depan/lalu, calming strategies, data lokal | Calming |
| 44 | [ZeroSmoke](https://apps.apple.com/us/app/stop-smoking-zerosmoke/id6748849730) | iOS | **✗ 404 — tidak terverifikasi** | — |
| 45 | [quitSTART (App Store)](https://itunes.apple.com/app/apple-store/id494552000?pt=564700&ct=SmokefreeGov&mt=8) | iOS | = quitSTART Android; game pengalih, Quit Kit, pin lokasi | Pemerintah |
| 46 | [Quit Smoking Get Healthy](https://apps.apple.com/in/app/quit-smoking-get-healthy/id1087358475) | iOS | Rokok/uang, 27 achievement, "I smoked, restart", widget | Restart |
| 104 | [QuitNow](https://apps.apple.com/us/app/quitnow/id483994930) | iOS+Watch+Mac | 80 milestone + WHO indikator, komunitas chat, sesi live ahli, AI, Apple Watch | Komunitas |
| 105 | [NHS Quit Smoking](https://apps.apple.com/gb/app/nhs-quit-smoking/id687298065) | iOS | Program 28 hari, Stoptober, mood journal, badge, NHS (UK) | Program 28 hari klinis |
| 106 | [Quittr](https://apps.apple.com/us/app/quit-smoking-quittr/id6503163176) | iOS | Cigarette tracker, biometric lock, cross-device sync, weekly/monthly trends, iOS 17+ | Biometric |
| 107 | [Quit Smoking Hero (Stop Now!)](https://apps.apple.com/id/app/quit-smoking-hero-stop-now/id6446471769) | iOS | Pixel game Tobacco Man, gauge perubahan fisik, widget, EN/ID | Gamifikasi |
| 108 | [QuitNow Stop Smoking (Medicon)](https://apps.apple.com/us/app/quitnow-stop-smoking/id6768372199) | iOS | 9 hari prep, 8 CBT exercises (urge surfing, thought records, coping cards, 5-4-3-2-1), 3,4 MB, offline (no servers) | CBT offline |
| 109 | [Kick It (UCSD)](https://apps.apple.com/us/app/kick-it-quit-smoking-vaping/id6473648667) | iOS | Human coach telepon/chat (gratis), misi, check-in, napas + game, 4,8★ | Coach manusia |
| 110 | [QuitSure](https://apps.apple.com/us/app/quitsure-quit-smoking-vaping/id1523992725) | iOS | 6 hari + 6 minggu CBT/REBT, video harian, komunitas, 81–95% klaim | CBT/REBT |
| 111 | [iQuit Smoking: Quit Plan](https://apps.apple.com/us/app/iquit-smoking-quit-plan/id6504419691) | iOS | Multi-habit, 30 hari (2 menit/hari), SOS countdown, slip log, no account, offline | Multi-kebiasaan |
| 112 | [Nixd](https://apps.apple.com/us/app/quit-smoking-vaping-nixd/id6761740706) | iOS | Cold turkey atau taper, SOS (napas/grounding/game), streak dipertahankan saat slip, offline, $29,99/tahun | Taper + slip |
| 113 | [Puff Pacer](https://apps.apple.com/us/app/puff-pacer-quit-smoking-vape/id6781159498) | iOS/Watch/Mac | Taper adaptif, selfie time-lapse, printable summary (PDF dokter), VoiceOver, 27 bahasa, Dynamic Island SOS | PDF dokter |
| 114 | [Jones](https://apps.apple.com/us/app/jones-quit-vaping-smoking/id6444833687) | iOS | Quit pods komunitas, Coach Jones AI, Quittle game, NRT mints, iCloud-ish sync | Komunitas |
| 115 | [Puff Count: Quit Vaping Now](https://apps.apple.com/us/app/puff-count-quit-vaping-now/id1488580640) | iOS | Puff tracker + mg strength, grafik h/m/b, batas harian, quit buddies, trigger recognition | Vape + grafik |
| 116 | [VapeLess](https://apps.apple.com/us/app/vapeless-quit-vaping-app/id6742739131) | iOS | Puff/craving, penurunan nikotin mingguan, group goals, napas terpandu | Group goals |
| 117 | [Stoppy](https://apps.apple.com/us/app/stoppy-quit-smoking-vaping/id6771973568) | iOS | Pandy companion, live money tracker, timeline personal, relapse log (best streak tetap), backup via Apple Sign-In | Companion |
| 118 | [Ease](https://apps.apple.com/us/app/ease-quit-nicotine-gradually/id6760263211) | iOS | Week-by-week reduction schedule, zero data collection, gratis sepenuhnya, 100% offline | Taper gratis |
| 119 | [Nicotine Free](https://apps.apple.com/us/app/nicotine-free-quit-vape-zyn/id6810766797) | iOS | Multi-product (Zyn/dip/pouch/rokok), 90-second pause, letters to future self, research-cited timeline, app lock | Letters to self |
| 120 | [Nixotine](https://apps.apple.com/us/app/nixotine-quit-vaping/id6788731578) | iOS/iPad | SOS 4-4-6 + Dynamic Island, taper mode, widget home screen, no account | Dynamic Island |
| 121 | [Quit Vaping App](https://apps.apple.com/us/app/quit-vaping/id1479615245) | iOS/Watch | Buddy system, forum komunitas, selfie-per-day, catatan craving/trigger, watchOS | Komunitas, selfie |
| 122 | [EasyQuit (iOS)](https://apps.apple.com/us/app/easyquit-stop-smoking/id1508110799) (duplikat #6, #148) | iOS/iPad | Slow mode taper, 62 badge, 28 themes, memory game, widget (Pro), relapse assistant | Taper, badge |
| 123 | [Quitzilla](https://apps.apple.com/us/app/quitzilla-quit-tracker/id1533076568) | iOS | Multi-habit (rokok/alkohol/porn/gambling/food), reward uang mingguan, quote of the day, CSV, 29 bahasa | Multi-kebiasaan |
| 124 | [My Last Cigarette](https://apps.apple.com/gb/app/my-last-cigarette/id639202516) | iOS/iPad | Readout CO/jantung/paru/sirkulasi, "deaths since quit", 10+ indikator, sedari 1999 | Readout klinis |
| 125 | [PuffNah](https://apps.apple.com/us/app/puffnah-quit-smoking-vaping/id593280856) | iOS/iPad | 30 badge, Blob mascot, community feed (share wins), backup email/Apple/Google | Komunitas |
| 126 | [Stop Smoking In 2 Hours](https://apps.apple.com/us/app/stop-smoking-in-2-hours/id6474775565) | iOS/iPad | 2 jam audio/video (Jason Vale), 21 malam hypnotherapy, SOS videos, bukan tracker | Hypnotherapy |
| 127 | [Smoke Free Now! (id6760993334)](https://apps.apple.com/us/app/smoke-free-quit-smoking-now/id6760993334) | iOS | Real-time streak, "focus games", trigger/mood/withdrawal log, weekly review, widget; privacy-first | Focus games |
| 128 | [EasyQuit - Quit Smoking Now](https://apps.apple.com/tm/app/easyquit-quit-smoking-now/id6759877168) | iOS | Plan gradual/cold turkey, Quitty companion, mood journal, badge, 1-tap log | Companion |
| 129 | [QuitSmoke](https://apps.apple.com/us/app/quitsmoke-quit-smoking-now/id1569885842) | iOS | Countdown, uang/rokok, reward tracker, "no ads/premium", local data, gratis sepenuhnya | Gratis |
| 130 | [Quit Smoking App](https://apps.apple.com/us/app/quit-smoking-app-smoke-free/id1591759019) | iOS | Craving stats + diary, money goals, CBT-inspired, treats/rewards dengan uang | Treats |
| 131 | [Since iQuit](https://apps.apple.com/us/app/since-iquit/id334825691) | iOS/iPad | Timer kebiasaan sederhana (rokok/alkohol), estimasi penghematan, social sharing, sedari 2017 | Timer sederhana |
| 132 | [Quit Smoking Now - AI Buddy](https://apps.apple.com/us/app/quit-smoking-now-ai-buddy/id6449152501) | iOS | AI companion, achievements, uang dihemat, tracking body recovery, langganan $4,99/minggu | AI coach |
| 133 | [Quit Smoking, Smoke Free Flamy (iOS)](https://apps.apple.com/us/app/quit-smoking-smoke-free-flamy/id1462887052) (duplikat #81) | iOS/Watch | SOS if-then setup, check-in 24/72h setelah slip, komunitas/challenge teman, $6,99–$34,99, offline-first | Flamy iOS |
| 134 | [Tabac info service (FR)](https://apps.apple.com/fr/app/tabac-info-service-lappli/id1138311639) | iOS/iPad | Coaching personal, kontak ahli tembakau, mini-game, supporter keluarga, pemerintah Prancis, 7 langkah | Pemerintah |
| 135 | [Ouiquit](https://apps.apple.com/fr/app/ouiquit/id1482743031) | iOS/Mac | Pierre AI coach, totem tanaman, 80+ tips anti-craving (goyang HP), Ouichat, 7+ mini-game, backup akun | AI + komunitas FR |

### D.3 F-Droid / IzzyOnDroid (8 listing: nomor 1, 3, 21–23, 47, 136–137)

| No. | Aplikasi (link) | Platform | Fitur terverifikasi (ringkas) | Kegunaan |
|---|---|---|---|---|
| 1 | [SmokingYou](https://f-droid.org/en/packages/com.smokingtracker) | Android | One-tap log, timer real-time, tapering, widget 1×1/3×1, breathing pause, trigger analytics, backup JSON, Material 3, 100% offline | Log + tapering + widget |
| 3 | [Quitter](https://f-droid.org/en/packages/com.quitter.app) | Android | Journey 13 kebiasaan + custom, milestone, jurnal, notifikasi, tema; MIT | Journey tracker |
| 21 | [Quit Smoking (de.baumann)](https://f-droid.org/en/packages/de.baumann.quitsmoking) (duplikat #137) | Android | Statistik dasar + diary; proyek **diarsipkan 2017**; anti-feature NoSourceSince | Referensi historis |
| 22 | [Smoking Tracker (Gašper Pintar)](https://f-droid.org/en/packages/com.gasperpintar.smokingtracker) (duplikat #79) | Android | Log per batang, statistik h/m/b/tahun, forecast, backup lokal, v1.9.2 (oct 2026), widget | Statistik periodik |
| 23 | [Smoke Reducer](https://f-droid.org/en/packages/com.java.SmokeReducer) | Android | **✗ 404 di URL utama.** Alternatif: [IzzyOnDroid](https://apt.izzysoft.de/fdroid/index/apk/com.java.SmokeReducer?repo=archive) — alarm perpanjangan jeda antarrokok; v1.0 2012, tidak dirawat | Tapering historis |
| 47 | [ExHale](https://f-droid.org/packages/net.retiolus.exhale/) | Android | Tracker offline minimal; waktu sejak berhenti, rokok (tidak) dihisap, uang; GPLv3 | Minimalis |
| 136 | [Sobriety](https://f-droid.org/packages/com.katiearose.sobriety/) | Android | Tracker kecanduan umum, milestone, relapse history, import/ekspor JSON, GPL-3 | Multi-kebiasaan |
| 137 | [Quit Smoking (arsip IzzyOnDroid)](https://apt.izzysoft.de/fdroid/index/apk/de.baumann.quitsmoking?repo=main) (duplikat #21) | Android | = #21; v2.5, 2017 | — |

### D.4 GitHub (20 listing: nomor 2, 12–20, 76–77, 138–145)

| No. | Aplikasi (link) | Platform | Fitur terverifikasi (ringkas) | Kegunaan |
|---|---|---|---|---|
| 2 | [TrackLess](https://github.com/poorangryman/trackless-public) | Android | Timer abstinensi + milestone, SOS 4-7-8, pola pagi/siang/sore/malam, widget, backup/import JSON, tema Obsidian gelap, MIT | Pola waktu + widget |
| 12 | [Quit-Smoke-App](https://github.com/trizin/Quit-Smoke-App) | Android (Flutter) | Timer, uang/rokok, panduan, daftar alasan | Flutter + alasan |
| 13 | [Quitter](https://github.com/brandonp2412/quitter) (duplikat #3) | Android | = #3; 200★ | — |
| 14 | [QuitTrack](https://github.com/Monaim-knight/Smoking-Tracker) | Mobile (RN) | Log harian, kalkulator biaya, estimasi life regained, grafik, MIT | Kalkulator biaya |
| 15 | [QuitEase](https://github.com/MUmer24/Quitease-Firebase-Application) | Android (Flutter) | Live timer, 20 badge, 10 milestone WHO, notifikasi; **Firebase (bukan offline-first)** | Statistik Flutter |
| 16 | [SmokeFree (Polymath-Saksh)](https://github.com/Polymath-Saksh/SmokeFree) | **Web (Django)** | **✗ 404 saat fetch; terverifikasi via websearch.** Web app + AI coach; bukan mobile/offline | Di luar ruang lingkup |
| 17 | [paceapp](https://github.com/s3gv/paceapp) | **iOS-only** | "Stint" tapering + target adaptif mingguan, Live Activity, WidgetKit; Drift/SQLite; MIT | Tapering konsep |
| 18 | [Nonic](https://github.com/bllfoad/nonic) | Flutter (And/iOS/Web) | Check-in mood/urge, skor risiko 0–100 (lokal 7 hari), slip log, milestone, tabungan, SOS breathing, data lokal; MIT | Risk score, check-in |
| 19 | [Breathe](https://github.com/imaswath/Breathe) | Android (RN) | Timer, uang dihemat, SOS craving, metrik tubuh (CO, paru); UI gelap minimal | Gelap minimal |
| 20 | [SmartQuit](https://github.com/ShreyNagda/smartquit) | Flutter (And/iOS) | Panic button, 10 intervensi evidence (CBT/grounding/game), statistik efektivitas intervensi, widget Android 1×1; Firebase | Stats intervensi |
| 76 | [Pace (ravipurohit1991)](https://github.com/ravipurohit1991/pace/releases/latest) | Android (native) | Metode interval + tap log, AI Ollama (opsional, user key), 12-second undo, widget glass, grounding 5-4-3-2-1, arcade (trivia/emoji), if-then playbook, JSON backup; GPL-3; berbeda dari #17 | Undo, if-then, widget |
| 77 | [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app) | Android (Flutter) | Undo entri/hapus, widget 3 ukuran, plan pengurangan, arsip + CSV backup/restore, TalkBack, EN/IT, MIT; **lintas-platform Android** | Undo + widget |
| 138 | [MyQuitBuddy](https://github.com/TheoMadCo/myquitbuddy) | Flutter (And/iOS) | wearable (HRV/tidur/aktivitas), grafik korelasi, tips; MIT; belum rilis store | Wearable |
| 139 | [QuitSmoking (rmiguel1985)](https://github.com/rmiguel1985/quitsmoking) | Android/iOS (Compose Multiplatform) | Timer, milestone, uang, privacy-first, lokal; GPL-3; "Coming soon" | Privacy-first |
| 140 | [QuitSmoke (nepaliparadox)](https://github.com/nepaliparadox/quitsmoke) | Android/iOS (RN/Expo) | Live journey, health analytics (O2/BP/CO), "Looser Filter" reset, tema hutan, GPL-3 | Looser Filter |
| 141 | [Quit Smoking While Smoking](https://github.com/emredevsalot/quit-smoking-while-smoking) | Android (RN) | Exposure therapy: +1 menit/hari antarrokok, jeda rokok pagi disesuaikan | Exposure therapy |
| 142 | [Breathing Room](https://github.com/anindya127/Breathing-Room) | **Android 13+ (Flutter)** | Dual-mode (counter/coach), algoritma tangga, sqflite + Riverpod (mirip stack proyek!), 18 badge, 12 milestone, multi-currency, haptic; MIT; APK tersedia | Stack sama, tapering |
| 143 | [Moke-Smoke](https://github.com/penteleichuk/Moke-Smoke) | iOS/Android (RN) | Tema teman via QR, feed berita, latihan, todo, audio motivasi, chat, pedometer; Firebase | Komunitas, audio |
| 144 | [QuitBuddy](https://github.com/feragusper/QuitBuddy) | Web/iOS/Android (Flutter) | BLOC, Firebase Auth/Firestore, Google Sign-In | Cloud, bukan offline |
| 145 | [smokeless](https://github.com/samer-saied/smokeless) | iOS/Android (Flutter) | Saran berhenti + statistik; Firebase; tidak selesai | Dasar |

### D.5 Store Lainnya (18 listing: nomor 74–75, 78–79, 146–159)

| No. | Aplikasi (link) | Platform | Status / catatan | Kegunaan |
|---|---|---|---|---|
| 74 | [QuitDay (Galaxy Store)](https://galaxystore.samsung.com/detail/com.siwooeo.quitday?cntyCd=IDN) | Android | **Verifikasi ringan (2026-11-10): HTTP 200, judul halaman tampil "QuitDay: Quit Smoking & Drink"** — package `com.siwooeo.quitday`; detail fitur tidak terbaca penuh; kemungkinan saudara QuitSave (paket `com.siwooeo.*`) | Ketersediaan terverifikasi |
| 75 | [QuitSave (Galaxy Store)](https://galaxystore.samsung.com/detail/com.siwooeo.quitsmoke?cntyCd=IDN) (duplikat #25) | Android | **Verifikasi ringan (2026-11-10): HTTP 200, judul halaman tampil "QuitSave: Quit Smoking Tracker"** — package `com.siwooeo.quitsmoke`; = QuitSave Google Play (duplikat lintas toko) | Ketersediaan terverifikasi |
| 78 | [Quit Tracker (Uptodown)](https://quit-tracker.en.uptodown.com/android) (duplikat #9) | Android | Package `com.despdev.quitsmoking`; HTTP 404 saat verifikasi ulang 2026-11-10 (sebelumnya 410); data via mirror = daftar resmi Play | Tidak terverifikasi |
| 79 | [Smoking Tracker (IzzyOnDroid)](https://apt.izzysoft.de/fdroid/index/apk/com.gasperpintar.smokingtracker) (duplikat #22) | Android | Mirror F-Droid; v1.9.2, 18 oct 2026 | Mirror |
| 146 | [QuitNow! (Amazon Appstore)](https://www.amazon.com/Fewlaps-QuitNow-Stop-smoking/dp/B008LJXY0A) (duplikat #11, #104) | Android | 403 pada link awal; terverifikasi via web: = QuitNow, Fewlaps, 4,8★, WHO | Distribusi alternatif |
| 147 | [Quit Smoking Hypnosis FREE](https://www.amazon.com/Quit-Smoking-Hypnosis-FREE-Hypnotherapy/dp/B00HLP0BHO) | Android | Audio hipnosis harian + binaural, 3,44★, Amazon gagal langsung; terverifikasi via web | Hypnotherapy |
| 148 | [Stop Smoking - EasyQuit free (Amazon)](https://www.amazon.com/Easy-Quit-Stop-Smoking-App/dp/B01N0OTGXD) (duplikat #6, #122) | Android | = EasyQuit, 4,8★ 106K ulasan Play | Distribusi alternatif |
| 149 | [Smoke Free (APKPure)](https://apkpure.com/smoke-free-quit-smoking-now/com.portablepixels.smokefree) (duplikat #31, #40) | Android | 403 APKPure; = Smoke Free Portable Pixels, 3,4 juta unduhan | Distribusi alternatif |
| 150 | [quitSTART (APKPure)](https://apkpure.com/quitstart-quit-smoking/com.mmgct.quitstart) (duplikat #80, #45) | Android | 403; = quitSTART | Distribusi alternatif |
| 151 | [Quit Tracker (APKPure)](https://apkpure.com/quit-tracker-stop-smoking/com.despdev.quitsmoking) (duplikat #9, #78, #155) | Android | 403; = Quit Tracker despDev | Distribusi alternatif |
| 152 | [Stop Smoking: Quit Tracker (Zelur Apps)](https://apkpure.com/stop-smoking-quit-tracker/com.momo.quit.smoke) | Android | 403; terverifikasi via web: entri baru 2026, streak, virtual cigarette craving kit, breathing exercise, tanpa reset setelah slip, ~69 unduhan | Virtual cigarette kit |
| 153 | [Quit or Reduce - SWay (Aptoide)](https://sway-shaman-way.en.aptoide.com/app) (duplikat #30) | Android | 403; = SWay, 100K+, dark theme | Distribusi alternatif |
| 154 | [Stop Smoking SR Group (Aptoide)](https://quit-tracker-sr-group.en.aptoide.com/app) | Android | 403; terverifikasi via web: craving diary, password-proteksi, badge, SR Group (India), 100K+, sejak 2018 | Password protection |
| 155 | [Quit Tracker (Aptoide)](https://quit-tracker.en.aptoide.com/app) (duplikat #9, #78, #151) | Android | 403; = Quit Tracker despDev | Distribusi alternatif |
| 156 | [Flamy (Aptoide)](https://flamy.en.aptoide.com/versions) (duplikat #81, #133) | Android | 403; = Flamy | Distribusi alternatif |
| 157 | [QuitSM (SlideME)](http://slideme.org/application/quitsm) | Android | **✗ 403 — tidak terverifikasi, tidak ada sumber alternatif** | — |
| 158 | [戒烟 (Tencent MyApp)](https://sj.qq.com/appdetail/com.yunchuan.quitsmoke) | Android (Cina) | Counter merokok, WHO recovery, target kesehatan; ±40.100 unduhan, v26.10.26; member berbayar menurut ulasan | Cina, offline |
| 159 | [Quit App (HK Gov)](https://appgallery.huawei.com/app/C104801805) | Android | AppGallery kosong; terverifikasi via [livetobaccofree.hk](https://livetobaccofree.hk): penilaian ketergantungan, rencana berhenti, Quitline 1833 183, Chat to Quit AI 24/7, NRT pack; pemerintah Hong Kong | Pemerintah |

### D.6 Duplikasi Lintas Toko (bukan produk baru)

- **Kwit:** [Google Play](https://play.google.com/store/apps/details?id=fr.kwit.android) = [App Store GB](https://apps.apple.com/gb/app/quit-smoking-for-good-kwit/id525441365).
- **Quit Tracker (despDev):** [Play](https://play.google.com/store/apps/details?id=com.despdev.quitsmoking) = [Uptodown](https://quit-tracker.en.uptodown.com/android) = [APKPure](https://apkpure.com/quit-tracker-stop-smoking/com.despdev.quitsmoking) = [Aptoide](https://quit-tracker.en.aptoide.com/app).
- **Smoking Tracker (Gašper Pintar):** [F-Droid](https://f-droid.org/en/packages/com.gasperpintar.smokingtracker) = [IzzyOnDroid](https://apt.izzysoft.de/fdroid/index/apk/com.gasperpintar.smokingtracker).
- **QuitSave:** [Play](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke) = [Galaxy Store](https://galaxystore.samsung.com/detail/com.siwooeo.quitsmoke?cntyCd=IDN).
- **quitSTART:** [Play](https://play.google.com/store/apps/details?id=com.mmgct.quitstart) = [App Store](https://itunes.apple.com/app/apple-store/id494552000?pt=564700&ct=SmokefreeGov&mt=8) = [APKPure](https://apkpure.com/quitstart-quit-smoking/com.mmgct.quitstart).
- **EasyQuit:** [Play](https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking) = [App Store](https://apps.apple.com/us/app/easyquit-stop-smoking/id1508110799) = [Amazon](https://www.amazon.com/Easy-Quit-Stop-Smoking-App/dp/B01N0OTGXD).
- **Flamy:** [Play](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) = [App Store](https://apps.apple.com/us/app/quit-smoking-smoke-free-flamy/id1462887052) = [Aptoide](https://flamy.en.aptoide.com/versions).
- **Quit Smoking Gradually (Alive):** [Play](https://play.google.com/store/apps/details?id=com.franciscogaribay.quitsmokingalive) = [App Store CA](https://apps.apple.com/ca/app/quit-smoking-gradually-alive/id1539249881).
- **QuitNow:** [Play](https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa) = [App Store US](https://apps.apple.com/us/app/quitnow/id483994930) = [Amazon](https://www.amazon.com/Fewlaps-QuitNow-Stop-smoking/dp/B008LJXY0A).
- **Smoke Free (Portable Pixels / 23 Ltd / smokefreeapp.com):** [Play](https://play.google.com/store/apps/details?id=com.portablepixels.smokefree) = [App Store id577767592](https://apps.apple.com/us/app/smoke-free-quit-smoking-now/id577767592) = [APKPure](https://apkpure.com/smoke-free-quit-smoking-now/com.portablepixels.smokefree).
- **Pace:** [s3gv/paceapp (iOS, Drift/SQLite)](https://github.com/s3gv/paceapp) ≠ [ravipurohit1991/pace (Android native, Compose)](https://github.com/ravipurohit1991/pace/releases/latest) — dua proyek berbeda, keduanya tercatat.
- **Quit Smoking (de.baumann):** [F-Droid](https://f-droid.org/en/packages/de.baumann.quitsmoking) = [IzzyOnDroid arsip](https://apt.izzysoft.de/fdroid/index/apk/de.baumann.quitsmoking?repo=main).

---

## E. Prioritas Gabungan (untuk penyortiran pengguna)

| Urutan | Rekomendasi | Jenis | Nilai utama | Ketergantungan utama |
|---:|---|---|---|---|
| 1 | Perbaiki ekspor cadangan: sertakan `konsumsi_rokok` & `sos_intervensi` (B1) | Bug / Optimasi | Integritas data pengguna; kerugian senyap hilang | Perbaikan ekspor + uji kontrak |
| 2 | Widget Home Screen Android (A1/C5) | Fitur baru | Akses 1–2 ketuk ke SOS/log/progres | Kode native Android (Glance/AppWidget) |
| 3 | Hubungkan konsumsi aktual ke counter/tapering/tabungan (B2) | Optimasi | Satu sumber kebenaran metrik | Helper rumus bersama |
| 4 | Anti-shame slip + bahasa netral + preview dampak (A6/B5/C4) | Optimasi/UX | Laporan jujur, retensi | Definisi metrik + copy |
| 5 | Undo/koreksi konsumsi (B3/C2) | Optimasi | Data akurat → metrik tepercaya | Notifier + UI feedback |
| 6 | Kartu progres yang dapat dibagikan (A2) | Fitur baru | Motivasi sosial terkendali | share_plus (ada) + template |
| 7 | Analitik: grafik tren + heatmap craving (A5/B6) | Fitur baru/optimasi | Insight yang bisa ditindaklanjuti | fl_chart (baru) + data cukup |
| 8 | Check-in harian mood singkat (A3) | Fitur baru | Refleksi & deteksi risiko | Tabel `check_in_harian` |
| 9 | Pengingat jam rawan berdasarkan pola (A13/B7) | Optimasi | Relevansi notifikasi | PolaCravingHelper + opt-in |
| 10 | Backup CSV + pratinjau (B8) | Optimasi | Portabilitas & analisis | Ekspor sisi baca saja |
| 11 | Mini-game distraksi (A7) | Fitur baru | Variasi motivasi | Matching-pairs sederhana |
| 12 | Gamifikasi ringan (misi harian, opsional) (A9) | Fitur baru | Retensi opt-in | Sistem reward sederhana |
| 13 | If-then plan (A10) & letters to future self (A11) | Fitur baru | Kedalaman motivasi | Layar kecil |
| 14 | NRT tracker (A12) | Fitur baru | Lengkapnya rencana tapering | Model `nrt_entri` |
| 15 | Pindahkan statistik sekunder ke layar Analitik terpisah dari Dashboard (lihat A5) | UX | Fokus; beban kognitif | Tinjau layar di HP kecil |
| 16 | AI coach (A8) | Fitur baru | Dukungan personal (opsional) | Backend, biaya, privasi |
| 17 | Komunitas (di luar offline-first) | Fitur baru | Dukungan sosial | Backend + moderasi; **bukan** rekomendasi utama |

---

## F. Verifikasi & Keterbatasan

- **Cakupan daftar:** seluruh **159 tautan** pada `apk_serupa.md` tercatat di katalog. Entri duplikat lintas toko diberi catatan, bukan dihitung sebagai produk berbeda.
- **Status verifikasi:** sekitar 142/159 listing berhasil dibaca (store page/README terakses, atau didukung mirror/situs resmi/websearch). **Tidak terverifikasi:** Breev (#29, 404), Quit Smoking Tracker: Stop it App Store (#35, 404), ZeroSmoke (#44, 404), Smoker Reducer (#54, listing tidak ditemukan), QuitSM SlideME (#157, 403), Flamy Aptoide (#156, 403), Quit Tracker Uptodown (#78, 404 pada verifikasi ulang 2026-11-10; sebelumnya 410). **Verifikasi ringan:** QuitDay & QuitSave Galaxy Store (#74–75) — HTTP 200 dan judul halaman tampil pada 2026-11-10, tetapi detail fitur tidak terbaca penuh; tidak dijadikan dasar rekomendasi fitur. Android `polymath-saksh` GitHub (#16) 404 saat fetch tetapi terverifikasi websearch (web app Django — bukan mobile).
- **Angka adopsi:** banyak listing baru (Stosmok, Cut Smoking, NicoQuit, QuitRise itd.) menampilkan <1K unduhan. Angka berubah; bukan bukti kualitas/efektivitas.
- **Privasi & cloud:** Kwit, QuitNow, Quit Smoking Now, Jones, QuitSure, Pelago, Tabac info service, Ouiquit memerlukan akun/cloud; proyek offline-first sebaiknya tidak meniru apa adanya.
- **AI coach:** memerlukan koneksi, backend, biaya, dan review konten; jatuhkan ke prioritas rendah.
- **Kesehatan:** milestone WHO/CDC/NHS yang ditampilkan sebagai fakta wajib diverifikasi; aplikasi hanya menyajikan estimasi ilustratif.
- **Platform:** Pace `s3gv` (Live Activities/WidgetKit) dan `quit-smoking-smoke-free` iOS-only tidak relevan untuk Android/Flutter; gunakan padanan Android bila ada.
- **Screenshot:** UI/UX disimpulkan dari deskripsi/README publik; interaksi dan aksesibilitas pada perangkat fisik belum diverifikasi. Tidak ada APK kompetitor yang dipasang/diuji.
- **Proyek:** kode tidak diubah dalam tugas riset ini; satu cacat ditemukan (B1) dan didokumentasikan, bukan diperbaiki di sini.
- **Backup proyek:** README menyebut versi 1 hanya `biodata`, `impian`, `diary_craving`, `alasan_berhenti` — tetapi kode mendaftarkan `konsumsi_rokok` dan `sos_intervensi` pada `tabelCadangan`, sementara `buatCadanganJson()` tidak menulisnya. Dokumentasikan sebagai bug B1.

---

## G. Sumber Riset Utama (semua listing terverifikasi)

**Google Play:** SmokeStop, Quitchi, EasyQuit, Kwit, Quit Tracker, SmokeFree slowly, QuitNow!, No Smoke, QuitSave, H2M, QUIT SOS, Burnout, SWay, Smoke Free, ClearStack, Quitrise, Cut Smoking, Quit Smoking Now–Tracker, NicoQuit, Stop Smoking, Breath, ZenQuit, PuffGone, SmokeFree Ging, Quit Smoking Go, RootedLife, Qit, NoMore, Quit Smoking–Stop Tracker, BreatheStreak, QuitPath, Stosmok, Smoke Free AntoTech, QuitStreak, Qwit, quitSTART, Flamy [indeks D.1/D.4], QuitSure, My QuitBuddy, Qwit Nicotine, Day Counter, No Vape, Jones, Alive, Smoke Tracker, LastCig, injunchoi, NoSmoke, Smoxy, Craving To Quit, Sober Time, Quit Vaping, Puff Counter, QuitHaven, Quash, Quit Smoking Hero, Stop it, Progress Tracker.

**App Store:** Kwit iOS, Quit Smoking Smoke-Free, Quit Smoking Smoke Free Flamy [id1185502772 / id1462887052], Quittt, Quit Smoking Vaping & Nicotine, Smoke Free Quit Tracker, Quit It, Smoke Free 23 Ltd, Alive iOS, Stop Smoking Habit Tracker, QuitDate, quitSTART iTunes, Get Healthy, QuitNow, NHS Quit Smoking, Quittr, Quit Smoking Hero, QuitNow Medicon, Kick It, QuitSure, iQuit, Nixd, Puff Pacer, Jones, Puff Count, VapeLess, Stoppy, Ease, Nicotine Free, Nixotine, Quit Vaping App, EasyQuit, Quitzilla, My Last Cigarette, PuffNah, Stop Smoking 2 Hours, Smoke Free Now, EasyQuit Now, QuitSmoke, Quit Smoking App, Since iQuit, AI Buddy, Tabac info service, Ouiquit.

**F-Droid/IzzyOnDroid:** SmokingYou, Quitter, de.baumann, Smoking Tracker (Pintar), Smoke Reducer (arsip), ExHale, Sobriety.

**GitHub:** TrackLess, Quit-Smoke-App, Quitter (brandonp2412), QuitTrack, QuitEase, SmokeFree (web — di luar ruang lingkup), paceapp (iOS), Nonic, Breathe, SmartQuit, QuitSmoking (rmiguel1985), QuitSmoke (nepaliparadox), Quit Smoking While Smoking, Breathing Room, Moke-Smoke, QuitBuddy, smokeless, Pace (ravipurohit1991), My Tracking App, MyQuitBuddy.

**Lainnya:** Samsung Galaxy Store (#74–75, verifikasi ringan: HTTP 200 + judul halaman, 2026-11-10), Uptodown (#78, 404), IzzyOnDroid, APKPure/Aptoide/SlideME (403; terverifikasi via web), Amazon (#146–148), Tencent MyApp (戒烟), Huawei AppGallery (HK Gov / livetobaccofree.hk).

---

_Dokumen diperbarui 11 November 2026 berdasarkan riset seluruh 159 listing di `apk_serupa.md`, ditambah verifikasi ulang sampel tautan pada tanggal yang sama: Galaxy Store (#74–75) kini HTTP 200 (verifikasi ringan), Quit Tracker Uptodown (#78) berubah dari 410 menjadi 404, dan bagian C1 (usulan Dashboard Metrik Dominan) dihapus oleh pengguna bersamaan dengan penghapusan PRD `prd/dashboard_metrik_dominan.md`. Pada 11 November 2026 bagian A4 (Tool SOS Tambahan) dihapus oleh pengguna setelah fiturnya diimplementasikan, bersamaan dengan penghapusan PRD `prd/sos_craving_tool_tambahan.md`; baris rekomendasi "Tool SOS tambahan" pada tabel E digugurkan dan urutan nomor di bawah posisi 9 digeser naik. Rekomendasi menunggu penyortiran dan keputusan pengguna. Per 11 November 2026 kode `lib/fitur/sos_craving/` telah diimplementasikan sesuai PRD tersebut (menu kartu teknik + 7 teknik); dokumen ini hanya mencatat riset, bukan status implementasi._
