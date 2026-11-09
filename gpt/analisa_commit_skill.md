1. saya ingin chat gpt agar bisa menganalisa semua riwayat commit terbaru setelah riwayat terakhir yang dievaluasi, untuk mengetahui riwayat terakhir yang di evaluasi cukup lihat isi file [`catatan.md`](http://catatan.md) saja.
2. jika semisal isi [`catatan.md`](http://catatan.md) nya masih kosong gpt cukup ambil 5 commit terbaru saja dulu untuk data awal, baru setelah itu gunakan commit terakhir dievaluasi.
3. karena di `catatan,md` terdapat banyak catatan gpt cukup lihat commit terakhir yang berjudul `# Evaluasi Skill dari commit`.
4. jika ada commit baru saat sedang evaluasi abaikan commit baru itu, untuk tugas berikutnya saja.
5. jadi aturannya begini, gpt harus tentukan dulu commit awal hingga commit akhir yang akan dievaluasi.
6. tujuannya yaitu untuk menentukan dari riwayat commit itu code mana yang saya inginkan, lalu perbarui atau tambahkan skill custom agar skills ini bisa saya gunakan untuk proyek flutter saya yang lainnya juga.
7. karena code yang saya commit sudah pasti sesuai dengan paket dan sdk flutter. serta sudah pasti code yang di commit itu sudah saya analisa.
8. kalau sudah menemukan cukup perbarui skill yang ada di folder `.agents/skills/custom`
9. tapi harus baca dulu file `.agents/rules/global/aturan_skill.md` agar cara penulisan serta yang lainnya sesuai dengan yang saya inginkan.
10. setelah itu perbarui isi file [`catatan.md`](http://catatan.md) yang ada di root agar memperbarui terakhir commit apa yang dievaluasi, agar tugas selanjut nya tidak kehilangan arah.
11. Menentukan commit awal dan commit akhir yang akan dievaluasi.
12. Commit awal \= commit setelah hash tersebut.
13. Commit akhir \= HEAD saat tugas dimulai.
14. Tentukan HEAD di awal tugas dan catat hash-nya sebagai commit akhir.
15. jika ada dua commit yang merubah kode yang sama, jadikan commit terbaru sebagai sumber kebenaran.
16. Catat hash-nya sebagai commit akhir.
17. yang dicatat cuma commit terakhir saja jangan semua commit yang di evaluasi.
18. untuk file .md jangan semuanya di jadikan evaluasi.
19. Hanya folder skill custom dan catatan.md yang berubah.
20. harus gunakan branch chat gpt yang sudah saya buatkan
