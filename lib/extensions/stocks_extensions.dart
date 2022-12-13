import 'package:b3_price_stocks/model/stock.dart';
import 'package:b3_price_stocks/providers/stocks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/enums.dart';
import 'package:collection/collection.dart';

extension SortOrderStocks on List<Stock> {
  void sortOrderStocks(StocksSortBy stocksSortBy, {bool sortOrder = true}) {
    switch (stocksSortBy) {
      case StocksSortBy.name:
        sort((a, b) => compareAsciiUpperCase(a.name, b.name));
        break;

      case StocksSortBy.close:
        sortOrder = !sortOrder;
        sort((a, b) {
          var close1 = a.close;
          var close2 = b.close;
          return close1.compareTo(close2);
        });
        break;

      case StocksSortBy.change:
        sortOrder = !sortOrder;
        sort((a, b) {
          var change1 = a.change;
          var change2 = b.change;

          return change1.compareTo(change2);
        });
        break;

      case StocksSortBy.volume:
        sortOrder = !sortOrder;
        sort((a, b) {
          var volume1 = a.volume;
          var volume2 = b.volume;

          return volume1.compareTo(volume2);
        });
        break;

      case StocksSortBy.market_cap_basic:
        sortOrder = !sortOrder;
        sort((a, b) {
          var market_cap1 = a.market_cap;
          var market_cap2 = b.market_cap;

          return market_cap1.compareTo(market_cap2);
        });
        break;

      case StocksSortBy.sector:
        sort((a, b) => compareAsciiUpperCase(a.sector, b.sector));

        break;
      case StocksSortBy.stock:
        sort((a, b) => compareAsciiUpperCase(a.stock, b.stock));
        break;
    }

    if (!sortOrder) {
      final listaTemp = <Stock>[...this];
      clear();
      addAll(listaTemp.reversed.toList());
    }
  }
}

extension GetstockSymbolList on List<Stock> {
  List<String> stockSymbolList() {
    final stockSymbol = <String>[];
    for (var element in this) {
      stockSymbol.add(element.stock);
    }

    return stockSymbol;
  }
}

extension GetfilterStockSymbol on List<Stock> {
  List<String> filterStockSymbol(String stockName) {
    return stockSymbolList().where((stock) {
      return stock.startsWith(stockName.toUpperCase(), 0);
    }).toList();
  }
}
