# Aturan Pembuatan dan Pembaruan SKILL.md

## 1. Cakupan

Aturan ini berlaku saat AI **membuat** atau **memperbarui** file `SKILL.md`.
Semua skill yang dibuat sebisa mungkin harus dapat digunakan oleh berbagai proyek Flutter milik pengguna (portabel lintas-proyek).

## 2. Lokasi dan Struktur

- Path skill: `.agents/skills/<kategori>/<nama-skill>/SKILL.md`
- Wajib menggunakan folder `skills` (jamak), bukan `skill`
- Kategori default: `custom`
- Struktur wajib:

```
.agents/skills/<kategori>/<nama-skill>/
└── SKILL.md
```

## 3. Topik Wajib (Referensi Format)

Setiap skill harus mengikuti standar format dan penulisan dari skill referensi yang sudah ada. Skill referensi ini digunakan sebagai acuan tata letak section, gaya bahasa, dan penggunaan backtick, bukan harus meniru isi secara harfiah.

### 3.1 Referensi Skill Topik UI

Berikut adalah daftar skill referensi UI yang formatnya harus diikuti sebagai acuan:

- `pola-ux/SKILL.md`
- `pola-ui/SKILL.md`
- `gaya/SKILL.md`
- `tipografi/SKILL.md`
- `spacing/SKILL.md`
- `widget-custom/SKILL.md`

### 3.2 Referensi Skill Topik Non-UI

- `bug-runtime/SKILL.md`

## 4. Nama Folder Skill

Nama folder skill wajib memenuhi semua ketentuan berikut:

1. Wajib **bahasa Indonesia**.
2. Wajib **deskriptif** (menunjukkan isi skill, bukan nama generik).
3. Wajib **kebab-case** (pemisah strip `-`).
4. Dilarang menggunakan garis bawah (`_`).
5. Dilarang menggunakan spasi.
6. Dilarang huruf besar.
7. Dilarang angka di awal nama.
8. Dilarang karakter selain `a-z`, `0-9`, dan strip `-`.

Contoh nama yang benar: `menambahkan-integration-test-flutter`, `material-app-tema-lokalisasi`, `flutter-local-notifikasi-push`.

Contoh nama yang salah: `integration_test`, `Integration Test`, `01-test`, `my-skill`, `skill_test`.

## 5. Sumber Isi (Berdasarkan Riwayat Commit)

Semua isi `SKILL.md` wajib **mengikuti riwayat commit code** pengguna.

### 5.1 Pengambilan Sumber

AI hanya boleh membaca dari commit yang sudah ada menggunakan perintah git seperti:

- `git log`
- `git show <commit>`
- `git diff <commit>`

### 5.2 Dilarang Mengambil Dari

- File yang belum di-commit (working directory / working tree)
- Perubahan yang masih di staging (`git diff --cached`)
- File untracked

### 5.3 Commit yang Berkaitan

"Commit yang berkaitan" berarti commit yang menyentuh file atau folder yang berhubungan dengan topik skill.

- Jika ada commit yang berkaitan: isi `SKILL.md` disusun dari commit tersebut.
- Jika ada beberapa commit yang berkaitan dan polanya berbeda: AI memilih pola dari **commit terbaru yang relevan**, kecuali pengguna menentukan lain.
- Jika **tidak ada** commit yang berkaitan: AI **dilarang mengarang** pola, gaya, atau contoh. AI wajib berhenti dan menanyakan kepada pengguna bagaimana ingin melanjutkan (contoh: memberikan contoh dari SDK resmi, atau menunda pembuatan skill sampai ada commit yang relevan).

### 5.4 Referensi Commit

`SKILL.md` boleh mencantumkan hash commit sebagai rujukan (opsional).

## 6. Pelanggaran Aturan

- Jika menemukan skill lama yang melanggar aturan ini, AI wajib **melaporkan kepada pengguna dan mengusulkan perbaikan** melalui komentar/pesan sebelum melakukan rename atau restructure.
- AI dilarang membiarkan pelanggaran tetap tanpa ditindaklanjuti. Jika pelanggaran ditemukan, AI harus memberitahu pengguna dan menunggu arahan sebelum melanjutkan perubahan apapun pada skill tersebut.

## 7. Front Matter (YAML)

Setiap `SKILL.md` wajib memiliki frontmatter di paling atas file, dibungkus dengan `---` pada baris pertama dan `---` setelah field terakhir.

### 7.1 Field Wajib

| Field                      | Keterangan                                                    |
| -------------------------- | ------------------------------------------------------------- |
| `name`                     | Sama dengan nama folder skill (kebab-case, bahasa Indonesia)  |
| `description`              | Deskripsi yang sangat detail                                  |
| `metadata.kategori`        | Sesuai folder kategori (default `"custom"`)                   |
| `metadata.versi`           | Format semver, contoh `"1.0.0"`                               |
| `metadata.commit-terakhir` | Hash commit rujukan, atau `"belum-ada-commit"` jika belum ada |

### 7.2 Field Opsional

| Field            | Keterangan                                                                                                                 |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `metadata.model` | Jika dicantumkan, wajib diisi dengan model AI yang sedang mengedit skill saat itu, dan diperbarui setiap kali skill diedit |

### 7.3 Contoh Front Matter

```yaml
---
name: menambahkan-integration-test-flutter
description: Panduan menambahkan integration test Flutter, mengeksplorasi UI via MCP, dan mengotomasi alur pengguna dengan integration_test.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  model: "models/gemini-3.1-pro-preview"
  commit-terakhir: "<hash-commit>"
---
```

## 8. Aturan Penulisan Deskripsi Skill

Deskripsi skill (bagian `description` dan paragasan pengantar) wajib mencakup poin-poin berikut:

1. **Kapan digunakan (trigger/use case)** — jelaskan skenario spesifik yang memerlukan skill ini.
2. **Apa yang di-cover** — cakupan fungsi, class, package, atau versi yang relevan (contoh: `flutter_local_notifications` v22.3.3).
3. **Apa yang harus dihindari** — jangan digunakan untuk UI web, jangan diedit manual file generated, dll.
4. **Langkah kerja (workflow)** — urutan tindakan yang wajib diikuti, misal `pub get` → `build_runner` → verifikasi `dart analyze`.
5. **Referensi ke file terkait** — path file atau folder yang relevan dengan topik skill dan digunakan sebagai acuan saat menerapkan skill tersebut.

## 9. Format Lengkap `SKILL.md`

Setiap section di bawah ini **wajib ada** dalam setiap `SKILL.md`. Tidak perlu folder `examples` terpisah — contoh kode langsung di dalam `SKILL.md`. Gunakan bahasa Indonesia, gaya teknis ringkas, tanpa pengalaman konversasi. Gunakan backtick `` ` `` untuk nama class, properti, method, dan package.

### 9.1 YAML Frontmatter (awal file)

```yaml
---
name: material-app-tema-lokalisasi
description: Panduan konfigurasi MaterialApp dan WidgetsApp - tema (theme, darkTheme, themeMode), lokalisasi (locale, supportedLocales, localizationsDelegates), serta ScrollBehavior.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "<hash-commit>"
  model: "kilo-auto/free"
---
```

### 9.2 Judul dan Intro

```markdown
# Konfigurasi MaterialApp, Tema, dan Lokalisasi

Mengatur `MaterialApp` / `WidgetsApp` dengan tema gelap/terang, locale, supportedLocales, dan localizationsDelegates untuk aplikasi multi-bahasa.
```

- H1 = judul skill
- Paragraf berikutnya = penjelasan singkat tujuan skill

### 9.3 `## Cakupan yang Di-Cover`

Daftar bullet dengan kategori: Package, Class, Enum, Properti, Method.

```markdown
## Cakupan yang Di-Cover

- Package: `package:flutter` (file `lib/src/widgets/material/app.dart`, `lib/src/widgets/app.dart`)
- Class: `MaterialApp`, `WidgetsApp`, `ThemeMode`, `ThemeData`, ...
- Enum: `ThemeMode.system`, `ThemeMode.light`, `ThemeMode.dark`
- Properti: `theme`, `darkTheme`, ...
- Method: `basicLocaleListResolution`, `Theme.of`, ...
```

### 9.4 `## Aturan`

Daftar berurutan (numbered list) yang harus diikuti saat menerapkan skill ini.

```markdown
## Aturan

1. `MaterialApp` membungkus `WidgetsApp` ...
2. Salah satu dari `home`, `routes`, `onGenerateRoute`, atau `builder` harus non-null.
   ...
```

### 9.5 `## Larangan`

Daftar bullet yang dimulai dengan `DILARANG` atau menjelaskan hal yang tidak boleh dilakukan.

```markdown
## Larangan

- `darkTheme` dengan brightness bukan `Brightness.dark`.
- `MaterialApp` tanpa `home`, `routes`, `onGenerateRoute`, atau `builder`.
  ...
```

### 9.6 `## Contoh Benar`

Satu blok kode Dart dengan implementasi yang benar.

````markdown
## Contoh Benar

```dart
MaterialApp(
  ...
);
```
````

````

### 9.7 `## Contoh Salah`

Satu atau lebih blok kode Dart dengan komentar `// DILARANG` atau `// salah: ...` yang menjelaskan mengapa salah.

```markdown
## Contoh Salah

```dart
// darkTheme tanpa brightness dark
darkTheme: ThemeData(primaryColor: Colors.blue), // salah: brightness default light
````

```dart
// supportedLocales kosong
supportedLocales: [], // assert error
```

````

### 9.8 `## Sumber Evaluasi`

Daftar file sumber dan class terkait untuk verifikasi.

```markdown
## Sumber Evaluasi

- File: `lib/path/to/file.dart`
- Class terkait: `NamaClass1`, `NamaClass2`
- Commit rujukan: `<hash-commit>`
```

## 10. Contoh Lengkap `SKILL.md` (Template Siap Salin)

Berikut adalah contoh lengkap yang dapat langsung disalin sebagai template untuk skill baru:

````markdown
---
name: nama-skill-bahasa-indonesia
description: Deskripsi sangat detail tentang kapan skill ini digunakan, apa yang di-cover, apa yang dihindari, langkah kerja, dan referensi file terkait.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "<hash-commit>"
  model: "nama-model-ai"
---

# Judul Skill dalam Bahasa Indonesia

Penjelasan singkat tujuan skill dalam satu atau dua paragraf.

## Cakupan yang Di-Cover

- Package: `package:nama_package`
- Class: `NamaClass1`, `NamaClass2`
- Enum: `EnumNilai1`, `EnumNilai2`
- Properti: `propertiSatu`, `propertiDua`
- Method: `namaMethodSatu`, `namaMethodDua`

## Aturan

1. Aturan pertama yang harus diikuti.
2. Aturan kedua yang harus diikuti.
3. Aturan ketiga yang harus diikuti.

## Larangan

- DILARANG melakukan sesuatu yang melanggar pola.
- DILARANG menggunakan properti tanpa validasi yang sesuai.

## Contoh Benar

```dart
// Implementasi yang benar sesuai aturan skill
NamaClass(
  propertiSatu: nilai,
);
```

## Contoh Salah

```dart
// DILARANG: implementasi yang tidak sesuai
NamaClass(
  propertiSatu: null, // salah: properti wajib diisi
);
```

## Sumber Evaluasi

- File: `path/to/file.dart`
- Class terkait: `NamaClass1`, `NamaClass2`
```

## 11. Checklist Sebelum Menyelesaikan SKILL.md

Sebelum mengakhiri pembuatan atau pembaruan `SKILL.md`, verifikasi semua poin berikut:

- [ ] File berada di `.agents/skills/<kategori>/<nama-skill>/SKILL.md`
- [ ] Nama folder menggunakan kebab-case, bahasa Indonesia, deskriptif
- [ ] Tidak ada underscore, spasi, huruf besar, angka di awal, atau karakter selain `a-z0-9-`
- [ ] Front matter YAML lengkap dengan field wajib (`name`, `description`, `metadata.kategori`, `metadata.versi`, `metadata.commit-terakhir`)
- [ ] Semua section wajib ada (Judul/Intro, Cakupan, Aturan, Larangan, Contoh Benar, Contoh Salah, Sumber Evaluasi)
- [ ] Isi mengikuti riwayat commit yang relevan (tidak diarang dari working directory/staging/untracked)
- [ ] Deskripsi mencakup trigger, cakupan, larangan, workflow, dan referensi file
- [ ] Bahasa Indonesia, gaya teknis ringkas, tanpa pengalaman konversasi
- [ ] Backtick digunakan untuk class, properti, method, package
- [ ] Jika menemukan pelanggaran pada skill lama, telah melaporkan dan mengusulkan perbaikan
```
