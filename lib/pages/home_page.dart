import 'package:b3_price_stocks/routes/routes_pages.dart';
import 'package:flutter/material.dart';

import '../components/item_menu_principal.dart';
import '../components/navigation_drawer_principal.dart';
import '../model/Item_menu_principal_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool bigSize = MediaQuery.of(context).size.width >= 640;
    return Scaffold(
      drawer: bigSize ? null :  const NavigationDrawerPrincipal(),
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
