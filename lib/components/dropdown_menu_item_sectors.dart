import 'package:flutter/material.dart';

import '../util/enums.dart';

DropdownMenuItem<sectors> dropdownMenuItemSectors({
  required BuildContext context,
  required sectors value,
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
          value.name.replaceAll('_', ' '),
          style:  Theme.of(context).textTheme.titleMedium,
        ),
      ),
    ),
  );
}
