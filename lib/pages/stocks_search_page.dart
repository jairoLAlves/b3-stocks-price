import 'package:b3_price_stocks/components/navigation_drawer_principal.dart';
import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:b3_price_stocks/model/stock.dart';
import 'package:b3_price_stocks/providers/stocks_provider.dart';
//import 'package:b3_price_stocks/routes/routes_pages.dart';

import 'package:flutter/material.dart';

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

  List<Stock> _listStocksHome = <Stock>[];
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    //loadList();
    controllerStock = context.read<StocksProvider>();

    controllerStock.updateStocks().then((value) {
      setState(() {
        isloading = false;
        _listStocksHome = value;
      });
    });
  }

  Future<void> loadList() async {
    context.read<StocksProvider>().updateStocks().then((value) {
      setState(() {
        isloading = false;
        _listStocksHome = value;
      });
    });
  }

  ValueNotifier _stocksSortBy =
      ValueNotifier<StocksSortBy>(StocksSortBy.volume);

  ValueNotifier _stocksSectors = ValueNotifier<sectors>(sectors.All);

  searchStockFilter(String value) {
    setState(() {
      _listStocksHome = Provider.of<StocksProvider>(context, listen: false)
          .searchStockFilter(value, _stocksSectors.value);
      _listStocksHome.sortOrderStocks(_stocksSortBy.value);
    });
  }

  filterlist() {
    setState(() {
      _listStocksHome = Provider.of<StocksProvider>(context, listen: false)
          .filterListStocks(_stocksSectors.value);
      _listStocksHome.sortOrderStocks(_stocksSortBy.value);
    });
  }

  sortedList() {
    setState(() {
      _listStocksHome.sortOrderStocks(_stocksSortBy.value);
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
    return Center(child: CircularProgressIndicator());
  }

  Widget _error(Function() onPressedBtnError) {
    return Center(
        child: ElevatedButton(
      onPressed: onPressedBtnError,
      child: Text('Tente Novamente'),
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
          itemCount: _listStocksHome.length,
          itemBuilder: (context, index) {
            Stock stock = _listStocksHome.elementAt(index);

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
                        margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 700,
                                  minWidth: 100,
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Symbol',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    border: null,
                                    suffixIcon: Icon(Icons.search),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      searchStockFilter(value);
                                    } else {
                                      filterlist();
                                    }
                                  },
                                ),
                              ),
                            ),
                            if(isExpanded)
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
