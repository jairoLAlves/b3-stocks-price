// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_init_to_null, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace
// ignore: avoid_init_to_null for this file
import 'dart:async';

import 'package:b3_price_stocks/components/widgets/error_graphic.dart';
import 'package:b3_price_stocks/components/widgets/loading.dart';
import 'package:b3_price_stocks/components/widgets/start.dart';
import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/chart_sample_date.dart';
import '../../pages/search_stocks/controller/item_list_stock_controller.dart';
import '../../providers/stock_info_provaider.dart';
import '../../util/enums.dart';
import 'controller/historical_price_controller.dart';
import 'controller/sf_graphic_controller.dart';
import 'dropdown_button_graphic_types.dart';
import 'historical_price_ChoiceChip.dart';

class SFChartCandle extends StatefulWidget {
  final ItemListStockController stockController;
  const SFChartCandle(this.stockController, {super.key});

  @override
  State<SFChartCandle> createState() => _SFChartCandleState();
}

class _SFChartCandleState extends State<SFChartCandle> {
  // Controllers
  late StockInfoProvider controller;

  late SfGraphicController sfGraphicController;

  late HistoricalPriceController priceController;

  ///--------------------
  ///

  void updateGraphic() async {
    sfGraphicController.status.value = StatusGetStocks.loading;
    final (:stockInfo, :listHistoricalDataPrice, :status) =
        await controller.getHistoricalDataPrice(
      interval: sfGraphicController.validInterval.value,
      range: sfGraphicController.validRange.value,
      symbol: widget.stockController.stock.stock,
    );

    sfGraphicController.stockInfo.value = stockInfo;
    sfGraphicController.status.value = status;

    /*  sfGraphicController.typeGraphic.addListener(() {
      setState(() {});
    }); */

    sfGraphicController.listDateCandle.value = listHistoricalDataPrice
        .map<ChartSampleDate>((date) => date.toChartSampleDate)
        .toList();

    final (:min, :max, :media) =
        sfGraphicController.listDateCandle.value.getMinMaxMedia();

    sfGraphicController.min.value = min;
    sfGraphicController.max.value = max;
    sfGraphicController.media.value = media;
  }

  @override
  void initState() {
    super.initState();

    controller = context.read<StockInfoProvider>();

    sfGraphicController = SfGraphicController();

    priceController = HistoricalPriceController();

    sfGraphicController.dropdownValue.value = sfGraphicController
        .getDropdownMenuItemChart(sfGraphicController.typeGraphic.value);

    updateGraphic();

    priceController.indexChipSelect.addListener(() {
      sfGraphicController.validRange.value =
          priceController.getChoiceChipRangeDate().validRange;

      updateGraphic();
    });

    sfGraphicController.isFullScreenGraphic.addListener(() async {
      if (sfGraphicController.isFullScreenGraphic.value) {
        await Future(() => showCupertinoModalPopup(
              // barrierDismissible: true,

              context: context,
              builder: (context) => pageGraphic(context),
            ));
      } else {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
    });

    Future(() {
      sfGraphicController.tooltipBehavior = TooltipBehavior(
        enable: true,
      );
      sfGraphicController.zoomPanBehavior = ZoomPanBehavior(
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
      sfGraphicController.trackballBehavior = TrackballBehavior(
        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
        enable: true,
        tooltipSettings: const InteractiveTooltip(
          enable: true,
        ),
        markerSettings: const TrackballMarkerSettings(
            markerVisibility: TrackballVisibilityMode.visible),
      );
      sfGraphicController.selectionBehavior = SelectionBehavior(
        enable: true,
        selectedColor: Colors.red,
        unselectedColor: Colors.grey,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final double height = 108;

  Widget stateManagement() {
    return ValueListenableBuilder(
        valueListenable: sfGraphicController.status,
        builder: (context, status, child) => switch (status) {
              StatusGetStocks.error => errorGraphic(() => updateGraphic()),
              StatusGetStocks.start => start(),
              StatusGetStocks.loading => loading(),
              StatusGetStocks.success => ValueListenableBuilder(
                  valueListenable: sfGraphicController.listDateCandle,
                  builder: (context, data, child) => SfCartesianChart(
                    enableAxisAnimation: true,
                    tooltipBehavior: sfGraphicController.tooltipBehavior,
                    annotations: <CartesianChartAnnotation>[
                      CartesianChartAnnotation(
                        widget: Opacity(
                            opacity: 0.5,
                            child: Text(
                              widget.stockController.stock.stock,
                              style: const TextStyle(fontSize: 20),
                            )),
                        region: AnnotationRegion.chart,
                        coordinateUnit: CoordinateUnit.percentage,
                        x: '50%',
                        y: '50%',
                      )
                    ],

                    plotAreaBorderColor:
                        Theme.of(context).colorScheme.onBackground,
                    //zoomPanBehavior: sfGraphicController.zoomPanBehavior,
                    // trackballBehavior: sfGraphicController.trackballBehavior,
                    legend: Legend(
                      isVisible: false,
                      position: LegendPosition.bottom,
                    ),

                    series: <CartesianSeries>[
                      switch (sfGraphicController.typeGraphic.value) {
                        TypesGraphic.candle =>
                          CandleSeries<ChartSampleDate, DateTime>(
                            isVisibleInLegend: false,
                            bearColor: Colors.green,
                            bullColor: Colors.red,
                            enableTooltip: true,
                            enableSolidCandles: true,
                            //isVisible: typeGraphic.value == TypesGraphic.candle,
                            animationDuration: 2000,
                            animationDelay: 1000,
                            dataSource: data,
                            xValueMapper: (ChartSampleDate sales, _) =>
                                sales.dateTime,
                            lowValueMapper: (ChartSampleDate sales, _) =>
                                sales.low,
                            highValueMapper: (ChartSampleDate sales, _) =>
                                sales.high,
                            openValueMapper: (ChartSampleDate sales, _) =>
                                sales.open,
                            closeValueMapper: (ChartSampleDate sales, _) =>
                                sales.close,
                            onRendererCreated:
                                (ChartSeriesController controller) {
                              sfGraphicController.chartSeriesControllerCandle =
                                  controller;
                            },
                          ),
                        TypesGraphic.hiloOpenClose =>
                          HiloOpenCloseSeries<ChartSampleDate, DateTime>(
                            isVisibleInLegend: false,
                            enableTooltip: true,
                            //isVisible: typeGraphic.value == TypesGraphic.hiloOpenClose,
                            animationDuration: 2000,
                            animationDelay: 1000,
                            dataSource: data,
                            xValueMapper: (ChartSampleDate sales, _) =>
                                sales.dateTime,
                            lowValueMapper: (ChartSampleDate sales, _) =>
                                sales.low,
                            highValueMapper: (ChartSampleDate sales, _) =>
                                sales.high,
                            openValueMapper: (ChartSampleDate sales, _) =>
                                sales.open,
                            closeValueMapper: (ChartSampleDate sales, _) =>
                                sales.close,
                            onRendererCreated:
                                (ChartSeriesController controller) {
                              sfGraphicController.chartSeriesControllerHilo =
                                  controller;
                            },
                          ),
                        TypesGraphic.line =>
                          LineSeries<ChartSampleDate, DateTime>(
                            isVisibleInLegend: false,
                            enableTooltip: true,
                            //isVisible: typeGraphic.value == TypesGraphic.line,
                            animationDuration: 2000,
                            animationDelay: 1000,
                            dataSource: data,
                            xValueMapper: (ChartSampleDate sales, _) =>
                                sales.dateTime,
                            yValueMapper: (ChartSampleDate sales, _) =>
                                sales.close,
                            onRendererCreated:
                                (ChartSeriesController controller) {
                              sfGraphicController.chartSeriesControllerLine =
                                  controller;
                            },
                          ),
                      }
                    ],
                    primaryXAxis: DateTimeAxis(
                      // intervalType: DateTimeIntervalType.days,
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
                      // isVisible: false,
                      maximum: sfGraphicController.min.value,
                      minimum: sfGraphicController.max.value,

                      decimalPlaces: 2,
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
                        locale: 'pt',
                        decimalDigits: 2,
                      ),
                    ),
                    //isTransposed: true,
                  ),
                )
            });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("_SFChartCandleState");

    return pageGraphic(context);
  }

  Scaffold pageGraphic(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButtonGraphicTypes(
              sfGraphicController: sfGraphicController,
            ),
            ValueListenableBuilder(
              valueListenable: sfGraphicController.isFullScreenGraphic,
              builder: (context, value, child) => IconButton(
                onPressed: () async {
                  sfGraphicController.setFullScreenGraphic();
                },
                icon: Icon(value ? Icons.fullscreen_exit : Icons.fullscreen),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: showWidgetGraphic(),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.bottomCenter,
        height: 30,
        //color: Colors.black.withAlpha(40),
        child: HistoricalPriceChoiceChipRangeDate(
          priceController: priceController,
        ),
      ),
    );
  }

  Widget showWidgetGraphic() {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: stateManagement(),
    );
  }
}
