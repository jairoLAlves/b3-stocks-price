import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../model/Item_menu_principal_model.dart';
import 'package:provider/provider.dart';

import '../providers/menu_principal_provider.dart';

class ItemMenuPrincipal extends StatelessWidget {
  final ItemMenuPrincipalModel item;
  final bool isSelected;
  final void Function() onTap;

  const ItemMenuPrincipal({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  Widget titleIntemMenu(BuildContext context, String title, bool selected) {
    return AnimatedDefaultTextStyle(
      style: selected
          ? TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            )
          : TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      duration: 1000.ms,
      child: Text(title),
    );
  }

  Widget iconTitleMenu(BuildContext context, IconData icon, bool selected) {
    return Animate(
      target: selected ? 1 : 0,
      delay: 100.ms,
    ).custom(
      begin: 30,
      end: 25,
      builder: (context, value, child) => Icon(
        icon,
        size: value,
        color: selected
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.surfaceTint,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isSelected) item.onTap();
        onTap();
      },
      child: Consumer<MenuPrincipalProvider>(
        builder: (context, controllerMenu, child) {
          return ValueListenableBuilder(
            valueListenable: controllerMenu.isCollapsedMenu,
            builder: (context, value, child) {
              return Container(
                // width: animationWidth.controllerMenu,
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  //color: Theme.of(context).colorScheme.background,
                  elevation: isSelected ? 5 : 0,
                  child: Container(
                    child: controllerMenu.isCollapsedMenu.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //icone
                              iconTitleMenu(context, item.icon, isSelected),
                              titleIntemMenu(context, item.title, isSelected),
                            ],
                          ).animate()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              iconTitleMenu(context, item.icon, isSelected),
                              titleIntemMenu(context, item.title, isSelected),
                            ],
                          ).animate(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
