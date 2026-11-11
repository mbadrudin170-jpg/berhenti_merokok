# Tujuan

Memindai seluruh file `SKILL.md` di `.agents/skills/**/` dan menulis indeks ke `SKILLS_INDEX.md` (root proyek) berdasarkan path skill, trigger, dan status diperbarui dari metadata.

# Alur Kerja

1. **Scan seluruh file SKILL.md.**
   - Temukan semua file `SKILL.md` di `.agents/skills/**/` (termasuk folder `bawaan` dan `custom`).
   - Baca front matter YAML setiap file untuk mendapatkan: `name`, `description`, `metadata.kategori`, `metadata.versi`, `metadata.diperbarui`, `metadata.sumber-terakhir`.

2. **Ekstrak trigger dari description.**
   - Identifikasi bagian "Kapan digunakan (trigger/use case)" dari `description`.
   - Tulis hanya trigger dalam bahasa Indonesia, tanpa mencampur cakupan/larangan/workflow.
   - Jika trigger tidak teridentifikasi, tulis penanda eksplisit: `perlu dilengkapi trigger`.

3. **Susun indeks per kategori.**
   - Kelompokkan entri berdasarkan `metadata.kategori` (mis. `custom`, `bawaan`).
   - Buat heading `## <folder>` untuk setiap kategori (mis. `## custom`, `## bawaan`).
   - Urutkan entri alfabetis berdasarkan path skill di dalam setiap kategori.

4. **Format entri indeks.**
   Setiap entri menggunakan format:
   ```
   1. <path skill>
   - Trigger : <isi trigger>
   - Status : diperbarui : <metadata.diperbarui>
   ```

5. **Tangani skill bawaan.**
   - Baca `installedAt` baris pertama dari `.config/dart_skills/skills_config.json`.
   - Konversi dari UTC ke Asia/Jakarta (`TZ=Asia/Jakarta date -d <timestamp>`).
   - Bandingkan dengan `metadata.diperbarui` di indeks; jika lebih baru, perbarui skill folder `bawaan` saja dan sinkronkan indeks.

6. **Tulis SKILLS_INDEX.md.**
   - Simpan di root proyek (`SKILLS_INDEX.md`).
   - Gunakan format waktu baku Asia/Jakarta untuk semua timestamp.

7. **Validasi.**
   - Pastikan `SKILLS_INDEX.md` hanya memuat trigger (bukan cakupan/larangan/workflow).
   - Pastikan `SKILL.md` tetap menjadi sumber kebenaran (wajib di-load sebelum mengerjakan tugas).

# Ketentuan Penulisan

1. **Bahasa:** Seluruh isi indeks wajib menggunakan bahasa Indonesia.
2. **Format waktu:** Wajib menggunakan output `TZ=Asia/Jakarta date` (contoh: `Wed Nov 11 2026 23:30:00 WIB`).
3. **Trigger:** Hanya ekstrak "kapan/untuk apa di-load", jangan salin seluruh `description`.
4. **Urutan:** Alfabetis per folder/kategori.

# Larangan

1. Dilarang mengubah file `SKILL.md` selama proses scan (hanya baca).
2. Dilarang mencantumkan cakupan, larangan, atau workflow di indeks — hanya trigger.
3. Dilarang mengarang trigger jika tidak ditemukan; wajib tulis `perlu dilengkapi trigger`.
4. Dilarang mengubah file lain di luar `SKILLS_INDEX.md`.

# Batasan Ruang Lingkup

1. Pekerjaan hanya mencakup pembuatan/memperbarui `SKILLS_INDEX.md` dari `SKILL.md` yang ada.
2. Tidak membuat, mengubah, atau menghapus file `SKILL.md`.
3. Jika `metadata.diperbarui` atau `metadata.sumber-terakhir` belum ada pada `SKILL.md`, catat di indeks dan lanjutkan; tidak menghentikan proses.

# Hasil Akhir

Setelah selesai:
1. `SKILLS_INDEX.md` di root proyek berisi indeks seluruh skill.
2. Setiap kategori memiliki heading sendiri (`## custom`, `## bawaan`, dll.).
3. Entri diurutkan alfabetis per kategori.
4. Format waktu menggunakan Asia/Jakarta.
5. Trigger diekstrak dengan benar dalam bahasa Indonesia.