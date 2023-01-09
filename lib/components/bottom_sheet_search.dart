import 'package:flutter/material.dart';

import '../util/enums.dart';

class BottomSheetSearch extends StatelessWidget {
  void Function(sectors sector) onActionSector;
  void Function(StocksSortBy value) onActionSorted;
  BuildContext context;
  sectors sector;
  StocksSortBy stocksSortBy;

  List<sectors> _sectors = [
    sectors.All,
    sectors.Communications,
    sectors.Finance,
    sectors.Retail_Trade,
    sectors.Health_Services,
    sectors.Energy_Minerals,
    sectors.Commercial_Services,
    sectors.Consumer_Non_Durables,
    sectors.Non_Energy_Minerals,
    sectors.Consumer_Services,
    sectors.Process_Industries,
    sectors.Transportation,
    sectors.Utilities,
    sectors.Electronic_Technology,
    sectors.Consumer_Durables,
    sectors.Miscellaneous,
    sectors.Technology_Services,
    sectors.Distribution_Services,
    sectors.Health_Technology,
    sectors.Producer_Manufacturing,
    sectors.Industrial_Services,
    sectors.Others,
  ];

  List<StocksSortBy> _sorted = [
    StocksSortBy.volume,
    StocksSortBy.change,
    StocksSortBy.close,
    StocksSortBy.market_cap_basic,
    StocksSortBy.name,
    StocksSortBy.sector,
    StocksSortBy.stock,
  ];

  BottomSheetSearch({
    required this.onActionSector,
    required this.onActionSorted,
    required this.sector,
    required this.stocksSortBy,
    required this.context,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sectores',
                    style: TextStyle(fontSize: 20),
                  ),
                  //dropdownSectors
                  DropdownButton(
                    value: sector,
                    isExpanded: true,
                    isDense: true,
                    autofocus: true,
                    dropdownColor: Colors.black26,
                    focusColor: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    alignment: Alignment.center,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.7,
                    //
                    selectedItemBuilder: (context) =>
                        _sectors.map((sector) => Text(sector.name)).toList(),
                    items: _sectors
                        .map((sector) => dropdownMenuItemSectors(
                              value: sector,
                            ))
                        .toList(),
                    onChanged: (Object? value) {
                      if (value != null) {
                        setState(() {
                          sector = value as sectors;
                        });
                        onActionSector(value as sectors);
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Order', style: TextStyle(fontSize: 20)),
                  //dropdownorted
                  DropdownButton(
                      value: stocksSortBy,
                      isExpanded: true,
                      isDense: true,
                      autofocus: true,
                      dropdownColor: Colors.black26,
                      focusColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      alignment: Alignment.center,
                      menuMaxHeight: MediaQuery.of(context).size.height * 0.7,
                      //
                      selectedItemBuilder: (context) =>
                          _sorted.map((sortBy) => Text(sortBy.name)).toList(),
                      items: _sorted
                          .map(
                              (sortBy) => dropdownMenuItemSorted(value: sortBy))
                          .toList(),
                      onChanged: (StocksSortBy? newValue) {
                        if (newValue != null) {
                          setState(() {
                            stocksSortBy = newValue;
                          });
                          onActionSorted(newValue);
                        }
                      }),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

DropdownMenuItem<StocksSortBy> dropdownMenuItemSorted({
  required StocksSortBy value,
  bool enabled = true,
}) {
  return DropdownMenuItem(
    value: value,
    enabled: enabled,
    child: Card(
      color: Colors.white,
      elevation: 2,
      child: Container(
        alignment: Alignment.center,
        child: ListTile(title: Text(value.name)),
      ),
    ),
  );
}

DropdownMenuItem<sectors> dropdownMenuItemSectors({
  required sectors value,
  bool enabled = true,
}) {
  return DropdownMenuItem(
    value: value,
    enabled: enabled,
    child: Card(
      color: Colors.white,
      elevation: 2,
      child: Container(
        alignment: Alignment.center,
        child: ListTile(title: Text(value.name.replaceAll('_', ' '))),
      ),
    ),
  );
}
