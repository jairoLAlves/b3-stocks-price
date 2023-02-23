import 'package:flutter/material.dart';

import '../model/Item_menu_principal_model.dart';
import 'package:provider/provider.dart';

import '../providers/menu_principal_provider.dart';

class ItemMenuPrincipal extends StatelessWidget {
  final ItemMenuPrincipalModel item;
  final bool isSelected;
  final void Function() onTap;
  final AnimationController animatedController;

  const ItemMenuPrincipal({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.animatedController,
  });

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
            valueListenable: controllerMenu.progressAnimated,
            builder: (context, value, child) {
              return Container(
                // width: animationWidth.controllerMenu,
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  //color: Theme.of(context).colorScheme.background,
                  elevation: isSelected ? 5 : 0,
                  child: Row(
                    children: [
                      Icon(
                        item.icon,
                        size: 38,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      if (value >= 0.6 && animatedController.isAnimating ||
                          controllerMenu.isCollapsedMenu.value &&
                              !animatedController.isAnimating)
                        AnimatedContainer(
                          curve: Curves.linearToEaseOut,
                          duration: const Duration(milliseconds: 1000),
                          child: Text(
                            item.title,
                            style: isSelected
                                ? TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                : const TextStyle(),
                          ),
                        )
                    ],
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
