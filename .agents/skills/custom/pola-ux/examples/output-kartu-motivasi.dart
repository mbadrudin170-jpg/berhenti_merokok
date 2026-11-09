// commit: e6595744b3840998d840e398ca1782e7be7d50b4
// Output: Kartu motivasi dengan akses data async aman & navigasi error handling

Widget buildKartuAlasanBerhenti(WidgetRef ref) {
  final alasanAsync = ref.watch(alasanBerhentiProvider);
  
  // BENAR: Akses aman tanpa blokir UI
  final jumlah = alasanAsync.asData?.value.jumlahAlasan ?? 0;
  L.i('jumlahAlasan=$jumlah');

  // Early return jika data kosong
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

// Navigasi pintasan SOS Craving di dashboard:
Widget buildCardSosCraving() {
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

// FilterChip dengan logging (FormAlasanBerhenti):
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