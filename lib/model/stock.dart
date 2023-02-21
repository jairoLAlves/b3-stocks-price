import 'dart:math';

import 'package:b3_price_stocks/util/enums.dart';

class Stock {
  double id = Random().nextDouble();
  String? _stock;
  String? _name;
  num? _close;
  num? _change;
  num? _volume;
  num? _market_cap;
  String? _logo;
  String? _sector;

  Stock({
    stock,
    name,
    close,
    change,
    volume,
    market_cap,
    logo,
    sector,
  }) {
    _stock = stock;
    _name = name;
    _close = close;
    _change = change;
    _volume = volume;
    _market_cap = market_cap;
    _logo = logo;
    _sector = sector;
  }

  String get stock {
    return _stock ?? '';
  }

  String get name {
    return _name ?? '';
  }

  num get close {
    return _close ?? 0.00;
  }

  num get change {
    return _change ?? 0.00;
  }

  num get volume {
    return _volume ?? 0.00;
  }

  num get market_cap {
    return _market_cap ?? 0.00;
  }

  String get logo {
    return _logo ?? '';
  }

  String get sector {
    return _sector?.toLowerCase().replaceAll('_', ' ').replaceAll('-', ' ') ??
        sectors.Others.name.toLowerCase();
  }

  Stock.fromJson(Map<String, dynamic> json) {
    _stock = json['stock'];
    _name = json['name'];
    _close = json['close'];
    _change = json['change'];
    _volume = json['volume'];
    _market_cap = json['market_cap'];
    _logo = json['logo'];
    _sector = json['sector'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = _name;
    data['close'] = _close;
    data['change'] = _change;
    data['volume'] = _volume;
    data['market_cap'] = _market_cap;
    data['logo'] = _logo;
    data['sector'] = _sector;

    return data;
  }
}
