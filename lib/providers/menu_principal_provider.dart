import 'package:flutter/material.dart';

class MenuPrincipalProvider with ChangeNotifier {
  ValueNotifier<int> currentSelectedIndex = ValueNotifier<int>(0);
  ValueNotifier<bool> isCollapsedMenu = ValueNotifier<bool>(false);

  final double maxWidth = 150.0;
  final double minWidth = 95.0;
}
