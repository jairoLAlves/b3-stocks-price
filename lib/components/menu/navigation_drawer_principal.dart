import 'package:flutter/material.dart';

import '../../model/Item_menu_principal_model.dart';
import '../../providers/menu_principal_provider.dart';
import '../../routes/routes_pages.dart';
import 'icon_light_or_dart.dart';
import 'item_menu_principal.dart';
import 'package:provider/provider.dart';

class NavigationDrawerPrincipal extends StatefulWidget {
  const NavigationDrawerPrincipal({super.key});

  @override
  State<NavigationDrawerPrincipal> createState() =>
      _NavigationDrawerPrincipalState();
}

class _NavigationDrawerPrincipalState extends State<NavigationDrawerPrincipal>
    with TickerProviderStateMixin {
  late final MenuPrincipalProvider controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<MenuPrincipalProvider>();

    controller.controllerMenu = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller.controllerIconMenu = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<ItemMenuPrincipalModel> intensMenuPrincipal = [
      ItemMenuPrincipalModel(
        title: 'Dashboard',
        icon: Icons.insert_chart,
        onTap: () {
          setState(() {
            Navigator.of(context).pushReplacementNamed(RoutesPages.home);
          });
        },
      ),
      ItemMenuPrincipalModel(
        title: 'Search',
        icon: Icons.search,
        onTap: () {
          setState(() {
            Navigator.of(context)
                .pushReplacementNamed(RoutesPages.stocksSearch);
          });
        },
      ),
      ItemMenuPrincipalModel(
        title: 'Settings',
        icon: Icons.settings,
        onTap: () {
          setState(() {
            Navigator.of(context).pushReplacementNamed(RoutesPages.settings);
          });
        },
      ),
    ];

    return Consumer<MenuPrincipalProvider>(
        builder: (context, controllerMenu, _) {
      return ValueListenableBuilder(
        valueListenable: controllerMenu.isCollapsedMenu,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Container();
                },
                itemCount: intensMenuPrincipal.length,
                itemBuilder: (context, index) => ItemMenuPrincipal(
                  //key: ObjectKey(index),
                  item: intensMenuPrincipal[index],
                  isSelected:
                      index == controllerMenu.currentSelectedIndex.value,

                  onTap: () {
                    setState(() {
                      controllerMenu.currentSelectedIndex.value = index;
                    });
                  },
                ),
              ),
            ),
            // Icon LightOrDart
            const IconLightOrDart(),
            // Icon expanded  Menu
            InkWell(
              onTap: () {
                setState(() {
                  controllerMenu.animatedMenu();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: controllerMenu.controllerIconMenu,
                  )
                ],
              ),
            )
          ],
        ),
        builder: (context, value, child) {
          return AnimatedContainer(
            duration: controllerMenu.controllerMenu.duration!,
            color: Theme.of(context).colorScheme.surface,
            height: MediaQuery.of(context).size.height,
            width: controllerMenu.widthMenu(), //controllerMenu.widthMenu(),
            child: child,
          );
        },
      );
    });
  }
}
