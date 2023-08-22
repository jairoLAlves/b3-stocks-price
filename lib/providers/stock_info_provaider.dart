import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../interfaces/stocks_info_interface.dart';
import '../model/historical_data_price.dart';
import '../model/range_interval.dart';
import '../model/stock_info_model.dart';
import '../util/enums.dart';

class StockInfoProvider with ChangeNotifier {
  late final IStockInfo _repository;
  late final List<StockInfoModel> listStockInfo;

  StockInfoProvider({required repository}) {
    _repository = repository;
    listStockInfo = <StockInfoModel>[];
  }

  Future<
      ({
        StockInfoModel? stockInfo,
        List<HistoricalDataPrice> listHistoricalDataPrice,
        StatusGetStocks status
      })> getHistoricalDataPrice({
    required String symbol,
    ValidRangesEnum range = ValidRangesEnum.five_d,
    ValidIntervalEnum interval = ValidIntervalEnum.one_d,
    bool dividends = false,
  }) async {
    print('''
 symbol = $symbol 
 range = $range 
 interval = $interval 
 dividends = $dividends
''');

    StockInfoModel? stockInfo = getStockInfo(symbol: symbol);

    StatusGetStocks status = StatusGetStocks.start;
    List<HistoricalDataPrice> listHistoricalDataPrice;

    if ((stockInfo == null) ||
        stockInfo
            .getHistoricalDataPrice(range: range, interval: interval)
            .isEmpty) {
      (:stockInfo, :status) = await getStockInfoAllRange(
          symbol: symbol,
          range: range,
          interval: interval,
          dividends: dividends);
    } else {
      status = StatusGetStocks.success;
    }

    listHistoricalDataPrice =
stockInfo?.getHistoricalDataPrice(range: range, interval: interval) ??
            [];

    return (
      stockInfo: stockInfo,
      listHistoricalDataPrice: listHistoricalDataPrice,
      status: status
    );
  }

  StockInfoModel? getStockInfo({
    required String symbol,
  }) {
    debugPrint("fun getStockInfo");

    StockInfoModel? stockInfo;
    try {
      stockInfo = listStockInfo.firstWhere(
        (stockInfo) => stockInfo.symbol == symbol,
      );
    } catch (e) {
      stockInfo = null;
    }

  

    return stockInfo;
  }

  void _addOrUpdateListStockInfo(StockInfoModel newStockInfo) {
    debugPrint("fun addOrUpdateListStockInfo");
    if (!listStockInfo.contains(newStockInfo)) {
      listStockInfo.add(newStockInfo);
    } else {
      int indexOldStockInfo = listStockInfo.indexOf(newStockInfo);

      List<RangeInterval>? oldListRange;

      if (indexOldStockInfo >= 0) {
        oldListRange = listStockInfo[indexOldStockInfo].listHistoricalDataPrice;
      }
      listStockInfo.remove(newStockInfo);
      if (oldListRange != null) {
        newStockInfo.addOrUpdateListHistoricalDataPrice(oldListRange);
      }
      listStockInfo.add(newStockInfo);
    }
  }

  Future<
      ({
        StockInfoModel? stockInfo,
        StatusGetStocks status,
      })> getStockInfoAllRange({
    required String symbol,
    required ValidRangesEnum range,
    required ValidIntervalEnum interval,
    bool dividends = false,
    bool fundamental = false,
  }) async {
    debugPrint("fun getStockInfoAllRange");

    StatusGetStocks status;

    StockInfoModel? stockInfo;

    try {
      stockInfo = await _repository.getAllStocksInfo(
        symbols: <String>[symbol],
        interval: interval,
        range: range,
        dividends: dividends,
        fundamental: fundamental,
      ).then((stockInfo) => stockInfo.results?.firstOrNull);

      if (stockInfo != null) {
        _addOrUpdateListStockInfo(stockInfo);
      }

      status = StatusGetStocks.success;
    } catch (e) {
      debugPrint("erro no provider: $e");
      status = StatusGetStocks.error;
    }
   

    return (stockInfo: stockInfo, status: status);
  }
}
