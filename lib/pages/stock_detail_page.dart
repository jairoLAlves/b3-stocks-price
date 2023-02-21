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
    debugPrint('id: ${stock.id}');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(stock.name),
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(stock.stock),
            Hero(
                tag: '${stock.id}',
                child: Container(child: getNetWorkSvg(stock.logo))),
          ],
        )
      ]),
    );
  }
}
