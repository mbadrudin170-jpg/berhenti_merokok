# Contoh Output: Kartu Motivasi dan Pintasan Aksi Cepat

## Sumber
- Commit: `e6595744b3840998d840e398ca1782e7be7d50b4`
- File rujukan: `lib/fitur/dashboard/screens/dashboard_screen.dart`, `lib/fitur/sos_craving/screens/sos_craving_screen.dart`, `lib/fitur/alasan_berhenti/screens/form_alasan_berhenti.dart`

## Implementasi

### 1. Akses Data Opsional Aman (Dashboard)
```dart
Widget _buildCardAlasanBerhenti(WidgetRef ref) {
  final alasanAsync = ref.watch(alasanBerhentiProvider);
  
  // Akses aman tanpa blokir UI
  final jumlah = alasanAsync.asData?.value.jumlahAlasan ?? 0;
  L.i('jumlahAlasan=$jumlah');

  if (jumlah == 0) {
    L.w('daftar alasan kosong, sembunyikan kartu');
    return const SizedBox.shrink();
  }

  final alasanTerbaru = alasanAsync.asData?.value.listAlasan.first;
  final snippet = alasanTerbaru?.teks ?? '';
  L.i('snippetAlasan=$snippet');

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Row(
            children: [
              const Icon(CupertinoIcons.heart_fill, color: Colors.red),
              const SizedBox(width: 8),
              Text('Alasan Berhenti', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          Text(snippet, style: Theme.of(context).textTheme.bodyMedium),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => unawaited(
                Nav.to(context, const AlasanBerhentiScreen()).catchError(
                  (e, s) => L.e('Gagal navigasi alasan berhenti: $e $s'),
                ),
              ),
              child: const Text('Kelola'),
            ),
          ),
        ],
      ),
    ),
  );
}
```

### 2. Navigasi Pintasan dengan Error Handling (Dashboard → SOS Craving)
```dart
Widget _buildCardSosCraving() {
  return Card(
    child: InkWell(
      onTap: () => unawaited(
        Nav.to(context, const SosCravingScreen()).catchError(
          (Object e, StackTrace s) {
            L.e('Gagal navigasi ke SOS Craving: $e $s');
            return null;
          },
        ),
      ),
      borderRadius: BorderRadius.circular(12),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(CupertinoIcons.exclamationmark_triangle_fill, color: Colors.orange, size: 32),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text('SOS Craving', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Tekan saat menginginkan rokok', style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
            Icon(CupertinoIcons.chevron_right),
          ],
        ),
      ),
    ),
  );
}
```

### 3. FilterChip Pilihan Cepat dengan Logging (Form Alasan Berhenti)
```dart
class _FormAlasanBerhentiState extends State<FormAlasanBerhenti> {
  final _snippetPilihan = [
    'Kesehatan saya dan keluarga',
    'Menghemat uang',
    'Tidak ingin jadi percontoh buruk anak',
    'Bersih dari ketergantungan',
    'Naik kesehatan fisik',
    'Menghindari penyakit jantung/paru',
    'Untuk masa depan yang lebih baik',
    'Janji kepada orang tersayang',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _snippetPilihan.map((snippet) {
        final terpilih = _teksController.text == snippet;
        // Log variabel terkait dalam satu pemanggilan
        L.i('snippet=$snippet, terpilih=$terpilih');
        
        return FilterChip(
          label: Text(snippet),
          selected: terpilih,
          onSelected: (dipilih) {
            // Log perubahan pilihan
            L.i('snippet dipilih=$snippet, dipilih=$dipilih');
            setState(() {
              _teksController.text = dipilih ? snippet : '';
            });
          },
        );
      }).toList(),
    );
  }
}
```

### 4. Kartu Motivasi di SOS Craving (Akses Data Opsional)
```dart
Widget _buildKartuAlasanBerhenti(WidgetRef ref) {
  final alasanAsync = ref.watch(alasanBerhentiProvider);
  final listAlasan = alasanAsync.asData?.value.listAlasan ?? <AlasanBerhentiModel>[];
  L.i('listAlasan.length=${listAlasan.length}');

  if (listAlasan.isEmpty) {
    L.w('tidak ada alasan berhenti, tampilkan placeholder');
    return const _PlaceholderAlasanBerhenti();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 8,
    children: [
      Text('Alasan Saya Berhenti', style: Theme.of(context).textTheme.titleMedium),
      ...listAlasan.take(3).map((alasan) => Card(
        child: ListTile(
          leading: const Icon(CupertinoIcons.heart_fill, color: Colors.red),
          title: Text(alasan.teks),
        ),
      )),
    ],
  );
}
```

## Penjelasan
1. **`asData?.value ?? fallback`** → akses data async opsional tanpa crash saat loading/error.
2. **`unawaited(Nav.to(...).catchError(...))`** → navigasi non-blocking, error di-log via `L.e`.
3. **Logging tergabung** → `L.i('snippet=$snippet, terpilih=$terpilih')` satu log untuk variabel terkait.
4. **Early return `SizedBox.shrink()` + `L.w`** → handle data kosong graceful tanpa error.
5. **FilterChip stateful** → log saat render dan saat user ubah pilihan.