// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'historical_data_and_chart_semple_date.dart';

class ChartSampleDate extends HistoricalDataAndChartSampleDate {
  final DateTime? dateTime;
  @override
  final num? open;
  @override
  final num? close;
  @override
  final num? low;
  @override
  final num? high;
  @override
  final num? volume;

  ChartSampleDate({
    this.dateTime,
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
  });

  @override
  String toString() {
    return 'ChartSampleDate(dateTime: $dateTime, open: $open, close: $close, low: $low, high: $high, volume: $volume)';
  }
}
