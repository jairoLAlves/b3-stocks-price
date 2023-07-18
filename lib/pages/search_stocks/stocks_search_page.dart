import 'package:b3_price_stocks/components/navigation_drawer_principal.dart';
import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:b3_price_stocks/model/stock.dart';
import 'package:b3_price_stocks/providers/stocks_provider.dart';
//import 'package:b3_price_stocks/routes/routes_pages.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/enums.dart';
import 'components/bottom_sheet_search.dart';
import 'components/item_list_stocks.dart';
import 'components/search_input_widget.dart';

class StocksSearchPage extends StatefulWidget {
  const StocksSearchPage({super.key});

  @override
  State<StocksSearchPage> createState() => _StocksSearchPageState();
}

class _StocksSearchPageState extends State<StocksSearchPage> {
  late  StocksProvider stocksProvider;
   final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    stocksProvider = context.read<StocksProvider>();
    stocksProvider.listStocks.addListener(() {
      stocksProvider.stockSymbolList.value =
          stocksProvider.listStocks.value.stockSymbolList();
    });


   

    stocksProvider.loadStocks();
  }

  




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stocksProvider.dispose();
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

  Widget stateManagement() {
    return ValueListenableBuilder<StatusGetStocks>(
      valueListenable: stocksProvider.stateUpdateStocks,
      builder: (context, stateUpdateStocks, child) {
        switch (stateUpdateStocks) {
          case StatusGetStocks.start:
            return _start();

          case StatusGetStocks.loading:
            return _loading();

          case StatusGetStocks.success:
            return ListView.builder(
              itemCount: stocksProvider.listStocks.value.length,
              itemBuilder: (context, index) {
                Stock stock = stocksProvider.listStocks.value.elementAt(index);

                return ItemListStocks(
                  key: ObjectKey(stock),
                  stock: stock,
                );
              },
            );

          case StatusGetStocks.error:
            return _error(stocksProvider.loadStocks);
        }
        ;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isExpanded = MediaQuery.of(context).size.width > 640;
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    stocksProvider = context.watch<StocksProvider>();

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
                        onActionSector:
                            stocksProvider.onActionDropdownMenuItemSectors,
                        onActionSorted:
                            stocksProvider.onActionDropdownMenuItemSorted,
                        sector: stocksProvider.stocksSectors.value,
                        stocksSortBy: stocksProvider.stocksSortBy.value,
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
                  key: refreshIndicatorKey,
                  onRefresh: stocksProvider.loadStocks,
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
                                stockSymbolList: stocksProvider.stockSymbolList,
                                searchStockFilter:
                                    stocksProvider.searchStockFilter,
                                filterList: stocksProvider.filterList,
                              ),
                            ),
                            if (isExpanded)
                              Container(
                                child: IconButton(
                                  onPressed: () => showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) => BottomSheetSearch(
                                      context: ctx,
                                      onActionSector: stocksProvider
                                          .onActionDropdownMenuItemSectors,
                                      onActionSorted: stocksProvider
                                          .onActionDropdownMenuItemSorted,
                                      sector:
                                          stocksProvider.stocksSectors.value,
                                      stocksSortBy:
                                          stocksProvider.stocksSortBy.value,
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
                          animation: stocksProvider.stateUpdateStocks,
                          builder: (context, child) {
                            return stateManagement();
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
