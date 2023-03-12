// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'stock.dart';

class Stocks {
  List<Stock>? stocks;

  Stocks({this.stocks});

  Stocks.fromJson(Map<String, dynamic> json) {
    if (json['stocks'] != null) {
      stocks = <Stock>[];
      json['stocks'].forEach((v) {
        stocks!.add(Stock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stocks != null) {
      data['stocks'] = stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => 'Stocks(stocks: $stocks)';
}
