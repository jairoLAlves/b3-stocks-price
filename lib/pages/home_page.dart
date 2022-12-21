import 'package:b3_price_stocks/extensions/stocks_extensions.dart';
import 'package:b3_price_stocks/model/stock.dart';
import 'package:b3_price_stocks/providers/stocks_provider.dart';
//import 'package:b3_price_stocks/routes/routes_pages.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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

  StocksSortBy _stocksSortBy = StocksSortBy.volume;

  sectors _stocksSectors = sectors.All;

  searchStockFilter(String value) {
    setState(() {
      _listStocksHome = Provider.of<StocksProvider>(context, listen: false)
          .searchStockFilter(value, _stocksSectors);
      _listStocksHome.sortOrderStocks(_stocksSortBy);
    });
  }

  filterlist() {
    setState(() {
      _listStocksHome = Provider.of<StocksProvider>(context, listen: false)
          .filterListStocks(_stocksSectors);
      _listStocksHome.sortOrderStocks(_stocksSortBy);
    });
  }

  sortedList() {
    setState(() {
      _listStocksHome.sortOrderStocks(_stocksSortBy);
    });
  }

  DropdownMenuItem<StocksSortBy> dropdownMenuItemSorted({
    required StocksSortBy value,
    bool enabled = true,
  }) {
    return DropdownMenuItem(
      value: value,
      enabled: enabled,
      child: Text(value.name),
    );
  }

  DropdownMenuItem<sectors> dropdownMenuItemSectors({
    required sectors value,
    bool enabled = true,
  }) {
    return DropdownMenuItem(
      value: value,
      enabled: enabled,
      child: Text(value.name.replaceAll('_', ' ')),
    );
  }

  Future<void> bottomSheet(BuildContext ctx) {
    return showModalBottomSheet<void>(
      context: ctx,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sectores',
                        style: TextStyle(fontSize: 25),
                      ),
                      DropdownButton(
                        isExpanded: true,
                        //isDense: true,
                        //alignment: AlignmentDirectional.center,
                        //dropdownColor: Colors.white54,
                        value: _stocksSectors,
                        items: [
                          dropdownMenuItemSectors(
                            value: sectors.All,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Communications,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Finance,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Retail_Trade,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Health_Services,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Energy_Minerals,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Commercial_Services,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Consumer_Non_Durables,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Non_Energy_Minerals,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Consumer_Services,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Process_Industries,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Transportation,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Utilities,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Electronic_Technology,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Consumer_Durables,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Miscellaneous,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Technology_Services,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Distribution_Services,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Health_Technology,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Producer_Manufacturing,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Industrial_Services,
                          ),
                          dropdownMenuItemSectors(
                            value: sectors.Others,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _stocksSectors = value ?? sectors.Others;
                          });
                          filterlist();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Order', style: TextStyle(fontSize: 25)),
                      DropdownButton(
                          isExpanded: true,
                          value: _stocksSortBy,
                          items: [
                            dropdownMenuItemSorted(
                              value: StocksSortBy.volume,
                            ),
                            dropdownMenuItemSorted(
                              value: StocksSortBy.change,
                            ),
                            dropdownMenuItemSorted(
                              value: StocksSortBy.close,
                            ),
                            dropdownMenuItemSorted(
                              value: StocksSortBy.market_cap_basic,
                            ),
                            dropdownMenuItemSorted(
                              value: StocksSortBy.name,
                            ),
                            dropdownMenuItemSorted(
                              value: StocksSortBy.sector,
                            ),
                            dropdownMenuItemSorted(
                              value: StocksSortBy.stock,
                            ),
                          ],
                          onChanged: (StocksSortBy? stocksSortBy) {
                            setState(() {
                              _stocksSortBy =
                                  stocksSortBy ?? StocksSortBy.volume;
                            });
                            sortedList();
                          }),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Container(
                child: IconButton(
                    onPressed: () => bottomSheet(context),
                    icon: Icon(Icons.settings)))
          ],
          title: Container(
            //padding: const EdgeInsets.only(bottom: 18),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Symbol',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
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
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [],
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
