import 'package:flutter/material.dart';

import '../model/stock.dart';
import '../util/utils.dart';

class StockDetail extends StatefulWidget {
  const StockDetail({super.key});

  @override
  State<StockDetail> createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> {
  @override
  Widget build(BuildContext context) {
    final stock = ModalRoute.of(context)?.settings.arguments as Stock;

    return Scaffold(
      appBar: AppBar(
        title: Text(stock.name),
        actions: [
          Hero(tag: '${stock.stock}', child: getNetWorkSvg(stock.logo))
        ],
      ),
      body: Column(children: [Container()]),
    );
  }
}
