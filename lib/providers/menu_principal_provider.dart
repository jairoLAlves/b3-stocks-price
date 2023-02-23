import 'package:flutter/material.dart';

class MenuPrincipalProvider with ChangeNotifier {
  ValueNotifier<int> currentSelectedIndex = ValueNotifier<int>(0);
  ValueNotifier<bool> isCollapsedMenu = ValueNotifier<bool>(false);
  ValueNotifier<double> progressAnimated = ValueNotifier<double>(0);

  final double maxWidth = 150;
  final double minWidth = 56;

   
}
