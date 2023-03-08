import '../model/stocks.dart';
import '../model/stocks_info_model.dart';
import '../util/enums.dart';

abstract class IStocks {
  Future<Stocks> getAllStocks();

  // Future<StocksInfoModel> getAllStocksInfo<T>(
  //     {required T symbols,
  //     //Intervalo de preços históricos
  //     ValidRangesEnum range = ValidRangesEnum.one_m,
  //     //Intervalo para obter preços históricos dentro do intervalo
  //     ValidRangesEnum interval = ValidRangesEnum.one_d,
  //     bool fundamental = true});
}

abstract class IStockInfo {
  Future<StocksInfoModel> getAllStocksInfo(
      {required List<String> symbols,
      //Intervalo de preços históricos
      ValidRangesEnum range = ValidRangesEnum.one_m,
      //Intervalo para obter preços históricos dentro do intervalo
      ValidRangesEnum interval = ValidRangesEnum.one_d,
      bool fundamental = true});
}
