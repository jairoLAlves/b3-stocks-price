import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:b3_price_stocks/services/stocks_http_service.dart';
import 'package:flutter/material.dart';

import '../interfaces/stocks_interface.dart';
import '../model/stock.dart';
import '../repository/stocks_repository.dart';
import '../util/enums.dart';

class StocksProvider with ChangeNotifier {
  late final IStocks _repository;

  StocksProvider({required repository}) {
    _repository = repository;
  }
 
  final ValueNotifier<List<Stock>> listStocks = ValueNotifier(<Stock>[]);
  final ValueNotifier<List<String>> stockSymbolList = ValueNotifier(<String>[]);
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  final ValueNotifier stocksSortBy =
      ValueNotifier<StocksSortBy>(StocksSortBy.volume);

  final ValueNotifier stocksSectors = ValueNotifier<sectors>(sectors.All);

  



  searchStockFilter(String value) {
    listStocks.value =
        _searchStockFilter(value, stocksSectors.value);

    listStocks.value.sortOrderStocks(stocksSortBy.value);
    notifyListeners();
  }

  filterList() {
    listStocks.value = _filterListStocks(stocksSectors.value);
    listStocks.value.sortOrderStocks(stocksSortBy.value);
    notifyListeners();
  }

  sortedList() {
    listStocks.value.sortOrderStocks(stocksSortBy.value);
    notifyListeners();
  }

  void onActionDropdownMenuItemSorted(StocksSortBy stocksSortBy) {
    this.stocksSortBy.value = stocksSortBy;
    sortedList();
  }

  void onActionDropdownMenuItemSectors(sectors sector) {
    stocksSectors.value = sector;

    filterList();
  }

  List<Stock> _stoks = <Stock>[];
  ValueNotifier<StatusGetStocks> stateUpdateStocks =
      ValueNotifier<StatusGetStocks>(StatusGetStocks.start);

  Future<void> loadStocks() async {

  try {
    isLoading.value = true;
    listStocks.value = await _updateStocks();
    isLoading.value = false;
  } catch (e) {
    isLoading.value = false;
    // trate o erro adequadamente aqui
  }
  notifyListeners();
  }

  List<Stock> _getAllStocks() {
    return [..._stoks];
  }

  Future<List<Stock>> _updateStocks() async {
    stateUpdateStocks.value = StatusGetStocks.loading;

    try {
      final listaStocks = await _repository.getAllStocks();
      _stoks = listaStocks.stocks ?? _stoks;
      //listaStockName = _stoks.stockSymbolList();
    } catch (e) {
      stateUpdateStocks.value = StatusGetStocks.error;
    }

    stateUpdateStocks.value = StatusGetStocks.success;

    return _stoks;
  }

  // StockInfoModel getStockInfo(String StockSymbol) {
  //   var listRetorno = listaFinal.firstWhere(
  //     (stocoInfo) => stocoInfo.symbol == StockSymbol,
  //     orElse: () => StockInfoModel(),
  //   );

  //   return listRetorno;
  // }

  // sortOrderStocks(StocksSortBy stocksSortBy, {bool sortOrder = true}) {
  //   _stoks.sortedBy(stocksSortBy);
  //   notifyListeners();
  // }

  List<Stock> _filterListStocks(sectors sector) {
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

  List<Stock> _searchStockFilter(String value, [sectors sector = sectors.All]) {
    return _filterListStocks(sector).where((element) {
      return element.stock.contains(value.toUpperCase());
    }).toList();
  }

  // Future<void> getStockInfoAll() async {
  //   listaFinal.clear();
  //   if (listaStockName.isNotEmpty) {
  //     var listaDividida = listaStockName.dividirListaString(20);

  //     for (List<String> stock in listaDividida) {
  //       var resp = await _repository.getAllStocksInfo(symbols: stock);

  //       listaFinal.addAll([...?resp.results]);
  //       notifyListeners();
  //       await Future.delayed(Duration(seconds: 5));
  //     }
  //   }
  // }

  // Future<void> getStockInfoAllRange({
  //   required String symbol,
  //   ValidRangesEnum range = ValidRangesEnum.one_m,
  //   ValidRangesEnum interval = ValidRangesEnum.one_d,
  // }) async {
  //   try {
  //     stateInfoAllRange.value = StatusGetStocks.loading;
  //     var resp = await _repository.getAllStocksInfo(
  //       symbols: <String>[symbol],
  //       interval: interval,
  //       range: range,
  //     );

  //     StockInfoModel velho = getStockInfo(symbol);

  //     if (listaFinal.contains(velho)) listaFinal.remove(velho);

  //     if (resp.results != null) listaFinal.addAll(resp.results!);
  //     stateInfoAllRange.value = StatusGetStocks.success;
  //    notifyListeners();
  //   } catch (e) {
  //     stateInfoAllRange.value = StatusGetStocks.error;
  //   }
  // }
}
