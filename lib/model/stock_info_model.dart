// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../util/enums.dart';
import 'dividends_data.dart';
import 'historical_data_price.dart';
import 'range_interval.dart';

class StockInfoModel {
  ///símbolo
  String? symbol;

  ///nome curto
  String? shortName;

  ///nome longo
  String? longName;

  ///moeda
  String? currency;

  ///preço normal de mercado
  num? regularMarketPrice;

  ///alta regular do dia de mercado
  num? regularMarketDayHigh;

  ///baixa regular do dia de mercado
  num? regularMarketDayLow;

  ///intervalo regular do dia de mercado
  String? regularMarketDayRange;

  ///mudança regular do mercado
  num? regularMarketChange;

  ///porcentagem regular de mudança de mercado
  num? regularMarketChangePercent;

  ///horário regular do mercado
  String? regularMarketTime;

  ///valor de mercado
  num? marketCap;

  ///volume de mercado regular
  num? regularMarketVolume;

  ///Mercado regular Fechamento anterior
  num? regularMarketPreviousClose;

  ///regular mercado aberto
  num? regularMarketOpen;

  ///volume diário médio 10 dias
  num? averageDailyVolume10Day;

  ///volume diário médio 3 meses
  num? averageDailyVolume3Month;

  ///cinquenta Mudança baixa de duas semanas
  num? fiftyTwoWeekLowChange;

  ///cinquenta Intervalo de duas semanas
  String? fiftyTwoWeekRange;

  ///cinquenta Mudança alta de duas semanas
  num? fiftyTwoWeekHighChange;

  ///cinquenta por cento de mudança alta de duas semanas
  num? fiftyTwoWeekHighChangePercent;

  ///cinquenta Duas semanas baixa
  num? fiftyTwoWeekLow;

  ///cinquenta Duas semanas de altura
  num? fiftyTwoWeekHigh;

  ///Média de duzentos dias
  num? twoHundredDayAverage;

  ///Mudança média de duzentos dias
  num? twoHundredDayAverageChange;

  ///Porcentagem de variação média de duzentos dias
  num? twoHundredDayAverageChangePercent;

  ///intervalos válidos
  List<String>? validRanges;

  ///preço de dados históricos
  List<HistoricalDataPrice>? historicalDataPrice;



  ///preço Ganhos
  num? priceEarnings;

  ///lucro por ação
  num? earningsPerShare;

  ///URL do logotipo
  String? logourl;

  ///dados de dividendos
  DividendsData? dividendsData;

  ValidRangesEnum rangeChip = ValidRangesEnum.five_d;

  List<RangeInterval>? listHistoricalDataPrice;

  StockInfoModel(
      {this.symbol,
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
      this.marketCap,
      this.regularMarketVolume,
      this.regularMarketPreviousClose,
      this.regularMarketOpen,
      this.averageDailyVolume10Day,
      this.averageDailyVolume3Month,
      this.fiftyTwoWeekLowChange,
      this.fiftyTwoWeekRange,
      this.fiftyTwoWeekHighChange,
      this.fiftyTwoWeekHighChangePercent,
      this.fiftyTwoWeekLow,
      this.fiftyTwoWeekHigh,
      this.twoHundredDayAverage,
      this.twoHundredDayAverageChange,
      this.twoHundredDayAverageChangePercent,
      this.validRanges,
      this.historicalDataPrice,
      this.priceEarnings,
      this.earningsPerShare,
      this.logourl,
      this.dividendsData});

  void addOrUpdateListHistoricalDataPrice(
    List<RangeInterval> newListRangeInterval,
  ) {
    if (listHistoricalDataPrice != null ) {
      for (var newRangeInterval in newListRangeInterval) {
        if (!listHistoricalDataPrice!.contains(newRangeInterval)) {
          listHistoricalDataPrice!.add(newRangeInterval);
        } else {
          listHistoricalDataPrice!.remove(newRangeInterval);
          listHistoricalDataPrice!.add(newRangeInterval);
        }
      }
    } else {
      listHistoricalDataPrice = newListRangeInterval;
    }
  }

  List<HistoricalDataPrice> getHistoricalDataPrice({
    required ValidRangesEnum range,
    required ValidIntervalEnum interval,
  }) {
    if (listHistoricalDataPrice != null) {
      for (RangeInterval rangeInterval in listHistoricalDataPrice!) {
        if (rangeInterval.interval == interval &&
            rangeInterval.range == range) {
          return rangeInterval.historicalDataPrice;
        }
      }
    }

    return <HistoricalDataPrice>[];
  }

  StockInfoModel.fromJson(Map<String, dynamic> json) {
    // json.forEach((key, value) {
    //   print("$key, $value");
    // });

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
    marketCap = json['marketCap'];
    regularMarketVolume = json['regularMarketVolume'];
    regularMarketPreviousClose = json['regularMarketPreviousClose'];
    regularMarketOpen = json['regularMarketOpen'];
    averageDailyVolume10Day = json['averageDailyVolume10Day'];
    averageDailyVolume3Month = json['averageDailyVolume3Month'];
    fiftyTwoWeekLowChange = json['fiftyTwoWeekLowChange'];
    fiftyTwoWeekRange = json['fiftyTwoWeekRange'];
    fiftyTwoWeekHighChange = json['fiftyTwoWeekHighChange'];
    fiftyTwoWeekHighChangePercent = json['fiftyTwoWeekHighChangePercent'];
    fiftyTwoWeekLow = json['fiftyTwoWeekLow'];
    fiftyTwoWeekHigh = json['fiftyTwoWeekHigh'];
    twoHundredDayAverage = json['twoHundredDayAverage'];
    twoHundredDayAverageChange = json['twoHundredDayAverageChange'];
    twoHundredDayAverageChangePercent =
        json['twoHundredDayAverageChangePercent'];
    validRanges = json['validRanges']?.cast<String>();
    if (json['historicalDataPrice'] != null) {
      historicalDataPrice = <HistoricalDataPrice>[];
      json['historicalDataPrice'].forEach((v) {
        historicalDataPrice!.add(HistoricalDataPrice.fromJson(v));
      });
    }
    priceEarnings = json['priceEarnings'];
    earningsPerShare = json['earningsPerShare'];
    logourl = json['logourl'];
    dividendsData = json['dividendsData'] != null
        ? DividendsData.fromJson(json['dividendsData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['shortName'] = shortName;
    data['longName'] = longName;
    data['currency'] = currency;
    data['regularMarketPrice'] = regularMarketPrice;
    data['regularMarketDayHigh'] = regularMarketDayHigh;
    data['regularMarketDayLow'] = regularMarketDayLow;
    data['regularMarketDayRange'] = regularMarketDayRange;
    data['regularMarketChange'] = regularMarketChange;
    data['regularMarketChangePercent'] = regularMarketChangePercent;
    data['regularMarketTime'] = regularMarketTime;
    data['marketCap'] = marketCap;
    data['regularMarketVolume'] = regularMarketVolume;
    data['regularMarketPreviousClose'] = regularMarketPreviousClose;
    data['regularMarketOpen'] = regularMarketOpen;
    data['averageDailyVolume10Day'] = averageDailyVolume10Day;
    data['averageDailyVolume3Month'] = averageDailyVolume3Month;
    data['fiftyTwoWeekLowChange'] = fiftyTwoWeekLowChange;
    data['fiftyTwoWeekRange'] = fiftyTwoWeekRange;
    data['fiftyTwoWeekHighChange'] = fiftyTwoWeekHighChange;
    data['fiftyTwoWeekHighChangePercent'] = fiftyTwoWeekHighChangePercent;
    data['fiftyTwoWeekLow'] = fiftyTwoWeekLow;
    data['fiftyTwoWeekHigh'] = fiftyTwoWeekHigh;
    data['twoHundredDayAverage'] = twoHundredDayAverage;
    data['twoHundredDayAverageChange'] = twoHundredDayAverageChange;
    data['twoHundredDayAverageChangePercent'] =
        twoHundredDayAverageChangePercent;
    data['validRanges'] = validRanges;
    if (historicalDataPrice != null) {
      data['historicalDataPrice'] =
          historicalDataPrice!.map((v) => v.toJson()).toList();
    }
    data['priceEarnings'] = priceEarnings;
    data['earningsPerShare'] = earningsPerShare;
    data['logourl'] = logourl;
    if (dividendsData != null) {
      data['dividendsData'] = dividendsData!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(covariant StockInfoModel other) {
    if (identical(this, other)) return true;

    return other.symbol == symbol;
  }

  @override
  int get hashCode {
    return symbol.hashCode;
  }

  @override
  String toString() {
    return '''
    StockInfoModel(symbol: $symbol,
    shortName: $shortName,
    longName: $longName,
    currency: $currency,
    regularMarketPrice: $regularMarketPrice,
    regularMarketDayHigh: $regularMarketDayHigh,
    regularMarketDayLow: $regularMarketDayLow,
    regularMarketDayRange: $regularMarketDayRange,
    regularMarketChange: $regularMarketChange,
    regularMarketChangePercent: $regularMarketChangePercent,
    regularMarketTime: $regularMarketTime,
    marketCap: $marketCap,
    regularMarketVolume: $regularMarketVolume,
    regularMarketPreviousClose: $regularMarketPreviousClose,
    regularMarketOpen: $regularMarketOpen,
    averageDailyVolume10Day: $averageDailyVolume10Day,
    averageDailyVolume3Month: $averageDailyVolume3Month,
    fiftyTwoWeekLowChange: $fiftyTwoWeekLowChange,
    fiftyTwoWeekRange: $fiftyTwoWeekRange,
    fiftyTwoWeekHighChange: $fiftyTwoWeekHighChange,
    fiftyTwoWeekHighChangePercent: $fiftyTwoWeekHighChangePercent,
    fiftyTwoWeekLow: $fiftyTwoWeekLow,
    fiftyTwoWeekHigh: $fiftyTwoWeekHigh,
    twoHundredDayAverage: $twoHundredDayAverage,
    twoHundredDayAverageChange: $twoHundredDayAverageChange,
    twoHundredDayAverageChangePercent: $twoHundredDayAverageChangePercent,
    validRanges: $validRanges,
    historicalDataPrice: $historicalDataPrice,
    priceEarnings: $priceEarnings,
    earningsPerShare: $earningsPerShare,
    logourl: $logourl,
    dividendsData: $dividendsData,
    rangeChip: $rangeChip,
    listHistoricalDataPrice: size:${listHistoricalDataPrice?.length}  $listHistoricalDataPrice
    ''';
  }
}
