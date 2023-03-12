// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'stock_info_model.dart';

class StocksInfoModel {
  List<StockInfoModel>? results;
  String? requestedAt;

  StocksInfoModel({this.results, this.requestedAt});

  StocksInfoModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <StockInfoModel>[];
      json['results'].forEach((v) {
        results!.add(StockInfoModel.fromJson(v));
      });
    }
    requestedAt = json['requestedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['requestedAt'] = requestedAt;
    return data;
  }

  @override
  String toString() => 'StocksInfoModel(results: $results, requestedAt: $requestedAt)';
}
