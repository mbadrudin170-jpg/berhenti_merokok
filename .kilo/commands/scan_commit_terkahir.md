Metadata
description
Evaluasi 15 commit terakhir terhadap AGENTS.md dan sinkronkan task.md dengan kondisi kode saat ini.
agent
code
Command: /scan_commit_terkahir
Path file: .kilo/commands/scan_commit_terkahir.md

Tujuan
Evaluasi maksimal 15 commit terakhir pada repository untuk memastikan perubahan kode sesuai dengan seluruh aturan yang berlaku di AGENTS.md. Jika ditemukan pelanggaran yang masih ada pada kode saat ini, tambahkan atau perbarui tugas perbaikannya di task.md.

Selain itu, periksa seluruh tugas lama di task.md. Hapus tugas yang statusnya masih belum dikerjakan apabila implementasinya ternyata sudah selesai dan dapat dibuktikan dari kode saat ini.

Command ini adalah kegiatan audit dan sinkronisasi task.md, bukan perintah untuk memperbaiki kode aplikasi.

Batasan utama
Jangan mengubah kode aplikasi, konfigurasi proyek, file pengujian, atau file dokumentasi selain task.md.
Jangan membuat commit, amend commit, reset, rebase, checkout, stash, cherry-pick, push, atau menjalankan perintah Git yang mengubah riwayat maupun working tree.
Jangan menghapus, membatalkan, atau menimpa perubahan pengguna yang belum di-commit.
Jangan mengubah AGENTS.md atau file aturan sumber.
File yang boleh dibuat atau diperbarui oleh command ini hanya task.md di root proyek, dan hanya jika memang diperlukan.
Jangan membuat tugas berdasarkan asumsi, preferensi pribadi, atau standar yang tidak diperintahkan oleh aturan proyek. Gunakan aturan yang benar-benar berlaku di AGENTS.md dan aturan terkait yang dirujuk olehnya.
Jangan menganggap semua perubahan dalam commit otomatis benar. Setiap perubahan tetap harus dievaluasi.
Tahap 1 — Kenali repository dan kondisi Git
Pastikan direktori kerja merupakan repository Git. Jika bukan, hentikan proses dan jelaskan penyebabnya.
Periksa dan catat:
root repository;
branch aktif;
commit HEAD;
kondisi working tree menggunakan git status --short.
Jangan mengubah atau membersihkan perubahan yang belum di-commit.
Evaluasi riwayat commit dan perubahan working tree sebagai dua hal yang berbeda. Fokus audit commit tetap pada commit yang dipilih. Perubahan yang belum di-commit bukan bagian dari 15 commit tersebut.
Saat memeriksa apakah tugas lama sudah diimplementasikan, periksa kode yang benar-benar tersedia saat ini. Jika implementasinya hanya terdapat pada perubahan yang belum di-commit, tetap laporkan bahwa implementasi tersebut belum di-commit.
Tahap 2 — Baca aturan yang berlaku
Baca seluruh isi AGENTS.md di root repository sebelum mengevaluasi commit.
Identifikasi aturan, instruksi, dan file referensi yang dirujuk oleh AGENTS.md. Baca bagian yang relevan sebelum mengambil keputusan.
Periksa apakah terdapat AGENTS.md tambahan pada direktori yang berisi file-file yang diubah. Jika ada, baca dan terapkan aturan tersebut hanya pada cakupan direktori yang sesuai.
Jangan mengabaikan aturan yang lebih spesifik pada direktori atau file tertentu.
Jika terdapat aturan yang saling bertentangan, jangan memilih salah satunya berdasarkan asumsi. Catat konflik tersebut dan jangan membuat tugas yang bergantung pada keputusan yang belum jelas.
Tahap 3 — Tentukan maksimal 15 commit terakhir
Ambil maksimal 15 commit terbaru yang dapat dijangkau dari HEAD pada branch aktif.
Gunakan seluruh commit yang tersedia apabila jumlahnya kurang dari 15.
Jangan membatasi evaluasi hanya pada commit yang mengubah file Dart. Semua jenis perubahan harus diperiksa, termasuk konfigurasi, pengujian, aset, dokumentasi, dan file pendukung lainnya.
Catat hash, tanggal, dan pesan setiap commit.
Evaluasi commit dari yang paling lama ke yang paling baru di antara 15 commit terpilih. Urutan ini diperlukan agar dapat diketahui apakah pelanggaran pada commit lama sudah diperbaiki oleh commit berikutnya.
Sertakan commit merge dalam rentang evaluasi. Untuk commit merge, evaluasi perubahan yang masuk ke jalur utama repository dengan membandingkannya terhadap parent pertama (first parent). Jangan sampai perubahan hasil merge terlewat.
Tahap 4 — Baca dan evaluasi commit satu per satu
WAJIB membaca setiap commit secara individual. Dilarang hanya membaca pesan commit, ringkasan statistik, atau hasil rangkuman seluruh commit.

Untuk setiap commit, lakukan langkah berikut secara berurutan:

Baca metadata commit, termasuk hash, tanggal, pesan, dan parent commit.
Baca daftar seluruh file yang ditambahkan, diubah, dihapus, atau dipindahkan.
Baca diff lengkap commit tersebut satu per satu. Jangan melompat ke commit berikutnya sebelum perubahan pada commit yang sedang diperiksa dipahami.
Jika diff terlalu panjang untuk diperiksa sekaligus, pecah pemeriksaan berdasarkan file atau bagian diff. Pastikan semua perubahan relevan tetap terbaca; jangan menyimpulkan hanya dari potongan awal.
Untuk setiap file yang berubah, pahami kode sebelum dan sesudah perubahan serta konteks kode di sekitarnya jika diperlukan.
Cocokkan perubahan dengan aturan AGENTS.md dan aturan tambahan yang berlaku pada file tersebut.
Evaluasi semua aspek yang memang diatur oleh aturan proyek, termasuk namun tidak terbatas pada:
ketepatan implementasi dan potensi bug;
keamanan dan kestabilan runtime;
pengelolaan state dan aliran data;
penggunaan Flutter, Dart, SDK, dan package;
struktur, keterbacaan, konsistensi, dan gaya penulisan kode;
efisiensi, performa, rebuild, dan pengelolaan resource;
UX/UI dan perilaku interaksi pengguna;
penanganan error, loading, dan kondisi kosong;
kualitas serta relevansi pengujian;
kepatuhan terhadap larangan dan batasan dalam aturan proyek.
Evaluasi hanya aspek yang relevan dengan perubahan dan aturan yang berlaku. Jangan memaksakan semua kategori jika tidak berhubungan dengan commit tersebut.
Untuk file generated, binary, atau diff yang tidak dapat dibaca secara normal, cari sumber atau konteks yang relevan. Jika tetap tidak dapat dievaluasi, catat keterbatasannya; jangan mengklaim file tersebut sudah diperiksa secara menyeluruh.
Catat setiap temuan dengan bukti: hash commit, path file, bagian kode atau simbol terkait, aturan yang dilanggar, dan penjelasan ketidaksesuaiannya.
Tahap 5 — Bedakan pelanggaran historis dan pelanggaran yang masih ada
Setelah seluruh commit selesai dibaca:

Telusuri perubahan dari commit berikutnya untuk mengetahui apakah pelanggaran pada commit sebelumnya sudah diperbaiki.
Periksa kondisi kode saat ini untuk memastikan apakah setiap temuan masih benar-benar terjadi.
Terapkan keputusan berikut:
Sudah diperbaiki oleh commit berikutnya: catat sebagai pelanggaran historis yang telah diselesaikan. Jangan tambahkan tugas perbaikan baru.
Masih terjadi pada kode saat ini: masukkan ke task.md sebagai tugas yang perlu dikerjakan.
Tidak dapat dibuktikan: jangan menyatakan sebagai pelanggaran yang pasti. Catat ketidakpastian dan bukti yang masih diperlukan.
Bukan pelanggaran terhadap aturan yang berlaku: jangan masukkan ke task.md hanya karena AI memiliki preferensi implementasi yang berbeda.
Jangan membuat tugas untuk masalah yang sama lebih dari satu kali. Gabungkan temuan yang memiliki akar masalah dan tindakan perbaikan yang sama jika penggabungan tidak menghilangkan kejelasan lokasi atau ruang lingkupnya.
Jangan menganggap kode yang baru ditambahkan pasti salah hanya karena berbeda dari pola kode lama. Nilai berdasarkan aturan yang berlaku dan dampak implementasinya.
Tahap 6 — Evaluasi tugas lama di task.md
Periksa apakah task.md di root repository tersedia. Jika tersedia, baca seluruh isinya sebelum melakukan perubahan.
Periksa setiap tugas yang masih berstatus belum dikerjakan, pending, atau status lain yang menunjukkan bahwa tugas belum selesai.
Untuk setiap tugas, telusuri path file, nama class, fungsi, widget, provider, fitur, atau objek lain yang disebutkan. Periksa implementasi aktual, bukan hanya judul atau deskripsi tugas.
Hapus tugas lama apabila implementasinya sudah benar-benar selesai pada kode saat ini, meskipun status di task.md masih menunjukkan belum dikerjakan.
Tugas hanya boleh dihapus jika seluruh ruang lingkup dan kriteria penyelesaiannya telah terpenuhi. Keberadaan kode yang namanya mirip dengan tugas tidak cukup untuk membuktikan bahwa tugas sudah selesai.
Jika hanya sebagian yang sudah diimplementasikan:
jangan hapus seluruh tugas;
perbarui deskripsi agar hanya memuat pekerjaan yang masih belum selesai;
pertahankan informasi yang masih relevan.
Jika implementasi belum dapat dibuktikan, pertahankan tugas tersebut. Jangan menghapusnya berdasarkan dugaan.
Jangan menghapus tugas yang belum dikerjakan hanya karena tidak ditemukan dalam 15 commit terakhir. Tugas tersebut mungkin berasal dari audit atau kebutuhan sebelumnya.
Jangan menghapus tugas yang masih diperlukan hanya karena sudah ada implementasi awal, jika hasil akhirnya belum memenuhi aturan atau kriteria tugas.
Saat menghapus tugas yang sudah diimplementasikan, hapus entri tugasnya dari daftar aktif. Jangan memindahkannya ke kategori lain atau menandainya selesai kecuali format task.md yang sudah ada memang secara khusus mensyaratkan riwayat tugas selesai.
Tahap 7 — Tambahkan atau perbarui pelanggaran di task.md
Jika ditemukan pelanggaran terhadap aturan yang masih ada pada kode saat ini:

Tambahkan tugas baru atau perbarui tugas lama yang membahas masalah yang sama.
Sebelum menambah tugas, periksa seluruh task.md untuk menghindari duplikasi.
Ikuti struktur, kategori, format status, dan sistem prioritas yang sudah digunakan oleh task.md. Jangan mengubah format keseluruhan tanpa kebutuhan.
Setiap tugas harus menjelaskan secara spesifik:
masalah atau perilaku yang salah;
path file yang terdampak;
class, fungsi, widget, provider, atau bagian kode terkait jika diketahui;
aturan AGENTS.md yang tidak dipatuhi;
tindakan perbaikan yang perlu dilakukan;
kriteria yang dapat digunakan untuk memastikan tugas benar-benar selesai.
Gunakan prioritas sesuai tingkat dampak dan sistem prioritas yang sudah berlaku di proyek. Jangan menaikkan prioritas tanpa alasan yang jelas.
Tulis tugas sebagai pekerjaan yang dapat dilaksanakan dan diverifikasi. Hindari deskripsi umum seperti "rapikan kode" atau "optimalkan aplikasi" tanpa ruang lingkup yang jelas.
Jika pelanggaran yang sama sudah tercatat, perbarui tugas yang ada daripada membuat tugas duplikat.
Jangan memasukkan temuan yang hanya berupa saran atau preferensi pribadi.
Jika tidak ditemukan pelanggaran yang masih ada, jangan membuat tugas baru.
Tahap 8 — Perbarui task.md dengan aman
Terapkan perubahan hanya setelah evaluasi commit dan pemeriksaan tugas lama selesai.
Pertahankan tugas yang masih valid, struktur dokumen, heading, kategori, urutan prioritas, serta format penulisannya.
Hapus hanya tugas yang terbukti sudah diimplementasikan secara lengkap.
Tambahkan hanya tugas untuk pelanggaran aturan yang masih terjadi dan belum tercatat.
Perbarui tugas yang sudah ada jika ruang lingkupnya berubah atau sebagian pekerjaannya telah selesai.
Jangan menghapus seluruh isi task.md atau menyusun ulang semua tugas tanpa alasan yang diperlukan.
Jika tidak ada tugas yang perlu ditambah, diperbarui, atau dihapus, jangan mengubah file task.md.
Jika task.md belum tersedia dan ada pelanggaran yang masih perlu diperbaiki, buat task.md dengan struktur yang paling sesuai dengan konvensi dokumentasi proyek. Jika tidak ada pelanggaran, jangan membuat file kosong.
Tahap 9 — Verifikasi hasil
Setelah perubahan task.md selesai:

Baca kembali seluruh task.md.
Pastikan setiap pelanggaran yang masih ada sudah memiliki tugas atau sudah tercakup oleh tugas yang relevan.
Pastikan tidak ada tugas duplikat.
Pastikan tugas yang sudah diimplementasikan secara lengkap telah dihapus dari daftar aktif.
Pastikan tugas yang baru ditambahkan memiliki bukti pelanggaran dan path file yang jelas.
Pastikan tidak ada file selain task.md yang berubah akibat command ini. Periksa menggunakan git status --short dan identifikasi perubahan yang memang sudah ada sebelum command dijalankan.
Jangan menjalankan formatter atau perintah lain yang dapat mengubah file aplikasi.
Format laporan akhir
Sampaikan laporan dalam bahasa Indonesia yang jelas dan terstruktur. Laporan wajib memuat:

1. Ringkasan pemeriksaan
   Jumlah commit yang diperiksa.
   Rentang hash commit paling lama dan paling baru.
   Branch dan HEAD yang diperiksa.
   Apakah terdapat perubahan working tree yang belum di-commit.
2. Hasil evaluasi commit
   Commit yang memiliki pelanggaran.
   Path file dan aturan yang dilanggar.
   Pelanggaran yang sudah diperbaiki oleh commit berikutnya.
   Pelanggaran yang masih terjadi pada kode saat ini.
   Keterbatasan pemeriksaan jika ada.
3. Perubahan task.md
   Jumlah tugas yang ditambahkan.
   Jumlah tugas yang diperbarui.
   Jumlah tugas lama yang dihapus karena sudah diimplementasikan.
   Alasan singkat untuk setiap perubahan tugas.
   Nyatakan secara jelas apabila task.md tidak berubah.
4. Status akhir
   Nyatakan apakah seluruh 15 commit (atau seluruh commit yang tersedia jika kurang dari 15) berhasil dievaluasi. Jangan menyatakan pemeriksaan selesai sepenuhnya apabila masih ada diff atau file yang belum dapat diperiksa.

Ketentuan keputusan
Bukti lebih penting daripada asumsi. Setiap temuan harus dapat ditelusuri ke perubahan kode dan aturan yang berlaku.
Evaluasi commit satu per satu. Jangan menggantinya dengan membaca ringkasan Git.
Kode saat ini menjadi dasar penentuan tugas aktif. Pelanggaran lama yang sudah diperbaiki tidak boleh menjadi tugas perbaikan baru.
Tugas yang sudah selesai harus dibersihkan. Jangan membiarkan tugas berstatus belum dikerjakan jika implementasinya terbukti sudah lengkap.
Jangan memperbaiki kode aplikasi dalam command ini. Catat pekerjaan yang diperlukan di task.md agar dapat dikerjakan secara terpisah.
