import '../util/enums.dart';
import 'chart_sample_date.dart';

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
    date = json['date'];
    open = json['open'];
    high = json['high'];
    low = json['low'];
    close = json['close'];
    volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['open'] = open;
    data['high'] = high;
    data['low'] = low;
    data['close'] = close;
    data['volume'] = volume;
    return data;
  }

  ChartSampleDate get toChartSampleDate {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(date!.toInt() * 1000);

    return ChartSampleDate(
      dateTime: dateTime,
      high: high,
      low: low,
      open: open,
      close: close,
      volume: volume,
    );
  }

  @override
  String toString() {
    return '''
    date: $date
    open: $open
    high: $high
    low: $low
    close: $close
    volume: $volume
''';
  }
}
