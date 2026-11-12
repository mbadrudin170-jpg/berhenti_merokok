# Format Berkas Hasil Diskusi

## 1. Tujuan

Aturan ini menetapkan format, lokasi, penamaan, status, dan kewajiban pencatatan berkas hasil diskusi (`diskusi_N.md`) agar setiap orang dan AI yang membuat atau memperbarui berkas tersebut menghasilkan isi yang konsisten.

## 2. Cakupan

- **Berkas yang diatur**: berkas hasil diskusi `diskusi_N.md` pada folder `hasil_diskusi/` di root proyek.
- **Mode terkait**: `.kilo/commands/mode/mode_diskusi.md` (aturan pelaksanaan mode diskusi) dan `.kilo/commands/kerjakan_hasil_diskusi.md` (tindak lanjut hasil diskusi).
- **Aturan format PRD**: `.agents/rules/global/format_PRD.md` (struktur dan aturan pengisian PRD).
- **Dokumen lain**: `MEMORI.md` (bagian `Lokasi Hasil Diskusi`, `Riwayat Diskusi`, dan `Riwayat Perubahan`).

## 3. Hubungan dengan `format_PRD.md`

1. `format_PRD.md` adalah **satu-satunya sumber kebenaran** untuk struktur, judul, jumlah bagian, dan aturan pengisian PRD.
2. Aturan ini adalah **sumber kebenaran khusus** untuk hal-hal yang melekat pada berkas hasil diskusi: lokasi folder, penamaan, penomoran, status dokumen/implementasi, pencatatan, dan larangan.
3. Jika terjadi konflik:
   - Untuk **struktur dan isi bagian PRD**, `format_PRD.md` yang berlaku.
   - Untuk **lokasi, penamaan, penomoran, status, dan pencatatan**, aturan ini yang berlaku.
4. **DILARANG** menduplikasi templat PRD ke dalam aturan ini atau ke dalam berkas hasil diskusi secara tidak lengkap. Rujuk `format_PRD.md` dan ikuti versi yang berlaku saat diskusi.

## 4. Aturan Lokasi dan Penamaan

1. Seluruh berkas hasil diskusi **WAJIB** disimpan di folder `hasil_diskusi/` pada root proyek.
2. Nama berkas **WAJIB** berformat `diskusi_N.md` dengan `N` berupa bilangan bulat positif tanpa awalan nol (contoh: `diskusi_1.md`, `diskusi_12.md`).
3. Penentuan nomor:
   - Jika folder `hasil_diskusi/` kosong, gunakan nomor `1`.
   - Jika sudah ada berkas, gunakan **nomor tertinggi + 1**.
   - Nomor yang terlewat (gap) **tidak diisi**; tetap gunakan `tertinggi + 1`.
4. **DILARANG** menyimpan berkas hasil diskusi di lokasi lain (mis. `prd/`, `docs/`, atau root tanpa folder).
5. **DILARANG** menimpa berkas hasil diskusi yang sudah ada. Diskusi baru selalu membuat berkas baru dengan nomor berikutnya.

## 5. Aturan Struktur Isi

1. Berkas **WAJIB** mencakup **seluruh bagian PRD** sebagaimana ditetapkan `format_PRD.md` pada saat diskusi berlangsung.
2. **Jumlah dan judul bagian DILARANG di-hardcode** di aturan lain maupun di dalam berkas hasil diskusi secara mendasar. Selalu ikuti versi `format_PRD.md` yang berlaku.
3. Bagian pembuka **WAJIB** berupa:
   - Judul H1: `# PRODUCT REQUIREMENTS DOCUMENT (PRD)`.
   - `**Status Dokumen:**` dan `**Status Implementasi:**`.
   - Pemisah `---`.
4. Setiap bagian PRD **WAJIB** mempertahankan urutan baku: konteks penggunaan, aturan pengisian, lalu isi (narasi atau tabel) sesuai `format_PRD.md`.
5. Seluruh isi **WAJIB** menggunakan bahasa Indonesia, gaya teknis ringkas, tanpa pengalaman konversasi.
6. Seluruh isi **WAJIB** didasarkan pada hasil diskusi dan informasi proyek yang diketahui. **DILARANG mengarang informasi.**

## 6. Aturan Status

1. `**Status Dokumen:**` **WAJIB** diisi salah satu dari:
   - `Draft` — masih dibahas atau belum disepakati.
   - `Final` — hasil diskusi sudah disepakati.
   - `Batal` — diskusi dibatalkan.
2. `**Status Implementasi:**` **WAJIB** diisi sesuai kondisi aktual, mis. `Belum Diimplementasikan`, `Sedang Diimplementasikan`, atau `Sudah Diimplementasikan`. Jika belum diketahui atau belum relevan, tulis secara eksplisit (mis. `Belum diketahui`) dan **DILARANG** mengarang.
3. Perubahan status **WAJIB** disertai penyesuaian isi bagian yang relevan agar dokumen tetap konsisten.

## 7. Aturan Bagian yang Belum Dibahas

1. Bagian yang belum dibahas, belum diputuskan, atau belum tersedia datanya **WAJIB** diisi keterangan eksplisit, mis. `Belum dibahas` atau `Belum diketahui`.
2. **DILARANG** menebak, mengisi contoh fiktif, atau mengosongkan bagian tanpa keterangan.

## 8. Aturan Pencatatan di `MEMORI.md`

1. Setelah berkas hasil diskusi dibuat, diperbarui, atau dihapus, **WAJIB** perbarui `MEMORI.md` pada bagian yang relevan, sekurang-kurangnya:
   - `Lokasi Hasil Diskusi` — lokasi folder, daftar berkas, dan nomor tertinggi.
   - `Riwayat Diskusi` — topik, status PRD, dan tindak lanjut.
   - `Riwayat Perubahan` — ringkasan perubahan berkas.
2. **DILARANG** membiarkan `MEMORI.md` memuat nomor tertinggi atau daftar berkas yang sudah usang.

## 9. Larangan

- **DILARANG** membuat berkas hasil diskusi di luar `hasil_diskusi/`.
- **DILARANG** mengisi gap penomoran atau menimpa berkas yang sudah ada.
- **DILARANG** mengubah berkas hasil diskusi berstatus `Final` tanpa alasan yang disepakati pengguna.
- **DILARANG** mengubah kode sumber implementasi (`.dart` atau kode lain) sebagai bagian dari pembuatan berkas hasil diskusi; mode diskusi hanya menghasilkan dokumen.
- **DILARANG** menghapus bagian PRD yang diwajibkan `format_PRD.md`.
- **DILARANG** menggunakan bahasa selain Indonesia, kecuali mengutip istilah teknis atau konten asing yang relevan.

## 10. Contoh Kerangka Berkas

```markdown
# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Draft

**Status Implementasi:** Belum Diimplementasikan

---

## 1. <Judul bagian sesuai format_PRD.md>

**Konteks penggunaan:**
...

**Aturan pengisian:**

- ...

**Isi:**
...
```

## 11. Checklist Sebelum Menyelesaikan Berkas

- [ ] Berkas berada di `hasil_diskusi/diskusi_N.md` dengan nomor `tertinggi + 1`.
- [ ] Seluruh bagian PRD sesuai `format_PRD.md` versi terbaru tersedia.
- [ ] `Status Dokumen` dan `Status Implementasi` terisi dan konsisten dengan isi.
- [ ] Bagian yang belum dibahas diberi keterangan eksplisit.
- [ ] Bahasa Indonesia dan tidak ada informasi yang dikarang.
- [ ] `MEMORI.md` diperbarui pada bagian `Lokasi Hasil Diskusi`, `Riwayat Diskusi`, dan `Riwayat Perubahan`.