// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_init_to_null
// ignore: avoid_init_to_null for this file
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/chart_sample_date.dart';
import '../../model/stock.dart';
import '../../providers/stock_info_provaider.dart';
import '../../util/enums.dart';
import '../widgets/error_graphic.dart';
import '../widgets/loading.dart';
import '../widgets/start.dart';
import 'dropdown_button_graphic_types.dart';
import 'historical_price_choicechip.dart';

class SFChartCandle extends StatefulWidget {
  final Stock stock;
  final bool isExpandedGraphic;
  final void Function() fullScreenGraphic;

  const SFChartCandle({
    Key? key,
    required this.stock,
    required this.isExpandedGraphic,
    required this.fullScreenGraphic,
  }) : super(key: key);

  @override
  State<SFChartCandle> createState() => _SFChartCandleState();
}

class _SFChartCandleState extends State<SFChartCandle> {
  late final StockInfoProvider controller;
  late ValueNotifier<ValidRangesEnum> validRange =
      ValueNotifier<ValidRangesEnum>(ValidRangesEnum.five_d);


  late List<ChartSampleDate> _listDate = <ChartSampleDate>[];

  late ChartSeriesController? _chartSeriesControllerCandle = null,
      _chartSeriesControllerHilo = null,
      _chartSeriesControllerLine = null;
  late SelectionBehavior? _selectionBehavior = null;
  late ZoomPanBehavior? _zoomPanBehavior = null;
  late TrackballBehavior? _trackballBehavior = null;
  late TooltipBehavior? _tooltipBehavior = null;

  ValueNotifier<TypesGraphic> typeGraphic = ValueNotifier(TypesGraphic.candle);

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      // Enables pinch zooming
      enablePinching: true,

      // Performs zooming on double tap
      enableDoubleTapZooming: true,
      enableSelectionZooming: true,
      selectionRectBorderColor: Colors.black,
      selectionRectBorderWidth: 1,
      selectionRectColor: Colors.grey,
      enableMouseWheelZooming: true,
      enablePanning: true,
    );
    _trackballBehavior = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
      enable: true,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
      ),
      markerSettings: const TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible),
    );
    _selectionBehavior = SelectionBehavior(
      enable: true,
      selectedColor: Colors.red,
      unselectedColor: Colors.grey,
    );

    super.initState();

    controller = context.read<StockInfoProvider>();
    _getStockInfoAllRange();
    controller.stateInfoAllRange.addListener(() {
      _listDate = getDateChandles;
    });
  }

  void animatedGraphic() {
    switch (typeGraphic.value) {
      case TypesGraphic.hiloOpenClose:
        _chartSeriesControllerHilo?.animate();
        break;
      case TypesGraphic.candle:
        _chartSeriesControllerCandle?.animate();
        break;
      case TypesGraphic.line:
        _chartSeriesControllerLine?.animate();
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setTypeGraphic(TypesGraphic type) {
    setState(() => typeGraphic.value = type);
    animatedGraphic();
  }

  List<ChartSampleDate> get getDateChandles {
    return controller
            .getStockInfo(widget.stock.stock)
            .historicalDataPrice
            ?.map<ChartSampleDate>((date) => date.toChartSampleDate)
            .toList() ??
        <ChartSampleDate>[];
  }

  void _getStockInfoAllRange() {
    controller.getStockInfoAllRange(
      symbol: widget.stock.stock,
      range: validRange.value,
    );
  }

  final double height = 108;

  Widget stateManagement(
    StatusGetStocks state,
    Function() onPressedBtnError,
  ) {
    switch (state) {
      case StatusGetStocks.loading:
        return loading();

      case StatusGetStocks.start:
        return start();
      case StatusGetStocks.success:
        return Container(
          //padding: const EdgeInsets.all(4.0),
          child: SfCartesianChart(
            enableAxisAnimation: true,
            tooltipBehavior: _tooltipBehavior,
            annotations: <CartesianChartAnnotation>[
              CartesianChartAnnotation(
                widget: Opacity(
                    opacity: 0.2,
                    child: Text(
                      widget.stock.stock,
                      style: const TextStyle(fontSize: 40),
                    )),
                region: AnnotationRegion.chart,
                coordinateUnit: CoordinateUnit.percentage,
                x: '50%',
                y: '50%',
              )
            ],

            plotAreaBorderColor: Theme.of(context).colorScheme.onBackground,
            zoomPanBehavior: _zoomPanBehavior,
            trackballBehavior: _trackballBehavior,
            legend: Legend(
              isVisible: false,
              position: LegendPosition.bottom,
            ),
            // indicators: <TechnicalIndicators<ChartSampleDate, DateTime>>[
            //   SmaIndicator<ChartSampleDate, DateTime>(
            //     isVisibleInLegend: true,
            //     signalLineColor: Colors.cyan,
            //     seriesName: 'SMA-9',
            //     period: 9,
            //     valueField: 'close',
            //     animationDuration: 2000,
            //     animationDelay: 1000,
            //     dataSource: _listDate,
            //     xValueMapper: (ChartSampleDate sales, _) => sales.dateTime,
            //     lowValueMapper: (ChartSampleDate sales, _) => sales.low,
            //     highValueMapper: (ChartSampleDate sales, _) => sales.high,
            //     openValueMapper: (ChartSampleDate sales, _) => sales.open,
            //     closeValueMapper: (ChartSampleDate sales, _) => sales.close,
            //   ),
            //   SmaIndicator<ChartSampleDate, DateTime>(
            //     isVisibleInLegend: true,
            //     signalLineColor: Colors.amber,
            //     seriesName: 'SMA-21',
            //     period: 21,
            //     valueField: 'close',
            //     animationDuration: 2000,
            //     animationDelay: 1000,
            //     dataSource: _listDate,
            //     xValueMapper: (ChartSampleDate sales, _) => sales.dateTime,
            //     lowValueMapper: (ChartSampleDate sales, _) => sales.low,
            //     highValueMapper: (ChartSampleDate sales, _) => sales.high,
            //     openValueMapper: (ChartSampleDate sales, _) => sales.open,
            //     closeValueMapper: (ChartSampleDate sales, _) => sales.close,
            //   ),
            //   SmaIndicator<ChartSampleDate, DateTime>(
            //     isVisibleInLegend: true,
            //     signalLineColor: Colors.redAccent,
            //     seriesName: 'SMA-50',
            //     period: 50,
            //     valueField: 'close',
            //     animationDuration: 2000,
            //     animationDelay: 1000,
            //     dataSource: _listDate,
            //     xValueMapper: (ChartSampleDate sales, _) => sales.dateTime,
            //     lowValueMapper: (ChartSampleDate sales, _) => sales.low,
            //     highValueMapper: (ChartSampleDate sales, _) => sales.high,
            //     openValueMapper: (ChartSampleDate sales, _) => sales.open,
            //     closeValueMapper: (ChartSampleDate sales, _) => sales.close,
            //   )
            // ],

            series: <CartesianSeries>[
              if (typeGraphic.value == TypesGraphic.candle)
                CandleSeries<ChartSampleDate, DateTime>(
                  isVisibleInLegend: false,
                  bearColor: Colors.green,
                  bullColor: Colors.red,
                  enableTooltip: true,
                  enableSolidCandles: true,
                  //isVisible: typeGraphic.value == TypesGraphic.candle,
                  animationDuration: 2000,
                  animationDelay: 1000,
                  dataSource: _listDate,
                  xValueMapper: (ChartSampleDate sales, _) => sales.dateTime,
                  lowValueMapper: (ChartSampleDate sales, _) => sales.low,
                  highValueMapper: (ChartSampleDate sales, _) => sales.high,
                  openValueMapper: (ChartSampleDate sales, _) => sales.open,
                  closeValueMapper: (ChartSampleDate sales, _) => sales.close,
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesControllerCandle = controller;
                  },
                ),
              if (typeGraphic.value == TypesGraphic.hiloOpenClose)
                HiloOpenCloseSeries<ChartSampleDate, DateTime>(
                  isVisibleInLegend: false,
                  enableTooltip: true,
                  //isVisible: typeGraphic.value == TypesGraphic.hiloOpenClose,
                  animationDuration: 2000,
                  animationDelay: 1000,
                  dataSource: _listDate,
                  xValueMapper: (ChartSampleDate sales, _) => sales.dateTime,
                  lowValueMapper: (ChartSampleDate sales, _) => sales.low,
                  highValueMapper: (ChartSampleDate sales, _) => sales.high,
                  openValueMapper: (ChartSampleDate sales, _) => sales.open,
                  closeValueMapper: (ChartSampleDate sales, _) => sales.close,
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesControllerHilo = controller;
                  },
                ),
              if (typeGraphic.value == TypesGraphic.line)
                LineSeries<ChartSampleDate, DateTime>(
                  isVisibleInLegend: false,
                  enableTooltip: true,
                  //isVisible: typeGraphic.value == TypesGraphic.line,
                  animationDuration: 2000,
                  animationDelay: 1000,
                  dataSource: _listDate,
                  xValueMapper: (ChartSampleDate sales, _) => sales.dateTime,
                  yValueMapper: (ChartSampleDate sales, _) => sales.close,
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesControllerLine = controller;
                  },
                ),

              // LineSeries<ChartSampleDate, DateTime>(
              //   dataSource: _listDate,
              //   xValueMapper: (ChartSampleDate sales, _) => sales.dateTime,
              //   yValueMapper: (ChartSampleDate sales, _) => sales.close,
              // ),
            ],
            primaryXAxis: DateTimeAxis(
              labelAlignment: LabelAlignment.center,
              plotOffset: 20,
              majorGridLines: const MajorGridLines(
                width: 0,
                color: Colors.transparent,
              ),
              minorGridLines: const MinorGridLines(
                width: 0,
                color: Colors.transparent,
              ),

              // dateFormat: ,
            ),
            primaryYAxis: NumericAxis(
                labelAlignment: LabelAlignment.center,
                opposedPosition: true,
                majorGridLines: const MajorGridLines(
                  width: 0,
                  color: Colors.transparent,
                ),
                minorGridLines: const MinorGridLines(
                  width: 0,
                  color: Colors.transparent,
                ),

                // minimum: 0.01,
                numberFormat: NumberFormat.simpleCurrency(
                    locale: 'pt', decimalDigits: 2)),
            //isTransposed: true,
          ),
        );

      case StatusGetStocks.error:
        return errorGraphic(onPressedBtnError);
    }
  }

  int indexChipSelect = 0;

  void onSelected(int index, ValidRangesEnum validRangeFun) {
    setState(() {
      indexChipSelect = index;
      validRange.value = validRangeFun;
    });
    controller.getStockInfoAllRange(
        symbol: widget.stock.stock, range: validRange.value);
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<StockInfoProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButtonGraphicTypes(
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
