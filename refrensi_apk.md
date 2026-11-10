# Referensi APK Sejenis

## Informasi Riset

- **Nama proyek:** Berhenti Merokok.
- **Repositori:** [mbadrudin170-jpg/berhenti_merokok](https://github.com/mbadrudin170-jpg/berhenti_merokok).
- **Branch yang diteliti:** `master` (prompt, README, AGENTS.md, daftar kompetitor, kode, dan dokumen keluaran diperiksa pada branch ini).
- **Path dokumen ini:** `refrensi_apk.md` di root proyek.
- **Tanggal penelitian:** 10 November 2026.
- **Platform sasaran:** Android (APK). Fitur yang hanya berjalan pada iOS, macOS, atau platform nonmobile tidak direkomendasikan sebagai implementasi Android. Referensi lintas platform tetap dapat digunakan untuk pola produk apabila fungsi yang dibahas memang tersedia di Android.
- **Sumber awal:** seluruh 79 entri pada `apk_serupa.md` di root proyek. Entri yang merupakan duplikasi lintas toko/distribusi tetap dihitung sebagai entri inventaris, tetapi relasi duplikasi diberi catatan dalam katalog.
- **Sumber tambahan yang ditemukan:** Flamy, SmokingYou, Smoking Tracker, SmokingWeaner, dan beberapa aplikasi lain yang mempunyai sumber Android yang lebih tepat atau lebih mutakhir.
- **Metode:** memeriksa tautan Google Play, F-Droid, Samsung Galaxy Store, App Store, Uptodown, IzzyOnDroid, situs pengembang, README/screenshot GitHub, dan kode aktual proyek pada branch `master`. Tautan mati, halaman pencarian, listing yang tidak cukup terbuka, dan fitur yang hanya berupa klaim pengembang ditandai sesuai tingkat kepastiannya.

### Batasan dan cara membaca rekomendasi

1. Ini adalah riset pembanding, bukan keputusan implementasi. Pengguna akan memilih sendiri rekomendasi yang ingin diterapkan.
2. Prioritas menunjukkan perkiraan nilai terhadap tujuan aplikasi, urgensi celah, dan ketergantungan teknis. Prioritas bukan perintah untuk mengerjakan fitur.
3. **Referensi aplikasi tidak berarti seluruh fiturnya harus ditiru.** Periksa manfaat, kesesuaian pengguna Indonesia, privasi, biaya pemeliharaan, dan kompatibilitas Android sebelum memilih.
4. Deskripsi toko adalah klaim pengembang. Angka kesehatan, perkiraan hidup yang diperoleh, dan data biologis harus diperiksa terhadap sumber kesehatan tepercaya sebelum ditampilkan sebagai fakta.
5. Penelitian ini tidak memasang seluruh aplikasi kompetitor dan tidak menguji interaksi langsung pada perangkat fisik. Pola UI/UX yang dijelaskan berdasarkan screenshot resmi/README atau deskripsi publik yang tersedia. Interaksi, animasi, dan perilaku pada semua ukuran layar belum diverifikasi.
6. Tidak tersedia emulator Android pada lingkungan proyek. Pemeriksaanan kode proyek bukan pengganti pengujian APK di perangkat Android.
7. Ketersediaan, nama, rating, jumlah unduhan, fitur, dan kebijakan aplikasi dapat berubah. Angka toko yang disebutkan hanya gambaran saat halaman diperiksa, bukan tolok ukur kualitas yang permanen.

---


## Ringkasan Temuan

Proyek sudah memiliki fondasi utama yang jauh lebih lengkap daripada aplikasi quit tracker dasar: profil dan rencana tapering, dashboard, pencatatan konsumsi harian, penanda slip, diary craving, SOS, kalender, milestone kesehatan, badge, tabungan impian, pengingat, serta backup lokal. Karena itu, menambah halaman yang mengulang kemampuan tersebut bukan prioritas.

Peluang terbesar adalah **menghubungkan data yang sudah dikumpulkan agar semua angka dan visualisasi menceritakan kondisi yang sama**. Modul konsumsi menyimpan jumlah, tanggal, catatan, dan status slip. Namun kalender smoke-free saat ini masih menghitung hari dari tanggal mulai berhenti pada biodata dan tidak membaca catatan konsumsi. Angka smoke-free, estimasi rokok yang dihindari, uang dihemat, serta progres tapering perlu mempunyai definisi yang jelas dan konsisten dengan log aktual.

Temuan utama:

1. **P1 — Integrasi konsumsi aktual dengan seluruh metrik.** Gunakan log konsumsi untuk membandingkan target tapering, konsumsi harian, rokok yang dihindari, uang yang tidak dibelanjakan, streak sejak konsumsi terakhir, dan progres kumulatif. Referensi: [SmokingYou](https://github.com/bodyaant/SmokingYou), [Smoking Tracker](https://github.com/pintargasper/SmokingTracker), [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), dan [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app).
2. **P1 — Kalender dan slip harus berbasis catatan.** Penanda slip sudah tersedia di model konsumsi, tetapi kalender hanya membaca tanggal berhenti. Bedakan hari yang terkonfirmasi bebas rokok, hari dengan konsumsi/slip, hari tanpa catatan, dan hari yang sedang mengikuti tapering. Referensi: [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking), [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree), [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), dan [ClearStack](https://clearstackapps.com/apps/smokefree).
3. **P1 — Diary craving perlu menyimpan strategi dan hasil.** Data saat ini mencatat waktu, pemicu, intensitas, dan catatan; belum ada durasi, suasana hati, tindakan koping, atau hasil. Referensi: [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [TrackLess](https://github.com/poorangryman/trackless-public), [Nonic](https://github.com/bllfoad/nonic), dan [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking).
4. **P2 — Widget Android.** Widget home screen untuk counter, ringkasan, atau pintasan SOS/log akan mengurangi langkah akses. Referensi kuat: [SmokingYou](https://github.com/bodyaant/SmokingYou), [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy), dan [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app).
5. **P2 — Simpan hasil intervensi SOS dan check-in singkat.** SOS sudah tersedia; nilai tambahnya adalah mengingat teknik yang dicoba dan apakah membantu, bukan menambah katalog aktivitas panjang. Check-in mood harian dapat bersifat opsional dan singkat. Referensi: [Quit Smoking Now – Tracker](https://play.google.com/store/apps/details?id=com.mifasuse.quitsmokingnow), [Qwit](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny), dan [Nonic](https://github.com/bllfoad/nonic).
6. **P3 — Gamifikasi lanjutan, AI coach, dan komunitas.** Referensi seperti [Quitrise](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise), [RootedLife](https://play.google.com/store/apps/details?id=com.neonbug.rootedlife), [QUIT Smoking SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking), dan [Pace Android](https://github.com/ravipurohit1991/pace) memberi inspirasi. Namun fitur tersebut menambah beban konten, privasi, moderasi, biaya, atau ketergantungan jaringan; letakkan setelah data inti akurat.

Seluruh rekomendasi merupakan bahan sortir, bukan keputusan implementasi. Prioritas mempertimbangkan celah produk, manfaat, kesesuaian Android, kebutuhan offline-first, serta biaya pemeliharaan.


## Kondisi Fitur Aktual Proyek

Bagian ini membedakan fitur yang sudah ada dari peluang optimasi. Pemeriksaan dilakukan pada kode dan dokumentasi branch `master`.

| Area | Kondisi yang ditemukan | Path sumber utama | Implikasi untuk riset |
|---|---|---|---|
| Navigasi utama | Empat destinasi: Dashboard, Biodata, Impian, dan Lainnya. Tab dibangun secara lazy dan dipertahankan dengan IndexedStack. | `lib/home.dart` | Pertahankan empat destinasi utama sampai ada bukti kebutuhan navigasi baru. |
| Dashboard | Menampilkan counter smoke-free, kartu SOS, progres/uang dihemat, target, impian, milestone, badge, dan ringkasan lain. | `lib/fitur/dashboard/screens/dashboard_screen.dart` | Jangan mengusulkan kartu SOS atau ringkasan progres sebagai fitur baru. Evaluasi ulang kepadatan dan akurasi angkanya. |
| Biodata dan tapering | Menyimpan kebiasaan awal, harga dan isi bungkus, tanggal mulai, mode seketika/bertahap, penurunan per minggu, serta target harian. | `lib/fitur/biodata/model/biodata_model.dart`; `lib/fitur/biodata/screens/form_biodata.dart` | Target tapering sudah ada; peluangnya adalah membandingkan target dengan konsumsi aktual. |
| Konsumsi rokok | Sudah ada model dengan `tanggal`, `jumlah`, `isSlip`, `catatan`, dan `dibuat`; daftar dikelompokkan per hari, ada quick log +1, tambah/ubah catatan, pemilihan tanggal, serta penanda slip. | `lib/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart`; `lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart`; `lib/fitur/konsumsi_rokok/screens/form_konsumsi_rokok.dart` | Bukan fitur baru. Optimasi utama: hubungkan catatan ke counter, tapering, kalender, tabungan, dan analitik; pertimbangkan koreksi/undo log yang mudah. |
| Perhitungan konsumsi | Helper menyediakan total, ringkasan harian, rata-rata, konsumsi hari ini, dan konsumsi tanggal tertentu. | `lib/fitur/konsumsi_rokok/helper/konsumsi_hitung_helper.dart` | Data aktual sudah dapat diringkas; pastikan rentang rata-rata benar-benar merujuk ke hari kalender terakhir, termasuk hari tanpa catatan bila diperlukan. |
| Perhitungan progres | `hariBerhenti`, `rokokTidakDiHisap`, dan `uangDihemat` berasal dari parameter biodata dan tanggal berhenti. | `lib/fitur/biodata/model/biodata_model.dart` | Bedakan baseline/estimasi dari hasil aktual. Satu rumus bersama diperlukan untuk Dashboard, Impian, Badge, dan laporan. |
| Impian/tabungan | CRUD impian, pengurutan, saldo terkumpul berbasis uang dihemat, progress, dan perayaan target sudah ada. | `lib/fitur/impian/` | Jangan menambahkan wishlist lagi; perjelas saldo estimasi vs aktual dan sumber perubahan saldo. |
| SOS Craving | Kartu akses di Dashboard; layar memiliki napas 4-7-8, timer tiga menit, distraksi, serta pengingat alasan berhenti. | `lib/fitur/sos_craving/screens/sos_craving_screen.dart`; `lib/fitur/dashboard/screens/dashboard_screen.dart` | Optimalkan kecepatan akses dan pencatatan hasil strategi. Jangan membangun ulang SOS. |
| Diary Craving | Model menyimpan tanggal/waktu, pemicu, intensitas 1–5, catatan opsional, dan waktu dibuat; tersedia tambah, ubah, hapus. Helper menentukan jam teratas setelah minimal tiga entri. | `lib/fitur/diary_craving/model/diary_craving_model.dart`; `lib/fitur/diary_craving/helper/pola_craving_helper.dart`; `lib/fitur/diary_craving/screens/form_diary_craving.dart` | Perluasan yang masuk akal: durasi, mood, strategi koping, hasil, dan ringkasan periode setelah data cukup. |
| Kalender smoke-free | Menandai rentang tanggal mulai berhenti sampai hari ini berdasarkan biodata; layar tidak membaca provider konsumsi rokok. | `lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart` | Ini celah integrasi penting: tampilan kalender belum mencerminkan log konsumsi/slip. |
| Pemulihan kesehatan | Menampilkan milestone dan waktu/progres menuju milestone berikutnya. | `lib/fitur/pemulihan_kesehatan/`; `lib/shared/konstanta/milestone_kesehatan.dart` | Sumber, tanggal pembaruan, dan sifat estimasi harus jelas; bukan diagnosis personal. |
| Badge | Badge berdasarkan hari smoke-free, rokok yang dihindari, uang dihemat, dan impian yang tercapai. | `lib/fitur/badge/` | Pastikan kondisi badge mengikuti metrik yang telah diselaraskan dengan konsumsi aktual dan slip. |
| Notifikasi | Pengingat harian, pilihan waktu, aktivasi/nonaktivasi, check-in pagi, dan pengingat pola craving telah mempunyai dasar implementasi/pengaturan sesuai platform. | `lib/fitur/pengaturan/`; `lib/shared/notifikasi/notifikasi_service.dart` | Perluasan harus kontekstual, dapat dikendalikan, dan tidak membanjiri pengguna. |
| Tema | Pilihan Sistem/Terang/Gelap tersedia. | `lib/fitur/tema/` | Fokus pada kontras, konsistensi, dan keterbacaan; variasi aksen bukan prioritas utama. |
| Cadangan/ekspor | Ekspor dan pemulihan JSON lokal tersedia; pemulihan mengganti data yang ada setelah konfirmasi. | `lib/fitur/cadangan/` | Backup JSON bukan fitur baru. Pratinjau, CSV, dan merge hanya dipertimbangkan dengan aturan konflik yang aman. |
| Alasan berhenti | CRUD alasan berhenti tersedia dan alasan terbaru bisa ditampilkan sebagai pengingat pada SOS. | `lib/fitur/alasan_berhenti/` | Motivasi personal sudah ada; optimasi berupa konteks dan waktu penyajian. |

**Batas pemeriksaan:** Kesimpulan di atas merujuk pada file yang disebutkan, README, model, helper, dan layar terkait yang diperiksa pada `master`. Rekomendasi perubahan lanjutan tetap perlu mengecek pemanggil/provider/migrasi lain sebelum implementasi. Tidak ada kode aplikasi yang diubah dalam tugas riset ini.


## A. Rekomendasi Fitur Baru untuk Android

Fitur yang tercantum di sini belum ditemukan sebagai kemampuan utuh pada kode proyek yang diperiksa. Fitur konsumsi harian, penanda slip, diary craving, SOS, impian, counter, kalender, badge, dan backup JSON **tidak** dimasukkan kembali sebagai fitur baru karena sudah tersedia.

### Prioritas Tinggi

#### 1. Widget Home Screen Android

- **Kondisi proyek:** Belum ditemukan implementasi widget Android native pada kode aplikasi.
- **Referensi:** [SmokingYou](https://github.com/bodyaant/SmokingYou), [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app), [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy), dan [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking).
- **Implementasi referensi:** Widget kecil untuk shortcut/pencatatan dan widget medium/besar untuk counter, streak, tabungan, atau ringkasan hari ini. My Tracking App menyediakan tiga ukuran widget dan tema terang/gelap; Quit Smoking Go memusatkan angka progres dan tabungan.
- **Tujuan:** Mengurangi langkah untuk melihat progres atau memulai tindakan penting.
- **Saran:** Mulai dengan widget kecil berisi satu atau dua tindakan yang paling sering digunakan, misalnya buka SOS dan buka pencatatan konsumsi. Widget statistik dapat menjadi tahap berikutnya. Jangan tampilkan data sensitif pada layar kunci.
- **Ketergantungan:** Android AppWidget/Glance atau RemoteViews, komunikasi Flutter-native, penyegaran data, dan pengujian launcher/perangkat.
- **Alasan prioritas:** Memberi manfaat langsung tanpa mengubah alur inti aplikasi.

### Prioritas Sedang

#### 2. Kartu Progres yang Dapat Dibagikan

- **Kondisi proyek:** Belum ditemukan generator kartu progres yang siap dibagikan sebagai gambar.
- **Referensi:** [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking), [Quitrise](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise), [Quit Tracker](https://play.google.com/store/apps/details?id=com.despdev.quitsmoking), dan [QuitNow!](https://www.quitnow.app/id/).
- **Implementasi referensi:** Kartu ringkas yang berisi hari smoke-free, penghematan estimatif, dan pencapaian; pengguna dapat membagikannya melalui Android Sharesheet.
- **Tujuan:** Membantu pengguna merayakan progres atau meminta dukungan tanpa harus membagikan semua data pribadi.
- **Saran:** Beri pilihan elemen yang akan terlihat, hilangkan nama/tanggal sensitif secara default, dan jelaskan apakah penghematan merupakan estimasi. Jangan menambahkan feed sosial di dalam aplikasi hanya untuk fitur ini.
- **Ketergantungan:** Template visual, rendering gambar, Android Sharesheet, dan izin yang sesuai.

#### 3. Check-in Harian Mood dan Kondisi Singkat

- **Kondisi proyek:** Pengingat harian dan catatan craving sudah tersedia, tetapi belum ditemukan alur check-in harian terpisah yang ringkas.
- **Referensi:** [Nonic](https://github.com/bllfoad/nonic), [BreatheStreak](https://play.google.com/store/apps/details?id=com.breathe.streak.app.breathqxa), [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking), dan [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy).
- **Implementasi referensi:** Check-in singkat dengan pilihan mood/kondisi, craving, atau refleksi harian; beberapa aplikasi menghubungkannya dengan catatan dan ringkasan tren.
- **Tujuan:** Membantu pengguna mengenali perubahan kondisi dan membangun kebiasaan refleksi.
- **Saran:** Jadikan opsional, dapat dilewati, dan cukup beberapa pilihan cepat. Hindari meminta pengguna mengulang data yang sudah ada pada Diary Craving atau Konsumsi Rokok.
- **Ketergantungan:** Model lokal, tampilan ringkas, dan definisi hubungan dengan entri diary/konsumsi yang sudah ada.

### Prioritas Rendah

#### 4. AI Coach Berbasis Percakapan

- **Kondisi proyek:** Belum ditemukan AI coach di dalam aplikasi. SOS, alasan berhenti, dan diary telah menjadi fondasi dukungan non-AI.
- **Referensi:** [Pace Android](https://github.com/ravipurohit1991/pace), [QuitNic AI](https://play.google.com/store/apps/details?id=store.evsi.quitsmoke), [Qwit](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny), dan [QUIT Smoking Cessation SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking).
- **Implementasi referensi:** Bantuan percakapan, saran coping, dan panduan ketika craving muncul.
- **Tujuan:** Memberi dukungan personal ketika teknik mandiri belum cukup.
- **Saran:** Jangan mulai dari chatbot bebas. Definisikan skenario terbatas, basis konten yang ditinjau, batasan medis, mekanisme fallback offline, dan cara menghapus data. Jangan kirim diary/craving sensitif ke layanan cloud tanpa persetujuan jelas.
- **Ketergantungan:** Backend/API, biaya operasional, kebijakan privasi, moderasi, pengujian keselamatan, dan kontrol pengguna.

#### 5. Mini-game Distraksi

- **Kondisi proyek:** SOS sudah mempunyai daftar aktivitas distraksi, tetapi belum ditemukan mini-game interaktif.
- **Referensi:** [QUIT Smoking Cessation SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking), [EasyQuit](https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy), dan [Quitrise](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise).
- **Implementasi referensi:** Permainan singkat untuk mengalihkan perhatian selama beberapa menit.
- **Tujuan:** Menambah variasi coping ketika craving datang.
- **Saran:** Pilih aktivitas sederhana, offline, cepat dimulai, dan tidak memakai iklan/interstitial ketika pengguna sedang membutuhkan bantuan. Jangan membuat mini-game mengalahkan akses ke teknik napas atau timer.
- **Ketergantungan:** Desain interaksi, aksesibilitas, dan pengujian performa.

#### 6. Dukungan Teman atau Komunitas

- **Kondisi proyek:** Belum ditemukan komunitas/dukungan antarpengguna; alasan berhenti saat ini mendukung motivasi personal.
- **Referensi:** [QuitNow!](https://www.quitnow.app/id/), [Kwit](https://play.google.com/store/apps/details?id=fr.kwit.android), dan [SmartQuit](https://github.com/ShreyNagda/smartquit).
- **Implementasi referensi:** Dukungan sosial, pengalaman pengguna lain, dan ruang untuk saling memberi semangat.
- **Tujuan:** Mengurangi rasa sendirian selama proses berhenti merokok.
- **Saran:** Pertimbangkan risiko moderasi, spam, penyalahgunaan, dan pembagian data. Fitur ini tidak sejalan dengan pendekatan offline-first tanpa backend kecuali dibuat sebagai integrasi opsional.
- **Ketergantungan:** Autentikasi, backend, moderasi, pelaporan penyalahgunaan, dan kebijakan privasi.


## B. Rekomendasi Optimasi Fitur yang Sudah Ada

### Prioritas Tinggi

#### 1. Satukan Perhitungan Baseline, Konsumsi Aktual, Streak, dan Tabungan

- **Kondisi proyek:** Konsumsi harian sudah tercatat dan dapat diringkas. Namun counter, jumlah rokok tidak dihisap, dan uang dihemat masih dihitung dari parameter baseline biodata serta tanggal berhenti.
- **Referensi:** [SmokingYou](https://github.com/bodyaant/SmokingYou), [Smoking Tracker](https://github.com/pintargasper/SmokingTracker), [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking), dan [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app).
- **Peluang optimasi:** Pisahkan baseline kebiasaan, target tapering, konsumsi tercatat, estimasi yang dihindari, dan uang yang secara estimatif tidak dibelanjakan. Jangan menganggap tidak adanya log sebagai bukti bahwa pengguna tidak merokok.
- **Saran:** Tentukan satu definisi untuk setiap metrik. Jika data harian belum lengkap, beri label estimasi dan jelaskan rentang/asumsinya. Gunakan satu helper/perhitungan bersama untuk Dashboard, Impian, Badge, kalender, dan ringkasan.
- **Tujuan:** Meningkatkan kepercayaan pengguna pada statistik serta menghindari angka yang bertentangan antarhalaman.

#### 2. Hubungkan Kalender Smoke-Free dengan Log Konsumsi dan Penanda Slip

- **Kondisi proyek:** Model konsumsi mendukung `isSlip`, tetapi kalender yang diperiksa hanya membaca tanggal berhenti dari biodata dan tidak membaca daftar konsumsi.
- **Referensi:** [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree), [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking), dan [ClearStack](https://clearstackapps.com/apps/smokefree).
- **Peluang optimasi:** Bedakan hari yang terkonfirmasi bebas rokok, hari dengan catatan konsumsi/slip, hari tanpa catatan, dan hari dalam rencana tapering. Pisahkan streak sejak rokok terakhir dari jumlah hari/progres kumulatif.
- **Saran:** Tetapkan aturan status kalender secara eksplisit. Jangan otomatis memberi status bebas rokok pada tanggal yang tidak memiliki log. Ketika pengguna mengetuk tanggal, tampilkan catatan yang mendasari status tersebut.
- **Tujuan:** Membuat kalender menggambarkan riwayat yang jujur dan mendorong pencatatan tanpa menghukum pengguna.

### Prioritas Sedang

#### 3. Diary Craving — Catat Strategi, Durasi, dan Hasil

- **Kondisi proyek:** Model saat ini berisi tanggal/waktu, pemicu, intensitas, dan catatan bebas. Analisis jam teratas baru tersedia setelah minimal tiga entri.
- **Referensi:** [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [TrackLess](https://github.com/poorangryman/trackless-public), [Nonic](https://github.com/bllfoad/nonic), dan [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking).
- **Peluang optimasi:** Tambahkan durasi craving, suasana hati, tindakan yang dicoba, dan hasilnya sebagai data opsional. Tampilkan pola 7/30 hari, jam rawan, pemicu berulang, serta strategi yang paling sering membantu.
- **Saran:** Pertahankan form utama singkat. Letakkan detail tambahan sebagai pilihan opsional dan izinkan pengguna menyimpan tanpa menulis catatan panjang. Tampilkan insight hanya ketika jumlah data memadai.
- **Tujuan:** Mengubah diary menjadi sumber wawasan perilaku yang dapat ditindaklanjuti.

#### 4. Konsumsi Rokok — Koreksi, Undo, dan Ringkasan yang Lebih Jelas

- **Kondisi proyek:** Sudah tersedia quick log +1, ringkasan per hari, form jumlah/tanggal, penanda slip, dan catatan.
- **Referensi:** [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app), [SmokingYou](https://github.com/bodyaant/SmokingYou), [Smoking Tracker](https://github.com/pintargasper/SmokingTracker), dan [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20).
- **Peluang optimasi:** Tambahkan undo setelah quick log, koreksi entri yang mudah ditemukan, ringkasan 7/30 hari, rata-rata, dan tren antarhari. Pertimbangkan validasi serta pesan yang jelas ketika entri bertanggal mundur atau jumlah diubah.
- **Saran:** Pertahankan satu ketukan sebagai tindakan utama. Detail pemicu atau alasan boleh menjadi pilihan lanjutan, bukan syarat setiap pencatatan. Pastikan mengubah entri tidak menggandakan hitungan harian.
- **Tujuan:** Mengurangi kesalahan input dan membuat data konsumsi cukup andal untuk perhitungan lain.

#### 5. SOS Craving — Simpan Hasil Intervensi

- **Kondisi proyek:** Napas 4-7-8, timer tiga menit, dan distraksi sudah tersedia. Riwayat permanen mengenai intervensi yang dipilih dan apakah berhasil belum tampak pada model diary saat ini.
- **Referensi:** [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [QUIT SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking), [Quit Smoking Now – Tracker](https://play.google.com/store/apps/details?id=com.mifasuse.quitsmokingnow), dan [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy).
- **Peluang optimasi:** Setelah latihan selesai, tawarkan satu pertanyaan opsional: “Apakah dorongan merokok berkurang?” Simpan jenis intervensi, waktu, dan hasil; tautkan ke pemicu diary bila pengguna setuju.
- **Saran:** Jangan meminta form panjang saat craving. Pertahankan satu tindakan mulai yang mudah terlihat dan sediakan opsi keluar/reset yang tidak membingungkan.
- **Tujuan:** Mengetahui teknik apa yang paling membantu pengguna dan menyempurnakan dukungan berdasarkan data pribadi.

### Prioritas Rendah

#### 6. Notifikasi — Kontrol Waktu dan Frekuensi

- **Kondisi proyek:** Pengingat harian, check-in pagi, dan pengingat pola craving memiliki dasar pengaturan pada platform yang mendukung.
- **Referensi:** [SmokingYou](https://github.com/bodyaant/SmokingYou), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy), [Qwit](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny), dan [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking).
- **Peluang optimasi:** Tambahkan jam tenang, batas frekuensi, pilihan kategori pesan, dan personalisasi berdasarkan pola yang cukup kuat.
- **Saran:** Minta persetujuan sebelum pengingat adaptif, sediakan nonaktif per kategori, dan jangan membuat keputusan dari jumlah data yang sangat sedikit.
- **Tujuan:** Meningkatkan relevansi tanpa menambah gangguan.

#### 7. Backup JSON — Pratinjau dan Ekspor CSV

- **Kondisi proyek:** Ekspor/pemulihan JSON sudah tersedia; pemulihan mengganti data lama setelah konfirmasi.
- **Referensi:** [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app), [SmokingYou](https://github.com/bodyaant/SmokingYou), dan [TrackLess](https://github.com/poorangryman/trackless-public).
- **Peluang optimasi:** Pratinjau isi/versi backup, ekspor CSV untuk analisis, serta pilihan gabungkan hanya jika konflik ID dan duplikasi ditangani dengan benar.
- **Saran:** Pertahankan pemulihan ganti sebagai tindakan eksplisit. Sebelum menambah merge, definisikan aturan benturan data dan tampilkan ringkasan perubahan. Jangan mengorbankan proses pemulihan atomik.
- **Tujuan:** Mengurangi risiko kehilangan data dan memudahkan pengguna memindahkan/menganalisis catatan.

#### 8. Badge dan Tabungan — Dasarkan pada Data yang Akurat

- **Kondisi proyek:** Badge, impian, dan progress tabungan sudah ada. Saldo bersumber dari angka uang dihemat yang dihitung dari biodata.
- **Referensi:** [QuitSave](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke), [Quitchi](https://play.google.com/store/apps/details?id=com.quitchi.app), [Quitrise](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise), dan [RootedLife](https://play.google.com/store/apps/details?id=com.neonbug.rootedlife).
- **Peluang optimasi:** Setelah metrik konsumsi diselaraskan, tambahkan pencapaian untuk konsistensi pencatatan, strategi craving yang dicoba, atau target tapering yang tercapai.
- **Saran:** Tunjukkan bahwa tabungan bersifat estimasi bila tidak benar-benar memindahkan uang. Jangan menghapus badge atau progres historis hanya karena slip. Hindari gamifikasi yang mempermalukan pengguna.
- **Tujuan:** Memberi reward yang sesuai dengan usaha aktual tanpa memanipulasi makna uang atau hari bebas rokok.


## C. Rekomendasi UI, UX, dan Layout

Pola di bawah merangkum tampilan yang terlihat pada screenshot, README, atau deskripsi publik. Karena aplikasi tidak seluruhnya dipasang dan diuji langsung, pola interaksi yang tidak ditunjukkan sumber tidak dinyatakan sebagai fakta.

### Prioritas Tinggi

#### 1. Hirarki Dashboard: Satu Fokus Utama dan Aksi yang Terlihat

- **Referensi:** [SmokingYou](https://github.com/bodyaant/SmokingYou), [TrackLess](https://github.com/poorangryman/trackless-public), [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking), dan [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app).
- **Pola UI:** Counter atau status hari ini menjadi fokus visual utama; penghematan, rokok dihindari, dan milestone menjadi informasi sekunder.
- **Pola UX:** Pengguna dapat memahami kondisi saat ini tanpa membaca banyak angka dengan bobot visual yang sama.
- **Pola layout:** Area ringkasan utama, dua atau tiga metrik pendukung, lalu akses ke SOS/log dan konten lanjutan. Chart ditempatkan pada layar analitik, bukan dijejalkan ke Dashboard.
- **Kondisi proyek:** Dashboard sudah memiliki banyak kartu progres, SOS, target, impian, milestone, badge, dan informasi tambahan.
- **Saran:** Audit urutan informasi pada layar ponsel kecil. Pertahankan satu metrik dominan dan satu tindakan cepat; pindahkan statistik rinci ke halaman khusus. Jangan menambah kartu tanpa mengurangi kepadatan.
- **Tujuan:** Mengurangi beban kognitif dan mempercepat akses ke tindakan utama.

#### 2. Log Konsumsi Satu Ketukan dengan Koreksi yang Mudah

- **Referensi:** [SmokingYou](https://github.com/bodyaant/SmokingYou), [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app), dan [Smoking Tracker](https://github.com/pintargasper/SmokingTracker).
- **Pola UI:** Tombol pencatatan cepat menonjol; riwayat menampilkan jumlah per hari dan detail dapat dibuka terpisah. My Tracking App menyertakan undo setelah log.
- **Pola UX:** Pencatatan harus dapat dilakukan cepat, tetapi salah tekan juga mudah dibatalkan.
- **Pola layout:** Pertahankan FAB quick log +1 yang sudah ada; tambahkan umpan balik dan opsi undo yang mudah dijangkau. Detail jumlah/tanggal/catatan tetap pada form terpisah.
- **Kondisi proyek:** Quick log +1 dan ringkasan harian sudah tersedia; fitur koreksi dilakukan lewat form.
- **Saran:** Fokus pada pembatalan log terbaru, konfirmasi perubahan yang berdampak pada metrik, dan kejelasan tanggal catatan. Hindari membuat pengguna mengisi form panjang setiap kali mencatat satu batang.
- **Tujuan:** Meningkatkan konsistensi dan kualitas data harian.

#### 3. Kalender dengan Status yang Bisa Dibedakan

- **Referensi:** [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking), [Smoking Tracker](https://github.com/pintargasper/SmokingTracker), dan [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree).
- **Pola UI:** Kalender menjadi ringkasan historis yang bisa dibuka per hari.
- **Pola UX:** Warna/status harus mempunyai arti dan tidak menyamakan hari tanpa catatan dengan hari yang terverifikasi bebas rokok.
- **Pola layout:** Kalender bulanan, legenda sederhana, ringkasan jumlah hari per status, lalu detail catatan ketika tanggal diketuk.
- **Kondisi proyek:** Kalender saat ini memakai rentang tanggal berhenti; status tidak diturunkan dari log konsumsi.
- **Saran:** Tentukan status “bebas rokok”, “ada konsumsi/slip”, “belum dicatat”, dan “tapering” serta simbol/label yang dapat dipahami tanpa hanya mengandalkan warna.
- **Tujuan:** Membuat riwayat visual akurat dan tidak menyesatkan.

### Prioritas Sedang

#### 4. Diary Craving dengan Input Bertahap

- **Referensi:** [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [ClearStack](https://clearstackapps.com/apps/smokefree), [Nonic](https://github.com/bllfoad/nonic), dan [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking).
- **Pola UI:** Pemicu, intensitas, durasi, coping, mood, dan hasil dikelompokkan; catatan bebas menjadi pilihan tambahan.
- **Pola UX:** Pengguna dapat mengisi hal penting dengan cepat dan melengkapi detail bila diperlukan.
- **Pola layout:** Field inti di bagian awal, detail opsional yang ringkas, serta tombol simpan yang konsisten.
- **Kondisi proyek:** Form sudah memiliki pemicu, intensitas, tanggal/waktu, dan catatan opsional.
- **Saran:** Tambahkan detail secara bertahap; hindari menampilkan semua pertanyaan sekaligus. Pastikan pilihan dapat dipahami dan tap target nyaman.
- **Tujuan:** Meningkatkan mutu analitik tanpa membuat proses pencatatan terasa berat.

#### 5. Penanda Slip dengan Bahasa Netral

- **Referensi:** [QuitWin](https://play.google.com/store/apps/details?id=com.elevatedev.quitwin), [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking), [No Smoke](https://play.google.com/store/apps/details?id=com.havabee.nosmoke), dan [ClearStack](https://clearstackapps.com/apps/smokefree).
- **Pola UI:** Catatan slip adalah bagian dari riwayat, dengan penjelasan singkat tentang dampaknya terhadap counter.
- **Pola UX:** Pengguna dapat melaporkan kejadian secara jujur tanpa merasa seluruh pencapaian sebelumnya dihapus.
- **Pola layout:** Toggle/opsi slip sudah ada dalam form konsumsi; penjelasan dan tampilan ringkas harus menguraikan apa yang akan berubah.
- **Kondisi proyek:** Model dan form konsumsi telah mempunyai penanda slip. Kalender dan perhitungan progres belum terhubung dengannya.
- **Saran:** Gunakan istilah yang netral, bedakan streak saat ini dengan progres kumulatif, dan jangan memakai warna merah sebagai satu-satunya penanda. Tampilkan perubahan metrik sebelum pengguna menyimpan bila dampaknya besar.
- **Tujuan:** Membangun rasa aman untuk mencatat dan mempertahankan keterlibatan.

#### 6. Widget Android yang Sederhana dan Adaptif

- **Referensi:** [SmokingYou](https://github.com/bodyaant/SmokingYou), [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app), [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), dan [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy).
- **Pola UI:** Beberapa ukuran widget menyajikan informasi dengan kepadatan berbeda; ukuran kecil fokus pada satu angka/tindakan, ukuran lebih besar menunjukkan ringkasan.
- **Pola UX:** Informasi utama tersedia dari home screen tanpa membuka aplikasi.
- **Pola layout:** Sediakan ukuran kecil/menengah, tema terang/gelap, dan area sentuh yang cukup besar.
- **Kondisi proyek:** Widget Android belum ditemukan.
- **Saran:** Mulai dari widget kecil dan pastikan data tidak kedaluwarsa saat app ditutup atau perangkat restart. Hindari menampilkan informasi privat di layar yang mudah terlihat orang lain.
- **Tujuan:** Mengurangi friction dan meningkatkan akses harian.

### Prioritas Rendah

#### 7. Statistik dan Insight dengan Filter Periode

- **Referensi:** [Smoking Tracker](https://github.com/pintargasper/SmokingTracker), [TrackLess](https://github.com/poorangryman/trackless-public), [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), dan [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app).
- **Pola UI:** Ringkasan metrik, filter 7/30 hari, grafik, lalu detail riwayat.
- **Pola UX:** Data disajikan sebagai tren yang bisa dibandingkan, bukan grafik dekoratif.
- **Pola layout:** Statistik terpisah dari Dashboard; kontrol periode sederhana; tiap grafik memiliki judul, satuan, dan rentang tanggal.
- **Kondisi proyek:** Diary sudah mempunyai ringkasan jam craving, tetapi belum ada layar analitik konsumsi dan craving yang menyatu.
- **Saran:** Bangun setelah data cukup dan definisi metrik stabil. Tampilkan empty state bila data kurang; jangan menyimpulkan pola dari beberapa catatan.
- **Tujuan:** Membantu pengguna menemukan perubahan yang dapat ditindaklanjuti.

#### 8. Impian/Tabungan dengan Visual yang Tidak Menyesatkan

- **Referensi:** [Quitchi](https://play.google.com/store/apps/details?id=com.quitchi.app), [QuitSave](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke), [RootedLife](https://play.google.com/store/apps/details?id=com.neonbug.rootedlife), dan [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking).
- **Pola UI:** Wishlist, tabungan, piggy bank, atau objek visual tumbuh mengikuti progres.
- **Pola UX:** Tujuan abstrak terasa lebih konkret ketika kemajuan terlihat.
- **Pola layout:** Target, saldo, persentase, dan estimasi sisa waktu disusun sederhana.
- **Kondisi proyek:** Impian dan progress tabungan sudah tersedia.
- **Saran:** Pertahankan pola visual yang telah ada. Prioritaskan label “estimasi uang dihemat” dan jelaskan sumber angka; jangan menyiratkan uang telah benar-benar masuk rekening/tabungan.
- **Tujuan:** Menjaga motivasi dan transparansi.

#### 9. Navigasi dan Empty State

- **Referensi:** [Quitter](https://github.com/brandonp2412/quitter), [SmokingYou](https://github.com/bodyaant/SmokingYou), dan [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke).
- **Pola UI:** Beberapa area utama di navigasi bawah; pengaturan dan alat sekunder ditempatkan di halaman terkelompok.
- **Pola UX:** Jumlah pilihan utama tetap terbatas; halaman kosong memberi tahu tindakan berikutnya.
- **Pola layout:** Pertahankan empat tab utama saat ini dan kelompokkan fitur tambahan secara konsisten.
- **Kondisi proyek:** Navigasi empat tab sudah ada dan beberapa empty state sudah disiapkan.
- **Saran:** Jangan menambah tab hanya karena ada modul baru. Setiap empty state perlu menjelaskan tujuan halaman dan menawarkan tindakan yang relevan.
- **Tujuan:** Menjaga navigasi mudah dipelajari dan mengurangi dead end.

## D. Katalog Aplikasi Kompetitor dan Referensi

**Keterangan status:**
- **Android terverifikasi:** sumber Android langsung ditemukan, seperti Google Play, F-Droid, APK Android, atau README repositori yang menyatakan Android.
- **Sumber proyek:** repositori kode publik; keberadaan repo tidak otomatis membuktikan aplikasi masih aktif dipelihara atau tersedia di Play Store.
- **iOS link:** pada daftar sumber, tautan yang diberikan adalah App Store. Aplikasi tidak dipakai sebagai bukti fitur Android kecuali tautan Android terpisah ditemukan.
- **Belum terverifikasi:** tautan tidak dapat dipastikan menunjuk ke aplikasi yang tepat atau halaman tidak dapat diakses.

### D.1 Android — Referensi Utama dan Paling Relevan

| Aplikasi | Sumber | Fitur/pola yang relevan | Link |
|---|---|---|---|
| SmokingYou | F-Droid / GitHub; Android, open-source | One-tap logging, smoke-free timer, widget 1×1 dan 3×1, tapering, breathing pause, chart, trigger analytics, milestone WHO, badge, backup JSON; Material 3 Expressive dan fokus offline. | [F-Droid](https://f-droid.org/en/packages/com.smokingtracker/) · [GitHub](https://github.com/bodyaant/SmokingYou) |
| TrackLess | GitHub; README menyatakan Android | Abstinence timer, SOS 4-7-8, chart 14 hari, pola waktu (pagi/siang/sore/malam), trigger analytics, widget, backup/import-export JSON; tampilan minimalis gelap. | [GitHub](https://github.com/poorangryman/trackless-public) |
| Quitter | F-Droid / GitHub; Android | Journey berhenti yang dapat dikustomisasi, milestone, journal, notifikasi, tema, data lokal/offline. Repo menampilkan screenshot home, journey merokok, journal, editor journey, dan pengaturan. | [F-Droid](https://f-droid.org/en/packages/com.quitter.app/) · [GitHub](https://github.com/brandonp2412/quitter) |
| Quitchi | Google Play; Android | Live counter, rokok dihindari, tabungan, wishlist, dan tanaman yang berkembang sebagai motivasi visual. | [Google Play](https://play.google.com/store/apps/details?id=com.quitchi.app) |
| EasyQuit | Google Play; Android | Mode pengurangan bertahap, statistik penghematan, trigger chart, game distraksi, badge, dan tema. | [Google Play](https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking) |
| Kwit | Google Play; Android dan iOS | CBT-oriented quit journey, progress, penghematan, jurnal, dan dukungan. Entri App Store pada `apk_serupa.md` adalah listing platform lain untuk aplikasi bernama sama. | [Google Play](https://play.google.com/store/apps/details?id=fr.kwit.android) · [App Store](https://apps.apple.com/gb/app/quit-smoking-for-good-kwit/id525441365) |
| Quit Tracker (despDev) | Google Play; Android | Counter, uang/waktu yang diperoleh, milestone kesehatan, reward, dan quit timeline. | [Google Play](https://play.google.com/store/apps/details?id=com.despdev.quitsmoking) |
| SmokeFree: Quit Smoking Slowly | Google Play; Android | Program berhenti bertahap, pengurangan jumlah rokok, jadwal dan pengingat. | [Google Play](https://play.google.com/store/apps/details?id=com.motivebite.smokefree.free) |
| QuitNow! | Google Play / situs resmi; Android | Status ex-smoker, milestone, achievement, komunitas, dan dukungan sosial. | [Google Play](https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa) · [Situs resmi](https://www.quitnow.app/id/) |
| Quit-Smoke-App | GitHub; Flutter, Android listing ditautkan README | Counter smoke-free, uang dihemat, rokok dihindari, perubahan kesehatan, dan panduan berhenti. | [GitHub](https://github.com/trizin/Quit-Smoke-App) · [Google Play yang ditautkan repo](https://play.google.com/store/apps/details?id=com.jmsc.quitsmoke) |
| QuitTrack | GitHub; React Native | Catatan konsumsi harian, target pengurangan, pemicu, kalkulator biaya, estimasi life lost, edukasi kesehatan, milestone, dan chart. Status rilis toko perlu diperiksa terpisah. | [GitHub](https://github.com/Monaim-knight/Smoking-Tracker) |
| QuitEase | GitHub; Flutter | Live timer, jumlah rokok dihindari, uang/waktu dihemat, 20 achievement badges, 10 milestone kesehatan berbasis WHO, dan notifikasi. Implementasinya menggunakan Firebase; tidak otomatis cocok untuk kebutuhan offline-first. | [GitHub](https://github.com/MUmer24/Quitease-Firebase-Application) |
| Pace | GitHub; Flutter, lintas platform | Gamifikasi balapan/kendaraan, savings goals, streak, recovery, dan analisis perilaku. Live Activities dan WidgetKit yang disebut README adalah fungsi iOS-only; jangan dijadikan rekomendasi Android. | [GitHub](https://github.com/s3gv/paceapp) |
| Nonic | GitHub; Flutter, APK Android | Check-in mood/urge, diary craving, strategi, slip log, risk score dari data pribadi 7 hari, milestone, tabungan, dan notifikasi. Risk score adalah fitur aplikasi, bukan diagnosis klinis. | [GitHub](https://github.com/bllfoad/nonic) |
| Breathe | GitHub; React Native + Expo, Android | Timer, penghematan, tombol Craving SOS, jumlah craving terlewati, dan milestone pemulihan tubuh; README menekankan tampilan gelap minimalis. | [GitHub](https://github.com/imaswath/Breathe) |
| SmartQuit / BreatheFree V2 | GitHub; Flutter | Panic button, 10 intervensi termasuk CBT/mindfulness/game, statistik craving, notifikasi personal, widget Android, dan sinkronisasi Firebase. | [GitHub](https://github.com/ShreyNagda/smartquit) |
| Quit Smoking (de.baumann) | F-Droid; Android, versi lama | Hari smoke-free, jumlah rokok/uang/waktu, health progress, dan diary. Sumber listing menunjukkan aplikasi lama; gunakan sebagai referensi historis, bukan benchmark modern. | [F-Droid](https://f-droid.org/en/packages/de.baumann.quitsmoking/) |
| Smoking Tracker (Gašper Pintar) | F-Droid / GitHub; Android, open-source | Log rokok, statistik harian/mingguan/bulanan/tahunan, consumption analytics, forecast, biaya, notes, penyimpanan lokal, dan backup Android. | [F-Droid](https://f-droid.org/en/packages/com.gasperpintar.smokingtracker/) · [GitHub](https://github.com/pintargasper/SmokingTracker) |
| Smoke Reducer | F-Droid; Android | Aplikasi pengaturan jeda antarrokok dengan alarm. Listing pada daftar awal tidak berhasil diverifikasi ulang; perlakukan sebagai referensi belum terkonfirmasi. | [F-Droid](https://f-droid.org/en/packages/com.java.SmokeReducer/) |
| No Smoke: Quit Smoking Today | Google Play; Android | Health score, penghematan, target, streak shield, bantuan craving, timer, CBT tips, trigger statistics, dan milestone. | [Google Play](https://play.google.com/store/apps/details?id=com.havabee.nosmoke) |
| QuitSave | Google Play; Android | Tabungan/reward, prediksi target, streak, timeline kesehatan, chart, reminder, milestone, dan backup lokal. | [Google Play](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke) |
| Quit Smoking: Tracker & Timer (H2M) | Google Play; Android | Live timer, 24 milestone, SOS 3 menit dan napas 4-7-8, stats/calendar, widgets, check-in, notifikasi, dan bahasa suportif saat gagal. | [Google Play](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke) |
| QUIT Smoking Cessation SOS | Google Play; Android | Tombol SOS, latihan napas, mini-games, artikel, AI coach, achievement, dan onboarding quiz. | [Google Play](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking) |
| Burnout | Google Play; Android | Pelacakan berhenti merokok/vape, progress visual berbasis tumpukan rokok, alat craving, dan total penghematan. Jumlah unduhan yang terlihat kecil; jadikan inspirasi interaksi saja. | [Google Play](https://play.google.com/store/apps/details?id=app.burnout.quit.smoking) |
| Breev | Google Play; Android | Milestone kesehatan, wishlist, piggy bank, dan target hadiah. Basis unduhan yang terlihat relatif kecil; validasi kebutuhan sebelum meniru. | [Google Play](https://play.google.com/store/apps/details?id=com.aura.stopsmoking) |
| SWay | Google Play; Android | Rencana pengurangan bertahap dengan timer/jeda antarrokok, pengurangan jumlah, dan kalkulasi progres. Periksa izin dan praktik privasi sebelum menjadikan integrasi sebagai referensi. | [Google Play](https://play.google.com/store/apps/details?id=com.stopsmoke.metodshamana) |
| Smoke Free — Portable Pixels | Google Play; Android | Teknik berhenti, pelacakan, penghematan, diary, badge, misi, dan alat bantu craving. | [Google Play](https://play.google.com/store/apps/details?id=com.portablepixels.smokefree) |
| SmokeFree: Quit Smoking Log — ClearStack | Google Play / situs pengembang; Android | Offline, slip tanpa reset otomatis, log craving dan coping, mood journal, heatmap, recap mingguan, health milestones bersumber, savings goals, dan JSON export. | [Google Play](https://play.google.com/store/apps/details?id=com.clearstackapps.smokefree) · [Situs resmi](https://clearstackapps.com/apps/smokefree) |
| ExHale | F-Droid; Android, open-source | Tracker offline, waktu sejak merokok, rokok dihindari, dan uang dihemat. Rilis yang terlihat lebih lama; referensi dasar. | [F-Droid](https://f-droid.org/en/packages/net.retiolus.exhale/) |
| Qwit (Qwit Nicotine) | Google Play; Android | SOS satu ketukan, breathing, AI coach, trigger/slip logs, milestones, missions, badges, widgets, Wear OS, dan NRT tracking. | [Google Play](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny) |
| QuitNic AI | Google Play; Android | Coach/CBT, SOS craving, milestone pemulihan, tabungan, dan pendekatan slip tanpa menghapus streak. Jumlah unduhan yang terlihat rendah; ide fitur perlu dinilai, bukan indikator kualitas pasar. | [Google Play](https://play.google.com/store/apps/details?id=store.evsi.quitsmoke) |
| Lungo | Situs pengembang; Android dan iOS | Gamifikasi katak/XP/streak, hadiah personal, daily check-in, breathing, mini-game, insight craving, journal, dan slip support. | [Situs resmi](https://trylungo.com/) |
| SmokingWeaner: Track & Reduce | Google Play; Android | Catat rokok/interval, rencana pengurangan fleksibel, craving intensity/duration/trigger/coping/outcome, ringkasan 7/30 hari, chart, weekly report, backup preview, merge/replace, dan CSV export. | [Google Play](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20) |
| QuitWin | Google Play; Android | Tracker privat dengan data lokal, tombol bantuan craving, uang dihemat, dan pendekatan non-shaming terhadap slip. Jumlah unduhan yang terlihat sangat kecil; referensi konsep sekunder. | [Google Play](https://play.google.com/store/apps/details?id=com.elevatedev.quitwin) |
| Weanie | Google Play; Android | Rencana pengurangan bertahap untuk pengguna yang tidak ingin berhenti mendadak. | [Google Play](https://play.google.com/store/apps/details?id=com.weanie.weanieapp) |
| Quit Smoking Gradually: Alive | Google Play; Android (ditambahkan saat riset) | Pengurangan bertahap dengan kecepatan fleksibel, pause/resume, serta pengingat yang lebih lembut. Listing App Store juga terdapat pada `apk_serupa.md`. | [Google Play](https://play.google.com/store/apps/details?id=com.franciscogaribay.quitsmokingalive) · [App Store](https://apps.apple.com/ca/app/quit-smoking-gradually-alive/id1539249881) |
| quitSTART | Google Play dan App Store; Android/iOS | Aplikasi Smokefree.gov dengan tips, tantangan, game, Quit Kit, dan tag pemicu. | [Google Play](https://play.google.com/store/apps/details?id=com.mmgct.quitstart) · [App Store](https://itunes.apple.com/app/apple-store/id494552000?pt=564700&ct=SmokefreeGov&mt=8) |

### D.2 Referensi Lintas Platform atau Link App Store dari Daftar Awal

Bagian ini tetap dicantumkan karena berasal dari `apk_serupa.md`, tetapi jangan menganggap setiap fitur eksklusif iOS dapat diterapkan pada Android. Untuk aplikasi yang juga mempunyai listing Android, tautan Android diletakkan pada bagian D.1.

| Aplikasi pada daftar awal | Tautan yang diberikan pada `apk_serupa.md` | Catatan penggunaan |
|---|---|---|
| Kwit (listing iOS duplikat) | [App Store](https://apps.apple.com/gb/app/quit-smoking-for-good-kwit/id525441365) | Aplikasi yang sama juga mempunyai listing Google Play pada bagian D.1. |
| Quit Smoking: Smoke-Free | [App Store](https://apps.apple.com/sa/app/quit-smoking-smoke-free/id6753927307) | Sumber awal hanya memberi link App Store; belum digunakan sebagai bukti fitur Android. |
| Quit Smoking — Smoke Free | [App Store](https://apps.apple.com/us/app/quit-smoking-smoke-free/id1185502772) | Sumber awal iOS; identitas/tautan Android yang sepadan belum dipastikan. |
| Quit Smoking Tracker: Stop it | [App Store](https://apps.apple.com/kw/app/quit-smoking-tracker-stop-it/id6444747858) | Referensi iOS; jangan mengasumsikan tampilan Android sama. |
| Quit Smoking Tracker — Quittt | [App Store](https://apps.apple.com/pl/app/quit-smoking-tracker-quittt/id6751553594) | Referensi iOS; link Android tidak tercantum pada daftar awal. |
| Quit Smoking Vaping & Nicotine | [App Store](https://apps.apple.com/us/app/quit-smoking-vaping-nicotine/id6756565950) | Referensi iOS; fungsi Android belum diverifikasi. |
| Smoke Free: Quit Tracker | [App Store](https://apps.apple.com/us/app/smoke-free-quit-tracker/id6759697339) | Referensi iOS; fungsi Android belum diverifikasi. |
| Quit It | [App Store](https://apps.apple.com/us/app/quit-it-quit-smoking-tracker/id6758652819) | Referensi iOS; aplikasi Android bernama mirip tidak otomatis sama. |
| Smoke Free — Quit Smoking Now | [App Store](https://apps.apple.com/us/app/smoke-free-quit-smoking-now/id577767592) | Nama/fitur berkaitan dengan aplikasi Portable Pixels; gunakan link Play Store D.1 untuk pembanding Android dan pastikan identitas bundle sebelum menyamakan keduanya. |
| Stop Smoking Habit Tracker | [App Store](https://apps.apple.com/ca/app/stop-smoking-habit-tracker/id1565965165) | Referensi iOS; link Android tidak disertakan pada daftar awal. |
| Quit Smoking Tracker: QuitDate | [App Store](https://apps.apple.com/us/app/quit-smoking-tracker-quitdate/id6748999711) | Referensi iOS; link Android tidak disertakan pada daftar awal. |
| ZeroSmoke | [App Store](https://apps.apple.com/us/app/stop-smoking-zerosmoke/id6748849730) | Referensi iOS; link Android tidak disertakan pada daftar awal. |
| Quit Smoking Get Healthy | [App Store](https://apps.apple.com/in/app/quit-smoking-get-healthy/id1087358475) | Referensi iOS; link Android tidak disertakan pada daftar awal. |
| Pace iOS capabilities | [GitHub Pace](https://github.com/s3gv/paceapp) | Fitur Live Activities/WidgetKit pada README adalah implementasi iOS; aplikasi inti Flutter lintas platform tetap dapat memberi ide domain/logika. |
| quitSTART iOS entry | [App Store](https://itunes.apple.com/app/apple-store/id494552000?pt=564700&ct=SmokefreeGov&mt=8) | Aplikasi juga mempunyai listing Android; lihat D.1. |

### D.3 Link yang Tidak Berhasil Dipastikan

| Nama dari `apk_serupa.md` | Link awal | Status |
|---|---|---|
| SmokeStop | [Google Play](https://play.google.com/store/apps/details?id=com.smokestop.tracker) | Tautan langsung dari daftar awal, tetapi halaman aplikasi tidak berhasil diverifikasi ulang dalam riset ini. Jangan jadikan klaim fitur savings goal sebagai bukti sampai listing aktif dipastikan. |
| SmokeFree (Polymath-Saksh) | [GitHub](https://github.com/Polymath-Saksh/SmokeFree) | Repositori/README tidak ditemukan saat pemeriksaan; jangan menggunakan ringkasan fitur awal sebagai bukti. |
| Smoke Reducer | [F-Droid](https://f-droid.org/en/packages/com.java.SmokeReducer/) | Halaman tidak berhasil diverifikasi ulang; pertahankan sebagai calon referensi, bukan bukti fitur. |
| Smoker Reducer | [Pencarian Google Play](https://play.google.com/store/search?q=Smoker%20Reducer&c=apps) | Link merupakan halaman pencarian, bukan halaman aplikasi tertentu; identitas listing belum dapat dipastikan. |
| Lungo | [Pencarian Google Play awal](https://play.google.com/store/search?q=Lungo%20quit%20smoking&c=apps) | Link pencarian awal; gunakan situs resmi pada bagian D.1. |
| Qwit | [Pencarian Google Play awal](https://play.google.com/store/search?q=Qwit%20Nicotine&c=apps) | Link pencarian awal telah diganti dengan halaman Play Store spesifik pada bagian D.1. |
| QuitNic AI | [Pencarian Google Play awal](https://play.google.com/store/search?q=QuitNic%20AI&c=apps) | Link pencarian awal telah diganti dengan halaman Play Store spesifik pada bagian D.1. |
| SmokingWeaner | [Pencarian Google Play awal](https://play.google.com/store/search?q=SmokingWeaner&c=apps) | Link pencarian awal telah diganti dengan halaman Play Store spesifik pada bagian D.1. |
| QuitWin | [Pencarian Google Play awal](https://play.google.com/store/search?q=QuitWin&c=apps) | Link pencarian awal telah diganti dengan halaman Play Store spesifik pada bagian D.1. |
| Weanie | [Pencarian Google Play awal](https://play.google.com/store/search?q=Weanie%20quit%20smoking&c=apps) | Link pencarian awal telah diganti dengan halaman Play Store spesifik pada bagian D.1. |

### D.4 Tambahan di Luar `apk_serupa.md`

| Aplikasi | Fitur relevan | Link | Alasan ditambahkan |
|---|---|---|---|
| Flamy | Quit date atau pengurangan bertahap, pengganti nikotin, counter, penghematan, health milestone, SOS, breathing/distraksi, dan Wear OS. | [Google Play](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) · [Situs resmi](https://flamy.co/) | Referensi Android dengan data unduhan dan ulasan yang besar; berguna untuk perbandingan rencana personal, intervensi, dan presentasi progres. |
| SmokingYou | Dicantumkan juga di daftar awal; link sumber F-Droid dan kode GitHub ditambahkan untuk memeriksa fitur dan screenshot secara lebih rinci. | [F-Droid](https://f-droid.org/en/packages/com.smokingtracker/) · [GitHub](https://github.com/bodyaant/SmokingYou) | Menjadi pembanding kuat untuk pencatatan aktual, widget Android, dan Material 3 Expressive. |
| Smoking Tracker (Gašper Pintar) | Log konsumsi, statistik periodik, forecast, biaya, notes, dan backup lokal. | [F-Droid](https://f-droid.org/en/packages/com.gasperpintar.smokingtracker/) · [GitHub](https://github.com/pintargasper/SmokingTracker) | README repositori menyediakan banyak screenshot halaman aplikasi yang berguna untuk riset layout. |
| Quit Smoking Gradually: Alive | Program pengurangan progresif dan pengaturan ritme. | [Google Play](https://play.google.com/store/apps/details?id=com.franciscogaribay.quitsmokingalive) | Entri awal hanya mencantumkan App Store; listing Android ditemukan saat penelitian. |

---


### D.5 Entri Tambahan dari Daftar Asli (Nomor 55–79)

Tabel berikut melengkapi entri yang sebelumnya belum tercakup secara lengkap. Jumlah unduhan hanya potret yang terlihat ketika halaman diperiksa dan bukan ukuran kualitas atau bukti efektivitas.

| No. | Aplikasi pada `apk_serupa.md` | Status/link | Fitur/pola yang dapat dipelajari dan batasan |
|---:|---|---|---|
| 55 | Quitrise | [Google Play](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise) | Counter, penghematan, kalender, 50 level, badge, daily mission, check-in, dan SOS. Listing yang diperiksa menunjukkan 1+ unduhan; ambil idenya sebagai opsi gamifikasi, bukan bukti adopsi pasar. |
| 56 | Cut Smoking: Quit Tracker | [Google Play](https://play.google.com/store/apps/details?id=com.nfm.aval024) | Aplikasi sederhana untuk menandai rokok yang berhasil dihindari, streak, dan estimasi penghematan. Listing yang diperiksa menunjukkan 10+ unduhan; referensi sekunder untuk interaksi pencatatan sederhana. |
| 57 | Quit Smoking Now – Tracker | [Google Play](https://play.google.com/store/apps/details?id=com.mifasuse.quitsmokingnow) | Counter, estimasi uang, reward, milestone, craving quick action dengan timer lima menit, dan latihan napas. Listing yang diperiksa menunjukkan 1K+ unduhan. |
| 58 | NicoQuit | [Google Play](https://play.google.com/store/apps/details?id=com.nicoquit.nico_quit) | Gamifikasi XP/level/avatar, tantangan, latihan napas, dan pencatatan craving. Listing yang diperiksa menunjukkan 10+ unduhan; gunakan sebagai inspirasi ringan, bukan benchmark utama. |
| 59 | Stop Smoking: Quit Tracker | [Google Play](https://play.google.com/store/apps/details?id=com.stopcig) | Counter, rokok yang dihindari, progres kesehatan dan penghematan; deskripsi menonjolkan penggunaan tanpa akun/data cloud. Listing yang diperiksa menunjukkan 100+ unduhan. |
| 60 | Breath: Quit Smoking & Vaping | [Google Play](https://play.google.com/store/apps/details?id=com.aydemir.breath) | Listing Android untuk Breath yang berbeda dari aplikasi bernama mirip dengan package lain. Riset awal mencatat log craving, analisis pemicu, pemulihan tubuh, tabungan, stopwatch, dan persiapan quit; verifikasi identitas package sebelum membandingkan dengan aplikasi Breath lain. |
| 61 | ZenQuit: Habit Tracker | [Google Play](https://play.google.com/store/apps/details?id=com.zenquit.habit) | Offline-first, counter, uang dihemat, craving counter, napas 4-7-8/box breathing, backup/restore, dan pengingat sesuai deskripsi listing yang diperiksa. Listing yang diperiksa menunjukkan 10+ unduhan. |
| 62 | PuffGone: Quit Smoking Tracker | [Google Play](https://play.google.com/store/apps/details?id=com.puffgone.app) | Halaman berhasil ditemukan, tetapi rincian publik yang cukup untuk memastikan seluruh fitur tidak tersedia dalam pemeriksaan. Jangan jadikan klaim fitur spesifik sebagai dasar rekomendasi tanpa pemeriksaan ulang. |
| 63 | SmokeFree: Quit Smoking | [Google Play](https://play.google.com/store/apps/details?id=com.gingstudio.smokefree) | Listing dengan fitur timer smoke-free, catatan craving, coping, dan streak menurut deskripsi yang tersedia. Identitasnya berbeda dari aplikasi SmokeFree lain pada daftar. |
| 64 | Quit Smoking Go: Stop Nicotine | [Google Play](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) | Counter real-time, widget tiga ukuran, tujuan tabungan, milestone reminder, relapse record berisi jumlah/alasan/lokasi/perasaan/rencana berikutnya, mood diary dan kalender. Listing saat diperiksa menunjukkan 10+ unduhan; fitur-fiturnya relevan untuk desain log dan widget meski basis unduhan masih kecil. |
| 65 | RootedLife: Quit Smoking | [Google Play](https://play.google.com/store/apps/details?id=com.neonbug.rootedlife) | Virtual forest tumbuh seiring hari bebas rokok, karakter pendamping memberi pesan/kiat craving, serta piggy bank dan goal. Listing yang diperiksa menunjukkan 50+ unduhan; ide visual gamifikasi sekunder. |
| 66 | Qit | [Google Play](https://play.google.com/store/apps/details?id=org.buldev.qit.androidApp) | Counter, uang/waktu, log craving dengan tempat/perasaan/intensitas, personal best, badge, dan tujuan personal. Jangan samakan dengan aplikasi lain bernama “Quit”; gunakan package ID ini. |
| 67 | NoMore | [Google Play](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) | Package ini tampil dengan nama listing “Quit Smoking & Drinking Habit”. Deskripsi menyebut check-in/slip undo, progres historis kumulatif, tabungan, pola waktu/hari, dan pengingat sebelum jendela risiko. Listing yang diperiksa menunjukkan 100+ unduhan. |
| 68 | Quit Smoking — Stop Tracker | [Google Play](https://play.google.com/store/apps/details?id=com.buggedapps.quitsmoking) | Listing ditemukan, tetapi bukti publik yang diperoleh belum cukup untuk merangkum detail fitur atau menilai UX-nya. |
| 69 | BreatheStreak | [Google Play](https://play.google.com/store/apps/details?id=com.breathe.streak.app.breathqxa) | Check-in harian, statistik progres, badge, estimasi rokok dan uang yang dihindari, serta penyimpanan lokal. Listing saat diperiksa menunjukkan 5+ unduhan. |
| 70 | QuitPath - Berhenti Merokok | [Google Play](https://play.google.com/store/apps/details?id=com.hernanmr.QuitSmoking) | Listing Android ditemukan; deskripsi/screenshot yang dapat dipastikan belum cukup untuk menyatakan pola fitur tertentu. |
| 71 | Stosmok - Stop & Quit Smoking | [Google Play](https://play.google.com/store/apps/details?id=com.anggastudio.stosmok) | Listing Android ditemukan; bukti publik yang cukup untuk analisis fitur dan alur UX belum tersedia pada pemeriksaan ini. |
| 72 | Smoke Free (AntoTech) | [Google Play](https://play.google.com/store/apps/details?id=com.antotech.smokefree) | Listing Android ditemukan dan halaman menampilkan informasi dashboard personal; rincian fitur perlu diverifikasi lagi sebelum dijadikan acuan spesifik. |
| 73 | QuitStreak - Quit Habit Coach | [Google Play](https://play.google.com/store/apps/details?id=com.mintsoft.quitstreak) | Listing Android ditemukan; deskripsi yang dapat dipastikan belum cukup untuk menyimpulkan pola interaksi atau fitur unik. |
| 74 | QuitDay: Quit Smoking & Drink | [Samsung Galaxy Store](https://galaxystore.samsung.com/detail/com.siwooeo.quitday?cntyCd=IDN) | Halaman Galaxy Store tidak menampilkan isi listing yang dapat dibaca saat diperiksa. Catat sebagai tautan katalog; fitur belum diverifikasi. |
| 75 | QuitSave: Quit Smoking Tracker | [Samsung Galaxy Store](https://galaxystore.samsung.com/detail/com.siwooeo.quitsmoke?cntyCd=IDN) | Package `com.siwooeo.quitsmoke` sama dengan QuitSave Google Play pada nomor 25; ini distribusi toko lain, bukan produk kompetitor berbeda. |
| 76 | Pace | [GitHub Releases](https://github.com/ravipurohit1991/pace/releases/latest) · [Repository](https://github.com/ravipurohit1991/pace) | Proyek Android native yang memadukan pencatatan pengurangan/berhenti dengan AI coach berbasis Ollama Cloud dan dukungan proaktif. Ini berbeda dari `s3gv/paceapp` nomor 17. Perhatikan ketergantungan cloud, privasi, dan biaya. |
| 77 | My Tracking App | [GitHub](https://github.com/lorenzocaputodev/my_tracking_app) · [Releases](https://github.com/lorenzocaputodev/my_tracking_app/releases/latest) | Aplikasi Flutter Android untuk banyak produk/kebiasaan, stok, biaya, statistik hari/minggu/bulan, undo, target, rencana pengurangan per produk, arsip, CSV backup/restore, widget tiga ukuran, pengingat, aksesibilitas, dan data lokal tanpa akun/backend. Referensi kuat untuk quick log, koreksi, widget, dan ekspor. |
| 78 | Quit Tracker (Uptodown) | [Uptodown](https://quit-tracker.en.uptodown.com/android) | Package name `com.despdev.quitsmoking`, sama dengan Quit Tracker di Google Play nomor 9. Ini sumber distribusi alternatif/versi APK, bukan aplikasi yang berbeda. Halaman menunjukkan versi 2.31 dan tanggal 3 Februari 2026; verifikasi sumber resmi sebelum instalasi APK dari luar toko. |
| 79 | Smoking Tracker (IzzyOnDroid) | [IzzyOnDroid](https://apt.izzysoft.de/fdroid/index/apk/com.gasperpintar.smokingtracker) | Package yang sama dengan Smoking Tracker F-Droid/GitHub nomor 22. Entri ini adalah mirror/distribusi lain; metadata yang ditemukan menunjukkan versi 1.9.1, pembaruan 5 Oktober 2026, dan dukungan widget. Bukan kompetitor terpisah. |

---

## E. Catatan UI/UX Visual yang Dapat Dipelajari

Berikut adalah pola dari screenshot resmi/README dan deskripsi publik. Ini bukan penilaian lengkap terhadap usability aplikasi yang diuji langsung.

| Referensi | Pola visual yang tampak/dijelaskan sumber | Pelajaran yang dapat dipertimbangkan |
|---|---|---|
| [SmokingYou](https://github.com/bodyaant/SmokingYou) | Material 3 Expressive, dashboard berorientasi data, widget, chart, dan tema; screenshot Android tersedia pada README. | Memadukan visual modern dengan tindakan pencatatan cepat dan informasi analitik tanpa memaksa login. |
| [TrackLess](https://github.com/poorangryman/trackless-public) | Tema gelap Obsidian dan beige, kartu ringkas, dashboard timer, history, 14-day analytics, dan widget. | Gunakan satu sistem kartu konsisten, ringkasan statistik jelas, serta analitik sebagai lapisan terpisah dari Dashboard. |
| [Smoking Tracker](https://github.com/pintargasper/SmokingTracker) | Screenshot menunjukkan timer besar, beberapa metrik harian, navigasi tanggal, riwayat log, serta halaman grafik/analytics terpisah. | Tempatkan timer dan metrik inti di atas, lalu riwayat dan analitik secara berurutan. |
| [Quitter](https://github.com/brandonp2412/quitter) | Antarmuka tenang dengan banyak ruang kosong, layar journey, statistik, pengaturan, dan journal. | Kurangi kepadatan Dashboard dan prioritaskan pembacaan progres. |
| [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke) | Menawarkan timer, statistik, kalender, SOS, dan pilihan tema/widget. | Akses aksi utama melalui dashboard/shortcuts dan kelompokkan statistik berdasarkan tujuan. |
| [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy) | Materi publik menampilkan indikator milestone kesehatan, timer, dan alat distraksi. | Milestone dapat menjadi visual motivasi, tetapi progres dan persentase harus mempunyai definisi yang jelas. |
| [Quitchi](https://play.google.com/store/apps/details?id=com.quitchi.app) | Metafora tanaman yang tumbuh, tabungan, dan wishlist. | Ubah tujuan uang menjadi visual yang mudah dimengerti; tetap beri pilihan tampilan yang tidak terlalu gamified. |
| [Lungo](https://trylungo.com/) | Kartu dashboard bertema maskot, streak, savings, check-in, dan beberapa destinasi navigasi. | Gamifikasi dapat membantu sebagian pengguna, tetapi jumlah kartu dan tab harus dijaga. |
| [ClearStack](https://clearstackapps.com/apps/smokefree) | Penekanan pada slip tanpa hukuman, log craving, heatmap waktu, journal, dan data lokal. | Bahasa dan feedback yang suportif merupakan bagian desain UX, bukan sekadar isi teks. |
| [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20) | Home screen diperbarui dengan progres target jeda, chart, report, dan flow backup. | Tampilkan progres tapering yang dapat ditindaklanjuti dan jelaskan konsekuensi pemulihan data. |
| [QUIT Smoking SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking) | Menggabungkan beberapa teknik breathing, mini-game, artikel, dan coach di dalam ruang SOS. | Bantuan dapat dikelompokkan per jenis intervensi; pengguna tetap perlu dapat memulai teknik tanpa membaca katalog panjang. |


| [My Tracking App](https://github.com/lorenzocaputodev/my_tracking_app) | README menyertakan screenshot Home, tujuan/badge, pengaturan, dan riwayat; terdapat widget Android tiga ukuran, pilihan tema, undo, serta aksesibilitas teks besar. | Contoh kuat untuk layout ringkas multi-metrik, riwayat yang dapat dibatalkan, widget adaptif, dan dukungan ukuran teks sistem. |
| [Quit Smoking Go](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking) | Deskripsi listing menampilkan counter real-time, widget, tabungan, diary mood, relapselog, dan kalender. | Satu perjalanan dapat ditampilkan dengan jelas tanpa menghapus histori setelah slip; gunakan bahasa netral dan pisahkan streak dari perjalanan total. |
| [NoMore](https://play.google.com/store/apps/details?id=com.appfactory.breakfree) | Listing menjelaskan check-in/slip undo, histori kumulatif, pola waktu, dan pengingat sebelum waktu risiko. | Berikan cara membatalkan input serta tampilkan pola sebagai ringkasan yang membantu, bukan peringatan yang menghakimi. |
| [QuitSave](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke) | Metafora tabungan/piggy bank dan pemisahan streak dari progres pengurangan. | Visual tabungan membantu tujuan personal, tetapi label uang harus menunjukkan angka tersebut estimasi bila tidak benar-benar ditabung. |
| [RootedLife](https://play.google.com/store/apps/details?id=com.neonbug.rootedlife) | Metafora hutan virtual yang tumbuh seiring progres dan karakter pendamping untuk craving. | Gamifikasi visual dapat dibuat opsional; jangan sampai animasi/ornamen mengurangi keterbacaan metrik inti. |
| [Quitrise](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise) | Level, badge, daily mission, dan SOS di dalam produk gamifikasi. | Misi harian sebaiknya dapat dilewati dan tidak mengurangi progres saat tidak dilakukan. |

### Saran penerapan visual untuk proyek

1. Pertahankan dasar desain yang sudah dipakai proyek dan tingkatkan urutan informasi sebelum mengganti tema.
2. Dashboard sebaiknya mempunyai satu status utama, ringkasan angka pendukung, satu tindakan cepat untuk craving, dan akses ke detail lanjutan.
3. Gunakan grafik hanya ketika data cukup dan beri rentang waktu yang mudah dipahami.
4. Form diary/konsumsi harus singkat, memiliki tap target yang cukup besar, dan menyediakan detail opsional.
5. Gunakan teks yang tidak menyalahkan pengguna pada keadaan slip, empty state, dan notifikasi.
6. Jangan menaruh semua modul pada bottom navigation. Pertahankan destinasi utama saat ini kecuali hasil pengamatan penggunaan menunjukkan alasan kuat untuk mengubahnya.
7. Hindari warna status yang hanya dibedakan melalui hue. Tambahkan label/ikon agar status tetap dapat dipahami.
8. Seluruh saran perlu diuji pada ukuran layar ponsel kecil serta tema terang/gelap.

---


## F. Prioritas Rekomendasi Gabungan

| Urutan | Rekomendasi | Jenis | Nilai utama | Ketergantungan utama |
|---:|---|---|---|---|
| 1 | Integrasikan konsumsi aktual dengan dashboard, tapering, streak, tabungan, dan badge | Optimasi | Menjadikan angka aplikasi konsisten dengan data perilaku. | Definisi metrik dan satu sumber perhitungan bersama. |
| 2 | Hubungkan kalender dengan log konsumsi dan penanda slip | Optimasi | Kalender merepresentasikan kejadian, bukan hanya tanggal mulai. | Provider konsumsi, aturan status harian, dan UI legenda. |
| 3 | Tambahkan durasi/strategi/hasil pada diary craving | Optimasi | Insight pemicu dan teknik coping menjadi lebih berguna. | Model, migrasi, form, penyimpanan, dan analitik. |
| 4 | Undo/koreksi cepat untuk konsumsi | Optimasi | Menekan kesalahan input dan memperbaiki keandalan riwayat. | Notifier, UI feedback, dan aturan perubahan metrik. |
| 5 | Widget home screen Android | Fitur baru | Akses cepat ke progres, SOS, atau log. | Native Android AppWidget/Glance, sinkronisasi, pengujian launcher. |
| 6 | Simpan hasil penggunaan SOS dan check-in singkat | Optimasi/fitur baru | Mengetahui dukungan yang benar-benar membantu. | Model lokal dan form minimal. |
| 7 | Penyempurnaan backup: preview, CSV, merge aman | Optimasi | Mengurangi risiko kehilangan dan memudahkan analisis data. | Validasi versi dan aturan konflik data. |
| 8 | Shareable progress card | Fitur baru | Memudahkan berbagi progres secara terkendali. | Rendering gambar dan Android Sharesheet. |
| 9 | Gamifikasi lanjutan/mini-game | Fitur baru | Menambah variasi motivasi dan coping. | Desain, aksesibilitas, pemeliharaan. |
| 10 | AI coach dan komunitas | Fitur baru | Dukungan personal dan sosial tambahan. | Cloud/backend, biaya, privasi, keselamatan, moderasi. |


## G. Verifikasi dan Keterbatasan

- **Cakupan daftar awal:** `apk_serupa.md` berisi 79 entri. Semuanya dicatat dalam inventaris; entri duplikat lintas toko/distribusi dipertahankan untuk jejak sumber dan diberi penjelasan, bukan dihitung sebagai produk berbeda.
- **Pemeriksaan kedalaman:** Listing, README, tautan repositori, screenshot, dan identitas package diperiksa sejauh halaman publik dapat diakses. Tidak semua 79 aplikasi berhasil dipastikan fiturnya secara menyeluruh; entri yang kurang bukti ditandai belum terverifikasi dan tidak dijadikan dasar rekomendasi fitur.
- **Tautan pencarian atau listing tidak terbaca:** Beberapa tautan awal berbentuk halaman pencarian, halaman toko yang tidak menampilkan konten, atau halaman yang gagal diakses. Link yang sudah ditemukan langsung dimasukkan pada katalog; tautan yang tidak pasti dipertahankan dengan catatan keterbatasan.
- **Duplikasi yang teridentifikasi:** Kwit App Store/Google Play; Quit Tracker Google Play/Uptodown (package `com.despdev.quitsmoking`); Smoking Tracker F-Droid/IzzyOnDroid (package `com.gasperpintar.smokingtracker`); QuitSave Google Play/Samsung Galaxy Store (package `com.siwooeo.quitsmoke`). Pace `s3gv/paceapp` dan Pace `ravipurohit1991/pace` adalah proyek yang berbeda.
- **Sumber proyek bukan bukti rilis aktif:** Keberadaan GitHub repository tidak otomatis membuktikan bahwa aplikasi masih dipelihara atau diterbitkan di Play Store. Periksa lisensi, commit, instruksi build, dan keamanan sebelum menggunakan kode.
- **Sinyal adopsi:** Banyak listing baru pada daftar nomor 55–73 menampilkan angka unduhan sangat rendah. Angka tersebut berubah seiring waktu dan tidak membuktikan kualitas, efektivitas, ataupun kecocokan produk. Gunakan hanya sebagai konteks.
- **Platform:** Rekomendasi implementasi fitur dibatasi pada Android/mobile. Live Activities dan WidgetKit dari Pace `s3gv/paceapp` adalah kemampuan iOS dan tidak disarankan sebagai fitur Android; gunakan padanan Android hanya jika memang tersedia.
- **UI/UX:** Screenshot dan deskripsi toko memberi petunjuk komposisi layar, tetapi tidak membuktikan keseluruhan flow, aksesibilitas, performa, atau usability pada semua ukuran perangkat. Tidak semua aplikasi dipasang/dicoba langsung.
- **Data kesehatan:** Klaim milestone WHO/CDC/NHS, skor paru, atau waktu hidup yang didapat kembali harus diperiksa ke sumber medis resmi sebelum digunakan. Sajikan sebagai informasi umum/estimasi, bukan diagnosis atau prediksi personal.
- **Privasi:** Aplikasi yang menggunakan AI/cloud, akun, komunitas, atau iklan tidak otomatis cocok untuk proyek offline-first. Evaluasi izin, kebijakan data, akses pihak ketiga, biaya operasional, dan kebutuhan pengguna.
- **Pemeriksaan proyek:** README dan file terkait konsumsi, diary craving, helper, serta kalender diperiksa pada branch `master`. Ditemukan bahwa konsumsi dan penanda slip sudah ada; kalender belum membaca provider konsumsi. Tidak ada kode aplikasi yang diubah, APK dibangun, emulator dijalankan, atau aplikasi kompetitor diinstal dalam tugas riset ini.

---

## H. Sumber Riset Utama

- [SmokingYou — F-Droid](https://f-droid.org/en/packages/com.smokingtracker/)
- [SmokingYou — GitHub](https://github.com/bodyaant/SmokingYou)
- [TrackLess — GitHub](https://github.com/poorangryman/trackless-public)
- [Quitter — F-Droid](https://f-droid.org/en/packages/com.quitter.app/)
- [Quitter — GitHub](https://github.com/brandonp2412/quitter)
- [Smoking Tracker — F-Droid](https://f-droid.org/en/packages/com.gasperpintar.smokingtracker/)
- [Smoking Tracker — GitHub](https://github.com/pintargasper/SmokingTracker)
- [SmokingWeaner — Google Play](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20)
- [SmokeFree Log — Google Play](https://play.google.com/store/apps/details?id=com.clearstackapps.smokefree)
- [SmokeFree Log — Situs resmi](https://clearstackapps.com/apps/smokefree)
- [H2M — Google Play](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke)
- [No Smoke — Google Play](https://play.google.com/store/apps/details?id=com.havabee.nosmoke)
- [Flamy — Google Play](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy)
- [Qwit — Google Play](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny)
- [Lungo — Situs resmi](https://trylungo.com/)
- [SWay — Google Play](https://play.google.com/store/apps/details?id=com.stopsmoke.metodshamana)
- [QuitNow! — Situs resmi](https://www.quitnow.app/id/)
- [QuitEase — GitHub](https://github.com/MUmer24/Quitease-Firebase-Application)
- [Nonic — GitHub](https://github.com/bllfoad/nonic)
- [SmartQuit — GitHub](https://github.com/ShreyNagda/smartquit)
- [Pace — GitHub](https://github.com/s3gv/paceapp)
- [quitSTART — Smokefree.gov](https://smokefree.gov/tools-tips/quitstart)

---


- [SmokingWeaner — Google Play](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20)
- [Quit Smoking Go — Google Play](https://play.google.com/store/apps/details?id=com.shosin_labs.qsmoking)
- [NoMore / Quit Smoking & Drinking Habit — Google Play](https://play.google.com/store/apps/details?id=com.appfactory.breakfree)
- [My Tracking App — GitHub](https://github.com/lorenzocaputodev/my_tracking_app)
- [Pace Android — GitHub](https://github.com/ravipurohit1991/pace)
- [QuitNic AI — Google Play](https://play.google.com/store/apps/details?id=store.evsi.quitsmoke)
- [Quit Smoking Now – Tracker — Google Play](https://play.google.com/store/apps/details?id=com.mifasuse.quitsmokingnow)
- [Quitrise — Google Play](https://play.google.com/store/apps/details?id=com.matrissoftware.Quitrise)
- [QuitWin — Google Play](https://play.google.com/store/apps/details?id=com.elevatedev.quitwin)
- [Weanie — Google Play](https://play.google.com/store/apps/details?id=com.weanie.weanieapp)
- [RootedLife — Google Play](https://play.google.com/store/apps/details?id=com.neonbug.rootedlife)
- [Uptodown — Quit Tracker package details](https://quit-tracker.en.uptodown.com/android)
- [IzzyOnDroid — Smoking Tracker](https://apt.izzysoft.de/fdroid/index/apk/com.gasperpintar.smokingtracker)

_Dokumen ini diperbarui berdasarkan riset dan pemeriksaan kode proyek pada 10 November 2026 di branch `master`. Seluruh rekomendasi masih menunggu penyortiran dan keputusan pengguna._
