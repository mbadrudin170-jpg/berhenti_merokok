# Referensi APK Sejenis

## Informasi Riset

- **Nama proyek:** Berhenti Merokok.
- **Repositori:** [mbadrudin170-jpg/berhenti_merokok](https://github.com/mbadrudin170-jpg/berhenti_merokok).
- **Branch yang diteliti:** `chatgpt` (prompt `gpt/referensi_apk_sejenis.md` dan daftar aplikasi `apk_serupa.md` ditemukan pada branch ini; file yang sama belum ditemukan pada branch default `main`).
- **Path dokumen ini:** `refrensi_apk.md` di root proyek.
- **Tanggal penelitian:** 10 November 2026.
- **Platform sasaran:** Android (APK). Fitur yang hanya berjalan pada iOS, macOS, atau platform nonmobile tidak direkomendasikan sebagai implementasi Android. Referensi lintas platform tetap dapat digunakan untuk pola produk apabila fungsi yang dibahas memang tersedia di Android.
- **Sumber awal:** seluruh 54 entri pada `apk_serupa.md` di root proyek. Entri yang merupakan duplikasi lintas toko digabung saat analisis, tetapi tautan asli tetap dicantumkan dalam katalog.
- **Sumber tambahan yang ditemukan:** Flamy, SmokingYou, Smoking Tracker, SmokingWeaner, dan beberapa aplikasi lain yang mempunyai sumber Android yang lebih tepat atau lebih mutakhir.
- **Metode:** memeriksa deskripsi Google Play/F-Droid/situs resmi, README dan screenshot repositori GitHub yang tersedia, serta kode aktual proyek pada branch `chatgpt`. Detail yang tidak dapat dibuktikan dari sumber yang tersedia diberi catatan belum terverifikasi.

### Batasan dan cara membaca rekomendasi

1. Ini adalah riset pembanding, bukan keputusan implementasi. Pengguna akan memilih sendiri rekomendasi yang ingin diterapkan.
2. Prioritas menunjukkan perkiraan nilai terhadap tujuan aplikasi, urgensi celah, dan ketergantungan teknis. Prioritas bukan perintah untuk mengerjakan fitur.
3. **Referensi aplikasi tidak berarti seluruh fiturnya harus ditiru.** Periksa manfaat, kesesuaian pengguna Indonesia, privasi, biaya pemeliharaan, dan kompatibilitas Android sebelum memilih.
4. Deskripsi toko adalah klaim pengembang. Angka kesehatan, perkiraan hidup yang diperoleh, dan data biologis harus diperiksa terhadap sumber kesehatan tepercaya sebelum ditampilkan sebagai fakta.
5. Penelitian ini tidak memasang seluruh aplikasi kompetitor dan tidak menguji interaksi langsung pada perangkat fisik. Pola UI/UX yang dijelaskan berdasarkan screenshot resmi/README atau deskripsi publik yang tersedia. Interaksi, animasi, dan perilaku pada semua ukuran layar belum diverifikasi.
6. Tidak tersedia emulator Android pada lingkungan proyek. Pemeriksaan kode proyek bukan pengganti pengujian APK di perangkat Android.
7. Ketersediaan, nama, rating, jumlah unduhan, fitur, dan kebijakan aplikasi dapat berubah. Angka toko yang disebutkan hanya gambaran saat halaman diperiksa, bukan tolok ukur kualitas yang permanen.

---

## Ringkasan Temuan

Proyek telah mempunyai fondasi yang cukup luas: dashboard, biodata, mode tapering, impian/tabungan, SOS Craving, diary craving, kalender smoke-free, pemulihan kesehatan, badge, alasan berhenti, pengingat harian, tema, serta ekspor dan pemulihan cadangan JSON.

Peluang terbesar bukan menambah halaman sebanyak mungkin, melainkan **menutup putusnya alur data perilaku**. Saat ini data dasar pengguna dan tanggal berhenti menjadi sumber utama perhitungan. Belum ditemukan modul pencatatan konsumsi rokok harian yang terstruktur maupun pencatatan slip. Akibatnya, target tapering belum dapat dibandingkan dengan konsumsi aktual, dan kalender/progres berpotensi menganggap seluruh hari sejak tanggal berhenti sebagai hari bebas rokok meskipun pengguna mengalami slip.

Temuan prioritas:

1. **P1 — Pencatatan konsumsi aktual dan evaluasi tapering.** Tambahkan catatan setiap batang/kejadian merokok atau input jumlah harian yang cepat. Gunakan data aktual untuk membandingkan target, interval antarrokok, dan perubahan konsumsi. Referensi utama: [SmokingYou](https://github.com/bodyaant/SmokingYou), [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [Smoking Tracker](https://github.com/pintargasper/SmokingTracker), dan [SWay](https://play.google.com/store/apps/details?id=com.stopsmoke.metodshamana).
2. **P1 — Pencatatan slip yang suportif.** Simpan waktu, jumlah, pemicu, dan catatan slip; jangan menghapus seluruh riwayat atau mengubahnya menjadi pesan yang menghakimi. Pisahkan streak sejak penggunaan terakhir dari progres kumulatif. Referensi utama: [SmokeFree Log (ClearStack)](https://play.google.com/store/apps/details?id=com.clearstackapps.smokefree), [No Smoke](https://play.google.com/store/apps/details?id=com.havabee.nosmoke), [Nonic](https://github.com/bllfoad/nonic), [Qwit](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny), dan [Quit Smoking Tracker & Timer (H2M)](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke).
3. **P1 — Diary craving dengan hasil strategi dan analisis pola.** Perluas data dari pemicu/intensitas/catatan menjadi durasi, suasana hati, tindakan koping, dan hasil; tampilkan pola 7/30 hari, jam rawan, serta strategi yang paling sering membantu. Referensi: [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [TrackLess](https://github.com/poorangryman/trackless-public), [SmokingYou](https://github.com/bodyaant/SmokingYou), dan [ClearStack](https://clearstackapps.com/apps/smokefree).
4. **P1 — Perbaiki konsistensi angka dashboard, kalender, dan tabungan.** Angka “rokok tidak dihisap”, “uang dihemat”, streak, dan hari smoke-free perlu menggunakan definisi yang jelas serta mempertimbangkan konsumsi dan slip aktual. Hindari menyajikan estimasi berbasis baseline sebagai hasil aktual.
5. **P2 — Pengingat adaptif dan check-in yang relevan.** Pengingat saat ini sudah tersedia pada satu waktu harian yang dipilih pengguna. Perluasan dapat berupa check-in harian singkat dan pengingat yang dipicu pola waktu craving, dengan persetujuan, jam tenang, dan kontrol frekuensi. Referensi: H2M, Flamy, SmokingYou, dan Qwit.
6. **P2 — Widget Android.** Widget 1×1 untuk membuka SOS/mencatat konsumsi dan widget lebih lebar untuk counter, uang, serta milestone dapat mengurangi langkah akses. Referensi: SmokingYou, TrackLess, H2M, Qwit, dan Flamy. Ini membutuhkan pengembangan native Android serta pengujian perangkat.
7. **P2 — Perkuat fitur SOS yang sudah ada.** Akses kartu SOS di Dashboard sudah tersedia dan layar SOS sudah memiliki napas 4-7-8, timer tiga menit, serta distraksi. Fokus optimasi: simpan hasil intervensi, tambah pilihan teknik, tautkan teknik dengan pemicu, dan tampilkan riwayat strategi yang membantu.
8. **P3 — Gamifikasi, komunitas, dan AI coach.** Tanaman/mascot, permainan, teman berhenti, atau coach dapat menjadi tambahan. Namun, fitur ini mempunyai biaya desain, moderasi, privasi, atau backend lebih besar; jangan mengorbankan stabilitas, mode offline, dan pengalaman utama.

---

## Kondisi Fitur Aktual Proyek

Bagian ini menjadi dasar agar rekomendasi tidak mengusulkan ulang fitur yang sebenarnya sudah ada. Pemeriksaan dilakukan pada kode branch `chatgpt`, bukan berdasarkan asumsi atau laporan riset lama.

| Area | Kondisi yang ditemukan | Path sumber utama | Implikasi untuk riset |
|---|---|---|---|
| Navigasi utama | Empat destinasi: Dashboard, Biodata, Impian, Lainnya. | `lib/home.dart` | Jangan menambah terlalu banyak tab utama tanpa alasan kuat. |
| Dashboard | Menampilkan counter smoke-free, kartu SOS Craving, progres/uang dihemat, target smoke-free, ringkasan impian, milestone, badge, dan informasi kerugian. | `lib/fitur/dashboard/screens/dashboard_screen.dart` | Rekomendasi “tambahkan tombol SOS pada Dashboard” sudah tidak tepat sebagai fitur baru. Kartu SOS sudah tersedia. |
| Biodata dan tapering | Menyimpan kebiasaan awal, harga rokok per bungkus, jumlah batang per bungkus, tanggal berhenti, mode seketika/bertahap, penurunan per minggu, tanggal mulai tapering, dan target hari smoke-free. | `lib/fitur/biodata/model/biodata_model.dart`; `lib/fitur/biodata/screens/form_biodata.dart` | Belum ditemukan catatan konsumsi aktual untuk memverifikasi pencapaian target tapering. |
| Perhitungan progres | `hariBerhenti`, `rokokTidakDiHisap`, dan `uangDihemat` dihitung dari biodata dan tanggal berhenti. | `lib/fitur/biodata/model/biodata_model.dart` | Estimasi berbasis baseline perlu dibedakan dari jumlah aktual, terutama ketika mode tapering atau slip digunakan. |
| Impian/tabungan | Daftar impian, pengurutan, saldo terkumpul dari uang yang dihemat, progress, dan perayaan saat target tercapai sudah tersedia. | `lib/fitur/impian/screens/impian_screen.dart`; `lib/fitur/impian/widget/visual_tabungan_impian.dart` | Wishlist/savings goal bukan fitur baru; optimasi harus menyasar akurasi saldo dan pengalaman progres. |
| SOS Craving | Kartu akses SOS sudah ada pada Dashboard. Layar SOS memiliki tiga tab: napas 4-7-8, timer tiga menit, dan daftar distraksi. Alasan berhenti terbaru juga dapat ditampilkan. | `lib/fitur/dashboard/screens/dashboard_screen.dart`; `lib/fitur/sos_craving/screens/sos_craving_screen.dart` | Yang layak dikembangkan adalah kualitas, variasi, pencatatan hasil, dan akses cepat; bukan membuat ulang fitur SOS. |
| Diary Craving | Catatan menyimpan tanggal, pemicu, intensitas (default 3), catatan opsional, dan waktu dibuat; tersedia tambah, ubah, hapus. | `lib/fitur/diary_craving/model/diary_craving_model.dart`; `lib/fitur/diary_craving/enum/pemicu_enum.dart`; `lib/fitur/diary_craving/screens/diary_craving_screen.dart` | Belum tampak field durasi, mood, strategi koping, hasil, atau dashboard analitik pemicu. |
| Kalender smoke-free | Kalender bulanan memberi tanda pada tanggal sejak tanggal berhenti sampai hari ini. | `lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart` | Kalender perlu terhubung dengan log konsumsi/slip agar status harian tidak hanya diasumsikan dari tanggal mulai. |
| Pemulihan kesehatan | Menampilkan milestone dan progress/waktu menuju milestone berikutnya. | `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`; `lib/fitur/pemulihan_kesehatan/helper/progres_milestone_helper.dart`; `lib/shared/konstanta/milestone_kesehatan.dart` | Perjelas sumber, tanggal peninjauan, dan bahwa angka merupakan estimasi populasi, bukan diagnosis personal. |
| Badge | Badge berdasarkan durasi, jumlah rokok yang tidak dihisap, uang dihemat, dan impian tercapai sudah tersedia. | `lib/fitur/badge/screens/badge_screen.dart`; `lib/fitur/badge/helper/badge_helper.dart` | Optimasi dapat menambahkan badge berbasis perilaku aktual setelah pencatatan konsumsi/slip tersedia. |
| Notifikasi | Pengingat harian dapat diaktifkan/dinonaktifkan, waktunya diatur, dan tersedia uji coba. | `lib/fitur/pengaturan/screens/pengaturan_screen.dart`; `lib/shared/notifikasi/notifikasi_service.dart` | Pengingat adaptif/check-in adalah perluasan, bukan pengingat dasar baru. |
| Tema | Pilihan tema Sistem/Terang/Gelap tersedia. | `lib/fitur/tema/enum/tema_enum.dart`; `lib/fitur/tema/notifier/tema_notifier.dart`; `lib/fitur/pengaturan/screens/pengaturan_screen.dart` | Penambahan variasi warna adalah opsional dan prioritas rendah. |
| Cadangan/ekspor | Ekspor dan pemulihan berkas JSON lokal sudah tersedia; data yang disebut pada konfirmasi meliputi biodata, impian, diary craving, dan alasan berhenti. Pemulihan mengganti data yang ada dengan isi cadangan. | `lib/fitur/cadangan/screens/cadangan_screen.dart`; `lib/fitur/cadangan/helper/cadangan_helper.dart` | Jangan usulkan ekspor/cadangan JSON sebagai fitur baru. Opsi gabungkan/ganti, pratinjau, versi, dan CSV dapat menjadi optimasi. |
| Alasan berhenti | Fitur menyimpan alasan berhenti; alasan terbaru dapat digunakan pada kartu motivasi SOS. | `lib/fitur/alasan_berhenti/` | Personalisasi dukungan motivasi sudah memiliki fondasi. |

**Catatan cakupan:** Tidak ditemukannya sebuah kemampuan pada file yang diperiksa bukan bukti absolut bahwa tidak ada implementasi tersembunyi di seluruh proyek. Sebelum implementasi, Kilo Code tetap harus memeriksa semua pemanggil, tabel database, helper, dan provider yang relevan.

---

## A. Rekomendasi Fitur Baru untuk Android

### Prioritas Tinggi

#### 1. Pencatatan Konsumsi Rokok Aktual dan Riwayat Harian

- **Kondisi proyek:** Biodata menyimpan jumlah rokok per hari sebagai baseline; belum ditemukan modul atau model khusus untuk merekam setiap kejadian merokok/jumlah aktual per tanggal.
- **Referensi:** [SmokingYou](https://github.com/bodyaant/SmokingYou), [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [Smoking Tracker](https://github.com/pintargasper/SmokingTracker), [TrackLess](https://github.com/poorangryman/trackless-public), [SWay](https://play.google.com/store/apps/details?id=com.stopsmoke.metodshamana).
- **Implementasi yang dapat dipelajari:** Pencatatan satu ketukan, cap waktu, jumlah harian, interval antarrokok, biaya aktual, dan riwayat yang dapat dikoreksi.
- **Tujuan:** Membuat data kebiasaan menjadi data aktual, bukan hanya perkiraan dari biodata.
- **Manfaat:** Menjadi fondasi yang dapat dipakai oleh tapering, laporan, analisis pemicu, kalender, dan hitungan uang.
- **Catatan desain:** Sediakan dua cara input: tombol cepat untuk satu kejadian dan koreksi jumlah harian untuk pengguna yang tidak ingin mencatat satu per satu. Hindari membuat proses pencatatan menjadi beban.
- **Ketergantungan:** Model dan tabel SQLite baru, migrasi database, repository/provider, UI input dan riwayat, serta cadangan JSON.
- **Risiko:** Catatan yang tidak lengkap dapat menghasilkan statistik menyesatkan. Tampilkan status data yang belum dicatat dan jangan menyamakan “tidak ada catatan” dengan “tidak merokok”.
- **Alasan prioritas:** Data aktual adalah prasyarat bagi beberapa optimasi besar lainnya.

#### 2. Riwayat Slip yang Tidak Menghapus Progres Kumulatif

- **Kondisi proyek:** Belum ditemukan entri slip/relapse khusus pada model biodata atau modul fitur yang diperiksa. Kalender dan counter smoke-free saat ini bergantung pada tanggal berhenti.
- **Referensi:** [SmokeFree: Quit Smoking Log — ClearStack](https://play.google.com/store/apps/details?id=com.clearstackapps.smokefree), [No Smoke](https://play.google.com/store/apps/details?id=com.havabee.nosmoke), [Nonic](https://github.com/bllfoad/nonic), [Qwit](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny), [Quit Smoking : Tracker & Timer — H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [Lungo](https://trylungo.com/).
- **Implementasi referensi:** Entri slip disimpan sebagai kejadian terpisah; penghitung waktu sejak rokok terakhir dapat berubah, tetapi riwayat, pencapaian terdahulu, dan progres kumulatif tidak dihapus.
- **Tujuan:** Mendukung proses berhenti yang realistis dan mencegah satu kejadian membuat pengguna merasa seluruh usahanya sia-sia.
- **Manfaat:** Pengguna dapat melihat perjalanan lebih jujur: berapa lama sejak penggunaan terakhir, berapa hari berhasil, jumlah rokok yang berhasil dihindari secara bersih, dan tren slip.
- **Saran data:** Waktu, jumlah, pemicu, catatan singkat, apakah kejadian tercatat sebagai slip, dan strategi yang ingin dicoba lain kali. Pisahkan metrik `streak sejak penggunaan terakhir` dari `progres kumulatif`.
- **Catatan UX:** Hindari kata-kata menghakimi. Jelaskan akibat pencatatan terhadap counter sebelum pengguna menyimpan. Jangan menghapus data atau memaksa seluruh perjalanan dimulai dari nol.
- **Ketergantungan:** Pencatatan aktual, model/tabel dan migrasi, penyesuaian perhitungan dashboard, kalender, badge, impian, dan backup.
- **Alasan prioritas:** Memperbaiki ketepatan data dan mendukung retensi pengguna setelah mengalami slip.

#### 3. Analisis Diary Craving Berbasis Perilaku

- **Kondisi proyek:** Diary saat ini mencatat tanggal, pemicu, intensitas, dan catatan bebas. Belum ditemukan pencatatan durasi craving, mood, strategi yang dicoba, serta hasil strategi.
- **Referensi:** [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [TrackLess](https://github.com/poorangryman/trackless-public), [SmokingYou](https://github.com/bodyaant/SmokingYou), [SmokeFree Log — ClearStack](https://clearstackapps.com/apps/smokefree), [Nonic](https://github.com/bllfoad/nonic).
- **Implementasi referensi:** Catatan craving dengan intensitas, durasi, konteks/pemicu, strategi koping, dan hasil; ringkasan 7 hari, 30 hari, serta pola waktu.
- **Tujuan:** Membantu pengguna mengenali kapan craving muncul dan strategi mana yang paling membantu.
- **Manfaat:** Mengubah diary dari arsip catatan menjadi alat refleksi yang dapat dipakai untuk menentukan strategi berikutnya.
- **Saran:** Pertimbangkan field opsional `mood`, `durasi`, `strategi`, dan `hasil` agar form tidak terlalu panjang. Tampilkan ringkasan pemicu teratas, jam rawan, intensitas rata-rata, serta strategi yang paling sering berhasil.
- **Ketergantungan:** Perubahan model, SQLite migration, form, repository/provider, dan visualisasi grafik yang ramah layar kecil.
- **Alasan prioritas:** Fitur diary sudah ada sehingga perluasan ini dapat langsung meningkatkan nilai data tanpa membuat modul inti baru.

### Prioritas Sedang

#### 4. Rencana Tapering Berbasis Konsumsi Aktual dan Interval

- **Kondisi proyek:** Data telah memiliki mode bertahap, penurunan mingguan, tanggal mulai tapering, dan target rokok harian yang dihitung. Belum ditemukan pencatatan konsumsi aktual yang dapat membuktikan target tercapai.
- **Referensi:** [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [SmokingYou](https://github.com/bodyaant/SmokingYou), [SWay](https://play.google.com/store/apps/details?id=com.stopsmoke.metodshamana), [Quit Smoking Gradually: Alive](https://play.google.com/store/apps/details?id=com.franciscogaribay.quitsmokingalive), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy).
- **Implementasi referensi:** Target pengurangan yang fleksibel, jadwal peningkatan interval, target harian, kemajuan aktual dibanding target, serta kemampuan mengubah atau menjeda rencana.
- **Tujuan:** Membantu pengguna mengurangi konsumsi secara bertahap dengan pengukuran yang dapat diperiksa.
- **Saran:** Setelah pencatatan konsumsi tersedia, tampilkan target hari ini, jumlah aktual, sisa batas, serta tren 7/30 hari. Izinkan jeda/perubahan rencana secara eksplisit oleh pengguna.
- **Catatan:** Jangan mengubah tanggal berhenti atau target secara otomatis tanpa memberi tahu dan meminta keputusan pengguna. Rencana tapering bukan jaminan berhenti dan tidak menggantikan nasihat tenaga kesehatan.
- **Ketergantungan:** Fitur pencatatan konsumsi aktual.

#### 5. Check-in Harian Singkat

- **Kondisi proyek:** Pengingat harian tersedia, tetapi belum ditemukan alur check-in harian yang merekam mood, tingkat craving, konsumsi aktual, dan strategi yang dilakukan.
- **Referensi:** [Nonic](https://github.com/bllfoad/nonic), [Lungo](https://trylungo.com/), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy), [QuitNow!](https://www.quitnow.app/id/).
- **Implementasi referensi:** Pertanyaan singkat satu kali per hari mengenai kondisi pengguna, craving, serta satu refleksi atau langkah berikutnya.
- **Tujuan:** Membuat pengguna melakukan refleksi rutin dan mengisi data perilaku dengan beban interaksi rendah.
- **Saran:** Maksimal beberapa input singkat, dapat dilewati, dan tidak menghalangi akses Dashboard. Jangan membuat pengguna merasa bersalah ketika melewatkan hari.
- **Ketergantungan:** Model check-in, penyimpanan lokal, dan kemungkinan integrasi dengan analitik diary.

#### 6. Widget Layar Beranda Android

- **Kondisi proyek:** Belum ditemukan implementasi widget Android pada kode proyek.
- **Referensi:** [SmokingYou](https://github.com/bodyaant/SmokingYou), [TrackLess](https://github.com/poorangryman/trackless-public), [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [Qwit](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy).
- **Implementasi referensi:** Widget kecil untuk membuka SOS atau mencatat konsumsi, serta widget ukuran sedang untuk menampilkan counter smoke-free, uang yang dihemat, atau milestone berikutnya.
- **Tujuan:** Menyediakan akses dan informasi tanpa harus membuka aplikasi.
- **Saran:** Mulai dari satu widget kecil dengan satu aksi utama; lanjutkan ke widget statistik jika kebutuhan terbukti. Semua angka widget harus bersumber dari data aplikasi yang sama.
- **Ketergantungan:** Integrasi native Android/App Widget, mekanisme update, komunikasi data Flutter-native, dan pengujian launcher/perangkat.
- **Batasan:** Jangan meniru iOS Live Activities atau WidgetKit. Fitur widget yang tersedia pada aplikasi lintas platform harus dipastikan benar-benar mendukung Android.

#### 7. Pengingat Berbasis Pola Craving

- **Kondisi proyek:** Pengingat harian dengan waktu tetap sudah tersedia.
- **Referensi:** [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [SmokingYou](https://github.com/bodyaant/SmokingYou), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy), [Qwit](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny).
- **Implementasi referensi:** Check-in pagi, pengingat milestone, dan notifikasi yang dapat disesuaikan; beberapa aplikasi mengaitkannya dengan pola craving.
- **Tujuan:** Mengirim dukungan pada waktu yang relevan, bukan sekadar menambah jumlah notifikasi.
- **Saran:** Mulai dari pilihan jam rawan berdasarkan riwayat pengguna, jam tenang, frekuensi maksimum, dan opsi nonaktif. Jangan menyimpulkan pola personal dari data yang terlalu sedikit.
- **Ketergantungan:** Data diary/konsumsi yang cukup, izin notifikasi Android, dan pengaturan preferensi.

#### 8. Notifikasi Berkelanjutan dengan Aksi Cepat

- **Kondisi proyek:** Belum ditemukan notifikasi berkelanjutan dengan tombol aksi untuk pencatatan rokok atau craving. Pengingat terjadwal sudah ada.
- **Referensi:** [SmokingYou](https://github.com/bodyaant/SmokingYou).
- **Implementasi referensi:** Notifikasi status yang menampilkan timer/kondisi hari ini dan tindakan cepat.
- **Tujuan:** Memungkinkan pencatatan tanpa membuka seluruh halaman aplikasi.
- **Saran:** Nilai kebutuhan terhadap widget terlebih dahulu. Hindari notifikasi permanen yang mengganggu, konsumsi baterai, atau menampilkan informasi sensitif di layar kunci.
- **Ketergantungan:** Integrasi Android notification actions, izin, dan pengujian perilaku sistem operasi.

### Prioritas Rendah

#### 9. Mini-games dan Intervensi Distraksi Tambahan

- **Kondisi proyek:** SOS sudah menyediakan daftar aktivitas distraksi statis dan tombol menandai berhasil. Belum ditemukan mini-game interaktif pada modul SOS.
- **Referensi:** [QUIT Smoking SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking), [SmartQuit/BreatheFree V2](https://github.com/ShreyNagda/smartquit), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy), [EasyQuit](https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking).
- **Implementasi referensi:** Memory match, permainan matematika singkat, permainan perhatian, dan latihan mindfulness.
- **Tujuan:** Memberi pilihan aktivitas terarah saat pengguna membutuhkan pengalihan perhatian.
- **Saran:** Tambahkan satu intervensi ringan terlebih dahulu dan pastikan dapat digunakan offline. Jangan membuat mini-game menjadi pusat aplikasi atau mengganggu alur bantuan utama.
- **Ketergantungan:** Desain interaksi, pengujian aksesibilitas, dan penyimpanan hasil jika ingin dianalisis.

#### 10. Teman Dukungan atau Komunitas

- **Kondisi proyek:** Belum ditemukan modul komunitas/teman dukungan daring. Fitur alasan berhenti sudah menyediakan motivasi personal.
- **Referensi:** [QuitNow!](https://www.quitnow.app/id/), [Kwit](https://play.google.com/store/apps/details?id=fr.kwit.android), [ClearStack](https://clearstackapps.com/apps/smokefree), [SmartQuit](https://github.com/ShreyNagda/smartquit).
- **Implementasi referensi:** Komunitas, cerita keberhasilan, dukungan teman, atau kontak pendamping.
- **Tujuan:** Mengurangi rasa sendirian dan menyediakan dukungan sosial.
- **Risiko:** Membutuhkan backend, moderasi konten, mekanisme pelaporan, perlindungan privasi, dan biaya operasional. Kontak pendamping pribadi dapat lebih sederhana daripada forum publik.
- **Alasan prioritas:** Bermanfaat bagi sebagian pengguna, tetapi bukan kebutuhan inti aplikasi offline-first.

#### 11. AI Coach atau Rekomendasi Personal

- **Kondisi proyek:** Belum ditemukan AI coach. Fitur SOS, pemicu, dan alasan berhenti telah menjadi fondasi untuk bantuan yang lebih personal tanpa AI.
- **Referensi:** [QUIT Smoking SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking), [Qwit](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny), [QuitNic AI](https://play.google.com/store/apps/details?id=store.evsi.quitsmoke), [SmartQuit](https://github.com/ShreyNagda/smartquit).
- **Implementasi referensi:** Chat coach, materi CBT, dan saran berdasarkan profil/pemicu.
- **Tujuan:** Memberi arahan sesuai situasi pengguna.
- **Saran:** Pertimbangkan aturan rekomendasi lokal berbasis pemicu dan strategi yang pernah berhasil sebelum menggunakan AI berbasis server. Jangan mengklaim diagnosis atau terapi klinis; sediakan batasan dan rujukan bantuan profesional.
- **Risiko:** Privasi data, biaya API, ketergantungan internet, akurasi saran, keamanan percakapan, dan kewajiban evaluasi konten.

#### 12. Gamifikasi Visual (Tanaman, Maskot, atau Koleksi)

- **Kondisi proyek:** Sistem badge dan impian sudah tersedia.
- **Referensi:** [Quitchi](https://play.google.com/store/apps/details?id=com.quitchi.app), [Lungo](https://trylungo.com/), [Pace](https://github.com/s3gv/paceapp), [Breev](https://play.google.com/store/apps/details?id=com.aura.stopsmoking).
- **Implementasi referensi:** Tanaman tumbuh, karakter/mascot, kendaraan yang terbuka, atau reward yang dikaitkan dengan progres.
- **Tujuan:** Membuat progres abstrak menjadi visual dan memberi motivasi tambahan.
- **Saran:** Pilih satu metafora visual yang konsisten. Jangan menambah banyak elemen animasi yang membuat Dashboard padat atau membebani perangkat.
- **Alasan prioritas:** Nilainya sangat bergantung pada preferensi pengguna; sistem badge/impian sudah memenuhi fungsi motivasi dasar.

---

## B. Rekomendasi Optimasi Fitur yang Sudah Ada

### Prioritas Tinggi

#### 1. Sinkronkan Counter, Uang yang Dihemat, Tapering, dan Data Aktual

- **Kondisi proyek:** `hariBerhenti`, `rokokTidakDiHisap`, dan `uangDihemat` berasal dari `BiodataModelPerhitungan`. Formula saat ini memakai jumlah rokok per hari dari biodata dikalikan hari sejak tanggal berhenti. Mode tapering sudah mempunyai target, tetapi belum tampak data konsumsi aktual yang menjadi pembanding.
- **Referensi:** [SmokeFree Log — ClearStack](https://clearstackapps.com/apps/smokefree), [SmokingYou](https://github.com/bodyaant/SmokingYou), [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [Smoking Tracker](https://github.com/pintargasper/SmokingTracker).
- **Peluang optimasi:** Pisahkan angka baseline, aktual, dan estimasi. Uang yang dihemat dihitung dari selisih konsumsi aktual dengan baseline atau target pembanding yang dijelaskan. Untuk pengguna yang belum melakukan pencatatan, tampilkan sebagai estimasi dan jelaskan asumsi.
- **Saran:** Buat satu sumber perhitungan bersama agar Dashboard, Impian, Badge, dan laporan tidak mempunyai formula yang berbeda. Pertimbangkan perubahan harga rokok dari waktu ke waktu agar perhitungan historis tidak berubah secara tidak masuk akal.
- **Tujuan:** Menjaga kepercayaan pengguna terhadap angka yang ditampilkan.

#### 2. Hubungkan Kalender dengan Catatan Konsumsi dan Slip

- **Kondisi proyek:** `KalenderSmokeFreeScreen` mewarnai rentang tanggal dari tanggal berhenti sampai hari ini. Tidak ditemukan integrasi dengan entri slip atau konsumsi harian.
- **Referensi:** [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [ClearStack](https://clearstackapps.com/apps/smokefree), [Smoking Tracker](https://github.com/pintargasper/SmokingTracker), [QuitNow!](https://www.quitnow.app/id/).
- **Peluang optimasi:** Bedakan tanggal tanpa catatan, tanggal terkonfirmasi bebas rokok, tanggal ada slip, dan tanggal masih dalam rencana tapering. Hindari memberi warna “berhasil” secara otomatis hanya karena tanggal berada setelah tanggal mulai.
- **Saran:** Gunakan legenda yang jelas dan definisikan apa arti setiap status. Berikan akses ke detail catatan ketika pengguna mengetuk tanggal.
- **Tujuan:** Kalender menjadi cerminan riwayat yang jujur, bukan visualisasi tanggal semata.

### Prioritas Sedang

#### 4. SOS Craving — Simpan Hasil dan Personalisasikan Intervensi

- **Kondisi proyek:** Dashboard sudah mempunyai kartu akses SOS. Layar SOS telah berisi tab napas 4-7-8, timer tiga menit, dan distraksi. Pada tab distraksi, daftar aktivitas berupa pilihan teks; jumlah keberhasilan disimpan pada state layar, bukan riwayat permanen.
- **Referensi:** [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [QUIT Smoking SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking), [SmartQuit](https://github.com/ShreyNagda/smartquit), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy), [ClearStack](https://clearstackapps.com/apps/smokefree).
- **Peluang optimasi:** Simpan intervensi yang dipilih dan apakah craving berhasil dilewati; tawarkan teknik alternatif; tautkan dengan pemicu dari diary; tampilkan alasan berhenti sebagai motivasi.
- **Saran:** Pertahankan bantuan inti yang cepat. Hindari form panjang ketika pengguna sedang craving. Jika ingin meminta feedback, gunakan satu pilihan sederhana setelah aktivitas selesai.
- **Tujuan:** Membuat SOS tidak hanya menyediakan aktivitas, tetapi juga belajar dari strategi yang membantu pengguna.

#### 5. Notifikasi — Kembangkan Tanpa Membanjiri Pengguna

- **Kondisi proyek:** Pengingat harian dan pemilihan waktu telah tersedia di Pengaturan.
- **Referensi:** [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy), [SmokingYou](https://github.com/bodyaant/SmokingYou), [Qwit](https://play.google.com/store/apps/details?id=stopSmokingDemo.team.geny).
- **Peluang optimasi:** Check-in pagi, pengingat milestone, jam tenang, pilihan jenis notifikasi, dan pengingat terkait pola craving jika pengguna menyetujuinya.
- **Saran:** Buat kontrol frekuensi yang mudah dipahami, tampilkan pratinjau contoh pesan, dan izinkan pengguna menonaktifkan masing-masing kategori. Jangan mengirim pengingat adaptif jika jumlah data belum cukup.
- **Tujuan:** Relevansi lebih tinggi tanpa mengurangi kendali pengguna.

#### 6. Cadangan JSON — Pratinjau dan Pilihan Pemulihan

- **Kondisi proyek:** Ekspor dan pemulihan JSON telah tersedia. UI pemulihan menyatakan data lama akan diganti dengan data dari cadangan dan mengonfirmasi tindakan destruktif.
- **Referensi:** [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [SmokingYou](https://github.com/bodyaant/SmokingYou), [TrackLess](https://github.com/poorangryman/trackless-public), [Quitter](https://github.com/brandonp2412/quitter).
- **Peluang optimasi:** Pratinjau isi backup sebelum pemulihan, pilihan `Ganti` atau `Gabungkan`, validasi versi/skema, serta ekspor riwayat ke CSV.
- **Saran:** Pertahankan `Ganti` sebagai perilaku eksplisit yang sudah ada; tambahkan `Gabungkan` hanya jika aturan konflik ID, duplikasi, dan tanggal sudah ditentukan dengan aman. Beri ringkasan data yang akan ditambahkan/diganti sebelum pengguna melanjutkan.
- **Tujuan:** Mengurangi risiko kehilangan data ketika pindah perangkat atau memulihkan cadangan lama.

### Prioritas Rendah

#### 7. Badge dan Pencapaian — Tambahkan Syarat Berbasis Perilaku Aktual

- **Kondisi proyek:** Badge berdasarkan hari smoke-free, rokok tidak dihisap, uang dihemat, dan impian tercapai sudah tersedia.
- **Referensi:** [QuitEase](https://github.com/MUmer24/Quitease-Firebase-Application), [QuitNow!](https://www.quitnow.app/id/), [EasyQuit](https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking), [SmokingYou](https://github.com/bodyaant/SmokingYou).
- **Peluang optimasi:** Setelah pencatatan aktual tersedia, pertimbangkan pencapaian seperti konsistensi check-in, strategi craving yang dicoba, interval konsumsi yang meningkat, atau target tapering tercapai.
- **Saran:** Hindari memberi badge yang mendorong perilaku tidak sehat atau membuat pengguna malu saat gagal. Pertahankan badge lama dan pastikan perubahan perhitungan tidak membuat badge tercapai/hilang secara tidak terduga.
- **Tujuan:** Menambah variasi penghargaan yang menggambarkan tindakan, bukan hanya durasi.

#### 8. Tema dan Personalisasi Visual

- **Kondisi proyek:** Tema Sistem/Terang/Gelap sudah tersedia.
- **Referensi:** [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [SmokingYou](https://github.com/bodyaant/SmokingYou), [Quitter](https://github.com/brandonp2412/quitter).
- **Peluang optimasi:** Pilihan aksen atau palet tambahan, selama kontras, keterbacaan, dan konsistensi komponen tidak menurun.
- **Saran:** Prioritaskan aksesibilitas kontras dan tema gelap yang benar sebelum menambah banyak warna.
- **Tujuan:** Personalisasi tanpa membuat desain sulit dipelihara.

#### 9. Impian dan Tabungan — Perjelas Angka dan Sumber Saldo

- **Kondisi proyek:** Impian dan progress bar sudah ada, dengan saldo bersumber dari `biodata.uangDihemat`.
- **Referensi:** [Quitchi](https://play.google.com/store/apps/details?id=com.quitchi.app), [SmokeStop](https://play.google.com/store/apps/details?id=com.smokestop.tracker), [QuitSave](https://play.google.com/store/apps/details?id=com.siwooeo.quitsmoke), [Breev](https://play.google.com/store/apps/details?id=com.aura.stopsmoking), [Pace](https://github.com/s3gv/paceapp).
- **Peluang optimasi:** Menjelaskan apakah saldo aktual atau estimasi, menampilkan rincian asumsi perhitungan, dan memperlihatkan perubahan saldo setelah log konsumsi/slip.
- **Saran:** Jangan menambah fitur wishlist baru. Fokus pada kejelasan sumber angka dan riwayat perubahan saldo.
- **Tujuan:** Menghindari pengguna menyangka uang estimasi sebagai uang yang benar-benar tersimpan.

---

## C. Rekomendasi UI, UX, dan Layout

Bagian ini membahas pola yang terlihat pada screenshot, README, atau deskripsi publik aplikasi. Karena tidak semua aplikasi dipasang dan diuji langsung, pola interaksi yang tidak tampak secara eksplisit tidak dianggap fakta.

### Prioritas Tinggi

#### 1. Hirarki Dashboard: Satu Metrik Utama, Ringkasan Sekunder, dan Aksi Jelas

- **Aplikasi referensi:** [SmokingYou](https://github.com/bodyaant/SmokingYou), [TrackLess](https://github.com/poorangryman/trackless-public), [Quit Smoking Tracker & Timer (H2M)](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [Smoking Tracker](https://github.com/pintargasper/SmokingTracker), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy).
- **Pola UI:** Angka utama seperti waktu sejak rokok terakhir atau waktu bebas rokok dibuat dominan. Angka pendukung seperti rokok yang dihindari dan uang dihemat ditampilkan sebagai ringkasan sekunder.
- **Pola UX:** Pengguna dapat memahami kondisi utama tanpa membaca banyak teks dan menemukan tindakan penting dengan cepat.
- **Pola layout:** Satu kartu/area hero, beberapa kartu metrik ringkas, lalu ringkasan milestone atau tren. Hindari semua metrik memakai ukuran dan penekanan visual yang sama.
- **Kondisi proyek:** Dashboard sudah menampilkan counter, progres, SOS, target, impian, milestone, badge, dan informasi tambahan.
- **Saran:** Evaluasi urutan dan kepadatan konten pada layar ponsel kecil. Pastikan kartu SOS dan status utama mudah ditemukan, sedangkan informasi sekunder dapat ditempatkan lebih bawah. Jangan menambah kartu baru tanpa mengurangi kepadatan bagian lain.
- **Tujuan:** Mempercepat pemahaman dan mengurangi beban kognitif.

#### 2. Aksi Pencatatan Satu Ketukan dengan Pemilihan Detail Setelahnya

- **Aplikasi referensi:** [SmokingYou](https://github.com/bodyaant/SmokingYou), [TrackLess](https://github.com/poorangryman/trackless-public), [Smoking Tracker](https://github.com/pintargasper/SmokingTracker).
- **Pola UI:** Tombol aksi cepat atau Speed Dial untuk pencatatan, kemudian detail opsional seperti pemicu dapat dipilih setelah aksi utama.
- **Pola UX:** Mengurangi hambatan pencatatan pada situasi sehari-hari.
- **Pola layout:** Tombol aksi yang menonjol tetapi tidak menutupi konten; form detail singkat dapat dibuka sebagai lembar bawah atau layar khusus.
- **Kondisi proyek:** Belum ditemukan alur pencatatan rokok aktual.
- **Saran:** Jika pencatatan konsumsi dibangun, sediakan aksi primer satu ketukan dan jangan mewajibkan form panjang untuk setiap kejadian. Pastikan tersedia cara mengoreksi salah tekan.
- **Tujuan:** Meningkatkan kelengkapan data tanpa membuat pencatatan merepotkan.

#### 3. SOS Craving: Jalur Bantuan Singkat dan Fokus

- **Aplikasi referensi:** [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [QUIT Smoking SOS](https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking), [Flamy](https://play.google.com/store/apps/details?id=net.offlinefirst.flamy), [SmartQuit](https://github.com/ShreyNagda/smartquit).
- **Pola UI:** Tombol SOS mudah dikenali, pilihan bantuan ditampilkan sebagai tindakan langsung, dan latihan napas memakai animasi/indikator progres.
- **Pola UX:** Saat craving, pengguna perlu bantuan tanpa membaca banyak instruksi atau menelusuri menu.
- **Pola layout:** Akses dari Dashboard ke layar SOS; di dalam SOS, kelompokkan teknik ke dalam tab/kartu yang jelas dan tampilkan satu instruksi utama pada satu waktu.
- **Kondisi proyek:** Kartu SOS di Dashboard dan tiga tab SOS telah ada.
- **Saran:** Pertahankan pintasan Dashboard. Evaluasi ukuran tombol, urutan tab, teks ringkas, dan visibilitas tombol mulai/jeda/reset. Jangan menambahkan shortcut duplikat yang membingungkan.
- **Tujuan:** Meminimalkan waktu dari munculnya craving ke dimulainya intervensi.

### Prioritas Sedang

#### 4. Statistik: Filter Periode dan Tren yang Dapat Dibandingkan

- **Aplikasi referensi:** [Smoking Tracker](https://github.com/pintargasper/SmokingTracker), [TrackLess](https://github.com/poorangryman/trackless-public), [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [SmokingYou](https://github.com/bodyaant/SmokingYou).
- **Pola UI:** Grafik harian/mingguan/bulanan, tren interval, dan distribusi pemicu disusun sebagai bagian analitik terpisah.
- **Pola UX:** Pengguna dapat membandingkan perubahan tanpa harus menghitung sendiri dari daftar catatan.
- **Pola layout:** Ringkasan angka di bagian atas, filter periode sederhana, grafik, kemudian daftar rincian atau insight.
- **Kondisi proyek:** Diary dan kalender sudah ada, tetapi belum ditemukan layar analitik perilaku yang menggabungkan konsumsi dan craving.
- **Saran:** Bangun analitik setelah tersedia data aktual yang cukup. Gunakan label, satuan, dan rentang tanggal yang jelas; jangan menampilkan grafik kosong atau menyimpulkan tren dari sedikit catatan.
- **Tujuan:** Membuat data menjadi wawasan yang bisa ditindaklanjuti.

#### 5. Slip: Bahasa Suportif dan Konsekuensi yang Transparan

- **Aplikasi referensi:** [ClearStack](https://clearstackapps.com/apps/smokefree), [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [No Smoke](https://play.google.com/store/apps/details?id=com.havabee.nosmoke), [Lungo](https://trylungo.com/).
- **Pola UI:** Form atau dialog pencatatan slip sederhana dengan bahasa yang tidak menghakimi dan penjelasan dampak pada metrik.
- **Pola UX:** Pengguna dapat mencatat kejadian tanpa takut kehilangan seluruh riwayat atau pencapaiannya.
- **Pola layout:** Tindakan `Catat slip` di area progres/riwayat, form ringkas, lalu ringkasan konsekuensi sebelum disimpan.
- **Kondisi proyek:** Belum ditemukan alur slip khusus.
- **Saran:** Setelah fitur tersedia, jelaskan metrik apa yang berubah dan apa yang tetap dipertahankan. Hindari warna/pesan kegagalan yang membuat pengguna merasa dihukum.
- **Tujuan:** Mendorong pencatatan jujur dan keberlanjutan usaha.

#### 6. Form Diary: Input Bertahap dan Pemilihan yang Mudah

- **Aplikasi referensi:** [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [ClearStack](https://clearstackapps.com/apps/smokefree), [Nonic](https://github.com/bllfoad/nonic).
- **Pola UI:** Pemicu, intensitas, durasi, strategi, dan hasil dikelompokkan. Input utama mudah dipilih; catatan bebas bersifat opsional.
- **Pola UX:** Mengurangi panjang form dan menjaga konsistensi data analitik.
- **Pola layout:** Bagian inti terlebih dahulu, detail tambahan sebagai bagian opsional; tombol simpan tetap mudah ditemukan.
- **Kondisi proyek:** Form sudah mendukung pemicu, intensitas, tanggal, dan catatan.
- **Saran:** Jangan menambah semua field sekaligus. Gunakan pilihan ringkas, default yang masuk akal, dan opsi melewati detail. Jaga agar ukuran tap target dan jarak antarkomponen nyaman.
- **Tujuan:** Menambah kualitas data tanpa mengorbankan kemudahan input.

#### 7. Navigasi: Pertahankan Destinasi Utama yang Terbatas

- **Aplikasi referensi:** [Quitter](https://github.com/brandonp2412/quitter), [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [SmokingYou](https://github.com/bodyaant/SmokingYou), [Lungo](https://trylungo.com/).
- **Pola UI:** Navigasi bawah atau tab digunakan untuk beberapa area inti; pengaturan dan fitur sekunder dapat ditempatkan di area lain.
- **Pola UX:** Mengurangi keputusan navigasi dan menjaga halaman utama tidak penuh.
- **Pola layout:** Sekitar 3–5 destinasi utama, dengan halaman sekunder yang dikelompokkan secara konsisten.
- **Kondisi proyek:** Navigasi bawah sudah mempunyai Dashboard, Biodata, Impian, dan Lainnya. SOS, Diary, Kalender, serta Pemulihan berada di Lainnya, kecuali pintasan SOS di Dashboard.
- **Saran:** Pertahankan empat destinasi selama data penggunaan belum menunjukkan kebutuhan baru. Gunakan shortcut Dashboard untuk tindakan berfrekuensi tinggi, bukan menambah semua fitur ke navigasi bawah.
- **Tujuan:** Menjaga navigasi sederhana dan dapat dipelajari.

#### 8. Cadangan: Pratinjau Sebelum Tindakan yang Mengganti Data

- **Aplikasi referensi:** [SmokingWeaner](https://play.google.com/store/apps/details?id=smoking.android.smokingweaner20), [TrackLess](https://github.com/poorangryman/trackless-public), [SmokingYou](https://github.com/bodyaant/SmokingYou).
- **Pola UI:** Pemilihan berkas, ringkasan isi cadangan, pilihan merge/replace, dan konfirmasi tindakan destruktif.
- **Pola UX:** Pengguna memahami konsekuensi dan dapat memilih metode pemulihan yang sesuai.
- **Pola layout:** Ringkasan jumlah/jenis data pada satu halaman sebelum konfirmasi terakhir.
- **Kondisi proyek:** Ekspor/pemulihan JSON tersedia dan pemulihan saat ini mengganti data.
- **Saran:** Tambahkan pratinjau dan opsi gabungkan hanya setelah kebijakan konflik data ditentukan. Pertahankan konfirmasi destruktif yang sudah ada.
- **Tujuan:** Mengurangi kehilangan data dan memperjelas proses pemulihan.

### Prioritas Rendah

#### 9. Gamifikasi yang Terkendali dan Konsisten

- **Aplikasi referensi:** [Quitchi](https://play.google.com/store/apps/details?id=com.quitchi.app), [Lungo](https://trylungo.com/), [Pace](https://github.com/s3gv/paceapp), [QuitEase](https://github.com/MUmer24/Quitease-Firebase-Application).
- **Pola UI:** Tanaman/karakter/objek berkembang mengikuti progres, reward ditampilkan dalam bentuk koleksi, dan pencapaian memiliki indikator kemajuan.
- **Pola UX:** Progres abstrak menjadi sesuatu yang mudah dipahami dan memberi penguatan positif.
- **Pola layout:** Satu elemen hero visual dan beberapa ringkasan; jangan membuat setiap kartu mempunyai maskot/animasi sendiri.
- **Kondisi proyek:** Impian dan badge telah menjadi mekanisme motivasi.
- **Saran:** Bila dipilih, kembangkan satu metafora visual yang terhubung ke data yang sudah ada. Sediakan mode hemat animasi dan jangan memakai warna sebagai satu-satunya penanda status.
- **Tujuan:** Meningkatkan motivasi tanpa menambah kebisingan visual.

#### 10. Personalisasi Tema

- **Aplikasi referensi:** [H2M](https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke), [SmokingYou](https://github.com/bodyaant/SmokingYou), [Quitter](https://github.com/brandonp2412/quitter).
- **Pola UI:** Beberapa palet warna dan dark mode; sebagian aplikasi memanfaatkan warna dinamis Android.
- **Pola UX:** Pengguna dapat memilih tampilan yang nyaman.
- **Pola layout:** Pengaturan tema dikelompokkan dalam satu bagian, bukan tersebar per halaman.
- **Kondisi proyek:** Tema Sistem/Terang/Gelap sudah tersedia.
- **Saran:** Aksesibilitas, kontras, dan konsistensi token lebih penting daripada jumlah pilihan warna.
- **Tujuan:** Personalisasi yang tetap mudah dipelihara.

---

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
| 1 | Pencatatan konsumsi rokok aktual | Fitur baru | Menjadi sumber data perilaku yang dapat diverifikasi. | SQLite, model, provider, UI, backup. |
| 2 | Slip log yang suportif dan progres kumulatif | Fitur baru | Mencegah hilangnya riwayat dan meningkatkan kejujuran data. | Event konsumsi, model, perhitungan, kalender. |
| 3 | Konsistensi perhitungan counter/uang/tapering/kalender | Optimasi | Meningkatkan kepercayaan terhadap statistik. | Pencatatan konsumsi dan slip. |
| 4 | Diary craving dan analitik pemicu | Optimasi | Memberi insight kapan craving terjadi dan strategi apa yang membantu. | Perluasan model diary dan grafik. |
| 5 | Tapering yang dibandingkan dengan konsumsi aktual | Optimasi | Mengukur apakah pengurangan berjalan sesuai target. | Pencatatan konsumsi aktual. |
| 6 | Check-in dan notifikasi adaptif yang dapat dikendalikan | Fitur baru/optimasi | Mendukung kebiasaan dan memberi pengingat yang relevan. | Data perilaku dan pengaturan notifikasi. |
| 7 | Penyempurnaan SOS dan penyimpanan hasil intervensi | Optimasi | Membuat alat yang sudah ada lebih berguna dan terukur. | Penyimpanan lokal dan diary. |
| 8 | Widget Android | Fitur baru | Mempercepat akses ke counter dan SOS. | Native Android, update data, pengujian perangkat. |
| 9 | Backup preview/merge/CSV | Optimasi | Mengurangi risiko kehilangan data dan memudahkan ekspor. | Validasi JSON, kebijakan merge, file picker. |
| 10 | Mini-games, gamifikasi visual, komunitas, AI coach | Fitur baru | Menambah engagement atau dukungan tambahan. | Desain, backend/moderasi atau evaluasi konten. |

---

## G. Verifikasi dan Keterbatasan

- **Cakupan daftar awal:** 54 entri pada `apk_serupa.md` telah ditinjau dan diklasifikasikan. Nama ganda lintas toko atau repositori telah dijelaskan sebagai duplikasi/relasi ketika dapat dikenali.
- **Tautan pencarian toko:** Sejumlah tautan awal adalah halaman pencarian, bukan halaman aplikasi spesifik. Untuk Qwit, QuitNic AI, SmokingWeaner, QuitWin, dan Weanie, ditemukan tautan Play Store yang lebih spesifik dan dicantumkan pada katalog. Untuk Smoker Reducer, identitas halaman belum dipastikan.
- **Repositori tidak tersedia:** `Polymath-Saksh/SmokeFree` tidak berhasil diverifikasi saat penelitian.
- **Referensi lama:** `de.baumann.quitsmoking` dan `net.retiolus.exhale` perlu diperlakukan sebagai pembanding dasar/historis karena rilis yang ditemukan lebih lama.
- **Platform:** Fungsi iOS-only seperti Live Activities/WidgetKit tidak masuk rekomendasi implementasi Android. Untuk aplikasi lintas platform, keberadaan fitur pada Android harus dikonfirmasi secara terpisah.
- **Desain:** Screenshot dari README/sumber publik dapat memperlihatkan komposisi layar, tetapi tidak membuktikan semua detail interaksi atau responsivitas.
- **Data kesehatan:** Milestone WHO/CDC/NHS dan angka kesehatan lainnya harus diperiksa kembali ke sumber resmi/tenaga kesehatan sebelum menjadi konten aplikasi. Hindari menyajikannya sebagai prediksi atau diagnosis individu.
- **Privasi:** Aplikasi pembanding yang memakai cloud, akun, AI, atau komunitas bukan otomatis cocok untuk proyek yang mengutamakan offline-first. Nilai kebutuhan dan risiko data terlebih dahulu.
- **Pengujian proyek:** Kode aktual telah diperiksa pada branch `chatgpt`; tidak dilakukan perubahan kode, build APK, uji emulator, ataupun pengujian fisik sebagai bagian dari riset ini.

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

_Dokumen ini disusun ulang berdasarkan riset pada 10 November 2026 dan pemeriksaan kode proyek di branch `chatgpt`. Seluruh rekomendasi masih menunggu penyortiran dan keputusan pengguna._
