// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../model/stock.dart';

class ItemListStockController extends ChangeNotifier {
  Stock stock;

  ItemListStockController(
    this.stock,
  );

  ValueNotifier<bool> isExpandedGraphic = ValueNotifier<bool>(false);
  ValueNotifier<double> heightGraphic = ValueNotifier<double>(0);

  

  void showGraphic() {
    isExpandedGraphic.value = !isExpandedGraphic.value;

    if (isExpandedGraphic.value) {
      heightGraphic.value = 146;
    } else {
      heightGraphic.value = 0;
    }
    notifyListeners();
  }
}
