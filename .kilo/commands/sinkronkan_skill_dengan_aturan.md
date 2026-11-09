# Command: sinkronkan_skill_dengan_aturan

## Tujuan

Membaca aturan bersama dan aturan khusus proyek, lalu memperbarui skill yang sudah ada atau menambahkan skill baru di folder `.agents/skills/custom` agar skill selalu sesuai dengan aturan terbaru.

## Langkah 0 — Baca aturan pembuatan skill (WAJIB, SEBELUM APA PUN)

Baca seluruh isi file berikut sampai habis, tanpa dilewati:

- `.agents/rules/global/aturan_skill.md`

Ikuti semua ketentuan di file itu (format, penamaan, struktur, gaya penulisan skill) pada setiap langkah berikutnya. Jangan membuat atau mengubah skill apa pun sebelum langkah ini selesai.

## Langkah 1 — Baca semua aturan

Baca seluruh isi kedua file berikut sampai habis:

- `.agents/rules/global/aturan_bersama.md`
- `.agents/rules/proyek/aturan_khusus.md`

Jangan hanya membaca sebagian atau meringkas dari judulnya saja.

## Langkah 2 — Baca skill yang sudah ada

Lihat seluruh isi folder `.agents/skills/custom` dan baca setiap file skill yang ada di dalamnya. Catat skill apa saja yang sudah ada dan apa cakupan masing-masing.

## Langkah 3 — Amati dan bandingkan

Bandingkan isi aturan (Langkah 1) dengan skill yang sudah ada (Langkah 2). Tentukan:

1. Aturan mana yang sudah tercakup dengan benar oleh skill yang ada.
2. Skill mana yang isinya sudah usang, kurang lengkap, atau bertentangan dengan aturan terbaru, sehingga perlu diperbarui.
3. Aturan atau pola kerja mana yang belum punya skill sama sekali, sehingga perlu skill baru.
4. Skill mana yang duplikat atau tumpang tindih, jika ada.

Tampilkan hasil pengamatan ini dalam bentuk daftar singkat sebelum mengedit apa pun.

## Langkah 4 — Perbarui atau tambah skill

Setelah pengamatan selesai:

1. Skill yang perlu diperbarui: edit file skill tersebut di tempat, jangan buat file baru yang menggandakannya. Pertahankan bagian yang masih benar.
2. Skill baru: buat file baru di `.agents/skills/custom` sesuai format dan penamaan di `aturan_skill.md`.
3. Jangan mengubah file aturan di `.agents/rules/`. File aturan hanya dibaca, bukan diedit.
4. Jangan menghapus skill apa pun tanpa konfirmasi dariku.
5. Jangan menulis isi skill yang bertentangan dengan `aturan_bersama.md`, `aturan_khusus.md`, atau `aturan_skill.md`.

## Langkah 5 — Verifikasi

Setelah semua perubahan selesai:

1. Buka kembali setiap skill yang diubah atau dibuat, lalu pastikan formatnya sesuai `aturan_skill.md`.
2. Pastikan tidak ada skill yang saling bertentangan.

## Laporan akhir

Tampilkan ringkasan dalam format berikut:

- **Skill diperbarui:** nama file + apa yang berubah (satu baris per file)
- **Skill baru:** nama file + tujuan skill (satu baris per file)
- **Tidak berubah:** skill yang sudah sesuai
- **Catatan:** aturan yang ambigu, bertentangan, atau butuh keputusanku (jika ada)
