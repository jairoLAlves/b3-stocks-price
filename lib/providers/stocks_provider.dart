import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:b3_price_stocks/model/stock_info_model.dart';
import 'package:flutter/material.dart';

import '../model/stock.dart';
import '../interfaces/stocks_interface.dart';
import '../repository/stocks_repository.dart';
import '../util/enums.dart';

class StocksProvider with ChangeNotifier {
  final IStocks _repository = StocksRepository();
  List<Stock> _stoks = <Stock>[];
  var listaFinal = <StockInfoModel>[];
  List<String> listaStockName = [];

  List<Stock> getAllStocks() {
    return [..._stoks];
  }

  Future<List<Stock>> updateStocks() async {
    final listaStocks = await _repository.getAllStocks();
    _stoks = listaStocks.stocks ?? _stoks;
    listaStockName = _stoks.stockSymbolList();
    getStockInfoAll();
    return _stoks;
  }

  StockInfoModel getStockInfo(String StockSymbol) {
    var listRetorno = listaFinal.firstWhere(
      (stocoInfo) => stocoInfo.symbol == StockSymbol,
      orElse: () => StockInfoModel(),
    );

    return listRetorno;
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

  Future<void> getStockInfoAll() async {
    listaFinal.clear();
    if (listaStockName.isNotEmpty) {
      var listaDividida = listaStockName.dividirListaString(20);

      for (List<String> stock in listaDividida) {
        var resp = await _repository.getAllStocksInfo(symbols: stock);

        listaFinal.addAll([...?resp.results]);
        notifyListeners();
        await Future.delayed(Duration(seconds: 5));
      }
    }
  }
}
