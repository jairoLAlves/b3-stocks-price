import 'package:flutter/material.dart';

import '../util/enums.dart';
import '../model/choice_chip_range_date_model.dart';

class HistoricalPriceChoicechipRangeDate extends StatelessWidget {
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

  final int indexChipSelect;
  final void Function(int index, ValidRangesEnum validRangeFun) onSelected;

  HistoricalPriceChoicechipRangeDate(
      {required this.indexChipSelect, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: ChoicechipRangeDateList.map((chip) {
        return ChoiceChip(
          shape: RoundedRectangleBorder(),
          selected: chip.index == indexChipSelect,
          label: Text(chip.label),
          onSelected: (value) {
            onSelected(
              chip.index,
              chip.validRange,
            );
          },
          // onSelected: (value) {
          //   setState(() {
          //     indexChipSelect = chip.index;
          //     validRange = chip.validRange;
          //   });
          //   controller.getStockInfoAllRange(
          //       symbol: widget.stockName, range: validRange);
          // },
        );
      }).toList(),
    );
  }
}