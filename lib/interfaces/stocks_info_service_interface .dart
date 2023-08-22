// ignore_for_file: slash_for_doc_comments


import '../util/enums.dart';



abstract mixin class IStockInfoService {
  /**
   * symbols = Add one or more tickers separated by a comma.
   * range = Range for historical prices.
   * interval = Interval to get historial prices within the range.
   * fundamental = Retrieve fundamental analysis data.
   * dividends = Retrieve dividends data.
   */
  Future<Map> getAllStocksInfo({
    required List<String> symbols,
    ValidRangesEnum range = ValidRangesEnum.one_mo,
    ValidIntervalEnum interval = ValidIntervalEnum.one_d,
    bool fundamental = true,
    bool dividends = true,
  });
}
