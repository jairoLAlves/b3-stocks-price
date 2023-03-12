
import 'package:flutter/material.dart';

class ItemInfoExpansionPanelModel {
  String title;
  Widget body;
  bool isExpanded;

  ItemInfoExpansionPanelModel({
    required this.title,
    this.isExpanded = false,
    required this.body,
  });
}
