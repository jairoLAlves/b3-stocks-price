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
  _start() {
    return Container(
      height: height,
    );
  }

  _loading() {
    return Container(
      height: height,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  _error(Function() onPressedBtnError) {
    return Container(
      height: height,
      child: Center(
          child: ElevatedButton(
        onPressed: onPressedBtnError,
        child: Text('Tente Novamente'),
      )),
    );
  }

  stateManagement(StatusGetStocks state, List<double> historicalDataPrice,
      Function() onPressedBtnError) {
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
        return Padding(
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
        );

      case StatusGetStocks.error:
        return _error(onPressedBtnError);
    }
  }

  int indexChipSelect = 0;

  var ChoicechipRangeDateList = <ChoicechipRangeDate>[
    // ChoicechipRangeDate(
    //   label: '1D',
    //   index: 0,
    //   validRange: ValidRangesEnum.one_d,
    // ),
    ChoicechipRangeDate(
      label: '5D',
      index: 0,
      validRange: ValidRangesEnum.five_d,
    ),
    ChoicechipRangeDate(
      label: '1M',
      index: 1,
      validRange: ValidRangesEnum.one_m,
    ),
    ChoicechipRangeDate(
      label: '3M',
      index: 2,
      validRange: ValidRangesEnum.three_m,
    ),
    ChoicechipRangeDate(
      label: '6M',
      index: 3,
      validRange: ValidRangesEnum.six_m,
    ),
    ChoicechipRangeDate(
      label: '1Y',
      index: 4,
      validRange: ValidRangesEnum.one_y,
    ),
    ChoicechipRangeDate(
      label: '2Y',
      index: 5,
      validRange: ValidRangesEnum.two_y,
    ),
    ChoicechipRangeDate(
      label: '5Y',
      index: 6,
      validRange: ValidRangesEnum.five_y,
    ),
    ChoicechipRangeDate(
      label: '10Y',
      index: 7,
      validRange: ValidRangesEnum.ten_y,
    ),
    ChoicechipRangeDate(
      label: 'YTD',
      index: 8,
      validRange: ValidRangesEnum.ytd,
    ),
    ChoicechipRangeDate(
      label: 'Max',
      index: 9,
      validRange: ValidRangesEnum.max,
    ),
  ];

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
      children: [
        Consumer<StocksProvider>(
          builder: (context, controller, child) {
            return stateManagement(
              controller.stateInfoAllRange.value,
              historicalDataPrice,
              _getStockInfoAllRange,
            );
          },
        ),
        Container(
          height: 30,
          color: Colors.black.withAlpha(40),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: ChoicechipRangeDateList.map((chip) {
              return ChoiceChip(
                shape: RoundedRectangleBorder(),
                selected: chip.index == indexChipSelect,
                label: Text(chip.label),
                onSelected: (value) {
                  setState(() {
                    indexChipSelect = chip.index;
                    validRange = chip.validRange;
                  });
                  controller.getStockInfoAllRange(
                      symbol: widget.stockName, range: validRange);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
