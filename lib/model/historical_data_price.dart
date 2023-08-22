// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'chart_sample_date.dart';
import 'historical_data_and_chart_semple_date.dart';

class HistoricalDataPrice extends HistoricalDataAndChartSampleDate {
  num? date;

  @override
  num? open;

  @override
  num? high;

  @override
  num? low;

  @override
  num? close;

  @override
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
    return 'HistoricalDataPrice(date: $date, open: $open, high: $high, low: $low, close: $close, volume: $volume)';
  }
}
