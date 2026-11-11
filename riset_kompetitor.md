# Riset Kompetitor Aplikasi Berhenti Merokok

Dokumen ini menjabarkan proses riset kompetitor aplikasi berhenti merokok untuk analisis fitur, positioning, dan celah pasar. Hasil riset tercatat di `apk_kompetitor.md` (katalog) dan `refrensi_apk.md` (laporan referensi mendalam).

## File Terkait

| File | Deskripsi |
|------|-----------|
| `apk_kompetitor.md` | Katalog daftar aplikasi kompetitor per store dengan kolom `Status Analisa` per baris (`Belum Dianalisa` / `Sudah Dianalisa`) |
| `refrensi_apk.md` | Laporan referensi mendalam dari seluruh APK di `apk_kompetitor.md` |
| `.agents/skills/custom/riset-kompetitor/SKILL.md` | Skill panduan riset kompetitor |
| `.kilo/commands/riset_kompetitor.md` | Perintah analisis fitur dari seluruh APK terdaftar |
| `.kilo/commands/cari_apk_kompetitor.md` | Perintah menambah listing aplikasi baru |

## Cakupan Riset

- **Store yang didukung:** Google Play Store, Apple App Store, F-Droid, GitHub, Samsung Galaxy Store, Uptodown, IzzyOnDroid, Amazon Appstore, APKPure, Aptoide, SlideME, Tencent MyApp, Huawei AppGallery
- **Kategori relevansi:** pelacakan progres, penghematan uang, milestone kesehatan, mode tapering, diary craving, SOS craving, lencana/badge, widget, komunitas, CBT/AI coach, offline-first, backup/restore, gamifikasi
- **Lingkup analisa:** hanya APK yang terdaftar di `apk_kompetitor.md` dan berstatus `Belum Dianalisa` (kolom `Status Analisa`); listing `Sudah Dianalisa` tidak dianalisa ulang kecuali diminta eksplisit

## Kolom Tabel (`apk_kompetitor.md`)

1. `Nama Aplikasi`
2. `Ringkasan Singkat` (maks 2-3 kalimat)
3. `Store`
4. `Link` (valid, terverifikasi)
5. `Status Analisa` (`Belum Dianalisa` / `Sudah Dianalisa`)

## Aturan Utama

1. Setiap aplikasi **wajib** memiliki nama, ringkasan singkat, nama store, link valid, dan kolom `Status Analisa`.
2. Link harus dapat diverifikasi (curl HTTP 200, iTunes lookup untuk Apple App Store).
3. Listing baru dari `cari_apk_kompetitor.md` wajib ditandai `Belum Dianalisa`.
4. Hanya perintah `riset_kompetitor.md` yang boleh mengubah status menjadi `Sudah Dianalisa`, setelah riset selesai per APK.
5. Dilarang membuat section `# Status Analisa Fitur` di akhir file `apk_kompetitor.md`.
6. Dilarang menandai listing baru sebagai `Sudah Dianalisa` tanpa menjalankan riset terlebih dahulu.
7. Tabel harus menggunakan format pipe Markdown.
8. Ringkasan singkat maksimal 2-3 kalimat.

## Struktur `refrensi_apk.md`

1. Informasi riset + cara membaca
2. Ringkasan temuan terbesar
3. Kondisi fitur aktual proyek
4. A. Rekomendasi fitur baru
5. B. Optimasi fitur eksisting
6. C. UI/UX & Layout
7. D. Katalog semua listing
8. E. Prioritas gabungan
9. F. Verifikasi & keterbatasan
10. G. Sumber

## Workflow Riset

1. Baca `README.md`, `AGENTS.md`, `apk_kompetitor.md` terlebih dahulu.
2. Baca skill `.agents/skills/custom/riset-kompetitor/SKILL.md`.
3. Identifikasi APK dengan status `Belum Dianalisa` di `apk_kompetitor.md`.
4. Kumpulkan referensi fitur/UI/UX dari setiap APK yang belum dianalisa.
5. Perbarui `refrensi_apk.md` dengan temuan baru, dilengkapi link referensi.
6. Ubah status APK di `apk_kompetitor.md` menjadi `Sudah Dianalisa` setelah riset selesai per baris.