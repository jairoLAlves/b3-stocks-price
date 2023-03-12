// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChartSampleDate {
  final DateTime? dateTime;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
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
