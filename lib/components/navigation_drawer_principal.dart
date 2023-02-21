import 'package:flutter/material.dart';

import '../model/Item_menu_principal_model.dart';
import '../routes/routes_pages.dart';
import 'item_menu_principal.dart';

class NavigationDrawerPrincipal extends StatefulWidget {
  const NavigationDrawerPrincipal({super.key});

  @override
  State<NavigationDrawerPrincipal> createState() =>
      _NavigationDrawerPrincipalState();
}

class _NavigationDrawerPrincipalState extends State<NavigationDrawerPrincipal>
    with SingleTickerProviderStateMixin {
  final double maxWidth = 150.0;
  final double minWidth = 50.0;
  late AnimationController _animationController;
  late Animation<double> widthAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  bool isExpanded = false;
  void setIsExpanded() => setState(() {
        isExpanded = !isExpanded;
        isExpanded
            ? _animationController.forward()
            : _animationController.reverse();
      });

  Widget buildHeader(BuildContext context) => Container(
        height: 20,
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: const [],
        ),
      );

  @override
  Widget build(BuildContext context) {
    //final bool isExpanded = MediaQuery.of(context).size.width >= 640;

    final List<ItemMenuPrincipalModel> intensMenuPrincipal = [
      ItemMenuPrincipalModel(
        title: 'Home',
        icon: Icons.home,
        index: 0,
        isSelected: ItemMenuPrincipalModel.indexSelected == 0,
        onTap: () {
          if (ItemMenuPrincipalModel.indexSelected != 0) {
            //Navigator.pop(context);
            Navigator.of(context).pushReplacementNamed(RoutesPages.HOME);
            ItemMenuPrincipalModel.indexSelected = 0;
          }
        },
      ),
      ItemMenuPrincipalModel(
        title: 'Search',
        icon: Icons.search,
        index: 1,
        isSelected: ItemMenuPrincipalModel.indexSelected == 1,
        onTap: () {
          if (ItemMenuPrincipalModel.indexSelected != 1) {
            //Navigator.pop(context);
            Navigator.of(context)
                .pushReplacementNamed(RoutesPages.STOCKSSEARCH);
            ItemMenuPrincipalModel.indexSelected = 1;
          }
        },
      ),
    ];

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          color: Theme.of(context).colorScheme.surfaceVariant,
          height: MediaQuery.of(context).size.height,
          width: widthAnimation.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildHeader(context),
              Expanded(
                child: ListView.builder(
                  itemCount: intensMenuPrincipal.length,
                  itemBuilder: (context, index) => ItemMenuPrincipal(
                    item: intensMenuPrincipal[index],
                    animationController: _animationController,
                  ),
                ),
              ),
              InkWell(
                onTap: setIsExpanded,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isExpanded
                          ? Icons.keyboard_double_arrow_right
                          : Icons.keyboard_double_arrow_left,
                      size: 38,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
