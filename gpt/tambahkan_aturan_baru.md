1. saya perintahkan gpt untuk menganalisa perubahan terbaru pada commit.
2. cek semua commit setelah `evaluasi_aturan_khusus` yang ada di file `catatan.md` di root.
3. identifikasi dari semua perubahan tersebut manakan yang bisa di tambahkan ke file `.agents/rules/global/aturan_bersama.md` dan `.agents/rules/proyek/aturan_khusus.md`.
4. untuk file `.agents/rules/proyek/aturan_bersama.md` cukup ambil refrensi dari semua perubahan yang ada di commit tersebut.
5. karena aturan bersama tidak semua proyek sama dengan proyek yang di analisa ini.
6. setelah menganalisa buatkan instruksi prompt untuk AI kilo code agar memperbarui kedua file aturan tersebut.
7. kedua file tersebut isinya jangan di hapus cukup di perbarui atau di tambahkan saja karena aturan lama mungkin bisa berguna di masa mendatang.
8. disini gpt cukup membuat prompt/instruksi untuk memperbarui kedua file tersebut. jadi AI kilo code tidak perlu analisa ulang untuk menghemat waktu.
9. didalam instruksi tersebut suruh AI kilo code untuk memperbarui file `catatan.md` nya juga.