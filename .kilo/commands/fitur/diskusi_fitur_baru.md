---
agent: code
---

# Diskusi Fitur Baru dan Penyusunan PRD

Tugasmu: membuat PRD untuk satu fitur dari `referensi_apk.md`, lalu berdiskusi dengan saya sampai PRD itu final. Kamu hanya menulis dokumen. Kamu TIDAK menulis atau mengubah kode Dart.

## ATURAN KERAS (berlaku sepanjang proses)

1. DILARANG mengubah file `.dart`, `pubspec.yaml`, file konfigurasi, atau file kode apa pun.
2. Hanya boleh mengedit DUA hal:
   - satu file PRD di folder `prd/` di root proyek (buat baru atau perbarui), dan
   - penanda "sudah dibuatkan PRD" di `referensi_apk.md` (langkah 9).
     Tidak ada file lain.
3. Jangan menebak. Kalau ada hal yang tidak jelas, tanyakan lewat tool `question` (lihat bagian DISKUSI).
4. Contoh kode di PRD hanya potongan ilustrasi di dalam dokumen PRD, bukan perubahan pada file kode.
5. Semua keputusan PRD harus sesuai `docs/struktur_rules.md`.

## LANGKAH 1: Baca aturan proyek

Baca isi `docs/struktur_rules.md` sampai habis SEBELUM melakukan hal lain. Semua struktur folder, penamaan, dan konvensi di PRD harus mengikuti file itu. Jika ada bagian yang bertentangan dengan permintaan fitur, catat sebagai pertanyaan untuk saya.

## LANGKAH 2: Cari file referensi dan pilih satu fitur

1. Cari file `referensi_apk.md` (gunakan pencarian file bila lokasinya belum diketahui) dan baca seluruh isinya.
2. Daftar semua fitur di dalamnya, lalu pisahkan:
   - yang sudah ditandai "sudah dibuatkan PRD" (abaikan), dan
   - yang belum.
3. Pilih SATU fitur dari yang belum, dengan syarat di langkah 3.

## LANGKAH 3: Pastikan file terdampak tidak bentrok dengan PRD lain

Tujuannya agar fitur-fitur bisa dikerjakan paralel tanpa konflik file.

1. Lihat semua file di folder `prd/`. Dari tiap PRD, baca bagian "File Terdampak".
2. Untuk setiap fitur kandidat, perkirakan file apa saja yang akan terdampak (file baru dan file yang diubah).
3. Jika ada satu saja file terdampak yang sama dengan file terdampak di PRD lain, SKIP fitur itu dan coba fitur berikutnya.
4. Pilih fitur pertama yang SEMUA file terdampaknya tidak tumpang tindih dengan PRD mana pun.
5. Jika tidak ada fitur yang lolos, berhenti dan laporkan kepada saya: sebutkan tiap kandidat, file yang bentrok, dan PRD yang bentrok dengannya. Lalu gunakan tool `question` untuk menanyakan apakah saya mau memilih salah satu, atau menunggu PRD yang bentrok selesai diimplementasikan.
6. Sebutkan hasil seleksi ke saya dalam beberapa baris: fitur yang dipilih, alasan, dan fitur mana yang di-skip beserta alasannya.

## LANGKAH 4: Cek apakah fitur sudah diimplementasikan

Sebelum menulis PRD, periksa kode yang ada:

1. Cari di `lib/` (nama fitur, kata kunci, nama class atau provider yang mungkin dipakai) dan baca file yang relevan.
2. Simpulkan salah satu: BELUM ada, SEBAGIAN ada, atau SUDAH ada.
3. Jika SUDAH ada sepenuhnya, jangan buat PRD. Laporkan ke saya bukti file dan barisnya, lalu gunakan tool `question` untuk menanyakan apakah mau pindah ke fitur lain.
4. Jika SEBAGIAN, PRD hanya mencakup bagian yang belum ada. Tulis bagian yang sudah ada di bagian "Status Implementasi Saat Ini".

## LANGKAH 5: Pelajari gambaran fitur dari link aplikasi

1. Ambil link aplikasi untuk fitur itu dari `referensi_apk.md` lalu buka dan baca halamannya (gunakan tool pengambil halaman web bila tersedia).
2. Catat: alur layar, elemen UI, perilaku, dan data yang dipakai.
3. Jika link tidak bisa dibuka atau isinya tidak cukup, JANGAN mengarang. Tanyakan lewat tool `question` dan minta saya mendeskripsikannya.

## LANGKAH 6: Tentukan file terdampak

Daftar semua file yang akan dibuat atau diubah untuk fitur ini, dengan path lengkap dan jenis perubahan. Ikuti struktur di `docs/struktur_rules.md`. Daftar ini harus lengkap karena dipakai untuk mendeteksi bentrok antar PRD (langkah 3).

## LANGKAH 7: Tulis PRD LANGSUNG, lalu perbaiki sambil berdiskusi

Jangan menunggu semua pertanyaan terjawab. Segera buat file PRD berdasarkan informasi yang sudah ada, tandai bagian yang belum pasti dengan `[BELUM FINAL]`, lalu perbarui file yang sama setiap kali saya menjawab pertanyaan.

- Lokasi: `prd/<nama_fitur_snake_case>.md`. Jika file untuk fitur ini sudah ada, perbarui, jangan buat duplikat.
- Isi PRD wajib memakai struktur ini:

```
# PRD: <Nama Fitur>

Status: DRAFT | FINAL
Terakhir diperbarui: <tanggal>

## 1. Referensi
- Sumber: `referensi_apk.md` baris <nomor awal>-<nomor akhir>
- Link aplikasi referensi: <link>
- Ringkasan gambaran dari referensi: <hasil bacaan langkah 5>

## 2. Latar Belakang dan Tujuan
<mengapa fitur ini ada, masalah yang diselesaikan>

## 3. Status Implementasi Saat Ini
<BELUM / SEBAGIAN / SUDAH, sertakan file dan baris bukti>

## 4. Ruang Lingkup
### Termasuk
### Tidak Termasuk

## 5. User Story
<format: Sebagai <pengguna>, saya ingin <aksi>, agar <manfaat>>

## 6. Alur dan Perilaku
<langkah demi langkah per layar, termasuk kondisi kosong, loading, dan error>

## 7. Kebutuhan Data
<tabel Supabase atau data lokal, kolom, aturan akses>

## 8. File Terdampak
| Path | Jenis (baru/ubah) | Keterangan |
|---|---|---|

## 9. Contoh Implementasi (ilustrasi)
<beberapa potongan kode singkat, ditulis sesuai konvensi di docs/struktur_rules.md>

## 10. Kepatuhan terhadap docs/struktur_rules.md
<sebutkan aturan yang relevan dan bagaimana PRD ini memenuhinya>

## 11. Kriteria Selesai
<daftar centang yang bisa diuji>

## 12. Risiko dan Pertanyaan Terbuka
<hal yang masih [BELUM FINAL]>

## 13. Catatan Keputusan Diskusi
<tabel: pertanyaan | keputusan | tanggal>
```

- Setiap kutipan atau acuan ke `referensi_apk.md` harus menyertakan path dan nomor barisnya, contoh: `referensi_apk.md:L34-L41`.
- Bagian "Contoh Implementasi" berisi beberapa potongan singkat (bukan file utuh), cukup untuk memperlihatkan pendekatannya.

## DISKUSI: pakai tool `question`

Gunakan tool `question` untuk semua pertanyaan kepadaku. Jangan bertanya lewat teks biasa di akhir jawaban.

1. Ajukan pertanyaan bertahap, maksimal 3 pertanyaan per pemanggilan tool.
2. Untuk setiap pertanyaan, sediakan opsi jawaban yang jelas dan saling berbeda, dengan opsi rekomendasimu di urutan pertama beserta alasan singkat.
3. Prioritaskan pertanyaan yang paling mempengaruhi isi PRD lebih dulu: ruang lingkup, alur, data, lalu detail kecil.
4. Setelah aku menjawab: perbarui bagian terkait di file PRD saat itu juga, hapus penanda `[BELUM FINAL]` pada bagian yang sudah terjawab, dan catat di bagian 13 "Catatan Keputusan Diskusi".
5. Pertanyaan yang belum sempat ditanyakan dicatat di bagian 12 "Risiko dan Pertanyaan Terbuka" supaya tidak hilang.
6. Lanjutkan siklus tanya, jawab, perbarui PRD, sampai tidak ada lagi pertanyaan terbuka dan aku menyatakan PRD sudah final. Jangan mengakhiri sesi sebelum itu.

## LANGKAH 8: Finalisasi

Jika semua pertanyaan terbuka sudah terjawab, gunakan tool `question` untuk meminta konfirmasi akhir dariku. Jika aku setuju:

1. Ubah `Status` di PRD menjadi `FINAL`, hapus semua penanda `[BELUM FINAL]`.
2. Pastikan bagian "File Terdampak" sudah akhir dan sama sekali tidak ada tumpang tindih dengan PRD lain di `prd/`.

## LANGKAH 9: Tandai di referensi

Di `referensi_apk.md`, pada bagian fitur yang baru dibuatkan PRD, tambahkan penanda tepat di baris judul atau baris pertama bagian itu:

`✅ PRD dibuat: prd/<nama_fitur_snake_case>.md`

Jangan mengubah isi lain di file itu. Lakukan langkah ini saat PRD pertama kali dibuat (bukan menunggu final), dan sesuaikan jika nama file PRD berubah.

## LAPORAN AKHIR

Setiap kali selesai satu putaran, tampilkan:

- Fitur yang dipilih dan fitur yang di-skip (beserta alasan bentrok)
- Status implementasi saat ini (belum/sebagian/sudah)
- Path file PRD yang dibuat atau diubah
- Daftar file terdampak
- Pertanyaan yang masih terbuka
- Konfirmasi bahwa tidak ada file kode yang diubah
