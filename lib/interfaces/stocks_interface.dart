import 'package:b3_price_stocks/model/stocks.dart';

abstract class IStocks {
  Future<Stocks> getAllStocks();
}