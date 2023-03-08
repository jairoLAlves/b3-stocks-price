import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class SearchInputWidget extends StatelessWidget {
  final void Function(String value) searchStockFilter;
  final void Function() filterList;
  final ValueNotifier<List<String>> stockSymbolList;

  const SearchInputWidget({
    super.key,
    required this.stockSymbolList,
    required this.searchStockFilter,
    required this.filterList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 700,
        minWidth: 100,
      ),
      // Campo de pesquisa
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Autocomplete<String>(
            optionsViewBuilder: (context, onSelected, options) {
              return ValueListenableBuilder(
                valueListenable: stockSymbolList,
                builder: (context, value, child) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 200,
                          maxWidth: 650,
                          minWidth: 100,
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final option = options.elementAt(index);
                            return InkWell(
                              onTap: () {
                                onSelected(option);
                              },
                              child: Builder(builder: (BuildContext context) {
                                final bool highlight =
                                    AutocompleteHighlightedOption.of(context) ==
                                        index;
                                if (highlight) {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback(
                                          (Duration timeStamp) {
                                    Scrollable.ensureVisible(context,
                                        alignment: 0.5);
                                  });
                                }
                                return Container(
                                  color: highlight
                                      ? Theme.of(context).focusColor
                                      : null,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(option),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return stockSymbolList.value.where((String item) =>
                  item.contains(textEditingValue.text.toUpperCase()));
            },
            onSelected: (value) {
              if (value.isNotEmpty) {
                searchStockFilter(value);
              } else {
                filterList();
              }
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController fieldTextEditingController,
                FocusNode fieldFocusNode,
                VoidCallback onFieldSubmitted) {
              return TextField(
                // showCursor: true,
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                style: Theme.of(context).textTheme.titleMedium,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                ],

                decoration: InputDecoration(
                  labelText: 'Search...',
                  contentPadding: const EdgeInsets.all(4),
                  fillColor: Colors.transparent,
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  prefixStyle: Theme.of(context).textTheme.titleMedium,

                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  //Bordas
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: null,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedErrorBorder: null,
                  // disabledBorder:  OutlineInputBorder(
                  //   borderSide : BorderSide(color: Colors.transparent),

                  // ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  //
                  suffixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    searchStockFilter(value);
                  } else {
                    filterList();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
