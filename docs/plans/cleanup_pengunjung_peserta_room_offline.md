# Rencana: Cleanup Otomatis Pengunjung & Peserta Room Saat User Offline

## 1. Tujuan

Memastikan ketika user offline, menutup aplikasi, atau session berakhir:

- **Pengunjung room** → dihapus dari Supabase
- **Peserta room** → `id_pengguna` dikosongkan (`NULL`), slot tetap terjaga

Dengan safety net berupa database timeout 20 menit dan antrian lokal untuk offline.

---

## 2. Kondisi Saat Ini

- `RoomRuangPage.initState()` sudah mendaftarkan user sebagai pengunjung room
- `_ubahPeserta()` sudah mengubah user menjadi peserta room
- `HeartbeatNotifier` sudah update `terakhir_online` setiap 10 menit
- Belum ada mekanisme cleanup saat user offline/kill app/logout
- Belum ada app lifecycle listener atau session listener untuk cleanup

---

## 3. Perilaku yang Diharapkan

| Kondisi                      | Pengunjung Room                      | Peserta Room                         |
| ---------------------------- | ------------------------------------ | ------------------------------------ |
| App di-hide/detach           | Hapus                                | Kosongkan `id_pengguna`              |
| Session berakhir             | Hapus                                | Kosongkan `id_pengguna`              |
| User keluar dari room manual | Hapus                                | Kosongkan `id_pengguna`              |
| Offline saat cleanup         | Di-queue, proses saat online kembali | Di-queue, proses saat online kembali |
| Timeout 20 menit             | Hapus via SQL                        | Kosongkan via SQL                    |

---

## 4. Dampak Perubahan

### 4.1 Model

- `PengunjungRoomModel` — tidak ada perubahan
- `PesertaRoomModel` — tidak ada perubahan (`idPengguna` sudah nullable)
- Model queue cleanup baru untuk menampung cleanup yang tertunda

### 4.2 SQL

- Tambah fungsi PostgreSQL `bersihkan_kehadiran_room_offline()`
- Scheduler untuk menjalankan fungsi setiap 10 menit

### 4.3 Notifier

- `PengunjungRoomNotifier` — method `hapusPengunjung` sudah ada
- `PesertaRoomNotifier` — perlu tambah method `kosongkanPeserta` dan `kosongkanSemuaPesertaUntukUser`

### 4.4 UI

- `RoomRuangPage` — tambah lifecycle listener, session listener, dan cleanup method dengan offline handling

---

## 5. Rencana Detail Implementasi

### Tahap 1 — Method Baru di `PesertaRoomNotifier`

**File:** `lib/fitur/room/notifier/peserta_room_notifier.dart`

Tambah 2 method:

1. `kosongkanPeserta(String id)` — mengosongkan satu peserta berdasarkan ID slot
2. `kosongkanSemuaPesertaUntukUser(String idPengguna)` — mengosongkan semua slot user

Pola:

- Ambil state lama
- Update state lokal dengan `copyWith(idPengguna: null)`
- `upsert` ke Supabase via `DbSupabase.perbaruiById`
- Rollback state jika gagal

---

### Tahap 2 — Model dan Service Queue Cleanup

**File baru 1:** `lib/fitur/room/model/cleanup_room_queue_model.dart`

- Model `CleanupRoomQueueModel` dengan `id`, `userId`, `createdAt`

**File baru 2:** `lib/fitur/room/service/cleanup_room_queue_service.dart`

- Service untuk simpan/ambil/hapus queue dari `SharedPreferences`
- Method: `tambah`, `ambilSemua`, `hapus`, `bersihkan`

---

### Tahap 3 — Implementasi Cleanup di `RoomRuangPage`

**File:** `lib/fitur/room/page/room_ruang_page.dart`

#### 3.1 Tambah App Lifecycle Listener

- `AppLifecycleListener` di `initState`
- `onHide` dan `onDetach` memanggil `_bersihkanKehadiranUser()`
- Dispose listener di `dispose()`

#### 3.2 Tambah Session Listener

- `ref.listenManual<SessionState?>(sessionProvider, ...)`
- Jika session menjadi `null` dari non-null, panggil cleanup

#### 3.3 Method `_bersihkanKehadiranUser()`

- Ambil `userId` dari `_idPenggunaAktif`
- Cek koneksi via `KoneksiInternetService.cekKoneksi()`
- Jika online: langsung cleanup ke Supabase
- Jika offline: simpan ke queue cleanup

#### 3.4 Method `_lakukanCleanupKeSupabase(userId)`

- Hapus semua `pengunjung_room` untuk user via `PengunjungRoomNotifier.hapusPengunjung`
- Kosongkan semua `peserta_room` untuk user via `PesertaRoomNotifier.kosongkanPeserta`

#### 3.5 Method `_prosesQueueCleanup()`

- Ambil semua queue cleanup dari `CleanupRoomQueueService`
- Proses satu per satu ke Supabase
- Hapus dari queue setelah berhasil

#### 3.6 Listener Koneksi

- `KoneksiInternetService.addListener` untuk proses queue saat koneksi kembali

---

### Tahap 4 — Database Timeout (Supabase)

**File:** `sql/setup_dummy_tables.sql`

#### 4.1 Fungsi PostgreSQL

Buat fungsi `bersihkan_kehadiran_room_offline()`:

- `DELETE FROM pengunjung_room` untuk user dengan `terakhir_online < NOW() - INTERVAL '20 minutes'`
- `UPDATE peserta_room SET id_pengguna = NULL` untuk user dengan `terakhir_online < NOW() - INTERVAL '20 minutes'`

#### 4.2 Scheduler

- Setup `pg_cron` atau Supabase Edge Function dengan cron setiap 10 menit
- Jika `pg_cron` tidak tersedia, gunakan scheduler eksternal

---

### Tahap 5 — Testing

- Test kill app → data ter-cleanup
- Test logout → data ter-cleanup
- Test minimize app → data ter-cleanup
- Test offline → data masuk queue, terproses saat online
- Test SQL timeout → data ter-cleanup setelah 20 menit

---

## 6. Urutan Eksekusi

| Urutan | Tahap                                                                 | File                                                     |
| ------ | --------------------------------------------------------------------- | -------------------------------------------------------- |
| 1      | Tambah method `kosongkanPeserta` dan `kosongkanSemuaPesertaUntukUser` | `lib/fitur/room/notifier/peserta_room_notifier.dart`     |
| 2      | Buat model queue cleanup                                              | `lib/fitur/room/model/cleanup_room_queue_model.dart`     |
| 3      | Buat service queue cleanup                                            | `lib/fitur/room/service/cleanup_room_queue_service.dart` |
| 4      | Implementasi lifecycle + session listener + cleanup method            | `lib/fitur/room/page/room_ruang_page.dart`               |
| 5      | Buat fungsi PostgreSQL cleanup                                        | `sql/setup_dummy_tables.sql`                             |
| 6      | Setup scheduler                                                       | Supabase Dashboard / Edge Function                       |
| 7      | Testing                                                               | Manual testing                                           |

---

## 7. Catatan Risiko

| Risiko                                              | Dampak                                | Mitigasi                                |
| --------------------------------------------------- | ------------------------------------- | --------------------------------------- |
| `AppLifecycleState.detached` tidak selalu dipanggil | Data menumpuk sementara               | SQL timeout 20 menit sebagai safety net |
| User offline saat cleanup                           | Cleanup tertunda                      | Queue lokal, diproses saat online       |
| Heartbeat terlewat                                  | `terakhir_online` menyesatkan         | Timeout 20 menit > heartbeat 10 menit   |
| Multiple device login                               | Satu cleanup mempengaruhi device lain | Tambah `device_id` jika perlu           |
| Queue cleanup menumpuk                              | Performa saat online kembali          | Proses batch, batasi jumlah             |

---

## 8. Catatan untuk Berikutnya

- Tidak ada perubahan model yang diperlukan karena `idPengguna` sudah nullable
- Semua perubahan kode tetap mengikuti aturan proyek
- Tidak ada perubahan kode dalam sesi plans ini
- Setiap perubahan kode nanti wajib melalui `flutter analyze` dan verifikasi manual
