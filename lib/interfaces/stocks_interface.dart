// ignore_for_file: slash_for_doc_comments

import '../model/stocks.dart';
import '../model/stocks_info_model.dart';
import '../util/enums.dart';

abstract class IStocks {
  Future<Stocks> getAllStocks();
}

abstract class IStockInfo {

    /**
   * symbols = Add one or more tickers separated by a comma.
   * range = Range for historical prices.
   * interval = Interval to get historial prices within the range.
   * fundamental = Retrieve fundamental analysis data.
   * dividends = Retrieve dividends data.
   */
  Future<StocksInfoModel> getAllStocksInfo({
    required List<String> symbols,
    ValidRangesEnum range = ValidRangesEnum.one_m,
    ValidRangesEnum interval = ValidRangesEnum.one_d,
    bool fundamental = true,
    bool dividends = true,

  });
}
