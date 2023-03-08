import 'package:flutter/material.dart';

import '../model/stock.dart';
import '../model/stock_info_model.dart';
import '../providers/stock_info_provaider.dart';
import '../providers/stocks_provider.dart';
import '../util/enums.dart';
import 'package:provider/provider.dart';

class StockDetailPage extends StatefulWidget {
  const StockDetailPage({
    super.key,
  });

  @override
  State<StockDetailPage> createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetailPage> {
  late final StockInfoProvider controller;
  // late final ValueNotifier<String> stockName = ValueNotifier("");
  late ValidRangesEnum validRange = ValidRangesEnum.five_d;
  late final ValueNotifier<Stock> stock = ValueNotifier(Stock());

  @override
  void initState() {
    super.initState();
    controller = context.read<StockInfoProvider>();
    stock.addListener(() {
       _getStockInfoAllRange();
    });

   
  }

  void _getStockInfoAllRange() {
    controller.getStockInfoAllRange(
      symbol: stock.value.stock,
      range: validRange,
    );
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<StockInfoProvider>();
    stock.value = (ModalRoute.of(context)?.settings.arguments as Stock);

    StockInfoModel stockInfo = controller.getStockInfo(stock.value.stock);

    return Scaffold(
        appBar: AppBar(
          title: Text(stock.value.name),
        ),
        body: ValueListenableBuilder(
          valueListenable: stock,
          builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Último Fechamento"),
                      Text("${stockInfo.regularMarketPrice}"),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
