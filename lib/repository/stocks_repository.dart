import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';
import '../interfaces/stocks_interface.dart';
import '../model/stocks.dart';
import '../model/stocks_info_model.dart';
import '../util/enums.dart';

class StocksRepository implements IStocks {
  final String _baseUrl = 'https://brapi.dev/api/quote';

  //'/api/quote/'
  //https://brapi.dev/api/quote/VSLH11?range=1d&interval=1mo&fundamental=false
  //https://brapi.dev/api/quote/PETR4?range=1d&interval1mo&fundamental=true

  @override
  Future<Stocks> getAllStocks() async {
    final Response respnse = await http.get(
      Uri.parse('$_baseUrl/list'),
    );

    final Map<String, dynamic> stocks = jsonDecode(respnse.body);
    return Stocks.fromJson(stocks);
  }

  @override
  Future<StocksInfoModel> getAllStocksInfo(
      {required String symbol,
      ValidRangesEnum range = ValidRangesEnum.ten_y,
      ValidRangesEnum interval = ValidRangesEnum.one_d,
      bool fundamental = true}) async {
    final Response respnse = await http.get(Uri.parse(
        '$_baseUrl/${symbol.toUpperCase()}?range=${getValidRangeString(range)}&interval=${getValidRangeString(interval)}&fundamental=$fundamental'));

    final Map<String, dynamic> stocksInfo = jsonDecode(respnse.body);

    return StocksInfoModel.fromJson(stocksInfo);
  }
}
