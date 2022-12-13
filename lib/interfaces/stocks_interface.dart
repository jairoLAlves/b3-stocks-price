import '../model/stocks.dart';
import '../model/stocks_info_model.dart';
import '../util/enums.dart';

abstract class IStocks {
  Future<Stocks> getAllStocks();
  Future<StocksInfoModel> getAllStocksInfo(
      {required String symbol,
      ValidRangesEnum range = ValidRangesEnum.one_d,
      ValidRangesEnum interval = ValidRangesEnum.one_m,
      bool fundamental = true});
}
