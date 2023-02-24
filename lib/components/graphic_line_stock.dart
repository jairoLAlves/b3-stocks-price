import 'package:b3_price_stocks/model/stock_info_model.dart';
import 'package:b3_price_stocks/providers/stocks_provider.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/choice_chip_range_date_model.dart';
import '../util/enums.dart';
import 'historical_price_choicechip.dart';

class GraphicLineStock extends StatefulWidget {
  final String stockName;

  GraphicLineStock({
    super.key,
    required this.stockName,
  });

  @override
  State<GraphicLineStock> createState() => _GraphicLineStockState();
}

class _GraphicLineStockState extends State<GraphicLineStock> {
  late final controller;

  late ValidRangesEnum validRange = ValidRangesEnum.five_d;

  @override
  void initState() {
    super.initState();
    controller = context.read<StocksProvider>();
    _getStockInfoAllRange();
  }

  void _getStockInfoAllRange() {
    controller.getStockInfoAllRange(
      symbol: widget.stockName,
      range: validRange,
    );
  }

  final double height = 108;

  Widget _start() {
    return Container(
      height: height,
    );
  }

  Widget _loading() {
    return Container(
      height: height,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _error(Function() onPressedBtnError) {
    return Container(
      height: height,
      child: Center(
          child: ElevatedButton(
        onPressed: onPressedBtnError,
        child: Text('Tente Novamente'),
      )),
    );
  }

  Widget stateManagement(
    StatusGetStocks state,
    List<double> historicalDataPrice,
    Function() onPressedBtnError,
  ) {
    bool? bullOrBearList = historicalDataPrice.bullOrBearList();

    Color cor = (bullOrBearList != null)
        ? bullOrBearList
            ? Colors.green
            : Colors.red
        : Colors.black;

    switch (state) {
      case StatusGetStocks.loading:
        return _loading();

      case StatusGetStocks.start:
        return _start();
      case StatusGetStocks.success:
        return Container(
          //padding: const EdgeInsets.all(4.0),
          child: Sparkline(
            data: historicalDataPrice,
            lineWidth: 1,
            //averageLine
            averageLine: true,
            averageLabel: true,
            lineColor: cor,
            gridLineLabelColor: Theme.of(context).colorScheme.onBackground,
            gridLineColor: Theme.of(context).colorScheme.onBackground,
            //enableThreshold: true,

            //useCubicSmoothing: true,
            pointsMode: PointsMode.atIndex,
            //backgroundColor: Theme.of(context).colorScheme.surfaceTint,
            //cubicSmoothingFactor: 0.2,
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
        );

      case StatusGetStocks.error:
        return _error(onPressedBtnError);
    }
  }

  int indexChipSelect = 0;

  void onSelected(int index, ValidRangesEnum validRangeFun) {
    setState(() {
      indexChipSelect = index;
      validRange = validRangeFun;
    });
    controller.getStockInfoAllRange(
        symbol: widget.stockName, range: validRange);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('reatualizando grafico: ${widget.stockName}');

    var controller = context.watch<StocksProvider>();

    var stockInfo = controller.getStockInfo(widget.stockName);

    List<double> historicalDataPrice =
        stockInfo.historicalDataPrice?.getListNumFilter().map((e) {
              var d = e.toStringAsFixed(2);
              return double.parse(d);
            }).toList() ??
            <double>[];

    //print('$historicalDataPrice' + '\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer<StocksProvider>(
          builder: (context, controller, child) {
            return AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: stateManagement(
                controller.stateInfoAllRange.value,
                historicalDataPrice,
                _getStockInfoAllRange,
              ),
            );
          },
        ),
        Container(
          height: 30,
          //color: Colors.black.withAlpha(40),
          child: HistoricalPriceChoicechipRangeDate(
            indexChipSelect: indexChipSelect,
            onSelected: onSelected,
          ),
        ),
      ],
    );
  }
}
