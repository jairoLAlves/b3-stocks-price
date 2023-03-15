// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:b3_price_stocks/controllers/theme_controller.dart';

import '../../model/chart_sample_date.dart';
import '../../model/stock_info_model.dart';
import '../../providers/stock_info_provaider.dart';
import '../../util/enums.dart';
import 'historical_price_choicechip.dart';

class SFChartCandle extends StatefulWidget {
  final String stockName;
  final bool isExpandedGraphic;
  final void Function() fullScreenGraphic;

  const SFChartCandle({
    Key? key,
    required this.stockName,
    required this.isExpandedGraphic,
    required this.fullScreenGraphic,
  }) : super(key: key);

  @override
  State<SFChartCandle> createState() => _SFChartCandleState();
}

class _SFChartCandleState extends State<SFChartCandle> {
  late final StockInfoProvider controller;
  late ValidRangesEnum validRange = ValidRangesEnum.five_d;
  late List<ChartSampleDate> _listDate = <ChartSampleDate>[];

  ValueNotifier<TypesGraphic> typeGraphic = ValueNotifier(TypesGraphic.candle);

  @override
  void initState() {
    super.initState();
    controller = context.read<StockInfoProvider>();
    _getStockInfoAllRange();
    controller.stateInfoAllRange.addListener(() {
      _listDate = getDateChandles;
      // print(_listDate);
    });

    //stateInfoAllRange
  }

  void setTypeGraphic(TypesGraphic type) =>
      setState(() => typeGraphic.value = type);

  List<ChartSampleDate> get getDateChandles {
    return controller
            .getStockInfo(widget.stockName)
            .historicalDataPrice
            ?.map<ChartSampleDate>((date) => date.toChartSampleDate)
            .toList() ??
        <ChartSampleDate>[];
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
    return SizedBox(
      height: height,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _error(Function() onPressedBtnError) {
    return SizedBox(
      height: height,
      child: Center(
          child: ElevatedButton(
        onPressed: onPressedBtnError,
        child: const Text('Tente Novamente'),
      )),
    );
  }

  Widget stateManagement(
    StatusGetStocks state,
    Function() onPressedBtnError,
  ) {
    switch (state) {
      case StatusGetStocks.loading:
        return _loading();

      case StatusGetStocks.start:
        return _start();
      case StatusGetStocks.success:
        return Container(
          //padding: const EdgeInsets.all(4.0),
          child: SfCartesianChart(
            series: <CartesianSeries>[
              if (typeGraphic.value == TypesGraphic.candle)
                CandleSeries<ChartSampleDate, DateTime>(
                  dataSource: _listDate,
                  xValueMapper: (ChartSampleDate sales, _) => sales.dateTime,
                  lowValueMapper: (ChartSampleDate sales, _) => sales.low,
                  highValueMapper: (ChartSampleDate sales, _) => sales.high,
                  openValueMapper: (ChartSampleDate sales, _) => sales.open,
                  closeValueMapper: (ChartSampleDate sales, _) => sales.close,
                ),
              if (typeGraphic.value == TypesGraphic.hiloOpenClose)
                HiloOpenCloseSeries<ChartSampleDate, DateTime>(
                  dataSource: _listDate,
                  xValueMapper: (ChartSampleDate sales, _) => sales.dateTime,
                  lowValueMapper: (ChartSampleDate sales, _) => sales.low,
                  highValueMapper: (ChartSampleDate sales, _) => sales.high,
                  openValueMapper: (ChartSampleDate sales, _) => sales.open,
                  closeValueMapper: (ChartSampleDate sales, _) => sales.close,
                ),
                 if (typeGraphic.value == TypesGraphic.line)
                LineSeries<ChartSampleDate, DateTime>(

                  dataSource: _listDate,
                  xValueMapper: (ChartSampleDate sales, _) => sales.dateTime,
                  yValueMapper: (ChartSampleDate sales, _) => sales.close,
                ),


              // LineSeries<ChartSampleDate, DateTime>(
              //   dataSource: _listDate,
              //   xValueMapper: (ChartSampleDate sales, _) => sales.dateTime,
              //   yValueMapper: (ChartSampleDate sales, _) => sales.close,
              // ),
            ],
            primaryXAxis: DateTimeAxis(
                // dateFormat: ,
                ),
            primaryYAxis: NumericAxis(
                // minimum: 0.01,
                numberFormat: NumberFormat.simpleCurrency(decimalDigits: 2)),
            //isTransposed: true,
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
    var controller = context.watch<StockInfoProvider>();
    StockInfoModel stockInfo = controller.getStockInfo(widget.stockName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButtonExample(
              setTypeGraphic: setTypeGraphic,
            ),
            IconButton(
              onPressed: widget.fullScreenGraphic,
              icon: Icon(widget.isExpandedGraphic
                  ? Icons.fullscreen_exit
                  : Icons.fullscreen),
            )
          ],
        ),
        Expanded(
          child: Consumer<StockInfoProvider>(
            builder: (context, controller, child) {
              return AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: stateManagement(
                  controller.stateInfoAllRange.value,
                  _getStockInfoAllRange,
                ),
              );
            },
          ),
        ),
        SizedBox(
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

enum TypesGraphic {
  hiloOpenClose,
  candle,
  line,
}

class DropdownMenuItemChart {
  Widget widget;
  String title;
  TypesGraphic typeGraphic;

  DropdownMenuItemChart({
    required this.widget,
    required this.title,
    required this.typeGraphic,
  });
}

class DropdownButtonExample extends StatefulWidget {
  final Function(TypesGraphic type) setTypeGraphic;
  const DropdownButtonExample({
    Key? key,
    required this.setTypeGraphic,
  }) : super(key: key);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  late ValueNotifier<DropdownMenuItemChart?> dropdownValue =
      ValueNotifier(null);
  final String assetName = 'assets/images/barras.svg';

  List<DropdownMenuItemChart> listaMenuChart = <DropdownMenuItemChart>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listaMenuChart = <DropdownMenuItemChart>[
      DropdownMenuItemChart(
          typeGraphic: TypesGraphic.candle,
          widget: const Icon(Icons.candlestick_chart),
          title: "Velas"),
      DropdownMenuItemChart(
          typeGraphic: TypesGraphic.hiloOpenClose,
          widget: ValueListenableBuilder(
            valueListenable: ThemeController.instance.themeLightOrDart,
            builder: (context, value, child) {
              return SvgPicture.asset(assetName,
                  height: 36.0,
                  width: 36.0,
                  fit: BoxFit.fitWidth,
                  theme: SvgTheme(
                      currentColor: value ? Colors.black : Colors.white),
                  semanticsLabel: 'barra',
                  colorFilter: ColorFilter.mode(
                      value ? Colors.black : Colors.white, BlendMode.srcIn),
                  placeholderBuilder: (BuildContext context) =>
                      const Center(child: CircularProgressIndicator()));
            },
          ),
          title: "Barras"),
      DropdownMenuItemChart(
          typeGraphic: TypesGraphic.line,
          widget: const Icon(Icons.show_chart),
          title: "Linha"),
    ];
    dropdownValue.value = listaMenuChart.first;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 50,
        maxWidth: 100,
        minHeight: 50,
      ),
      child: DropdownButton<DropdownMenuItemChart>(
        isExpanded: true,
        icon: const SizedBox(),
        value: dropdownValue.value,
        selectedItemBuilder: (context) {
          return listaMenuChart.map<Widget>((DropdownMenuItemChart value) {
            return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              value.widget,
            ]);
          }).toList();
        },
        onChanged: (DropdownMenuItemChart? value) {
          setState(() {
            dropdownValue.value = value!;
          });
          if (value != null) {
            widget.setTypeGraphic(value.typeGraphic);
          }
        },
        items: listaMenuChart.map<DropdownMenuItem<DropdownMenuItemChart>>(
            (DropdownMenuItemChart value) {
          return DropdownMenuItem<DropdownMenuItemChart>(
            value: value,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  value.widget,
                  Text(value.title),
                ]),
          );
        }).toList(),
      ),
    );
  }
}
