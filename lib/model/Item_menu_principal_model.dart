import 'package:flutter/material.dart';

class ItemMenuPrincipalModel {
  final String title;
  final IconData icon;
  final int index;
  final bool isSelected;
  final void Function() onTap;
  static int indexSelected = 0;

  ItemMenuPrincipalModel({
    required this.title,
    required this.icon,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  bool get getIsSelected => index == ItemMenuPrincipalModel.indexSelected;
}
