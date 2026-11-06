# Aturan Optimasi Boilerplate

## 1. State dan Model

- Wajib menggunakan `Freezed` untuk seluruh pembuatan state dan model.

#### Contoh benar

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bahan_bakar_state.freezed.dart';

@freezed
class BahanBakarState with _$BahanBakarState {
  const factory BahanBakarState({
    required List<BahanBakar> listBahanBakar,
  }) = _BahanBakarState;
}
```

**Alasan:** State dibuat dengan `@freezed` dan menghasilkan file `.freezed.dart`.

#### Contoh salah

```dart
class BahanBakarState {
  final List<BahanBakar> listBahanBakar;
  BahanBakarState({required this.listBahanBakar});
}
```

**Kesalahan:** State dibuat manual tanpa `Freezed`.

**Rujukan teknis:**
- `pubspec.yaml` — `freezed`, `freezed_annotation`.
- `lib/fitur/*/state/*.dart` dan `*.freezed.dart`.
## 2. Pemanfaatan Paket

- Cari paket yang tersedia di [pub.dev](https://pub.dev/) menggunakan tool `websearch`.
- Cari paket yang memiliki tujuan atau fungsi serupa dengan kode yang digunakan dalam proyek.
- Gunakan kata kunci pencarian yang umum dan tidak terlalu spesifik, misalnya:
  - Paket loading.
  - Paket stream.
  - Paket notifikasi.
  - Paket untuk kebutuhan lainnya yang relevan.
- Lakukan pencarian secara menyeluruh terhadap paket-paket yang relevan.
- Kembalikan hasil pencarian kepada pengguna dalam bentuk daftar tautan paket pub.dev.

## 3. Penggunaan Kembali Fungsi

- Jika terdapat kode dengan fungsi atau tujuan yang sama di beberapa tempat, pertimbangkan untuk memindahkannya ke satu file khusus.
- File-file yang membutuhkan fungsi tersebut cukup memanggil implementasi dari file khusus tersebut.
- Hindari menulis ulang kode yang sebenarnya dapat digunakan bersama.

## 4. Penerapan Abstraksi

- Jangan membuat abstraksi hanya untuk mengurangi jumlah kode yang ditulis.
- Setiap abstraksi harus memberikan manfaat yang jelas, seperti:
  - Memungkinkan penggunaan ulang kode.
  - Memisahkan tanggung jawab.
  - Mempermudah pengujian.

## 5. Pemanfaatan Fitur Bawaan

- Sebelum membuat implementasi secara manual, periksa terlebih dahulu apakah Flutter, Dart, atau paket yang sudah digunakan menyediakan fitur atau fungsi yang dibutuhkan.
- Gunakan fitur bawaan yang sudah tersedia dan memadai.
- Jangan membuat ulang mekanisme yang sebenarnya sudah disediakan oleh SDK atau paket yang digunakan.

## 6. Efisiensi Jumlah Kode

- Usahakan menggunakan jumlah kode yang efisien tanpa mengurangi keterbacaan, kejelasan, dan kemudahan pemeliharaan.
- Pertahankan tujuan dan perilaku kode yang sudah ada.
- Jangan mengubah fungsi maupun hasil yang diharapkan dari kode tersebut.

## 7. Pemanfaatan SDK

- Sebelum membuat kode secara manual, cari terlebih dahulu apakah implementasi atau fungsi yang dibutuhkan sudah tersedia di SDK.
- Lakukan pencarian pada SDK atau sumber lokal yang tersedia terlebih dahulu.
- Jika tidak ditemukan secara lokal, cari implementasi atau fungsi serupa di [pub.dev](https://pub.dev/).

## 8. Struktur Folder

Gunakan folder `notifier` dan `provider` sesuai tanggung jawab masing-masing:

- **Folder `notifier`**: khusus menyimpan file yang berisi class Notifier, termasuk Notifier yang menyediakan fungsi `read`.
- **Folder `provider`**: khusus menyimpan file provider yang tidak memiliki fungsi `read`.

## 9. Enum yang Ditampilkan kepada Pengguna

- Setiap Enum yang nilainya ditampilkan kepada pengguna wajib memiliki getter `label` melalui extension.
- Tambahkan getter `icon` apabila diperlukan.
- Gunakan extension khusus untuk setiap Enum agar representasi nilai dapat dikelola secara terpusat.

Contoh:

```dart
extension SortBahanBakarExtension on SortBahanBakarEnum {
  String get label {
    switch (this) {
      // Sesuaikan label dengan setiap nilai Enum.
    }
  }
}
```
