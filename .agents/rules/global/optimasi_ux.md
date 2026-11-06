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
