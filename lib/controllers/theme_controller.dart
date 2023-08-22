import 'package:flutter/foundation.dart';

class ThemeController {
  static final ThemeController instance = ThemeController._();
  ThemeController._();

  final themeLightOrDart = ValueNotifier(true);

  changeTheme(bool value) {
    themeLightOrDart.value = value;
  }
}
