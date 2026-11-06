# Pengaturan dan Penggunaan Prettier

## 1. Tujuan

Gunakan Prettier sebagai formatter untuk menjaga konsistensi format file yang didukung, terutama Markdown, JSON, dan JSONC.

Pengaturan Prettier harus mengikuti konfigurasi proyek dan tidak boleh diubah berdasarkan preferensi pribadi AI.

## 2. File Konfigurasi Wajib

Pastikan kedua file berikut tersedia di root proyek:

1. `.prettierrc`
2. `.prettierignore`

Jangan membuat konfigurasi Prettier tambahan dengan nama berbeda yang berpotensi menimbulkan konflik.

### A. File `.prettierrc`

Apabila file belum tersedia, buat file tersebut.

Apabila sudah tersedia, sesuaikan isinya dengan konfigurasi berikut:

```json
{
  "trailingComma": "none",
  "overrides": [
    {
      "files": ["*.json"],
      "options": {
        "parser": "json",
        "trailingComma": "none"
      }
    },
    {
      "files": [
        "*.jsonc",
        "tsconfig*.json",
        "jsconfig.json",
        "devcontainer.json",
        "language-configuration.json"
      ],
      "options": {
        "parser": "jsonc",
        "trailingComma": "none"
      }
    }
  ]
}
```

Ketentuan:

- Pertahankan seluruh pengaturan tersebut.
- Jangan mengubah nilai `trailingComma`.
- Pastikan JSON menggunakan parser `json`.
- Pastikan JSONC dan file konfigurasi yang tercantum menggunakan parser `jsonc`.
- Jangan menambahkan pengaturan lain tanpa kebutuhan yang jelas dan persetujuan pengguna.

### B. File `.prettierignore`

Apabila file belum tersedia, buat file tersebut.

Apabila sudah tersedia, periksa isinya terlebih dahulu. Tambahkan pola pengecualian yang belum tersedia tanpa menghapus aturan pengecualian lain yang masih relevan.

Gunakan konfigurasi dasar berikut:

```gitignore
# Git dan dependensi JavaScript
.git/
node_modules/

# Cache dan dependensi Flutter/Dart
.dart_tool/
.pub/
.packages

# Hasil build dan pengujian
**/build/
**/coverage/

# File metadata hasil generate Flutter
.flutter-plugins
.flutter-plugins-dependencies

# Kode Dart hasil generate
**/*.g.dart
**/*.freezed.dart

# Hasil generate platform Android dan iOS
**/.gradle/
**/Pods/
**/ephemeral/
```

Ketentuan:

- Jangan mengabaikan seluruh folder `lib/`, `test/`, atau folder kode sumber lainnya.
- Jangan mengabaikan seluruh file Markdown, JSON, atau JSONC.
- Jangan membuat pola pengecualian yang terlalu luas sehingga file konfigurasi atau dokumentasi buatan pengguna ikut terabaikan.
- Pertahankan pola pengecualian tambahan yang sudah dibuat pengguna.

## 3. Aturan Penggunaan Prettier

1. Gunakan Prettier hanya untuk jenis file yang didukung.
2. Untuk file Markdown, JSON, dan JSONC, ikuti konfigurasi `.prettierrc`.
3. Jangan menggunakan Prettier untuk memformat file Dart.
4. Untuk seluruh file Dart, gunakan `dart format` sesuai SDK Dart yang digunakan proyek.
5. Jangan mengubah isi, maksud, atau perilaku kode ketika hanya diminta melakukan pemformatan.
6. Jangan mengubah pengaturan Prettier hanya agar hasil pemformatan sesuai preferensi pribadi AI.
7. Jangan memformat file yang masuk dalam `.prettierignore`.
8. Jangan memasang Prettier secara otomatis tanpa memeriksa apakah Prettier sudah tersedia.
9. Jangan membuat atau mengubah `package.json` maupun file lock hanya untuk memasang Prettier tanpa persetujuan pengguna.

## 4. Pemeriksaan Konfigurasi

Sebelum menggunakan Prettier:

1. Pastikan `.prettierrc` tersedia dan berisi konfigurasi yang ditentukan.
2. Pastikan `.prettierignore` tersedia dan berisi pola pengecualian yang ditentukan.
3. Pastikan Prettier tersedia di lingkungan proyek atau sistem.
4. Pastikan jenis file yang akan diformat didukung oleh Prettier.

Apabila Prettier tidak tersedia, laporkan kondisi tersebut. Jangan menganggap pemformatan berhasil.

## 5. Pemeriksaan Hasil Pemformatan

Setelah menjalankan Prettier:

1. Pastikan proses pemformatan berhasil.
2. Periksa hasil perubahan.
3. Pastikan tidak ada file yang seharusnya diabaikan ikut berubah.
4. Pastikan tidak ada perubahan isi yang tidak berkaitan dengan pemformatan.
5. Laporkan file yang berhasil diformat dan file yang gagal diformat.

## 6. Batasan Pekerjaan

- Jangan menjalankan pemformatan seluruh proyek apabila pengguna hanya meminta pemformatan file tertentu.
- Jangan mengubah file lain yang tidak berkaitan dengan tugas.
- Jangan mengubah aturan format tanpa alasan yang jelas.
- Jangan menyatakan pemeriksaan berhasil apabila belum benar-benar dijalankan.

**Prinsip utama:** Gunakan Prettier untuk file yang didukung dan `dart format` untuk kode Dart. Seluruh pemformatan wajib mengikuti konfigurasi proyek.
