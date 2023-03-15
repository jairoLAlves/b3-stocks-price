import 'package:b3_price_stocks/model/stocks.dart';

abstract class IStocksService {
  Future<Map<String, dynamic>> getAllStocks();
}