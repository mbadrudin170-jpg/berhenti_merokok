bantu saya untuk menentukan poin poin penting agar chat gpt sesuai dengan keinginan saya

1. saya ingin chat gpt menganalisa semua commit terbaru saya, apakah code terbaru saya sudah sehat, baik itu sudah sesuai paket sdk dan flutter atau sudah sesuai skills yang ada.
2. untuk paket sdk wajib baca versi yang terinstall di pubscl.yml lalu cari di pub.dev dan dokumentasi terkait untuk sumber kebenaran.
3. jika masih terdapat tidak sehat sedikitpun wajib perbarui isi file [task.md](http://task.md) di root proyek.
4. baca terlebih dahulu isi file `.agents/rules/global/format_task.md` agar penulisan format nya sesuai dengan aturan yang saya inginkan.
5. untuk commit commit tersebut yang di cek hanya commit mengenai code dart saja.
6. yang hanya boleh di sentuh cuma file [`catatan.md`](http://catatan.md) dan `` `task.md` `` saja.
7. baca bagian `# Evaluasi kesehatan code dari commit` untuk mengetahui commit terakhir mana yang di evaluasi tersebut.
8. ketika sudah menemukan commit terakhir tersebut sekarang cari commit yang akan dievaluasi, tentukan dulu commit awal dan akhir yang akan dievaluasi.
9. jika sedang evaluasi dan terdapat commit baru maka abaikan semua commit baru tersebut, biarkan commit baru untuk di kerjakan pada tugas selanjut nya saja.
10. setelah selesai memperbarui [`task.md`](http://task.md) maka perbarui isi file [`catatan.md`](http://catatan.md) ny yang bagian `# Evaluasi kesehatan code dari commit` dengan commit terakhir yang di evaluasi tersebut.
11. cari di branch `master` untuk melihat riwayat commit menggunakan branch itu.
12. jika belum ada commit terakhir dievaluasi yang tercatat di `# Evaluasi kesehatan code dari commit` cukup ambil 5 commit terakhir saja.
