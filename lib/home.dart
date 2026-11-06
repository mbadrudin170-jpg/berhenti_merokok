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

  final List<Widget> _pages = [const DashboardScreen(), const LainnyaScreen()];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
