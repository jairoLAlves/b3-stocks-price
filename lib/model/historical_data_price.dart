import 'package:candlesticks_plus/candlesticks_plus.dart';

class HistoricalDataPrice {
  num? date;
  num? open;
  num? high;
  num? low;
  num? close;
  num? volume;

  HistoricalDataPrice({
    this.date,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
  });

  HistoricalDataPrice.fromJson(Map<String, dynamic> json) {
    this.date = json['date'];
    this.open = json['open'];
    this.high = json['high'];
    this.low = json['low'];
    this.close = json['close'];
    this.volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['open'] = this.open;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    data['volume'] = this.volume;
    return data;
  }

  Candle get toCandle {
    DateTime _date =
        DateTime.fromMillisecondsSinceEpoch(this.date!.toInt() * 1000);
    double _high = this.high!.toDouble();
    double _low = this.low!.toDouble();
    double _open = this.open!.toDouble();
    double _close = this.close!.toDouble();
    double _volume = this.volume!.toDouble();
    return Candle(
      date: _date,
      high: _high,
      low: _low,
      open: _open,
      close: _close,
      volume: _volume,
    );
  }

  @override
  String toString() {
    return '''
    ${this.date}
    ${this.open}
    ${this.high}
    ${this.low}
    ${this.close}
    ${this.volume}
''';
  }
}
