import 'package:flutter/material.dart';

import '../util/enums.dart';

DropdownMenuItem<StocksSortBy> dropdownMenuItemSorted({
  required BuildContext context,
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
        child: Text(
          value.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    ),
  );
}
