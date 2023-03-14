import 'package:b3_price_stocks/components/navigation_drawer_principal.dart';
import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:b3_price_stocks/model/stock.dart';
import 'package:b3_price_stocks/providers/stocks_provider.dart';
//import 'package:b3_price_stocks/routes/routes_pages.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'components/bottom_sheet_search.dart';
import 'components/item_list_stocks.dart';
import 'components/search_input_widget.dart';
import '../../util/enums.dart';

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
  ValueNotifier<bool> isLoading = ValueNotifier(true);

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
        isLoading.value = false;
        _listStocksHome.value = value;
      });
    });
  }

  Future<void> loadList() async {
    context.read<StocksProvider>().updateStocks().then((value) {
      setState(() {
        isLoading.value = false;
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

  filterList() {
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
    filterList();
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
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

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
                            vertical: 8, horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: SearchInputWidget(
                                stockSymbolList: stockSymbolList,
                                searchStockFilter: searchStockFilter,
                                filterList: filterList,
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
