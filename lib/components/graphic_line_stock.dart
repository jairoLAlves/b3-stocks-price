import 'package:b3_price_stocks/model/stock_info_model.dart';
import 'package:b3_price_stocks/providers/stocks_provider.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphicLineStock extends StatefulWidget {
  final String stockName;

  GraphicLineStock({super.key, required this.stockName});

  @override
  State<GraphicLineStock> createState() => _GraphicLineStockState();
}

class _GraphicLineStockState extends State<GraphicLineStock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('reatualizando grafico: ${widget.stockName}');

    final controller = context.watch<StocksProvider>();
    var stockInfo = controller.getStockInfo(widget.stockName);

    List<double> historicalDataPrice =
        stockInfo.historicalDataPrice?.getListNumFilter().map((e) {
              var d = e.toStringAsFixed(2);
              return double.parse(d);
            }).toList() ??
            <double>[];

    bool? bullOrBearList = historicalDataPrice.bullOrBearList();

    Color cor = (bullOrBearList != null)
        ? bullOrBearList
            ? Colors.green
            : Colors.red
        : Colors.black;
    //print('$historicalDataPrice' + '\n');

    return historicalDataPrice.isEmpty
        ? Container()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Sparkline(
                  data: historicalDataPrice,
                  lineWidth: 1,
                  //averageLine
                  averageLine: true,
                  averageLabel: true,
                  lineColor: cor,
                  gridLineLabelColor: Colors.black,
                  gridLineColor: Colors.black,
                  //enableThreshold: true,

                  useCubicSmoothing: true,
                  pointsMode: PointsMode.atIndex,
                  //backgroundColor: Colors.grey.shade300,
                  cubicSmoothingFactor: 0.2,
                  kLine: const [
                    'max',
                    'min',
                  ],
                  fillMode: FillMode.below,
                  fillGradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [cor, cor.withAlpha(5)],
                  ),
                ),
              ),
            ],
          );
  }
}

class SalesDate {
  final double year;
  final double sales;
  SalesDate(this.sales, this.year);
}
