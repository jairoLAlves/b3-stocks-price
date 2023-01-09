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

  _start() {
    return Container();
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }

  _error(Function() onPressedBtnError) {
    return Center(
        child: ElevatedButton(
      onPressed: onPressedBtnError,
      child: Text('Tente Novamente'),
    ));
  }

  stateManagement(StatusGetStocks state) {
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

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Hero(
              tag: 'searchButton',
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  child: Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Container(
                            //padding: const EdgeInsets.only(bottom: 18),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Symbol',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
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
                                Container(
                                    child: IconButton(
                                        onPressed: () => showModalBottomSheet(
                                              context: context,
                                              builder: (ctx) =>
                                                  BottomSheetSearch(
                                                context: ctx,
                                                onActionSector:
                                                    onActionDropdownMenuItemSectors,
                                                onActionSorted:
                                                    onActionDropdownMenuItemSorted,
                                                sector: _stocksSectors.value,
                                                stocksSortBy:
                                                    _stocksSortBy.value,
                                              ),
                                            ),
                                        icon: Icon(Icons.settings)))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            Expanded(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: loadList,
                child: AnimatedBuilder(
                  animation: controller.stateUpdateStocks,
                  builder: (context, child) {
                    return stateManagement(controller.stateUpdateStocks.value);
                  },
                ),
              ),
            ),
            ////
          ],
        ),
      ),
    );
  }
}
