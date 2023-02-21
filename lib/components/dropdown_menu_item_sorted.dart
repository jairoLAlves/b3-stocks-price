import 'package:flutter/material.dart';

import '../util/enums.dart';

DropdownMenuItem<StocksSortBy> dropdownMenuItemSorted({
  required StocksSortBy value,
  bool enabled = true,
}) {
  return DropdownMenuItem(
    value: value,
    enabled: enabled,
    child: Card(
      // color: Colors.white,
      elevation: 2,
      child: Container(
        alignment: Alignment.center,
        child: ListTile(title: Text(value.name)),
      ),
    ),
  );
}
