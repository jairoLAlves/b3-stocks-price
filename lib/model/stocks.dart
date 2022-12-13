import '../util/enums.dart';
import 'stock.dart';

class Stocks {
  List<Stock>? stocks;

  Stocks({this.stocks});

  Stocks.fromJson(Map<String, dynamic> json) {
    if (json['stocks'] != null) {
      stocks = <Stock>[];
      json['stocks'].forEach((v) {
        stocks!.add(new Stock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stocks != null) {
      data['stocks'] = this.stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
