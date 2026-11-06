# Aturan Optimasi Performa

## 1. Mempertahankan Posisi Scroll dan Identitas Item

1. Ketika operasi apa pun dilakukan pada daftar, seperti menambah, menghapus, mengubah, atau memperbarui item, posisi scroll harus tetap dipertahankan.
2. Jangan sampai daftar kembali ke posisi paling atas hanya karena operasi tersebut menyebabkan widget dibangun ulang (_rebuild_).
3. Setiap item yang dirender dalam daftar wajib memiliki `Key` yang stabil dan unik.
4. Gunakan `ValueKey`, `ObjectKey`, atau `UniqueKey` sesuai karakteristik dan kebutuhan identitas item.
5. Key harus tetap konsisten untuk item yang sama selama item tersebut masih memiliki identitas yang sama. Jangan membuat key baru setiap kali widget dibangun ulang.

#### Contoh benar

```dart
ListView.builder(
  itemCount: daftar.length,
  itemBuilder: (context, index) {
    final item = daftar[index];
    return ListTile(
      key: ValueKey(item.id),
      title: Text(item.nama),
    );
  },
);
```

**Alasan:** `ValueKey(item.id)` stabil dan unik untuk setiap item.

#### Contoh salah

```dart
ListView.builder(
  itemCount: daftar.length,
  itemBuilder: (context, index) {
    final item = daftar[index];
    return ListTile(
      key: ValueKey(DateTime.now().millisecondsSinceEpoch),
      title: Text(item.nama),
    );
  },
);
```

**Kesalahan:** Key berubah setiap rebuild, sehingga posisi scroll dan identitas item tidak stabil.

**Rujukan teknis:**
- Flutter SDK — `ValueKey`, `ObjectKey`, `UniqueKey`.
```

## 2. Rekomendasi Optimasi Pekerjaan Berat

1. Pekerjaan berat, seperti parsing JSON berukuran besar, sorting data dalam jumlah besar, dan komputasi intensif, direkomendasikan untuk dijalankan di luar UI thread menggunakan `compute()` atau `Isolate.run()`.
2. Hindari menjalankan pekerjaan berat secara langsung di UI thread karena dapat menyebabkan antarmuka tidak responsif.
3. Fungsi yang diberikan sebagai argumen kepada `compute()` harus berupa fungsi `top-level` atau `static`.
