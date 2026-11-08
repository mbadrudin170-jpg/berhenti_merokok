# Referensi APK Sejenis

## Informasi Riset

- **Nama proyek:** Berhenti Merokok
- **Kategori aplikasi:** Aplikasi mobile pendamping berhenti merokok (pelacakan progres smoke-free, penghematan uang, impian/tujuan, biodata pengguna, pemulihan kesehatan, dukungan craving).
- **Platform:** Android (APK), dengan dukungan web untuk pengujian.
- **Tanggal penelitian:** 2026-11-08
- **Ringkasan cakupan:** Penelitian dilakukan terhadap aplikasi Android sejenis yang tersedia di Google Play Store dan sumber resmi pengembang. Fokus pada tiga ruang lingkup: (1) fitur baru yang layak dipertimbangkan, (2) optimasi fitur yang sudah tersedia pada proyek, dan (3) pola UI, UX, dan layout aplikasi kompetitor. Kondisi implementasi proyek didasarkan pada kode aktual di `lib/` (fitur: dashboard, biodata dengan mode tapering, impian, tema, dummy, pengaturan, notifikasi harian, SOS craving, pemulihan kesehatan, diary craving, kalender smoke-free, badge).
- **Keterbatasan penelitian:** Penelitian dilakukan secara daring tanpa instalasi aplikasi. Detail interaksi UI/UX didasarkan pada deskripsi resmi Google Play Store, situs pengembang, tangkapan layar resmi, dan artikel perbandingan. Beberapa aplikasi hanya tersedia di App Store (iOS) dan ditandai sebagai referensi tambahan. Tidak semua detail visual dapat diverifikasi.

## Ringkasan Temuan

Proyek sudah memiliki cakupan fitur yang cukup lengkap untuk pelacakan berhenti merokok (counter smoke-free, penghematan uang, rokok tidak dihisap, milestone kesehatan, SOS craving dengan napas 4-7-8/timer/distraksi, diary pemicu, kalender smoke-free, badge, notifikasi harian, mode berhenti bertahap). Peluang utama terletak pada: (1) akses cepat ke fitur SOS craving dari layar utama, (2) visualisasi progres yang lebih kuat (counter besar, piggy bank tabungan, grafik pemicu), (3) penanganan slip/relapse yang suportif, dan (4) widget layar beranda. Rekomendasi prioritas tinggi berfokus pada aksesibilitas SOS craving dan penanganan slip yang tidak menghakimi.

---

## A. Rekomendasi Fitur Baru

### Prioritas Tinggi

#### 1. Akses Cepat SOS Craving dari Layar Utama

- **Tujuan:** Memudahkan pengguna menjangkau bantuan craving dalam hitungan detik saat dorongan merokok muncul.
- **Masalah pengguna:** Fitur SOS Craving saat ini hanya dapat diakses melalui menu "Lainnya", sehingga membutuhkan beberapa ketukan dari layar utama.
- **Cara kerja di mobile:** Tombol aksi mengambang (FAB) atau pintasan pada Dashboard yang langsung membuka layar SOS Craving; dapat juga ditambahkan sebagai tab/destinasi navigasi.
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); QUIT Smoking SOS (ANKO Solutions); Flamy.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking ; https://flamy.co/
- **Link bukti:** Deskripsi resmi Google Play Store (fitur SOS satu ketukan).
- **Manfaat untuk proyek:** Mengurangi hambatan akses ke fitur yang paling kritis pada momen craving.
- **Ketergantungan/keterbatasan:** Perlu penyesuaian navigasi; tidak membutuhkan dependensi baru.
- **Alasan prioritas:** Sangat sesuai dengan tujuan aplikasi dan menjawab kebutuhan pengguna utama pada momen kritis.

### Prioritas Sedang

#### 2. Pencatatan Slip/Relapse yang Suportif

- **Tujuan:** Memungkinkan pengguna mencatat jika sempat merokok lagi tanpa kehilangan seluruh progres, dengan pesan yang tidak menghakimi.
- **Masalah pengguna:** Saat ini progres dihitung dari satu tanggal berhenti; jika pengguna merokok lagi, tidak ada mekanisme pencatatan slip yang mempertahankan riwayat.
- **Cara kerja di mobile:** Opsi "catat slip" yang mencatat waktu dan pemicu, memulai ulang penghitung smoke-free, namun mempertahankan riwayat sebelumnya (streak terpanjang, total rokok dihindari).
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); Quitzilla; MeQuit.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://quitzilla.com/ ; https://stopsmokingapp.com/quit-smoking-daily-motivation-app
- **Link bukti:** Deskripsi resmi ("It's OK to Fail", relapse sebagai entri diary, reset plan).
- **Manfaat untuk proyek:** Mendukung realitas proses berhenti merokok dan mengurangi rasa gagal.
- **Ketergantungan/keterbatasan:** Memerlukan penyesuaian perhitungan smoke-free dan riwayat.
- **Alasan prioritas:** Relevan dan bermanfaat, memerlukan pertimbangan tambahan.

#### 3. Kuis Onboarding dan Rencana Berhenti

- **Tujuan:** Membantu pengguna baru menyusun rencana berhenti merokok (tanggal berhenti, pemicu, strategi) sejak awal.
- **Masalah pengguna:** Form biodata saat ini hanya mencatat data dasar tanpa panduan menyusun rencana.
- **Cara kerja di mobile:** Kuis singkat (pemicu, kebiasaan, alasan) yang menghasilkan rencana berhenti dan strategi koping.
- **Aplikasi referensi:** Kick It (UC San Diego); QUIT Smoking SOS (ANKO Solutions); Flamy.
- **Link aplikasi:** https://kickitca.org/app ; https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking ; https://flamy.co/
- **Link bukti:** Deskripsi resmi (quit plan, onboarding quiz, personal quit plan).
- **Manfaat untuk proyek:** Meningkatkan kesiapan pengguna dan personalisasi.
- **Ketergantungan/keterbatasan:** Memerlukan konten dan logika tambahan.
- **Alasan prioritas:** Relevan, dampak terbatas pada sebagian pengguna.

#### 4. Widget Layar Beranda (Home Widget)

- **Tujuan:** Menampilkan penghitung smoke-free dan tabungan langsung di layar beranda tanpa membuka aplikasi.
- **Masalah pengguna:** Pengguna harus membuka aplikasi untuk melihat progres terkini.
- **Cara kerja di mobile:** Widget Android yang menampilkan hari smoke-free dan uang tersimpan, diperbarui secara berkala.
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); Quit Tracker (despDev); QUIT Smoking SOS (ANKO Solutions); Bommi.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://quittracker.app/ ; https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking ; https://bommi.lazyhippodev.com/
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Manfaat untuk proyek:** Meningkatkan visibilitas progres dan motivasi harian.
- **Ketergantungan/keterbatasan:** Membutuhkan paket tambahan (mis. `home_widget`) dan uji coba Android; di luar dependensi saat ini.
- **Alasan prioritas:** Bermanfaat, tetapi kompleksitas lebih besar dibanding manfaat awal.

### Prioritas Rendah

#### 6. Permainan Kecil untuk Distraksi (Mini-games)

- **Tujuan:** Memberikan distraksi interaktif saat craving (selain daftar aktivitas statis).
- **Masalah pengguna:** Daftar distraksi saat ini berupa teks statis tanpa interaksi.
- **Cara kerja di mobile:** Permainan sederhana (pasangan kartu, matematika cepat, 2048) yang dapat dimainkan 3-5 menit.
- **Aplikasi referensi:** EasyQuit (Herzberg); Quit Tracker (despDev); QUIT Smoking SOS (ANKO Solutions); Flamy.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking ; https://quittracker.app/ ; https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking ; https://flamy.co/
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Manfaat untuk proyek:** Meningkatkan keterlibatan saat craving.
- **Ketergantungan/keterbatasan:** Memerlukan pengembangan UI/game tambahan.
- **Alasan prioritas:** Bersifat tambahan; dampak belum terlalu kuat.

#### 7. Pelacakan Toxin yang Dihindari

- **Tujuan:** Menampilkan zat berbahaya (tar, karbon monoksida, dll.) yang dihindari dengan tidak merokok.
- **Masalah pengguna:** Pengguna hanya melihat jumlah rokok dan uang, belum zat berbahaya.
- **Cara kerja di mobile:** Daftar perkiraan toxin yang dihindari berdasarkan jumlah rokok tidak dihisap.
- **Aplikasi referensi:** LastCig (VictorExplore).
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.lastcig.app
- **Link bukti:** Deskripsi resmi Google Play Store (toxin tracking).
- **Manfaat untuk proyek:** Menambah pemahaman dampak kesehatan.
- **Ketergantungan/keterbatasan:** Memerlukan data faktor konversi yang akurat.
- **Alasan prioritas:** Bersifat tambahan; bukti terbatas.

#### 8. Dukungan Perangkat Wearable (Wear OS)

- **Tujuan:** Menampilkan progres smoke-free di jam tangan.
- **Masalah pengguna:** Pengguna harus membuka ponsel untuk melihat progres.
- **Cara kerja di mobile:** Aplikasi pendamping Wear OS yang menampilkan hari smoke-free dan tabungan.
- **Aplikasi referensi:** QuitNow (Fewlaps).
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa
- **Link bukti:** Deskripsi resmi Google Play Store (Wear OS app and tiles).
- **Manfaat untuk proyek:** Meningkatkan aksesibilitas progres.
- **Ketergantungan/keterbatasan:** Memerlukan pengembangan platform Wear OS yang signifikan.
- **Alasan prioritas:** Kompleksitas lebih besar dibanding manfaatnya.

#### 9. Komunitas dan Sesi Ahli

- **Tujuan:** Dukungan sosial dari sesama pengguna dan akses ke sesi ahli.
- **Masalah pengguna:** Pengguna berhenti merokok sendirian tanpa dukungan komunitas.
- **Cara kerja di mobile:** Chat in-app, grup, atau feed komunitas; sesi live dengan ahli.
- **Aplikasi referensi:** QuitNow (Fewlaps); Flamy (Offlinefirst); Smoke Free (Portable Pixels).
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa ; https://play.google.com/store/apps/details?id=net.offlinefirst.flamy ; https://play.google.com/store/apps/details?id=com.portablepixels.smokefree
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Manfaat untuk proyek:** Dukungan sosial yang terbukti membantu.
- **Ketergantungan/keterbatasan:** Membutuhkan backend, moderasi, dan sumber daya yang belum tersedia.
- **Alasan prioritas:** Di luar ruang lingkup aplikasi lokal saat ini.

#### 10. AI Coach / Panduan Personal

- **Tujuan:** Memberikan saran personal berdasarkan profil dan pola pengguna.
- **Masalah pengguna:** Pengguna tidak mendapatkan panduan personal selain data statis.
- **Cara kerja di mobile:** Chatbot yang menjawab pertanyaan dan memberi rencana harian berdasarkan data pengguna.
- **Aplikasi referensi:** QUIT Smoking SOS (ANKO Solutions); Quit It (Antonis Evmorfopoulos).
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking ; https://play.google.com/store/apps/details?id=com.quititapp
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Manfaat untuk proyek:** Personalisasi dukungan.
- **Ketergantungan/keterbatasan:** Membutuhkan backend/AI yang belum tersedia.
- **Alasan prioritas:** Kompleksitas tinggi untuk proyek lokal.

#### 11. Misi Harian dan Tantangan

- **Tujuan:** Memberikan tantangan harian untuk menjaga keterlibatan.
- **Masalah pengguna:** Tidak ada tantangan terstruktur untuk menjaga motivasi jangka panjang.
- **Cara kerja di mobile:** Misi harian kecil (minum air, jalan kaki) dengan pencapaian.
- **Aplikasi referensi:** Smoke Free (Portable Pixels); Quit It (Antonis Evmorfopoulos).
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.quititapp
- **Link bukti:** Deskripsi resmi Google Play Store (daily missions).
- **Manfaat untuk proyek:** Meningkatkan keterlibatan harian.
- **Ketergantungan/keterbatasan:** Memerlukan konten dan logika tantangan.
- **Alasan prioritas:** Bersifat tambahan.

---

## B. Optimasi Fitur yang Sudah Ada

### Prioritas Tinggi

#### 1. Aksesibilitas SOS Craving

- **Kondisi fitur pada proyek:** SOS Craving tersedia dengan tab Napas 4-7-8, Timer 3 Menit, dan Distraksi, namun hanya diakses dari menu "Lainnya".
- **Status implementasi:** Sebagian (fitur lengkap, akses terbatas).
- **Path implementasi proyek:** `lib/fitur/sos_craving/screens/sos_craving_screen.dart`, `lib/lainnya_screen.dart`.
- **Aplikasi pembanding:** Quit Smoking : Tracker & Timer (H2M apps); QUIT Smoking SOS (ANKO Solutions).
- **Implementasi referensi:** SOS satu ketukan dari layar utama/dashboard.
- **Peluang optimasi:** Menambahkan pintasan SOS pada Dashboard atau tombol aksi mengambang.
- **Saran optimasi:** Tambahkan FAB atau kartu SOS pada Dashboard yang langsung membuka `SosCravingScreen`.
- **Tujuan dan manfaat:** Mengurangi waktu akses saat craving.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Sangat sesuai dengan tujuan aplikasi dan menjawab kebutuhan pengguna utama.

### Prioritas Sedang

#### 2. Impian (Goals/Tabungan)

- **Kondisi fitur pada proyek:** Daftar impian dengan nama, jumlah target, target tanggal, progress bar berbasis saldo terkumpul, dan state kosong dengan CTA sudah tersedia.
- **Status implementasi:** Sebagian (core impian dan progress ada; visual piggy bank/reward belum).
- **Path implementasi proyek:** `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/impian/screens/form_impian.dart`, `lib/fitur/impian/screens/detail_impian_screen.dart`.
- **Aplikasi pembanding:** Breev (Aura App Studio); Flamy (Offlinefirst); Quit It (Antonis Evmorfopoulos).
- **Implementasi referensi:** Piggy bank visual dengan tema (Breev), savings goals dengan item keinginan (Flamy), savings goals dengan reward (Quit It).
- **Peluang optimasi:** Menambahkan visualisasi progres tabungan (piggy bank) dan opsi "hadiah" saat impian tercapai.
- **Saran optimasi:** Tambahkan indikator visual (mis. piggy bank) dan pesan perayaan saat impian tercapai.
- **Tujuan dan manfaat:** Meningkatkan motivasi dan kejelasan progres menuju tujuan finansial.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.aura.stopsmoking ; https://play.google.com/store/apps/details?id=net.offlinefirst.flamy ; https://play.google.com/store/apps/details?id=com.quititapp
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Relevan dan bermanfaat, dampak terbatas.

#### 3. Biodata (Profil Merokok)

- **Kondisi fitur pada proyek:** Biodata mencakup nama, tanggal lahir, jumlah rokok/hari, harga rokok/bungkus, tanggal mulai merokok, tanggal mulai berhenti, mode berhenti (seketika/bertahap), penurunan per minggu, dan tanggal mulai penurunan.
- **Status implementasi:** Sebagian (field dasar dan tapering ada; alasan berhenti dan target smoke-free belum).
- **Path implementasi proyek:** `lib/fitur/biodata/screens/biodata_screen.dart`, `lib/fitur/biodata/screens/form_biodata.dart`, `lib/fitur/biodata/model/biodata_model.dart`.
- **Aplikasi pembanding:** Smoke Free (Portable Pixels); Quit Tracker (despDev); Kick It (UC San Diego).
- **Implementasi referensi:** Profil merokok dengan input jumlah rokok, harga, trigger; beberapa meminta alasan berhenti dan target.
- **Peluang optimasi:** Menambahkan field opsional "alasan berhenti" dan "target smoke-free" (hari) pada biodata.
- **Saran optimasi:** Tambahkan field opsional alasan berhenti dan target smoke-free, tampilkan di dashboard sebagai motivasi.
- **Tujuan dan manfaat:** Personalisasi pengalaman dan penguatan motivasi.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.despdev.quitsmoking ; https://play.google.com/store/apps/details?id=com.kickitca
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Relevan, dampak terbatas.

#### 4. Dashboard (Ringkasan Progres)

- **Status PRD:** Sudah dibuat — `prd/optimasi-dashboard-ringkasan-progres.md`
- **Kondisi fitur pada proyek:** Dashboard menampilkan metrik smoke-free (uang dihemat, rokok tidak dihisap), milestone kesehatan terdekat, dan shortcut pencapaian.
- **Status implementasi:** Sebagian (metrik dasar dan milestone ada; jumlah impian/impian tercapai dan streak terpanjang belum ditampilkan).
- **Path implementasi proyek:** `lib/fitur/dashboard/screens/dashboard_screen.dart`.
- **Aplikasi pembanding:** QuitNow (Fewlaps); Smoke Free (Portable Pixels); Quit Tracker (despDev).
- **Implementasi referensi:** Dashboard dengan counter smoke-free, uang tersimpan, rokok tidak terhisap, dan milestone tercapai.
- **Peluang optimasi:** Menambahkan ringkasan jumlah impian dan impian tercapai, serta streak terpanjang.
- **Saran optimasi:** Tambahkan kartu ringkasan impian dan streak terpanjang pada Dashboard.
- **Tujuan dan manfaat:** Menyelaraskan dashboard dengan tujuan aplikasi dan memberikan informasi bermakna.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa ; https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.despdev.quitsmoking
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Relevan, dampak terbatas.

#### 5. Diary Craving (Catatan Pemicu)

- **Kondisi fitur pada proyek:** Diary Craving tersedia dengan daftar, form, empty state, dan pemicu enum.
- **Status implementasi:** Sebagian (pencatatan ada; analisis pemicu belum).
- **Path implementasi proyek:** `lib/fitur/diary_craving/screens/diary_craving_screen.dart`, `lib/fitur/diary_craving/screens/form_diary_craving.dart`, `lib/fitur/diary_craving/enum/pemicu_enum.dart`.
- **Aplikasi pembanding:** Smoke Free (Portable Pixels); Quit It (Antonis Evmorfopoulos); EasyQuit (Herzberg).
- **Implementasi referensi:** Cravings analysis, trigger insights (pie chart), log pemicu.
- **Peluang optimasi:** Menambahkan analisis pemicu (mis. grafik) dan laporan mingguan.
- **Saran optimasi:** Tambahkan ringkasan pemicu teratas dan tren mingguan pada layar Diary Craving.
- **Tujuan dan manfaat:** Membantu pengguna mengenali pola pemicu.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.quititapp ; https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Relevan, dampak terbatas.

#### 6. Notifikasi (Pengingat Harian)

- **Kondisi fitur pada proyek:** Notifikasi harian terjadwal dengan toggle, pemilih waktu, uji coba, dan penjadwalan ulang saat aplikasi dibuka sudah tersedia.
- **Status implementasi:** Sebagian (pengingat harian ada; pengingat berbasis pola craving belum).
- **Path implementasi proyek:** `lib/shared/notifikasi/notifikasi_service.dart`, `lib/fitur/pengaturan/screens/pengaturan_screen.dart`.
- **Aplikasi pembanding:** Quit Smoking : Tracker & Timer (H2M apps); Quit It (Antonis Evmorfopoulos); MeQuit.
- **Implementasi referensi:** Morning check-in, pengingat pada jam craving tinggi, rencana notifikasi kustom.
- **Peluang optimasi:** Menambahkan pengingat berbasis pola craving pengguna dan check-in pagi.
- **Saran optimasi:** Tambahkan opsi pengingat pada jam-jam yang sering craving (berdasarkan diary) dan check-in pagi.
- **Tujuan dan manfaat:** Meningkatkan relevansi notifikasi.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://www.quit-it-web.com/ ; https://stopsmokingapp.com/quit-smoking-daily-motivation-app
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Relevan, dampak terbatas.

#### 7. Onboarding dan Empty State

- **Kondisi fitur pada proyek:** Flow FormBiodata awal dan empty state pada daftar impian sudah tersedia.
- **Status implementasi:** Sebagian (empty state ada; tips onboarding belum jelas).
- **Path implementasi proyek:** `lib/fitur/biodata/screens/form_biodata.dart`, `lib/fitur/impian/screens/impian_screen.dart`.
- **Aplikasi pembanding:** quitSTART (Smokefree.gov); Kick It (UC San Diego).
- **Implementasi referensi:** Onboarding dengan tips persiapan berhenti dan empty state yang menjelaskan langkah berikutnya.
- **Peluang optimasi:** Menambahkan tips singkat pada FormBiodata awal.
- **Saran optimasi:** Tambahkan tips singkat pada FormBiodata awal (mis. "Tentukan tanggal berhenti dan target").
- **Tujuan dan manfaat:** Memandu pengguna baru agar tidak bingung.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.mmgct.quitstart ; https://play.google.com/store/apps/details?id=com.kickitca
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Relevan, dampak terbatas.

### Prioritas Rendah

#### 8. Pemulihan Kesehatan (Milestone)

Status PRD: Sudah dibuat — `prd/optimasi-pemulihan-kesehatan-milestone.md`

- **Kondisi fitur pada proyek:** Daftar milestone dengan status tercapai/belum dan waktu target sudah tersedia.
- **Status implementasi:** Sudah diimplementasikan (metrik dasar); penambahan "hari hidup yang diperoleh" belum.
- **Path implementasi proyek:** `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`, `lib/shared/konstanta/milestone_kesehatan.dart`.
- **Aplikasi pembanding:** Quit Smoking : Tracker & Timer (H2M apps); Smoke Free (Portable Pixels).
- **Implementasi referensi:** 24 milestone kesehatan, health improvement bars.
- **Peluang optimasi:** Menambahkan metrik "hari hidup yang diperoleh" atau visual progress bar yang lebih detail.
- **Saran optimasi:** Tambahkan visual progress bar per milestone dan metrik tambahan yang relevan.
- **Tujuan dan manfaat:** Memperjelas manfaat kesehatan.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.portablepixels.smokefree
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Bersifat tambahan.

#### 9. Badge dan Pencapaian

- **Kondisi fitur pada proyek:** Sistem badge berbasis durasi smoke-free dan impian tercapai sudah tersedia.
- **Status implementasi:** Sudah diimplementasikan.
- **Path implementasi proyek:** `lib/fitur/badge/screens/badge_screen.dart`, `lib/fitur/badge/helper/badge_helper.dart`.
- **Aplikasi pembanding:** QuitNow (Fewlaps); Smoke Free (Portable Pixels); EasyQuit (Herzberg).
- **Implementasi referensi:** Badge otomatis saat mencapai durasi/uang tertentu, 80+ milestone.
- **Peluang optimasi:** Menambah variasi badge (craving berhasil dilewati, jumlah impian tercapai).
- **Saran optimasi:** Tambahkan badge berbasis jumlah craving yang berhasil dilewati dan impian tercapai.
- **Tujuan dan manfaat:** Meningkatkan motivasi.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa ; https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Bersifat tambahan.

#### 10. Tema dan Personalisasi

- **Kondisi fitur pada proyek:** Pilihan tema Sistem/Terang/Gelap tersedia melalui pengaturan.
- **Status implementasi:** Sudah diimplementasikan.
- **Path implementasi proyek:** `lib/fitur/tema/notifier/tema_notifier.dart`, `lib/fitur/pengaturan/screens/pengaturan_screen.dart`.
- **Aplikasi pembanding:** Quit Smoking : Tracker & Timer (H2M apps).
- **Implementasi referensi:** 16 tema latar dan 15 warna aksen.
- **Peluang optimasi:** Menambah pilihan tema/warna aksen.
- **Saran optimasi:** Tambahkan pilihan warna aksen atau tema tambahan.
- **Tujuan dan manfaat:** Personalisasi tampilan.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke
- **Link bukti:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Bersifat tambahan.

---

## C. Rekomendasi UI, UX, dan Layout

### Prioritas Tinggi

#### 1. Tombol SOS Craving yang Mudah Dijangkau

- **Fitur/halaman yang dibandingkan:** SOS Craving.
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); QUIT Smoking SOS (ANKO Solutions); Flamy.
- **Pola UI:** Tombol SOS besar dan mencolok pada layar utama.
- **Pola UX:** Akses satu ketukan ke bantuan craving.
- **Pola layout:** Pintasan pada dashboard atau tombol aksi mengambang.
- **Tujuan pola:** Mengurangi hambatan pada momen kritis.
- **Kondisi pada proyek:** SOS Craving tersedia tetapi diakses dari menu "Lainnya".
- **Saran untuk proyek:** Tambahkan kartu atau FAB SOS Craving pada Dashboard.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking ; https://flamy.co/
- **Link screenshot atau sumber visual:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Sangat sesuai dengan tujuan aplikasi.

### Prioritas Sedang

#### 2. Counter Smoke-Free Besar pada Dashboard

- **Fitur/halaman yang dibandingkan:** Dashboard.
- **Aplikasi referensi:** QuitNow (Fewlaps); LastCig (VictorExplore); Quit Tracker (despDev).
- **Pola UI:** Angka besar untuk hari/jam smoke-free di bagian atas layar.
- **Pola UX:** Informasi utama terlihat segera saat membuka aplikasi.
- **Pola layout:** Counter besar di atas kartu ringkasan.
- **Tujuan pola:** Meningkatkan motivasi melalui visibilitas progres.
- **Kondisi pada proyek:** Dashboard menampilkan metrik dalam kartu; counter besar belum menonjol.
- **Saran untuk proyek:** Tampilkan counter smoke-free (hari, jam) dengan ukuran besar di bagian atas Dashboard.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa ; https://play.google.com/store/apps/details?id=com.lastcig.app ; https://quittracker.app/
- **Link screenshot atau sumber visual:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Relevan dan bermanfaat.

#### 3. Visualisasi Tabungan (Piggy Bank)

- **Fitur/halaman yang dibandingkan:** Impian.
- **Aplikasi referensi:** Breev (Aura App Studio); Quit It (Antonis Evmorfopoulos).
- **Pola UI:** Visualisasi piggy bank/tabungan yang terisi sesuai progres.
- **Pola UX:** Memberikan kepuasan visual saat progres bertambah.
- **Pola layout:** Ilustrasi pada kartu impian atau dashboard.
- **Tujuan pola:** Meningkatkan motivasi dan kejelasan progres.
- **Kondisi pada proyek:** Impian menggunakan progress bar; visual piggy bank belum ada.
- **Saran untuk proyek:** Tambahkan ilustrasi piggy bank yang terisi sesuai progres saldo terkumpul.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.aura.stopsmoking ; https://play.google.com/store/apps/details?id=com.quititapp
- **Link screenshot atau sumber visual:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Relevan, dampak terbatas.
- **Status PRD:** Sudah dibuat — prd/optimasi-impian-tabungan.md

#### 4. Grafik dan Insight Pemicu

- **Fitur/halaman yang dibandingkan:** Diary Craving.
- **Aplikasi referensi:** EasyQuit (Herzberg); Quit It (Antonis Evmorfopoulos); Smoke Free (Portable Pixels).
- **Pola UI:** Pie chart atau daftar pemicu teratas.
- **Pola UX:** Membantu pengguna mengenali pola pemicu.
- **Pola layout:** Ringkasan di atas daftar diary.
- **Tujuan pola:** Meningkatkan kesadaran diri.
- **Kondisi pada proyek:** Diary Craving menampilkan daftar; insight pemicu belum ada.
- **Saran untuk proyek:** Tambahkan ringkasan pemicu teratas pada layar Diary Craving.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking ; https://play.google.com/store/apps/details?id=com.quititapp ; https://play.google.com/store/apps/details?id=com.portablepixels.smokefree
- **Link screenshot atau sumber visual:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Relevan, dampak terbatas.

#### 5. Pesan Suportif Saat Slip

- **Fitur/halaman yang dibandingkan:** Alur berhenti merokok.
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); Quitzilla.
- **Pola UI:** Pesan "It's OK to fail" dan opsi reset yang tidak menghakimi.
- **Pola UX:** Mengurangi rasa gagal dan mendorong mencoba lagi.
- **Pola layout:** Dialog konfirmasi dengan pesan suportif.
- **Tujuan pola:** Mendukung realitas proses berhenti merokok.
- **Kondisi pada proyek:** Belum ada penanganan slip yang suportif.
- **Saran untuk proyek:** Tambahkan pesan suportif dan opsi "catat slip" yang tidak menghakimi.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://quitzilla.com/
- **Link screenshot atau sumber visual:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Relevan, dampak terbatas.

#### 6. Restrukturisasi Navigasi

- **Fitur/halaman yang dibandingkan:** Navigasi utama.
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); QUIT Smoking SOS (ANKO Solutions).
- **Pola UI:** Tab/destinasi untuk fitur yang sering digunakan (SOS, Diary).
- **Pola UX:** Mengurangi langkah untuk fitur penting.
- **Pola layout:** Bottom navigation dengan destinasi tambahan atau shortcut dashboard.
- **Tujuan pola:** Meningkatkan aksesibilitas fitur penting.
- **Kondisi pada proyek:** Fitur SOS, Diary, Kalender, Pemulihan berada di menu "Lainnya".
- **Saran untuk proyek:** Pertimbangkan memindahkan SOS Craving dan Diary Craving ke shortcut dashboard atau tab terpisah.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking
- **Link screenshot atau sumber visual:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Relevan, dampak terbatas.

### Prioritas Rendah

#### 7. Personalisasi Tema Lebih Luas

- **Fitur/halaman yang dibandingkan:** Pengaturan.
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps).
- **Pola UI:** 16 tema latar dan 15 warna aksen.
- **Pola UX:** Personalisasi tampilan sesuai preferensi.
- **Pola layout:** Pemilih tema/warna pada pengaturan.
- **Tujuan pola:** Meningkatkan keterikatan pengguna.
- **Kondisi pada proyek:** Hanya Sistem/Terang/Gelap.
- **Saran untuk proyek:** Tambahkan pilihan warna aksen.
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke
- **Link screenshot atau sumber visual:** Deskripsi resmi Google Play Store.
- **Alasan prioritas:** Bersifat tambahan.

---

## D. Daftar Aplikasi Kompetitor

| Aplikasi                               | Pengembang            | Platform    | Fitur Relevan                                                                                                 | Link Store                                                                                    | Sumber Tambahan                                                              |
| -------------------------------------- | --------------------- | ----------- | ------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| Quit Smoking : Tracker & Timer         | H2M apps              | Android     | Counter real-time, 24 milestone kesehatan, SOS craving, widget beranda, kalender, notifikasi cerdas           | https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke                          | Deskripsi resmi Google Play                                                  |
| Smoke Free                             | Portable Pixels       | Android     | Coaches, badge, log craving, health improvement bars, diary pemicu, daily missions                            | https://play.google.com/store/apps/details?id=com.portablepixels.smokefree                    | https://smokefreeapp.com/faq                                                 |
| QuitNow                                | Fewlaps               | Android     | Ex-smoker status, chat komunitas, sesi ahli, 80 milestone, Wear OS, buku                                      | https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa                      | Deskripsi resmi Google Play                                                  |
| Stop Smoking - EasyQuit                | Herzberg              | Android     | Slow mode (tapering), statistik uang, craving trigger pie chart, game pasangan, 100+ badge, treat savings     | https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking                    | Deskripsi resmi Google Play                                                  |
| Quit Tracker                           | despDev               | Android     | Home screen widget, card game distraksi, diary, statistik, penyimpanan lokal                                  | https://play.google.com/store/apps/details?id=com.despdev.quitsmoking                         | https://quittracker.app/                                                     |
| Quit It                                | Antonis Evmorfopoulos | Android/iOS | Trigger insights, personal rewards, craving management, jurnal                                                | https://play.google.com/store/apps/details?id=com.quititapp                                   | https://www.quit-it-web.com/                                                 |
| Kick It                                | UC San Diego          | Android/iOS | Check-in harian, quit plan, trigger & strategi, badge, multi-bahasa                                           | https://play.google.com/store/apps/details?id=com.kickitca                                    | https://kickitca.org/app                                                     |
| quitSTART                              | Smokefree.gov         | Android     | Tips personalisasi, tantangan, game, Quit Kit, tag pemicu                                                     | https://play.google.com/store/apps/details?id=com.mmgct.quitstart                             | https://smokefree.gov/tools-tips/quitstart                                   |
| QUIT Smoking SOS                       | ANKO Solutions        | Android     | SOS satu ketukan, napas, mini-games, artikel, AI coach Quity, 15 achievement, widget beranda, onboarding quiz | https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking                         | Deskripsi resmi Google Play                                                  |
| Smoke Tracker: Track & Pace            | Codeas                | Android     | Log rokok/vape, biaya, batas harian, reward/coins, achievement, pencadangan terenkripsi                       | https://play.google.com/store/apps/details?id=com.smoketracker.app                            | Deskripsi resmi Google Play                                                  |
| LastCig                                | VictorExplore         | Android     | Timer real-time, log rokok/craving, toxin tracking, privasi lokal (tanpa akun)                                | https://play.google.com/store/apps/details?id=com.lastcig.app                                 | Deskripsi resmi Google Play                                                  |
| Bommi                                  | Lazy Hippo            | Android/iOS | Urge rescue widget, streak, uang tersimpan, kalori, milestone, tema terang/gelap                              | https://bommi.lazyhippodev.com/                                                               | Situs resmi                                                                  |
| Flamy                                  | Offlinefirst          | Android/iOS | Rencana berhenti personal (6 pertanyaan), SOS napas/distraksi, health tracker, game, bagikan progres, CBT     | https://play.google.com/store/apps/details?id=net.offlinefirst.flamy                          | https://flamy.co/                                                            |
| Quitzilla                              | Quitzilla             | Android/iOS | Timer, uang & waktu diperoleh, alasan berhenti, diary relapse, ekspor CSV, pencadangan Google Drive           | https://quitzilla.com/                                                                        | Situs resmi                                                                  |
| Quit Smoking: Progress Tracker         | Inspector Studios     | Android     | Quit plan, diary pemicu, mood, laporan mingguan, insight, achievement, reasons vault, CBT                     | https://play.google.com/store/apps/details?id=com.inspectorstudios.quitsmokingprogresstracker | Deskripsi resmi Google Play                                                  |
| MeQuit (Stop Smoking Daily Motivation) | Stop Smoking App      | Android/iOS | Trigger logging, pengingat kustom, reset slip, statistik                                                      | https://stopsmokingapp.com/quit-smoking-daily-motivation-app                                  | Situs resmi                                                                  |
| Quit Smoking: Widget Tracker           | KEISUKE ONO           | iOS         | Widget beranda, live activity, tombol craving satu ketukan, breathing guide, insight jam/tempat               | App Store                                                                                     | https://www.appbrain.com/appstore/quit-smoking-widget-tracker/ios-6789900590 |

## E. Catatan Validasi dan Keterbatasan

- **Informasi yang belum terverifikasi:** Detail visual (posisi tombol, warna, struktur halaman) sebagian besar didasarkan pada deskripsi resmi dan tangkapan layar yang tersedia; tidak semua dapat diperiksa secara langsung karena penelitian dilakukan daring tanpa instalasi aplikasi.
- **Screenshot atau alur yang belum dapat diperiksa:** Alur interaksi detail (animasi, gesture, transisi) tidak dapat diverifikasi; hanya deskripsi fitur yang dapat dikonfirmasi dari sumber resmi.
- **Tools yang tidak tersedia:** Tidak ada akses ke emulator Android atau perangkat fisik; pengujian aplikasi kompetitor tidak dilakukan secara langsung.
- **Hal yang perlu diperiksa lebih lanjut:** Ketersediaan dan kestabilan paket `home_widget` untuk widget beranda; akurasi data toxin yang dihindari.
- **Keterbatasan sumber:** Beberapa aplikasi hanya tersedia di App Store (iOS) dan ditandai sebagai referensi tambahan. Informasi fitur didasarkan pada deskripsi resmi Google Play Store dan situs pengembang. Tanggal penelitian: 2026-11-08; informasi aplikasi dapat berubah sewaktu-waktu.

---

_File ini diperbarui berdasarkan hasil penelitian referensi APK sejenis pada 2026-11-08._
