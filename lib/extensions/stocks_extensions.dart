import 'package:b3_price_stocks/model/historical_data_price.dart';
import 'package:b3_price_stocks/model/stock.dart';
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

extension GetListNumFilter on List<HistoricalDataPrice> {
  List<num> getListNumFilter(
      [PriceTipes priceTipes = PriceTipes.close, bool isReversed = true]) {
    var listaRetorno = <num>[];
    var listaNull = <num?>[];

    switch (priceTipes) {
      case PriceTipes.close:
        listaNull = map((numero) {
          return numero.close;
        }).toList();

        break;

      case PriceTipes.open:
        listaNull = map((numero) {
          return numero.open;
        }).toList();

        break;

      case PriceTipes.high:
        listaNull = map((numero) {
          return numero.high;
        }).toList();

        break;

      case PriceTipes.low:
        listaNull = map((numero) {
          return numero.low;
        }).toList();

        break;
    }

    //print(listaNull);

    listaRetorno = listaNull.whereType<num>().toList();

    if (isReversed) listaRetorno.reversed;

    return listaRetorno;
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
