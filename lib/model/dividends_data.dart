// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'cash_dividends.dart';
import 'stock_dividends.dart';
import 'subscriptions.dart';

class DividendsData {
  ///Dividendos em dinheiro
  List<CashDividends>? cashDividends;
  ///dividendos de ações 
  List<StockDividends>? stockDividends;
  ///assinaturas
  List<Subscriptions>? subscriptions;

  DividendsData({this.cashDividends, this.stockDividends, this.subscriptions});

  DividendsData.fromJson(Map<String, dynamic> json) {
    if (json['cashDividends'] != null) {
      cashDividends = <CashDividends>[];
      json['cashDividends'].forEach((v) {
        cashDividends!.add(CashDividends.fromJson(v));
      });
    }
    if (json['stockDividends'] != null) {
      stockDividends = <StockDividends>[];
      json['stockDividends'].forEach((v) {
        stockDividends!.add(StockDividends.fromJson(v));
      });
    }
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['subscriptions'].forEach((v) {
        subscriptions!.add(Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cashDividends != null) {
      data['cashDividends'] = cashDividends!.map((v) => v.toJson()).toList();
    }
    if (stockDividends != null) {
      data['stockDividends'] = stockDividends!.map((v) => v.toJson()).toList();
    }
    if (subscriptions != null) {
      data['subscriptions'] = subscriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => """{
        cashDividends: $cashDividends, \n
        stockDividends: $stockDividends, \n
        subscriptions: $subscriptions}""";
}
