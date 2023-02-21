import 'package:flutter/material.dart';

import '../model/Item_menu_principal_model.dart';

class ItemMenuPrincipal extends StatefulWidget {
  final ItemMenuPrincipalModel item;
  final AnimationController animationController;

  const ItemMenuPrincipal({
    super.key,
    required this.item,
    required this.animationController,
  });

  @override
  State<ItemMenuPrincipal> createState() => _ItemMenuPrincipalState();
}

class _ItemMenuPrincipalState extends State<ItemMenuPrincipal> {
  late Animation<double> widthAnimation;
  @override
  void initState() {
    super.initState();
    widthAnimation =
        Tween<double>(begin: 150, end: 50).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.item.onTap,
      child: Container(
        width: widthAnimation.value,
        child: Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          color: Theme.of(context).colorScheme.background,
          elevation: widget.item.isSelected ? 5 : 0,
          child: Row(
            children: [
              Icon(
                widget.item.icon,
                size: 38,
                color: widget.item.isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
              if (widthAnimation.value > 110) ...[
                const SizedBox(
                  width: 20,
                ),
                Text(widget.item.title),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
