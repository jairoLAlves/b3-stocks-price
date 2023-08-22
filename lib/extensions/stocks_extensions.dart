// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:b3_price_stocks/model/stock.dart';
import '../model/historical_data_and_chart_semple_date.dart';
import '../util/enums.dart';
import 'package:collection/collection.dart';

extension BullOrBearList on List<double> {
  bool? bullOrBearList() {
    if (isNotEmpty && length >= 2) {
      if (first == last) return null;

      return (first > last) ? false : true;
    }

    return null;
  }
}

extension DividirListaString on List<String> {
  List<List<String>> dividirListaString([int step = 20]) {
    //step numeor de vezes da divisão

    var listRetorno = <List<String>>[];
    int size = length;
    int subDivid = (size ~/ step);

    //print(subDivid);

    for (int index = 0; index < step; index++) {
      if (subDivid == 0) {
        listRetorno.add(sublist(0));
        return listRetorno;
      }

      int start = index * subDivid;
      int end = (index + 1) * subDivid;

      var subLista =
          (index < (step - 1)) ? sublist(start, end) : sublist(start);

      if (subLista.isNotEmpty) listRetorno.add(subLista);
    }

    return listRetorno;
  }
}

extension GetMinMaxMedia on List<HistoricalDataAndChartSampleDate> {
  ({double min, double max, double media}) getMinMaxMedia() {
    List<num> maxList = getListNumFilter(PriceTipes.high, false);
    List<num> minList = getListNumFilter(PriceTipes.low, false);

  

    double _max = 0;
    double _min = 0;

    if (maxList.isNotEmpty) {
       _max = double.parse('${maxList.reduce((a, b) => max(a, b))}');
    }
    if (minList.isNotEmpty) {
       _min = double.parse('${minList.reduce((a, b) => min(a, b))}');
    }

    double media = (_max + _min);

    if (media > 0) media /= 2;

    return (min: _min, max: _max, media: media);
  }
}

extension GetListNumFilter on List<HistoricalDataAndChartSampleDate> {
  List<num> getListNumFilter([
    PriceTipes priceTipes = PriceTipes.close,
    bool isReversed = true,
  ]) {
    List<num> listReturn = switch (priceTipes) {
      PriceTipes.close => map((numero) {
          return numero.close;
        }).toList(),
      PriceTipes.open => map((numero) {
          return numero.open;
        }).toList(),
      PriceTipes.high => map((numero) {
          return numero.high;
        }).toList(),
      PriceTipes.low => map((numero) {
          return numero.low;
        }).toList(),
    }
        .whereType<num>()
        .toList();

    //print(listReturn);

    if (isReversed) listReturn.reversed;

    return listReturn;
  }
}

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
          var marketCap1 = a.market_cap;
          var marketCap2 = b.market_cap;

          return marketCap1.compareTo(marketCap2);
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
