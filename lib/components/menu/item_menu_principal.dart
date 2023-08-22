import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../model/Item_menu_principal_model.dart';
import 'package:provider/provider.dart';

import '../../providers/menu_principal_provider.dart';

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
    return Icon(
      icon,
      color: selected
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).colorScheme.surfaceTint,
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
        return Container(
          //duration: controllerMenu.controllerMenu.duration!,
          // width: controllerMenu.animationMenu.value,
          child: Card(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            //color: Theme.of(context).colorScheme.background,
            elevation: isSelected ? 5 : 0,
            child: Container(
              child: AnimatedCrossFade(
                duration: const Duration(seconds: 1),
                crossFadeState: controllerMenu.animatedCrossFadeState(),
                firstChild: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //icone
                    iconTitleMenu(context, item.icon, isSelected),
                    titleIntemMenu(
                      context,
                      item.title,
                      isSelected,
                    ),
                  ],
                ),
                secondChild: Container(
                  alignment: Alignment.center,
                  // width: controllerMenu.animationMenu.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      iconTitleMenu(context, item.icon, isSelected),
                      titleIntemMenu(context, item.title, isSelected),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
