import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../interfaces/stocks_interface.dart';
import '../model/stock_info_model.dart';
import '../repository/stocks_repository.dart';
import '../util/enums.dart';

class StockInfoProvider with ChangeNotifier {
  final IStockInfo _repository = StocksRepository();
  static bool isPrimary = true;

  ValueNotifier<StatusGetStocks> stateInfoAllRange =
      ValueNotifier<StatusGetStocks>(StatusGetStocks.start);
  final List<StockInfoModel> _listaFinal = <StockInfoModel>[];

  StockInfoModel getStockInfo(String StockSymbol) {
    var retorno = _listaFinal.firstWhere(
      (stocoInfo) => stocoInfo.symbol == StockSymbol,
      orElse: () => StockInfoModel(),
    );
    return retorno;
  }

  void getStockInfoAllRange({
    required String symbol,
    ValidRangesEnum range = ValidRangesEnum.one_m,
    ValidRangesEnum interval = ValidRangesEnum.one_d,
    bool dividends = true,
  }) async {
    if (StockInfoProvider.isPrimary) {
      try {
        stateInfoAllRange.value = StatusGetStocks.loading;
        var resp = await _repository.getAllStocksInfo(
          symbols: <String>[symbol],
          interval: interval,
          range: range,
          dividends: dividends,
        );

        StockInfoModel velho = getStockInfo(symbol);

        if (_listaFinal.contains(velho)) _listaFinal.remove(velho);

        if (resp.results != null) _listaFinal.addAll(resp.results!);
        stateInfoAllRange.value = StatusGetStocks.success;
        notifyListeners();
      } catch (e) {
        debugPrint("$e");
        stateInfoAllRange.value = StatusGetStocks.error;
      }
    } else {
      StockInfoProvider.isPrimary = false;
    }
  }
}
