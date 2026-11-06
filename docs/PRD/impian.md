# MASALAH

- user bisa membuat impian, misalnya membeli barang-barang mengenai kendaraan user.
- user bisa tahu berapa lama lagi impiannya tercapai.
- jika tanggal targetnya tidak kosong, user bisa mengetahui harus kumpulkan berapa rupiah per hari agar impiannya bisa dibeli sesuai tanggal targetnya.
- user bisa tahu berapa yang user harus tabung per hari agar impiannya bisa segera terbeli ketika tanggal targetnya tercapai.
- user ingin tahu daftar impian yang telah mereka buat, beserta per itemnya user bisa langsung tahu progresnya, berapa targetnya per item lalu berapa per harinya yang user harus kumpulkan, tanpa melihat detail item satu per satu.

# SOLUSI

<!-- semua masalah diatas harus diberikan solusi -->

## Fitur yang Harus Dibuat

### Fitur 1: Manajemen Data Impian (CRUD)

- Masalah yang diatasi: user bisa membuat impian terkait kendaraan.
- Solusi: Halaman daftar impian beserta form tambah, edit, dan hapus impian. Setiap impian dilampirkan ke satu kendaraan yang terpilih, dengan deskripsi dan jumlah target. Terdapat fitur pencarian dan pengurutan (sortir) daftar impian.

### Fitur 2: Estimasi Waktu Tercapai Impian

- Masalah yang diatasi: user bisa tahu berapa lama lagi impiannya tercapai.
- Solusi: Hitung estimasi waktu sisa hingga impian tercapai berdasarkan sisa target (jumlah target - total tabungan terkumpul) dibagi rata-rata tabungan per hari sejak impian dibuat. Tampilkan estimasi waktu (hari/bulan) pada halaman detail impian.

### Fitur 3: Target Rupiah Per Hari Berdasarkan Tanggal Target

- Masalah yang diatasi: jika tanggal target tidak kosong, user mengetahui harus kumpulkan berapa rupiah per hari agar impian tercapai sesuai tanggal target.
- Solusi: Tambahkan field tanggal target pada model impian. Hitung jumlah rupiah yang harus terkumpul per hari dari sekarang hingga tanggal target agar jumlah target tercapai. Tampilkan target rupiah harian pada halaman detail impian.

### Fitur 4: Estimasi Tabungan Harian (Dengan atau Tanpa Tanggal Target)

- Masalah yang diatasi: user bisa tahu berapa yang user harus tabung per hari agar impiannya bisa segera terbeli ketika tanggal targetnya tercapai.
- Solusi: Tambahkan fitur perhitungan estimasi rupiah yang harus ditabung per hari, baik ketika tanggal target ditentukan maupun tidak. Jika tanggal target ditentukan, hitung target rupiah harian berdasarkan sisa target (jumlah target - total tabungan terkumpul) dibagi selisih hari hingga tanggal target (seperti Fitur 3). Jika tanggal target tidak ditentukan, hitung estimasi tabungan harian tanpa bergantung pada tanggal target: sistem menghitung sisa target, lalu membaginya dengan estimasi waktu penyelesaian (dalam hari) berdasarkan rata-rata tabungan per hari sejak impian dibuat, agar impian segera tercapai. Digunakan sebagai estimasi tambahan ketika tanggal target tidak ditentukan. Tampilkan estimasi tabungan harian pada halaman detail impian.

### Fitur 5: Daftar Impian dengan Progres dan Estimasi Perhari

- Masalah yang diatasi: user ingin tahu daftar impian yang telah mereka buat, beserta progressnya, targetnya, dan berapa per hari yang user harus kumpulkan, tanpa melihat detail item satu per satu.
- Solusi: Tambahkan kolom progres, jumlah target, dan estimasi tabungan per hari pada setiap item daftar impian di halaman `impian_page.dart`. Data dihitung dari total tabungan terkumpul (tipe pemasukan) dibandingkan jumlah target impian. Estimasi perharian dihitung berdasarkan sisa jumlah dibagi selisih hari hingga tanggal target (jika ada).
