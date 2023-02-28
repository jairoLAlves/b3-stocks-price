import 'package:flutter/material.dart';
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

class _NavigationDrawerPrincipalState extends State<NavigationDrawerPrincipal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController;
  late final MenuPrincipalProvider controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<MenuPrincipalProvider>();
    _animatedController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _animatedController.addListener(() {
      controller.progressAnimated.value = _animatedController.value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animatedController.dispose();
  }

  Widget buildHeader(BuildContext context) => Container(
        child: Column(
          children: const [],
        ),
      );

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

    return Consumer<MenuPrincipalProvider>(builder: (context, value, _) {
      return AnimatedContainer(
        curve: Curves.easeInBack,
        duration: Duration(seconds: 1),
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        width: value.isCollapsedMenu.value ? value.maxWidth : value.minWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildHeader(context),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Container();
                },
                itemCount: intensMenuPrincipal.length,
                itemBuilder: (context, index) => ItemMenuPrincipal(
                  //key: ObjectKey(index),
                  item: intensMenuPrincipal[index],
                  isSelected: index == value.currentSelectedIndex.value,
                  animatedController: _animatedController,

                  onTap: () {
                    setState(() {
                      value.currentSelectedIndex.value = index;
                    });
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () => setState(() {
                value.isCollapsedMenu.value = !value.isCollapsedMenu.value;
                value.isCollapsedMenu.value
                    ? _animatedController.forward()
                    : _animatedController.reverse();
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _animatedController,
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
