---
description: Menindaklanjuti hasil diskusi (hasil_diskusi/diskusi_N.md) menjadi rencana kerja terstruktur di task.md atau rekomendasi PRD.
---

1. **Input**: pengguna wajib menentukan file sumber `hasil_diskusi/diskusi_N.md` yang akan ditindaklanjuti (nomor/path). Jika belum ditentukan, minta pengguna memilih file diskusi terlebih dahulu.
2. **Baca konteks wajib terlebih dahulu**:
   - `AGENTS.md` (root) dan patuhi aturannya.
   - Setelah itu, baca file diskusi sumber yang ditunjuk pengguna dan periksa `## Status` beserta isi relevannya.
3. **Validasi status diskusi**:
   - Jika file diskusi berstatus `Draft`, **jangan dikerjakan walaupun ditunjuk oleh pengguna**. Hentikan proses, sampaikan bahwa diskusi masih `Draft`, dan minta pengguna mengubah status menjadi `Final` terlebih dahulu (atau `Batal` jika tidak dilanjutkan).
   - Hanya file diskusi berstatus `Final` yang boleh ditindaklanjuti. Jika status bukan `Final`/tidak valid, hentikan dan minta klarifikasi.
4. **Baca konteks pendukung** (setelah status valid): baca aturan format yang relevan (`.agents/rules/global/format_hasil_diskusi.md`, serta `.agents/rules/global/format_task.md` dan `.agents/rules/global/format_PRD.md` bila diperlukan) agar hasil sesuai aturan proyek.
5. **Fokus topik**: proses hanya tindak lanjut yang berkaitan langsung dengan diskusi sumber; jangan menambah pekerjaan di luar keputusan/topik diskusi.
6. **Analisis dan petakan tindak lanjut**:
   - Identifikasi item tindakan yang konkret dari `## Keputusan` dan `## Tindak Lanjut`.
   - Tentukan bentuk keluaran per item:
     - **task.md**: untuk pekerjaan implementasi/perbaikan yang terpetakan ke file terdampak dan langkah teknis.
     - **PRD**: jika cakupan adalah fitur/produk besar yang butuh spesifikasi sesuai `format_PRD.md` (sarankan pembuatan/pembaruan PRD, jangan langsung menulis PRD tanpa konfirmasi).
     - **Tidak dapat dieksekusi**: jika butuh informasi/keputusan tambahan, catat sebagai pertanyaan/klarifikasi.
7. **Susun draf usulan terstruktur** (belum ditulis ke berkas target, kecuali disetujui):
   - Untuk `task.md`, susun draf mengikuti `format_task.md` secara ketat: `# Kelompok N`, `## file terdampak`, prioritas (`## Tinggi`/`## Rendah`/sesuai konteks), dan setiap task berisi `Status`, `Masalah`, `Solusi`, `aturan dilanggar`, `file bermasalah`, `prompt`.
   - Set `Status` task baru sebagai `kerjakan` hanya bila siap dieksekusi; sertakan referensi aturan/file bermasalah bila relevan.
   - Kelompokkan berdasarkan himpunan file terdampak yang sama (sesuai aturan `format_task.md`).
8. **Konfirmasi sebelum menulis**: tampilkan ringkasan draf (item task/kelompok atau rekomendasi PRD) dan minta konfirmasi pengguna mengenai:
   - file target yang akan diubah/dibuat (`task.md`, dan/atau rujukan PRD),
   - isi draf yang disetujui.
   - Jangan mengubah berkas apa pun sebelum ada konfirmasi eksplisit.
9. **Tulis hasil yang disetujui**:
   - Perbarui/buat entri di `task.md` sesuai draf yang disetujui dan `format_task.md` (jangan menghapus atau mengubah task lain tanpa alasan yang disepakati).
   - Jika disepakati membuat/memperbarui PRD, ikuti `format_PRD.md` dan batasi perubahan pada file PRD yang relevan.
   - **Dilarang** mengubah kode sumber implementasi (`.dart` atau file kode lain) dalam command ini; command ini hanya menghasilkan rencana kerja terstruktur.
10. **Kriteria selesai**:
    - Sumber diskusi terbaca, status tervalidasi `Final`, dan tindak lanjutnya terpetakan.
    - Draf/usulan ditampilkan dan status konfirmasi jelas.
    - Jika disetujui, `task.md`/PRD yang relevan diperbarui sesuai format dan siap ditindaklanjuti oleh `kerjakan_task.md` atau alur PRD.
11. **Bahasa**: selalu gunakan bahasa Indonesia saat berinteraksi dengan pengguna.
