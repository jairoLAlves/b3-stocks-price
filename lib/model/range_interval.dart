// ignore_for_file: public_member_api_docs, sort_constructors_first



import '../util/enums.dart';
import 'historical_data_price.dart';

class RangeInterval {
  ValidRangesEnum range;
  ValidIntervalEnum interval;
  List<HistoricalDataPrice> historicalDataPrice;

  RangeInterval({
    required this.range,
    required this.interval,
    required this.historicalDataPrice,
  });

  @override
  bool operator ==(covariant RangeInterval other) {
    if (identical(this, other)) return true;

    return other.range == range && other.interval == interval;
  }

  @override
  int get hashCode => range.hashCode ^ interval.hashCode;

  @override
  String toString() =>
      'RangeInterval(range: $range, interval: $interval, historicalDataPrice: ${historicalDataPrice.length})';
}
