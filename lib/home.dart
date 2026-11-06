import 'package:berhenti_merokok/fitur/dashboard/screens/dashboard_screen.dart';
import 'package:berhenti_merokok/lainnya_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int _selectedIndex = 0;

  // Tab yang sudah pernah dibuka; awalnya hanya tab 0 (Dashboard).
  final Set<int> _tabTerbuka = {0};

  // GlobalKey per tab agar currentState tetap dapat diakses untuk
  // fitur scroll-to-top setelah tab dibuka. LainnyaScreen adalah
  // StatelessWidget sehingga key-nya tidak bertipe State.
  final GlobalKey _kunciDashboard = GlobalKey();
  final GlobalKey _kunciLainnya = GlobalKey();

  // Waktu tap terakhir untuk deteksi double-tap pada tab aktif.
  DateTime? _lastTapTime;
  static const Duration _durasiDoubleTap = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _saatPilihTab(int i) {
    final sekarang = DateTime.now();
    final lastTap = _lastTapTime;
    final tabSama = i == _selectedIndex;
    final doubleTap =
        tabSama && lastTap != null && sekarang.difference(lastTap) <= _durasiDoubleTap;
    if (doubleTap) {
      _scrollKeAtas(i);
      _lastTapTime = null;
      return;
    }
    if (!tabSama) {
      setState(() {
        _tabTerbuka.add(i);
        _selectedIndex = i;
      });
    }
    _lastTapTime = sekarang;
  }

  void _scrollKeAtas(int i) {
    // Periksa state == null terlebih dahulu (tab belum dibuka) agar tidak crash.
    final state = switch (i) {
      0 => _kunciDashboard.currentState,
      _ => _kunciLainnya.currentState,
    };
    if (state == null) {
      return;
    }
    // Hanya panggil scrollToTop() apabila state mengimplementasikan
    // ScrollKeAtas; pada proyek ini layar tab belum menyediakannya.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: List<Widget>.generate(2, (i) {
          if (!_tabTerbuka.contains(i)) {
            return const SizedBox.shrink();
          }
          return switch (i) {
            0 => DashboardScreen(key: _kunciDashboard),
            _ => LainnyaScreen(key: _kunciLainnya),
          };
        }),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _saatPilihTab,
        destinations: [
          NavigationDestination(
            icon: const Icon(CupertinoIcons.home),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: const Icon(CupertinoIcons.ellipsis),
            label: 'Lainnya',
          ),
        ],
      ),
    );
  }
}
