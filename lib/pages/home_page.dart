import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:b3_price_stocks/model/stock.dart';
import 'package:b3_price_stocks/providers/stocks_provider.dart';
//import 'package:b3_price_stocks/routes/routes_pages.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../components/bottom_sheet_search.dart';
import '../components/item_list_stocks.dart';
import '../util/enums.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final controllerStock;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Stock> _listStocksHome = <Stock>[];
  bool isloading = true;

  @override
  void initState() {
    //loadList();
    controllerStock = context.read<StocksProvider>();

    controllerStock.updateStocks().then((value) {
      setState(() {
        isloading = false;
        _listStocksHome = value;
      });
    });

    super.initState();
  }

  Future<void> loadList() async {
    Provider.of<StocksProvider>(context, listen: false)
        .updateStocks()
        .then((value) {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
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
                                      icon: Icon(Icons.settings)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: loadList,
                child: isloading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: _listStocksHome.length,
                        itemBuilder: (context, index) {
                          Stock stock = _listStocksHome.elementAt(index);

                          return ItemListStocks(
                            key: ObjectKey(stock),
                            stock: stock,
                          );
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
