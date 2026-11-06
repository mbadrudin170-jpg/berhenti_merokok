---
name: custom-animasi-loading
description: Membuat animasi loading di Flutter untuk satu halaman — spinner, progress bar, atau skeleton shimmer dengan package shimmer. Gunakan saat pengguna meminta loading state, spinner, placeholder, shimmer, FutureBuilder loading, atau animasi tunggu. Menghasilkan satu widget halaman dan satu class privat _LoadingView yang aksesibel dan menghormati MediaQuery.disableAnimations.
argument-hint: "[nama-halaman] [jenis-loading] [warna]"
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# Custom Animasi Loading (Flutter)

Buat animasi loading sebagai **satu class privat `_LoadingView`** di dalam file halaman. Gunakan widget bawaan Flutter untuk spinner/progress, dan package `shimmer` untuk skeleton. Jangan menulis ulang efek shimmer dari nol.

## Kapan Skill Ini Relevan

- Pengguna meminta halaman Flutter dengan _loading state_, _spinner_, _progress bar_, _skeleton_, _shimmer_, atau _placeholder_.
- Ada `FutureBuilder`, `StreamBuilder`, atau `isLoading` yang perlu ditampilkan ke pengguna.
- Pengguna meminta animasi tunggu untuk tombol submit, refresh, unggah/unduh, atau pemuatan daftar.

## Aturan Struktur (Wajib)

- **Satu halaman publik** (mis. `ArticleListPage`) yang mengelola data dan memilih tampilan.
- **Satu class privat `_LoadingView`** khusus animasi loading halaman itu.
- Semua placeholder baris/kartu dibuat **inline** di dalam `_LoadingView`. Tidak ada `_SkeletonTile`, `_SkeletonCard`, atau wrapper adaptif.
- Ekstrak ke widget bersama **hanya jika** skeleton dipakai di ≥ 2 halaman berbeda.

## Langkah Kerja

1. **Pilih jenis indikator** berdasarkan konteks:
   - `CircularProgressIndicator` → proses singkat, aksi tunggal (submit, refresh).
   - `LinearProgressIndicator` → progres terukur (`value` 0.0–1.0) atau indeterminate untuk unggah/unduh.
   - Skeleton + `shimmer` → memuat konten terstruktur (list, kartu, profil) agar layout tidak melompat.

2. **Tulis halaman publik**:
   - Kelola `_isLoading` dan data (mis. `_articles`).
   - Di `build`, pilih tampilan: `_isLoading ? const _LoadingView() : <konten asli>`.
   - Pastikan `setState` dipanggil setelah `if (!mounted) return;`.

3. **Tulis `_LoadingView` privat**:
   - Bungkus seluruh placeholder dengan **satu** `Shimmer.fromColors` — bukan satu `Shimmer` per baris. Dokumentasi resmi menegaskan: "Wrap a list of placeholders in one Shimmer, not one Shimmer per row."[reference:0]
   - Child shimmer berupa bentuk solid: `Container`, `Row`, `Column`, `SizedBox`. Dokumentasi: "Build the child from solid shapes. The gradient replaces those colors; transparent pixels stay transparent."[reference:1]
   - Bungkus dengan `Semantics(label: 'Memuat …', liveRegion: true)`.
   - Baca `MediaQuery.of(context).disableAnimations`. Jika `true`, kembalikan placeholder statis (tanpa `Shimmer`).

4. **Kustomisasi shimmer sesuai parameter resmi**:

   | Parameter        | Default                        | Keterangan                                                  |
   | ---------------- | ------------------------------ | ----------------------------------------------------------- |
   | `direction`      | `ShimmerDirection.ltr`         | `ltr`, `rtl`, `ttb`, `btt`[reference:2]                     |
   | `period`         | `Duration(milliseconds: 1500)` | Durasi satu siklus[reference:3]                             |
   | `loop`           | `0`                            | `0` = selamanya; `N` = berhenti setelah N kali[reference:4] |
   | `enabled`        | `true`                         | `false` menghentikan animasi[reference:5]                   |
   | `baseColor`      | `#FFE0E0E0`                    | Warna dasar (khusus `fromColors`)                           |
   | `highlightColor` | `#FFF5F5F5`                    | Warna band (khusus `fromColors`)                            |

   Untuk gradient yang mengikuti `Theme`, gunakan konstruktor `Shimmer(gradient: ...)` — dokumentasi menyarankan ini saat butuh `RadialGradient`, `SweepGradient`, atau `LinearGradient` yang mengikuti `Theme`.[reference:6]

5. **Format output**:
   - Satu file Dart lengkap: halaman publik + `_LoadingView` privat.
   - Sertakan `import 'package:shimmer/shimmer.dart';`.
   - Sebutkan `flutter pub add shimmer` jika dependensi belum ada.
   - Catatan versi resmi: `shimmer: ^4.0.0` membutuhkan `material_ui: ^1.0.1` (Flutter 3.44+). Proyek yang masih memakai `package:flutter/material.dart` dapat membungkus subtree dengan `MaterialUiCompatibilityBridge`.[reference:7] Untuk Flutter stabil di bawah 3.44, gunakan `shimmer: ^3.0.0`.

6. **Verifikasi mandiri sebelum menjawab**:
   - Hanya **dua class** dalam file: satu halaman publik, satu `_LoadingView` privat.
   - Satu `Shimmer` membungkus seluruh list, bukan per item.
   - `Semantics(label: ..., liveRegion: true)` ada di wrapper.
   - Ada fallback statis saat `disableAnimations == true`.
   - Child shimmer hanya berisi bentuk solid.
   - `if (!mounted) return;` sebelum `setState` setelah `await`.

## Referensi Pola

Buka `references/patterns.md` untuk: skeleton list, skeleton kartu, dark theme, arah & kecepatan, gradient kustom dari `Theme`, fallback reduce-motion, dan integrasi `FutureBuilder`. Pilih pola yang relevan saja.

## Contoh

Lihat `examples/input-skeleton.md` dan `examples/output-skeleton.md`.

## Larangan

- ❌ Membuat lebih dari satu class privat untuk animasi loading dalam satu halaman.
- ❌ Mengekstrak `_SkeletonTile`, `_SkeletonCard`, atau wrapper adaptif ke class terpisah.
- ❌ Membungkus setiap baris list dengan `Shimmer` sendiri (boros ticker).[reference:8]
- ❌ Memakai `Image`, `Text` berdekorasi, atau `Card` ber-elevation di dalam child shimmer — dokumentasi memperingatkan widget mewah "often look wrong because the shader replaces their colors."[reference:9]
- ❌ Membuat `AnimationController` manual untuk shimmer.
- ❌ Mengabaikan `MediaQuery.disableAnimations` untuk animasi dekoratif.
- ❌ Menggunakan `skeletonizer_plus`, `skeletonizer`, atau package skeleton lain kecuali diminta eksplisit.
