import 'package:dio/dio.dart';
import '../interfaces/stocks_interface.dart';
import '../model/stocks.dart';
import '../model/stocks_info_model.dart';
import '../util/enums.dart';

class StocksRepository with IStockInfo implements IStocks {
  static const String _baseUrl = 'https://brapi.dev/api/quote';

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

    for (var symbol in symbols) {
      bool isLast = symbols.last != symbol;
      symbolList += isLast ? '${symbol.toUpperCase()},' : symbol.toUpperCase();
    }

    final String urlCompleta =
        '$_baseUrl/$symbolList?range=${getValidRangeString(range)}&interval=${getValidRangeString(interval)}&fundamental=$fundamental';

    Response? response =
        symbolList.isNotEmpty ? await dio.get(urlCompleta) : null;

    Map<String, dynamic> stocksInfo = <String, dynamic>{};

    if (response != null) stocksInfo = response.data;

    return StocksInfoModel.fromJson(stocksInfo);
  }
}
