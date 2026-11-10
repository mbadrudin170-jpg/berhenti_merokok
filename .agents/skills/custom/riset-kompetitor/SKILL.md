---
name: riset-kompetitor
description: Panduan melakukan riset kompetitor aplikasi berhenti merokok - mencatat daftar aplikasi serupa di berbagai store (Google Play, Apple App Store, F-Droid, GitHub), menyertakan ringkasan fitur relevan, link store/repositori, dan mengikuti format tabel yang terstandarisasi untuk perbandingan fitur, platform, dan relevansi terhadap proyek.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "a6f3020"
  model: "kilo-auto/free"
---

# Riset Kompetitor Aplikasi Berhenti Merokok

Mengumpulkan dan mendokumentasikan daftar aplikasi kompetitor (serupa) untuk analisis fitur, positioning, dan celah pasar. Hasil riset disimpan dalam format tabel standar di `apk_serupa.md` untuk referensi tim dan stakeholder.

## Cakupan yang Di-Cover

- Package: `tidak ada` (dokumentasi non-kode)
- File: `apk_serupa.md` (root proyek)
- Kolom tabel: `Nama Aplikasi`, `Ringkasan Singkat`, `Store`, `Link`
- Store yang didukung: Google Play Store, Apple App Store, F-Droid, GitHub, Samsung Galaxy Store, Uptodown, IzzyOnDroid
- Kategori relevansi: pelacakan progres, penghematan uang, milestone kesehatan, mode tapering, diary craving, SOS craving, lencana/badge, widget, komunitas, CBT/AI coach, offline-first, backup/restore, gamifikasi

## Aturan

1. Setiap aplikasi **wajib** memiliki nama, ringkasan singkat (maks 2-3 kalimat), nama store/sumber, dan link yang valid.
2. Ringkasan singkat **wajib** menyebutkan fitur-fitur utama yang relevan dengan proyek ini (smoke-free tracking, savings, milestones, tapering, craving diary, badges, widgets, community, CBT, offline-first, dll).
3. Format tabel **wajib** mengikuti standar Markdown pipe (`| Kolom 1 | Kolom 2 | ... |`) dengan header dan separator baris kedua (`| --- | --- | ... |`).
4. Aplikasi dari store yang sama **dikelompokkan** secara berurutan (Google Play → Apple App Store → F-Droid → GitHub → Lainnya).
5. Duplikat nama aplikasi di store berbeda **diperbolehkan** (mis. Kwit di Play Store dan App Store) dengan baris terpisah.
6. Link **wajib** mengarah ke halaman resmi store/repositori (bukan pencarian umum), gunakan format `[Buka Aplikasi](url)`, `[Buka Repositori](url)`, `[Unduh APK](url)`, atau `[Cari Aplikasi](url)` sesuai jenis store.
7. Setiap penambahan/perubahan **wajib** di-commit dengan pesan `docs: ...` dan referensi ke skill ini.
8. **Wajib** verifikasi link masih aktif sebelum commit (cek manual atau otomatis).

## Larangan

- DILARANG menambah aplikasi tanpa ringkasan fitur relevan (hanya nama dan link).
- DILARANG menggunakan format tabel non-standar (mis. daftar bullet, JSON, CSV).
- DILARANG mengubah urutan kolom tabel yang sudah ditetapkan.
- DILARANG menghapus aplikasi yang sudah tercatat kecuali aplikasi benar-benar tidak lagi tersedia/tersedia di store resmi.
- DILARANG menyalin ringkasan dari deskripsi store tanpa disesuaikan dengan konteks proyek ini.
- DILARANG menambah kolom baru tanpa memperbarui skill ini dan seluruh baris tabel.

## Contoh Benar

```markdown
| Nama Aplikasi | Ringkasan Singkat                                                                                                                                                                                 | Store             | Link                                                                                  |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- | ------------------------------------------------------------------------------------- |
| SmokeStop     | Aplikasi berhenti merokok dengan fitur "Savings Goals" yang membiayai target personal dari uang rokok yang dihemat. Relevan dengan fitur impian/target dan progress bar berbasis saldo terkumpul. | Google Play Store | [Buka Aplikasi](https://play.google.com/store/apps/details?id=com.smokestop.tracker)  |
| Kwit          | Aplikasi berhenti merokok berbasis CBT dengan pelacakan progres, penghematan uang, jurnal perjalanan, dan dukungan komunitas. Relevan dengan pelacakan progres, penghematan, dan jurnal craving.  | Google Play Store | [Buka Aplikasi](https://play.google.com/store/apps/details?id=fr.kwit.android)        |
| Kwit          | Aplikasi berhenti merokok berbasis CBT dengan pelacakan progres, penghematan uang, jurnal perjalanan, dan dukungan komunitas. Relevan dengan pelacakan progres, penghematan, dan jurnal craving.  | Apple App Store   | [Buka Aplikasi](https://apps.apple.com/gb/app/quit-smoking-for-good-kwit/id525441365) |
| TrackLess     | Pelacak kebiasaan offline dan privat dengan timer pantang, milestone kesehatan, dan pencadangan JSON lokal. Relevan dengan pendekatan offline-first dan pemantauan progres smoke-free.            | GitHub            | [Buka Repositori](https://github.com/poorangryman/trackless-public)                   |
```

## Contoh Salah

```markdown
// DILARANG: Ringkasan tidak menyebutkan fitur relevan proyek
| Nama Aplikasi | Ringkasan Singkat | Store | Link |
| ------------- | ----------------- | ----- | ---- |
| SmokeStop | Aplikasi populer untuk berhenti merokok. | Google Play Store | [Buka Aplikasi](https://play.google.com/store/apps/details?id=com.smokestop.tracker) |

// DILARANG: Format link tidak standar
| QuitNow! | Aplikasi dengan komunitas dan milestone. | Google Play Store | https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa |

// DILARANG: Kolom tidak lengkap
| EasyQuit | Mode tapering dan statistik. | Google Play Store | |

// DILARANG: Tabel tidak menggunakan format pipe Markdown

- SmokeFree: Quit smoking slowly - Mode bertahap, notifikasi - Google Play Store - [Link](...)
```

## Sumber Evaluasi

- File: `apk_serupa.md` (root proyek)
- Commit rujukan: `a6f3020` — Tambah daftar aplikasi berhenti merokok serupa (85+ aplikasi)
- Commit rujukan: `d174c1b` — Revisi instruksi riset aplikasi sejenis
- Commit rujukan: `f6ad391` — Delegasi pencarian aplikasi serupa ke berkas panduan
