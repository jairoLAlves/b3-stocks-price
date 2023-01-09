import 'dart:convert';
import 'package:dio/dio.dart';
import '../interfaces/stocks_interface.dart';
import '../model/stocks.dart';
import '../model/stocks_info_model.dart';
import '../util/enums.dart';

class StocksRepository implements IStocks {
  static String _baseUrl = 'https://brapi.dev/api/quote';

  final dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: 50000,
    receiveTimeout: 50000,
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
    print(respnse.statusCode);

    final Map<String, dynamic> stocks = respnse.data;
    return Stocks.fromJson(stocks);
  }

  @override
  Future<StocksInfoModel> getAllStocksInfo({
    required List<String> symbols,
    ValidRangesEnum range = ValidRangesEnum.one_m,
    ValidRangesEnum interval = ValidRangesEnum.one_d,
    bool fundamental = true,
  }) async {
    String symbolList = '';

    symbols.forEach((symbol) {
      bool islast = symbols.last != symbol;
      symbolList += islast ? symbol.toUpperCase() + ',' : symbol.toUpperCase();
    });

    final String urlCompleta =
        '$_baseUrl/${symbolList}?range=${getValidRangeString(range)}&interval=${getValidRangeString(interval)}&fundamental=$fundamental';
    print(urlCompleta);

    final response = await dio.get(urlCompleta);

    print(response.statusCode);
    // print(response.data);

    Map<String, dynamic> stocksInfo = response.data;

    return StocksInfoModel.fromJson(stocksInfo);
  }
}
