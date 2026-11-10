---
name: riset-kompetitor
description: Panduan melakukan riset kompetitor aplikasi berhenti merokok - mencatat daftar aplikasi serupa di berbagai store (Google Play, Apple App Store, F-Droid, GitHub, Amazon Appstore, APKPure, Aptoide, SlideME, Tencent MyApp, Huawei AppGallery), menyertakan ringkasan fitur relevan, link store/repositori yang terverifikasi otomatis (curl HTTP 200, iTunes lookup), dan mengikuti format tabel yang terstandarisasi untuk perbandingan fitur, platform, dan relevansi terhadap proyek.
metadata:
  kategori: "custom"
  versi: "1.1.0"
  commit-terakhir: "3af4f53"
  model: "openrouter/thinkingmachines/inkling-2-small:free"
---

# Riset Kompetitor Aplikasi Berhenti Merokok

Mengumpulkan dan mendokumentasikan daftar aplikasi kompetitor (serupa) untuk analisis fitur, positioning, dan celah pasar. Hasil riset disimpan dalam format tabel standar di `apk_serupa.md` untuk referensi tim dan stakeholder.

## Cakupan yang Di-Cover

- Package: `tidak ada` (dokumentasi non-kode)
- File: `apk_serupa.md` (root proyek)
- Kolom tabel: `Nama Aplikasi`, `Ringkasan Singkat`, `Store`, `Link`
- Store yang didukung: Google Play Store, Apple App Store, F-Droid, GitHub, Samsung Galaxy Store, Uptodown, IzzyOnDroid, Amazon Appstore, APKPure, Aptoide, SlideME, Tencent MyApp, Huawei AppGallery
- Toko yang sering memblokir/menyulitkan akses langsung (Xiaomi GetApps, Oppo App Market, Vivo App Store, Huawei AppGallery, Baidu Mobile Assistant): hanya sertakan aplikasi bila link halaman aplikasi spesifik dapat diverifikasi.
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
9. Untuk riset massal lintas-store, delegasikan pencarian per-store ke subagen paralel, lalu **gabungkan dan verifikasi ulang secara independen** (subagen terbukti dapat mengarang link detail yang 404). Jangan percaya temuan subagen tanpa probe ulang.
10. Verifikasi otomatis dengan: `curl -s -o /dev/null -w "%{http_code}" -A "Mozilla/5.0 (X11; Linux x86_64) Chrome/120.0" -L <url>`. HTTP **200** = valid; HTTP **404** = buang entri; HTTP **403** dari APKPure/Aptoide/SlideME = anti-bot (bukan link mati) — verifikasi via websearch/webfetch, jangan dibuang otomatis.
11. Untuk id aplikasi Apple App Store, gunakan lookup `https://itunes.apple.com/lookup?id=<id>`; `resultCount: 0` berarti aplikasi tidak ada dan **tidak boleh** disertakan. Link per-region (`us`/`gb`/`id`/dst.) boleh dipakai bila mengembalikan 200.
12. Aplikasi Tionghoa/Regional tanpa link halaman aplikasi spesifik yang terverifikasi (mis. 戒烟军团, 今日抽烟, 自律戒烟, 戒烟小目标, 决心戒烟) **tidak boleh** disertakan; keberadaan di store saja (dari sumber sekunder) tidak cukup.
13. Periksa duplikat exact berdasarkan `package id` sebelum menambah baris (mis. `com.siwooeo.quitday` dan `com.siwooeo.quitsmoke` di Samsung Galaxy Store sudah tercatat sebagai QuitDay/QuitSave).
14. Untuk batch besar, tambahkan section `# Tambahan Riset (YYYY-MM-DD)` dengan sub-section `## <Store>`; setiap tabel tetap wajib punya header + separator (tabel yang kehilangan header rusak saat dirender).

## Larangan

- DILARANG menambah aplikasi tanpa ringkasan fitur relevan (hanya nama dan link).
- DILARANG menggunakan format tabel non-standar (mis. daftar bullet, JSON, CSV).
- DILARANG mengubah urutan kolom tabel yang sudah ditetapkan.
- DILARANG menghapus aplikasi yang sudah tercatat kecuali aplikasi benar-benar tidak lagi tersedia/tersedia di store resmi.
- DILARANG menyalin ringkasan dari deskripsi store tanpa disesuaikan dengan konteks proyek ini.
- DILARANG menambah kolom baru tanpa memperbarui skill ini dan seluruh baris tabel.
- DILARANG mempercayai link hasil subagen tanpa verifikasi independen (curl / iTunes lookup / webfetch) sebelum commit.
- DILARANG menyertakan aplikasi hanya dari sumber sekunder (situs agregator) tanpa link halaman aplikasi resmi yang terverifikasi.
- DILARANG menganggap HTTP 403 dari APKPure/Aptoide/SlideME sebagai link mati (itu anti-bot); sebaliknya DILARANG menyertakan link ber-HTTP 404 atau id App Store dengan `resultCount: 0`.
- DILARANG menambah tabel tanpa header/separator, atau menumpuk baris batch riset di bawah tabel yang sudah ada tanpa header baru.

## Contoh Benar

```markdown
| Nama Aplikasi | Ringkasan Singkat                                                                                                                                                                                 | Store             | Link                                                                                  |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- | ------------------------------------------------------------------------------------- |
| SmokeStop     | Aplikasi berhenti merokok dengan fitur "Savings Goals" yang membiayai target personal dari uang rokok yang dihemat. Relevan dengan fitur impian/target dan progress bar berbasis saldo terkumpul. | Google Play Store | [Buka Aplikasi](https://play.google.com/store/apps/details?id=com.smokestop.tracker)  |
| Kwit          | Aplikasi berhenti merokok berbasis CBT dengan pelacakan progres, penghematan uang, jurnal perjalanan, dan dukungan komunitas. Relevan dengan pelacakan progres, penghematan, dan jurnal craving.  | Google Play Store | [Buka Aplikasi](https://play.google.com/store/apps/details?id=fr.kwit.android)        |
| Kwit          | Aplikasi berhenti merokok berbasis CBT dengan pelacakan progres, penghematan uang, jurnal perjalanan, dan dukungan komunitas. Relevan dengan pelacakan progres, penghematan, dan jurnal craving.  | Apple App Store   | [Buka Aplikasi](https://apps.apple.com/gb/app/quit-smoking-for-good-kwit/id525441365) |
| TrackLess     | Pelacak kebiasaan offline dan privat dengan timer pantang, milestone kesehatan, dan pencadangan JSON lokal. Relevan dengan pendekatan offline-first dan pemantauan progres smoke-free.            | GitHub            | [Buka Repositori](https://github.com/poorangryman/trackless-public)                   |
```

Contoh verifikasi otomatis sebelum commit (riset massal lintas-store):

```bash
# Google Play / Apple App Store / GitHub / F-Droid (200 = valid, 404 = buang)
for u in "<url1>" "<url2>"; do
  code=$(curl -s -o /dev/null -w "%{http_code}" -A "Mozilla/5.0 (X11; Linux x86_64) Chrome/120.0" --max-time 15 -L "$u"); echo "$code  $u"
done

# App Store: cek keberadaan app (resultCount: 0 = tidak ada, jangan sertakan)
curl -s "https://itunes.apple.com/lookup?id=<app_id>" | head -c 300

# APKPure / Aptoide / SlideME sering 403 (anti-bot, bukan mati) -> verifikasi via websearch/webfetch
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
- Commit rujukan: `3af4f53` — Tambah riset aplikasi serupa lintas-store (delegasi subagen paralel, verifikasi curl/HTTP 200 + iTunes lookup, 403 anti-bot APKPure/Aptoide/SlideME, section `# Tambahan Riset (2026-11-10)`)
