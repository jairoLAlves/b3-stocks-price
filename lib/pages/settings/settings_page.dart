import 'package:flutter/material.dart';

import '../../components/menu/navigation_drawer_principal.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool bigSize = MediaQuery.of(context).size.width >= 640;
    return Scaffold(
      drawer: bigSize ? null : const NavigationDrawerPrincipal(),
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Row(
        children: [
          if (bigSize) const NavigationDrawerPrincipal(),
          Column(),
        ],
      ),
    );
  }
}
