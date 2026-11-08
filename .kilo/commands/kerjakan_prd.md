---
agent: code
---

# Kerjakan PRD

Tugasmu: mengimplementasikan SATU PRD yang saya tentukan, sesuai isinya, lalu membersihkan PRD itu dan entri terkaitnya di `referensi_apk.md` setelah selesai.

PRD yang dikerjakan: $ARGUMENTS

Jika bagian di atas kosong atau tidak menunjuk file PRD yang jelas, BERHENTI. Tampilkan daftar isi folder `prd/` dan tanyakan PRD mana yang harus dikerjakan. Jangan memilih sendiri.

## ATURAN KERAS (berlaku sepanjang proses)

1. Kerjakan HANYA PRD yang disebut di atas. Jangan menyentuh, membaca-untuk-dikerjakan, atau menghapus PRD lain.
2. Ubah HANYA file yang tercantum di bagian "File Terdampak" PRD tersebut. Jika ternyata butuh mengubah file di luar daftar itu, BERHENTI dan tanyakan dulu, jelaskan file apa dan alasannya.
3. Jangan menambah fitur, refactor, atau perbaikan di luar isi PRD, sekecil apa pun.
4. Jangan menebak. Jika isi PRD ambigu atau bertentangan dengan `docs/struktur_rules.md`, tanyakan dulu sebelum menulis kode.
5. Jangan pernah menghapus apa pun sebelum implementasi selesai DAN `flutter analyze` bersih (lihat LANGKAH 6).
6. Jangan menaruh kunci rahasia (Supabase, LiveKit, dll.) di kode atau output. Gunakan konfigurasi yang sudah dipakai proyek.

## LANGKAH 1: Baca aturan proyek (WAJIB PERTAMA)

Baca SELURUH isi `docs/struktur_rules.md` dari baris pertama sampai terakhir SEBELUM melakukan hal lain, termasuk sebelum membaca PRD. Semua struktur folder, penamaan, state management, dan konvensi kode yang kamu tulis nanti harus mengikuti file itu. Jangan melanjutkan sebelum selesai membacanya.

## LANGKAH 2: Baca dan pahami PRD

1. Baca seluruh file PRD yang ditunjuk.
2. Catat: tujuan, ruang lingkup (termasuk dan tidak termasuk), alur dan perilaku, kebutuhan data, daftar "File Terdampak", contoh implementasi, dan "Kriteria Selesai".
3. Jika Status PRD bukan `FINAL` atau masih ada penanda `[BELUM FINAL]`, BERHENTI dan laporkan ke saya, tanyakan apakah tetap dilanjutkan.
4. Catat nomor baris di `referensi_apk.md` yang diacu PRD (bagian "Referensi") untuk dipakai di LANGKAH 7.

## LANGKAH 3: Periksa kondisi kode saat ini

1. Baca semua file di "File Terdampak" yang sudah ada, dan cari di `lib/` apakah sebagian fitur sudah ada.
2. Jika kode sebenarnya sudah berbeda dari yang diasumsikan PRD (nama class berubah, file sudah dipindah, dst.), jelaskan perbedaannya ke saya sebelum lanjut.

## LANGKAH 4: Rencanakan dengan `todowrite`

Gunakan tool `todowrite` untuk membuat daftar tugas yang dipecah per file atau per bagian dari PRD, ditambah item terpisah untuk: `flutter analyze`, perbaikan error, penghapusan PRD, dan pembersihan `referensi_apk.md`. Tandai item `in_progress` saat dikerjakan dan `completed` begitu selesai. Satu item `in_progress` pada satu waktu.

## LANGKAH 5: Implementasikan

1. Kerjakan sesuai daftar tugas, satu file demi satu, mengikuti PRD dan `docs/struktur_rules.md`.
2. Contoh kode di PRD adalah ilustrasi. Sesuaikan dengan konvensi dan API yang sebenarnya dipakai proyek.
3. Untuk SDK atau paket pihak ketiga (LiveKit, Supabase, Riverpod, dll.): jika perlu membaca source-nya dan tidak bisa dibaca langsung, baca repo git paket tersebut, dan WAJIB versi yang sama dengan yang terpasang di `pubspec.lock`. Jangan memakai API dari versi lain.
4. Jangan mengubah `pubspec.yaml` kecuali PRD secara eksplisit mencantumkannya di "File Terdampak". Jika perlu menambah dependency yang tidak ada di PRD, berhenti dan tanyakan.

## LANGKAH 6: Verifikasi (gerbang sebelum penghapusan)

1. Jalankan `flutter analyze` dan baca hasilnya sampai habis.
2. Jika ada error atau warning pada file yang kamu ubah, perbaiki, lalu jalankan ulang sampai bersih. Perbaikan hanya boleh di file "File Terdampak".
3. Jika masalah berasal dari file di luar "File Terdampak" (sudah ada sebelumnya), jangan diperbaiki. Catat di laporan.
4. Cocokkan hasil kerja dengan "Kriteria Selesai" di PRD, satu per satu. Jika ada yang belum terpenuhi, kerjakan dulu. Jika tidak bisa diuji dari terminal (misalnya butuh device), tandai sebagai "perlu diuji manual" di laporan.
5. Jika setelah beberapa kali percobaan masih ada error yang tidak bisa kamu selesaikan, BERHENTI. Jangan menghapus apa pun, dan laporkan error mentahnya apa adanya.

## LANGKAH 7: Hapus PRD dan entri referensinya

Lakukan HANYA jika LANGKAH 6 lolos sepenuhnya.

1. **Bersihkan `referensi_apk.md`**:
   - Buka `referensi_apk.md`. Nomor baris mungkin sudah bergeser, jadi cari bagian yang tepat lewat penanda `✅ PRD dibuat: prd/<nama_file_prd>.md` dan cocokkan dengan nomor baris yang tercatat di PRD.
   - Baca bagian itu dan pastikan memang itu fitur dari PRD ini.
   - Hapus HANYA bagian milik fitur ini: judul, isi, dan penandanya. Jangan menghapus bagian fitur lain, dan jangan mengubah format sisa file.
   - Baca ulang file untuk memastikan sisa isinya utuh dan rapi (tidak ada baris kosong berlebih atau potongan bagian yang tertinggal).
2. **Hapus file PRD** yang baru dikerjakan, dan hanya file itu.
3. Jika tidak yakin bagian mana di `referensi_apk.md` yang berkaitan, jangan menghapus apa pun. Tanyakan dulu.

## LAPORAN AKHIR

Tampilkan:
- PRD yang dikerjakan
- Daftar file yang dibuat dan diubah (path lengkap)
- Output mentah `flutter analyze` terakhir
- Status tiap "Kriteria Selesai": terpenuhi atau perlu diuji manual
- Konfirmasi bagian `referensi_apk.md` yang dihapus (sebutkan judulnya) dan PRD yang dihapus
- Masalah di luar lingkup yang kamu temukan tapi sengaja tidak diubah