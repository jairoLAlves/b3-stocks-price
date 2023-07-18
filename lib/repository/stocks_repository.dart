// ignore_for_file: slash_for_doc_comments

import 'package:b3_price_stocks/interfaces/stocks_interface.dart';
import 'package:b3_price_stocks/model/stocks_info_model.dart';
import 'package:b3_price_stocks/services/stocks_http_service.dart';

import '../interfaces/stocks_info_interface.dart';
import '../model/stocks.dart';
import '../util/enums.dart';

class StocksRepository with IStockInfo implements IStocks {
  final StocksHttpService service;
  StocksRepository({required this.service});

  @override
  Future<Stocks> getAllStocks() async {
    Stocks stocks = Stocks();

    var json = await service.getAllStocks();
    stocks = Stocks.fromJson(json);
    return stocks;
  }

  @override
  Future<StocksInfoModel> getAllStocksInfo({
    required List<String> symbols,
    ValidRangesEnum range = ValidRangesEnum.one_m,
    ValidRangesEnum interval = ValidRangesEnum.one_d,
    bool fundamental = true,
    bool dividends = true,
  }) async {
    StocksInfoModel stocksInfo = StocksInfoModel();

    var json = await service.getAllStocksInfo(
      symbols: symbols,
      range: range,
      interval: interval,
      fundamental: fundamental,
      dividends: dividends,
    );

    stocksInfo = StocksInfoModel.fromJson(json);

    return stocksInfo;
  }
}
