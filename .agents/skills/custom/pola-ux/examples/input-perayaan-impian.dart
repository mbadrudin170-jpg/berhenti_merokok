// commit: c7337d1519d495d0ccd022fb18d63f72d443866a
// Input: Perayaan pencapaian impian (toast berulang, tanpa persist)

void perayaanSalah(String impianId, String impianNama, double saldo, double target) {
  // SALAH: Toast muncul setiap rebuild, tidak persist
  if (saldo >= target) {
    AppToast.sukses(context, 'Selamat! Impian "$impianNama" telah tercapai!');
  }
}