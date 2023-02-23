import 'package:flutter/material.dart';

class ItemMenuPrincipalModel {
  final String title;
  final IconData icon;


  final void Function() onTap;

  ItemMenuPrincipalModel({
    required this.title,
    required this.icon,

    required this.onTap,
  });
}
