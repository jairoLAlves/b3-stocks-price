// ignore_for_file: slash_for_doc_comments

import 'package:dio/dio.dart';
import '../interfaces/stocks_interface.dart';
import '../model/stocks.dart';
import '../model/stocks_info_model.dart';
import '../util/enums.dart';

class StocksRepository with IStockInfo implements IStocks {
  static const String _baseUrl = 'https://brapi.dev/api/quote';

  final dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(milliseconds: 50000),
    receiveTimeout: const Duration(milliseconds: 50000),
    contentType: 'application/json', // Added contentType here
  ));

  //'/api/quote/'
  //https://brapi.dev/api/quote/VSLH11?range=1d&interval=1mo&fundamental=false
  //https://brapi.dev/api/quote/PETR4?range=1d&interval1mo&fundamental=true

  @override
  Future<Stocks> getAllStocks() async {
    final Response respnse = await dio.get(
      '$_baseUrl/list',
    );

    final Map<String, dynamic> stocks = respnse.data;
    return Stocks.fromJson(stocks);
  }

  /**
   * symbols = Add one or more tickers separated by a comma.
   * range = Range for historical prices.
   * interval = Interval to get historial prices within the range.
   * fundamental = Retrieve fundamental analysis data.
   * dividends = Retrieve dividends data.
   */

  @override
  Future<StocksInfoModel> getAllStocksInfo({
    required List<String> symbols,
    ValidRangesEnum range = ValidRangesEnum.one_m,
    ValidRangesEnum interval = ValidRangesEnum.one_d,
    bool fundamental = true,
    bool dividends = true,
  }) async {
    String symbolList = '';

    for (var symbol in symbols) {
      bool isLast = symbols.last != symbol;
      symbolList += isLast ? '${symbol.toUpperCase()},' : symbol.toUpperCase();
    }

    final String urlCompleta =
        '$_baseUrl/$symbolList?range=${getValidRangeString(range)}&interval=${getValidRangeString(interval)}&fundamental=$fundamental&dividends=$dividends';

    Response? response = await dio.get(urlCompleta);

    Map<String, dynamic> stocksInfo = <String, dynamic>{};

    return StocksInfoModel.fromJson(stocksInfo);
  }
}
