import 'dart:convert';
import 'dart:io';

import 'package:b3_price_stocks/interfaces/stocks_info_service_interface%20.dart';
import 'package:b3_price_stocks/interfaces/stocks_interface%20_service.dart';
import 'package:b3_price_stocks/util/enums.dart';
import 'package:http/http.dart' as http;

class StocksHttpService with IStockInfoService implements IStocksService {
  static const String _baseUrl = 'brapi.dev';

   Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

  @override
  Future<Map<String, dynamic>> getAllStocks() async {
    var url = Uri.https(_baseUrl, '/api/quote/list');
    var response = await http.get(url, headers:headers);

    var body =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    return body;
  }

  // symbols = Add one or more tickers separated by a comma.
  // range = Range for historical prices.
  // interval = Interval to get historial prices within the range.
  // fundamental = Retrieve fundamental analysis data.
  // dividends = Retrieve dividends data.

  @override
  Future<Map<String, dynamic>> getAllStocksInfo({
    required List<String> symbols,
    ValidRangesEnum range = ValidRangesEnum.one_m,
    ValidRangesEnum interval = ValidRangesEnum.one_d,
    bool fundamental = true,
    bool dividends = true,
  }) async {
    String symbolList = '';

    for (var element in symbols) {
      bool isLast = symbols.last != element;
      symbolList +=
          isLast ? '${element.toUpperCase()},' : element.toUpperCase();
    }

    Map<String, String> queryParameters = {
      "range": "${getValidRangeString(range)}",
      "interval": "${getValidRangeString(interval)}",
      "fundamental": "$fundamental",
      "dividends": "$dividends",
    };
   

    var url = Uri.https(
      _baseUrl,
      '/api/quote/$symbolList',
      queryParameters,
    );
   

    var response = await http.get(
      url,
      headers: headers,
    );
    


    Map<String, dynamic> body =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

  
    return body;
  }
}
