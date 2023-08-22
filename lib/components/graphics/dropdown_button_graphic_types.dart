import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controllers/theme_controller.dart';
import '../../util/enums.dart';
import 'controller/sf_graphic_controller.dart';
import 'model/dropdown_menu_item_chart.dart';

class DropdownButtonGraphicTypes extends StatefulWidget {
  final SfGraphicController sfGraphicController;

  const DropdownButtonGraphicTypes({
    required this.sfGraphicController,
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownButtonGraphicTypes> createState() =>
      _DropdownButtonGraphicTypesState();
}

class _DropdownButtonGraphicTypesState
    extends State<DropdownButtonGraphicTypes> {
  @override
  void initState() {
    super.initState();
  }

  Widget getWidgetTypesGraphic(TypesGraphic type) => switch (type) {
        TypesGraphic.line => Icon(
            Icons.show_chart,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        TypesGraphic.candle => Icon(
            Icons.candlestick_chart,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        TypesGraphic.hiloOpenClose => ValueListenableBuilder(
            valueListenable: ThemeController.instance.themeLightOrDart,
            builder: (context, value, child) {
              return SvgPicture.asset(widget.sfGraphicController.assetName,
                  height: 36.0,
                  width: 36.0,
                  fit: BoxFit.fitWidth,
                  theme: SvgTheme(
                      currentColor: value ? Colors.white : Colors.black),
                  semanticsLabel: 'barra',
                  colorFilter: ColorFilter.mode(
                      value ? Colors.black : Colors.white, BlendMode.srcIn),
                  placeholderBuilder: (BuildContext context) =>
                      const Center(child: CircularProgressIndicator()));
            },
          ),
      };

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TypesGraphic>(
      valueListenable: widget.sfGraphicController.typeGraphic,
      builder: (context, value, child) => ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 75,
        ),
        child: DropdownButton<DropdownMenuItemChart>(
          isExpanded: true,
          icon: const SizedBox(),
          value: widget.sfGraphicController.dropdownValue.value,
          selectedItemBuilder: (context) {
            return widget.sfGraphicController.listMenuItemChart
                .map<Widget>((DropdownMenuItemChart value) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getWidgetTypesGraphic(value.typeGraphic),
                  ]);
            }).toList();
          },
          onChanged: (DropdownMenuItemChart? value) {
            widget.sfGraphicController.dropdownValue.value = value!;

            widget.sfGraphicController.setTypeGraphic(value.typeGraphic);
          },
          items: widget.sfGraphicController.listMenuItemChart
              .map<DropdownMenuItem<DropdownMenuItemChart>>(
                  (DropdownMenuItemChart value) {
            return DropdownMenuItem<DropdownMenuItemChart>(
              value: value,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getWidgetTypesGraphic(value.typeGraphic),
                    Text(value.title),
                  ]),
            );
          }).toList(),
        ),
      ),
    );
  }
}
