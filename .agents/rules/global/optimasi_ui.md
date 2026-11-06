# Optimasi UI

**Path:** `.agents/rules/global/optimasi_ui.md`

## Tujuan

File ini merupakan referensi utama untuk seluruh implementasi UI/UX pada proyek Flutter.

Seluruh desain antarmuka harus mengacu pada ketentuan dalam file ini, khususnya mengenai layout, tipografi, ukuran, jarak, padding, dan margin. Tujuannya adalah menjaga konsistensi desain agar aplikasi memiliki tampilan yang profesional dan premium.

## Aturan

### 1. Referensi Desain

1. Gunakan file ini sebagai referensi untuk menentukan:
   - Layout.
   - Jenis dan ukuran font.
   - Ukuran komponen.
   - Jarak antar-elemen.
   - Padding.
   - Margin.

2. Seluruh implementasi UI/UX wajib mengacu pada standar yang ditetapkan dalam file ini.

3. Terapkan standar desain tersebut pada seluruh file Dart agar tampilan aplikasi tetap konsisten.

4. Dilarang menetapkan nilai ukuran, jarak, padding, dan margin secara sembarangan di dalam widget. Gunakan nilai yang telah ditentukan dalam referensi desain ini.

### 2. Penggunaan Warna dan Tema

1. Gunakan warna dari tema aplikasi untuk teks maupun komponen UI lainnya agar tampilannya dapat menyesuaikan dengan mode tema yang aktif.

2. Penggunaan warna hardcode diperbolehkan apabila warna tersebut memang harus tetap sama pada seluruh mode tema.

3. Nilai warna yang menggunakan format HEX atau RGBA tidak boleh diubah menjadi referensi `ColorScheme`.

4. Jangan menggunakan warna hardcode untuk komponen yang seharusnya mengikuti perubahan tema aplikasi.

### 3. Penanganan Text Overflow

1. Antisipasi kemungkinan teks menjadi panjang dan menyebabkan overflow pada layout.

2. Berikan penanganan khusus pada teks yang wajib tetap terlihat agar tidak menyebabkan overflow.

3. Gunakan widget seperti `FittedBox` atau `Flexible` apabila sesuai dengan kebutuhan layout dan karakteristik teks.

4. Jangan menerapkan `FittedBox` atau `Flexible` secara sembarangan pada seluruh teks. Gunakan hanya pada bagian yang memang membutuhkannya.

### 4. Pengaturan Jarak Antar-Anak Widget

1. Gunakan properti `spacing` pada `Row` dan `Column` untuk mengatur jarak antar-widget anak.

2. Gunakan `SizedBox` hanya untuk kebutuhan jarak khusus yang tidak dapat ditangani menggunakan properti `spacing`.

3. Hindari penggunaan `SizedBox` berulang hanya untuk mengatur jarak standar antar-widget anak.

#### Contoh benar

```dart
Column(
  spacing: 8,
  children: const [
    Text('Judul'),
    Text('Deskripsi'),
  ],
);
```

**Alasan:** Jarak antar-anak diatur melalui properti `spacing`.

#### Contoh salah

```dart
Column(
  children: const [
    Text('Judul'),
    SizedBox(height: 8),
    Text('Deskripsi'),
    SizedBox(height: 8),
    Text('Lainnya'),
  ],
);
```

**Kesalahan:** Menggunakan `SizedBox` berulang untuk jarak standar.

**Rujukan teknis:**
- Flutter SDK — `Row.spacing`, `Column.spacing`.
```

### 5. Pengaturan Tipografi

1. Gunakan `Theme.of(context).textTheme` sebagai referensi utama untuk menentukan gaya teks.

2. Jika diperlukan penyesuaian gaya teks, gunakan `copyWith()` berdasarkan gaya teks yang tersedia dalam tema.

#### Contoh benar

```dart
final textTheme = Theme.of(context).textTheme;

Text(
  'Judul',
  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
);
```

**Alasan:** Gaya teks dasar diambil dari tema, lalu disesuaikan dengan `copyWith`.

#### Contoh salah

```dart
Text(
  'Judul',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
);
```

**Kesalahan:** Menentukan ukuran dan gaya teks secara manual tanpa acuan tema.

**Rujukan teknis:**
- Flutter SDK — `Theme.of(context).textTheme`, `TextStyle.copyWith`.
```

3. Penggunaan warna hardcode pada teks diperbolehkan apabila memang diperlukan untuk mempertahankan warna tertentu pada mode terang dan gelap.

### 6. Dialog Konfirmasi

Gunakan komponen yang tersedia dalam paket `adaptive_dialog` untuk membuat dialog konfirmasi.

### 7. Proses Berat di Build

1. Jangan menjalankan proses komputasi berat secara langsung di dalam method `build()`.

2. Proses seperti sorting data dalam jumlah besar dan parsing data harus dipindahkan ke tempat yang sesuai, seperti Provider atau Isolate.

3. Hindari pekerjaan berat di dalam `build()` agar proses rendering UI tidak terganggu.

### 8. Penggunaan showModalBottomSheet

1. Setiap penggunaan `showModalBottomSheet` wajib memperhatikan area aman layar menggunakan `SafeArea`.

2. Jika konten Bottom Sheet berukuran panjang dan berpotensi melebihi tinggi layar, wajib menggunakan `isScrollControlled: true`.

3. Pastikan konten yang panjang dapat ditampilkan dan digulir tanpa terpotong oleh batas layar.

#### Contoh benar

```dart
showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  builder: (context) => SafeArea(
    child: DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => ListView(
        controller: scrollController,
        children: const [Text('Konten panjang')],
      ),
    ),
  ),
);
```

**Alasan:** Bottom sheet panjang menggunakan `SafeArea` dan `isScrollControlled`.

#### Contoh salah

```dart
showModalBottomSheet<void>(
  context: context,
  builder: (context) => Column(
    children: const [Text('Konten panjang')],
  ),
);
```

**Kesalahan:** Konten panjang tidak dapat digulir dan tidak memperhatikan area aman.

**Rujukan teknis:**
- Flutter SDK — `showModalBottomSheet`, `SafeArea`, `isScrollControlled`.
```

## Rekomendasi

1. Utamakan konsistensi desain pada seluruh halaman aplikasi.
2. Pilih widget yang sesuai dengan kebutuhan layout dan karakteristik konten.
3. Hindari penggunaan widget yang tidak diperlukan apabila tersedia solusi yang lebih sederhana.
