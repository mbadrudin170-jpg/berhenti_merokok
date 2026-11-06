<!-- Path: .kilo/commands/scan.md -->

description: Audit seluruh file Dart di lib satu per satu terhadap AGENTS.md, catat progres dengan todowrite, dan perbarui task.md tanpa mengubah kode Dart.
MODE: AUDIT MENYELURUH KODE FLUTTER — STRICT READ-ONLY
Tujuan
Audit seluruh file kode Dart di lib/ secara langsung, satu per satu, untuk menemukan masalah yang terbukti berdasarkan implementasi dan aturan proyek. Hasil audit digunakan untuk memperbarui task.md dan, jika ditemukan ide fitur baru yang benar-benar layak, rencana_fitur_baru.md.

Audit mencakup:

Pelanggaran terhadap aturan dalam .agents/rules/AGENTS.md dan aturan lain yang dirujuk olehnya.
Bug runtime dan masalah keandalan implementasi.
Masalah UX.
Masalah UI, terutama padding, margin, spacing, ukuran, layout, overflow, dan widget yang berpotensi menyentuh tepi layar secara tidak semestinya.
Task lama yang sudah tidak sesuai dengan aturan atau kode terbaru.
Ide fitur baru yang relevan dan memiliki alasan yang jelas.
Perintah ini hanya untuk audit dan pembaruan dokumentasi. Dilarang mengubah kode Dart.

A. BATASAN WAJIB
A1. Cakupan file
Periksa seluruh file Dart di dalam lib/ secara rekursif, termasuk semua subfolder.
Kecualikan hanya file yang nama akhirnya sesuai dengan pola _.g.dart atau _.freezed.dart.
Jangan mengecualikan file Dart lain, termasuk file generated lain, file test yang kebetulan berada di lib/, atau file yang dianggap tidak penting.
Jangan membatasi audit pada file yang ditemukan melalui pencarian pola. Setiap file dalam cakupan harus dibaca langsung.
Catat jumlah file yang ditemukan, dikecualikan, berhasil dibaca, dan belum berhasil dibaca.
A2. Larangan terminal
Dilarang menggunakan terminal atau tool bash dalam bentuk apa pun.
Dilarang menjalankan perintah shell, script, analyzer, formatter, test, atau perintah lain.
Dilarang menggunakan perintah terminal untuk mencari, membaca, menghitung, atau memeriksa kode.
Gunakan glob hanya untuk menemukan dan menginventarisasi nama/path file.
Gunakan tool read untuk membaca isi file, terutama seluruh file Dart di lib/.
Jangan mengganti pembacaan langsung dengan grep, pencarian pola, ringkasan indeks, atau hasil pemindaian otomatis.
A3. Larangan mengubah kode
Dilarang mengedit, menghapus, menambah, memindahkan, memformat, atau melakukan refactoring terhadap file Dart.
Dilarang memperbaiki implementasi yang ditemukan bermasalah.
Dilarang mengubah konfigurasi proyek, dependency, file generated, atau dokumentasi lain yang tidak diizinkan.
File yang boleh diperbarui hanya:
task.md di root proyek.
rencana_fitur_baru.md di root proyek, hanya jika ada ide fitur baru yang layak.
Jika path file dokumentasi tidak ditemukan, cari keberadaannya menggunakan glob. Jangan membuat file pengganti di lokasi lain tanpa alasan dan jangan mengubah file lain sebagai gantinya.
A4. Aturan penggunaan tool
Tool yang digunakan untuk pekerjaan ini:

glob: menginventarisasi file dan menemukan lokasi source yang diperlukan.
read: membaca isi file dan source code.
todowrite: membuat dan memperbarui checklist audit.
todoread: membaca checklist yang sedang aktif sebelum memperbaruinya.
edit atau write: hanya memperbarui task.md dan rencana_fitur_baru.md sesuai ketentuan.
websearch atau webfetch: boleh digunakan untuk dokumentasi resmi jika diperlukan, tetapi tidak menggantikan pemeriksaan source code lokal.
Jangan gunakan tool lain untuk menjalankan atau mengubah kode proyek. Jika suatu tool tidak tersedia, laporkan keterbatasannya; jangan menggantinya dengan terminal. Jika todowrite tidak tersedia atau fitur TODO dinonaktifkan, jangan mengaku checklist sudah dibuat. Laporkan bahwa pengguna perlu mengaktifkan fitur Task Todo List Kilo atau menyediakan mode yang memiliki akses ke todowrite sebelum checklist file dapat dibuat.

B. ALUR AUDIT WAJIB
Ikuti tahapan secara berurutan. Jangan menyatakan audit selesai sebelum seluruh tahapan yang dapat dilakukan benar-benar selesai.

TAHAP 1 — BACA ATURAN PROYEK
Baca seluruh isi .agents/rules/AGENTS.md menggunakan read.
Jika file tersebut merujuk ke file aturan lain, buka dan baca seluruh aturan yang relevan.
Catat nama file aturan, judul bagian, nomor poin jika tersedia, dan maksud setiap aturan yang relevan.
Bedakan ketentuan wajib, larangan, rekomendasi, dan pengecualian.
Periksa apakah terdapat aturan yang saling bertentangan. Jangan memilih salah satu berdasarkan dugaan. Catat konflik beserta lokasi aturannya untuk dilaporkan.
Jangan menyatakan suatu kode melanggar aturan sebelum memastikan aturan tersebut berlaku pada konteks kode yang diperiksa.
TAHAP 2 — INVENTARISASI FILE DART
Gunakan glob untuk menemukan seluruh file \*.dart di lib/ dan seluruh subfoldernya.
Dari daftar tersebut, keluarkan hanya file dengan akhiran .g.dart dan .freezed.dart.
Jangan mengandalkan jumlah file dari hasil pencarian isi kode.
Susun daftar final seluruh file yang wajib dibaca beserta path relatif dari root proyek.
Pastikan tidak ada path yang terlewat, terduplikasi, atau tidak termasuk folder lib/.
Ketentuan daftar file
Daftar inventaris harus menjadi dasar checklist todowrite. Jangan membuat checklist hanya berisi tahapan umum; setiap file Dart wajib memiliki item checklist tersendiri.

TAHAP 3 — BUAT TODO DENGAN todowrite
Setelah inventarisasi selesai dan sebelum mulai membaca file Dart:

Gunakan tool todowrite untuk membuat checklist audit.
Buat satu item terpisah untuk setiap file Dart yang wajib diperiksa.
Cantumkan path relatif lengkap pada setiap item, bukan hanya nama file.
Tambahkan item tahapan audit dan pembaruan dokumentasi yang diperlukan.
Jangan menggabungkan beberapa file menjadi satu item checklist.
Seluruh item file dimulai dengan status belum selesai.
Jangan menandai file selesai hanya karena file sudah ditemukan melalui glob.
Ketentuan memperbarui checklist
Dokumentasi Kilo menyatakan bahwa setiap pemanggilan todowrite mengganti seluruh checklist dengan versi terbaru. Oleh karena itu:

Sebelum memperbarui checklist yang sudah ada, gunakan todoread untuk membaca status terakhir.
Saat memanggil todowrite, pertahankan seluruh item yang masih relevan beserta statusnya.
Jangan menghilangkan item yang masih tertunda atau sudah selesai hanya karena sedang memperbarui satu item.
Ubah status item file menjadi selesai hanya setelah seluruh isi file berhasil dibaca dan diperiksa terhadap aturan yang relevan.
Jika file baru ditemukan setelah inventarisasi, tambahkan item file tersebut dan pertahankan semua item sebelumnya.
Jika pembacaan file gagal atau hanya sebagian isi yang terbaca, biarkan item belum selesai dan catat hambatannya.
Jangan menandai seluruh checklist selesai jika masih ada file yang belum dibaca atau tahapan wajib yang belum diselesaikan.
Satu tanda selesai pada checklist harus berarti file tersebut benar-benar sudah dibaca secara langsung, bukan sekadar terdeteksi atau dicari polanya.

TAHAP 4 — BACA DAN AUDIT SETIAP FILE SATU PER SATU
Untuk setiap item file Dart dalam checklist:

Buka file menggunakan tool read.
Baca seluruh isi file dari awal sampai akhir.
Jika hasil read terpotong atau file terlalu panjang, lanjutkan membaca bagian berikutnya sampai seluruh isi file tercakup. Jangan menganggap cuplikan awal sudah mewakili seluruh file.
Periksa isi implementasi secara langsung terhadap aturan yang berlaku.
Periksa import, deklarasi, fungsi, class, widget, state, alur asynchronous, penanganan error, serta hubungan dengan file lain jika relevan.
Catat bukti pelanggaran beserta nomor baris yang ditampilkan oleh read.
Setelah seluruh isi file selesai dibaca dan diperiksa, perbarui checklist dengan menandai item file tersebut selesai.
Lanjutkan ke file berikutnya sampai semua item selesai atau hambatan akses dilaporkan.
Pembagian pekerjaan jika file sangat banyak
Boleh membagi audit ke beberapa kelompok kecil agar pembacaan dan evaluasi tetap akurat.
Pembagian kelompok hanya untuk mengatur urutan kerja, bukan untuk mengurangi cakupan.
Jangan mengabaikan file, melompati subfolder, atau memilih hanya file yang dianggap penting.
Jangan menyimpulkan AI kewalahan hanya berdasarkan jumlah file. Lanjutkan secara bertahap dengan checklist.
Jangan memasukkan seluruh isi semua file ke dalam satu ringkasan besar. Baca, evaluasi, dan catat temuan per file agar bukti tidak tercampur.
Jika batas konteks, batas tool, atau kegagalan pembacaan benar-benar menghalangi kelanjutan, catat file yang belum selesai. Jangan mengklaim audit 100% selesai.
TAHAP 5 — PEMERIKSAAN PELANGGARAN DAN BUKTI
Periksa setiap file berdasarkan isi aktual dan seluruh aturan yang berlaku. Area pemeriksaan mencakup, tetapi tidak terbatas pada:

Lifecycle widget dan pengelolaan resource.
State management dan penggunaan Riverpod.
Operasi asynchronous dan penanganan error.
Null safety, tipe data, parsing, dan validasi.
Database, transaksi, serta integritas data.
Struktur kode dan arsitektur proyek.
Penggunaan Flutter SDK, Dart SDK, dan paket pihak ketiga.
Penggunaan widget, layout, constraints, dan responsive design.
Konsistensi desain, spacing, padding, margin, dan ukuran.
Interaksi, feedback, konfirmasi, serta alur pengguna.
Setiap temuan harus mempunyai bukti yang dapat diperiksa. Jangan membuat temuan hanya karena pencarian pola menunjukkan suatu kata atau sintaks tertentu.

Bukti wajib untuk setiap temuan
Setiap temuan yang akan dimasukkan ke task.md harus memuat:

File dan nomor baris yang benar-benar menunjukkan masalah.
Penjelasan perilaku atau implementasi yang bermasalah.
Aturan yang dilanggar, jika memang ada.
Alasan spesifik mengapa implementasi bertentangan dengan aturan tersebut.
Dampak atau risiko nyata yang dapat dijelaskan.
Solusi yang direkomendasikan dan dasar verifikasinya.
Jangan membuat nomor baris, bukti, dampak, atau identitas aturan berdasarkan perkiraan.

Identitas aturan yang dilanggar
Untuk setiap task yang merupakan pelanggaran aturan, cantumkan path file aturan dan judul bagian atau nomor poinnya.
Jika aturan tidak memiliki nomor, gunakan judul bagian dan kutipan singkat yang relevan.
Jika aturan berasal dari file lain yang dirujuk AGENTS.md, sebutkan path file aturan yang sebenarnya.
Jika masalah bukan pelanggaran aturan tertulis, tulis Bukan pelanggaran aturan tertulis dan jelaskan dasar masalahnya.
Jangan mengarang aturan baru atau mengubah rekomendasi menjadi kewajiban.
TAHAP 6 — VERIFIKASI SOURCE SDK DAN PAKET
Solusi tidak boleh didasarkan pada asumsi, ingatan model, atau pola umum yang belum diverifikasi.

Untuk setiap temuan yang solusinya bergantung pada perilaku SDK atau paket:

Identifikasi API, class, method, widget, atau paket yang berhubungan langsung dengan masalah.
Periksa versi Flutter, Dart, dan paket yang digunakan melalui file konfigurasi proyek yang dapat dibaca, seperti pubspec.yaml, pubspec.lock, dan .dart_tool/package_config.json jika tersedia.
Gunakan glob untuk menemukan lokasi source yang relevan jika path-nya belum diketahui.
Gunakan read untuk membaca source Flutter SDK, Dart SDK, atau source paket pihak ketiga yang berkaitan langsung dengan temuan.
Pastikan solusi sesuai dengan versi yang digunakan proyek, bukan versi dokumentasi yang berbeda.
Periksa signature API, parameter, tipe data, lifecycle, dan perilaku implementasi yang relevan.
Jangan membaca seluruh SDK atau seluruh cache paket tanpa alasan. Baca bagian source yang benar-benar berkaitan dengan masalah.
Dilarang menggunakan terminal untuk mencari lokasi source atau membaca source.
Jika source berada di luar workspace dan akses read ditolak, jangan menggunakan terminal sebagai jalan pintas. Catat bahwa source belum dapat diakses.
Jika source tidak dapat ditemukan atau dibaca, nyatakan bahwa solusi belum terverifikasi. Jangan menyajikan dugaan sebagai solusi yang sudah pasti.
Untuk temuan yang tidak bergantung pada perilaku SDK atau paket, jelaskan dasar teknisnya dari implementasi proyek dan aturan yang relevan. Jangan memaksakan klaim bahwa source SDK sudah diperiksa jika memang tidak diperlukan.

TAHAP 7 — AUDIT UI DAN UX SECARA LANGSUNG
Baca implementasi widget dan telusuri hubungan antara widget anak dengan parent, layout halaman, serta constraints yang memengaruhinya. Jangan hanya mencari nilai padding, margin, atau SizedBox.

Pemeriksaan UI
Periksa hal-hal berikut:

Apakah konten atau widget berpotensi menempel ke tepi layar tanpa alasan desain yang jelas?
Apakah padding tepi halaman konsisten?
Apakah padding antarhalaman dan antarkomponen serasi?
Apakah spacing terlalu rapat, terlalu renggang, atau tidak konsisten?
Apakah ukuran komponen mengikuti referensi desain?
Apakah layout memiliki risiko overflow atau konten terpotong?
Apakah layout menangani ukuran layar dan constraints dengan benar?
Apakah penggunaan SafeArea, ScrollView, padding parent, dan padding child sudah tepat?
Apakah terdapat padding ganda atau tidak ada padding pada area yang membutuhkannya?
Apakah implementasi mengikuti optimasi_ui.md, desain.md, atau DESAINS.md jika file tersebut tersedia dan berlaku di proyek?
Baca dokumen referensi desain yang benar-benar tersedia. Jangan menganggap nama atau isi file desain tertentu pasti ada.

Pemeriksaan UX
Periksa hal-hal berikut:

Apakah tujuan setiap tombol dan tindakan dapat dipahami?
Apakah konsekuensi tindakan penting dijelaskan?
Apakah tindakan penghapusan memiliki konfirmasi yang sesuai?
Apakah proses berjalan, berhasil, gagal, atau membutuhkan perhatian memberikan feedback yang jelas?
Apakah pengguna dapat memahami bahwa suatu proses sedang berlangsung?
Apakah tindakan berulang yang tidak disengaja dicegah jika diperlukan?
Apakah proses yang membutuhkan waktu lama menghambat interaksi tanpa alasan?
Apakah teks yang ditampilkan kepada pengguna mengikuti bahasa yang formal dan baku sesuai ketentuan proyek?
Batas verifikasi tampilan
Pembacaan source dapat membuktikan struktur dan konfigurasi layout, tetapi tidak selalu membuktikan hasil render aktual.
Jangan mengklaim telah melihat tampilan aplikasi jika tidak benar-benar menggunakan preview atau bukti visual.
Jika hanya source code yang tersedia, tulis temuan sebagai masalah struktural atau potensi masalah visual yang didukung kode.
Jika hasil visual belum dapat dipastikan, tandai bahwa verifikasi visual masih diperlukan.
Jangan menganggap widget yang menyentuh tepi layar sebagai kesalahan jika hal tersebut memang disengaja oleh desain dan konsisten dengan referensi proyek.
TAHAP 8 — AUDIT DAN PERBARUI task.md
Setelah seluruh file dalam cakupan selesai diaudit, baca seluruh isi task.md di root proyek menggunakan read.

Jangan sekadar menambahkan temuan baru di bagian bawah. Evaluasi ulang seluruh task lama berdasarkan aturan dan kode terbaru.

Evaluasi setiap task lama
Untuk setiap task lama:

Periksa apakah file terkait masih ada.
Periksa apakah masalahnya masih ditemukan pada implementasi terbaru.
Periksa apakah nomor baris dan lokasi kode masih benar.
Periksa apakah task masih sesuai dengan .agents/rules/AGENTS.md dan aturan terkait.
Periksa apakah solusi lama masih benar dan dapat diterapkan pada versi SDK atau paket sekarang.
Periksa apakah task sudah diselesaikan oleh perubahan kode terbaru.
Periksa apakah task merupakan duplikasi dari task lain.
Keputusan terhadap task lama
Pertahankan task jika masalahnya masih terbukti ada.
Perbaiki deskripsi, bukti, prioritas, aturan yang dilanggar, path, dan nomor baris jika sudah tidak akurat.
Perbarui solusi jika solusi lama tidak lagi sesuai dengan source atau versi SDK/paket.
Hapus task yang terbukti sudah tidak terjadi atau sudah diselesaikan.
Hapus task yang terbukti merupakan duplikasi, dengan tetap mempertahankan seluruh file terkait pada satu task gabungan jika penyebabnya sama.
Hapus atau revisi task yang bertentangan dengan aturan terbaru berdasarkan bukti aturan yang jelas.
Jangan menghapus task hanya karena belum berhasil diverifikasi. Pertahankan dengan status Perlu diverifikasi dan jelaskan penyebabnya.
Jangan mempertahankan task lama hanya karena sebelumnya pernah dicatat.
Ketentuan task baru
Satu task mewakili satu masalah utama yang dapat ditindaklanjuti.
Beberapa file boleh dimasukkan ke satu task jika terbukti memiliki satu akar masalah yang sama.
Jangan menggabungkan masalah berbeda hanya karena berada dalam file atau fitur yang sama.
Jangan membuat task dari dugaan yang tidak memiliki bukti.
Jangan memasukkan ide fitur baru ke kategori Bug runtime, UX, atau UI.
TAHAP 9 — FORMAT DAN PRIORITAS task.md
Susun isi task.md dengan urutan kategori berikut:

# Bug runtime

# UX

# UI

Di dalam setiap kategori, susun urutan prioritas:

## Tinggi

## Sedang

## Rendah

Gunakan format berikut secara konsisten:

# Bug runtime

## Tinggi

- Status: Belum dikerjakan
- Masalah: Jelaskan masalah yang terbukti ditemukan.
- Solusi: Jelaskan solusi yang direkomendasikan dan dasar verifikasinya.
- Aturan dilanggar: `.agents/rules/AGENTS.md` — bagian/nama aturan/poin yang dilanggar.
- File terkait: [nama_file.dart#L21](lib/path/nama_file.dart#L21), [file_lain.dart#L50](lib/path/file_lain.dart#L50)

## Sedang

Tidak ada temuan.

## Rendah

Tidak ada temuan.

# UX

## Tinggi

Tidak ada temuan.

## Sedang

- Status: Belum dikerjakan
- Masalah: Jelaskan masalah UX yang terbukti ditemukan.
- Solusi: Jelaskan solusi yang direkomendasikan.
- Aturan dilanggar: Bukan pelanggaran aturan tertulis — jelaskan dasar masalahnya.
- File terkait: [nama_file.dart#L21](lib/path/nama_file.dart#L21)

## Rendah

Tidak ada temuan.

# UI

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

Tidak ada temuan.
Ketentuan format
Gunakan bahasa Indonesia yang baik, benar, formal, dan mudah dipahami.
Gunakan label Status, Masalah, Solusi, Aturan dilanggar, dan File terkait secara konsisten.
Status harus mencerminkan keadaan sebenarnya, misalnya Belum dikerjakan, Sedang dikerjakan, Perlu diverifikasi, atau Selesai.
Path tautan harus relatif dari root proyek.
Gunakan anchor nomor baris Markdown seperti #L21 jika didukung oleh penampil repository.
Nomor baris harus berasal dari hasil pembacaan file, bukan perkiraan.
Jika tidak ada temuan pada suatu prioritas, tulis Tidak ada temuan.
Jangan membuat task kosong hanya untuk memenuhi format.
Penentuan prioritas
Tinggi

Berpotensi menyebabkan aplikasi crash atau fitur utama gagal.
Berpotensi menyebabkan kehilangan, kerusakan, atau ketidakkonsistenan data yang serius.
Menimbulkan risiko keamanan atau integritas data yang serius.
Menghalangi alur utama aplikasi secara signifikan.
Sedang

Mengganggu fungsi tertentu tetapi tidak menyebabkan kegagalan kritis pada seluruh aplikasi.
Menimbulkan masalah state, resource, atau alur operasi yang nyata dengan dampak terbatas.
Menimbulkan kebingungan pengguna atau ketidakkonsistenan UI yang cukup mengganggu.
Rendah

Masalah minor yang tidak mengganggu fungsi utama.
Ketidakkonsistenan visual kecil.
Penyempurnaan kualitas implementasi yang tidak mendesak.
Tentukan prioritas berdasarkan dampak dan risiko nyata, bukan semata-mata karena aturan dilanggar.

TAHAP 10 — IDE FITUR BARU
Jika ditemukan ide fitur baru yang relevan:

Baca rencana_fitur_baru.md di root proyek. Path tersebut setara dengan ../../rencana_fitur_baru.md jika dihitung dari lokasi command .kilo/commands/scan.md.
Pastikan ide tersebut belum tercatat dengan nama atau maksud yang berbeda.
Pastikan ide tersebut benar-benar fitur baru, bukan bug, perubahan UI, atau penyempurnaan fitur yang sudah tersedia.
Jelaskan tujuan, manfaat, dan gambaran implementasinya secara ringkas tetapi jelas.
Tambahkan hanya ide yang memiliki alasan kuat dan relevan dengan aplikasi.
Ikuti format serta urutan prioritas yang sudah digunakan di file tersebut. Jangan mengubah sistem prioritas yang sudah ada tanpa alasan.
Jangan menghapus ide lama yang masih relevan.
Jangan memaksakan ide fitur jika tidak ada temuan yang layak.
Jika file belum ada, pastikan terlebih dahulu bahwa path root proyek memang tidak memiliki file tersebut. Buat hanya jika ada ide fitur yang layak dan pembuatan file diperlukan untuk memenuhi tujuan ini.

C. PENANGANAN AUDIT YANG BELUM SELESAI
Jika ada file yang tidak dapat dibaca, source yang tidak dapat diakses, atau batas tool/konteks yang menghalangi pemeriksaan:

Jangan tandai item file tersebut selesai di todowrite.
Catat path file dan bagian yang belum terbaca.
Catat penyebabnya secara spesifik, misalnya akses ditolak, hasil baca terpotong dan tidak dapat dilanjutkan, atau tool tidak tersedia.
Jangan membuat klaim bahwa seluruh lib/ telah diaudit.
Jangan menghapus task lama yang belum dapat diverifikasi.
Jika task.md tetap perlu diperbarui, hanya ubah temuan yang sudah dapat diverifikasi dan beri status Perlu diverifikasi pada task lama yang belum dapat dipastikan. Jelaskan cakupan audit yang belum selesai pada laporan.
Jangan menyembunyikan keterbatasan dengan ringkasan yang menyatakan audit selesai.
D. PEMERIKSAAN AKHIR
Sebelum menyelesaikan pekerjaan, pastikan:

Seluruh file Dart dalam cakupan sudah tercantum satu per satu di checklist todowrite.
Setiap file yang ditandai selesai memang sudah dibaca seluruh isinya dengan read dan diperiksa.
File .g.dart dan .freezed.dart saja yang dikecualikan.
Tidak ada penggunaan terminal atau bash.
Tidak ada file Dart atau konfigurasi proyek yang diubah.
Setiap temuan memiliki bukti, nomor baris, dan identitas aturan yang tepat jika melanggar aturan.
Solusi yang memerlukan verifikasi SDK/paket sudah diperiksa terhadap source yang relevan atau secara jujur ditandai belum terverifikasi.
Pemeriksaan UI membedakan bukti struktural dari tampilan aktual yang belum dilihat.
Seluruh task lama sudah dievaluasi terhadap kode dan aturan terbaru sejauh file terkait berhasil diperiksa.
Tidak ada task duplikat.
Kategori dan prioritas task sudah benar.
Path serta nomor baris pada task.md benar.
rencana_fitur_baru.md diperiksa dan hanya diperbarui jika ada ide fitur baru yang layak.
Checklist todowrite mencerminkan status pekerjaan yang sebenarnya.
E. LAPORAN HASIL AUDIT
Setelah audit selesai atau terhenti karena keterbatasan, berikan laporan berikut:

1. Ringkasan inventaris
   Total file Dart ditemukan:
   File yang dikecualikan (.g.dart dan .freezed.dart):
   Total file yang wajib diperiksa:
   Total file yang berhasil dibaca dan diperiksa:
   Total file yang belum selesai diperiksa:
2. Hasil temuan
   Bug runtime: jumlah temuan.
   UX: jumlah temuan.
   UI: jumlah temuan.
   Total pelanggaran aturan tertulis:
   Total masalah yang bukan pelanggaran aturan tertulis:
3. Perubahan task
   Task baru:
   Task lama yang diperbarui:
   Task yang dihapus karena sudah selesai/tidak relevan:
   Task duplikat yang digabung atau dihapus:
   Task yang masih perlu diverifikasi:
4. Evaluasi aturan
   Sebutkan aturan yang paling sering dilanggar, file terkait, dan pola masalahnya. Informasi ini digunakan pengguna untuk mengevaluasi apakah aturan perlu diperjelas atau diperbaiki.

Jika ditemukan konflik antaraturan, sebutkan kedua lokasi aturan dan jelaskan konfliknya. Jangan menyelesaikan konflik dengan asumsi.

5. File dokumentasi yang diperbarui
   Sebutkan path file yang benar-benar berhasil diperbarui. Jangan menyatakan file diperbarui jika tool edit/write gagal.

6. Keterbatasan
   Sebutkan seluruh file atau bagian yang belum dibaca, source SDK/paket yang belum dapat diakses, dan verifikasi visual yang belum dilakukan.

KETENTUAN PALING PENTING
Audit harus berdasarkan pembacaan langsung setiap file Dart, bukan hanya pencarian pola.
Checklist todowrite wajib memuat satu item untuk setiap file Dart yang harus diperiksa.
Item hanya boleh dicentang setelah seluruh isi file dibaca dan diperiksa.
Setiap pembaruan todowrite harus mempertahankan seluruh item serta status sebelumnya karena pembaruan mengganti seluruh checklist.
Jangan menganggap jumlah file yang banyak sebagai alasan untuk melewatkan pemeriksaan. Kerjakan bertahap.
Jangan membuat temuan, bukti, solusi, nomor baris, atau pelanggaran aturan yang tidak dapat dibuktikan.
Jangan mengubah file Dart.
Jangan menggunakan terminal atau bash.
Jangan menyatakan audit selesai 100% jika masih ada file yang belum diperiksa.
task.md harus mencerminkan kondisi kode dan aturan proyek yang terbaru, bukan sekadar menyimpan daftar task lama.
⋮⋮⋮⋮
