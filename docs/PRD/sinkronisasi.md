# MASALAH

- saya ingin ada sinkronisasi otomatis.
- user bisa menentukan sendiri kapan sinkronisasi ini dijalankan misalnya per hari, per minggu, atau per bulan.
- jangan ada sinkronisasi ganda.
- harus mengatasi jika user belum mendaftarkan akun Google Drive-nya.

# SOLUSI

Berikut adalah solusi yang menangani setiap masalah di bagian MASALAH, dengan memetakan masalah ke fitur yang harus dibuat dan file-file terkait yang sudah ada di proyek.

## Fitur yang Harus Dibuat

### Fitur 1: Sinkronisasi Otomatis ke Google Drive

**Masalah yang diatasi:** "saya ingin ada sinkronisasi otomatis."

Deskripsi:

- Database SQLite lokal (`app.db`) diupload ke Google Drive (`appDataFolder`) secara otomatis sesuai frekuensi yang dipilih user.
- Proses berjalan silent (tidak menampilkan toast, tidak mengubah state loading global) agar tidak mengganggu UI.
- Sebelum upload, database ditutup dulu (`dbSqfliteProvider.close()`) agar file tidak terkunci.
- File disimpan dengan nama `app_backup.db` di folder tersembunyi aplikasi (appDataFolder), sehingga tidak terlihat oleh user di UI Google Drive.

File terkait:

- `lib/fitur/sinkronisasi/service/sinkronisasi_service.dart` (`sinkronisasiOtomatis`)
- `lib/fitur/sinkronisasi/sinkronisasi_page.dart` (`_jalankanSinkronisasiOtomatis`)
- `lib/shared/sinkronisasi/google_drive_helper.dart` (`uploadFile`, `downloadFile`)
- `lib/shared/db/sqflite/db_sqflite.dart` (`close`)

---

### Fitur 2: Pengaturan Frekuensi Sinkronisasi (Perhari / Perminggu / Perbulan)

**Masalah yang diatasi:** "user bisa menentukan sendiri kapan sinkronisasi ini dijalankan misalnya perhari, perminggu, atau perbulan."

Deskripsi:

- User dapat memilih frekuensi sinkronisasi melalui dropdown di halaman sinkronisasi.
- Tiga opsi: perhari, perminggu, perbulan.
- Pilihan disimpan ke SharedPref dengan kunci `waktu_sinkronisasi`.
- Saat aplikasi dibuka, pengaturan frekuensi dimuat kembali dari SharedPref.
- Enum `WaktuSinkronisasiEnum` menyediakan label human-readable untuk setiap opsi.

File terkait:

- `lib/fitur/sinkronisasi/enum/waktu_sinkronisasi_enum.dart` (`perhari`, `perminggu`, `perbulan`)
- `lib/fitur/sinkronisasi/sinkronisasi_page.dart` (`_frekuensi`, `_simpanFrekuensi`, dropdown)
- `lib/shared/konstanta/shared_keys.dart` (`waktuSinkronisasi`)

---

### Fitur 3: Pencegahan Sinkronisasi Ganda (Idempoten)

**Masalah yang diatasi:** "jangan ada sinkronisasi ganda."

Deskripsi:

- Setiap sinkronisasi berhasil mencatat timestamp terakhir (`last_sinkronisasi`) ke SharedPref.
- Sebelum melakukan upload, sistem memeriksa apakah sudah waktunya sinkronisasi dengan `perluSinkronisasi()` berdasarkan frekuensi dan timestamp terakhir.
- Jika belum waktunya (masih dalam periode yang sama), sinkronisasi dilewati (return false).
- Jika file dengan nama `app_backup.db` sudah ada di appDataFolder, file lama dihapus dulu sebelum upload baru, sehingga tidak menumpuk / tidak ada duplikasi file di Google Drive.

File terkait:

- `lib/fitur/sinkronisasi/service/sinkronisasi_service.dart` (`perluSinkronisasi`, `bacaLastSinkronisasi`, `catatLastSinkronisasi`, `sinkronisasiOtomatis`)
- `lib/shared/konstanta/shared_keys.dart` (`lastSinkronisasi`)
- `lib/shared/sinkronisasi/google_drive_helper.dart` (`uploadFile` — hapus file lama sebelum upload)

---

### Fitur 4: Penanganan Belum Login Google Drive

**Masalah yang diatasi:** "harus atasi, jika user belum daftarkan akun google drive nya."

Deskripsi:

- Sebelum melakukan sinkronisasi apa pun, sistem memeriksa `GoogleDriveHelper.sudahLogin`.
- Jika user belum login, tampilkan status "Belum login" dan tombol "Login Google" untuk login interaktif.
- Terdapat metode `cobaLoginOtomatis()` untuk mencoba login tanpa dialog (gunakan sesi tersimpan jika ada).
- Jika belum login, sinkronisasi otomatis otomatis dilewati (return false) tanpa error.
- Setelah login berhasil, email ditampilkan dan tombol Backup / Restore / Logout tersedia.
- Tombol logout tersedia untuk keluar dari akun Google Drive.

File terkait:

- `lib/shared/sinkronisasi/google_drive_helper.dart` (`sudahLogin`, `email`, `login`, `logout`, `cobaLoginOtomatis`)
- `lib/fitur/sinkronisasi/sinkronisasi_page.dart` (`_login`, `_logout`, `_status`, `_email`, tombol login/logout)
- `lib/fitur/sinkronisasi/service/sinkronisasi_service.dart` (`sinkronisasiOtomatis` — cek `sudahLogin` di awal)

# KEBUTUHAN

# ALUR KERJA

# KONSTRAINTA

# KODE YANG DIBUAT

# FILE TERKAIT

# STATISTIK

# KOMENTAR
