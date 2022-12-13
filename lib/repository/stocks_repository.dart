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
      {required List<String> symbols,
      ValidRangesEnum range = ValidRangesEnum.one_m,
      ValidRangesEnum interval = ValidRangesEnum.one_d,
      bool fundamental = true}) async {
    final sizeListS = symbols.length;

    String symbolList = '';
    symbols.forEach((symbol) {
      bool islast = symbols.last != symbol;
      symbolList +=
          islast ? symbol.toUpperCase() + '%2C' : symbol.toUpperCase();
    });

    final Response response = await http.get(Uri.parse(
        '$_baseUrl/${symbolList}?range=${getValidRangeString(range)}&interval=${getValidRangeString(interval)}&fundamental=$fundamental'));

    //print(response);
    final Map<String, dynamic> stocksInfo = jsonDecode(response.body);
    //print(stocksInfo);

    return StocksInfoModel.fromJson(stocksInfo);
  }
}
