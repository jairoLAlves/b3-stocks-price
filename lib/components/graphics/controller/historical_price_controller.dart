import 'package:flutter/foundation.dart';

import '../../../model/choice_chip_range_date_model.dart';
import '../../../util/enums.dart';

class HistoricalPriceController extends ChangeNotifier {
  final choiceChipRangeDateList = <ChoiceChipRangeDate>[
    /*  ChoiceChipRangeDate(
      label: '1D',
      index: 0,
      validRange: ValidRangesEnum.one_d,
    ), */
    ChoiceChipRangeDate(
      label: '5D',
      index: 0,
      validRange: ValidRangesEnum.five_d,
    ),
    ChoiceChipRangeDate(
      label: '1M',
      index: 1,
      validRange: ValidRangesEnum.one_mo,
    ),
    ChoiceChipRangeDate(
      label: '3M',
      index: 2,
      validRange: ValidRangesEnum.three_mo,
    ),
    ChoiceChipRangeDate(
      label: '6M',
      index: 3,
      validRange: ValidRangesEnum.six_mo,
    ),
    ChoiceChipRangeDate(
      label: '1Y',
      index: 4,
      validRange: ValidRangesEnum.one_y,
    ),
    ChoiceChipRangeDate(
      label: '2Y',
      index: 5,
      validRange: ValidRangesEnum.two_y,
    ),
    ChoiceChipRangeDate(
      label: '5Y',
      index: 6,
      validRange: ValidRangesEnum.five_y,
    ),
    ChoiceChipRangeDate(
      label: '10Y',
      index: 7,
      validRange: ValidRangesEnum.ten_y,
    ),
    ChoiceChipRangeDate(
      label: 'YTD',
      index: 8,
      validRange: ValidRangesEnum.ytd,
    ),
    ChoiceChipRangeDate(
      label: 'Max',
      index: 9,
      validRange: ValidRangesEnum.max,
    ),
  ];

  final ValueNotifier<int> indexChipSelect = ValueNotifier<int>(0);

  ChoiceChipRangeDate getChoiceChipRangeDate() =>
      choiceChipRangeDateList[indexChipSelect.value];

  setIndex(int index) {
    indexChipSelect.value = index;
  }

  ChoiceChipRangeDate getChoiceChipSelected() {
    return choiceChipRangeDateList[indexChipSelect.value];
  }

  bool isSelectedItem(int index) => index == indexChipSelect.value;
}
