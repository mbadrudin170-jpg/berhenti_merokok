import 'package:berhenti_merokok/fitur/dummy/screens/dummy_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_global_saya/core_shared.dart';

class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTombolCustom(() => Nav.to(context, DummyScreen()), 'Dummy'),
      ],
    );
  }

  Widget _buildTombolCustom(VoidCallback ontap, String title) {
    return ListTile(
      onTap: ontap,
      title: Text(title),
      trailing: Icon(CupertinoIcons.chevron_right),
    );
  }
}
