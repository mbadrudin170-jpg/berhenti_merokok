# Referensi APK Sejenis

## Informasi Penelitian

- **Nama proyek:** Berhenti Merokok
- **Jenis aplikasi:** Aplikasi mobile pendamping berhenti merokok (pelacakan progres smoke-free, penghematan uang, impian/tujuan, biodata pengguna).
- **Platform:** Android (APK), dengan dukungan web untuk pengujian.
- **Tanggal penelitian:** 2026-11-07
- **Ringkasan hasil penelitian:** Penelitian dilakukan terhadap aplikasi Android sejenis yang tersedia di Google Play Store, terutama aplikasi pelacak berhenti merokok. Ditemukan referensi fitur baru (timer smoke-free real-time, milestone kesehatan, SOS craving, diary pemicu, badge, notifikasi, widget layar beranda, mode berhenti bertahap, AI coach), peningkatan fitur yang sudah ada (impian, biodata, dashboard), serta pola UI/UX (counter besar, timeline kesehatan, kalender smoke-free, tombol SOS satu ketukan, piggy bank tabungan). Prioritas disusun berdasarkan relevansi dengan tujuan proyek dan manfaat bagi pengguna.

---

## 1. Referensi Fitur Baru

### Timer Smoke-Free Real-Time

- **Prioritas:** Tinggi
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); Smoke Free (Portable Pixels); Quit Tracker (despDev)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.despdev.quitsmoking
- **Link sumber pendukung:** Deskripsi resmi Google Play Store masing-masing aplikasi.
- **Tujuan fitur:** Menampilkan durasi smoke-free secara real-time agar pengguna mendapat umpan balik langsung dan motivasi berkelanjutan.
- **Penerapan pada aplikasi referensi:** Menampilkan penghitung hari/jam/menit sejak tanggal berhenti, seringkali pada halaman utama dengan angka besar.
- **Relevansi terhadap proyek:** Proyek sudah menyimpan `tanggalMulaiBerhentiMerokok` pada biodata, tetapi belum menampilkan penghitung smoke-free real-time.
- **Rekomendasi:** Tambahkan penghitung smoke-free (hari, jam, menit) pada Dashboard, dihitung dari `tanggalMulaiBerhentiMerokok`.

### Milestone Kesehatan (Pemulihan Tubuh)

- **Prioritas:** Tinggi
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); Smoke Free (Portable Pixels); EasyQuit (Herzberg)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Tujuan fitur:** Menunjukkan perubahan kesehatan tubuh berdasarkan waktu tanpa rokok (mis. 20 menit tekanan darah normal, 48 jam pengecapan membaik, 72 jam nikotin hilang, 1 tahun risiko jantung turun).
- **Penerapan pada aplikasi referensi:** Daftar milestone dengan waktu target dan status tercapai/belum, sering ditampilkan sebagai timeline atau progress bar.
- **Relevansi terhadap proyek:** Proyek belum memiliki informasi kesehatan pemulihan. Data tanggal berhenti sudah tersedia sehingga milestone dapat dihitung.
- **Rekomendasi:** Tambahkan halaman/section "Pemulihan Kesehatan" yang menampilkan milestone berdasarkan durasi smoke-free.

### SOS Craving (Bantuan Saat Dorongan Merokok)

- **Prioritas:** Tinggi
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); QUIT Smoking Cessation SOS (ANKO Solutions); Expire (FitCal)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking ; https://play.google.com/store/apps/details?id=com.virex.expire
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Tujuan fitur:** Memberikan bantuan cepat saat craving (timer 3 menit, latihan napas 4-7-8, distraksi) untuk mencegah relapse.
- **Penerapan pada aplikasi referensi:** Tombol SOS satu ketukan yang membuka latihan napas, timer, atau mini-game.
- **Relevansi terhadap proyek:** Proyek belum memiliki fitur bantuan craving. Fitur ini langsung mendukung tujuan utama aplikasi.
- **Rekomendasi:** Tambahkan tombol SOS yang membuka latihan napas (4-7-8) dan timer craving 3 menit.

### Diary Pemicu dan Craving (Trigger Tracking)

- **Prioritas:** Tinggi
- **Aplikasi referensi:** EasyQuit (Herzberg); QuitSure (RapidKart); Kwit (Kwit SAS)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking ; https://play.google.com/store/apps/details?id=org.instaquit.app ; https://play.google.com/store/apps/details?id=fr.kwit.android
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Tujuan fitur:** Mencatat pemicu (stres, kopi, alkohol, sosial) dan craving untuk mengidentifikasi pola dan mencegah relapse.
- **Penerapan pada aplikasi referensi:** Form pencatatan craving dengan kategori pemicu, kadang ditampilkan sebagai pie chart (EasyQuit).
- **Relevansi terhadap proyek:** Proyek belum mencatat pemicu/craving. Data ini berguna untuk analisis dan personalisasi.
- **Rekomendasi:** Tambahkan fitur pencatatan craving dengan pilihan pemicu, disimpan ke database (tabel baru + migrasi).

### Badge dan Pencapaian (Gamifikasi)

- **Prioritas:** Sedang
- **Aplikasi referensi:** QuitNow (Fewlaps); Smoke Free (Portable Pixels); EasyQuit (Herzberg); Kick It (UC San Diego)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa ; https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking ; https://play.google.com/store/apps/details?id=com.kickitca
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Tujuan fitur:** Memberikan penghargaan (badge) saat mencapai milestone untuk meningkatkan motivasi.
- **Penerapan pada aplikasi referensi:** Badge otomatis saat mencapai durasi/uang tertentu, ditampilkan di profil atau dashboard.
- **Relevansi terhadap proyek:** Proyek belum memiliki sistem pencapaian. Dapat meningkatkan engagement.
- **Rekomendasi:** Tambahkan sistem badge sederhana berbasis durasi smoke-free dan jumlah impian tercapai.

### Notifikasi Harian dan Pengingat

- **Prioritas:** Sedang
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); Kick It (UC San Diego)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.kickitca
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Tujuan fitur:** Pengingat pagi, check-in harian, dan notifikasi motivasi untuk menjaga konsistensi.
- **Penerapan pada aplikasi referensi:** Notifikasi terjadwal (morning check-in, pengingat craving) yang dapat disesuaikan.
- **Relevansi terhadap proyek:** Proyek belum memiliki notifikasi. Aturan proyek sudah menyediakan `flutter_local_notifications` dan `NotifikasiService`.
- **Rekomendasi:** Tambahkan notifikasi harian (check-in) dan pengingat craving menggunakan infrastruktur notifikasi yang sudah ada.

### Widget Layar Beranda

- **Prioritas:** Sedang
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); EasyQuit (Herzberg); Flamy (Offlinefirst)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking ; https://play.google.com/store/apps/details?id=net.offlinefirst.flamy
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Tujuan fitur:** Menampilkan penghitung smoke-free dan tabungan langsung di layar beranda tanpa membuka app.
- **Penerapan pada aplikasi referensi:** Widget Android (home screen) dengan counter hari dan uang tersimpan.
- **Relevansi terhadap proyek:** Proyek belum memiliki widget. Membutuhkan implementasi platform Android (home_widget) yang belum ada di dependensi.
- **Rekomendasi:** Pertimbangkan setelah fitur inti stabil; membutuhkan paket tambahan (`home_widget`) dan uji coba Android.

### Mode Berhenti Bertahap (Tapering)

- **Prioritas:** Sedang
- **Aplikasi referensi:** EasyQuit (Herzberg); Quit It (Antonis Evmorfopoulos); QuitSure (RapidKart)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking ; https://play.google.com/store/apps/details?id=com.quititapp ; https://play.google.com/store/apps/details?id=org.instaquit.app
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Tujuan fitur:** Membantu pengguna yang tidak dapat berhenti seketika dengan rencana penurunan jumlah rokok per hari.
- **Penerapan pada aplikasi referensi:** Rencana kustom (mis. kurangi 1 batang/minggu), pengingat, dan penyesuaian target.
- **Relevansi terhadap proyek:** Proyek menyimpan `jumlahRokokPerHari` tetapi belum ada mode tapering. Relevan untuk pengguna yang memilih berhenti bertahap.
- **Rekomendasi:** Tambahkan opsi "berhenti bertahap" dengan target penurunan harian/mingguan, disimpan pada biodata.

### AI Coach / Panduan Personal

- **Prioritas:** Rendah
- **Aplikasi referensi:** QUIT SOS (ANKO Solutions); Quit It (Antonis Evmorfopoulos)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking ; https://play.google.com/store/apps/details?id=com.quititapp
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Tujuan fitur:** Memberikan saran personal berdasarkan profil dan pola pengguna.
- **Penerapan pada aplikasi referensi:** Chatbot/AI coach yang menjawab pertanyaan dan memberi rencana harian.
- **Relevansi terhadap proyek:** Membutuhkan backend/AI yang belum tersedia; kompleksitas tinggi untuk proyek lokal.
- **Rekomendasi:** Tunda; pertimbangkan hanya jika ada sumber daya backend.

### Komunitas / Chat Ex-Smoker

- **Prioritas:** Rendah
- **Aplikasi referensi:** QuitNow (Fewlaps); Expire (FitCal); QuitSure (RapidKart)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa ; https://play.google.com/store/apps/details?id=com.virex.expire ; https://play.google.com/store/apps/details?id=org.instaquit.app
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Tujuan fitur:** Dukungan sosial dari sesama pengguna yang berhenti merokok.
- **Penerapan pada aplikasi referensi:** Chat in-app, grup, atau feed komunitas.
- **Relevansi terhadap proyek:** Membutuhkan backend dan moderasi; di luar ruang lingkup aplikasi lokal saat ini.
- **Rekomendasi:** Tidak prioritas untuk versi awal; pertimbangkan jangka panjang.

---

## 2. Referensi Peningkatan Fitur yang Sudah Ada

### Impian (Goals/Impian Tabungan)

- **Prioritas:** Tinggi
- **Fitur pada proyek:** Impian (nama, jumlah uang, target tanggal) pada tab Impian.
- **Aplikasi referensi:** Breev (Aura App Studio); Flamy (Offlinefirst); Quit It (Antonis Evmorfopoulos)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.aura.stopsmoking ; https://play.google.com/store/apps/details?id=net.offlinefirst.flamy ; https://play.google.com/store/apps/details?id=com.quititapp
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Penerapan pada aplikasi referensi:** Piggy bank visual dengan tema (Breev), savings goals dengan item keinginan (Flamy), savings goals dengan reward (Quit It).
- **Perbandingan:** Proyek menyimpan impian sebagai daftar dengan jumlah uang dan target tanggal, tetapi belum memiliki visualisasi tabungan (piggy bank) atau pencapaian reward.
- **Potensi peningkatan:** Tambahkan visualisasi progres tabungan (mis. progress bar menuju target impian) dan opsi "hadiah" (reward) saat impian tercapai.
- **Tujuan peningkatan:** Meningkatkan motivasi dan kejelasan progres menuju tujuan finansial.

### Biodata (Profil Merokok)

- **Prioritas:** Sedang
- **Fitur pada proyek:** Biodata (nama, tanggal lahir, jumlah rokok/hari, harga rokok/bungkus, tanggal mulai merokok, tanggal mulai berhenti merokok).
- **Aplikasi referensi:** Smoke Free (Portable Pixels); Quit Tracker (despDev); Kick It (UC San Diego)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.despdev.quitsmoking ; https://play.google.com/store/apps/details?id=com.kickitca
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Penerapan pada aplikasi referensi:** Profil merokok dengan input jumlah rokok, harga, dan trigger; beberapa meminta alasan berhenti dan target.
- **Perbandingan:** Proyek sudah mencakup data dasar yang cukup untuk menghitung uang tersimpan dan rokok tidak terhisap. Belum ada input alasan berhenti atau target personal.
- **Potensi peningkatan:** Tambahkan field opsional "alasan berhenti" dan "target smoke-free" (hari) pada biodata; tampilkan di dashboard sebagai motivasi.
- **Tujuan peningkatan:** Personalisasi pengalaman dan penguatan motivasi.

### Dashboard (Ringkasan Progres)

- **Prioritas:** Sedang
- **Fitur pada proyek:** Dashboard (km terbaru, saldo, jadwal service terdekat, jumlah impian, impian tercapai) — catatan: sebagian field berasal dari template kendaraan dan perlu disesuaikan dengan konteks berhenti merokok.
- **Aplikasi referensi:** QuitNow (Fewlaps); Smoke Free (Portable Pixels); Quit Tracker (despDev)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa ; https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.despdev.quitsmoking
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Penerapan pada aplikasi referensi:** Dashboard dengan counter smoke-free, uang tersimpan, rokok tidak terhisap, dan milestone tercapai.
- **Perbandingan:** Proyek dashboard masih menampilkan field kendaraan (km, jadwal service) yang tidak relevan dengan berhenti merokok; perlu diganti dengan metrik smoke-free.
- **Potensi peningkatan:** Ganti field dashboard menjadi: hari smoke-free, uang tersimpan, rokok tidak terhisap, impian tercapai, milestone kesehatan terdekat.
- **Tujuan peningkatan:** Menyelaraskan dashboard dengan tujuan aplikasi dan memberikan informasi yang bermakna.

### Kalender Smoke-Free

- **Prioritas:** Sedang
- **Fitur pada proyek:** Belum ada; daftar impian menggunakan ListView.
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); Flamy (Offlinefirst)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=net.offlinefirst.flamy
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Penerapan pada aplikasi referensi:** Tampilan kalender bulanan/tahunan yang menandai hari smoke-free dan hari relapse.
- **Perbandingan:** Proyek belum memiliki visualisasi kalender smoke-free.
- **Potensi peningkatan:** Tambahkan tampilan kalender smoke-free pada tab Dashboard atau halaman terpisah.
- **Tujuan peningkatan:** Memberikan gambaran visual progres jangka panjang.

---

## 3. Referensi UI dan UX

### Counter Besar pada Halaman Utama

- **Prioritas:** Tinggi
- **Aplikasi referensi:** QuitNow (Fewlaps); Smoke Free (Portable Pixels); Quit It (Antonis Evmorfopoulos)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa ; https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.quititapp
- **Link sumber pendukung:** Deskripsi dan tangkapan layar Google Play Store.
- **Bagian yang menjadi referensi:** Angka besar (hari smoke-free) di bagian atas halaman, diikuti metrik sekunder (uang, rokok).
- **Tujuan UI/UX:** Memberikan fokus visual pada pencapaian utama dan motivasi instan.
- **Relevansi terhadap proyek:** Dashboard proyek belum menampilkan counter smoke-free yang menonjol.
- **Rekomendasi:** Jadikan hari smoke-free sebagai elemen utama (typography besar) pada Dashboard.

### Timeline Milestone Kesehatan

- **Prioritas:** Sedang
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps); Smoke Free (Portable Pixels)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.portablepixels.smokefree
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Bagian yang menjadi referensi:** Daftar milestone dengan waktu target dan indikator tercapai.
- **Tujuan UI/UX:** Menjelaskan manfaat kesehatan secara bertahap dan terukur.
- **Relevansi terhadap proyek:** Dapat ditambahkan sebagai section di Dashboard atau halaman terpisah.
- **Rekomendasi:** Tampilkan milestone sebagai list dengan status (tercapai/belum) dan waktu target.

### Tombol SOS Satu Ketukan

- **Prioritas:** Tinggi
- **Aplikasi referensi:** QUIT SOS (ANKO Solutions); Quit Smoking : Tracker & Timer (H2M apps)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking ; https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Bagian yang menjadi referensi:** Tombol SOS yang mudah diakses (floating atau bottom bar) saat craving.
- **Tujuan UI/UX:** Memberikan akses cepat ke bantuan saat momen kritis.
- **Relevansi terhadap proyek:** Proyek belum memiliki aksi craving; tombol SOS dapat ditambahkan sebagai FAB di Dashboard.
- **Rekomendasi:** Tambahkan FAB "SOS" yang membuka latihan napas/timer craving.

### Empty State dan Onboarding yang Jelas

- **Prioritas:** Sedang
- **Aplikasi referensi:** quitSTART (Smokefree.gov); Kick It (UC San Diego)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.mmgct.quitstart ; https://play.google.com/store/apps/details?id=com.kickitca
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Bagian yang menjadi referensi:** Onboarding dengan tips persiapan berhenti dan empty state yang menjelaskan langkah berikutnya.
- **Tujuan UI/UX:** Memandu pengguna baru agar tidak bingung saat pertama membuka app.
- **Relevansi terhadap proyek:** Proyek sudah memiliki flow FormBiodata awal, tetapi onboarding bisa lebih informatif.
- **Rekomendasi:** Tambahkan tips singkat pada FormBiodata awal (mis. "Tentukan tanggal berhenti dan target").

### Feedback dan Status Operasi yang Jelas

- **Prioritas:** Sedang
- **Aplikasi referensi:** Kick It (UC San Diego); Expire (FitCal)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.kickitca ; https://play.google.com/store/apps/details?id=com.virex.expire
- **Link sumber pendukung:** Deskripsi resmi Google Play Store.
- **Bagian yang menjadi referensi:** Daily check-in dengan mood/craving dan feedback langsung.
- **Tujuan UI/UX:** Memberikan kepastian status (berhasil/gagal) dan motivasi.
- **Relevansi terhadap proyek:** Proyek sudah menggunakan AppToast dan EasyLoading; dapat ditambahkan feedback personalisasi.
- **Rekomendasi:** Tampilkan pesan motivasi personal setelah menyimpan biodata atau impian.

### Konsistensi Tema (Terang/Gelap)

- **Prioritas:** Rendah
- **Aplikasi referensi:** Quit Smoking : Tracker & Timer (H2M apps)
- **Link aplikasi:** https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke
- **Link sumber pendukung:** Deskripsi resmi Google Play Store (16 tema background).
- **Bagian yang menjadi referensi:** Pilihan tema personalisasi (warna background/aksen).
- **Tujuan UI/UX:** Personalisasi tampilan sesuai preferensi pengguna.
- **Relevansi terhadap proyek:** Proyek sudah mendukung tema terang/gelap/sistem. Personalisasi warna tambahan bersifat opsional.
- **Rekomendasi:** Pertahankan tema saat ini; personalisasi warna dapat ditambahkan nanti.

---

## 4. Rekomendasi Utama

### Fitur Baru yang Paling Layak Dipertimbangkan

1. Timer smoke-free real-time (Hari/Jam/Menit) pada Dashboard.
2. Milestone kesehatan (pemulihan tubuh) berdasarkan durasi smoke-free.
3. SOS craving (latihan napas 4-7-8 + timer 3 menit).
4. Diary pemicu/craving dengan kategori pemicu.

### Peningkatan Fitur yang Sudah Ada

1. Sesuaikan Dashboard agar menampilkan metrik smoke-free (bukan km/jadwal service).
2. Tambahkan visualisasi progres tabungan pada Impian (progress bar menuju target).
3. Tambahkan kalender smoke-free untuk gambaran progres jangka panjang.

### Peningkatan UI dan UX

1. Jadikan counter smoke-free sebagai elemen utama Dashboard (typography besar).
2. Tambahkan tombol SOS yang mudah diakses.
3. Tambahkan onboarding tips pada FormBiodata awal.

---

## 5. Sumber dan Keterbatasan Penelitian

**Sumber yang digunakan:**
- Google Play Store (deskripsi aplikasi, tangkapan layar, rating, jumlah unduhan).
- Artikel perbandingan aplikasi berhenti merokok: https://getburnout.app/articles/comparisons/best-quit-smoking-apps ; https://habitbox.app/blog/quit-smoking-tracker ; https://www.quit-it-web.com/best-quit-smoking-apps ; https://www.medicalnewstoday.com/articles/317633

**Keterbatasan penelitian:**
- Penelitian dilakukan secara daring tanpa instalasi aplikasi, sehingga detail interaksi UI/UX didasarkan pada deskripsi dan tangkapan layar yang tersedia.
- Beberapa fitur yang disebutkan (mis. AI coach, komunitas) membutuhkan backend yang belum tersedia pada proyek; ditandai sebagai prioritas rendah.
- Tidak semua aplikasi referensi memiliki dokumentasi teknis; informasi fitur didasarkan pada deskripsi resmi Google Play Store.
- Tanggal penelitian: 2026-11-07. Informasi aplikasi dapat berubah sewaktu-waktu.

---

*File ini diperbarui berdasarkan hasil penelitian referensi APK sejenis pada 2026-11-07.*
