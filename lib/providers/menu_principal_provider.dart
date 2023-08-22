import 'package:b3_price_stocks/controllers/theme_controller.dart';
import 'package:flutter/material.dart';

class MenuPrincipalProvider with ChangeNotifier {


  late AnimationController controllerMenu;

  late AnimationController controllerIconMenu;

  late AnimationController controllerIconLightOrDart;

  late Animation<double> animationMenu =
      Tween(begin: 120.0, end: 150.0).animate(controllerMenu);

  late Animation<double> animationMenuIcon =
      Tween(begin: 0.0, end: 1.0).animate(controllerIconMenu);

  late Animation<double> animationMenuIconLightOrDart =
      Tween(begin: 0.0, end: 1.0).animate(controllerIconLightOrDart);

  ValueNotifier<int> currentSelectedIndex = ValueNotifier<int>(0);
  ValueNotifier<bool> isCollapsedMenu = ValueNotifier<bool>(false);

  double widthMenu() => !isCollapsedMenu.value ? 120.0 : 150.0;

  animatedMenu() {
    isCollapsedMenu.value = !isCollapsedMenu.value;
    animatedMenuWidth();
    animatedMenuIcon();
  }

  animatedMenuWidth() => isCollapsedMenu.value
      ? controllerMenu.forward()
      : controllerMenu.reverse();

  animatedMenuIcon() => isCollapsedMenu.value
      ? controllerIconMenu.forward()
      : controllerIconMenu.reverse();

  animatedLightDartIcon() {
    ThemeController.instance.themeLightOrDart.value
        ? controllerIconLightOrDart.forward()
        : controllerIconLightOrDart.reverse();

    ThemeController.instance
        .changeTheme(!ThemeController.instance.themeLightOrDart.value);
  }

  animatedIconLightOrDartCrossFadeState() =>
      ThemeController.instance.themeLightOrDart.value
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond;

  animatedCrossFadeState() => isCollapsedMenu.value
      ? CrossFadeState.showFirst
      : CrossFadeState.showSecond;
}
