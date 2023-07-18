import 'package:b3_price_stocks/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../model/Item_menu_principal_model.dart';
import '../providers/menu_principal_provider.dart';
import '../routes/routes_pages.dart';
import 'item_menu_principal.dart';
import 'package:provider/provider.dart';

class NavigationDrawerPrincipal extends StatefulWidget {
  const NavigationDrawerPrincipal({super.key});

  @override
  State<NavigationDrawerPrincipal> createState() =>
      _NavigationDrawerPrincipalState();
}

class _NavigationDrawerPrincipalState extends State<NavigationDrawerPrincipal> {
  late final MenuPrincipalProvider controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<MenuPrincipalProvider>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    
    bool bigSize = MediaQuery.of(context).size.width >= 640;

    final List<ItemMenuPrincipalModel> intensMenuPrincipal = [
      ItemMenuPrincipalModel(
        title: 'Dashboard',
        icon: Icons.insert_chart,
        onTap: () {
          setState(() {
            Navigator.of(context).pushReplacementNamed(RoutesPages.HOME);
          });
        },
      ),
      ItemMenuPrincipalModel(
        title: 'Search',
        icon: Icons.search,
        onTap: () {
          setState(() {
            Navigator.of(context)
                .pushReplacementNamed(RoutesPages.STOCKSSEARCH);
          });
        },
      ),
      ItemMenuPrincipalModel(
        title: 'Settings',
        icon: Icons.settings,
        onTap: () {
          setState(() {
            Navigator.of(context).pushReplacementNamed(RoutesPages.SETTINGS);
          });
        },
      ),
    ];

    return Consumer<MenuPrincipalProvider>(
        builder: (context, controllerMenu, _) {
      return AnimatedContainer(
        duration: 1000.ms,
        color: Theme.of(context).colorScheme.surface,
        height: MediaQuery.of(context).size.height,
        width: controllerMenu.isCollapsedMenu.value
            ? controllerMenu.maxWidth
            : controllerMenu.minWidth,
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
            ValueListenableBuilder<bool>(
              valueListenable: ThemeController.instance.themeLightOrDart,
              builder: (context, value, child) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: value
                            ? const Icon(Icons.light_mode)
                            : const Icon(Icons.dark_mode),
                        onPressed: () {
                          setState(() =>
                              ThemeController.instance.changeTheme(!value));
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            InkWell(
              onTap: () => setState(() {
                controllerMenu.isCollapsedMenu.value =
                    !controllerMenu.isCollapsedMenu.value;
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.surfaceTint,
                  )
                      .animate(
                        target: controllerMenu.isCollapsedMenu.value ? 1 : 0,
                      )
                      .rotate(duration: 1000.ms)
                      .swap(
                    builder: (context, child) {
                      return Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.onSurface,
                      ).animate();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
