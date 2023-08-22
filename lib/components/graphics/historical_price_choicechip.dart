// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'controller/historical_price_controller.dart';

class HistoricalPriceChoiceChipRangeDate extends StatelessWidget {
  final HistoricalPriceController priceController;

  const HistoricalPriceChoiceChipRangeDate({
    required this.priceController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("HistoricalPriceChoiceChipRangeDate");
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ValueListenableBuilder(
        valueListenable: priceController.indexChipSelect,
        builder: (context, value, child) => Row(
          children: [
            ...priceController.choiceChipRangeDateList.map((chip) {
              var isSelectedItem = priceController.isSelectedItem(chip.index);

              return Container(
                margin: const EdgeInsets.all(2),
                child: ChoiceChip(
                  elevation: 2,
                  pressElevation: 3,
                  shape: const BeveledRectangleBorder(),
                  disabledColor: Theme.of(context).colorScheme.background,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  side: BorderSide.none,
                  selected: isSelectedItem,
                  label: Text(
                    chip.label,
                    style: TextStyle(
                      color: isSelectedItem
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onSelected: (value) {
                    if (!isSelectedItem) {
                      priceController.setIndex(chip.index);
                    }
                  },
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
