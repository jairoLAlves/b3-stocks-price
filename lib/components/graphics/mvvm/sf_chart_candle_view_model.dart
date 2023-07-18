import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import '../../../model/chart_sample_date.dart';
import '../../../model/stock.dart';
import '../../../providers/stock_info_provaider.dart';
import '../../../util/enums.dart';

class SfChartCandleViewModel extends ChangeNotifier {
  late final Stock stock;
  late final StockInfoProvider controller;
  late final BuildContext context;

  late ValueNotifier<ValidRangesEnum> validRange =
      ValueNotifier<ValidRangesEnum>(ValidRangesEnum.five_d);

  late ValueNotifier<List<ChartSampleDate>> listDate =
      ValueNotifier<List<ChartSampleDate>>(<ChartSampleDate>[]);

  late ChartSeriesController? chartSeriesControllerCandle = null,
      chartSeriesControllerHilo = null,
      chartSeriesControllerLine = null;

  late SelectionBehavior? selectionBehavior = null;

  late ZoomPanBehavior? zoomPanBehavior = null;

  late TrackballBehavior? trackballBehavior = null;

  late TooltipBehavior? tooltipBehavior = null;

  ValueNotifier<TypesGraphic> typeGraphic = ValueNotifier(TypesGraphic.candle);

  SfChartCandleViewModel({required this.stock, required this.context}) {
    controller = context.read<StockInfoProvider>();

    getStockInfoAllRange();

    controller.stateInfoAllRange.addListener(() {
      listDate.value = getDateChandles;
    });

    tooltipBehavior = TooltipBehavior(
      enable: true,
    );
    zoomPanBehavior = ZoomPanBehavior(
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
    trackballBehavior = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
      enable: true,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
      ),
      markerSettings: const TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible),
    );
    selectionBehavior = SelectionBehavior(
      enable: true,
      selectedColor: Colors.red,
      unselectedColor: Colors.grey,
    );
  }
  List<ChartSampleDate> get getDateChandles {
    return controller
            .getStockInfo(stock.stock)
            .historicalDataPrice
            ?.map<ChartSampleDate>((date) => date.toChartSampleDate)
            .toList() ??
        <ChartSampleDate>[];
  }

  void getStockInfoAllRange() {
    controller.getStockInfoAllRange(
      symbol: stock.stock,
      range: validRange.value,
    );
  }

  void setTypeGraphic(TypesGraphic type) {
    typeGraphic.value = type;
    // animatedGraphic();
    notifyListeners();
  }

  void animatedGraphic() {
    switch (typeGraphic.value) {
      case TypesGraphic.hiloOpenClose:
        chartSeriesControllerHilo?.animate();
        break;
      case TypesGraphic.candle:
        chartSeriesControllerCandle?.animate();
        break;
      case TypesGraphic.line:
        chartSeriesControllerLine?.animate();
        break;
    }
  }
}
