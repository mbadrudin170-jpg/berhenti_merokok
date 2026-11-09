# Panduan Kerja Proyek (AGENTS.md)

Berikut adalah aturan wajib yang harus ditaati oleh semua pihak (termasuk AI agent) yang mengerjakan proyek ini.

## 1. Selalu Cari Skill Sebelum Mengerjakan

Ketika akan mengerjakan sesuatu, selalu cari skill yang sesuai terlebih dahulu di folder `.agents/skills/` — terutama di `.agents/skills/custom/`.

**Dilarang mengerjakan sesuatu tanpa panduan dari sebuah skill.** Setiap tugas harus didasarkan pada skill yang relevan sebelum kode diubah.

Bagian `.agents/skills/` (terutama `.agents/skills/custom/`) adalah kumpulan **rules dan petunjuk wajib** bagi setiap pihak yang mengerjakan proyek ini. Semua skill merupakan aturan yang harus dipatuhi, bukan saran opsional.

## 2. Dilarang Mengubah Kode Tanpa Panduan Skill

Jangan biarkan semua pihak mengubah kode di proyek tanpa panduan dari skills yang proyek punya. Sebelum mengubah kode apapun:

1. Cari skill yang sesuai dengan topik tugas di `.agents/skills/custom/`.
2. Baca dan pahami seluruh isi skill tersebut (Aturan, Larangan, Contoh Benar, Contoh Salah).
3. Ikuti langkah kerja (workflow) yang disebutkan di skill.
4. Setelah selesai, verifikasi kembali bahwa implementasi tidak melanggar Larangan pada skill tersebut.

Jika tidak ada skill yang relevan dengan tugas yang akan dikerjakan, **berhenti dan tanyakan kepada pengguna** sebelum melanjutkan. Jangan buat asumsi sendiri.

## 3. Dilarang Berasumsi Liar

Gunakan **skill** dan **SDK** (Flutter, Dart, dan paket yang terpasang di `pubspec.yaml`) sebagai bahan panduan bekerja. Dilarang berasumsi liar tentang perilaku API, struktur folder, atau pola kode yang tidak didasarkan pada skill yang ada atau dokumentasi SDK resmi.

## 4. Skill sebagai Sumber Kebenaran

Setiap skill di `.agents/skills/custom/` adalah aturan operasional proyek. Jika terdapat pertentangan antara asumsi umum dengan isi skill, **skill merupakan yang benar** dan harus diikuti.

Semua skill wajib mengikuti format yang didefinisikan di `.agents/rules/global/aturan_skill.md` (front matter YAML, Judul/Intro, Cakupan yang Di-Cover, Aturan, Larangan, Contoh Benar, Contoh Salah, Sumber Evaluasi).
