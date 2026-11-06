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
