import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:flutter/material.dart';

import '../model/stock.dart';
import '../interfaces/stocks_interface.dart';
import '../repository/stocks_repository.dart';
import '../util/enums.dart';

class StocksProvider with ChangeNotifier {
  final IStocks _repository = StocksRepository();
  List<Stock> _stoks = <Stock>[];

  List<Stock> getAllStocks() {
    return [..._stoks];
  }

  Future<List<Stock>> updateStocks() async {
    final listaStocks = await _repository.getAllStocks();
    _stoks = listaStocks.stocks ?? _stoks;
    return _stoks;
  }

  // sortOrderStocks(StocksSortBy stocksSortBy, {bool sortOrder = true}) {
  //   _stoks.sortedBy(stocksSortBy);
  //   notifyListeners();
  // }

  List<Stock> filterListStocks(sectors sector) {
    return [..._stoks].where((element) {
      if (sector != sectors.All) {
        var sectorAtual = element.sector;

        var sectorParm =
            sector.name.toLowerCase().replaceAll('_', ' ').replaceAll('-', ' ');

        return sectorAtual.contains(sectorParm);
      } else {
        return true;
      }
    }).toList();
  }

  List<Stock> searchStockFilter(String value, [sectors sector = sectors.All]) {
    return filterListStocks(sector).where((element) {
      return element.stock.contains(value.toUpperCase());
    }).toList();
  }
}
