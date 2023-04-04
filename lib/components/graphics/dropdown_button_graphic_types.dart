
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controllers/theme_controller.dart';
import '../../util/enums.dart';
import 'model/dropdown_menu_item_chart.dart';

class DropdownButtonGraphicTypes extends StatefulWidget {
  final Function(TypesGraphic type) setTypeGraphic;
  const DropdownButtonGraphicTypes({
    Key? key,
    required this.setTypeGraphic,
  }) : super(key: key);

  @override
  State<DropdownButtonGraphicTypes> createState() => _DropdownButtonGraphicTypesState();
}

class _DropdownButtonGraphicTypesState extends State<DropdownButtonGraphicTypes> {
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
