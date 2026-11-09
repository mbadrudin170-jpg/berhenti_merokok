# Aturan Inti: Pembuatan dan Pembaruan SKILL.md

## 1. Cakupan
1.1. Aturan ini berlaku setiap kali AI **membuat** atau **memperbarui** file `SKILL.md`.
1.2. Skill sebisa mungkin harus bisa dipakai ulang oleh berbagai proyek Flutter milik pengguna, jadi hindari isi yang terikat pada satu proyek saja.

## 2. Lokasi dan Struktur
2.1. Path skill: `.agents/skills/<kategori>/<nama-skill>/SKILL.md`
2.2. Gunakan `skills` (jamak), bukan `skill`.
2.3. Kategori default: `custom`.
2.4. Struktur wajib:

```
.agents/skills/<kategori>/<nama-skill>/
├── SKILL.md
├── examples/
│   ├── input-<varian>.dart
│   └── output-<varian>.dart
└── references/          (opsional)
    └── <topik>.md
```

## 3. Topik Wajib
Daftar di bawah adalah standar dan contoh. Untuk skill di luar daftar ini, AI wajib menyesuaikan topiknya.

### 3.1. Topik UI
- `pola-ux/SKILL.md`
- `pola-ui/SKILL.md`
- `gaya/SKILL.md`
- `tipografi/SKILL.md`
- `spacing/SKILL.md`
- `widget-custom/SKILL.md`

### 3.2. Topik Non-UI
- `bug-runtime/SKILL.md`
- `boilerplate/SKILL.md`

## 4. Nama Folder Skill
4.1. Wajib **bahasa Indonesia**.
4.2. Wajib **deskriptif**: menunjukkan isi skill, bukan nama generik.
4.3. Wajib **kebab-case**, pemisah `-`.
4.4. Dilarang: `_`, spasi, huruf besar, angka di awal, dan karakter selain `a-z`, `0-9`, `-`.

## 5. Folder `examples/`
5.1. Setiap skill **wajib** punya folder `examples/`.
5.2. Isi `examples/` hanya boleh file `.dart`. Ekstensi lain dilarang.
5.3. Minimal **satu pasang** file: `input-<varian>.dart` + `output-<varian>.dart`.
5.4. `<varian>` wajib kebab-case dan bahasa Indonesia.
5.5. Setiap `input-<varian>.dart` wajib punya pasangan `output-<varian>.dart` dengan `<varian>` yang sama.
5.6. `examples/` dilarang kosong.
5.7. Isi pasangan file: `input` = kode awal atau kasus, `output` = kode hasil. File ini adalah potongan contoh: tidak harus bisa dikompilasi, dan dilarang di-import dari `lib/` atau `test/`.
5.8. Rujukan commit wajib ditulis sebagai komentar di baris paling atas setiap file contoh:
- `// commit: <hash-commit>`
- `// commit: belum-ada-commit` (jika belum ada commit rujukan)

## 6. Folder `references/` (Opsional)
6.1. Dibuat hanya jika skill butuh rujukan pola atau teori.
6.2. Isinya file `.md` dengan nama kebab-case.

## 7. Sumber Isi
7.1. Semua isi `SKILL.md` dan `examples/` wajib **mengikuti riwayat commit** kode pengguna.
7.2. AI hanya boleh membaca dari commit yang sudah ada: `git log`, `git show`, `git diff <commit>`.
7.3. AI **dilarang** memakai:
- file yang belum di-commit (working directory)
- perubahan di staging (`git diff --cached`)
- file untracked
7.4. "Commit yang berkaitan" = commit yang menyentuh file atau folder yang berhubungan dengan topik skill.

### 7.5. Jika ada commit yang berkaitan
- Isi `SKILL.md` dan `examples/` disusun dari commit tersebut.
- Setiap file contoh di `examples/` wajib mencantumkan **hash commit** sesuai 5.8.
- Jika ada beberapa commit berkaitan dengan pola berbeda, pilih pola dari **commit terbaru yang relevan**, kecuali pengguna menentukan lain.
- `SKILL.md` boleh mencantumkan hash commit (opsional).

### 7.6. Jika tidak ada commit yang berkaitan
- AI **wajib menambahkan skill baru**, dengan rancangan `SKILL.md` dan `examples/` yang disusun AI.
- File contoh pada skill baru **tidak wajib** berisi hash commit, tapi wajib memakai `belum-ada-commit` sesuai 5.8 sebagai tanda belum ada commit rujukan.

### 7.7. Larangan mengarang
Di luar kondisi 7.6, AI dilarang mengarang pola, gaya, atau contoh yang tidak pernah muncul di riwayat commit.

## 8. Frontmatter
8.1. Setiap `SKILL.md` wajib punya frontmatter di paling atas file.
8.2. Dibungkus `---` di baris pertama dan `---` setelah field terakhir.
8.3. Atribut level atas HANYA boleh berasal dari daftar yang didukung Code OSS agents:
`argument-hint`, `compatibility`, `context`, `description`, `disable-model-invocation`, `license`, `metadata`, `name`, `user-invocable`.
Dilarang menulis atribut lain di level atas (misalnya `kategori`, `versi`, `commit-terakhir`, `model`), karena akan memunculkan error.
8.4. Atribut level atas yang wajib:
- `name`: sama dengan nama folder skill (kebab-case, bahasa Indonesia)
- `description`: ringkasan isi skill, satu kalimat
- `metadata`: berisi data tambahan sesuai 8.5
8.5. Isi `metadata` (semua nilai wajib berupa string, pakai tanda kutip):
- `kategori`: sesuai folder kategori (default `"custom"`)
- `versi`: format semver, contoh `"1.0.0"`
- `commit-terakhir`: hash commit rujukan, atau `"belum-ada-commit"` jika belum ada
- `model` (opsional): model AI yang dipakai saat menyusun skill
8.6. Contoh:

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

## 9. Sinkronisasi
9.1. Update `SKILL.md` → wajib periksa dan perbarui `examples/` jika langkah, input, atau output berubah.
9.2. Update `examples/` → wajib pastikan `SKILL.md` masih konsisten.
9.3. Setiap perubahan isi skill → naikkan `metadata.versi` dan perbarui `metadata.commit-terakhir` jika rujukannya berubah.

## 10. Pelanggaran
10.1. Jika menemukan skill lama yang melanggar aturan ini, AI wajib **melapor dan mengusulkan perbaikan** sebelum melakukan rename atau restructure.
10.2. AI dilarang diam-diam membiarkan aturan yang tidak terpenuhi.
10.3. Skill lama yang masih menulis `kategori`, `versi`, `commit-terakhir`, atau `model` di level atas frontmatter, atau yang `examples/`-nya berisi file `.md`, termasuk pelanggaran dan wajib dilaporkan sesuai 10.1.