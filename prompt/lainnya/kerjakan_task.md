# Kerjakan Task — STRICT EXECUTION

Jalankan task dari `task.md` dengan mengikuti `AGENTS.md` dan aturan proyek. **Batas eksekusi paling penting: hanya task dengan status `Kerjakan` yang boleh dikerjakan. Jangan pernah mengerjakan task berstatus lain.**

## Aturan wajib

1. **Baca `AGENTS.md` di root terlebih dahulu**, lalu baca aturan dan skill proyek yang relevan sebelum mengubah kode. Patuhi semuanya.
2. **GERBANG STATUS — WAJIB DIPATUHI:** eksekusi hanya task yang nilai statusnya tepat `Kerjakan` (kapitalisasi boleh berbeda). Status harus cocok sebagai nilai penuh setelah `Status:`; kata `kerjakan` di dalam frasa seperti `Belum dikerjakan` tidak membuat task boleh dieksekusi. Status `Selesai`, `Dilewati`, `Belum dikerjakan`, `Sedang`, kosong, atau nilai lain berarti **DILARANG DIKERJAKAN**. Jangan mengubah status atau isi task tersebut; cukup laporkan kepada pengguna.
3. **Urutan kelompok:** proses kelompok sesuai urutan kemunculannya di `task.md`. Selesaikan seluruh task berstatus `Kerjakan` dalam kelompok aktif sebelum pindah ke kelompok berikutnya. Di dalam kelompok, ikuti urutan task pada file. Jangan melompati task `Kerjakan` untuk mengerjakan kelompok lain.
4. Sebelum mengerjakan task, periksa apakah seluruh file sumber yang akan disentuh sedang terbuka di editor. Jika ada yang terbuka, **jangan edit file tersebut**; ubah status task menjadi `Dilewati` dan tulis alasan yang jelas. `task.md` tidak termasuk pemeriksaan ini karena memang perlu diperbarui.
5. **Backup wajib sebelum setiap pengeditan file yang sudah ada**, termasuk `task.md`. Simpan salinan asli di folder root `.backup task/`, pertahankan struktur path file, lalu tambahkan ekstensi `.bak` (contoh: `.backup task/lib/app.dart.bak`). Jangan menimpa backup lama; gunakan nama unik jika diperlukan. Jika backup gagal dibuat, jangan edit file tersebut.
6. Kerjakan satu task pada satu waktu dan batasi perubahan pada solusi task itu. Jika implementasi ternyata sudah benar-benar ada, jangan mengubah kode; tandai task `Selesai`.
7. Setelah satu task memiliki hasil, **segera edit `task.md` sebelum memulai task berikutnya**:
   - Berhasil diselesaikan atau ternyata sudah dikerjakan: `Status: Selesai`.
   - Tidak dikerjakan karena file terbuka atau kendala yang tidak dapat diselesaikan: `Status: Dilewati`, disertai `Alasan dilewati: ...` yang spesifik.
   Backup `task.md` terlebih dahulu setiap kali akan mengeditnya.
8. Setiap perubahan kode wajib disertai komentar singkat dan deskriptif di dekat perubahan yang menjelaskan **alasan teknis perubahan**. Jangan membuat komentar panjang atau sekadar mengulang isi kode.
9. Jalankan `flutter analyze` sebagai pemeriksaan awal, setelah setiap task, dan sekali lagi di akhir. Periksa hasilnya, bukan sekadar menjalankan perintah. Target akhir adalah `No issues found!` tanpa error maupun lint.
10. Jika perubahan pada task menyebabkan error/lint dan masalah tersebut tetap tidak dapat diselesaikan setelah upaya perbaikan yang wajar, **hentikan task itu**. Rollback seluruh file `.dart` yang diubah oleh task tersebut ke kondisi sebelum task menggunakan backup yang sesuai, jalankan kembali `flutter analyze`, lalu tandai task `Dilewati` beserta alasan dan diagnostic yang tersisa. Jangan mempertahankan perubahan parsial yang bermasalah.
11. Jangan memperbaiki temuan lain yang tidak berasal dari task berstatus `Kerjakan`, termasuk temuan yang muncul dari `flutter analyze`. Catat sebagai temuan awal/tidak terkait dan laporkan; jangan memperluas ruang lingkup tanpa persetujuan pengguna.

## Larangan mutlak

- Jangan mengerjakan task dengan status selain `Kerjakan`, apa pun tingkat prioritas, kelompok, atau tingkat kemudahannya.
- Jangan menganggap `Belum dikerjakan`, status kosong, atau status lain sebagai izin untuk mulai bekerja.
- Jangan mengubah status task non-`Kerjakan` hanya agar task tersebut bisa dikerjakan.
- Jangan pindah kelompok sebelum seluruh task `Kerjakan` pada kelompok aktif sudah berstatus akhir `Selesai` atau `Dilewati`.
- Jangan mengedit file tanpa backup terlebih dahulu.

**Jika tidak ada task berstatus tepat `Kerjakan`, jangan mengubah kode atau task apa pun. Berhenti dan laporkan bahwa tidak ada task yang memenuhi syarat.**

## Laporan akhir

Laporkan jumlah dan daftar task `Selesai` serta `Dilewati` beserta alasan setiap task yang dilewati. Laporkan juga task yang tidak dikerjakan karena statusnya bukan `Kerjakan`, hasil akhir `flutter analyze` (termasuk temuan awal yang tidak terkait bila ada), dan lokasi backup. Jangan menyatakan analisis bersih jika output sebenarnya masih berisi diagnostic.
