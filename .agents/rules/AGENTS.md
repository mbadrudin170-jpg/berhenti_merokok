// ============================================================
// FILE: .agents/rules/global/aturan_global.md
// ============================================================

# Aturan Global
## Tujuan File
File ini berfungsi sebagai dokumen ringkasan yang menjelaskan tujuan, fungsi, cakupan, dan lokasi setiap file aturan yang terdapat di folder `.agents/rules/global/`.
Folder tersebut digunakan untuk menyimpan standar dan ketentuan pengembangan yang berlaku secara global untuk seluruh proyek berbasis Flutter dan Dart.
## Ketentuan
1. Seluruh file aturan yang terdapat di folder `.agents/rules/global/` merupakan aturan global yang berlaku untuk semua proyek Flutter dan Dart.
2. AI wajib membaca, memahami, dan menerapkan aturan global tersebut ketika mengerjakan setiap proyek Flutter maupun Dart.
3. Aturan global tetap berlaku untuk seluruh proyek baru maupun proyek yang sudah ada. Penerapannya tidak terbatas pada proyek tertentu.
4. Aturan global wajib tetap diterapkan selama tidak bertentangan dengan aturan khusus proyek yang terdapat di folder `.agents/rules/proyek/`.
5. Jika terdapat konflik antara aturan global dan aturan khusus proyek, AI wajib mengikuti aturan khusus proyek. Aturan global lainnya yang tidak bertentangan tetap wajib diterapkan.
6. AI tidak boleh mengabaikan aturan global yang relevan hanya karena sedang mengerjakan proyek yang berbeda.
7. Setiap file aturan yang dicantumkan dalam dokumen ini wajib disertai path lengkap yang sesuai dengan lokasi sebenarnya agar mudah ditemukan.
8. AI tidak boleh mengarang atau memperkirakan nama maupun lokasi file yang belum diverifikasi.
## Prinsip Penggunaan
- `.agents/rules/global/`: Menyimpan standar pengembangan yang berlaku untuk seluruh proyek Flutter dan Dart.
- `.agents/rules/proyek/`: Menyimpan ketentuan khusus yang hanya berlaku untuk proyek tertentu.
## Format Ringkasan File
Gunakan format berikut untuk menjelaskan setiap file aturan:
### Nama File
- **Path:** `.agents/rules/global/nama_file.md`
- **Fungsi:** Penjelasan mengenai tujuan dan fungsi file.
- **Cakupan:** Penjelasan mengenai aspek pengembangan yang diatur oleh file tersebut.
## Rekomendasi
- Kelompokkan file berdasarkan fungsi agar mudah dibaca dan dipelihara.
- Perbarui ringkasan apabila terdapat penambahan, penghapusan, perubahan nama, atau pemindahan file aturan.


// ============================================================
// FILE: .agents/rules/global/aturan_lainnya.md
// ============================================================

Aturan Umum Pengembangan Flutter dan Dart
Path file proyek: prompt/aturan/aturan_lainnya.md
Dokumen ini berisi aturan umum yang wajib diterapkan AI saat membaca, menganalisis, memperbaiki, atau mengembangkan kode Flutter dan Dart dalam proyek.
Ketentuan Umum
Terapkan setiap aturan yang relevan dengan pekerjaan. Jangan mengabaikan aturan secara diam-diam.
Sebelum melakukan perubahan, periksa kode, konfigurasi, dokumentasi, dan aturan proyek yang berkaitan.
Jangan membuat asumsi tentang struktur proyek, API, versi SDK, paket, atau maksud pengguna jika hal tersebut dapat diperiksa atau perlu dikonfirmasi.
Jika suatu aturan tidak dapat diterapkan, alat yang diperlukan tidak tersedia, atau terdapat konflik yang belum dapat diselesaikan, jelaskan kendalanya kepada pengguna. Jangan berpura-pura telah mematuhi aturan tersebut.
Contoh benar dan salah pada setiap aturan merupakan ilustrasi perilaku. Nama API dalam contoh kode tetap harus dicocokkan dengan implementasi yang benar-benar tersedia di proyek.
1. Referensi Desain Antarmuka
   Sebelum mengubah, membuat, atau menganalisis tampilan antarmuka pengguna (UI), baca file optimasi_ui.md terlebih dahulu. File tersebut merupakan referensi desain proyek dan menjadi acuan untuk ukuran, jarak, tata letak, tipografi, warna, padding, dan margin.
Ikuti nilai dan pola desain yang sudah ditentukan dalam optimasi_ui.md.
Jangan membuat nilai desain baru langsung di widget jika nilai tersebut seharusnya menjadi bagian dari referensi desain terpusat.
Jika kebutuhan desain belum diatur, periksa pola yang sudah digunakan dalam proyek sebelum mengusulkan nilai baru.
Jika ada ketidaksesuaian antara kebutuhan tugas dan referensi desain, jelaskan ketidaksesuaian tersebut sebelum mengambil keputusan yang mengubah standar desain.
Contoh benar: Membaca optimasi_ui.md, lalu menggunakan token ukuran dan warna yang telah ditetapkan.
Contoh salah: Langsung menentukan padding, ukuran teks, atau warna baru di widget tanpa memeriksa optimasi_ui.md.
2. Verifikasi Versi dan Lokasi SDK
   Sebelum menggunakan API Flutter atau Dart, pastikan versi SDK yang benar-benar digunakan proyek. Jangan mengandalkan ingatan model atau dokumentasi untuk versi yang berbeda.
Periksa versi dengan flutter --version dan dart --version.
Temukan lokasi Flutter SDK yang benar-benar digunakan melalui command -v flutter, konfigurasi proyek, atau cara lain yang dapat diverifikasi.
Gunakan lokasi SDK aktual tersebut sebagai dasar pencarian sumber. Jangan menganggap SDK selalu berada di /flutter.
Bedakan lokasi sumber berikut:
Sumber framework Flutter umumnya berada di <FLUTTER_ROOT>/packages/flutter/lib/.
Sumber pustaka Dart berada di <FLUTTER_ROOT>/bin/cache/dart-sdk/lib/.
Paket SDK Flutter dapat berada di <FLUTTER_ROOT>/packages/<nama_paket>/ atau <FLUTTER_ROOT>/bin/cache/pkg/<nama_paket>/.
Folder <FLUTTER_ROOT>/bin/cache/ berisi berbagai artefak dan cache SDK. Jangan menganggap seluruh folder tersebut sebagai lokasi sumber kode framework Flutter.
Untuk paket pihak ketiga, periksa lokasi cache yang benar. Pada Linux, lokasi default biasanya ~/.pub-cache/hosted/pub.dev/, tetapi dapat berubah jika variabel PUB_CACHE digunakan.
Gunakan pubspec.lock untuk mengetahui versi paket yang benar-benar terselesaikan. Jika lokasi paket belum jelas, periksa .dart_tool/package_config.json dan konfigurasi dependensi proyek.
Baca hanya file sumber SDK atau paket yang relevan dengan API yang sedang digunakan. Jangan membaca seluruh cache secara rekursif tanpa tujuan.
Contoh benar: Memastikan versi Flutter, membaca pubspec.lock, menemukan versi paket yang digunakan, lalu memeriksa sumber API pada lokasi SDK atau cache paket yang sesuai.
Contoh salah: Mengasumsikan Flutter selalu berada di /flutter/bin/cache/, membaca cache secara acak, atau memakai API berdasarkan pengetahuan model tanpa memeriksa versi proyek.
3. Pemeriksaan Sumber dan Dokumentasi API
   Setiap kali pekerjaan membutuhkan API Flutter, Dart, atau paket pihak ketiga, periksa implementasi dan dokumentasi yang sesuai dengan versi terpasang sebelum menulis kode.
Urutan pemeriksaan:
Baca kode proyek yang memanggil atau akan memanggil API tersebut.
Baca versi dependensi pada pubspec.lock.
Periksa sumber API pada Flutter SDK, Dart SDK, atau direktori paket yang benar.
Periksa dokumentasi resmi, README, CHANGELOG, dan dokumentasi API paket jika tersedia.
Periksa contoh implementasi pada folder example/ paket jika tersedia.
Periksa tes atau contoh internal paket jika perilaku API belum jelas.
Pastikan API, konstruktor, parameter, nilai kembalian, serta pola penanganan error yang dipilih memang tersedia pada versi terpasang dan tidak deprecated.
Jika sumber lokal tidak cukup menjelaskan perilaku API, cari dokumentasi resmi yang sesuai dengan versi paket. Jangan menjadikan artikel tidak resmi sebagai sumber utama jika dokumentasi resmi tersedia.
Contoh benar: Memeriksa definisi konstruktor dan parameter pada sumber paket versi terpasang, lalu mencocokkannya dengan dokumentasi resmi.
Contoh salah: Menyalin contoh dari internet untuk versi terbaru padahal proyek menggunakan versi lama, tanpa memeriksa apakah API tersebut tersedia.
4. Kedalaman Pemeriksaan File
   Untuk analisis bug, perubahan fitur, atau pekerjaan yang berpotensi berdampak lintas file, periksa sekurang-kurangnya 10 file yang benar-benar relevan apabila file sebanyak itu tersedia. Pemeriksaan dapat mencakup widget, halaman, provider/notifier, model, repository, database, helper, konfigurasi, tes, serta sumber dependensi.
Jangan hanya membaca file yang disebut pengguna. Telusuri pemanggil, pemanggilan lanjutan, alur data, dan dependensi yang dapat memengaruhi masalah.
Jika pekerjaan sederhana dan hanya memiliki sedikit file yang relevan, baca seluruh file relevan yang tersedia. Jangan membaca file yang tidak berhubungan hanya untuk memenuhi jumlah 10 file.
Jika jumlah file relevan kurang dari 10, sebutkan jumlah file yang diperiksa dan alasannya dalam laporan akhir.
Jangan menyimpulkan bahwa suatu masalah hanya berada pada satu file sebelum memeriksa alur yang berkaitan.
Contoh benar: Saat memperbaiki data yang tidak tampil, memeriksa halaman, provider, model, repository, query database, helper pemetaan, konfigurasi, serta tes yang berkaitan.
Contoh salah: Mengubah satu widget berdasarkan dugaan tanpa memeriksa provider, sumber data, atau file lain yang memasok data ke widget tersebut.
5. Manajemen Dependensi dan Paket
   Jangan menambah atau menghapus dependensi secara manual dengan mengubah bagian dependencies atau dev_dependencies di pubspec.yaml.
Tambahkan dependensi menggunakan flutter pub add nama_paket.
Tambahkan dependensi pengembangan menggunakan flutter pub add --dev nama_paket.
Untuk dependensi Flutter SDK, gunakan opsi SDK yang sesuai, misalnya flutter pub add flutter_localizations --sdk flutter.
Hapus dependensi menggunakan flutter pub remove nama_paket.
Setelah perubahan dependensi, periksa hasil perubahan pada pubspec.yaml dan pubspec.lock.
Jangan menambahkan paket yang sudah tersedia atau mengganti paket tanpa memeriksa dependensi dan pola proyek terlebih dahulu.
Aturan ini hanya mengatur entri dependensi. Pengaturan aset dan font di bagian flutter: pada pubspec.yaml tetap boleh diperbarui sesuai Aturan 14.
Contoh benar: Menambahkan paket dengan flutter pub add uuid.
Contoh salah: Menambahkan baris uuid: ^... secara manual ke bagian dependencies di pubspec.yaml.
6. Baca Kode Sebelum Menganalisis atau Mengubah
   Baca implementasi yang sudah ada sebelum membuat kesimpulan atau mengubah kode. Pengetahuan model dan cache konteks AI dapat tidak sesuai dengan versi proyek saat ini.
Dahulukan bukti dari kode proyek dan sumber SDK/paket yang benar-benar terpasang.
Jangan mengarang nama fungsi, parameter, provider, class, path, atau struktur data.
Jangan menganggap cache jawaban AI selalu terbaru atau benar.
Cocokkan setiap asumsi teknis dengan implementasi yang dapat dibaca.
Contoh benar: Memeriksa definisi fungsi dan seluruh pemanggilnya sebelum mengubah parameter fungsi tersebut.
Contoh salah: Menganggap sebuah fungsi menerima parameter tertentu hanya karena pernah melihat pola serupa pada proyek lain.
7. Batasi Ruang Lingkup Perubahan
   Fokus hanya pada kode dan file yang diperlukan untuk menyelesaikan topik atau tugas pengguna.
Gunakan tool edit atau mekanisme perubahan parsial untuk mengubah bagian kode yang diperlukan.
Jangan menulis ulang seluruh file jika perubahan hanya membutuhkan beberapa baris.
Jangan melakukan refactor, penggantian nama, pemindahan file, perubahan arsitektur, atau perapian di luar ruang lingkup tanpa kebutuhan yang terbukti dan persetujuan pengguna.
Perubahan lintas file hanya diperbolehkan jika memang diperlukan oleh alur fungsi, dependensi, atau perbaikan bug.
Jika perubahan besar tidak dapat dihindari, jelaskan alasan dan dampaknya sebelum melakukannya.
Contoh benar: Mengubah satu fungsi dengan tool edit tanpa mengubah bagian file lainnya.
Contoh salah: Menulis ulang seluruh file atau merapikan modul lain yang tidak berkaitan dengan permintaan.
8. File Hasil Generator
   Jangan mengedit file hasil generator secara langsung, termasuk file dengan akhiran .g.dart dan .freezed.dart.
Jika perubahan pada file hasil generator diperlukan, cari file sumber atau anotasi yang menjadi asalnya.
Ubah file sumber, lalu jalankan generator yang memang digunakan proyek.
Periksa konfigurasi dan perintah generator sebelum menjalankannya.
Jangan menghapus, menimpa, atau mengubah hasil generator secara manual.
Contoh benar: Mengubah model Freezed, kemudian menjalankan perintah generator yang sesuai dengan konfigurasi proyek.
Contoh salah: Mengubah isi file pengguna.freezed.dart secara langsung agar error hilang.
9. Konsistensi Implementasi
   Pertahankan konsistensi dengan struktur, pola, penamaan, dan arsitektur yang sudah digunakan proyek.
Cari implementasi serupa pada file lain sebelum membuat pola baru.
Ikuti cara proyek menangani state, error, logging, navigasi, database, serta pemisahan tanggung jawab.
Jangan membuat abstraksi atau helper baru jika pola yang tersedia sudah dapat digunakan.
Jangan menyalin pola dari file lain secara membabi buta; pastikan pola tersebut masih sesuai dengan kebutuhan dan versi dependensi.
Contoh benar: Mengikuti pola repository dan provider yang sudah dipakai oleh fitur sejenis setelah memeriksa implementasinya.
Contoh salah: Membuat mekanisme pengelolaan state baru padahal proyek sudah memiliki pola standar yang sesuai.
10. Logging dan Larangan print
    Dilarang menggunakan print() atau debugPrint() untuk logging aplikasi.
Untuk log ke console, gunakan class atau helper p yang memang tersedia di proyek.
Untuk log debug yang ditujukan agar dapat dilihat dari aplikasi/APK, gunakan logger yang disediakan melalui file l.dart.
Sebelum memanggil logger, baca file implementasinya dan gunakan nama metode serta parameter yang benar-benar tersedia. Jangan menebak API logger.
Jangan meninggalkan log sementara yang tidak diperlukan setelah debugging selesai.
Contoh benar: Menggunakan metode logging dari p atau logger di l.dart setelah memeriksa definisi API-nya.
Contoh salah: Menulis print(data); atau debugPrint(data.toString()); untuk mencetak log aplikasi.
11. Konvensi Penamaan
    Gunakan bahasa Indonesia untuk nama yang dibuat sendiri pada kode aplikasi, dengan tetap mengikuti konvensi penamaan Dart.
Class, enum, dan type menggunakan PascalCase.
Variabel, fungsi, method, getter, dan nama provider mengikuti konvensi proyek, umumnya camelCase.
Nama file wajib menggunakan snake_case.
Pilih nama singkat, jelas, dan cukup spesifik sehingga maksudnya dapat dipahami tanpa menebak.
Jangan mengubah nama API Flutter, Dart, paket pihak ketiga, atau simbol hasil generator.
Pertahankan nama yang diwajibkan oleh kontrak eksternal, format data, atau kompatibilitas API.
Contoh benar: DaftarPenggunaPage, ambilDataPengguna, dan daftar_pengguna_page.dart.
Contoh salah: Membuat file DaftarPenggunaPage.dart, memakai nama ambigu seperti x1, atau menerjemahkan nama API resmi Flutter.
12. Dokumentasi dan Komentar Kode
    Tambahkan dokumentasi singkat menggunakan doc comment /// pada API publik dan logika kompleks yang tidak mudah dipahami dari kode saja.
Setiap doc comment wajib satu baris dan menjelaskan fungsi atau tujuan secara langsung.
Gunakan komentar biasa hanya jika diperlukan untuk menjelaskan alasan, batasan, atau perilaku yang tidak jelas dari kode.
Hapus komentar yang sudah tidak relevan, salah, duplikat, atau hanya mengulang isi kode.
Jangan menghapus komentar yang masih menjelaskan alasan teknis penting, batasan, atau keputusan yang tidak dapat diketahui hanya dari kode.
Contoh benar:
/// Mengambil daftar pengguna yang masih aktif.
Future<List<Pengguna>> ambilPenggunaAktif() async { ... }
Contoh salah:
/// Fungsi ini digunakan untuk mengambil daftar pengguna yang masih aktif
/// berdasarkan kondisi tertentu dan kemudian mengembalikannya kepada pemanggil.
Future<List<Pengguna>> ambilPenggunaAktif() async { ... } 13. Batasan Penggunaan Git
Perintah Git hanya boleh digunakan untuk membaca informasi. Sebelum menjalankan perintah yang dapat mengubah repository, index, branch, riwayat, atau remote, wajib meminta persetujuan pengguna melalui tool question.
Perintah baca yang diperbolehkan antara lain git status, git diff, git log, git show, git branch --list, dan git ls-files.
Perintah yang mengubah keadaan Git, misalnya git add, git commit, git checkout, git switch, git reset, git restore, git clean, git stash, git merge, git rebase, git cherry-pick, git tag, git push, dan git pull, wajib meminta persetujuan terlebih dahulu.
Jika ragu apakah sebuah perintah mengubah repository atau remote, jangan jalankan sebelum bertanya.
Contoh benar: Menjalankan git diff untuk membaca perubahan.
Contoh salah: Menjalankan git add . atau git commit tanpa persetujuan pengguna.
14. Manajemen Aset dan Font di pubspec.yaml
    Setiap aset gambar, font, ikon, atau berkas lokal yang digunakan aplikasi harus didaftarkan pada bagian yang sesuai di pubspec.yaml dan dimuat melalui path yang konsisten.
Periksa struktur folder aset dan konfigurasi yang sudah ada sebelum menambahkan path.
Jangan mendaftarkan path yang tidak ada.
Jangan membuat beberapa path berbeda untuk merujuk aset yang sama tanpa alasan.
Pendaftaran aset/font pada bagian flutter: diperbolehkan diperbarui secara langsung; larangan edit manual pada Aturan 5 hanya berlaku untuk bagian dependensi.
Contoh benar: Menambahkan folder aset yang benar-benar ada ke bagian flutter/assets, lalu memuat gambar menggunakan path yang sama.
Contoh salah: Memakai assets/gambar/logo.png di kode tanpa memastikan file tersebut ada dan terdaftar di pubspec.yaml.
15. Format Kode dan Analisis Statis
    Setelah mengubah kode Dart:
Jalankan dart format hanya pada file Dart yang dibuat atau diubah.
Jalankan flutter analyze untuk memeriksa proyek.
Jika analisis menemukan masalah yang disebabkan oleh perubahan, perbaiki lalu jalankan kembali format dan analisis.
Jalankan tes yang relevan apabila perubahan memengaruhi logika yang memiliki tes atau membutuhkan verifikasi perilaku.
Laporkan error yang sudah ada sebelum perubahan jika dapat dibedakan dari error akibat pekerjaan saat ini.
Urutan ini memastikan format akhir ikut diperiksa oleh analisis statis. Jangan mengklaim analisis berhasil jika perintah tidak dijalankan atau hasilnya belum diperiksa.
Contoh benar: Menjalankan dart format lib/fitur/pengguna/daftar_pengguna.dart, kemudian flutter analyze.
Contoh salah: Mengubah file Dart, tidak menjalankan formatter maupun analyzer, lalu menyatakan pekerjaan bebas error.
16. Penggunaan Google Fonts
    Gunakan Google Fonts dengan mekanisme cache agar font tidak dimuat berulang kali dari jaringan.
Periksa apakah paket google_fonts sudah tersedia dan bagaimana konfigurasi versi terpasangnya.
Ikuti pola pemakaian font yang telah ditentukan proyek.
Hindari pemuatan jaringan berulang pada setiap pembangunan widget atau setiap perpindahan halaman.
Jika aplikasi harus dapat menampilkan font secara konsisten tanpa koneksi internet, periksa opsi penyertaan font sebagai aset lokal dan daftarkan font tersebut pada pubspec.yaml.
Contoh benar: Menggunakan font sesuai konfigurasi cache proyek dan memastikan font yang wajib tersedia secara offline telah dibundel.
Contoh salah: Memicu pengunduhan font dari jaringan berulang kali saat widget dibangun.
17. Splash Screen
    Gunakan flutter_native_splash untuk membuat splash screen native. Jangan membuat splash screen awal secara manual menggunakan widget Flutter jika kebutuhan tersebut merupakan splash screen saat aplikasi diluncurkan.
Periksa konfigurasi dan versi flutter_native_splash yang digunakan proyek.
Ikuti konfigurasi warna, gambar, dan platform yang sudah ditetapkan.
Jalankan generator splash screen sesuai dokumentasi versi paket setelah mengubah konfigurasinya.
Contoh benar: Mengatur splash screen melalui konfigurasi flutter_native_splash dan menjalankan generatornya.
Contoh salah: Membuat halaman widget buatan sendiri sebagai pengganti splash screen native saat proses awal aplikasi.
18. Toast dan Feedback Singkat
    Gunakan fluttertoast untuk feedback singkat yang memang sesuai ditampilkan sebagai toast.
Periksa helper atau pola toast yang sudah tersedia sebelum memanggil paket secara langsung.
Hindari menampilkan toast berulang untuk satu kejadian.
Jangan gunakan toast sebagai pengganti konfirmasi tindakan berisiko, informasi proses yang berlangsung lama, formulir, atau pesan error panjang.
Pastikan pesan singkat, jelas, dan sesuai bahasa pengguna.
Contoh benar: Menampilkan satu toast singkat setelah penyimpanan berhasil.
Contoh salah: Menampilkan toast berulang kali selama proses pemuatan atau menggunakan toast sebagai satu-satunya konfirmasi sebelum menghapus data.
19. Pembuatan ID Unik
    Gunakan paket uuid untuk membuat ID unik apabila data membutuhkan identifier baru.
Periksa apakah paket uuid sudah tersedia dan ikuti pola pemakaiannya di proyek.
Jangan menggunakan timestamp sebagai pengganti ID unik.
Jangan membuat ID sendiri dari gabungan waktu atau angka acak sederhana tanpa dasar yang dapat dipertanggungjawabkan.
Jangan membuat ulang ID untuk data yang sudah memiliki ID tetap.
Contoh benar: Membuat ID baru menggunakan generator UUID dari paket uuid.
Contoh salah: Menggunakan DateTime.now().millisecondsSinceEpoch sebagai ID utama sebuah data.
20. Shared Preferences
    Gunakan shared_preferences hanya untuk pengaturan sederhana yang sesuai disimpan sebagai preferensi lokal.
Cocok untuk nilai kecil seperti tema, bahasa pilihan, atau preferensi tampilan.
Jangan menyimpan data sensitif, kredensial, data berukuran besar, atau kumpulan data utama aplikasi.
Gunakan database atau mekanisme penyimpanan yang sesuai untuk data terstruktur dan data utama aplikasi.
Ikuti pola akses preferences yang sudah digunakan proyek.
Contoh benar: Menyimpan pilihan tema gelap pengguna.
Contoh salah: Menyimpan seluruh riwayat transaksi atau kata sandi pengguna ke shared_preferences.
21. Daftar dengan Banyak Item
    Untuk daftar yang berpotensi menampilkan lebih dari 20 item, gunakan widget yang membangun item secara bertahap, seperti ListView.builder atau SliverList.
Jangan membangun seluruh item sekaligus dengan ListView(children: ...) jika jumlah item dapat melebihi 20.
Pilih widget berdasarkan struktur layar yang sudah digunakan proyek.
Pastikan setiap item memiliki identitas dan key yang tepat jika diperlukan.
Contoh benar: Menggunakan ListView.builder untuk menampilkan daftar ratusan transaksi.
Contoh salah: Membuat seluruh ratusan widget daftar sekaligus di dalam Column atau ListView(children: ...).
22. Skills
    Sebelum mengerjakan tugas, periksa skills yang tersedia dan muat skill yang relevan dengan bahasa, framework, paket, atau jenis pekerjaan tersebut.
Baca isi skill yang relevan sebelum menulis atau mengubah kode.
Ikuti instruksi dan referensi yang disediakan skill.
Jangan memuat atau mengikuti skill yang tidak berhubungan dengan tugas.
Jika tidak ada skill yang relevan atau tool skill tidak tersedia, lanjutkan berdasarkan dokumentasi resmi dan kode proyek, lalu laporkan keterbatasannya bila berpengaruh.
Contoh benar: Memuat skill Flutter/Riverpod yang relevan sebelum mengubah provider.
Contoh salah: Mengabaikan skill yang tersedia dan langsung menulis implementasi berdasarkan asumsi.
23. Contoh Implementasi Paket
    Saat menggunakan atau memperbaiki implementasi paket pihak ketiga, periksa folder example/ dari versi paket yang benar-benar terpasang jika folder tersebut tersedia.
Bandingkan pola penggunaan paket dalam proyek dengan contoh resmi paket.
Periksa apakah contoh menggunakan API yang sama dengan versi terpasang.
Jangan menyalin contoh mentah tanpa memahami kebutuhan, batasan, dan struktur proyek.
Jika folder example/ tidak tersedia, periksa dokumentasi resmi, README, tes paket, atau sumber implementasinya.
Contoh benar: Membandingkan konfigurasi paket yang digunakan proyek dengan contoh pada versi paket yang terpasang.
Contoh salah: Menyatakan implementasi proyek sudah benar tanpa memeriksa contoh atau dokumentasi paket yang relevan.
24. Klarifikasi kepada Pengguna
    Jangan menebak keputusan yang dapat mengubah hasil, perilaku, arsitektur, data, atau ruang lingkup pekerjaan. Jika informasi penting belum tersedia atau terdapat beberapa pilihan yang sama-sama mungkin, gunakan tool question untuk meminta kepastian.
Ajukan pertanyaan yang spesifik dan sertakan pilihan jika pilihan tersebut dapat dirumuskan dengan jelas.
Jangan menanyakan hal yang jawabannya sudah tersedia di percakapan, kode, konfigurasi, atau dokumentasi proyek.
Jangan meminta konfirmasi untuk detail teknis rutin yang sudah ditentukan oleh aturan dan pola proyek.
Jika pertanyaan belum dijawab, jangan menjalankan perubahan yang bergantung pada jawaban tersebut.
Jika tool question tidak tersedia, ajukan pertanyaan secara langsung di percakapan. Jangan berpura-pura telah menggunakan tool.
Contoh benar: Bertanya apakah data yang dihapus harus dihapus permanen atau dipindahkan ke arsip ketika kode dan permintaan pengguna belum menjelaskan hal tersebut.
Contoh salah: Memilih salah satu perilaku penghapusan berdasarkan dugaan, padahal pilihan tersebut berdampak pada data pengguna.
25. Peta Jalan Pekerjaan dengan todowrite
    Untuk pekerjaan yang terdiri atas beberapa tahap, melibatkan banyak file, atau membutuhkan analisis dan verifikasi, gunakan tool todowrite sebelum mulai bekerja agar pengguna dapat melihat peta jalan pekerjaan.
Susun langkah yang konkret, berurutan, dan sesuai ruang lingkup tugas.
Perbarui status daftar tugas ketika pekerjaan dimulai, selesai, atau ketika ditemukan langkah tambahan yang memang diperlukan.
Jangan memasukkan pekerjaan di luar permintaan.
Untuk permintaan sangat sederhana yang hanya membutuhkan satu tindakan kecil, daftar tugas tidak wajib jika tidak menambah manfaat.
Jika tool todowrite tidak tersedia, sampaikan rencana singkat melalui percakapan. Jangan mengaku telah memperbarui daftar tugas.
Contoh benar: Membuat daftar tahap untuk menelusuri bug, memperbaiki beberapa file, menjalankan tes, dan memeriksa hasil analisis.
Contoh salah: Memulai perubahan lintas file tanpa peta jalan, atau membuat daftar tugas yang tidak berkaitan dengan permintaan.
26. Tool untuk Mengubah File
    Untuk mengubah kode atau file proyek, gunakan tool edit atau write.
Utamakan edit untuk perubahan sebagian pada file yang sudah ada.
Gunakan write untuk membuat file baru atau menulis ulang seluruh isi file hanya jika memang diperlukan dan sesuai permintaan.
Jangan mengubah kode menggunakan perintah terminal, skrip shell, atau teknik penggantian teks melalui terminal.
Terminal boleh digunakan untuk membaca informasi, mencari file/teks, menjalankan formatter, analyzer, generator, tes, dan perintah verifikasi lain yang tidak mengubah kode sumber secara manual.
Jangan menggunakan sed -i, perl -pi, tee, pengalihan > atau >>, atau skrip sejenis untuk mengedit file.
Contoh benar: Mengubah beberapa baris Dart menggunakan tool edit.
Contoh salah: Menjalankan sed -i atau cat > file.dart untuk mengubah kode proyek.
27. Tool dan Perintah Pencarian
    Gunakan tool yang paling sesuai dengan jenis pencarian.
Gunakan glob untuk mencari file berdasarkan nama atau pola path.
Gunakan ls untuk melihat isi satu folder.
Gunakan rg untuk mencari teks di dalam file.
Gunakan grep -rn hanya sebagai alternatif ketika rg benar-benar gagal atau tidak tersedia.
Jika rg dilaporkan belum terpasang, periksa lokasinya menggunakan which rg melalui perintah shell sebelum memilih alternatif.
Kode keluar rg yang menunjukkan tidak ada hasil pencarian bukan berarti tool gagal. Jangan langsung beralih ke grep hanya karena tidak ada hasil.
Jangan menggunakan pencarian luas tanpa membatasi folder atau pola ketika ruang lingkup sudah diketahui.
Contoh benar: Mencari pemanggilan fungsi dengan rg "namaFungsi" lib/ dan mencari file dengan glob.
Contoh salah: Langsung menjalankan grep -rn meskipun rg tersedia dan berfungsi.
28. Urutan Kerja Analisis hingga Implementasi
    Untuk tugas yang membutuhkan analisis dan perubahan kode, gunakan alur berikut:
Pahami tujuan dan batasan permintaan pengguna.
Baca aturan proyek yang berlaku, termasuk AGENTS.md dan rules lain yang telah didaftarkan.
Baca optimasi_ui.md jika pekerjaan menyentuh UI.
Periksa skills yang relevan.
Periksa struktur dan kode proyek yang berkaitan. Untuk pekerjaan kompleks atau lintas file, terapkan ketentuan pemeriksaan pada Aturan 4.
Telusuri alur dari UI ke state/provider, repository, database, atau layanan yang terkait.
Periksa versi dependensi dan sumber SDK/paket mengikuti Aturan 2 dan 3.
Periksa dokumentasi resmi serta folder example/ paket jika relevan.
Jika terdapat keputusan penting yang belum jelas, gunakan tool question dan tunggu jawaban.
Susun peta jalan menggunakan todowrite jika pekerjaan terdiri atas beberapa tahap.
Lakukan perubahan sekecil mungkin menggunakan tool edit file.
Jalankan formatter, analyzer, dan tes relevan.
Tinjau kembali diff agar tidak ada perubahan di luar ruang lingkup.
Laporkan file yang diubah, alasan perubahan, pemeriksaan yang dijalankan, hasilnya, dan kendala yang belum terselesaikan.
Contoh benar: Menelusuri seluruh alur data dan API paket sebelum memperbaiki bug pada tampilan.
Contoh salah: Langsung menulis kode dari dugaan tanpa membaca aturan, kode sumber, versi paket, atau alur dependensi.
29. Inisialisasi Database sqflite FFI
    Jika aplikasi menggunakan sqflite pada platform desktop atau web, atur database factory yang sesuai sebelum membuka database.
Untuk desktop yang menggunakan FFI, panggil sqfliteFfiInit() dan atur databaseFactory ke databaseFactoryFfi sebelum pemanggilan pembukaan database.
Untuk web, atur databaseFactory ke databaseFactoryFfiWeb sebelum pemanggilan pembukaan database.
Untuk Android dan iOS, ikuti factory bawaan yang sesuai dengan paket sqflite; jangan memaksakan factory FFI desktop.
Periksa versi dan dokumentasi paket FFI yang terpasang, termasuk import dan API yang benar.
Pastikan inisialisasi hanya dilakukan pada tempat yang tepat dan tidak terlambat setelah database dibuka.
Contoh benar: Memilih factory berdasarkan platform, menyelesaikan inisialisasi terlebih dahulu, lalu memanggil openDatabase.
Contoh salah: Membuka database desktop sebelum sqfliteFfiInit() dan pengaturan databaseFactoryFfi, atau menggunakan factory FFI desktop tanpa memeriksa platform.
30. Navigasi Antarhalaman
    Semua navigasi antarhalaman wajib menggunakan helper Nav yang tersedia di core_shared.
Baca definisi helper Nav terlebih dahulu untuk mengetahui method, parameter, dan nilai kembaliannya.
Gunakan helper tersebut untuk navigasi maju, kembali, atau bentuk navigasi lain yang didukung proyek.
Jangan memanggil API navigasi Flutter secara langsung jika helper proyek sudah menyediakan fungsi yang sesuai.
Pengecualian yang diperbolehkan: pengecekan guard seperti `Navigator.of(context).canPop()` untuk memastikan navigasi dapat dilakukan, serta `SystemNavigator.pop()` untuk keluar dari aplikasi. Pemanggilan `Navigator.push`, `pushReplacement`, dan `pop` secara langsung tetap dilarang meskipun untuk menutup dialog atau bottom sheet, karena `Nav.pop(context, result)` sudah mendukung pengembalian nilai.
Gunakan unawaited hanya jika Future memang sengaja tidak perlu ditunggu dan pola tersebut sesuai dengan implementasi helper.
Contoh benar:
unawaited(Nav.to(context, const StatistikBahanBakar()));
Contoh salah:
Navigator.push(
context,
MaterialPageRoute(builder: (\_) => const StatistikBahanBakar()),
); 31. Aturan Import
Gunakan package: import untuk mengimpor file proyek. Jangan menggunakan relative import.
Contoh benar:
import 'package:myapp/fitur/pengguna/halaman/daftar_pengguna.dart';
Contoh salah:
import '../../pengguna/halaman/daftar_pengguna.dart'; 32. Penyimpanan Tanggal dan Waktu
Simpan tanggal dan waktu ke database dalam format UTC. Saat menampilkan tanggal dan waktu kepada pengguna, konversikan ke waktu lokal perangkat.
Konversikan nilai ke UTC sebelum disimpan.
Konversikan nilai UTC ke waktu lokal ketika akan ditampilkan kepada pengguna.
Ikuti format penyimpanan yang sudah digunakan proyek dan pastikan proses parsing tidak menghilangkan informasi zona waktu.
Jangan menyimpan waktu lokal seolah-olah merupakan UTC.
Contoh benar: Menggunakan waktu.toUtc() sebelum menyimpan dan waktuUtc.toLocal() sebelum menampilkan.
Contoh salah: Menyimpan waktu lokal tanpa konversi UTC, lalu menganggap nilai tersebut sudah UTC.
33. Lokalisasi Aplikasi
    Aplikasi Flutter wajib mengatur lokalisasi secara eksplisit pada MaterialApp.
Deklarasikan supportedLocales.
Jika aplikasi menargetkan pengguna Indonesia, sertakan const Locale('id', 'ID').
Gunakan flutter_localizations dari Flutter SDK untuk menyediakan data lokalisasi.
Pastikan localizationsDelegates mencakup setidaknya:
GlobalMaterialLocalizations.delegate
GlobalWidgetsLocalizations.delegate
GlobalCupertinoLocalizations.delegate
Jangan hanya mengandalkan delegate paket pihak ketiga jika paket tersebut tidak menyediakan data untuk locale yang dibutuhkan.
Pastikan teks sistem yang tampil kepada pengguna, seperti toolbar pemilihan teks, dialog, date picker, dan komponen Material/Cupertino, mengikuti locale yang didukung.
Setiap perubahan lokalisasi wajib diverifikasi secara visual pada layar yang terdampak.
Pastikan dependensi dan import lokalisasi sesuai dengan versi Flutter SDK yang digunakan.
Contoh benar: Mendeklarasikan supportedLocales, delegate global Flutter, dan memeriksa date picker dalam locale Indonesia.
Contoh salah: Hanya mengatur teks buatan aplikasi ke bahasa Indonesia, tetapi membiarkan komponen sistem memakai locale yang tidak sesuai.
34. Pendaftaran dan Pemuatan Rules Kilo Code
    Keberadaan file rules di folder proyek tidak otomatis membuktikan bahwa Kilo Code memuat rules tersebut.
Daftarkan file rules proyek secara eksplisit pada array instructions di kilo.jsonc.
Untuk file ini, pastikan path prompt/aturan/aturan_lainnya.md tercantum dalam instructions.
Sebelum mengubah konfigurasi, baca isi kilo.jsonc yang sudah ada. Pertahankan seluruh konfigurasi lain dan jangan menimpa isi file secara keseluruhan.
Jika path belum terdaftar, tambahkan hanya entri yang diperlukan menggunakan tool edit file.
Jika rules terlalu besar atau mencampur banyak topik, pecah menjadi beberapa file berdasarkan tanggung jawab. Pastikan setiap file hasil pemecahan juga didaftarkan secara eksplisit.
Jangan menganggap rules aktif hanya karena file ada, namanya benar, atau foldernya sudah dibuat.
Setelah perubahan konfigurasi rules, pastikan sintaks JSONC valid dan ikuti kebutuhan pemuatan ulang sesi Kilo Code agar konfigurasi terbaru diterapkan.
Rules berbentuk instruksi teks tidak menjamin semua tindakan dapat dicegah secara teknis. Untuk larangan yang sangat kritis, gunakan juga permission Kilo Code yang sesuai dan pemeriksaan otomatis seperti analyzer, tes, atau validasi konfigurasi.
Contoh benar: Memeriksa kilo.jsonc, memastikan path prompt/aturan/aturan_lainnya.md berada di dalam instructions, lalu memeriksa ulang konfigurasi.
Contoh salah: Menganggap rules otomatis aktif hanya karena file prompt/aturan/aturan_lainnya.md tersedia di proyek.
35. Pemeriksaan Kepatuhan Sebelum Menyelesaikan Tugas
    Sebelum menyatakan pekerjaan selesai, lakukan pemeriksaan berikut:
Apakah semua aturan yang relevan telah diterapkan?
Apakah file dan alur dependensi yang berkaitan sudah diperiksa?
Apakah perubahan tetap berada dalam ruang lingkup permintaan?
Apakah tidak ada file .g.dart atau .freezed.dart yang diedit langsung?
Apakah tidak ada print() atau debugPrint() yang ditambahkan?
Apakah import, penamaan, navigasi, logging, dan pola proyek sudah konsisten?
Apakah dart format dan flutter analyze sudah dijalankan setelah perubahan kode Dart?
Apakah tes atau verifikasi visual yang relevan sudah dilakukan?
Apakah diff sudah diperiksa untuk menemukan perubahan yang tidak diminta?
Apakah semua kendala, pemeriksaan yang gagal, atau aturan yang tidak dapat diterapkan sudah dilaporkan secara jujur?
Apakah larangan yang sangat kritis juga dilindungi dengan permission atau pemeriksaan otomatis jika memungkinkan?
Jangan menyatakan tugas selesai atau bebas error apabila pemeriksaan yang diwajibkan belum dilakukan. Jangan menganggap pendaftaran rules sebagai jaminan teknis bahwa semua tindakan akan selalu dicegah; rules Kilo Code merupakan instruksi bagi agen dan perlu didukung oleh permission serta pemeriksaan otomatis untuk kebutuhan yang kritis.
Contoh benar: Melaporkan bahwa formatter dan analyzer berhasil, menyebutkan file yang berubah, serta menjelaskan tes yang dijalankan.
Contoh salah: Mengatakan "semua sudah aman" tanpa memeriksa hasil formatter, analyzer, tes, atau diff.


// ============================================================
// FILE: .agents/rules/global/aturan_notifikasi.md
// ============================================================

# Aturan Notifikasi
**Path:** `.agents/rules/global/aturan_notifikasi.md`
## Aturan Wajib Baca
Sebelum mengimplementasikan atau mengubah kode yang berkaitan dengan notifikasi lokal, AI wajib membaca dokumentasi berikut:
- [flutter_local_notifications versi 22.3.3](https://pub.dev/packages/flutter_local_notifications/versions/22.3.3)
Ketentuan:
1. Gunakan dokumentasi tersebut sebagai referensi utama implementasi.
2. Versi `22.3.3` merupakan versi yang telah dipasang pada proyek. Jangan mencari, mengganti, atau mempertanyakan versi lain.
3. Pastikan penggunaan API, konfigurasi, dan implementasi sesuai dengan dokumentasi versi tersebut.
## Aturan Implementasi
### 1. Paket dan Inisialisasi
1. Gunakan `flutter_local_notifications` untuk menangani notifikasi lokal.
2. Lakukan inisialisasi notifikasi di dalam fungsi `main()`.
3. Gunakan paket `timezone` dengan alias `tz` untuk mengatur jadwal notifikasi.
#### Contoh benar
```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
Future<void> main() async {
  tz.initializeTimeZones();
  final plugin = FlutterLocalNotificationsPlugin();
  await plugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('ic_notifikasi'),
    ),
  );
  runApp(const App());
}
```
**Alasan:** Inisialisasi dilakukan sebelum `runApp`, plugin berasal dari paket yang dipasang, dan `timezone` diimpor dengan alias `tz`.
#### Contoh salah
```dart
void main() {
  runApp(const App()); // plugin belum diinisialisasi
}
final jadwal = DateTime.now().add(const Duration(hours: 1));
```
**Kesalahan:** Notifikasi tidak diinisialisasi di `main()` dan jadwal tidak menggunakan `tz.TZDateTime` dari paket `timezone`.
**Rujukan teknis:**
- `lib/shared/notifikasi/notifikasi_service.dart` — `inisialisasi()`.
- `pubspec.yaml` — `flutter_local_notifications: ^22.3.3`, `timezone: ^0.11.2`.
### 2. Ikon Notifikasi
1. Wajib menggunakan ikon aplikasi sebagai ikon notifikasi.
2. Pastikan ikon dikonfigurasi sesuai dengan ketentuan dan format yang didukung oleh platform.
3. Ikuti dokumentasi `flutter_local_notifications` versi `22.3.3` untuk menentukan konfigurasi ikon yang benar.
#### Contoh benar
```dart
const android = AndroidNotificationDetails(
  'jadwal_service',
  'Jadwal Service',
  icon: 'ic_notifikasi',
);
```
**Alasan:** Ikon menggunakan aset aplikasi `ic_notifikasi` yang juga dipakai proyek.
#### Contoh salah
```dart
const android = AndroidNotificationDetails(
  'jadwal_service',
  'Jadwal Service',
  icon: 'https://example.com/icon.png',
);
```
**Kesalahan:** Ikon dimuat dari jaringan, bukan ikon aplikasi yang terpasang.
**Rujukan teknis:**
- `lib/shared/notifikasi/notifikasi_service.dart` — `AndroidNotificationDetails(icon: 'ic_notifikasi')`.
### 3. Payload Notifikasi
1. Setiap notifikasi wajib memiliki payload yang memuat:
   - `kategori`: jenis atau kategori data yang menjadi sumber notifikasi.
   - `id`: identitas data yang terkait dengan notifikasi.
2. Kedua informasi tersebut digunakan untuk menentukan tujuan navigasi ketika pengguna membuka notifikasi.
#### Contoh benar
```dart
await plugin.show(
  1,
  'Jadwal service',
  'Segera lakukan service',
  notificationDetails,
  payload: 'kategori=jadwal_service&id=$idJadwal',
);
```
**Alasan:** Payload memuat `kategori` dan `id` yang dapat dipakai untuk navigasi.
#### Contoh salah
```dart
await plugin.show(1, 'Jadwal service', 'Segera lakukan service', notificationDetails);
```
**Kesalahan:** Notifikasi ditampilkan tanpa payload, sehingga tujuan navigasi tidak dapat ditentukan.
**Rujukan teknis:**
- `lib/shared/notifikasi/notifikasi_service.dart` — `_navigasiKeHalaman(payload)`.
### 4. Penanganan Izin
1. Tangani permintaan izin notifikasi sesuai dengan ketentuan masing-masing platform.
2. Sesuaikan mekanisme permintaan dan pemeriksaan izin dengan platform yang digunakan.
#### Contoh benar
```dart
if (kIsWeb) {
  await plugin
      .resolvePlatformSpecificImplementation<WebFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
} else if (defaultTargetPlatform == TargetPlatform.android) {
  await plugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}
```
**Alasan:** Mekanisme izin disesuaikan dengan platform web dan Android.
#### Contoh salah
```dart
await plugin.requestNotificationsPermission(); // API generik tanpa platform
```
**Kesalahan:** Memanggil API izin tanpa mempertimbangkan platform yang didukung.
**Rujukan teknis:**
- `lib/shared/notifikasi/notifikasi_service.dart` — `inisialisasi()` dan `mintaIzin()`.
### 5. ID Notifikasi
1. Gunakan ID yang unik untuk setiap notifikasi agar tidak terjadi benturan ID.
2. ID dapat menggunakan UUID versi 4 (`uuid.v4`) atau ID dari item terkait apabila nilainya sudah unik.
3. Jangan menggunakan tanggal sebagai ID notifikasi.
#### Contoh benar
```dart
final notifId = int.tryParse(idJadwal)?.abs() ?? idJadwal.hashCode.abs();
await plugin.cancel(id: notifId);
```
**Alasan:** ID numerik konsisten dibuat dari ID item, bukan tanggal.
#### Contoh salah
```dart
final notifId = DateTime.now().millisecondsSinceEpoch;
await plugin.show(notifId, judul, isi, details);
```
**Kesalahan:** Menggunakan tanggal sebagai ID notifikasi, sehingga ID berubah setiap waktu dan benturan ID tidak terkontrol.
**Rujukan teknis:**
- `lib/shared/notifikasi/notifikasi_service.dart` — `_notifId(String id)`.
- `pubspec.yaml` — `uuid: ^4.6.0`.


// ============================================================
// FILE: .agents/rules/global/aturan_pemanfaatan_sdk_dan_paket.md
// ============================================================

# Aturan Pemanfaatan SDK dan Paket Flutter
## 1. Tujuan
Memastikan pemanfaatan SDK, paket, dan fitur yang tersedia dalam proyek Flutter dilakukan secara tepat, konsisten, dan sesuai dengan mekanisme resmi yang telah disediakan.
Implementasi wajib mengutamakan pemanfaatan fitur dan API yang sudah tersedia daripada membuat mekanisme sendiri yang memiliki fungsi serupa.
## 2. Skills
1. **Wajib membaca Skills sebelum implementasi.**
   - Sebelum menulis atau mengubah kode, periksa dan baca Skills yang tersedia di folder `.agents/skills`.
   - Identifikasi Skills yang relevan dengan paket, SDK, atau fitur yang akan digunakan.
   - Load dan ikuti panduan dari Skills terkait sebelum memulai implementasi.
2. **Utamakan mekanisme yang sudah tersedia.**
   - Gunakan API, utilitas, pola implementasi, dan mekanisme yang telah dijelaskan dalam Skills.
   - Jangan membuat ulang mekanisme yang sebenarnya sudah tersedia dan dapat digunakan.
   - Jangan mengabaikan panduan Skills tanpa alasan teknis yang jelas.
## 3. Aturan Pemanfaatan Paket dan API
### 3.1. Pengaturan Jarak pada Row dan Column
- Gunakan properti `spacing` pada `Row` dan `Column` untuk mengatur jarak antar-anak secara konsisten.
- Jangan menggunakan beberapa `SizedBox` hanya untuk mengatur jarak antar-anak yang memiliki jarak seragam.
- Gunakan `SizedBox` apabila terdapat kebutuhan jarak khusus pada anak tertentu yang tidak dapat dipenuhi secara tepat menggunakan `spacing`.
### 3.2. Pengurutan Data Koleksi
- Gunakan fungsi `sorted` dari paket `collection` untuk mengurutkan data dalam koleksi.
- Jangan membuat mekanisme pengurutan sendiri apabila fungsi tersebut sudah memenuhi kebutuhan.
#### Contoh benar
```dart
import 'package:collection/collection.dart';
final terurut = daftarBahanBakar.sorted((a, b) => a.tanggal.compareTo(b.tanggal));
```
**Alasan:** Pengurutan menggunakan `sorted` dari paket `collection`.
#### Contoh salah
```dart
final terurut = [...daftarBahanBakar]..sort((a, b) => a.tanggal.compareTo(b.tanggal));
```
**Kesalahan:** Membuat mekanisme pengurutan manual padahal `sorted` sudah tersedia.
**Rujukan teknis:**
- `pubspec.yaml` — `collection: ^1.19.1`.
- `pub-cache/.../collection-*/lib/collection.dart`.
### 3.3. Pencarian Satu Item dalam Koleksi
- Gunakan fungsi `firstWhereOrNull` dari paket `collection` untuk mencari satu item berdasarkan kondisi tertentu.
- Fungsi ini digunakan ketika hasil pencarian mungkin tidak ditemukan dan nilai `null` perlu dikembalikan tanpa menimbulkan exception.
#### Contoh benar
```dart
import 'package:collection/collection.dart';
final item = daftar.firstWhereOrNull((e) => e.id == idDicari);
```
**Alasan:** Pencarian mengembalikan `null` tanpa exception ketika item tidak ditemukan.
#### Contoh salah
```dart
final item = daftar.firstWhere((e) => e.id == idDicari);
```
**Kesalahan:** `firstWhere` melempar exception ketika item tidak ditemukan.
**Rujukan teknis:**
- `pubspec.yaml` — `collection: ^1.19.1`.
### 3.4. Pengambilan Item Berdasarkan Nilai Maksimum
- Gunakan fungsi `maxBy` dari paket `collection` untuk mengambil satu item yang memiliki nilai maksimum berdasarkan properti atau kriteria tertentu.
- Jangan menggunakan `firstWhereOrNull` untuk kebutuhan ini karena keduanya memiliki tujuan yang berbeda.
#### Contoh benar
```dart
import 'package:collection/collection.dart';
final terbaru = daftar.maxBy((e) => e.tanggal);
```
**Alasan:** `maxBy` mengambil item dengan nilai maksimum berdasarkan kriteria.
#### Contoh salah
```dart
final terbaru = daftar.firstWhereOrNull((e) => e.tanggal == daftar.map((x) => x.tanggal).reduce((a, b) => a.isAfter(b) ? a : b));
```
**Kesalahan:** Menggunakan `firstWhereOrNull` untuk kebutuhan nilai maksimum, padahal `maxBy` lebih tepat.
**Rujukan teknis:**
- `pubspec.yaml` — `collection: ^1.19.1`.
### 3.5. Menampilkan Gambar dari Jaringan
- Gunakan `CachedNetworkImage` dari paket `cached_network_image` untuk menampilkan gambar yang bersumber dari jaringan.
- Jangan menggunakan `Image.network` untuk kebutuhan tersebut.
- Implementasi wajib menyediakan:
  - `placeholder` untuk menampilkan kondisi ketika gambar sedang dimuat.
  - `errorWidget` untuk menangani dan menampilkan kondisi ketika gambar gagal dimuat.
- Ikuti pola implementasi resmi pada folder `example` paket `cached_network_image`, dengan mengacu pada `example.md` apabila tersedia.
#### Contoh benar
```dart
import 'package:cached_network_image/cached_network_image.dart';
CachedNetworkImage(
  imageUrl: urlGambar,
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (context, url, error) => const Icon(Icons.error),
);
```
**Alasan:** Gambar jaringan ditampilkan dengan cache, placeholder, dan error widget.
#### Contoh salah
```dart
Image.network(urlGambar);
```
**Kesalahan:** Tidak menggunakan cache dan tidak menyediakan placeholder/error widget.
**Rujukan teknis:**
- `pubspec.yaml` — `cached_network_image: ^4.0.6`.
## 4. Aturan Berdasarkan Paket
### 4.1. UUID
**Tujuan:** Menghasilkan ID unik dengan mekanisme yang telah disediakan oleh paket `uuid`.
Ketentuan:
1. Gunakan `uuid.v4()` dari paket `uuid` untuk menghasilkan ID unik.
2. Dilarang membuat ID secara manual.
3. Dilarang menggunakan tanggal, waktu, timestamp, atau kombinasi nilai lainnya sebagai pengganti UUID.
#### Contoh benar
```dart
import 'package:uuid/uuid.dart';
final id = const Uuid().v4();
```
**Alasan:** ID dihasilkan oleh generator UUID versi 4.
#### Contoh salah
```dart
final id = DateTime.now().millisecondsSinceEpoch.toString();
```
**Kesalahan:** Menggunakan timestamp sebagai ID, bertentangan dengan aturan pembuatan ID unik.
**Rujukan teknis:**
- `pubspec.yaml` — `uuid: ^4.6.0`.
### 4.2. URL Launcher
**Tujuan:** Memastikan pembukaan URL, tautan, email, dan berkas menggunakan mekanisme resmi paket `url_launcher` dengan penanganan kegagalan yang tepat.
#### A. Membuka URL
1. Gunakan `launchUrl` untuk membuka URL.
2. Buat objek `Uri` menggunakan metode yang sesuai:
   - `Uri.parse`
   - `Uri.tryParse`
   - `Uri(...)`
   - `Uri.file`
3. Periksa nilai balik `bool` dari `launchUrl`.
4. Jika hasilnya `false`, lempar `Exception` agar kegagalan tidak diabaikan.
5. Bungkus operasi pembukaan URL dengan `try`/`catch` untuk menangani exception yang mungkin terjadi.
#### B. Menentukan Mode Peluncuran
Pilih `LaunchMode` berdasarkan kebutuhan dan konteks penggunaan:
- `externalApplication`
- `inAppBrowserView`
- `inAppWebView`
- `externalNonBrowserApplication`
Untuk universal link:
1. Coba buka menggunakan `externalNonBrowserApplication` terlebih dahulu.
2. Jika gagal, lakukan fallback menggunakan `inAppBrowserView`.
Jangan menggunakan mode peluncuran secara sembarangan tanpa mempertimbangkan jenis URL dan pengalaman pengguna yang diharapkan.
#### C. Konfigurasi Browser dan WebView
Gunakan konfigurasi sesuai kebutuhan:
- `BrowserConfiguration`, misalnya `showTitle`.
- `WebViewConfiguration`, misalnya `headers`, `enableJavaScript`, dan `enableDomStorage`.
- `webOnlyWindowName` untuk menentukan target jendela pada platform web.
Jangan menambahkan konfigurasi yang tidak diperlukan.
#### D. Memeriksa Dukungan Fitur
- Gunakan `canLaunchUrl` untuk memeriksa ketersediaan atau dukungan URL tertentu sebelum menampilkan aksi kepada pengguna.
- Terapkan terutama pada URL yang bergantung pada aplikasi eksternal, seperti panggilan telepon.
- Jangan menampilkan aksi yang tidak dapat dijalankan apabila ketersediaannya dapat diperiksa terlebih dahulu.
#### E. Membuka Email
- Gunakan `Uri` dengan konfigurasi:
  - `scheme: 'mailto'`
  - `path` berisi alamat email tujuan.
  - `query` berisi hasil fungsi `encodeQueryParameters`.
- Implementasikan `encodeQueryParameters` menggunakan `Uri.encodeComponent` untuk mengamankan parameter query.
#### F. Membuka Berkas
- Gunakan `Uri.file` untuk membentuk URI dari lokasi berkas.
- Pastikan berkas benar-benar tersedia sebelum memanggil `launchUrl`.
- Tangani kondisi ketika berkas tidak ditemukan atau gagal dibuka.
#### G. Tautan Deklaratif
- Gunakan widget `Link` dengan properti `uri` dan `target` untuk kebutuhan tautan deklaratif.
- Jangan mengganti mekanisme ini dengan implementasi manual apabila widget tersebut sudah memenuhi kebutuhan.
#### H. Menutup WebView
- Gunakan `closeInAppWebView()` apabila WebView yang dibuka melalui aplikasi perlu ditutup secara programatik.
#### I. Referensi Implementasi
- Ikuti contoh resmi pada folder `example` paket `url_launcher`.
- Gunakan `example.md` sebagai referensi apabila tersedia.
- Jangan mengasumsikan API atau konfigurasi berdasarkan ingatan apabila dokumentasi paket sudah tersedia.
### 4.3. Timezone
**Tujuan:** Memastikan pengolahan waktu dan zona waktu dilakukan menggunakan database zona waktu yang benar serta sesuai dengan platform.
#### A. Inisialisasi Database Zona Waktu
1. Inisialisasi database zona waktu sebelum menggunakan fitur yang bergantung padanya.
2. Gunakan `tz.initializeTimeZones()` untuk menginisialisasi database.
3. Gunakan `tz.getLocation('...')` atau `tz.timeZoneDatabase` untuk menentukan lokasi zona waktu.
4. Gunakan `tz.TZDateTime` untuk melakukan pengolahan dan konversi waktu berdasarkan zona waktu yang ditentukan.
5. Contoh konversi: `tz.TZDateTime.from(waktu, tz.local)`.
Jangan memanggil `tz.getLocation` atau menggunakan `tz.TZDateTime` sebelum database zona waktu selesai diinisialisasi.
#### Contoh benar
```dart
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
tz.initializeTimeZones();
final lokasi = tz.getLocation('Asia/Jakarta');
final waktuLokal = tz.TZDateTime.from(waktuUtc, lokasi);
```
**Alasan:** Database zona waktu diinisialisasi sebelum `tz.getLocation` dan `tz.TZDateTime` digunakan.
#### Contoh salah
```dart
final lokasi = tz.getLocation('Asia/Jakarta'); // database belum diinisialisasi
```
**Kesalahan:** Memanggil `tz.getLocation` sebelum inisialisasi database zona waktu.
**Rujukan teknis:**
- `pubspec.yaml` — `timezone: ^0.11.2`.
#### B. Inisialisasi Berdasarkan Platform
Gunakan mekanisme inisialisasi yang sesuai dengan platform:
- **Web:** Gunakan `initializeTimeZone()` dari `package:timezone/browser.dart`.
- **VM/Standalone:** Gunakan `tz.initializeTimeZones()` dari `package:timezone/data/latest.dart`.
Pastikan hanya mekanisme inisialisasi yang sesuai dengan platform target yang digunakan.
#### C. Penanganan Kesalahan
1. Bungkus proses inisialisasi dengan `try`/`catch`.
2. Catat kegagalan inisialisasi agar penyebabnya dapat ditelusuri.
3. Pada platform web, tangani `TimeZoneInitException` apabila exception tersebut terjadi.
4. Jangan melanjutkan proses yang membutuhkan database zona waktu apabila inisialisasi gagal.
### 4.4. Sqflite
**Tujuan:** Memastikan inisialisasi database SQLite menggunakan factory yang sesuai dengan platform target.
Ketentuan:
1. Panggil `sqfliteFfiInit()` sebelum menggunakan database melalui implementasi FFI.
2. Atur `databaseFactory` sesuai platform:
   - Desktop: gunakan `databaseFactoryFfi`.
   - Web: gunakan `databaseFactoryFfiWeb`.
3. Pastikan inisialisasi dan pengaturan `databaseFactory` selesai sebelum database dibuka.
4. Jangan membuka database sebelum mekanisme inisialisasi platform selesai dilakukan.
5. Ikuti contoh implementasi pada folder `example` dari paket terkait:
   - `sqflite`
   - `sqflite_common_ffi`
   - `sqflite_common_ffi_web`
Gunakan implementasi yang sesuai dengan platform dan paket yang benar-benar digunakan dalam proyek.
#### Contoh benar (desktop)
```dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
sqfliteFfiInit();
databaseFactory = databaseFactoryFfi;
```
**Alasan:** Factory FFI diinisialisasi sebelum database dibuka.
#### Contoh salah
```dart
final db = await openDatabase('app.db'); // factory belum diatur
```
**Kesalahan:** Database dibuka sebelum inisialisasi factory platform.
**Rujukan teknis:**
- `lib/main.dart` — pengaturan factory berdasarkan platform.
- `pubspec.yaml` — `sqflite`, `sqflite_common_ffi`, `sqflite_common_ffi_web`.
### 4.5. adaptive_dialog
**Tujuan:** Menyeragamkan mekanisme dialog konfirmasi agar konsisten dan mendukung tampilan adaptif sesuai platform.
Ketentuan:
1. Wajib menggunakan paket `adaptive_dialog` untuk dialog konfirmasi.
2. Gunakan `showOkCancelAlertDialog` untuk konfirmasi dengan pilihan OK dan Cancel.
3. Sesuaikan parameter dialog dengan konteks tindakan yang dikonfirmasi:
   - `context`: BuildContext yang aktif.
   - `title`: Judul konfirmasi.
   - `message`: Penjelasan tindakan.
   - `okLabel`: Label tombol persetujuan.
   - `cancelLabel`: Label tombol pembatalan.
   - `isDestructiveAction`: Gunakan `true` untuk tindakan destruktif, seperti menghapus data.
4. Jangan membuat dialog konfirmasi manual apabila mekanisme dari `adaptive_dialog` sudah memenuhi kebutuhan.
**Contoh implementasi:**
```dart
showOkCancelAlertDialog(
  context: context,
  title: 'Hapus Data?',
  message: 'Data yang dihapus tidak dapat dikembalikan.',
  okLabel: 'Hapus',
  cancelLabel: 'Batal',
  isDestructiveAction: true,
);
```


// ============================================================
// FILE: .agents/rules/global/aturan_riverpod.md
// ============================================================

# Aturan Riverpod
## 1. Penggunaan riverpod_generator
Setiap provider dan notifier wajib dibuat menggunakan `riverpod_generator`.
#### Contoh benar
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'pengguna_provider.g.dart';
@riverpod
Future<List<Pengguna>> daftarPengguna(Ref ref) async {
  return ref.watch(repositoryProvider).ambilSemua();
}
```
**Alasan:** Provider dibuat dengan anotasi `@riverpod` dan file `.g.dart` dihasilkan oleh generator.
#### Contoh salah
```dart
final daftarPenggunaProvider = FutureProvider<List<Pengguna>>((ref) async {
  return ref.watch(repositoryProvider).ambilSemua();
});
```
**Kesalahan:** Provider dibuat manual dengan `FutureProvider`, bukan melalui `riverpod_generator`.
**Rujukan teknis:**
- `pubspec.yaml` — `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`.
- `lib/fitur/*/provider/*.dart` dan `*.g.dart`.
## 2. Pengaturan siklus hidup state
- Gunakan `@Riverpod(keepAlive: true)` untuk state yang perlu dipertahankan dan tidak boleh otomatis dihapus ketika tidak lagi digunakan.
- Gunakan `@riverpod` untuk state yang tidak perlu dipertahankan sehingga provider menggunakan mekanisme auto-dispose.
## 3. Penggunaan `ref.watch`
`ref.watch` hanya boleh digunakan di dalam `build`, notifier, dan provider.
- **Di dalam `build`:** tangani status `AsyncValue` dengan urutan pemeriksaan berikut:
  1. Periksa `.isLoading` terlebih dahulu.
  2. Setelah itu, periksa `.hasError`.
  3. Jika kedua kondisi tersebut tidak terpenuhi, ambil data menggunakan `.requireValue`.
- **Di dalam notifier dan provider:** jika sumber data bersifat asynchronous, gunakan `ref.watch(provider.future)`.
- **Larangan:** saat menggunakan `ref.watch`, jangan mengambil nilai menggunakan `.value` atau `.valueOrNull`.
## 4. Penggunaan `ref.read`
- Jika provider yang dibaca menghasilkan data asynchronous dan nilai datanya diperlukan, gunakan `.future` serta `await`.
  Contoh:
  ```dart
  final state = await ref.read(provider.future);
  ```
- Jika fungsi notifier mengembalikan `Future`, panggil fungsi tersebut menggunakan `await`.
  Contoh:
  ```dart
  await ref.read(provider).hapus();
  ```
- Untuk mengambil hasil provider asynchronous di luar `build`, gunakan `.future`. Jangan menangani status `.isLoading` dan `.hasError` secara manual.
  Contoh:
  ```dart
  final data = await ref.read(provider.future);
  ```
## 5. Penggunaan `ref.listen`
`ref.listen` hanya boleh digunakan di dalam `build`.
- Gunakan `.value` untuk mengambil nilai dari `previous` dan `next`.
- Untuk nilai `previous`, gunakan `previous.value` atau `previous?.value`, sesuai dengan nullability variabelnya.
- Untuk nilai `next`, periksa `.isLoading` dan `.hasError` sebelum mengakses atau memproses `.value`.
## 6. Penggunaan `ref.listenManual`
Gunakan `ref.listenManual` hanya di luar `build`. Sebelum menggunakannya, periksa cara penggunaan dan ketentuannya pada source code SDK Riverpod.
## 7. Pemasangan ProviderScope
Setiap proyek yang menggunakan Riverpod wajib memasang scope Riverpod di `main.dart`.
- Gunakan `ProviderScope` untuk penggunaan normal.
- Gunakan `UncontrolledProviderScope` apabila proyek mengelola `ProviderContainer` secara manual.
## 8. Penggunaan `ref.refresh`
Gunakan `ref.refresh(provider)` untuk langsung mengevaluasi ulang provider dan memperoleh hasil evaluasi terbarunya.
- Ketika UI sedang menampilkan error dan provider perlu dicoba kembali, gunakan `ref.refresh`, bukan `ref.invalidate`.
- Gunakan pola berikut:
  ```dart
  final _ = ref.refresh(provider);
  ```
## 9. Optimistic update pada notifier
Setiap optimistic update di dalam notifier wajib mengikuti urutan berikut:
1. Perbarui state terlebih dahulu.
2. Jalankan operasi ke database.
3. Jika operasi database menghasilkan `Exception`, kembalikan state ke data sebelumnya (_rollback_), kemudian teruskan kembali exception menggunakan `rethrow`.
Contoh:
```dart
state = AsyncValue.data(listBaru);
try {
  await ref.read(baseOpSqfliteProvider).tambah(...);
} on Exception {
  state = AsyncValue.data(dataLama);
  rethrow;
}
```
## 10. Pembersihan resource dengan `ref.onDispose`
Gunakan `ref.onDispose(() { ... })` di dalam provider untuk membersihkan resource yang dibuat oleh provider tersebut, seperti controller, subscription, dan timer.
## 11. Membatasi rebuild dengan `select`
Untuk membatasi rebuild UI, gunakan `ref.watch(provider.select((state) => state.field))` ketika UI hanya membutuhkan sebagian state. Dengan demikian, UI hanya bergantung pada field yang dipilih.


// ============================================================
// FILE: .agents/rules/global/aturan_testing.md
// ============================================================

# Aturan Testing
## 1. Cakupan Pengujian
- Setiap method `public` yang terdapat di dalam file `state` wajib memiliki pengujian.
- Pastikan seluruh method `public` pada file tersebut tercakup dalam file test yang sesuai.
## 2. Paket Testing dan Mocking
- Gunakan paket `mockito` untuk kebutuhan testing dan mocking.
- Jangan menggunakan paket mocking lain sebagai pengganti `mockito`.
#### Contoh benar
```dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
@GenerateMocks([BaseOpSqflite])
void main() {}
```
**Alasan:** Mocking menggunakan paket `mockito` sesuai standar proyek.
#### Contoh salah
```dart
import 'package:mocktail/mocktail.dart';
class MockDb extends Mock implements BaseOpSqflite {}
```
**Kesalahan:** Menggunakan paket mocking lain padahal proyek mewajibkan `mockito`.
**Rujukan teknis:**
- `pubspec.yaml` — dependensi pengembangan testing.
- `test/*_state_test.dart` — pola pengujian state proyek.
## 3. Struktur File Test
Struktur dan penamaan file test wajib konsisten dengan konvensi proyek.
Pada proyek ini, file test ditempatkan secara datar di folder `test/` dengan penamaan `<nama_fitur>_state_test.dart`, bukan dengan menyalin struktur folder `lib/fitur/...`.
**Contoh:**
Jika file sumber berada di:
```text
lib/fitur/bahan_bakar/state/bahan_bakar_state.dart
```
Maka file test wajib berada di:
```text
test/bahan_bakar_state_test.dart
```
Pastikan penamaan file test menggunakan akhiran `_state_test.dart` dan sesuai dengan nama fitur yang diuji. Jangan membuat struktur folder `test/fitur/...` yang tidak sesuai dengan konvensi proyek.
## 4. Penggunaan Dummy Data
- Setiap pengujian `state` wajib menggunakan dummy data yang tersedia di folder `dummy`.
- Jangan membuat data pengujian secara manual apabila dummy data yang sesuai sudah tersedia.
- Gunakan dummy data sebagai sumber data ketika membuat instance state dalam pengujian.
**Contoh:**
```dart
final state = BahanBakarState(
  listBahanBakar: dummyBahanBakar,
);
```


// ============================================================
// FILE: .agents/rules/global/model_agent.md
// ============================================================

# model_agent.md
## OpenRouter
Karena pada gambar tidak dicantumkan skor benchmark (seperti MMLU atau Elo), peringkat di bawah ini diestimasikan berdasarkan konvensi penamaan model AI, yaitu ukuran parameter dalam Billion (B) serta label tingkatan seperti Ultra, Super, Lightning, dan Nano/Small.
### Tingkat Tertinggi (Flagship / Parameter Terbesar)
Model pada tingkat ini memiliki kapabilitas penalaran paling kuat, ukuran paling besar, atau merupakan model unggulan.
Tidak ada model yang tercantum pada tingkat ini di teks asli.
### Tingkat Menengah Atas (Large / Dioptimalkan)
Model berukuran besar (MoE — Mixture of Experts) atau model yang dioptimalkan untuk kecepatan tinggi.
1. Xing4.0 29B A4B — model 29 miliar parameter dengan 4B active parameters.
### Tingkat Menengah (Spesialis / Omni)
2. Inkling — model basis standar.
3. North Mini Code — model khusus untuk coding dengan ukuran mini.
### Tingkat Terendah / Ringan (Small / Tiny)
Model pada tingkat ini sangat cepat dan ringan, tetapi kapasitas penalaran kompleksnya lebih rendah.
4. Inkling Small — versi kompak dari Inkling.
5. Flint — model basis/ringan.
6. LFM2.5-2.6B — hanya memiliki 2,6 miliar parameter; paling kecil dalam daftar ini.
## KIlo Code


// ============================================================
// FILE: .agents/rules/global/optimasi_boilerplate.md
// ============================================================

# Aturan Optimasi Boilerplate
## 1. State dan Model
- Wajib menggunakan `Freezed` untuk seluruh pembuatan state dan model.
#### Contoh benar
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'bahan_bakar_state.freezed.dart';
@freezed
class BahanBakarState with _$BahanBakarState {
  const factory BahanBakarState({
    required List<BahanBakar> listBahanBakar,
  }) = _BahanBakarState;
}
```
**Alasan:** State dibuat dengan `@freezed` dan menghasilkan file `.freezed.dart`.
#### Contoh salah
```dart
class BahanBakarState {
  final List<BahanBakar> listBahanBakar;
  BahanBakarState({required this.listBahanBakar});
}
```
**Kesalahan:** State dibuat manual tanpa `Freezed`.
**Rujukan teknis:**
- `pubspec.yaml` — `freezed`, `freezed_annotation`.
- `lib/fitur/*/state/*.dart` dan `*.freezed.dart`.
## 2. Pemanfaatan Paket
- Cari paket yang tersedia di [pub.dev](https://pub.dev/) menggunakan tool `websearch`.
- Cari paket yang memiliki tujuan atau fungsi serupa dengan kode yang digunakan dalam proyek.
- Gunakan kata kunci pencarian yang umum dan tidak terlalu spesifik, misalnya:
  - Paket loading.
  - Paket stream.
  - Paket notifikasi.
  - Paket untuk kebutuhan lainnya yang relevan.
- Lakukan pencarian secara menyeluruh terhadap paket-paket yang relevan.
- Kembalikan hasil pencarian kepada pengguna dalam bentuk daftar tautan paket pub.dev.
## 3. Penggunaan Kembali Fungsi
- Jika terdapat kode dengan fungsi atau tujuan yang sama di beberapa tempat, pertimbangkan untuk memindahkannya ke satu file khusus.
- File-file yang membutuhkan fungsi tersebut cukup memanggil implementasi dari file khusus tersebut.
- Hindari menulis ulang kode yang sebenarnya dapat digunakan bersama.
## 4. Penerapan Abstraksi
- Jangan membuat abstraksi hanya untuk mengurangi jumlah kode yang ditulis.
- Setiap abstraksi harus memberikan manfaat yang jelas, seperti:
  - Memungkinkan penggunaan ulang kode.
  - Memisahkan tanggung jawab.
  - Mempermudah pengujian.
## 5. Pemanfaatan Fitur Bawaan
- Sebelum membuat implementasi secara manual, periksa terlebih dahulu apakah Flutter, Dart, atau paket yang sudah digunakan menyediakan fitur atau fungsi yang dibutuhkan.
- Gunakan fitur bawaan yang sudah tersedia dan memadai.
- Jangan membuat ulang mekanisme yang sebenarnya sudah disediakan oleh SDK atau paket yang digunakan.
## 6. Efisiensi Jumlah Kode
- Usahakan menggunakan jumlah kode yang efisien tanpa mengurangi keterbacaan, kejelasan, dan kemudahan pemeliharaan.
- Pertahankan tujuan dan perilaku kode yang sudah ada.
- Jangan mengubah fungsi maupun hasil yang diharapkan dari kode tersebut.
## 7. Pemanfaatan SDK
- Sebelum membuat kode secara manual, cari terlebih dahulu apakah implementasi atau fungsi yang dibutuhkan sudah tersedia di SDK.
- Lakukan pencarian pada SDK atau sumber lokal yang tersedia terlebih dahulu.
- Jika tidak ditemukan secara lokal, cari implementasi atau fungsi serupa di [pub.dev](https://pub.dev/).
## 8. Struktur Folder
Gunakan folder `notifier` dan `provider` sesuai tanggung jawab masing-masing:
- **Folder `notifier`**: khusus menyimpan file yang berisi class Notifier, termasuk Notifier yang menyediakan fungsi `read`.
- **Folder `provider`**: khusus menyimpan file provider yang tidak memiliki fungsi `read`.
## 9. Enum yang Ditampilkan kepada Pengguna
- Setiap Enum yang nilainya ditampilkan kepada pengguna wajib memiliki getter `label` melalui extension.
- Tambahkan getter `icon` apabila diperlukan.
- Gunakan extension khusus untuk setiap Enum agar representasi nilai dapat dikelola secara terpusat.
Contoh:
```dart
extension SortBahanBakarExtension on SortBahanBakarEnum {
  String get label {
    switch (this) {
      // Sesuaikan label dengan setiap nilai Enum.
    }
  }
}
```


// ============================================================
// FILE: .agents/rules/global/optimasi_bug_runtime.md
// ============================================================

# Aturan Optimasi Bug Runtime
**Path file:** `prompt/aturan/optimasi_bug_runtime.md`
## Tujuan
Aturan ini digunakan untuk mencegah kesalahan runtime, kesalahan pengelolaan data, kebocoran sumber daya, kesalahan proses asynchronous, serta masalah lain yang dapat menyebabkan aplikasi Flutter tidak berjalan sebagaimana mestinya.
AI wajib mengikuti aturan ini ketika membaca, membuat, mengubah, atau memperbaiki kode Dart dan Flutter di dalam proyek.
## Aturan
### 1. Penanganan Nilai Null
Selalu tangani kemungkinan nilai `null` sesuai dengan kebutuhan dan logika program.
Ketentuan:
- Hindari penggunaan operator `!` untuk memaksakan nilai nullable agar dianggap tidak null.
- Hindari penggunaan casting `as` untuk memaksakan nilai nullable menjadi tipe non-null tanpa validasi.
- Gunakan operator `??` untuk memberikan nilai pengganti ketika nilai di sebelah kirinya `null`, selama nilai pengganti tersebut sesuai dengan kebutuhan dan logika program.
- Utamakan `??` untuk penanganan null sederhana daripada membuat percabangan `if` yang menghasilkan perilaku sama.
- Gunakan `??=` untuk mengisi variabel hanya ketika nilainya `null`, sesuai rekomendasi linter `prefer_conditional_assignment`.
- Jangan memberikan nilai pengganti secara sembarangan hanya untuk menghilangkan kemungkinan `null`.
- Jangan menyembunyikan kesalahan atau kondisi data tidak valid dengan memberikan nilai default yang tidak sesuai.
- Jika nilai `null` menunjukkan bahwa data tidak valid atau tidak tersedia, tangani kondisi tersebut secara eksplisit. Jangan mengubahnya menjadi nilai lain yang dapat menyebabkan kesalahan logika.
Contoh penggunaan yang direkomendasikan:
```dart
return val ?? true;
```
Bentuk berikut juga benar, tetapi tidak perlu digunakan apabila hanya menghasilkan perilaku yang sama tanpa menambahkan logika:
```dart
if (val == null) {
  return true;
}
return val;
```
### 2. Parsing dan Konversi Tipe Data
Hindari penggunaan `dynamic` dan parsing yang berisiko menimbulkan kesalahan runtime.
Ketentuan:
- Gunakan `tryParse` daripada `parse` ketika mengonversi String menjadi tipe data seperti `int`, `double`, dan tipe lain yang menyediakan metode `tryParse`.
- Hindari menggunakan `dynamic` sebagai tipe variabel apabila tipe datanya dapat ditentukan secara jelas.
- Jangan melakukan konversi tipe secara paksa tanpa memastikan tipe data sumber.
- Tangani hasil parsing yang gagal atau menghasilkan `null` sesuai kebutuhan program.
- Jangan memberikan nilai default secara sembarangan ketika parsing gagal.
- Jika nilai berasal dari data eksternal, pastikan format dan tipe datanya divalidasi sebelum digunakan.
Contoh:
```dart
final nilai = int.tryParse(dataString);
```
Jangan menggunakan:
```dart
final nilai = int.parse(dataString);
```
**Penanganan parameter constructor dan variabel privat yang nullable:**
- Jika nilai nullable berasal dari parameter constructor atau variabel privat, salin terlebih dahulu nilainya ke variabel lokal sebelum melakukan pemeriksaan null, terutama ketika nilai tersebut akan digunakan lebih lanjut setelah pemeriksaan.
- Lakukan pemeriksaan null terhadap variabel lokal tersebut.
- Gunakan variabel lokal yang sudah dipastikan tidak null untuk proses berikutnya.
- Jangan menggunakan `!` atau `as` hanya untuk mengatasi kesulitan promosi tipe data.
Contoh:
```dart
final nilai = _nilai;
if (nilai == null) {
  return;
}
// Gunakan nilai setelah dipastikan tidak null.
```
### 3. Model dan Struktur Data Database
Setiap struktur baris (row) database harus memiliki representasi model data yang jelas.
Ketentuan:
- Buat model untuk merepresentasikan struktur data dari setiap tabel database yang digunakan.
- Nama tabel dan nama kolom harus didefinisikan secara jelas.
- Gunakan model untuk membaca, mengolah, dan menyimpan data database.
- Hindari penggunaan Map database secara langsung dan berulang di berbagai bagian aplikasi apabila pemetaan tersebut dapat ditangani melalui model atau lapisan repository.
- Pastikan pemetaan antara nama kolom database dan properti model sesuai dengan struktur tabel sebenarnya.
- Jangan menggunakan nama tabel atau kolom yang tidak sesuai dengan skema database.
### 4. Pengecekan `mounted`
Setiap operasi asynchronous yang berhubungan dengan UI harus memperhatikan status `mounted`.
Ketentuan:
- Setelah `await` di dalam `State`, periksa `mounted` sebelum melanjutkan operasi yang menggunakan `setState`, `context`, atau sumber daya milik State.
- Jika widget sudah tidak terpasang, hentikan proses lanjutan yang membutuhkan widget tersebut.
- Untuk penggunaan `BuildContext` di luar State, gunakan `context.mounted` sebelum mengakses context setelah operasi asynchronous.
- Jangan memanggil `setState` setelah widget tidak lagi terpasang.
- Jangan menggunakan `BuildContext` yang sudah tidak valid.
Contoh:
```dart
await prosesData();
if (!mounted) return;
setState(() {
  // Perbarui UI.
});
```
Pengecekan `mounted` tidak perlu dipaksakan apabila kode setelah `await` hanya menjalankan proses yang tidak bergantung pada State, UI, atau BuildContext.
### 5. Future di Dalam `build()`
Jangan membuat atau menjalankan Future baru secara langsung di dalam metode `build()`.
Ketentuan:
- Jangan memanggil fungsi asynchronous secara langsung di dalam `build()` untuk menghasilkan Future baru pada setiap rebuild.
- Jangan menempatkan proses pengambilan data asynchronous yang menyebabkan Future terus dibuat ulang ketika widget melakukan rebuild.
- Siapkan Future pada tempat yang sesuai, misalnya melalui `initState`, provider, atau mekanisme pengelolaan state yang sudah digunakan proyek.
- Pastikan Future yang digunakan oleh `FutureBuilder` memiliki referensi yang stabil dan tidak dibuat ulang tanpa kebutuhan.
Tujuannya adalah mencegah proses asynchronous berjalan berulang akibat rebuild yang tidak diperlukan.
### 6. Try/Catch dan Penanganan Error
Operasi yang berpotensi menghasilkan error runtime wajib memiliki penanganan error yang sesuai.
Prioritaskan operasi yang berhubungan dengan:
- Database.
- Jaringan atau API.
- File dan penyimpanan.
- Platform channel.
- Parsing dan pemrosesan data eksternal.
- Operasi asynchronous yang berpotensi gagal.
Ketentuan:
- Gunakan `try/catch` untuk menangani error pada operasi tersebut.
- Setiap blok `catch` wajib menggunakan logger `L.e`.
- Setelah mencatat error, teruskan kembali error menggunakan `rethrow` agar lapisan pemanggil, termasuk UI, dapat menangani kegagalan tersebut.
- Jangan menangkap error lalu mengabaikannya tanpa penanganan yang jelas.
- Jangan mengubah error menjadi nilai default yang dapat menyembunyikan kegagalan operasi.
- Tempatkan penanganan error pada lapisan yang tepat.
- Hindari menangkap dan mencatat error yang sama berulang kali pada banyak lapisan apabila tidak memberikan informasi tambahan.
Pengecualian untuk Future yang dijalankan tanpa `await`:
- Future yang berjalan menggunakan `unawaited` tetap wajib memiliki penanganan error.
- Jika proses tersebut merupakan inisialisasi UI, tangani kegagalan pada batas inisialisasi dan tampilkan kondisi error melalui state UI.
- Jangan melakukan `rethrow` ke Future yang tidak memiliki pemanggil atau mekanisme penanganan error.
### 7. Dispose dan Pengelolaan Sumber Daya
Pastikan seluruh sumber daya yang membutuhkan pelepasan dikelola dengan benar.
Ketentuan:
- Tutup seluruh controller yang sudah tidak digunakan melalui `dispose()`.
- Hentikan `StreamSubscription` melalui `cancel()`.
- Hentikan `Timer` melalui `cancel()`.
- Lepaskan listener yang sudah didaftarkan.
- Hentikan atau lepaskan observer yang sudah didaftarkan.
- Pastikan sumber daya tidak dibiarkan aktif setelah widget atau objek pemiliknya tidak digunakan.
- Jangan memanggil `setState` setelah widget tidak lagi terpasang.
- Pastikan proses pembersihan sumber daya tidak dilakukan berulang kali secara tidak aman.
Contoh sumber daya yang perlu diperhatikan:
- `TextEditingController`.
- `ScrollController`.
- `FocusNode`.
- `AnimationController`.
- `StreamSubscription`.
- `Timer`.
- Listener dan observer.
### 8. Transaksi Database dan Rollback
Operasi perubahan data database wajib memperhatikan konsistensi dan integritas data.
Ketentuan:
- Gunakan transaksi untuk operasi `insert`, `update`, dan `delete` yang menjadi bagian dari suatu proses bisnis.
- Pastikan seluruh perubahan data yang saling berkaitan berada dalam satu transaksi.
- Lakukan commit hanya ketika seluruh operasi dalam transaksi berhasil.
- Jika salah satu operasi gagal, lakukan rollback agar perubahan yang belum berhasil tidak meninggalkan data dalam kondisi tidak konsisten.
- Setelah kegagalan, teruskan error menggunakan `rethrow`.
- Jangan mengabaikan kegagalan transaksi.
- Ikuti mekanisme transaksi yang disediakan oleh library database yang digunakan.
- Jika menggunakan API seperti `transaction()` pada Sqflite, manfaatkan mekanisme commit dan rollback otomatis yang disediakan API tersebut.
- Jangan mencampurkan transaksi otomatis dari library dengan pemanggilan `begin`, `commit`, atau `rollback` manual yang tidak diperlukan.
Tujuannya adalah memastikan data tetap konsisten meskipun salah satu langkah operasi database mengalami kegagalan.
### 9. String Literal dan Konstanta
Hindari penggunaan string literal yang berulang atau berfungsi sebagai identifier tetap di berbagai bagian kode.
Ketentuan:
- Gunakan konstanta atau enum untuk nilai string yang memiliki fungsi tetap dalam logika aplikasi.
- Gunakan `enum` untuk kumpulan nilai yang pilihannya sudah ditentukan dan terbatas.
- Gunakan `const` atau konstanta terpusat untuk nama tabel, nama kolom, key penyimpanan, route, status, kategori, dan identifier lainnya.
- Jangan menyebarkan string yang sama ke banyak file apabila dapat menggunakan satu definisi terpusat.
- Pastikan penggunaan konstanta tidak mengubah makna atau perilaku program.
Tidak perlu mengubah setiap string literal menjadi enum. Pemilihan konstanta atau enum harus disesuaikan dengan fungsi dan karakteristik nilainya.
### 10. Penggunaan `await` dan `unawaited`
Gunakan `await` dan `unawaited` sesuai kebutuhan proses asynchronous.
Ketentuan:
- Gunakan `await` apabila hasil Future diperlukan, proses harus menunggu penyelesaiannya, atau urutan operasi harus dipastikan.
- Gunakan `unawaited()` apabila Future memang tidak perlu ditunggu oleh pemanggil.
- Pastikan operasi yang dijalankan menggunakan `unawaited()` tetap memiliki penanganan error yang sesuai.
- Jangan menggunakan `unawaited()` hanya untuk menghilangkan peringatan analyzer.
- Jangan menggunakan `await` apabila penyelesaian Future tidak diperlukan dan tidak memengaruhi urutan proses.
- Untuk navigasi, gunakan `await` jika hasil navigasi diperlukan atau ada proses lanjutan yang harus menunggu halaman ditutup. Gunakan `unawaited()` jika hasilnya memang tidak diperlukan.
Import yang digunakan apabila `unawaited()` diperlukan:
```dart
import 'dart:async';
```
Contoh:
```dart
unawaited(prosesAsynchronous());
```
### 11. Penggunaan Logger
Gunakan logger dari class `L` yang sudah tersedia di proyek.
Jangan menggunakan `print()`, `debugPrint()`, atau logger lain untuk menggantikan logger proyek.
Ketentuan penggunaan:
| Logger | Kegunaan                                                                                                   |
| ------ | ---------------------------------------------------------------------------------------------------------- |
| `L.i`  | Mencatat alur proses normal, seperti proses dimulai atau selesai.                                          |
| `L.s`  | Mencatat keberhasilan operasi, seperti penyimpanan, penghapusan, dan penambahan data ke database.          |
| `L.w`  | Mencatat kondisi tidak normal yang tidak menyebabkan operasi gagal, seperti data kosong atau izin ditolak. |
| `L.e`  | Mencatat error runtime yang ditangani melalui blok `catch`.                                                |
Ketentuan tambahan:
- Setiap blok `catch` wajib mencatat error menggunakan `L.e`.
- Gunakan `L.i` untuk informasi yang memang memberikan manfaat dalam pemantauan alur aplikasi.
- Jangan menggunakan `L.i` secara berlebihan.
- Jangan menempatkan logging di dalam loop yang berjalan berulang atau berfrekuensi tinggi.
- Hindari penggunaan logger di dalam metode `build()` karena metode tersebut dapat dipanggil berulang kali.
- Pastikan informasi yang dicatat membantu proses debugging dan tidak membocorkan data sensitif.
### 12. Flutter Analyzer
Kode wajib bersih dari seluruh temuan analyzer pada folder `lib/` dan `test/`.
Ketentuan:
- Jalankan `flutter analyze` setelah melakukan perubahan kode.
- Perbaiki seluruh `error`, `warning`, dan `info` yang ditemukan pada folder `lib/` dan `test/`.
- Jangan membiarkan temuan analyzer yang belum diselesaikan.
- Jangan menggunakan komentar `ignore` hanya untuk menyembunyikan temuan analyzer.
- Jika suatu temuan memang tidak dapat dihindari, pastikan terdapat alasan teknis yang jelas sebelum menentukan penanganannya.
- Periksa kembali hasil analyzer setelah perbaikan.
### 13. Restart Aplikasi
Ketika fitur restart aplikasi menggunakan API `Restart.restartApp()`, ikuti ketentuan berikut:
- Panggil `Restart.restartApp()` menggunakan `await`.
- Tangani hasil pengembalian bertipe `RestartResult`.
- Periksa properti `success` untuk mengetahui apakah permintaan restart berhasil diterima oleh platform.
- Jika `success` bernilai `false`, tangani informasi `code` dan `message` sesuai kebutuhan.
- Perhatikan bahwa `code` dan `message` dapat bernilai `null`.
- Jangan menganggap restart berhasil hanya karena pemanggilan Future selesai.
- Gunakan `try/catch` untuk menangani error saat proses restart.
- Setiap blok `catch` wajib mencatat error menggunakan `L.e`.
- Sebelum melakukan `setState` atau mengakses `context` setelah `await`, periksa `mounted`.
- Jika proses restart gagal, berikan informasi kegagalan kepada UI sesuai kebutuhan.
### 14. ParserUtil untuk Data Dynamic dari Map
Seluruh parsing nilai `dynamic` yang berasal dari Map database maupun jaringan wajib menggunakan `ParserUtil` yang sudah tersedia di proyek.
Ketentuan:
- Gunakan `ParserUtil` sebagai tempat penanganan dan konversi tipe data dari Map database atau jaringan.
- Jangan melakukan parsing `dynamic` secara langsung dan berulang di berbagai bagian aplikasi.
- Periksa implementasi `ParserUtil` terlebih dahulu sebelum menggunakannya.
- Gunakan metode parsing yang sudah tersedia dan sesuai dengan tipe data yang dibutuhkan.
- Jika metode yang diperlukan belum tersedia, sesuaikan implementasi `ParserUtil` tanpa membuat fungsi parsing duplikat di berbagai file.
- Pastikan penanganan nilai null dan kegagalan parsing tetap mengikuti aturan pada bagian penanganan null dan parsing.
- Jika perlu menambahkan metode parsing, gunakan pendekatan yang aman terhadap data yang tidak valid.
**Prioritas penerapan:**
`ParserUtil` merupakan jalur utama untuk memproses nilai `dynamic` dari Map database dan jaringan. Penggunaan `tryParse` diterapkan di dalam implementasi parsing apabila diperlukan, bukan sebagai pengganti `ParserUtil` di seluruh bagian aplikasi.
### 15. Inisialisasi Asynchronous di initState
Jangan menjadikan metode `initState()` sebagai metode asynchronous.
Apabila inisialisasi membutuhkan proses asynchronous, gunakan kombinasi `Future.microtask`, `unawaited`, dan pengecekan `mounted`.
Ketentuan:
- Jalankan proses inisialisasi asynchronous melalui `Future.microtask`.
- Gunakan `unawaited` untuk menjalankan Future tersebut dari `initState()`.
- Pastikan proses inisialisasi memiliki penanganan error.
- Periksa `mounted` sebelum mengakses UI setelah proses asynchronous.
- Jangan melakukan pembaruan UI apabila widget sudah tidak terpasang.
- Pastikan error dari Future yang tidak ditunggu tidak dibiarkan menjadi unhandled error.
- Gunakan state error atau mekanisme penanganan UI yang sesuai apabila proses inisialisasi gagal.
### 16. Pengamanan Aksi dan Double Submit
Gunakan flag seperti `_sedangMemuat` atau `_isLoading` untuk mencegah satu aksi dijalankan berulang kali sebelum proses sebelumnya selesai.
Ketentuan:
- Periksa flag sebelum memulai operasi.
- Jika operasi masih berjalan, hentikan pemanggilan berikutnya.
- Aktifkan flag sebelum memulai proses asynchronous.
- Pastikan flag dikembalikan ke kondisi semula setelah operasi selesai, termasuk ketika terjadi error.
- Gunakan `try/finally` apabila diperlukan agar proses pengembalian flag tetap dijalankan.
- Jika flag digunakan untuk memperbarui UI, periksa `mounted` sebelum memanggil `setState`.
- Selama operasi berlangsung, cegah pengguna menjalankan aksi yang sama berulang kali.
Contoh:
```dart
if (_isLoading) return;
```
### 17. Post Frame Callback dan WidgetsBindingObserver
Gunakan `addPostFrameCallback` dan `WidgetsBindingObserver` sesuai kebutuhan siklus hidup widget dan aplikasi.
**A. addPostFrameCallback**
Gunakan `WidgetsBinding.instance.addPostFrameCallback` untuk operasi yang membutuhkan widget sudah selesai dirender.
Contoh penggunaan:
- Mengatur posisi scroll setelah widget selesai ditampilkan.
- Mengatur fokus pada suatu input setelah widget dirender.
- Menampilkan dialog yang membutuhkan widget sudah tersedia.
- Melakukan operasi lain yang bergantung pada hasil rendering frame.
Ketentuan:
- Jangan menggunakan `addPostFrameCallback` untuk pekerjaan yang tidak membutuhkan widget selesai dirender.
- Pastikan widget masih terpasang sebelum mengakses UI dari callback.
- Jika callback menjalankan operasi asynchronous, terapkan pengecekan `mounted` setelah `await` sebelum mengakses UI.
**B. WidgetsBindingObserver**
Gunakan `WidgetsBindingObserver` apabila widget atau objek perlu mengetahui perubahan siklus hidup aplikasi.
Ketentuan:
- Daftarkan observer melalui `WidgetsBinding.instance.addObserver(this)` di dalam `initState()`.
- Lepaskan observer melalui `WidgetsBinding.instance.removeObserver(this)` di dalam `dispose()`.
- Gunakan `didChangeAppLifecycleState` untuk menangani perubahan siklus hidup aplikasi.
- Sesuaikan tindakan dengan status aplikasi, seperti ketika aplikasi berpindah ke background atau kembali ke foreground.
- Pastikan observer tidak didaftarkan berulang kali tanpa kebutuhan.
- Pastikan observer selalu dilepaskan ketika objek pemiliknya sudah tidak digunakan.
Contoh penggunaan:
- Mengunci aplikasi ketika berpindah ke background.
- Memperbarui data ketika aplikasi kembali ke foreground.
- Menghentikan proses tertentu ketika aplikasi tidak aktif.
Referensi:
https://api.flutter.dev/flutter/widgets/WidgetsBindingObserver-class.html
---
## Prioritas Penyelesaian Ketika Menemukan Pelanggaran
Ketika AI menemukan kode yang tidak sesuai dengan aturan ini:
1. Periksa terlebih dahulu konteks kode dan tujuan operasi yang sedang dikerjakan.
2. Identifikasi sumber masalah dan kemungkinan dampaknya terhadap runtime.
3. Perbaiki berdasarkan kebutuhan dan logika program, bukan sekadar menghilangkan peringatan analyzer.
4. Jangan mengganti perilaku program yang sudah benar hanya untuk menyesuaikan bentuk penulisan.
5. Jangan membuat abstraksi, helper, konstanta, atau percabangan baru apabila tidak diperlukan.
6. Pastikan perbaikan tidak menimbulkan masalah baru pada bagian lain.
7. Jalankan `flutter analyze` setelah perubahan dan selesaikan seluruh temuan pada folder `lib/` dan `test/`.
## Rekomendasi (Tidak Bersifat Wajib)
Hal-hal berikut merupakan rekomendasi tambahan untuk meningkatkan kualitas penerapan aturan:
- Pertimbangkan untuk menyediakan unit test pada `ParserUtil`, terutama untuk nilai null, format tidak valid, dan perbedaan tipe data dari database maupun jaringan.
- Pertimbangkan untuk menguji operasi transaksi database ketika salah satu langkah insert, update, atau delete mengalami kegagalan.
- Pertimbangkan untuk menyediakan mekanisme pencatatan error yang konsisten agar proses debugging lebih mudah dilakukan.
Rekomendasi di atas tidak menambahkan kewajiban baru terhadap implementasi apabila belum diperlukan oleh kebutuhan proyek.


// ============================================================
// FILE: .agents/rules/global/optimasi_keamanan.md
// ============================================================

# Aturan Optimasi Keamanan
## Tujuan
Menetapkan standar penyimpanan dan perlindungan data agar informasi sensitif pengguna tetap aman, tidak terekspos melalui media yang tidak semestinya, serta dibersihkan ketika pengguna melakukan logout.
## Ketentuan
### 1. Penyimpanan Data Sensitif
Seluruh data sensitif wajib disimpan menggunakan paket `flutter_secure_storage` yang memanfaatkan mekanisme penyimpanan aman pada masing-masing platform:
- iOS: Keychain.
- Android: Keystore.
Data yang wajib menggunakan penyimpanan aman meliputi:
- PIN dan hash PIN.
- Salt.
- Access token.
- Refresh token.
- Kredensial.
- Kunci enkripsi.
Dilarang menyimpan data sensitif tersebut menggunakan `SharedPreferences`.
#### Contoh benar
```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
const storage = FlutterSecureStorage();
await storage.write(key: 'access_token', value: token);
```
**Alasan:** Token disimpan pada secure storage, bukan SharedPreferences.
#### Contoh salah
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString('access_token', token);
```
**Kesalahan:** Menyimpan token pada SharedPreferences.
**Rujukan teknis:**
- `pubspec.yaml` — `flutter_secure_storage: ^11.2.0`, `shared_preferences: ^2.5.6`.
- `lib/fitur/kunci_aplikasi/service/kunci_aplikasi_service.dart`.
```
### 2. Penggunaan SharedPreferences
`SharedPreferences` hanya boleh digunakan untuk menyimpan preferensi pengguna yang tidak bersifat sensitif.
Contoh data yang diperbolehkan:
- Preferensi tema.
- Preferensi bahasa.
- Pilihan UI.
- Flag onboarding.
Jangan menyimpan kredensial, token, kunci enkripsi, maupun informasi sensitif lainnya menggunakan `SharedPreferences`.
#### Contoh benar
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setBool('is_onboarding_selesai', true);
```
**Alasan:** Flag onboarding bukan data sensitif.
#### Contoh salah
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString('refresh_token', refreshToken);
```
**Kesalahan:** Menyimpan refresh token pada SharedPreferences.
**Rujukan teknis:**
- `pubspec.yaml` — `shared_preferences: ^2.5.6`.
```
### 3. Perlindungan Data Sensitif
Data sensitif tidak boleh terekspos melalui clipboard maupun screenshot.
Ketentuan perlindungan:
- Gunakan `enableInteractiveSelection: false` pada field yang menampilkan atau menerima data sensitif untuk mencegah pengguna menyeleksi dan menyalin teks tersebut.
- Terapkan perlindungan screenshot pada layar yang menampilkan data sensitif agar informasi tersebut tidak dapat ditangkap melalui screenshot.
### 4. Pembersihan Data Saat Logout
Ketika pengguna melakukan logout, seluruh data sensitif wajib dihapus dari:
- Secure storage.
- Memory aplikasi.
Pastikan tidak ada data sensitif milik sesi sebelumnya yang masih tersimpan atau dapat diakses setelah proses logout.


// ============================================================
// FILE: .agents/rules/global/optimasi_performa.md
// ============================================================

# Aturan Optimasi Performa
## 1. Mempertahankan Posisi Scroll dan Identitas Item
1. Ketika operasi apa pun dilakukan pada daftar, seperti menambah, menghapus, mengubah, atau memperbarui item, posisi scroll harus tetap dipertahankan.
2. Jangan sampai daftar kembali ke posisi paling atas hanya karena operasi tersebut menyebabkan widget dibangun ulang (_rebuild_).
3. Setiap item yang dirender dalam daftar wajib memiliki `Key` yang stabil dan unik.
4. Gunakan `ValueKey`, `ObjectKey`, atau `UniqueKey` sesuai karakteristik dan kebutuhan identitas item.
5. Key harus tetap konsisten untuk item yang sama selama item tersebut masih memiliki identitas yang sama. Jangan membuat key baru setiap kali widget dibangun ulang.
#### Contoh benar
```dart
ListView.builder(
  itemCount: daftar.length,
  itemBuilder: (context, index) {
    final item = daftar[index];
    return ListTile(
      key: ValueKey(item.id),
      title: Text(item.nama),
    );
  },
);
```
**Alasan:** `ValueKey(item.id)` stabil dan unik untuk setiap item.
#### Contoh salah
```dart
ListView.builder(
  itemCount: daftar.length,
  itemBuilder: (context, index) {
    final item = daftar[index];
    return ListTile(
      key: ValueKey(DateTime.now().millisecondsSinceEpoch),
      title: Text(item.nama),
    );
  },
);
```
**Kesalahan:** Key berubah setiap rebuild, sehingga posisi scroll dan identitas item tidak stabil.
**Rujukan teknis:**
- Flutter SDK — `ValueKey`, `ObjectKey`, `UniqueKey`.
```
## 2. Rekomendasi Optimasi Pekerjaan Berat
1. Pekerjaan berat, seperti parsing JSON berukuran besar, sorting data dalam jumlah besar, dan komputasi intensif, direkomendasikan untuk dijalankan di luar UI thread menggunakan `compute()` atau `Isolate.run()`.
2. Hindari menjalankan pekerjaan berat secara langsung di UI thread karena dapat menyebabkan antarmuka tidak responsif.
3. Fungsi yang diberikan sebagai argumen kepada `compute()` harus berupa fungsi `top-level` atau `static`.


// ============================================================
// FILE: .agents/rules/global/optimasi_ui.md
// ============================================================

# Optimasi UI
**Path:** `.agents/rules/global/optimasi_ui.md`
## Tujuan
File ini merupakan referensi utama untuk seluruh implementasi UI/UX pada proyek Flutter.
Seluruh desain antarmuka harus mengacu pada ketentuan dalam file ini, khususnya mengenai layout, tipografi, ukuran, jarak, padding, dan margin. Tujuannya adalah menjaga konsistensi desain agar aplikasi memiliki tampilan yang profesional dan premium.
## Aturan
### 1. Referensi Desain
1. Gunakan file ini sebagai referensi untuk menentukan:
   - Layout.
   - Jenis dan ukuran font.
   - Ukuran komponen.
   - Jarak antar-elemen.
   - Padding.
   - Margin.
2. Seluruh implementasi UI/UX wajib mengacu pada standar yang ditetapkan dalam file ini.
3. Terapkan standar desain tersebut pada seluruh file Dart agar tampilan aplikasi tetap konsisten.
4. Dilarang menetapkan nilai ukuran, jarak, padding, dan margin secara sembarangan di dalam widget. Gunakan nilai yang telah ditentukan dalam referensi desain ini.
### 2. Penggunaan Warna dan Tema
1. Gunakan warna dari tema aplikasi untuk teks maupun komponen UI lainnya agar tampilannya dapat menyesuaikan dengan mode tema yang aktif.
2. Penggunaan warna hardcode diperbolehkan apabila warna tersebut memang harus tetap sama pada seluruh mode tema.
3. Nilai warna yang menggunakan format HEX atau RGBA tidak boleh diubah menjadi referensi `ColorScheme`.
4. Jangan menggunakan warna hardcode untuk komponen yang seharusnya mengikuti perubahan tema aplikasi.
### 3. Penanganan Text Overflow
1. Antisipasi kemungkinan teks menjadi panjang dan menyebabkan overflow pada layout.
2. Berikan penanganan khusus pada teks yang wajib tetap terlihat agar tidak menyebabkan overflow.
3. Gunakan widget seperti `FittedBox` atau `Flexible` apabila sesuai dengan kebutuhan layout dan karakteristik teks.
4. Jangan menerapkan `FittedBox` atau `Flexible` secara sembarangan pada seluruh teks. Gunakan hanya pada bagian yang memang membutuhkannya.
### 4. Pengaturan Jarak Antar-Anak Widget
1. Gunakan properti `spacing` pada `Row` dan `Column` untuk mengatur jarak antar-widget anak.
2. Gunakan `SizedBox` hanya untuk kebutuhan jarak khusus yang tidak dapat ditangani menggunakan properti `spacing`.
3. Hindari penggunaan `SizedBox` berulang hanya untuk mengatur jarak standar antar-widget anak.
#### Contoh benar
```dart
Column(
  spacing: 8,
  children: const [
    Text('Judul'),
    Text('Deskripsi'),
  ],
);
```
**Alasan:** Jarak antar-anak diatur melalui properti `spacing`.
#### Contoh salah
```dart
Column(
  children: const [
    Text('Judul'),
    SizedBox(height: 8),
    Text('Deskripsi'),
    SizedBox(height: 8),
    Text('Lainnya'),
  ],
);
```
**Kesalahan:** Menggunakan `SizedBox` berulang untuk jarak standar.
**Rujukan teknis:**
- Flutter SDK — `Row.spacing`, `Column.spacing`.
```
### 5. Pengaturan Tipografi
1. Gunakan `Theme.of(context).textTheme` sebagai referensi utama untuk menentukan gaya teks.
2. Jika diperlukan penyesuaian gaya teks, gunakan `copyWith()` berdasarkan gaya teks yang tersedia dalam tema.
#### Contoh benar
```dart
final textTheme = Theme.of(context).textTheme;
Text(
  'Judul',
  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
);
```
**Alasan:** Gaya teks dasar diambil dari tema, lalu disesuaikan dengan `copyWith`.
#### Contoh salah
```dart
Text(
  'Judul',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
);
```
**Kesalahan:** Menentukan ukuran dan gaya teks secara manual tanpa acuan tema.
**Rujukan teknis:**
- Flutter SDK — `Theme.of(context).textTheme`, `TextStyle.copyWith`.
```
3. Penggunaan warna hardcode pada teks diperbolehkan apabila memang diperlukan untuk mempertahankan warna tertentu pada mode terang dan gelap.
### 6. Dialog Konfirmasi
Gunakan komponen yang tersedia dalam paket `adaptive_dialog` untuk membuat dialog konfirmasi.
### 7. Proses Berat di Build
1. Jangan menjalankan proses komputasi berat secara langsung di dalam method `build()`.
2. Proses seperti sorting data dalam jumlah besar dan parsing data harus dipindahkan ke tempat yang sesuai, seperti Provider atau Isolate.
3. Hindari pekerjaan berat di dalam `build()` agar proses rendering UI tidak terganggu.
### 8. Penggunaan showModalBottomSheet
1. Setiap penggunaan `showModalBottomSheet` wajib memperhatikan area aman layar menggunakan `SafeArea`.
2. Jika konten Bottom Sheet berukuran panjang dan berpotensi melebihi tinggi layar, wajib menggunakan `isScrollControlled: true`.
3. Pastikan konten yang panjang dapat ditampilkan dan digulir tanpa terpotong oleh batas layar.
#### Contoh benar
```dart
showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  builder: (context) => SafeArea(
    child: DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => ListView(
        controller: scrollController,
        children: const [Text('Konten panjang')],
      ),
    ),
  ),
);
```
**Alasan:** Bottom sheet panjang menggunakan `SafeArea` dan `isScrollControlled`.
#### Contoh salah
```dart
showModalBottomSheet<void>(
  context: context,
  builder: (context) => Column(
    children: const [Text('Konten panjang')],
  ),
);
```
**Kesalahan:** Konten panjang tidak dapat digulir dan tidak memperhatikan area aman.
**Rujukan teknis:**
- Flutter SDK — `showModalBottomSheet`, `SafeArea`, `isScrollControlled`.
```
## Rekomendasi
1. Utamakan konsistensi desain pada seluruh halaman aplikasi.
2. Pilih widget yang sesuai dengan kebutuhan layout dan karakteristik konten.
3. Hindari penggunaan widget yang tidak diperlukan apabila tersedia solusi yang lebih sederhana.


// ============================================================
// FILE: .agents/rules/global/optimasi_ux.md
// ============================================================

<!-- Path: optimasi_ux.md -->
# Aturan Optimasi UX/UI Flutter
## Prinsip umum
1. Sebelum membuat, mengubah, atau menganalisis tampilan UI, wajib membaca `optimasi_ui.md` sebagai referensi desain.
2. Seluruh penerapan aturan UX/UI wajib mengikuti referensi desain yang sudah ditentukan.
3. Jangan membuat nilai ukuran, padding, margin, atau spacing sendiri apabila nilai tersebut sudah tersedia di `optimasi_ui.md`.
4. Jangan menyatakan pekerjaan selesai sebelum melakukan pemeriksaan terhadap aturan UX/UI yang berkaitan dengan pekerjaan tersebut.
5. Terapkan aturan ini pada seluruh halaman dan widget yang dibuat, diubah, maupun diperiksa.
---
# Aturan UX
## 1. Konfirmasi operasi penghapusan
Setiap operasi penghapusan data wajib memberikan informasi kepada pengguna mengenai data yang akan dihapus dan menampilkan konfirmasi sebelum penghapusan dilakukan.
Ketentuan:
- Tampilkan informasi mengenai data atau objek yang akan dihapus.
- Jelaskan konsekuensi penghapusan apabila diperlukan.
- Sediakan pilihan untuk membatalkan dan melanjutkan penghapusan.
- Jangan menjalankan operasi penghapusan sebelum pengguna memberikan konfirmasi.
- Jangan menampilkan konfirmasi berulang apabila pengguna sudah memberikan konfirmasi untuk operasi yang sama.
Contoh benar:
- Menekan tombol hapus bahan bakar menampilkan dialog: "Apakah Anda yakin ingin menghapus data bahan bakar ini?"
- Menyediakan tombol "Batal" dan "Hapus".
- Penghapusan hanya dilakukan setelah pengguna menekan "Hapus".
Contoh salah:
- Data langsung dihapus setelah tombol hapus ditekan.
- Dialog hanya menampilkan pesan "Apakah Anda yakin?" tanpa menjelaskan objek yang akan dihapus.
- Operasi penghapusan berjalan sebelum pengguna memberikan konfirmasi.
## 2. Bahasa yang ditampilkan kepada pengguna
Seluruh teks yang tampil kepada pengguna wajib menggunakan bahasa yang formal, baku, dan sesuai dengan bahasa atau locale aplikasi.
Ketentuan:
- Gunakan bahasa yang mudah dipahami pengguna.
- Hindari singkatan tidak umum, bahasa gaul, typo, dan kalimat yang ambigu.
- Gunakan istilah yang konsisten pada seluruh halaman.
- Pesan error harus menjelaskan masalah dengan bahasa yang dapat dipahami pengguna.
- Jangan menentukan bahasa hanya berdasarkan perkiraan lokasi pengguna. Gunakan konfigurasi bahasa atau locale aplikasi.
Contoh benar:
- "Data bahan bakar berhasil disimpan."
- "Koneksi internet tidak tersedia. Silakan periksa koneksi Anda."
- "Apakah Anda yakin ingin menghapus data ini?"
Contoh salah:
- "Data udah kesimpan."
- "Waduh, error nih!"
- "Gagal karena sesuatu."
## 3. Kejelasan tampilan
Setiap tampilan wajib dirancang agar pengguna dapat memahami informasi dan tindakan yang tersedia tanpa harus menebak-nebak.
Ketentuan:
- Susun informasi berdasarkan tingkat kepentingannya.
- Kelompokkan informasi yang saling berkaitan.
- Hindari tampilan yang terlalu padat atau tidak terstruktur.
- Gunakan istilah dan pola interaksi yang konsisten.
- Setiap elemen yang memiliki fungsi harus mempunyai tujuan yang jelas.
- Hindari menampilkan informasi yang tidak diperlukan untuk menyelesaikan tugas pengguna.
Contoh benar:
- Informasi saldo, total pemasukan, dan total pengeluaran dikelompokkan secara terstruktur.
- Pengguna dapat membedakan informasi utama dan informasi tambahan.
Contoh salah:
- Seluruh informasi ditampilkan tanpa pengelompokan.
- Tombol, label, dan nilai informasi disusun tanpa hierarki yang jelas.
- Pengguna harus mencoba beberapa tombol terlebih dahulu untuk memahami fungsinya.
## 4. Kejelasan tujuan tombol dan tindakan
Setiap tombol atau elemen interaktif wajib menjelaskan tujuan tindakannya melalui label, ikon yang mudah dikenali, atau tooltip.
Ketentuan:
- Label tombol harus menggambarkan tindakan yang akan dilakukan.
- Hindari label yang terlalu umum apabila tindakan sebenarnya dapat dijelaskan lebih spesifik.
- Gunakan ikon sesuai fungsi yang sebenarnya.
- Untuk ikon yang tidak memiliki label teks, wajib sediakan tooltip.
- Jangan membuat tombol yang fungsi atau konsekuensinya tidak dapat dipahami pengguna.
Contoh benar:
- Tombol "Simpan Perubahan" untuk menyimpan perubahan.
- Tombol "Hapus" untuk menghapus data.
- Ikon pensil dengan tooltip "Ubah Data".
Contoh salah:
- Tombol "OK" untuk beberapa tindakan yang berbeda tanpa konteks.
- Ikon tanpa label atau tooltip sehingga pengguna harus menebak fungsinya.
- Tombol yang terlihat seperti tombol simpan tetapi ternyata menjalankan penghapusan.
## 5. Kejelasan status operasi
Pengguna tidak boleh dibiarkan menebak apakah suatu operasi sedang berjalan, sudah selesai, gagal, atau belum dijalankan.
Ketentuan:
- Tampilkan status ketika operasi membutuhkan waktu untuk diproses.
- Pastikan pengguna mengetahui ketika proses dimulai.
- Pastikan pengguna mengetahui ketika proses berhasil atau gagal.
- Hindari tampilan yang tidak memberikan respons setelah pengguna melakukan tindakan.
- Untuk proses yang membutuhkan waktu, tampilkan indikator pemrosesan yang sesuai.
- Cegah pengguna menjalankan permintaan yang sama berulang kali ketika permintaan sebelumnya masih berjalan.
Contoh benar:
1. Pengguna menekan tombol simpan.
2. Sistem menampilkan indikator loading.
3. Tombol terkait dinonaktifkan sementara.
4. Setelah berhasil, sistem memberikan informasi bahwa data berhasil disimpan.
Contoh salah:
1. Pengguna menekan tombol simpan.
2. Tampilan tidak memberikan respons.
3. Pengguna menekan tombol berkali-kali karena tidak mengetahui apakah proses sedang berjalan.
## 6. Feedback sistem
Sistem wajib memberikan feedback yang sesuai dengan keadaan operasi agar pengguna memperoleh kepastian mengenai hasil tindakannya.
Jenis feedback:
- **Info:** Memberikan informasi mengenai keadaan sistem atau proses.
- **Sukses:** Memberitahukan bahwa operasi berhasil dilakukan.
- **Warning:** Memberitahukan kondisi yang membutuhkan perhatian pengguna.
- **Error:** Memberitahukan bahwa operasi gagal atau terjadi masalah.
Ketentuan:
- Gunakan jenis feedback sesuai keadaan sebenarnya.
- Pesan harus menjelaskan apa yang terjadi.
- Pesan sukses hanya boleh ditampilkan setelah operasi benar-benar berhasil.
- Pesan error harus disertai informasi yang relevan dan, apabila memungkinkan, langkah yang dapat dilakukan pengguna.
- Jangan menampilkan feedback yang menyesatkan.
- Hindari menampilkan terlalu banyak notifikasi untuk satu kejadian yang sama.
Contoh benar:
- Info: "Sedang memuat data."
- Sukses: "Data berhasil disimpan."
- Warning: "Data ini belum memiliki kategori."
- Error: "Data gagal disimpan. Silakan coba kembali."
Contoh salah:
- Menampilkan pesan sukses sebelum penyimpanan selesai.
- Menampilkan pesan "Berhasil" meskipun operasi gagal.
- Tidak memberikan informasi apa pun ketika operasi mengalami kegagalan.
## 7. Proses background dan integritas data
Proses yang hasilnya tidak perlu ditunggu pengguna sebaiknya dijalankan di background agar tidak menghambat interaksi pengguna.
Namun, optimasi tersebut tidak boleh menyebabkan data rusak, tidak konsisten, hilang, atau mengalami perubahan yang tidak semestinya.
Ketentuan:
- Bedakan proses yang membutuhkan hasil langsung dengan proses yang dapat berjalan di background.
- Jangan memblokir UI untuk pekerjaan yang tidak membutuhkan hasil langsung.
- Operasi yang saling bergantung wajib mempertahankan urutan eksekusinya.
- Pastikan proses penyimpanan dan perubahan data memiliki penanganan error yang sesuai.
- Gunakan transaksi database untuk operasi yang membutuhkan konsistensi beberapa perubahan data.
- Pastikan proses background tidak mengubah data secara sembarangan ketika halaman atau objek terkait sudah tidak berlaku.
- Jangan menjalankan proses secara tidak terpantau sehingga kegagalannya tidak diketahui sistem.
- Apabila proses background gagal, pastikan kegagalan tersebut ditangani dan dapat diketahui sesuai kebutuhan aplikasi.
Contoh benar:
- Pengguna membuka halaman sementara proses sinkronisasi data berjalan di background.
- UI tetap dapat digunakan selama sinkronisasi tidak mengharuskan pengguna menunggu hasilnya.
- Apabila sinkronisasi gagal, sistem tetap mencatat dan menangani kegagalan tersebut.
Contoh salah:
- Seluruh UI dikunci hanya untuk menjalankan proses yang tidak membutuhkan hasil langsung.
- Beberapa perubahan database dijalankan secara terpisah tanpa menjaga konsistensi data.
- Proses background mengalami kegagalan tetapi tidak ditangani.
## 8. Optimasi rebuild
Hindari rebuild widget yang tidak diperlukan. Usahakan hanya bagian UI yang terdampak perubahan state yang melakukan rebuild.
Ketentuan:
- Tempatkan pengelolaan state pada cakupan widget yang sesuai.
- Hindari membuat widget besar melakukan rebuild ketika hanya sebagian kecil tampilannya berubah.
- Pisahkan bagian UI yang memiliki kebutuhan perubahan state berbeda apabila memang diperlukan.
- Gunakan mekanisme pembatasan rebuild sesuai pola pengelolaan state yang digunakan proyek.
- Jangan melakukan optimasi berlebihan yang justru membuat struktur kode semakin rumit.
- Utamakan optimasi berdasarkan kebutuhan dan dampak yang nyata.
Contoh benar:
- Perubahan jumlah barang hanya memperbarui bagian ringkasan jumlah barang yang membutuhkan nilai tersebut.
- Widget lain yang tidak bergantung pada perubahan state tidak perlu ikut rebuild.
Contoh salah:
- Perubahan satu nilai menyebabkan seluruh halaman melakukan rebuild tanpa alasan.
- Seluruh halaman bergantung pada satu state yang sebenarnya dapat dibatasi pada widget tertentu.
## 9. Pencegahan memory leak dan pengelolaan resource
Pastikan resource yang memiliki siklus hidup wajib dikelola dengan benar agar tidak menyebabkan memory leak atau penggunaan resource yang tidak diperlukan.
Ketentuan:
- Pastikan `TextEditingController`, `ScrollController`, `AnimationController`, `FocusNode`, dan resource sejenis yang dimiliki oleh widget di-dispose ketika tidak lagi digunakan.
- Batalkan subscription, listener, timer, dan proses yang dapat dibatalkan ketika pemiliknya sudah tidak digunakan.
- Tutup resource seperti stream atau koneksi apabila memang menjadi tanggung jawab objek tersebut.
- Jangan melakukan dispose terhadap resource yang dimiliki dan dikelola oleh objek lain.
- Pastikan lifecycle widget diperhatikan, khususnya ketika proses asynchronous berlangsung.
- Hindari mempertahankan referensi atau listener yang sudah tidak diperlukan.
Contoh benar:
- Controller yang dibuat oleh `StatefulWidget` di-dispose pada `dispose()`.
- Subscription dibatalkan ketika widget tidak lagi digunakan.
Contoh salah:
- Membuat `TextEditingController` tetapi tidak pernah melakukan dispose.
- Listener terus aktif setelah halaman ditutup.
- Melakukan dispose terhadap controller yang sebenarnya dimiliki oleh parent.
## 10. Padding tepi layar
Seluruh konten utama halaman wajib memiliki jarak yang sesuai dari tepi layar. Jangan sampai konten utama terlihat menempel langsung pada batas layar.
**Aturan kepemilikan padding:**
1. Padding tepi layar merupakan tanggung jawab container pada tingkat halaman atau parent yang menyusun konten halaman.
2. Terapkan padding pada container yang menjadi batas utama konten halaman, bukan secara sembarangan pada setiap widget anak.
3. Widget reusable/shared tidak boleh memasukkan padding tepi layar ke dalam dirinya sendiri. Tanggung jawab tersebut berada pada halaman yang menggunakan widget.
4. Widget reusable tetap boleh mempunyai padding internal untuk kebutuhan desain komponennya sendiri, misalnya jarak isi di dalam Card. Padding internal ini tidak boleh dianggap sebagai pengganti padding tepi layar.
5. Apabila sebuah halaman menggunakan beberapa widget reusable, parent halaman wajib memastikan seluruh widget tersebut berada di dalam batas padding tepi layar.
6. Apabila parent sudah memberikan padding tepi layar, jangan menambahkan padding tepi layar yang sama lagi pada setiap anak sehingga menghasilkan padding ganda.
7. Nilai padding wajib mengikuti `optimasi_ui.md`. Dilarang menentukan nilai sendiri tanpa dasar referensi desain.
8. Untuk layout yang menggunakan `ListView`, `GridView`, `CustomScrollView`, atau `SingleChildScrollView`, pastikan konten pertama dan terakhir tetap mempunyai jarak yang sesuai dari tepi layar.
9. Untuk list horizontal, perhatikan juga jarak item paling awal dan paling akhir terhadap tepi layar.
10. Padding harus diterapkan pada lapisan layout yang benar agar tidak hilang, tertimpa, atau tidak berpengaruh terhadap konten yang ditampilkan.
11. Pengecualian hanya diperbolehkan untuk elemen yang memang sengaja dirancang memenuhi lebar layar (edge-to-edge), seperti background atau gambar tertentu, sesuai kebutuhan desain. Konten teks dan elemen interaktif di dalamnya tetap harus memperhatikan jarak aman.
**Prosedur pemeriksaan padding wajib dilakukan:**
1. Identifikasi seluruh halaman yang dibuat, diubah, atau diperiksa.
2. Identifikasi batas area konten utama setiap halaman.
3. Telusuri struktur widget dari parent halaman sampai widget yang menampilkan konten.
4. Pastikan parent yang bertanggung jawab sudah memberikan padding tepi layar.
5. Periksa apakah ada widget utama yang masih menempel pada sisi kiri atau kanan layar.
6. Apabila terdapat widget reusable, cari seluruh tempat widget tersebut digunakan.
7. Periksa setiap halaman yang menggunakan widget reusable tersebut, bukan hanya file widget reusable-nya.
8. Periksa penggunaan list, grid, row, column, dan scrollable layout untuk memastikan item pertama, terakhir, dan kelompok konten utama tidak menempel pada tepi layar.
9. Pastikan tidak terdapat padding ganda atau padding internal yang keliru dianggap sebagai padding tepi layar.
10. Periksa kembali hasil perubahan sebelum menyatakan pekerjaan selesai.
**Kriteria kelulusan:**
- Seluruh konten utama mempunyai jarak yang sesuai dari tepi layar.
- Parent halaman bertanggung jawab memberikan padding tepi layar.
- Widget reusable tidak mengambil alih tanggung jawab padding tepi layar.
- Seluruh halaman pengguna widget reusable sudah diperiksa.
- Nilai padding sesuai dengan `optimasi_ui.md`.
- Tidak ada pelanggaran padding yang belum diselesaikan.
Apabila salah satu kriteria tersebut belum terpenuhi, pekerjaan belum boleh dinyatakan selesai.
Contoh benar:
Struktur halaman:
```text
Scaffold
└── SafeArea
    └── Padding (mengikuti optimasi_ui.md)
        └── ListView
            ├── RingkasanWidget
            ├── StatistikWidget
            └── DaftarWidget
```
Widget reusable:
```text
RingkasanWidget
└── Card
    └── Padding internal untuk isi Card
```
Widget reusable digunakan oleh beberapa halaman:
```text
Halaman A
└── Padding tepi layar
    └── RingkasanWidget
Halaman B
└── Padding tepi layar
    └── RingkasanWidget
```
Contoh salah:
```text
Scaffold
└── SafeArea
    └── ListView
        ├── RingkasanWidget (menempel pada tepi layar)
        ├── StatistikWidget (menempel pada tepi layar)
        └── DaftarWidget (menempel pada tepi layar)
```
Contoh salah lainnya:
- Widget reusable memiliki padding yang dianggap sebagai pengganti padding tepi layar untuk semua halaman.
- AI hanya memeriksa file widget reusable tanpa memeriksa parent pada halaman yang menggunakannya.
- Halaman A sudah memiliki padding, tetapi Halaman B menggunakan widget yang sama tanpa padding.
- AI hanya memeriksa satu sisi layar dan mengabaikan sisi lainnya.
- Padding di dalam Card dianggap sudah cukup untuk memenuhi aturan padding tepi layar.
## 11. Konsistensi jarak dan spacing
Seluruh jarak antarelemen wajib terlihat serasi, proporsional, dan konsisten berdasarkan referensi desain `optimasi_ui.md`.
Ketentuan:
- Gunakan nilai spacing yang telah ditetapkan dalam referensi desain.
- Jangan menggunakan jarak yang terlalu sempit hingga elemen terlihat berhimpitan.
- Jangan menggunakan jarak yang terlalu lebar hingga elemen terlihat tidak saling berkaitan.
- Bedakan jarak berdasarkan hubungan antar elemen, kelompok konten, dan bagian halaman.
- Gunakan prinsip konsistensi pada halaman yang mempunyai struktur serupa.
- Jangan menambahkan nilai spacing sembarangan hanya untuk memperbaiki satu widget tanpa mempertimbangkan keseluruhan layout.
Contoh benar:
- Jarak antara label dan nilainya lebih dekat daripada jarak antara dua kelompok informasi yang berbeda.
- Jarak antarbagian halaman mengikuti skala spacing pada referensi desain.
Contoh salah:
- Seluruh elemen menggunakan jarak yang sama tanpa mempertimbangkan hierarkinya.
- Satu kelompok informasi mempunyai jarak terlalu lebar sedangkan kelompok lain terlalu rapat.
- Menggunakan nilai padding dan margin acak yang tidak sesuai referensi desain.
## 12. Loading dan penguncian aksi
Setiap aksi asynchronous yang membutuhkan waktu pemrosesan wajib memberikan indikator loading agar pengguna mengetahui bahwa tindakan sedang berjalan.
Gunakan paket `flutter_easyloading` untuk loading overlay sesuai pola implementasi proyek.
Ketentuan:
- Sebelum menggunakan API `flutter_easyloading`, baca contoh penggunaannya pada file `example.md` yang relevan.
- Periksa implementasi dan konfigurasi `flutter_easyloading` yang sudah ada di proyek.
- Ikuti pola penggunaan yang benar berdasarkan dokumentasi dan implementasi proyek.
- Jangan membuat widget loading custom sebagai pengganti loading aksi yang seharusnya menggunakan `flutter_easyloading`.
- Tampilkan loading ketika operasi dimulai.
- Hentikan loading ketika operasi selesai, baik berhasil maupun gagal.
- Pastikan loading tidak tertinggal ketika terjadi exception.
- Cegah pengguna mengirim aksi yang sama berulang kali selama operasi sebelumnya masih berlangsung.
- Kunci hanya bagian interaksi yang perlu dikunci. Jangan memblokir seluruh halaman jika hal tersebut tidak diperlukan.
- Pastikan status akhir operasi tetap disampaikan melalui feedback sistem.
- Jangan menggunakan loading overlay yang menghalangi seluruh UI untuk proses background yang memang tidak perlu ditunggu pengguna. Untuk proses tersebut, ikuti aturan nomor 7.
Contoh benar:
- Pengguna menekan tombol simpan.
- `flutter_easyloading` menampilkan loading ketika penyimpanan berlangsung.
- Tombol simpan tidak dapat ditekan kembali selama proses berlangsung.
- Loading dihentikan setelah operasi selesai.
- Sistem menampilkan feedback sesuai hasil penyimpanan.
Contoh salah:
- Pengguna menekan tombol simpan tetapi tidak mendapatkan indikator loading.
- Membuat widget loading custom padahal proyek sudah menggunakan `flutter_easyloading`.
- Loading tidak dihentikan setelah terjadi error.
- Pengguna dapat menekan tombol simpan berkali-kali dan menghasilkan permintaan penyimpanan berulang.
- Menampilkan loading overlay yang memblokir UI untuk pekerjaan background yang tidak membutuhkan hasil langsung.
## 13. Standarisasi Toast feedback
Seluruh Toast feedback wajib menggunakan utilitas `AppToast` yang sudah tersedia di proyek.
Ketentuan:
- Jangan menggunakan `Fluttertoast` secara langsung pada halaman atau widget.
- Gunakan metode `AppToast` yang tersedia untuk menampilkan feedback.
- Periksa implementasi `AppToast` sebelum menggunakannya.
- Jangan mengarang nama metode yang belum tersedia.
- Gunakan jenis Toast sesuai hasil operasi.
Contoh benar:
```dart
AppToast.sukses(
  context,
  'Bahan bakar berhasil dihapus',
);
```
Contoh salah:
```dart
Fluttertoast.showToast(
  msg: 'Bahan bakar berhasil dihapus',
);
```
Contoh salah lainnya:
- Membuat utilitas Toast baru padahal `AppToast` sudah tersedia.
- Menampilkan Toast sukses sebelum operasi benar-benar berhasil.
## 14. SafeArea
Gunakan `SafeArea` untuk konten yang berpotensi tertutup oleh notch, status bar, navigation bar, atau area sistem lainnya.
Ketentuan:
- Perhatikan area aman perangkat pada setiap halaman.
- Pastikan konten utama tidak tertutup oleh elemen sistem.
- Terapkan `SafeArea` pada lapisan layout yang tepat.
- Hindari penggunaan `SafeArea` berulang yang menyebabkan jarak berlebihan.
- Elemen yang memang dirancang edge-to-edge harus tetap memperhatikan posisi konten interaktif dan teks.
Contoh benar:
- Konten utama halaman dibungkus dengan `SafeArea` sehingga tidak tertutup status bar.
Contoh salah:
- Konten utama dimulai dari bagian paling atas layar dan tertutup status bar.
- Menggunakan `SafeArea` berulang tanpa alasan sehingga konten mempunyai jarak berlebihan.
## 15. Area sentuh dan interaksi
Gunakan widget interaksi yang sesuai dengan perilaku dan desain aplikasi.
Ketentuan:
- Gunakan `InkWell` atau `InkResponse` untuk area sentuh yang membutuhkan efek ripple Material.
- Gunakan `GestureDetector` apabila efek ripple memang tidak diperlukan.
- Ikon yang tidak mempunyai label teks wajib mempunyai tooltip.
- Touch target untuk elemen interaktif minimal berukuran 48 × 48 dp.
- Pastikan area sentuh tidak terlalu kecil atau saling bertumpuk.
- Jangan membuat area sentuh yang berbeda dari area yang secara visual terlihat dapat ditekan.
Contoh benar:
- Ikon hapus mempunyai area sentuh minimal 48 × 48 dp dan tooltip "Hapus".
- Tombol menggunakan `InkWell` dengan efek ripple.
Contoh salah:
- Ikon hanya mempunyai area sentuh 20 × 20 dp.
- Ikon tidak memiliki label atau tooltip.
- Menggunakan `GestureDetector` padahal desain mengharuskan efek ripple Material.
## 16. Modal dan Bottom Sheet
Gunakan jenis modal sesuai tujuan interaksi.
Ketentuan:
- Gunakan `showModalBottomSheet` untuk filter, pengurutan (sort), dan pilihan sekunder.
- Bottom sheet wajib memperhatikan `SafeArea`.
- Gunakan `isScrollControlled: true` apabila konten bottom sheet panjang atau membutuhkan ruang lebih besar.
- Pastikan konten yang panjang tetap dapat di-scroll dan tidak terpotong.
- Gunakan `showModalActionSheet` dari paket `adaptive_dialog` untuk menu aksi sederhana.
- Jangan menggunakan bottom sheet atau dialog untuk informasi yang sebenarnya lebih tepat ditampilkan langsung pada halaman.
Contoh benar:
- Filter daftar kendaraan ditampilkan menggunakan `showModalBottomSheet`.
- Menu pilihan aksi sederhana ditampilkan menggunakan `showModalActionSheet`.
Contoh salah:
- Filter ditampilkan sebagai dialog kecil sehingga seluruh pilihan terpotong.
- Bottom sheet dengan banyak konten tidak dapat di-scroll.
- Menu aksi sederhana dibuat menggunakan layout modal yang rumit tanpa alasan.
---
# Aturan Tipografi
## 17. Penggunaan Bold
Gunakan ketebalan teks secara terarah untuk memperjelas informasi yang penting.
Ketentuan:
- Bedakan teks yang memang membutuhkan penekanan dengan teks biasa.
- Gunakan bold untuk judul, informasi utama, nilai penting, atau elemen yang membutuhkan penekanan sesuai hierarki tampilan.
- Jangan menggunakan bold pada seluruh teks.
- Jangan membuat teks biasa menjadi terlalu dominan dibandingkan informasi utama.
- Pertahankan konsistensi penggunaan ketebalan teks pada bagian yang memiliki fungsi serupa.
Contoh benar:
- Judul halaman menggunakan ketebalan yang lebih tegas daripada deskripsi.
- Nilai total transaksi mempunyai penekanan lebih kuat daripada labelnya.
Contoh salah:
- Seluruh label, deskripsi, dan nilai menggunakan bold.
- Informasi tambahan menggunakan ketebalan lebih dominan daripada informasi utama.
- Teks penting tidak mempunyai penekanan yang membedakannya dari teks biasa.
## 18. Hierarki Visual Label, Sub-Label, dan Nilai
Pada tampilan yang menyajikan informasi berjenjang, setiap tingkat teks wajib mempunyai perbedaan gaya visual yang dapat dikenali.
Ketentuan:
- Label, sub-label, dan nilai wajib mempunyai perbedaan minimal satu properti gaya teks.
- Perbedaan dapat berupa ukuran font, ketebalan, warna, atau kombinasi beberapa properti.
- Tidak diperbolehkan dua tingkat informasi yang berbeda menggunakan gaya teks yang identik apabila keduanya mempunyai fungsi hierarki yang berbeda.
- Jangan menentukan ukuran font secara sembarangan.
- Gunakan `Theme.of(context).textTheme` sebagai dasar gaya teks.
- Gunakan `copyWith()` apabila diperlukan untuk menyesuaikan ketebalan, warna, atau properti lainnya.
- Pastikan hierarki tetap terlihat jelas pada tema terang dan gelap.
Contoh benar:
```dart
final textTheme = Theme.of(context).textTheme;
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'Total Pengeluaran',
      style: textTheme.bodySmall,
    ),
    Text(
      'Pengeluaran bulan ini',
      style: textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
      ),
    ),
    Text(
      'Rp500.000',
      style: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
);
```
Contoh salah:
```dart
final style = Theme.of(context).textTheme.bodyMedium;
Column(
  children: [
    Text('Total Pengeluaran', style: style),
    Text('Pengeluaran bulan ini', style: style),
    Text('Rp500.000', style: style),
  ],
);
```
Ketiga tingkat informasi menggunakan gaya teks yang sama sehingga hierarki visual tidak terlihat.
---
# Pemeriksaan Wajib Sebelum Menyelesaikan Pekerjaan
Setiap pekerjaan yang membuat, mengubah, atau menganalisis UI wajib melewati pemeriksaan berikut:
1. Periksa apakah seluruh tampilan mengikuti referensi `optimasi_ui.md`.
2. Periksa apakah teks menggunakan bahasa formal dan baku.
3. Periksa apakah tujuan setiap tombol dan tindakan sudah jelas.
4. Periksa apakah operasi asynchronous memberikan status yang sesuai.
5. Periksa apakah feedback sistem sesuai dengan hasil operasi sebenarnya.
6. Periksa apakah proses background tidak merusak integritas data.
7. Periksa apakah terdapat rebuild yang tidak diperlukan.
8. Periksa apakah resource yang harus di-dispose sudah dikelola dengan benar.
9. Periksa seluruh padding tepi layar, termasuk penggunaan widget reusable pada setiap halaman.
10. Periksa apakah jarak dan spacing sudah sesuai dengan referensi desain.
11. Periksa loading dan penguncian aksi.
12. Periksa penggunaan `AppToast`.
13. Periksa `SafeArea`.
14. Periksa area sentuh dan tooltip.
15. Periksa modal dan bottom sheet.
16. Periksa penggunaan bold serta hierarki teks.
## Ketentuan pelaporan
Setelah pemeriksaan selesai, sampaikan:
- Aturan yang sudah terpenuhi.
- Pelanggaran yang ditemukan.
- File dan lokasi kode yang mengalami pelanggaran.
- Perbaikan yang sudah dilakukan.
- Bagian yang belum dapat diverifikasi beserta alasannya.
Khusus pemeriksaan padding tepi layar, wajib sebutkan:
- Halaman yang diperiksa.
- Widget reusable yang diperiksa.
- Halaman lain yang menggunakan widget reusable tersebut.
- Parent yang bertanggung jawab memberikan padding.
- Status akhir setiap temuan.
**Larangan:** Jangan menyatakan seluruh aturan sudah terpenuhi hanya karena file widget yang sedang dikerjakan sudah mempunyai padding. Pemeriksaan harus mencakup struktur parent dan seluruh halaman yang menggunakan widget tersebut.


// ============================================================
// FILE: .agents/rules/global/setup_prettier.md
// ============================================================

# Pengaturan dan Penggunaan Prettier
## 1. Tujuan
Gunakan Prettier sebagai formatter untuk menjaga konsistensi format file yang didukung, terutama Markdown, JSON, dan JSONC.
Pengaturan Prettier harus mengikuti konfigurasi proyek dan tidak boleh diubah berdasarkan preferensi pribadi AI.
## 2. File Konfigurasi Wajib
Pastikan kedua file berikut tersedia di root proyek:
1. `.prettierrc`
2. `.prettierignore`
Jangan membuat konfigurasi Prettier tambahan dengan nama berbeda yang berpotensi menimbulkan konflik.
### A. File `.prettierrc`
Apabila file belum tersedia, buat file tersebut.
Apabila sudah tersedia, sesuaikan isinya dengan konfigurasi berikut:
```json
{
  "trailingComma": "none",
  "overrides": [
    {
      "files": ["*.json"],
      "options": {
        "parser": "json",
        "trailingComma": "none"
      }
    },
    {
      "files": [
        "*.jsonc",
        "tsconfig*.json",
        "jsconfig.json",
        "devcontainer.json",
        "language-configuration.json"
      ],
      "options": {
        "parser": "jsonc",
        "trailingComma": "none"
      }
    }
  ]
}
```
Ketentuan:
- Pertahankan seluruh pengaturan tersebut.
- Jangan mengubah nilai `trailingComma`.
- Pastikan JSON menggunakan parser `json`.
- Pastikan JSONC dan file konfigurasi yang tercantum menggunakan parser `jsonc`.
- Jangan menambahkan pengaturan lain tanpa kebutuhan yang jelas dan persetujuan pengguna.
### B. File `.prettierignore`
Apabila file belum tersedia, buat file tersebut.
Apabila sudah tersedia, periksa isinya terlebih dahulu. Tambahkan pola pengecualian yang belum tersedia tanpa menghapus aturan pengecualian lain yang masih relevan.
Gunakan konfigurasi dasar berikut:
```gitignore
# Git dan dependensi JavaScript
.git/
node_modules/
# Cache dan dependensi Flutter/Dart
.dart_tool/
.pub/
.packages
# Hasil build dan pengujian
**/build/
**/coverage/
# File metadata hasil generate Flutter
.flutter-plugins
.flutter-plugins-dependencies
# Kode Dart hasil generate
**/*.g.dart
**/*.freezed.dart
# Hasil generate platform Android dan iOS
**/.gradle/
**/Pods/
**/ephemeral/
```
Ketentuan:
- Jangan mengabaikan seluruh folder `lib/`, `test/`, atau folder kode sumber lainnya.
- Jangan mengabaikan seluruh file Markdown, JSON, atau JSONC.
- Jangan membuat pola pengecualian yang terlalu luas sehingga file konfigurasi atau dokumentasi buatan pengguna ikut terabaikan.
- Pertahankan pola pengecualian tambahan yang sudah dibuat pengguna.
## 3. Aturan Penggunaan Prettier
1. Gunakan Prettier hanya untuk jenis file yang didukung.
2. Untuk file Markdown, JSON, dan JSONC, ikuti konfigurasi `.prettierrc`.
3. Jangan menggunakan Prettier untuk memformat file Dart.
4. Untuk seluruh file Dart, gunakan `dart format` sesuai SDK Dart yang digunakan proyek.
5. Jangan mengubah isi, maksud, atau perilaku kode ketika hanya diminta melakukan pemformatan.
6. Jangan mengubah pengaturan Prettier hanya agar hasil pemformatan sesuai preferensi pribadi AI.
7. Jangan memformat file yang masuk dalam `.prettierignore`.
8. Jangan memasang Prettier secara otomatis tanpa memeriksa apakah Prettier sudah tersedia.
9. Jangan membuat atau mengubah `package.json` maupun file lock hanya untuk memasang Prettier tanpa persetujuan pengguna.
## 4. Pemeriksaan Konfigurasi
Sebelum menggunakan Prettier:
1. Pastikan `.prettierrc` tersedia dan berisi konfigurasi yang ditentukan.
2. Pastikan `.prettierignore` tersedia dan berisi pola pengecualian yang ditentukan.
3. Pastikan Prettier tersedia di lingkungan proyek atau sistem.
4. Pastikan jenis file yang akan diformat didukung oleh Prettier.
Apabila Prettier tidak tersedia, laporkan kondisi tersebut. Jangan menganggap pemformatan berhasil.
## 5. Pemeriksaan Hasil Pemformatan
Setelah menjalankan Prettier:
1. Pastikan proses pemformatan berhasil.
2. Periksa hasil perubahan.
3. Pastikan tidak ada file yang seharusnya diabaikan ikut berubah.
4. Pastikan tidak ada perubahan isi yang tidak berkaitan dengan pemformatan.
5. Laporkan file yang berhasil diformat dan file yang gagal diformat.
## 6. Batasan Pekerjaan
- Jangan menjalankan pemformatan seluruh proyek apabila pengguna hanya meminta pemformatan file tertentu.
- Jangan mengubah file lain yang tidak berkaitan dengan tugas.
- Jangan mengubah aturan format tanpa alasan yang jelas.
- Jangan menyatakan pemeriksaan berhasil apabila belum benar-benar dijalankan.
**Prinsip utama:** Gunakan Prettier untuk file yang didukung dan `dart format` untuk kode Dart. Seluruh pemformatan wajib mengikuti konfigurasi proyek.


// ============================================================
// FILE: .agents/rules/proyek/aturan_khusus.md
// ============================================================

# Aturan Khusus Proyek
## Penanganan AsyncValue (Riverpod) untuk ID Terpilih
Ketentuan berikut wajib diterapkan agar kesalahan runtime terkait `selectedId`/ID terpilih tidak terulang:
1. **Jangan gunakan `.value` atau `.valueOrNull` pada `AsyncValue` hasil `ref.watch(...)` di dalam `build` maupun di dalam builder widget (mis. `itemBuilder` `ListView.builder`).**
   - Gunakan `.asData?.value` atau `.maybeWhen(data: (id) => id, orElse: () => null)` untuk membaca nilai dengan aman terhadap status loading/error.
   - Contoh benar: `ref.watch(selectedKendaraanIdProvider).asData?.value`
   - Contoh salah: `ref.watch(selectedKendaraanIdProvider).value`
2. **Setiap `AsyncValue` yang di-`watch` wajib diperiksa statusnya dengan urutan: `.isLoading` terlebih dahulu, lalu `.hasError`, baru `.requireValue`.**
   - Gabungkan pemeriksaan loading/error untuk semua provider yang digunakan di `build`.
   - Contoh:
     ```dart
     if (kmAsync.isLoading || kendaraanAsync.isLoading || selectedKendaraanIdAsync.isLoading) {
       return const _LoadingView();
     }
     if (kmAsync.hasError || kendaraanAsync.hasError || selectedKendaraanIdAsync.hasError) {
       return _buildError();
     }
     kmAsync.requireValue;
     kendaraanAsync.requireValue;
     selectedKendaraanIdAsync.requireValue;
     ```
3. **Jangan memanggil `ref.watch(...)` di dalam `itemBuilder`, `builder`, atau callback widget.**
   - Baca `AsyncValue` sekali di awal `build`, lalu teruskan nilainya melalui parameter ke widget/fungsi builder.
   - Contoh: `_buildDrawer(kendaraanState, selectedKendaraanIdAsync.asData?.value)` dan gunakan parameter di dalam `itemBuilder`.
4. **Gunakan `ref.read(...)` (bukan `ref.watch`) di dalam callback aksi (mis. `onTap`) ketika hanya membutuhkan nilai sekali.**
5. **Pastikan `flutter analyze` bersih sebelum menyatakan perubahan selesai.**
## Registrasi Delegate Lokalisasi `material_ui` untuk `adaptive_dialog`
Proyek menggunakan paket `adaptive_dialog` (mandat Aturan 4.5 `aturan_pemanfaatan_sdk_dan_paket.md`) yang secara internal bergantung pada paket `material_ui`. Paket `material_ui` mendefinisikan kelas `MaterialLocalizations` miliknya sendiri (berbeda dari `MaterialLocalizations` milik Flutter SDK). Komponen `adaptive_dialog` mencari `MaterialLocalizations` dari `material_ui` melalui `Localizations.of<material_ui.MaterialLocalizations>(context)`. Jika delegate untuk tipe tersebut tidak terdaftar di `MaterialApp.localizationsDelegates`, nilai yang dikembalikan adalah `null`, dan pemanggilan berikutnya menggunakan null-check operator (`!`) sehingga aplikasi melempar `Null check operator used on a null value` saat dialog ditampilkan.
**Cakupan:**
- `lib/app.dart` — `App.build`, khususnya `MaterialApp.localizationsDelegates` dan `supportedLocales`.
- Kelas `_MaterialUiLocalizationsDelegate` di `lib/app.dart`.
- Setiap penggunaan `adaptive_dialog` (`showOkCancelAlertDialog`, `showModalActionSheet`, dan sejenisnya) di seluruh fitur.
**Aturan wajib:**
1. `MaterialApp` wajib mendaftarkan delegate lokalisasi khusus untuk `material_ui.MaterialLocalizations` selain tiga delegate global Flutter (`GlobalMaterialLocalizations`, `GlobalWidgetsLocalizations`, `GlobalCupertinoLocalizations`).
2. Delegate khusus tersebut wajib memiliki `isSupported` yang mengembalikan `true` untuk locale yang didukung aplikasi (proyek ini menggunakan `Locale('id', 'ID')`), karena delegate bawaan `material_ui` (`DefaultMaterialLocalizations.delegate`) hanya mendukung `locale.languageCode == 'en'`.
3. Metode `load` delegate khusus wajib memanggil `material_ui.DefaultMaterialLocalizations.load(locale)`.
4. `supportedLocales` wajib tetap memuat `Locale('id', 'ID')` agar delegate global Flutter dan delegate `material_ui` selaras.
5. Jangan menghapus delegate khusus ini meskipun tidak ada error analyzer, karena error hanya muncul pada runtime saat dialog ditampilkan.
**Larangan:**
- Jangan mengandalkan `material_ui.DefaultMaterialLocalizations.delegate` langsung pada `MaterialApp.localizationsDelegates`, karena `isSupported`-nya hanya `true` untuk locale `en`, sehingga pada locale `id` delegate tidak dimuat dan `Localizations.of` mengembalikan `null`.
- Jangan menghapus `_MaterialUiLocalizationsDelegate` dari `localizationsDelegates` untuk "merapikan" kode, meskipun analyzer tidak melaporkan masalah.
- Jangan mengganti delegate khusus dengan delegate Flutter bawaan (`GlobalMaterialLocalizations.delegate`) karena tipe `MaterialLocalizations` yang dicari `adaptive_dialog`/`material_ui` berbeda dari tipe Flutter.
**Alasan:**
Paket `material_ui` (versi terpasang `^1.10.0`) mendefinisikan kelas `MaterialLocalizations` tersendiri yang tidak identik dengan `MaterialLocalizations` milik Flutter SDK. Delegate bawaan paket tersebut (`_MaterialLocalizationsDelegate`) hanya mengembalikan `true` pada `isSupported` untuk `locale.languageCode == 'en'`. Aplikasi ini mendukung `Locale('id', 'ID')`, sehingga pada runtime delegate bawaan tidak dimuat, `Localizations.of<material_ui.MaterialLocalizations>(context)` mengembalikan `null`, dan `adaptive_dialog` memanggil null-check operator pada nilai tersebut → `Null check operator used on a null value`. Delegate khusus dengan `isSupported => true` memastikan `DefaultMaterialLocalizations` selalu dimuat untuk locale apa pun yang didukung aplikasi.
**Dampak apabila dilanggar:**
- `adaptive_dialog` melempar `Null check operator used on a null value` saat `showOkCancelAlertDialog`/`showModalActionSheet` dipanggil.
- Dialog konfirmasi (termasuk konfirmasi penghapusan data yang diwajibkan oleh Aturan UX 1) gagal ditampilkan, sehingga pengguna tidak dapat memberikan konfirmasi sebelum operasi destruktif.
- Error bersifat runtime dan tidak terdeteksi oleh `flutter analyze`, sehingga berpotensi lolos ke APK.
**Rujukan implementasi:**
- `lib/app.dart` — kelas `_MaterialUiLocalizationsDelegate` dan pendaftarannya pada `MaterialApp.localizationsDelegates`.
- `pubspec.yaml` — `adaptive_dialog: ^3.0.1`, `material_ui: ^1.10.0`, `flutter_localizations` (SDK).
- Source paket: `~/.pub-cache/hosted/pub.dev/material_ui-1.10.0/lib/src/material_localizations.dart` — kelas `MaterialLocalizations`, `DefaultMaterialLocalizations`, dan `_MaterialLocalizationsDelegate.isSupported` (`locale.languageCode == 'en'`).
- Aturan global: `aturan_lainnya.md` poin 33 (Lokalisasi Aplikasi), `aturan_pemanfaatan_sdk_dan_paket.md` bagian 4.5 (adaptive_dialog).
**Contoh benar:**
```dart
import 'package:material_ui/material_ui.dart' as mui;
class _MaterialUiLocalizationsDelegate
    extends LocalizationsDelegate<mui.MaterialLocalizations> {
  const _MaterialUiLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<mui.MaterialLocalizations> load(Locale locale) =>
      mui.DefaultMaterialLocalizations.load(locale);
  @override
  bool shouldReload(
    covariant LocalizationsDelegate<mui.MaterialLocalizations> old,
  ) =>
      false;
}
MaterialApp(
  supportedLocales: const [Locale('id', 'ID')],
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    _MaterialUiLocalizationsDelegate(),
  ],
);
```
**Contoh salah:**
```dart
MaterialApp(
  supportedLocales: const [Locale('id', 'ID')],
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    // material_ui.DefaultMaterialLocalizations.delegate tidak didaftarkan.
    // Delegate bawaan material_ui hanya isSupported untuk locale 'en'.
  ],
);
```
**Penjelasan perbedaan:**
Contoh benar mendaftarkan delegate khusus dengan `isSupported => true` sehingga `material_ui.DefaultMaterialLocalizations` selalu dimuat untuk locale `id`, dan `adaptive_dialog` memperoleh instance `MaterialLocalizations` yang tidak `null`. Contoh salah mengandalkan delegate global Flutter atau delegate bawaan `material_ui`; pada locale `id` delegate bawaan `material_ui` tidak dimuat, `Localizations.of<material_ui.MaterialLocalizations>(context)` mengembalikan `null`, dan `adaptive_dialog` melempar `Null check operator used on a null value` saat dialog ditampilkan.
## Padding Tepi Layar pada `KendaraanTerpilihList`
`KendaraanTerpilihList` (`lib/shared/widget/kendaraan_terpilih_list.dart`) merupakan widget reusable yang menampilkan daftar chip kendaraan secara horizontal. Widget ini **tidak** menyertakan padding tepi layar di dalam dirinya sendiri (sesuai `optimasi_ux.md` §10 — padding tepi layar merupakan tanggung jawab container halaman). Jika halaman tidak membungkus widget ini dengan `Padding`, chip paling kiri/kanan akan menempel pada batas layar.
**Cakupan:**
- `lib/shared/widget/kendaraan_terpilih_list.dart` — widget reusable.
- Seluruh halaman yang menggunakan widget ini: `bahan_bakar_page.dart`, `km_page.dart`, `impian_page.dart`, `transaksi_page.dart`, `dashboard_page.dart`, `pengingat_page.dart`, `jadwal_service_page.dart`, `komponen_page.dart`, `statistik_bahan_bakar.dart`.
**Aturan wajib:**
1. Setiap halaman yang menggunakan `KendaraanTerpilihList` wajib membungkusnya dengan `Padding` (screen-edge padding) pada lapisan halaman.
2. Nilai padding mengikuti standar horizontal yang sudah digunakan halaman tersebut (mis. `EdgeInsets.all(12)` pada `bahan_bakar_page.dart`, `EdgeInsets.all(16)` pada `km_page.dart`). Jangan memaksakan satu nilai universal yang bertentangan dengan standar halaman.
3. Jangan menambahkan padding tepi layar di dalam widget `KendaraanTerpilihList` itu sendiri.
**Larangan:**
- Jangan menempatkan `KendaraanTerpilihList` langsung di dalam `Column`/`Row` halaman tanpa pembungkus `Padding`, karena chip akan menempel pada tepi layar.
- Jangan memodifikasi `KendaraanTerpilihList` untuk menambahkan padding tepi layar, karena akan menyebabkan padding ganda pada halaman yang sudah membungkusnya.
**Alasan:**
Widget ini reusable dan dipakai di banyak halaman dengan konteks padding yang berbeda. Tanggung jawab screen-edge padding berada pada container halaman (per `optimasi_ux.md` §10). Sebelumnya `bahan_bakar_page.dart` menempatkan widget ini langsung di `Column` tanpa `Padding`, sehingga chip menempel pada tepi layar.
**Dampak apabila dilanggar:**
- Chip kendaraan menempel pada batas kiri/kanan layar, melanggar aturan padding tepi layar (`optimasi_ux.md` §10).
- Inconsistent dengan halaman lain (`km_page.dart`) yang sudah membungkus widget ini dengan `Padding`.
**Rujukan implementasi:**
- `lib/fitur/bahan_bakar/page/bahan_bakar_page.dart` — `Padding(padding: const EdgeInsets.all(12), child: KendaraanTerpilihList(...))`.
- `lib/fitur/km/page/km_page.dart` — pola yang sama (`Padding` + `KendaraanTerpilihList`).
- `lib/shared/widget/kendaraan_terpilih_list.dart` — widget reusable tanpa screen-edge padding.
- `.agents/rules/global/optimasi_ux.md` §10 — aturan padding tepi layar.
**Contoh benar:**
```dart
body: Column(
  children: [
    Padding(
      padding: const EdgeInsets.all(12),
      child: KendaraanTerpilihList(
        listKendaraan: kendaraanState.listKendaraan,
        selectedId: selectedId,
        onSelected: (kendaraan) {
          setState(() => _kendaraanTerpilih = kendaraan);
        },
        onReload: _reloadKendaraanTerpilih,
      ),
    ),
    Expanded(child: _buildListBbm(context, bahanBakarState, kendaraanState)),
  ],
),
```
**Contoh salah:**
```dart
body: Column(
  children: [
    KendaraanTerpilihList(
      listKendaraan: kendaraanState.listKendaraan,
      selectedId: selectedId,
      onSelected: (kendaraan) {
        setState(() => _kendaraanTerpilih = kendaraan);
      },
      onReload: _reloadKendaraanTerpilih,
    ),
    Expanded(child: _buildListBbm(context, bahanBakarState, kendaraanState)),
  ],
),
```
## Navigasi Tab Utama (Home) — Inisialisasi Lazy dan Retensi State
**Cakupan:**
- `lib/home.dart` — kelas `Home` / `_HomeState`, khususnya `build` (IndexedStack), `_saatPilihTab`, dan `_scrollKeAtas`.
- Kelima tab: Dashboard, KM, Jadwal Service, Transaksi, Lainnya, beserta `GlobalKey` masing-masing (`_kunciDashboard`, `_kunciKm`, `_kunciJadwal`, `_kunciTransaksi`, `_kunciLainnya`).
**Aturan wajib:**
1. Gunakan `IndexedStack` dengan daftar yang dibangun secara **lazy**: tab hanya dibuat saat pertama kali dipilih, lalu tetap dipertahankan (state tidak dibuang).
2. Simpan tab yang sudah pernah dibuka dalam `Set<int> _tabTerbuka` (awalnya `{0}`). Tambahkan indeks ke set ini sebelum mengubah `_selectedIndex` ke tab baru.
3. Setiap tab yang belum pernah dibuka direpresentasikan sebagai `SizedBox.shrink()` pada slot IndexedStack-nya, sehingga tidak membangun widget/provider tab tersebut.
4. Pertahankan `GlobalKey<State<...>>` per tab agar `currentState` tetap dapat diakses untuk fitur scroll-to-top setelah tab dibuka.
5. Deteksi double-tap pada tab yang sedang aktif dengan jendela waktu `<= 500ms` (`_durasiDoubleTap`), lalu panggil `_scrollKeAtas(i)` dan reset `_lastTapTime = null`.
6. Pada `_scrollKeAtas`, periksa `state == null` terlebih dahulu (tab belum dibuka) dan log `L.w` + `return` (jangan crash/cast).
7. Hanya panggil `scrollToTop()` dan log sukses apabila state mengimplementasikan `ScrollKeAtas`; log `L.w` jika tidak.
**Larangan:**
- Jangan kembali ke pola `IndexedStack` dengan kelima halaman selalu dibangun sekaligus (menyebabkan lag saat pindah tab dan beban awal tinggi).
- Jangan menghapus `_tabTerbuka` / lazy loading dengan alasan "merapikan", karena itu akan memicu rebuild/provider tab yang belum dikunjungi.
- Jangan menghapus `GlobalKey` per tab, karena fitur double-tap scroll-to-top bergantung pada `currentState`.
- Jangan memanggil `scrollToTop()` tanpa memeriksa `state == null` dan tipe `ScrollKeAtas`.
- Jangan log "scroll berhasil" tanpa benar-benar memanggil `scrollToTop()`.
**Alasan:**
Sebelumnya semua tab dibangun dan tetap hidup sejak awal, sehingga perubahan data/provider di tab lain dapat memicu rebuild dan beban memori tinggi, menyebabkan pindah tab terasa berat. Lazy loading mengurangi beban awal dan beban tab yang belum dikunjungi, sambil tetap mempertahankan state tab yang sudah dibuka. Double-tap scroll-to-top bergantung pada `GlobalKey.currentState`; tab yang belum dibuka memiliki state `null` dan harus ditangani agar tidak crash.
**Dampak apabila dilanggar:**
- Lag saat pindah tab dan saat pertama membuka aplikasi.
- State tab (scroll position, filter, input) hilang atau dibangun ulang.
- Crash null saat double-tap pada tab yang belum pernah dibuka.
- Log menyesatkan yang menyatakan scroll berhasil padahal tidak dieksekusi.
**Rujukan implementasi:**
- `lib/home.dart` — `_tabTerbuka`, `IndexedStack` + `List.generate`, `_saatPilihTab`, `_scrollKeAtas`.
- `lib/shared/widget/scroll_ke_atas.dart` — interface `ScrollKeAtas`.
- Halaman tab yang mengimplementasikan `ScrollKeAtas`: `dashboard_page.dart`, `km_page.dart`, `jadwal_service_page.dart`, `transaksi_page.dart`, `lainnya_page.dart`.
**Contoh benar:**
```dart
final Set<int> _tabTerbuka = {0};
IndexedStack(
  index: _selectedIndex,
  children: List<Widget>.generate(5, (i) {
    if (!_tabTerbuka.contains(i)) {
      return const SizedBox.shrink();
    }
    return switch (i) {
      0 => DashboardPage(key: _kunciDashboard),
      1 => KmPage(key: _kunciKm),
      _ => LainnyaPage(key: _kunciLainnya),
    };
  }),
)
void _saatPilihTab(int i) {
  final sekarang = DateTime.now();
  final lastTap = _lastTapTime;
  final tabSama = i == _selectedIndex;
  final doubleTap =
      tabSama && lastTap != null && sekarang.difference(lastTap) <= _durasiDoubleTap;
  if (doubleTap) {
    _scrollKeAtas(i);
    _lastTapTime = null;
    return;
  }
  if (!tabSama) {
    setState(() {
      _tabTerbuka.add(i);
      _selectedIndex = i;
    });
  }
  _lastTapTime = sekarang;
}
void _scrollKeAtas(int i) {
  final state = switch (i) {
    0 => _kunciDashboard.currentState,
    _ => _kunciLainnya.currentState,
  };
  if (state == null) {
    L.w('Scroll ke atas diabaikan: state tab ke-$i belum tersedia');
    return;
  }
  if (state case final ScrollKeAtas scrollable) {
    try {
      scrollable.scrollToTop();
      L.i('Scroll ke atas pada tab ke-$i');
    } catch (e, s) {
      L.e('Gagal scroll ke atas pada tab ke-$i: $e $s');
    }
  } else {
    L.w('Scroll ke atas diabaikan: tab ke-$i tidak mengimplementasikan ScrollKeAtas');
  }
}
```
**Contoh salah:**
```dart
// Semua tab selalu dibangun sejak awal.
IndexedStack(
  index: _selectedIndex,
  children: const [
    DashboardPage(key: _kunciDashboard),
    KmPage(key: _kunciKm),
    JadwalServicePage(key: _kunciJadwal),
    TransaksiPage(key: _kunciTransaksi),
    LainnyaPage(key: _kunciLainnya),
  ],
)
// Deteksi double-tap tidak reset dan log sukses tanpa memanggil scroll.
void _saatPilihTab(int i) {
  final sekarang = DateTime.now();
  final lastTap = _lastTapTime;
  final doubleTap =
      i == _selectedIndex && lastTap != null && sekarang.difference(lastTap) < _durasiDoubleTap;
  if (doubleTap) {
    _scrollKeAtas(i);
  } else {
    setState(() => _selectedIndex = i);
  }
  _lastTapTime = sekarang;
}
void _scrollKeAtas(int i) {
  final state = ...;
  if (state case final ScrollKeAtas scrollable) {
    try {
      scrollable.scrollToTop();
    } catch (e, s) {
      L.e('Gagal scroll ke atas pada tab ke-$i: $e $s');
    }
  }
  L.i('Scroll ke atas pada tab ke-$i'); // log menyesatkan
}
```
**Penjelasan perbedaan:**
Contoh benar membangun tab secara lazy (hanya saat pertama dipilih) dan tetap mempertahankan state, mendeteksi double-tap dengan reset waktu, serta hanya log sukses setelah `scrollToTop()` benar-benar dipanggil. Contoh salah membangun semua tab sejak awal (menyebabkan lag), tidak reset waktu setelah double-tap, dan log sukses meski scroll tidak dieksekusi (menyesatkan debugging).
## Kelengkapan Refresh pada `_buildError` (Halaman Multi-Provider)
**Cakupan:**
- Halaman yang me-`watch` lebih dari satu provider dan memiliki tombol "Coba lagi" / refresh, khususnya `DashboardPage` (`lib/fitur/dashboard/page/dashboard_page.dart`), `JadwalServicePage` (`lib/fitur/jadwal_service/page/jadwal_service_page.dart`), `KmPage`, dan `TransaksiPage`.
**Aturan wajib:**
1. Setiap provider yang di-`watch` di `build` (dan diperiksa loading/error-nya) wajib ikut di-`refresh` pada handler retry di `_buildError`.
2. Jangan melewatkan provider yang "sekunder" (mis. `mataUangProvider`, `kmProvider`) hanya karena tidak menjadi fokus utama halaman.
3. Urutan pemeriksaan `AsyncValue` tetap loading → error → data untuk semua provider terkait.
**Larangan:**
- Jangan refresh sebagian provider saja di `_buildError` (mis. refresh `kendaraanProvider`, `kmProvider`, `jadwalServiceProvider`, `transaksiProvider`, `impianProvider` tetapi lupa `mataUangProvider`).
- Jangan menambah provider baru ke `build` tanpa menambahkan refresh-nya di `_buildError`.
**Alasan:**
`DashboardPage` sebelumnya me-`watch` `mataUangProvider` dan menanganinya di loading/error, tetapi handler retry tidak me-refresh-nya. Akibatnya saat retry, data mata uang lama/stale tetap dipakai dan tampilan saldo bisa tidak konsisten. Hal serupa berlaku untuk `JadwalServicePage` yang me-`watch` `kmProvider` (dipakai untuk skor urgensi) tetapi tidak me-refresh-nya saat retry.
**Dampak apabila dilanggar:**
- Data stale setelah retry (mis. saldo/mata uang atau skor urgensi jadwal tidak terbarui).
- Inconsistent state antara provider yang direfresh dan yang tidak.
**Rujukan implementasi:**
- `lib/fitur/dashboard/page/dashboard_page.dart` — `_buildError` (refresh `kendaraanProvider`, `kmProvider`, `jadwalServiceProvider`, `transaksiProvider`, `impianProvider`, `mataUangProvider`).
- `lib/fitur/jadwal_service/page/jadwal_service_page.dart` — `_buildError` (refresh `jadwalServiceProvider`, `riwayatJadwalServiceProvider`, `kendaraanProvider`, `kmProvider`).
**Contoh benar:**
```dart
onPressed: () {
  final _ = ref.refresh(kendaraanProvider);
  final _ = ref.refresh(kmProvider);
  final _ = ref.refresh(jadwalServiceProvider);
  final _ = ref.refresh(transaksiProvider);
  final _ = ref.refresh(impianProvider);
  final _ = ref.refresh(mataUangProvider); // jangan lupa provider sekunder
},
```
**Contoh salah:**
```dart
onPressed: () {
  final _ = ref.refresh(kendaraanProvider);
  final _ = ref.refresh(kmProvider);
  final _ = ref.refresh(jadwalServiceProvider);
  final _ = ref.refresh(transaksiProvider);
  final _ = ref.refresh(impianProvider);
   // mataUangProvider tidak direfresh -> data mata uang stale
 },
 ```
**Penjelasan perbedaan:**
Contoh benar me-refresh seluruh provider yang di-`watch` (termasuk `mataUangProvider`), sehingga retry menghasilkan state konsisten. Contoh salah melewatkan provider sekunder, menyebabkan data stale setelah retry.
## Penempatan Metode `_buildLoading` dan `_buildError` di Bagian Bawah Kelas State
**Cakupan:**
- Seluruh halaman yang menggunakan `ConsumerState`/`State` dengan metode `_buildLoading()` dan/atau `_buildError()` (mis. `dashboard_page.dart`, `km_page.dart`, dan halaman serupa).
**Aturan wajib:**
1. Tempatkan metode `_buildLoading()` dan `_buildError()` di **bagian paling bawah** kelas State, setelah metode-metode lain (mis. `_buildForm`, `_buildList`, helper).
2. Pertahankan urutan internal yang konsisten: `_buildLoading()` terlebih dahulu, kemudian `_buildError()`, sebelum penutup kelas `}`.
3. Pastikan metode tetap berada pada level anggota kelas (bukan metode lokal/nested di dalam metode lain).
4. Setelah memindahkan metode, jalankan `dart format` dan `flutter analyze` untuk memastikan tidak ada kesalahan kompilasi (mis. `undefined_method` akibat nesting).
**Larangan:**
- Jangan menempatkan `_buildLoading()`/`_buildError()` tepat setelah `build()` atau di tengah metode lain sehingga batas blok menjadi ambigu.
- Jangan memindahkan metode dengan memotong/memindahkan blok tanpa memeriksa penutupan kurung kurawal (`}`), karena metode dapat tidak sengaja tersarang di dalam metode lain.
**Alasan:**
Penempatan di bawah kelas memudahkan navigasi (UI utama di atas, fallback UI di bawah) dan mengikuti konvensi yang telah diterapkan pada halaman seperti `DashboardPage` dan `KmPage`. Pemindahan manual dengan edit tool berisiko merusak batas blok jika kurung kurawal tidak diperiksa.
**Dampak apabila dilanggar:**
- Struktur kelas tidak konsisten antar halaman.
- Risiko metode menjadi lokal/nested, menyebabkan `undefined_method` saat dipanggil dari `build()`.
**Rujukan implementasi:**
- `lib/fitur/dashboard/page/dashboard_page.dart` — `_buildLoading()` dan `_buildError()` di bagian bawah `_DashboardPageState`.
- `lib/fitur/km/page/km_page.dart` — `_buildError()` di bagian bawah `_KmPageState`.
**Contoh benar:**
```dart
class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    if (isLoading) return _buildLoading();
    if (hasError) return _buildError();
    return Scaffold(/* ... */);
  }
  Widget _buildCardKm(KmModel? kmTerbaru) { /* ... */ }
  Widget _buildLoading() {
    return Scaffold(/* ... */);
  }
  Widget _buildError() {
    return Scaffold(/* ... */);
  }
}
```
**Contoh salah:**
```dart
class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    if (isLoading) return _buildLoading();
    if (hasError) return _buildError();
    return Scaffold(/* ... */);
  }
  Widget _buildLoading() { /* ... */ } // terlalu atas
  Widget _buildError() { /* ... */ }
  Future<void> _simpan() async {
    Widget _buildError() { // tersarang (metode lokal) — SALAH
      return Scaffold(/* ... */);
    }
  }
}
```
**Penjelasan perbedaan:**
Contoh benar menempatkan `_buildLoading()` dan `_buildError()` di bawah kelas sebagai metode anggota (dapat dipanggil dari `build`). Contoh salah menempatkannya terlalu atas dan, pada kasus kedua, secara tidak sengaja menjadikannya metode lokal di dalam `_simpan()` sehingga tidak dapat dipanggil dari `build()` (`undefined_method`).
## Konsolidasi Pemuatan Data Dashboard ke Provider Async
**Cakupan:**
- `lib/fitur/dashboard/provider/dashboard_provider.dart` — `DashboardNotifier` (kelas Notifier).
- `lib/fitur/dashboard/page/dashboard_page.dart` — `_DashboardPageState.build`.
- Provider yang dikonsolidasi: `impianProvider`, `kmProvider`, `transaksiProvider`, `jadwalServiceProvider`.
**Aturan wajib:**
1. Gunakan satu provider async (`dashboardProvider`) sebagai sumber data tunggal untuk halaman dashboard, bukan me-`watch` banyak provider secara terpisah di `build`.
2. Pindahkan logika perhitungan (sorting, scoring, pemilihan item terdekat) dari page ke provider/notifier. Page hanya mengonsumsi state yang sudah diproses.
3. Di dalam notifier, gunakan `ref.watch(provider.future)` (bukan `ref.watch(provider)`) untuk sumber data asynchronous, sesuai aturan Riverpod.
4. Pastikan provider yang dikonsolidasi tetap memeriksa loading/error semua sumber data di dalam `_muatData`, dan page menangani loading/error dari `dashboardProvider` saja.
5. Jangan duplikasi logika perhitungan antara page dan provider.
**Larangan:**
- Jangan me-`watch` `kmProvider`, `jadwalServiceProvider`, `transaksiProvider`, `impianProvider` secara terpisah di `build` halaman dashboard setelah konsolidasi.
- Jangan menyimpan logika sorting/scoring di page setelah dipindahkan ke provider.
- Jangan menggunakan `ref.watch(provider)` (tanpa `.future`) di dalam notifier untuk sumber data async.
**Alasan:**
Sebelum konsolidasi, `DashboardPage` me-`watch` 5 provider secara terpisah dan melakukan perhitungan `_jadwalTerdekat`, `_skorUrgensi`, `_rasioKm`, `_rasioHari` di page. Hal ini menyebabkan page menjadi berat dan logika bisnis bercampur dengan UI. Setelah konsolidasi, page hanya me-`watch` `dashboardProvider(selectedKendaraanIdState)` dan provider menangani seluruh pemuatan dan perhitungan.
**Dampak apabila dilanggar:**
- Page menjadi berat dan sulit dipelihara.
- Duplikasi logika antara page dan provider.
- Risiko state tidak konsisten karena perhitungan di dua tempat.
- Rebuild yang tidak perlu karena page bergantung pada banyak provider.
**Rujukan implementasi:**
- `lib/fitur/dashboard/provider/dashboard_provider.dart` — `_muatData`, `_jadwalTerdekat`, `_skorUrgensi`, `_rasioKm`, `_rasioHari`.
- `lib/fitur/dashboard/page/dashboard_page.dart` — `build` yang hanya me-`watch` `dashboardProvider`.
**Contoh benar:**
```dart
// Provider: konsolidasi semua data dan perhitungan.
@Riverpod(keepAlive: true)
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Future<DashboardState> build(String? idKendaraan) async =>
      await _muatData(idKendaraan);
  Future<DashboardState> _muatData(String? idKendaraan) async {
    final impianState = await ref.watch(impianProvider.future);
    final kmState = await ref.watch(kmProvider.future);
    final transaksiState = await ref.watch(transaksiProvider.future);
    final jadwalState = await ref.watch(jadwalServiceProvider.future);
    // ... perhitungan di sini ...
    return DashboardState(/* ... */);
  }
}
// Page: hanya konsumsi provider tunggal.
final dashboardAsync = ref.watch(dashboardProvider(selectedKendaraanIdState));
if (dashboardAsync.isLoading) return _buildLoading();
if (dashboardAsync.hasError) return _buildError();
final dashboardState = dashboardAsync.requireValue;
```
**Contoh salah:**
```dart
// Page: me-watch banyak provider dan hitung di page (sebelum konsolidasi).
final kmAsync = ref.watch(kmProvider);
final jadwalAsync = ref.watch(jadwalServiceProvider);
final transaksiAsync = ref.watch(transaksiProvider);
final impianAsync = ref.watch(impianProvider);
// ... perhitungan _jadwalTerdekat, _skorUrgensi di page ...
```
**Penjelasan perbedaan:**
Contoh benar mengonsolidasi pemuatan dan perhitungan ke provider, sehingga page hanya mengonsumsi state yang sudah diproses. Contoh salah menyebarkan pemuatan dan perhitungan di page, menyebabkan page berat dan logika bercampur dengan UI.
## Migrasi State Dashboard dari List ke Field Scalar (Freezed)
**Cakupan:**
- `lib/fitur/dashboard/state/dashboard_state.dart` — `DashboardState`.
- `lib/fitur/dashboard/provider/dashboard_provider.dart` — `DashboardNotifier`.
**Aturan wajib:**
1. Gunakan field scalar yang spesifik (`kmTerbaru`, `saldo`, `jadwalServiceTerdekat`, `jumlahImpian`, `impianTercapai`) alih-alih `List<DashboardModel>` pada state dashboard.
2. Gunakan tipe model nullable (`KmModel?`, `JadwalServiceModel?`) untuk field yang mungkin tidak tersedia, bukan `double` dengan default 0.
3. Gunakan `@Default(0)` untuk field numerik yang selalu ada.
4. Perbarui file `.freezed.dart` melalui generator setelah mengubah state (jangan edit manual).
**Larangan:**
- Jangan menggunakan `List<DashboardModel>` untuk state dashboard jika data yang dibutuhkan hanya ringkasan (km terbaru, saldo, jadwal terdekat, jumlah impian).
- Jangan menggunakan `double` dengan default 0 untuk field yang seharusnya model (mis. `kmTerbaru` sebagai `double`).
- Jangan mengedit file `.freezed.dart` secara manual.
**Alasan:**
State dashboard awalnya menggunakan `List<DashboardModel> listDashboard`, kemudian dimigrasikan ke field scalar yang lebih spesifik. `kmTerbaru` awalnya `double` (nilai km saja), kemudian diubah ke `KmModel?` agar menyimpan model lengkap. Ini lebih type-safe dan menyederhanakan akses data di UI.
**Dampak apabila dilanggar:**
- State menjadi tidak type-safe (mis. `kmTerbaru` sebagai `double` kehilangan informasi model).
- UI harus melakukan pencarian/filter pada list untuk mendapatkan data yang dibutuhkan.
- Risiko error runtime karena data tidak sesuai tipe.
**Rujukan implementasi:**
- `lib/fitur/dashboard/state/dashboard_state.dart` — definisi Freezed.
- `lib/fitur/dashboard/state/dashboard_state.freezed.dart` — file generated.
**Contoh benar:**
```dart
@freezed
abstract class DashboardState with _$DashboardState {
  const DashboardState._();
  const factory DashboardState({
    KmModel? kmTerbaru,
    @Default(0) double saldo,
    JadwalServiceModel? jadwalServiceTerdekat,
    @Default(0) double jumlahImpian,
    @Default(0) double impianTercapai,
  }) = _DashboardState;
}
```
**Contoh salah:**
```dart
@freezed
abstract class DashboardState with _$DashboardState {
  const DashboardState._();
  const factory DashboardState({
    @Default([]) List<DashboardModel> listDashboard,
    @Default(0) double kmTerbaru, // seharusnya KmModel?
  }) = _DashboardState;
}
```
**Penjelasan perbedaan:**
Contoh benar menggunakan field scalar yang type-safe (`KmModel?`, `JadwalServiceModel?`) dan default value yang sesuai. Contoh salah menggunakan list yang memerlukan filter tambahan dan tipe `double` untuk km yang kehilangan informasi model.
## Family Provider untuk Parameter idKendaraan
**Cakupan:**
- `lib/fitur/dashboard/provider/dashboard_provider.dart` — `DashboardNotifier` dengan parameter `idKendaraan`.
- `lib/shared/provider/pemilih_kendaraan_provider.dart` — `pemilihKendaraan` dengan parameter `page` dan `value`.
**Aturan wajib:**
1. Gunakan family provider (`@Riverpod` dengan parameter pada `build`) ketika provider bergantung pada parameter eksternal (mis. `idKendaraan`).
2. Pastikan file `.g.dart` dihasilkan ulang setelah menambah/mengubah parameter `build`.
3. Berikan nama kelas Notifier yang konsisten (mis. `DashboardNotifier`, bukan `Dashboard`).
4. Gunakan `keepAlive: true` jika state perlu dipertahankan (mis. dashboard).
5. Gunakan `@Riverpod()` (auto-dispose) jika state tidak perlu dipertahankan (mis. pemilih kendaraan).
**Larangan:**
- Jangan menggunakan functional provider (`int dashboard(Ref ref)`) jika state perlu dimutasi melalui metode (gunakan Notifier kelas).
- Jangan menambah parameter pada `build` tanpa meregenerasi file `.g.dart`.
- Jangan menggunakan nama kelas Notifier yang tidak konsisten.
**Alasan:**
Dashboard provider awalnya adalah functional provider sederhana (`int dashboard(Ref ref) => 0`), kemudian dimigrasikan ke Notifier kelas, dan akhirnya menjadi family provider dengan parameter `idKendaraan`. Ini menunjukkan evolusi dari provider sederhana ke provider yang lebih kompleks dan reusable.
**Dampak apabila dilanggar:**
- Provider tidak dapat menerima parameter, sehingga tidak reusable untuk kendaraan berbeda.
- File `.g.dart` tidak sinkron dengan sumber, menyebabkan error kompilasi.
- Inconsistent naming menyebabkan kebingungan.
**Rujukan implementasi:**
- `lib/fitur/dashboard/provider/dashboard_provider.dart` — `DashboardNotifier` dengan `build(String? idKendaraan)`.
- `lib/fitur/dashboard/provider/dashboard_provider.g.dart` — file generated.
**Contoh benar:**
```dart
@Riverpod(keepAlive: true)
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Future<DashboardState> build(String? idKendaraan) async =>
      await _muatData(idKendaraan);
}
```
**Contoh salah:**
```dart
// Functional provider tanpa parameter (tidak bisa menerima idKendaraan).
@Riverpod(keepAlive: true)
int dashboard(Ref ref) {
  return 0;
}
```
**Penjelasan perbedaan:**
Contoh benar menggunakan Notifier kelas dengan parameter, sehingga provider dapat menerima `idKendaraan` dan menghasilkan state yang berbeda per kendaraan. Contoh salah menggunakan functional provider tanpa parameter, sehingga tidak dapat menerima input dan tidak dapat dimutasi.
## Penempatan Metode scrollToTop pada Kelas State
**Cakupan:**
- Halaman yang mengimplementasikan interface `ScrollKeAtas` (mis. `dashboard_page.dart`, `km_page.dart`).
- Metode `scrollToTop()`.
**Aturan wajib:**
1. Tempatkan metode `scrollToTop()` (implementasi interface `ScrollKeAtas`) di bagian **atas** kelas State, sebelum metode `build()`.
2. Pastikan metode tetap berada pada level anggota kelas.
3. Jangan menempatkan `scrollToTop()` di bagian bawah kelas (berbeda dari `_buildLoading`/`_buildError` yang ditempatkan di bawah).
**Larangan:**
- Jangan menempatkan `scrollToTop()` di bagian bawah kelas State (setelah `build()` dan helper lain).
- Jangan memindahkan metode tanpa memeriksa batas blok kurung kurawal.
**Alasan:**
Metode `scrollToTop()` adalah implementasi interface yang dipanggil dari luar (via `GlobalKey.currentState`), bukan dari dalam `build()`. Penempatannya di atas kelas (sebelum `build()`) memudahkan navigasi dan konsisten dengan pola yang diterapkan pada `DashboardPage`. Berbeda dari `_buildLoading`/`_buildError` yang ditempatkan di bawah karena merupakan fallback UI yang jarang dirujuk.
**Dampak apabila dilanggar:**
- Struktur kelas tidak konsisten antar halaman.
- Metode interface sulit ditemukan karena tercampur dengan helper internal.
**Rujukan implementasi:**
- `lib/fitur/dashboard/page/dashboard_page.dart` — `scrollToTop()` di atas `build()`.
**Contoh benar:**
```dart
class _DashboardPageState extends ConsumerState<DashboardPage>
    implements ScrollKeAtas {
  @override
  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```
**Contoh salah:**
```dart
class _DashboardPageState extends ConsumerState<DashboardPage>
    implements ScrollKeAtas {
  @override
  Widget build(BuildContext context) {
    // ...
  }
  // scrollToTop di bawah — tidak konsisten.
  @override
  void scrollToTop() {
    // ...
  }
}
```
**Penjelasan perbedaan:**
Contoh benar menempatkan `scrollToTop()` di atas `build()` sehingga metode interface mudah ditemukan. Contoh salah menempatkannya di bawah, tidak konsisten dengan pola yang diterapkan pada halaman lain.
## Nonaktifkan Konfigurasi Linter pada analysis_options.yaml
**Cakupan:**
- `analysis_options.yaml` — seluruh konfigurasi linter dan analyzer.
**Status:** Temuan/kendala yang perlu dilaporkan, bukan aturan wajib.
**Temuan:**
Pada commit `4cfa0c83`, seluruh konfigurasi linter dan analyzer pada `analysis_options.yaml` di-comment out (termasuk `include: package:flutter_lints/flutter.yaml`, rules linter, plugins riverpod_lint, dan analyzer exclude/language). Hal ini bertentangan dengan aturan global yang mewajibkan kode bersih dari temuan analyzer (`flutter analyze`).
**Dampak:**
- Analyzer tidak lagi melaporkan error/warning/info pada kode.
- Temuan potensial bug (null safety, unawaited futures, dll.) tidak terdeteksi.
- Kode dapat memiliki masalah yang tidak terdeteksi.
**Rekomendasi:**
- Aktifkan kembali konfigurasi linter dan analyzer.
- Jika terdapat konflik dengan kode yang ada, perbaiki kode agar sesuai dengan rules, bukan menonaktifkan rules.
- Jika rules tertentu memang tidak sesuai, nonaktifkan secara selektif dengan alasan yang jelas, bukan seluruhnya.
**Catatan:**
Ini adalah temuan dari evaluasi commit, bukan aturan baru. AI harus melaporkan temuan ini kepada pengguna dan tidak boleh mengubah `analysis_options.yaml` melalui command ini.
## Penggunaan EasyLoading Overlay pada Aksi Simpan (Form Jadwal Service)
**Cakupan:**
- `lib/fitur/jadwal_service/page/form_jadwal_service.dart` — `_FormJadwalServiceState._simpanForm` dan `_buildTombolSimpan`.
- Aksi simpan lain yang menggunakan `flutter_easyloading` sebagai overlay loading (sesuai `optimasi_ux.md` §12).
**Aturan wajib:**
1. Tampilkan overlay loading melalui `unawaited(EasyLoading.show(status: 'Menyimpan...'))` segera setelah flag `_isLoading` diaktifkan.
2. Sembunyikan overlay melalui `unawaited(EasyLoading.dismiss())` di dalam blok `finally`, sebelum mengembalikan `_isLoading` ke `false`.
3. Pertahankan guard double-submit di awal metode: `if (_isLoading) { L.w(...); return; }`.
4. Karena loading ditangani oleh overlay, tombol simpan tidak perlu menampilkan spinner sendiri maupun dinonaktifkan melalui `onPressed: _isLoading ? null : _simpanForm`; cukup panggil `_simpanForm` langsung.
5. Pastikan `_isLoading` dikembalikan ke `false` pada semua jalur (sukses, error, dan finally), dengan pemeriksaan `mounted` sebelum `setState`.
**Larangan:**
- Jangan menampilkan spinner di dalam tombol sekaligus overlay EasyLoading untuk aksi yang sama (redundan).
- Jangan menghilangkan guard `_isLoading` di awal metode ketika overlay digunakan, karena tombol tetap dapat ditekan berulang.
- Jangan memanggil `EasyLoading.dismiss()` tanpa `unawaited` atau di luar `finally`, karena overlay dapat tertinggal saat terjadi exception.
**Alasan:**
Pada form jadwal service, loading awalnya ditampilkan di dalam tombol (`CircularProgressIndicator` + `onPressed: _isLoading ? null : _simpanForm`). Setelah ditambahkan overlay EasyLoading, spinner di tombol menjadi redundan dan tombol dinonaktifkan secara manual tidak lagi diperlukan, karena guard `_isLoading` di awal `_simpanForm` sudah mencegah double-submit, sementara overlay memberikan feedback visual kepada pengguna.
**Dampak apabila dilanggar:**
- Overlay loading tertinggal (tidak hilang) ketika terjadi exception, sehingga UI terkunci.
- Double-submit dapat terjadi jika guard `_isLoading` dihilangkan.
- Tampilan loading ganda (spinner di tombol + overlay) yang tidak konsisten.
**Rujukan implementasi:**
- `lib/fitur/jadwal_service/page/form_jadwal_service.dart` — `_simpanForm` (guard, `EasyLoading.show`, `EasyLoading.dismiss` di `finally`).
- `.agents/rules/global/optimasi_ux.md` §12 — loading dan penguncian aksi.
**Contoh benar:**
```dart
Future<void> _simpanForm() async {
  if (_isLoading) {
    L.w('Form masih loading, simpan diabaikan');
    return;
  }
  // ... validasi ...
  setState(() => _isLoading = true);
  unawaited(EasyLoading.show(status: 'Menyimpan...'));
  try {
    // ... operasi simpan ...
  } on Exception catch (e, s) {
    L.e('Gagal menyimpan: $e $s');
    if (mounted) AppToast.gagal(context, 'Gagal menyimpan');
  } finally {
    if (mounted) {
      unawaited(EasyLoading.dismiss());
      setState(() => _isLoading = false);
    }
  }
}
Widget _buildTombolSimpan() {
  return OutlinedButton(
    onPressed: _simpanForm,
    child: const Text('Simpan'),
  );
}
```
**Contoh salah:**
```dart
Widget _buildTombolSimpan() {
  // Loading ganda: spinner di tombol + overlay EasyLoading.
  return OutlinedButton(
    onPressed: _isLoading ? null : _simpanForm,
    child: _isLoading
        ? const CircularProgressIndicator(strokeWidth: 2)
        : const Text('Simpan'),
  );
}
Future<void> _simpanForm() async {
  // Guard dihilangkan -> double-submit.
  setState(() => _isLoading = true);
  EasyLoading.show(status: 'Menyimpan...'); // tanpa unawaited
  try {
    // ...
  } finally {
    setState(() => _isLoading = false); // dismiss tidak dipanggil -> overlay tertinggal
  }
}
```
**Penjelasan perbedaan:**
Contoh benar menggunakan guard `_isLoading` di awal metode, overlay EasyLoading dengan `unawaited`, dan `EasyLoading.dismiss()` di `finally`, sehingga loading selalu dihentikan meskipun terjadi exception. Contoh salah menampilkan loading ganda, menghilangkan guard, dan tidak menjamin dismiss overlay.
## Preferensi State Lokal daripada Re-watch Provider pada Halaman
**Cakupan:**
- Halaman yang sudah menyimpan nilai terpilih dalam state lokal (`StatefulWidget`/`ConsumerState`), khususnya `DashboardPage` (`lib/fitur/dashboard/page/dashboard_page.dart`) dengan `_kendaraanTerpilih`.
- Provider yang menyediakan nilai terpilih secara asynchronous (mis. `selectedKendaraanIdProvider`).
**Aturan wajib:**
1. Jika nilai yang dibutuhkan sudah tersedia dalam state lokal widget (mis. `_kendaraanTerpilih?.id`), gunakan nilai tersebut langsung sebagai argumen provider, tanpa me-`watch` provider async yang menyediakan nilai yang sama.
2. Jangan menambahkan pemeriksaan `isLoading`/`hasError`/`requireValue` untuk provider yang tidak lagi di-`watch`.
3. Jika sebuah provider dihapus dari `build`, pastikan juga dihapus dari daftar refresh pada `_buildError` (lihat aturan "Kelengkapan Refresh pada `_buildError`").
**Larangan:**
- Jangan me-`watch` provider async yang nilainya sudah tersedia di state lokal, hanya untuk meneruskannya ke provider lain.
- Jangan mempertahankan pemeriksaan `AsyncValue` untuk provider yang sudah tidak di-`watch`.
**Alasan:**
`DashboardPage` sebelumnya me-`watch` `selectedKendaraanIdProvider` dan menanganinya (`isLoading`/`hasError`/`requireValue`) hanya untuk meneruskan nilainya ke `dashboardProvider(selectedKendaraanIdState)`. Karena nilai tersebut sudah tersedia sebagai `_kendaraanTerpilih?.id` (state lokal), re-watch provider async menambah kompleksitas penanganan `AsyncValue` tanpa manfaat. Penggunaan state lokal menyederhanakan `build` dan menghindari rebuild tambahan.
**Dampak apabila dilanggar:**
- `build` menjadi lebih kompleks karena harus menangani `AsyncValue` tambahan.
- Risiko state tidak konsisten antara state lokal dan provider.
- Rebuild yang tidak perlu saat provider async berubah.
**Rujukan implementasi:**
- `lib/fitur/dashboard/page/dashboard_page.dart` — `build` menggunakan `dashboardProvider(_kendaraanTerpilih?.id)`.
**Contoh benar:**
```dart
// Nilai sudah tersedia di state lokal; gunakan langsung.
final dashboardAsync = ref.watch(dashboardProvider(_kendaraanTerpilih?.id));
if (dashboardAsync.isLoading) return _buildLoading();
if (dashboardAsync.hasError) return _buildError();
final dashboardState = dashboardAsync.requireValue;
```
**Contoh salah:**
```dart
// Re-watch provider async yang nilainya sudah ada di state lokal.
final selectedKendaraanId = ref.watch(selectedKendaraanIdProvider);
if (selectedKendaraanId.isLoading) return _buildLoading();
if (selectedKendaraanId.hasError) return _buildError();
final selectedKendaraanIdState = selectedKendaraanId.requireValue;
final dashboardAsync = ref.watch(dashboardProvider(selectedKendaraanIdState));
```
**Penjelasan perbedaan:**
Contoh benar menggunakan state lokal yang sudah tersedia, sehingga `build` hanya menangani `AsyncValue` dari `dashboardProvider`. Contoh salah menambahkan penanganan `AsyncValue` untuk `selectedKendaraanIdProvider` yang redundan, karena nilainya sudah ada di `_kendaraanTerpilih`.
## Pengurutan Koleksi dengan `sorted` Tanpa Spread Berlebih
**Cakupan:**
- Kode yang mengurutkan koleksi menggunakan `sorted` dari `package:collection`, khususnya pada provider/notifier seperti `DashboardNotifier._jadwalTerdekat`.
**Aturan wajib:**
1. Gunakan `list.sorted(...)` langsung, karena `sorted` sudah mengembalikan list baru tanpa memutasi list asli.
2. Jangan menambahkan spread `[...list]` sebelum `.sorted(...)` karena menghasilkan salinan ganda yang tidak diperlukan.
**Larangan:**
- Jangan menulis `[...list].sorted(...)`.
**Alasan:**
Extension `sorted` dari `package:collection` sudah mengembalikan list baru, sehingga spread `[...list]` hanya membuat salinan tambahan yang tidak diperlukan dan menambah overhead memori/performa tanpa perubahan perilaku.
**Dampak apabila dilanggar:**
- Overhead memori dan waktu pemrosesan tambahan (kecil, tetapi tidak perlu).
- Kode kurang efisien tanpa manfaat.
**Rujukan implementasi:**
- `lib/fitur/dashboard/provider/dashboard_provider.dart` — `_jadwalTerdekat`.
**Contoh benar:**
```dart
import 'package:collection/collection.dart';
final sorted = list.sorted(
  (a, b) => _skorUrgensi(a, kmTerbaru).compareTo(_skorUrgensi(b, kmTerbaru)),
);
return sorted.first;
```
**Contoh salah:**
```dart
final sorted = [...list].sorted(
  (a, b) => _skorUrgensi(a, kmTerbaru).compareTo(_skorUrgensi(b, kmTerbaru)),
);
```
**Penjelasan perbedaan:**
Contoh benar memanggil `sorted` langsung pada list, menghasilkan list baru tanpa salinan perantara. Contoh salah menambahkan spread yang membuat salinan list terlebih dahulu, padahal `sorted` sudah tidak memutasi list asli.


// ============================================================
// FILE: .agents/rules/proyek/aturan_proyek.md
// ============================================================

# Aturan Proyek
**Path:** `.agents/rules/proyek/aturan_proyek.md`
## Tujuan
Folder `.agents/rules/proyek/` digunakan untuk menyimpan seluruh aturan khusus yang hanya berlaku pada proyek ini.
File ini merupakan ringkasan yang menjelaskan alasan keberadaan folder tersebut, fungsi aturan di dalamnya, serta ketentuan penerapannya.
## Aturan
### 1. Kewajiban Mematuhi Aturan Proyek
1. AI wajib membaca, memahami, dan mematuhi seluruh file aturan yang terdapat di dalam folder `.agents/rules/proyek/`.
2. Seluruh aturan dalam folder tersebut wajib diterapkan pada setiap pekerjaan yang dilakukan di proyek ini.
3. AI tidak boleh mengabaikan, menghapus, mengubah, atau mengesampingkan aturan proyek atas inisiatif sendiri.
### 2. Prioritas Aturan Global dan Aturan Proyek
1. Jika terdapat konflik antara aturan dalam `.agents/rules/global/` dan `.agents/rules/proyek/`, aturan dalam folder `.agents/rules/proyek/` wajib diprioritaskan.
2. Seluruh aturan dalam folder `.agents/rules/proyek/` wajib dipertahankan dan dipatuhi, termasuk aturan yang bertentangan dengan aturan global.
3. Aturan global yang tidak bertentangan dengan aturan proyek tetap berlaku dan wajib dipatuhi.
4. Jika ditemukan konflik antara aturan global dan aturan proyek, AI wajib mengidentifikasi dan melaporkannya. Jangan mengubah atau mengabaikan aturan secara sepihak.
### 3. Cakupan Penerapan
1. Aturan dalam folder `.agents/rules/proyek/` hanya berlaku untuk proyek ini.
2. Aturan tersebut tidak otomatis menjadi ketentuan bagi proyek Flutter atau Dart lainnya.
## Aturan Khusus Proyek
### 1. Target Platform
1. Proyek ini dikembangkan sebagai aplikasi Android (APK) untuk tahap awal.
2. Seluruh kode, implementasi, konfigurasi, dan penggunaan paket wajib kompatibel dengan Android.
3. Jangan menerapkan implementasi yang tidak didukung atau tidak kompatibel dengan Android.
### 2. Keterbatasan Pengujian
1. Karena keterbatasan perangkat keras, saat ini pengujian aplikasi belum dapat dilakukan menggunakan emulator Android.
2. Pengujian hanya dapat dilakukan melalui Web Server.
3. AI wajib mempertimbangkan keterbatasan tersebut ketika menyusun implementasi, menjalankan pengujian, dan memverifikasi hasil pekerjaan.
4. Ketidakmampuan menjalankan emulator bukan alasan untuk mengabaikan kompatibilitas Android.
5. Pengujian melalui Web Server tidak boleh dianggap sebagai bukti bahwa seluruh implementasi sudah berjalan dengan benar di Android.
## Perbedaan Aturan Global dan Aturan Proyek
- **`.agents/rules/global/`**: berisi aturan umum yang berlaku untuk seluruh proyek Flutter dan Dart.
- **`.agents/rules/proyek/`**: berisi aturan khusus yang hanya berlaku untuk proyek ini dan wajib diprioritaskan apabila terjadi konflik dengan aturan global.


