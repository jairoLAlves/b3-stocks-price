import 'package:flutter/material.dart';
import '../../components/navigation_drawer_principal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool bigSize = MediaQuery.of(context).size.width >= 640;
    return Scaffold(
      drawer: bigSize ? null : const NavigationDrawerPrincipal(),
      appBar: bigSize ? null : AppBar(),
      body: Row(
        children: [
          if (bigSize) const NavigationDrawerPrincipal(),
          Column(),
        ],
      ),
    );
  }
}
