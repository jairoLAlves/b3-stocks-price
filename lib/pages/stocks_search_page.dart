import 'package:b3_price_stocks/components/navigation_drawer_principal.dart';
import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:b3_price_stocks/model/stock.dart';
import 'package:b3_price_stocks/providers/stocks_provider.dart';
//import 'package:b3_price_stocks/routes/routes_pages.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../components/bottom_sheet_search.dart';
import '../components/item_list_stocks.dart';
import '../util/enums.dart';

class StocksSearchPage extends StatefulWidget {
  const StocksSearchPage({super.key});

  @override
  State<StocksSearchPage> createState() => _StocksSearchPageState();
}

class _StocksSearchPageState extends State<StocksSearchPage> {
  late final controllerStock;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final ValueNotifier<List<Stock>> _listStocksHome = ValueNotifier(<Stock>[]);
  final ValueNotifier<List<String>> stockSymbolList = ValueNotifier(<String>[]);
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    _listStocksHome.addListener(() {
      stockSymbolList.value = _listStocksHome.value.stockSymbolList();
      // print(stockSymbolList.value);
    });

    //loadList();
    controllerStock = context.read<StocksProvider>();

    controllerStock.updateStocks().then((value) {
      setState(() {
        isloading = false;
        _listStocksHome.value = value;
      });
    });
  }

  Future<void> loadList() async {
    context.read<StocksProvider>().updateStocks().then((value) {
      setState(() {
        isloading = false;
        _listStocksHome.value = value;
      });
    });
  }

  final ValueNotifier _stocksSortBy =
      ValueNotifier<StocksSortBy>(StocksSortBy.volume);

  final ValueNotifier _stocksSectors = ValueNotifier<sectors>(sectors.All);

  searchStockFilter(String value) {
    setState(() {
      _listStocksHome.value =
          Provider.of<StocksProvider>(context, listen: false)
              .searchStockFilter(value, _stocksSectors.value);
      _listStocksHome.value.sortOrderStocks(_stocksSortBy.value);
    });
  }

  filterlist() {
    setState(() {
      _listStocksHome.value =
          Provider.of<StocksProvider>(context, listen: false)
              .filterListStocks(_stocksSectors.value);
      _listStocksHome.value.sortOrderStocks(_stocksSortBy.value);
    });
  }

  sortedList() {
    setState(() {
      _listStocksHome.value.sortOrderStocks(_stocksSortBy.value);
    });
  }

  void onActionDropdownMenuItemSorted(StocksSortBy stocksSortBy) {
    setState(() {
      _stocksSortBy.value = stocksSortBy;
    });
    sortedList();
  }

  void onActionDropdownMenuItemSectors(sectors sector) {
    setState(() {
      _stocksSectors.value = sector;
    });
    filterlist();
  }

  Widget _start() {
    return Container();
  }

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _error(Function() onPressedBtnError) {
    return Center(
        child: ElevatedButton(
      onPressed: onPressedBtnError,
      child: const Text('Tente Novamente'),
    ));
  }

  Widget stateManagement(StatusGetStocks state) {
    switch (state) {
      case StatusGetStocks.start:
        return _start();
      case StatusGetStocks.loading:
        return _loading();
      case StatusGetStocks.success:
        return ListView.builder(
          itemCount: _listStocksHome.value.length,
          itemBuilder: (context, index) {
            Stock stock = _listStocksHome.value.elementAt(index);

            return ItemListStocks(
              key: ObjectKey(stock),
              stock: stock,
            );
          },
        );
      case StatusGetStocks.error:
        return _error(loadList);
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<StocksProvider>();

    final isExpanded = MediaQuery.of(context).size.width > 640;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        drawer: isExpanded ? null : const NavigationDrawerPrincipal(),
        appBar: isExpanded
            ? null
            : AppBar(
                actions: [
                  IconButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (ctx) => BottomSheetSearch(
                        context: ctx,
                        onActionSector: onActionDropdownMenuItemSectors,
                        onActionSorted: onActionDropdownMenuItemSorted,
                        sector: _stocksSectors.value,
                        stocksSortBy: _stocksSortBy.value,
                      ),
                    ),
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
        body: SafeArea(
          child: Row(
            children: [
              if (isExpanded) const NavigationDrawerPrincipal(),
              Expanded(
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: loadList,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Container(
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
                                      optionsMaxHeight: 100,
                                      optionsViewBuilder:
                                          (context, onSelected, options) {
                                        return ValueListenableBuilder(
                                          valueListenable: stockSymbolList,
                                          builder: (context, value, child) {
                                            return Align(
                                              alignment: Alignment.topLeft,
                                              child: Material(
                                                elevation: 4.0,
                                                child: ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                    maxHeight: 200,
                                                    maxWidth: 650,
                                                    minWidth: 100,
                                                  ),
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    itemCount: options.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final option = options
                                                          .elementAt(index);
                                                      return InkWell(
                                                        onTap: () {
                                                          onSelected(option);
                                                        },
                                                        child: Builder(builder:
                                                            (BuildContext
                                                                context) {
                                                          final bool highlight =
                                                              AutocompleteHighlightedOption.of(
                                                                      context) ==
                                                                  index;
                                                          if (highlight) {
                                                            SchedulerBinding
                                                                .instance
                                                                .addPostFrameCallback(
                                                                    (Duration
                                                                        timeStamp) {
                                                              Scrollable
                                                                  .ensureVisible(
                                                                      context,
                                                                      alignment:
                                                                          0.5);
                                                            });
                                                          }
                                                          return Container(
                                                            color: highlight
                                                                ? Theme.of(
                                                                        context)
                                                                    .focusColor
                                                                : null,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
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
                                        return stockSymbolList.value.where(
                                            (String item) => item.contains(
                                                textEditingValue.text
                                                    .toUpperCase()));
                                      },
                                      onSelected: (value) {
                                        if (value.isNotEmpty) {
                                          searchStockFilter(value);
                                        } else {
                                          filterlist();
                                        }
                                      },
                                      fieldViewBuilder: (BuildContext context,
                                          TextEditingController
                                              fieldTextEditingController,
                                          FocusNode fieldFocusNode,
                                          VoidCallback onFieldSubmitted) {
                                        return TextField(
                                          // showCursor: true,
                                          controller:
                                              fieldTextEditingController,
                                          focusNode: fieldFocusNode,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[a-zA-Z0-9]')),
                                          ],

                                          decoration: InputDecoration(
                                            labelText: 'Search...',
                                            contentPadding:
                                                const EdgeInsets.all(4),
                                            fillColor: Colors.transparent,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                            prefixStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium,

                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            filled: true,
                                            //Bordas
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                            ),
                                            errorBorder: null,
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                            ),
                                            focusedErrorBorder: null,
                                            // disabledBorder:  OutlineInputBorder(
                                            //   borderSide : BorderSide(color: Colors.transparent),

                                            // ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                            ),
                                            //
                                            suffixIcon:
                                                const Icon(Icons.search),
                                          ),
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              searchStockFilter(value);
                                            } else {
                                              filterlist();
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (isExpanded)
                              Container(
                                child: IconButton(
                                  onPressed: () => showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) => BottomSheetSearch(
                                      context: ctx,
                                      onActionSector:
                                          onActionDropdownMenuItemSectors,
                                      onActionSorted:
                                          onActionDropdownMenuItemSorted,
                                      sector: _stocksSectors.value,
                                      stocksSortBy: _stocksSortBy.value,
                                    ),
                                  ),
                                  icon: const Icon(Icons.settings),
                                ),
                              )
                          ],
                        ),
                      ),
                      Expanded(
                        child: AnimatedBuilder(
                          animation: controller.stateUpdateStocks,
                          builder: (context, child) {
                            return stateManagement(
                                controller.stateUpdateStocks.value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
