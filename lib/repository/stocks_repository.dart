// ignore_for_file: slash_for_doc_comments

import 'package:b3_price_stocks/interfaces/stocks_interface.dart';
import 'package:b3_price_stocks/model/stocks_info_model.dart';
import 'package:b3_price_stocks/services/stocks_http_service.dart';

import '../interfaces/stocks_info_interface.dart';
import '../model/range_interval.dart';
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
    required ValidRangesEnum range,
    required ValidIntervalEnum interval,
    required bool fundamental,
    required bool dividends,
  }) async {
    StocksInfoModel stocksInfo = StocksInfoModel();

    var json = await service.getAllStocksInfo(
      symbols: symbols,
      range: range,
      interval: interval,
      fundamental: fundamental,
      dividends: dividends,
    );

    stocksInfo = StocksInfoModel.fromJson(json)
      ..results?.forEach((stocksInfo) {
        if (stocksInfo.historicalDataPrice != null) {
          stocksInfo.addOrUpdateListHistoricalDataPrice(
            [
              RangeInterval(
                  range: range,
                  interval: interval,
                  historicalDataPrice: stocksInfo.historicalDataPrice!)
            ],
          );
        }
      });

    return stocksInfo;
  }
}
