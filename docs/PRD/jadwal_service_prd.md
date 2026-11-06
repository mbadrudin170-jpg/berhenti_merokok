# MASALAH

1. User ingin tahu kapan waktunya untuk service,
2. user bisa mencatat beberapa jadwal service untuk kendaraannya.
3. user ingin tahu berapa total biaya yang harus user keluarkan per KM, per hari, per minggu, per bulan dan per tahun untuk semua service yang ada.
4. user ingin tahu berapa KM atau bulan/hari lagi untuk service.
5. user bisa tahu service mana yang paling mendekati untuk segera di service.
6. ada notifikasi ketika sudah waktunya service baik itu berdasarkan tanggal ataupun KM.
7. user ingin mengetahui untuk service A komponen apa saja yang akan di service.
8. user ingin tahu berapa biaya per komponen untuk service A ini.
9. user ingin tahu berapa biaya untuk service A, berapa biaya per KM, per hari, per minggu, per bulan dan per tahun
10. user bisa cari jadwal service-nya.
11. user bisa sorting jadwal service-nya.
12. dummy: buat file dummy-nya untuk ditambahkan ke Sqflite.
13. user ingin tahu berapa biaya untuk masing-masing komponennya dalam satu jadwal service, per KM, per hari, per minggu dan per tahun.
14. saya ingin menampilkan total semua komponen dari semua jadwal service berapa biaya per KM, per hari, per minggu, per bulan dan per tahun.
15. saya ingin menampilkan semua total biaya jadwal service yang user tambahkan, lalu total biaya per KM, per hari, per minggu, per bulan dan per tahun.
16. saya ingin menampilkan rincian misalnya Komponen A berapa total biayanya dari akumulasi jadwal service yang menggunakan komponen ini.
17. saya ingin menampilkan biaya total per komponen, dan biayanya per KM, per hari, per minggu dan per bulan.
18. user bisa urutkan biaya per komponen, berdasarkan biaya tertinggi dan terendah

# SOLUSI

## Fitur yang Harus Dibuat

### Fitur 1: Manajemen Jadwal Service (CRUD, Pencarian, Sorting, Sisa Waktu & KM, Notifikasi)

Fitur ini memungkinkan user mencatat, mengubah, dan menghapus beberapa jadwal service untuk kendaraannya. Setiap jadwal service memiliki nama, interval bulan, interval KM, KM terakhir service, dan tanggal terakhir service. Fitur ini juga menampilkan perhitungan sisa KM dan sisa bulan/hari sampai service berikutnya, serta menentukan service mana yang paling mendekati (paling mendesak) melalui sorting dengan skor urgensi. Terdapat fitur pencarian jadwal service berdasarkan nama, bulan, atau KM. Selain itu, fitur ini menyediakan notifikasi peringatan ketika sudah waktunya service baik berdasarkan tanggal maupun KM.

- Terkait masalah: 1, 2, 4, 5, 6, 10, 11
- Solusi notifikasi: Menggunakan paket `flutter_local_notifications` untuk jadwal notifikasi lokal. Notifikasi akan dipicu ketika sisa KM <= 0 atau sisa bulan/hari <= 0. Pengaturan notifikasi (aktif/nonaktif dan waktu pengingat, misal: 1 hari, 3 hari, 7 hari sebelum target) diatur di halaman pengaturan.
- Status implementasi: CRUD, pencarian, sorting (termasuk "Paling Mendesak"), perhitungan sisa waktu/KM, dan notifikasi waktu service (berdasarkan tanggal atau KM) sudah diimplementasi.

### Fitur 2: Manajemen Komponen dalam Jadwal Service

Fitur ini memungkinkan user mengetahui komponen apa saja yang akan di service dalam satu jadwal service (service A), beserta biaya per komponen dan total biaya komponen untuk jadwal tersebut. User juga dapat menambahkan komponen langsung saat berada di form jadwal service. Komponen dapat diurutkan berdasarkan nama atau harga.

- Terkait masalah: 7, 8
- Status implementasi: Relasi komponen jadwal service, daftar komponen di detail jadwal service, total biaya komponen, dan tambah komponen di form jadwal service sudah diimplementasi.

### Fitur 3: Statistik & Perhitungan Biaya Service

Fitur ini menampilkan total biaya yang harus dikeluarkan user untuk semua service yang ada, per KM, per hari, per minggu, per bulan, dan per tahun. Selain itu, fitur ini menampilkan biaya untuk masing-masing komponen dalam satu jadwal service, per KM, per hari, per minggu, dan per tahun, sehingga user bisa mengetahui biaya service A secara detail beserta distribusinya per satuan waktu.

- Terkait masalah: 3, 9, 13, 14, 15, 16, 17, 18
- Solusi biaya per service individual: Tambahkan method di `JadwalServiceState` untuk menghitung total biaya komponen per `jadwalServiceId`, lalu bagi dengan total KM/bulan/hari/minggu/tahun dari jadwal tersebut untuk menampilkan biaya per satuan waktu tiap service.
- Solusi biaya per komponen per satuan waktu: Di halaman detail jadwal service, tampilkan setiap komponen dengan harga dan bagi harga komponen tersebut dengan total KM/bulan/hari/minggu/tahun dari jadwal service induk.
- Solusi biaya total per komponen dan biaya per satuan waktu per komponen (masalah 17): Tambahkan method di `JadwalServiceState` untuk menghitung total biaya per komponen dari seluruh jadwal service yang menggunakan komponen tersebut, lalu bagi dengan total KM/bulan/hari/minggu/tahun akumulasi untuk menampilkan biaya per satuan waktu tiap komponen. Tampilkan di halaman statistik.
- Solusi pengurutan biaya per komponen berdasarkan tertinggi dan terendah (masalah 18): Tambahkan opsi sorting di halaman statistik/detail komponen untuk mengurutkan daftar biaya per komponen dari nilai tertinggi ke terendah dan sebaliknya.
- Solusi akumulasi biaya per komponen dari semua jadwal service: Tambahkan method di `JadwalServiceState` untuk menghitung total biaya per komponen dari seluruh jadwal service yang menggunakan komponen tersebut, dengan mengiterasi semua relasi jadwal service-komponen dan menjumlahkan harga komponen yang sama.
- Solusi total semua komponen dari semua jadwal service per satuan waktu (masalah 14): Jumlahkan seluruh biaya komponen dari seluruh jadwal service, lalu bagi dengan total KM/bulan/hari/minggu/tahun akumulasi untuk menampilkan total biaya semua komponen per satuan waktu. Tampilkan di halaman statistik.
- Status implementasi: Statistik total biaya semua service per satuan waktu, biaya per jadwal service individual per satuan waktu, biaya per masing-masing komponen per satuan waktu, akumulasi biaya per komponen dari semua jadwal service, biaya total per komponen dengan biaya per satuan waktu, dan pengurutan biaya per komponen sudah diimplementasi (`statistik_jadwal_service_page.dart` dan `detail_jadwal_service.dart`).

### Fitur 4: Data Dummy untuk Sqflite

Fitur ini menyediakan file dummy data yang dapat ditambahkan ke database Sqflite untuk keperluan pengembangan dan pengujian. Data dummy mencakup kendaraan, komponen, jadwal service, dan relasi jadwal service-komponen.

- Terkait masalah: 12
- Status implementasi: Sudah diimplementasi (dummy_jadwal_service.dart, dummy_jadwal_service_komponen.dart, dummy_komponen.dart, dummy_data.dart).
