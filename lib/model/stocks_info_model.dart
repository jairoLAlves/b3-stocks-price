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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['requestedAt'] = this.requestedAt;
    return data;
  }
}
