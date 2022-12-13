import 'historical_data_price.dart';

class StockInfoModel {
  String? symbol;
  String? shortName;
  String? longName;
  String? currency;
  num? regularMarketPrice;
  num? regularMarketDayHigh;
  num? regularMarketDayLow;
  String? regularMarketDayRange;
  num? regularMarketChange;
  num? regularMarketChangePercent;
  String? regularMarketTime;
  int? regularMarketVolume;
  num? regularMarketPreviousClose;
  num? regularMarketOpen;
  num? fiftyTwoWeekLowChange;
  num? fiftyTwoWeekLowChangePercent;
  String? fiftyTwoWeekRange;
  num? fiftyTwoWeekHighChange;
  num? fiftyTwoWeekHighChangePercent;
  num? fiftyTwoWeekLow;
  num? fiftyTwoWeekHigh;
  List<String>? validRanges;
  List<HistoricalDataPrice>? historicalDataPrice;
  num? priceEarnings;
  num? earningsPerShare;
  String? logourl;

  StockInfoModel({
    this.validRanges = const <String>[],
    this.historicalDataPrice = const <HistoricalDataPrice>[],
    this.symbol,
    this.shortName,
    this.longName,
    this.currency,
    this.regularMarketPrice,
    this.regularMarketDayHigh,
    this.regularMarketDayLow,
    this.regularMarketDayRange,
    this.regularMarketChange,
    this.regularMarketChangePercent,
    this.regularMarketTime,
    this.regularMarketVolume,
    this.regularMarketPreviousClose,
    this.regularMarketOpen,
    this.fiftyTwoWeekLowChange,
    this.fiftyTwoWeekLowChangePercent,
    this.fiftyTwoWeekRange,
    this.fiftyTwoWeekHighChange,
    this.fiftyTwoWeekHighChangePercent,
    this.fiftyTwoWeekLow,
    this.fiftyTwoWeekHigh,
    this.priceEarnings,
    this.earningsPerShare,
    this.logourl,
  });

  StockInfoModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    shortName = json['shortName'];
    longName = json['longName'];
    currency = json['currency'];
    regularMarketPrice = json['regularMarketPrice'];
    regularMarketDayHigh = json['regularMarketDayHigh'];
    regularMarketDayLow = json['regularMarketDayLow'];
    regularMarketDayRange = json['regularMarketDayRange'];
    regularMarketChange = json['regularMarketChange'];
    regularMarketChangePercent = json['regularMarketChangePercent'];
    regularMarketTime = json['regularMarketTime'];
    regularMarketVolume = json['regularMarketVolume'];
    regularMarketPreviousClose = json['regularMarketPreviousClose'];
    regularMarketOpen = json['regularMarketOpen'];
    fiftyTwoWeekLowChange = json['fiftyTwoWeekLowChange'];
    fiftyTwoWeekLowChangePercent = json['fiftyTwoWeekLowChangePercent'];
    fiftyTwoWeekRange = json['fiftyTwoWeekRange'];
    fiftyTwoWeekHighChange = json['fiftyTwoWeekHighChange'];
    fiftyTwoWeekHighChangePercent = json['fiftyTwoWeekHighChangePercent'];
    fiftyTwoWeekLow = json['fiftyTwoWeekLow'];
    fiftyTwoWeekHigh = json['fiftyTwoWeekHigh'];
    if (json['validRanges'] != null) {
      validRanges = <String>[];
      json['validRanges'].forEach((v) {
        validRanges!.add(v);
      });
    }

    if (json['historicalDataPrice'] != null) {
      this.historicalDataPrice = <HistoricalDataPrice>[];
      json['historicalDataPrice'].forEach((v) {
        historicalDataPrice!.add(new HistoricalDataPrice.fromJson(v));
      });
    }
    priceEarnings = json['priceEarnings'];
    earningsPerShare = json['earningsPerShare'];
    logourl = json['logourl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['shortName'] = this.shortName;
    data['longName'] = this.longName;
    data['currency'] = this.currency;
    data['regularMarketPrice'] = this.regularMarketPrice;
    data['regularMarketDayHigh'] = this.regularMarketDayHigh;
    data['regularMarketDayLow'] = this.regularMarketDayLow;
    data['regularMarketDayRange'] = this.regularMarketDayRange;
    data['regularMarketChange'] = this.regularMarketChange;
    data['regularMarketChangePercent'] = this.regularMarketChangePercent;
    data['regularMarketTime'] = this.regularMarketTime;
    data['regularMarketVolume'] = this.regularMarketVolume;
    data['regularMarketPreviousClose'] = this.regularMarketPreviousClose;
    data['regularMarketOpen'] = this.regularMarketOpen;
    data['fiftyTwoWeekLowChange'] = this.fiftyTwoWeekLowChange;
    data['fiftyTwoWeekLowChangePercent'] = this.fiftyTwoWeekLowChangePercent;
    data['fiftyTwoWeekRange'] = this.fiftyTwoWeekRange;
    data['fiftyTwoWeekHighChange'] = this.fiftyTwoWeekHighChange;
    data['fiftyTwoWeekHighChangePercent'] = this.fiftyTwoWeekHighChangePercent;
    data['fiftyTwoWeekLow'] = this.fiftyTwoWeekLow;
    data['fiftyTwoWeekHigh'] = this.fiftyTwoWeekHigh;
    data['validRanges'] = this.validRanges;

    if (this.historicalDataPrice != null) {
      data['historicalDataPrice'] =
          this.historicalDataPrice!.map((v) => v.toJson()).toList();
    }
    data['priceEarnings'] = this.priceEarnings;
    data['earningsPerShare'] = this.earningsPerShare;
    data['logourl'] = this.logourl;
    return data;
  }
}
