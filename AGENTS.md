1. ketika mengerjakan sesuatu selalu cari skill yang sesuai, dilarang mengerjakan sesuatu tanpa panduan dari sebuah skill atau rules,
2. baca atau load juga bagian `.agents/skills` terutama bagian `.agents/skills/custom` dan `.agents/skills/bawaan` karena bagian skills itu adalah sebuah rules dan petunjuk yang harus ditaati oleh semua pihak yang mengerjakan proyek saya ini.
3. jangan biarkan semua pihak mengubah kode di proyek tanpa panduan dari skills atau rules yang proyek punya .
4. dilarang berasumsi liar gunakan skill atau aturan dan sdk sebagai bahan panduan bekerja.
5. file dan folder yang harus dibaca terlebih dahulu :

- `.agents/rules/global`
- `.agents/skills/bawaan`
- `.agents/skills/custom`
- `MEMORI.md` (root proyek — **wajib dibaca SEBELUM setiap interaksi apa pun di proyek ini** (task, pertanyaan, diskusi, review, penelusuran) dan diperbarui SESUDAH interaksi yang mengubah proyek; lihat skill `memori-check` di `.agents/skills/custom/memori-check/SKILL.md`)
- `SKILLS_INDEX.md` (indeks bantu discovery skill berdasarkan trigger; `SKILL.md` tetap sumber kebenaran dan wajib di-load sebelum mengerjakan tugas)

6. bahasa Indonesia wajib digunakan dalam semua interaksi dengan pengguna, sesuai dengan aturan penggunaan sistem yang tercantum dalam `aturan_pembuatan_skill.md` dan `format_PRD.md`
7. jangan mengubah kode di proyek tanpa mengikuti semua skill dan rules yang relevan, terutama rules tentang format dan struktur file
8. ketika menambahkan konten baru ke file manapun, pastikan untuk mengikuti aturan format yang ditetapkan dalam rules yang relevan, terutama rules tentang SKILL.md dan PRD format
9. jangan menggunakan bahasa selain Indonesia dalam dokumentasi, komentar, atau interaksi pengguna, kecuali ketika secara eksplisit diperlukan untuk mengutip konten asing atau merujuk ke teknis yang spesifik
10. kapan pun berinteraksi dengan proyek ini dalam bentuk apa pun (task, pertanyaan, diskusi, review, penelusuran), wajib baca `MEMORI.md` di root proyek terlebih dahulu; setiap kali selesai mengerjakan task atau interaksi yang mengubah proyek, selalu perbarui isi file `MEMORI.md` agar konteks proyek tetap konsisten, antara lain update bagian `Status Proyek` (versi/state), `Provider/Riverpod Key`, `Enum Utama`, `File Konfigurasi & Penting`, `Skills & Rules Utama yang Diaktifkan`, `Aturan yang Harus Dipelihara`, `Catatan Teknis Penting`, dan `Catatan untuk Model Selanjutnya`; baca dan patuhi skill `memori-check` (`.agents/skills/custom/memori-check/SKILL.md`) sebelum mulai dan sesudah selesai interaksi
11. wajib baca konfigurasi global Kilo `~/.config/kilo/kilo.jsonc` (terutama bagian `permission`) sebelum menjalankan perintah `bash` atau mengambil tindakan lain, agar tahu izin apa saja yang ditolak (`deny`) dan aturan `ask`/`allow` yang berlaku; izin `deny` bersifat mutlak dan DILARANG dilewati, diakali, atau dieksekusi lewat perintah lain (misalnya saat ini `bash`: `cat *`, `sed *`, `python3 *`; `read`: `*.env`, `*.env.*`); file `kilo.jsonc` tersebut adalah sumber kebenaran dan bisa berubah sewaktu-waktu, jadi baca ulang isinya setiap interaksi dan jangan mengandalkan daftar di aturan ini saja; sumber izin adalah konfigurasi global, bukan `kilo.json` proyek
