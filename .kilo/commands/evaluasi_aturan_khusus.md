Metadata
description
Evaluasi perubahan kode dan commit terbaru, lalu perbarui aturan khusus proyek serta aturan bersama Flutter.
agent
code
Evaluasi Aturan Khusus dan Aturan Bersama
Tujuan
Setiap kali pengguna menjalankan command ini setelah mengerjakan kode, baik untuk memperbaiki kode yang sudah ada maupun menambahkan kode baru, lakukan evaluasi terhadap perubahan tersebut. Tujuan utamanya adalah menangkap keputusan, pola implementasi, preferensi, dan pelajaran dari perubahan kode agar kesalahan atau perubahan yang tidak sesuai tidak terulang pada pekerjaan berikutnya.

Hasil evaluasi harus digunakan untuk memperbarui dua sumber aturan berikut:

Aturan khusus proyek: .agents/rules/proyek/aturan_khusus.md
Aturan bersama lintas proyek Flutter: .agents/rules/global/aturan_bersama.md
Setelah kedua sumber aturan selesai dievaluasi dan diperbarui, jalankan scripts/build_rules_context.sh untuk membangun ulang konteks aturan ke dalam AGENTS.md.

Command ini berfokus pada evaluasi dan dokumentasi aturan. Jangan mengubah kode aplikasi, melakukan refactor, memperbaiki bug secara langsung, membuat commit, atau mengubah file lain di luar cakupan yang diizinkan dalam command ini. Jika menemukan masalah kode yang belum diperbaiki, catat sebagai temuan dan laporkan kepada pengguna. Jangan diam-diam memperluas pekerjaan.

Prinsip wajib
Gunakan bukti dari diff, kode aktual, riwayat commit, dan aturan yang sudah ada. Jangan membuat aturan berdasarkan dugaan, asumsi, atau preferensi yang tidak pernah ditunjukkan oleh pengguna.
Evaluasi seluruh jenis perubahan, bukan hanya bug runtime. Perhatikan juga gaya penulisan kode, penamaan, struktur, arsitektur, alur data, state management, performa, cache, penggunaan memori, UI/UX, pengujian, keamanan, dan konsistensi dengan pola proyek.
Jangan menganggap suatu pola benar hanya karena pernah digunakan atau sudah masuk commit. Commit adalah riwayat perubahan yang sudah diselesaikan atau diterima sebagai bagian dari pekerjaan sebelumnya, tetapi isi dan hasil akhirnya tetap harus dievaluasi.
Jangan pula menganggap semua perubahan dalam commit lama salah atau harus diubah kembali. Gunakan riwayat tersebut untuk memahami keputusan dan menemukan pelajaran yang dapat dijadikan aturan.
Jangan membuat aturan hanya demi menambah jumlah aturan. Tambahkan atau perbarui aturan hanya jika hasil evaluasi memberikan pelajaran yang jelas, dapat diterapkan, dan berguna untuk mencegah kesalahan berulang.
Pertahankan tujuan dan maksud aturan yang sudah ada. Perjelas redaksi atau gabungkan aturan yang tumpang tindih tanpa menghilangkan maksud aslinya.
Jika menemukan pertentangan dengan AGENTS.md, .agents/rules/AGENTS.md, atau aturan lain yang berlaku, jangan menebak aturan mana yang harus diubah. Catat lokasi dan isi konflik, jangan menambahkan aturan yang memperbesar konflik, lalu laporkan kepada pengguna.
Gunakan bahasa Indonesia yang baik, baku, tegas, dan tidak ambigu. Gunakan istilah teknis Flutter/Dart secara tepat.
Tahap 1 — Pastikan lokasi dan kondisi repository
Pastikan terminal berada di direktori root proyek yang benar.
Pastikan direktori tersebut merupakan Git repository. Periksa dengan git rev-parse --show-toplevel dan git status --short.
Catat branch aktif dan kondisi working tree sebelum melakukan evaluasi.
Jangan menjalankan perintah Git yang mengubah atau menghapus riwayat maupun perubahan pengguna, termasuk reset, checkout untuk membuang perubahan, restore, clean, rebase, commit, atau push.
Jika direktori bukan Git repository atau riwayat commit tidak tersedia, jangan mengarang riwayat. Tetap evaluasi perubahan yang dapat diperiksa dan jelaskan keterbatasannya.
Tahap 2 — Baca aturan dan konteks yang berlaku
Sebelum membuat atau mengubah aturan, baca isi file berikut apabila tersedia:

AGENTS.md di root proyek.
.agents/rules/AGENTS.md.
.agents/rules/proyek/aturan_khusus.md.
.agents/rules/global/aturan_bersama.md.
File aturan lain yang secara langsung dirujuk atau berkaitan dengan bagian kode yang sedang dievaluasi.
scripts/build_rules_context.sh untuk memahami cara script membangun ulang AGENTS.md dan mengetahui file apa saja yang mungkin diubahnya.
Jangan hanya membaca judul atau daftar isi. Baca isi aturan yang relevan agar pembaruan tidak menduplikasi, menghapus, atau bertentangan dengan ketentuan yang sudah ada.

Jika salah satu file target belum tersedia, pastikan direktori induknya dan buat file tersebut hanya jika memang diperlukan. Jangan membuat file aturan tambahan di luar dua lokasi target yang ditentukan.

Tahap 3 — Periksa perubahan yang belum di-commit
Periksa perubahan working tree karena perubahan terbaru mungkin belum masuk ke commit:

Periksa git status --short.
Periksa ringkasan perubahan dengan git diff --stat.
Baca perubahan yang belum di-stage dengan git diff.
Baca perubahan yang sudah di-stage dengan git diff --cached.
Periksa file baru yang belum dilacak berdasarkan daftar dari git status --short. Baca isinya jika berkaitan dengan pekerjaan yang sedang dievaluasi.
Perhatikan perubahan yang dihapus, dipindahkan, atau diubah namanya. Jangan hanya mengevaluasi baris kode yang ditambahkan.
Evaluasi perubahan tersebut berdasarkan maksud pengguna, aturan proyek, dan konteks implementasinya. Jangan menganggap perubahan yang belum di-commit sebagai keputusan final. Namun, jangan mengubahnya dalam command ini.

Tahap 4 — Tentukan batas riwayat commit
Periksa maksimal 15 commit terakhir dari HEAD menggunakan riwayat Git, misalnya git log -15 --format="%H%x09%h%x09%s".
Utamakan pemeriksaan 15 commit terakhir jika tersedia. Jika jumlah commit yang tersedia kurang dari 10, periksa semua commit yang tersedia. Jangan memperluas pemeriksaan melewati 15 commit hanya karena ingin mencari contoh tambahan.
Jangan memakai seluruh riwayat proyek sebagai bahan evaluasi. Batas pemeriksaan adalah 15 commit terakhir.
Catat hash pendek, pesan commit, dan urutan commit yang akan diperiksa agar tidak ada commit yang terlewat.
Jangan hanya mengandalkan pesan commit, statistik perubahan, nama file, atau ringkasan otomatis. Semua itu hanya petunjuk awal, bukan pengganti pembacaan diff.
Tahap 5 — Baca dan evaluasi commit satu per satu
Wajib membaca commit satu per satu. Jangan menggabungkan seluruh commit menjadi satu diff untuk menggantikan pemeriksaan individual.

Untuk setiap commit dalam batas riwayat tersebut, lakukan urutan berikut:

Baca metadata commit dan pesan commit.
Periksa daftar file yang berubah serta statistik perubahannya.
Baca diff lengkap commit tersebut, termasuk kode yang dihapus dan diganti. Gunakan git show untuk satu hash commit pada satu waktu, misalnya git show --format=fuller --find-renames <HASH> --.
Jika diff terlalu panjang, pecah pembacaan berdasarkan file, tetapi tetap selesaikan seluruh file dalam commit tersebut sebelum berpindah ke commit berikutnya.
Jika commit merupakan merge commit, evaluasi perubahan hasil merge terhadap first parent menggunakan diff yang sesuai, misalnya git diff <HASH>^1 <HASH> --. Jangan menganggap merge commit tidak memiliki perubahan hanya karena tampilan diff biasa tidak memperlihatkan patch gabungan.
Jika ada file yang tidak dapat dibaca sebagai teks, seperti file biner, catat file tersebut dan jelaskan keterbatasannya. Untuk file hasil generate, periksa sumber atau file pembentuknya apabila tersedia; jangan menyimpulkan perilaku hanya dari file hasil generate.
Setelah membaca diff, periksa kode terkini pada bagian yang terdampak. Tujuannya untuk mengetahui apakah perubahan tersebut masih berlaku, sudah diganti oleh implementasi baru, atau justru menyisakan masalah.
Setelah satu commit selesai dievaluasi, catat hasilnya sebelum membaca commit berikutnya.
Jangan berhenti setelah membaca beberapa commit yang dianggap paling menarik. Selesaikan seluruh commit terpilih, kecuali data repository memang tidak dapat diakses. Jika ada kendala, sebutkan commit yang tidak berhasil diperiksa dan alasannya.

Tahap 6 — Evaluasi semua aspek perubahan
Untuk setiap commit dan perubahan working tree yang relevan, evaluasi aspek berikut sesuai konteksnya. Jangan memaksakan aspek yang tidak berkaitan.

A. Kesesuaian dengan maksud dan preferensi pengguna
Apakah implementasi sesuai dengan permintaan dan maksud pengguna?
Apakah struktur dan gaya kode sesuai dengan aturan proyek?
Apakah terdapat keputusan atau pola yang menunjukkan preferensi pengguna?
Apakah perubahan membuat implementasi menjadi lebih sulit dipahami, dirawat, diuji, atau dikembangkan?
B. Kualitas dan kebenaran kode
Kebenaran logika dan hasil yang dihasilkan.
Potensi bug, regresi, kondisi tepi, null safety, dan penanganan error.
Konsistensi tipe data, validasi, serta alur input dan output.
Penamaan variabel, fungsi, class, file, dan struktur folder.
Duplikasi kode, abstraksi yang tidak diperlukan, serta kompleksitas yang tidak memberikan manfaat.
Konsistensi dengan pola arsitektur dan implementasi yang sudah ditetapkan proyek.
C. Runtime, performa, dan pengelolaan resource
Potensi crash, freeze, race condition, dan masalah asynchronous.
Siklus hidup widget, provider, subscription, stream, controller, timer, dan resource lain.
Rebuild yang tidak perlu serta pekerjaan berat pada UI thread.
Penggunaan cache, database, jaringan, dan state: apakah alurnya benar dan konsisten?
Potensi kebocoran memori, pemanggilan berulang, atau pekerjaan yang tidak dihentikan ketika sudah tidak diperlukan.
D. UI/UX dan perilaku aplikasi
Kejelasan fungsi tombol, navigasi, status proses, pesan, dan tindakan pengguna.
Konsistensi tampilan serta kemudahan penggunaan.
Penanganan loading, empty state, success, warning, dan error jika relevan.
Konfirmasi untuk tindakan destruktif dan perlindungan dari input berulang jika relevan.
Perilaku UI terhadap perubahan state dan data.
E. Pengujian dan pemeliharaan
Apakah perubahan memiliki pengujian yang sesuai dengan risiko dan kompleksitasnya?
Apakah pengujian memeriksa perilaku penting, bukan sekadar detail implementasi?
Apakah perubahan mempersulit pengujian atau pemeliharaan tanpa alasan yang jelas?
Apakah dokumentasi atau aturan perlu diperbarui agar keputusan implementasi tidak hilang?
Jangan menyatakan sesuatu sebagai bug atau pelanggaran jika bukti belum cukup. Bedakan secara tegas antara masalah yang terbukti, risiko yang perlu diperiksa, preferensi pengguna, dan saran opsional.

Tahap 7 — Tentukan aturan khusus dan aturan bersama
Setiap temuan yang layak dijadikan aturan harus dinilai untuk dua cakupan berikut.

A. Aturan khusus proyek
Masukkan aturan ke .agents/rules/proyek/aturan_khusus.md apabila aturan tersebut bergantung pada karakteristik proyek, misalnya:

Alur bisnis atau kebutuhan khusus aplikasi.
Struktur folder, nama fitur, model, provider, service, atau database proyek.
Keputusan arsitektur yang hanya berlaku pada proyek tersebut.
Konvensi implementasi yang memang sengaja dipilih untuk proyek tersebut.
Perilaku khusus yang harus dipertahankan agar kebutuhan aplikasi tidak berubah.
Tuliskan aturan dengan menyebutkan cakupan atau lokasi yang relevan. Jangan mengubah detail khusus proyek menjadi larangan global.

B. Aturan bersama lintas proyek Flutter
Masukkan aturan ke .agents/rules/global/aturan_bersama.md hanya jika prinsipnya memang dapat diterapkan secara konsisten pada proyek Flutter lain tanpa bergantung pada nama fitur, struktur folder, kebutuhan bisnis, atau keputusan khusus satu aplikasi.

Pertimbangkan prinsip lintas proyek seperti:

Praktik Dart dan Flutter yang berlaku umum.
Keamanan null safety dan penanganan asynchronous.
Pengelolaan lifecycle dan resource.
Konsistensi arsitektur, state management, dan pemisahan tanggung jawab jika memang menjadi standar bersama.
Kualitas pengujian, keterbacaan, pemeliharaan, performa, dan UX yang relevan lintas aplikasi.
Jangan memasukkan aturan yang hanya cocok untuk satu proyek ke aturan bersama. Hindari menyebut nama fitur, class, tabel, atau path khusus proyek di dalam aturan global, kecuali benar-benar merupakan contoh yang diberi label sebagai contoh.

C. Turunkan prinsip umum dari temuan khusus
Walaupun suatu temuan hanya dapat diterapkan secara langsung pada satu proyek, tetap evaluasi apakah ada prinsip umum yang dapat dijadikan referensi untuk aturan bersama.

Contoh pendekatan:

Aturan khusus: validasi urutan proses penyimpanan pada fitur transaksi tertentu.
Prinsip umum yang mungkin dapat diangkat: pastikan seluruh prasyarat data tervalidasi sebelum melakukan operasi penyimpanan yang mengubah data permanen.
Contoh tersebut hanya ilustrasi cara menggeneralisasi prinsip, bukan aturan yang otomatis harus ditambahkan.

Untuk setiap temuan khusus, tanyakan:

Apakah penyebab kesalahannya dapat terjadi juga di proyek Flutter lain?
Apakah ada prinsip pencegahan yang tetap benar tanpa membawa detail proyek asal?
Apakah prinsip tersebut belum tercakup dalam aturan_bersama.md?
Apakah penerapannya tidak bertentangan dengan aturan global yang sudah ada?
Jika jawabannya mendukung, tambahkan prinsip abstrak tersebut ke aturan bersama. Jika tidak ada prinsip yang benar-benar dapat diterapkan lintas proyek, jangan memaksakannya. Catat dalam laporan bahwa temuan tersebut hanya menjadi aturan khusus dan jelaskan secara singkat alasannya.

Tahap 8 — Susun atau perbarui isi aturan
Pertahankan isi dan maksud aturan yang masih relevan.
Tambahkan aturan baru pada bagian yang paling sesuai.
Perbarui aturan lama jika hasil evaluasi memberikan rumusan yang lebih tepat, lebih tegas, atau lebih lengkap.
Gabungkan aturan yang isinya sama atau tumpang tindih. Jangan mempertahankan duplikasi hanya karena berasal dari commit yang berbeda.
Jangan menghapus aturan lama hanya karena tidak ditemukan penerapannya dalam 15 commit terakhir. Riwayat tersebut merupakan sampel terbatas, bukan bukti bahwa aturan tidak diperlukan.
Jangan membuat aturan yang terlalu umum seperti "tulis kode dengan baik". Rumuskan tindakan yang harus dilakukan, kondisi penerapannya, dan perilaku yang dilarang.
Bedakan kewajiban dengan preferensi. Gunakan kata WAJIB atau DILARANG untuk ketentuan tegas, dan UTAMAKAN atau HINDARI untuk preferensi yang masih memungkinkan pengecualian dengan alasan teknis.
Jelaskan pengecualian apabila suatu aturan tidak berlaku pada semua kondisi.
Jangan mengubah aturan hanya berdasarkan gaya pribadi AI atau praktik umum yang belum tentu sesuai dengan keputusan pengguna.
Jangan menyalin seluruh aturan khusus ke aturan bersama. Hanya prinsip umum yang sudah lolos evaluasi cakupan yang boleh dimasukkan.
Tahap 9 — Sertakan contoh kode benar dan salah
Setiap aturan baru atau aturan teknis yang diperbarui harus dilengkapi contoh kode BENAR dan SALAH agar maksudnya mudah dipahami dan tidak ditafsirkan keliru.

Ketentuan contoh:

Contoh harus berkaitan langsung dengan aturan yang dijelaskan.
Contoh harus menggunakan Dart/Flutter jika aturan membahas implementasi Flutter.
Contoh harus cukup lengkap untuk menunjukkan perbedaan perilaku atau pola implementasi.
Berikan keterangan singkat mengapa contoh BENAR sesuai aturan dan mengapa contoh SALAH melanggar aturan.
Gunakan API, class, dan pola yang benar-benar tersedia serta sesuai dengan versi dependensi atau SDK proyek apabila contoh mengambil konteks proyek.
Jangan mengarang nama provider, method, model, atau API seolah-olah merupakan bagian dari kode proyek.
Untuk contoh yang berasal dari proyek, gunakan kode aktual yang relevan dan sederhanakan seperlunya tanpa mengubah inti perilakunya.
Untuk aturan global, gunakan contoh generik yang tidak bergantung pada fitur atau nama proyek tertentu.
Jangan menambahkan contoh yang tidak valid secara sintaksis, menyesatkan, atau justru mengajarkan pola berbahaya.
Jika aturan bersifat non-teknis dan tidak memiliki contoh kode yang masuk akal, jelaskan dengan contoh perilaku atau skenario yang konkret. Jangan membuat kode palsu hanya untuk memenuhi format.
Gunakan pola penulisan berikut sebagai acuan:

### [Judul aturan]

**Aturan:** [Ketentuan yang harus dilakukan atau dihindari.]

**Alasan:** [Masalah atau risiko yang dicegah.]

**BENAR:**

```dart
// Contoh implementasi yang sesuai.
```

Keterangan: [Mengapa contoh ini benar.]

**SALAH:**

```dart
// Contoh implementasi yang tidak sesuai.
```

Keterangan: [Mengapa contoh ini salah.]
Pola di atas merupakan contoh struktur dokumentasi. Sesuaikan isi dan tingkat detailnya dengan aturan yang benar-benar ditemukan.

Tahap 10 — Evaluasi konflik, duplikasi, dan cakupan
Sebelum menyimpan hasil akhir:

Bandingkan aturan baru dengan seluruh aturan relevan yang sudah dibaca.
Pastikan aturan khusus tidak dimasukkan sebagai larangan global tanpa proses generalisasi.
Pastikan aturan global tidak memuat keputusan yang hanya berlaku untuk satu proyek.
Pastikan contoh BENAR dan SALAH tidak bertentangan dengan aturan lain.
Pastikan tidak ada dua aturan dengan maksud sama tetapi redaksi berbeda.
Pastikan setiap aturan cukup spesifik untuk dilaksanakan AI dan tidak menimbulkan tafsir ganda.
Jika konflik tidak dapat diselesaikan berdasarkan instruksi yang sudah tersedia, jangan memilih salah satu secara sepihak. Pertahankan aturan yang ada, jangan menambahkan ketentuan konflik, dan masukkan konflik tersebut ke laporan akhir.
Tahap 11 — Perbarui file aturan
Perbarui hanya file berikut sesuai hasil evaluasi:

.agents/rules/proyek/aturan_khusus.md
.agents/rules/global/aturan_bersama.md
Jangan menimpa seluruh isi file tanpa alasan. Gunakan perubahan terarah agar aturan yang masih berlaku tetap dipertahankan.

Jika setelah evaluasi tidak ada aturan baru atau perubahan yang benar-benar diperlukan, jangan mengubah file hanya untuk menghasilkan diff. Nyatakan bahwa kedua file telah dievaluasi dan tidak memerlukan perubahan.

Tahap 12 — Bangun ulang AGENTS.md
Setelah kedua file aturan selesai diperiksa dan seluruh perubahan aturan disimpan:

Pastikan script scripts/build_rules_context.sh tersedia.

Jalankan script tersebut dari root proyek dengan perintah:

bash scripts/build_rules_context.sh
Periksa output terminal untuk memastikan script selesai tanpa error.

Periksa perubahan pada AGENTS.md dan pastikan isinya sudah mencerminkan aturan terbaru.

Jangan mengedit AGENTS.md secara manual jika file tersebut memang dihasilkan oleh script. Perbaiki sumber aturan, lalu jalankan ulang script jika diperlukan.

Jika script tidak tersedia atau gagal dijalankan, jangan mengarang bahwa proses berhasil. Laporkan pesan error dan kondisi file yang dihasilkan.

Jika script mengubah file lain di luar AGENTS.md dan dua file aturan target, periksa perubahan tersebut. Jangan mempertahankan perubahan yang tidak berkaitan tanpa alasan; jangan menghapus atau membatalkan perubahan pengguna secara otomatis.

Tahap 13 — Pemeriksaan akhir
Lakukan pemeriksaan berikut setelah script dijalankan:

Jalankan git diff --check untuk mendeteksi masalah whitespace pada perubahan.
Periksa git status --short.
Periksa diff dari kedua file aturan dan AGENTS.md.
Pastikan semua contoh kode sesuai dengan aturan yang dijelaskan.
Pastikan tidak ada file kode aplikasi yang berubah akibat command ini.
Pastikan perubahan hanya mencakup dua file aturan target dan hasil pembaruan script yang memang diperlukan. Jika ada perubahan lain, jelaskan dan jangan menyembunyikannya.
Jangan membuat commit. Biarkan pengguna memutuskan kapan perubahan aturan akan di-commit.
Format laporan akhir
Setelah seluruh proses selesai, berikan laporan dengan susunan berikut:

1. Ringkasan evaluasi
   Jumlah commit yang tersedia dan jumlah commit yang berhasil diperiksa.
   Rentang atau daftar hash pendek commit yang diperiksa.
   Jumlah perubahan working tree yang ikut dievaluasi, jika ada.
   Kendala pemeriksaan, jika ada.
2. Temuan penting
   Pola atau keputusan kode yang perlu dipertahankan.
   Kesalahan, risiko, atau ketidaksesuaian yang ditemukan.
   Preferensi pengguna yang teridentifikasi dari perubahan kode.
   Pisahkan masalah yang terbukti dari risiko atau saran.
3. Pembaruan aturan khusus
   Path: .agents/rules/proyek/aturan_khusus.md
   Sebutkan aturan yang ditambahkan atau diperbarui.
   Sebutkan jika tidak ada perubahan dan jelaskan alasannya.
4. Pembaruan aturan bersama
   Path: .agents/rules/global/aturan_bersama.md
   Sebutkan prinsip lintas proyek Flutter yang ditambahkan atau diperbarui.
   Sebutkan prinsip dari temuan khusus yang berhasil digeneralisasi.
   Sebutkan temuan yang tetap khusus proyek karena tidak layak dijadikan aturan global.
   Sebutkan jika tidak ada perubahan dan jelaskan alasannya.
5. Konflik atau masalah yang belum terselesaikan
   Sebutkan path file, aturan yang bertentangan, dampaknya, dan alasan mengapa konflik belum diselesaikan. Jangan menyembunyikan konflik atau mengambil keputusan berdasarkan asumsi.

6. Hasil pembaruan AGENTS.md
   Perintah yang dijalankan: bash scripts/build_rules_context.sh.
   Status keberhasilan atau kegagalan script.
   Konfirmasi apakah AGENTS.md sudah mencerminkan pembaruan aturan.
7. Pemeriksaan akhir
   Hasil git diff --check.
   Daftar file yang berubah.
   Konfirmasi bahwa tidak ada kode aplikasi yang diubah dan tidak ada commit yang dibuat oleh command ini.
   Laporan harus spesifik berdasarkan hasil pemeriksaan aktual. Jangan mengklaim commit telah dibaca, aturan telah diperbarui, atau script telah berhasil jika tindakan tersebut belum benar-benar dilakukan.
