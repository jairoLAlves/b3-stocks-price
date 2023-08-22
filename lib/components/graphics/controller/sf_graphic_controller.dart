import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/chart_sample_date.dart';
import '../../../model/stock_info_model.dart';
import '../../../util/enums.dart';
import '../model/dropdown_menu_item_chart.dart';

class SfGraphicController extends ChangeNotifier {
  final String assetName = 'assets/images/barras.svg';

  ValueNotifier<StockInfoModel?> stockInfo = ValueNotifier(null);
  ValueNotifier<List<ChartSampleDate>> listDateCandle = ValueNotifier([]);
  ValueNotifier<ValidRangesEnum> validRange =
      ValueNotifier<ValidRangesEnum>(ValidRangesEnum.five_d);
  ValueNotifier<ValidIntervalEnum> validInterval =
      ValueNotifier<ValidIntervalEnum>(ValidIntervalEnum.one_d);
  ValueNotifier<StatusGetStocks> status =
      ValueNotifier<StatusGetStocks>(StatusGetStocks.start);
  ValueNotifier<TypesGraphic> typeGraphic = ValueNotifier(TypesGraphic.line);
  ValueNotifier<double> max = ValueNotifier<double>(1000);
  ValueNotifier<double> min = ValueNotifier<double>(1);
  ValueNotifier<double> media = ValueNotifier<double>(500);

  List<DropdownMenuItemChart> listMenuItemChart = [
    DropdownMenuItemChart(typeGraphic: TypesGraphic.candle, title: "Velas"),
    DropdownMenuItemChart(
        typeGraphic: TypesGraphic.hiloOpenClose, title: "Barras"),
    DropdownMenuItemChart(typeGraphic: TypesGraphic.line, title: "Linha"),
  ];

  ValueNotifier<DropdownMenuItemChart?> dropdownValue = ValueNotifier(null);

  DropdownMenuItemChart? getDropdownMenuItemChart(TypesGraphic type) {
    DropdownMenuItemChart? result;

    try {
      result = listMenuItemChart.firstWhere(
        (element) => element.typeGraphic == type,
      );
    } catch (e) {
      result = null;
    }

    return result;
  }

  void setTypeGraphic(TypesGraphic type) async {
    status.value = StatusGetStocks.loading;
    typeGraphic.value = type;

    await Future.delayed(const Duration(seconds: 2));
    status.value = StatusGetStocks.success;
  }

  void setOrientations() {
    if (isFullScreenGraphic.value) {
      setFullScreen();
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    }
  }

  void setFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  ValueNotifier<bool> isFullScreenGraphic = ValueNotifier<bool>(false);

  void setFullScreenGraphic() {
    isFullScreenGraphic.value = !isFullScreenGraphic.value;
    setOrientations();
  }

  ChartSeriesController? chartSeriesControllerCandle,
      chartSeriesControllerHilo,
      chartSeriesControllerLine;

  SelectionBehavior? selectionBehavior;

  ZoomPanBehavior? zoomPanBehavior;

  TrackballBehavior? trackballBehavior;

  TooltipBehavior? tooltipBehavior;

  void animatedGraphic() {
    switch (typeGraphic.value) {
      case TypesGraphic.hiloOpenClose:
        chartSeriesControllerHilo?.animate();
      case TypesGraphic.candle:
        chartSeriesControllerCandle?.animate();
      case TypesGraphic.line:
        chartSeriesControllerLine?.animate();
    }
  }
}
