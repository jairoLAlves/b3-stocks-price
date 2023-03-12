import 'package:flutter/material.dart';

import '../components/graphic_line_stock.dart';
import '../components/pane_item_info.dart';
import '../model/stock.dart';
import '../model/stock_info_model.dart';
import '../providers/stock_info_provaider.dart';
import '../util/enums.dart';
import 'package:provider/provider.dart';

//how to get the stock data of Tesla in dadrt?

class StockDetailPage extends StatefulWidget {
  const StockDetailPage({
    super.key,
  });

  @override
  State<StockDetailPage> createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetailPage>
    with TickerProviderStateMixin {
  late StockInfoProvider controller;
  final ValueNotifier<StockInfoModel> stockInfo =
      ValueNotifier(StockInfoModel());
  late ValidRangesEnum validRange = ValidRangesEnum.five_d;
  late final ValueNotifier<Stock> stock = ValueNotifier(Stock());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    controller = context.read<StockInfoProvider>();
    stock.addListener(() {
      _getStockInfoAllRange();
    });

    _tabController = TabController(length: 3, vsync: this);
  }

  void _getStockInfoAllRange() {
    controller.getStockInfoAllRange(
      symbol: stock.value.stock,
      range: validRange,
    );
  }

  @override
  Widget build(BuildContext context) {
    controller = context.watch<StockInfoProvider>();
    stock.value = (ModalRoute.of(context)?.settings.arguments as Stock);

    stockInfo.value = controller.getStockInfo(stock.value.stock);
    String titleLong = (stockInfo.value.longName ?? stock.value.name) ?? "";

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(titleLong),
          ),
          body: Column(
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 700,
                ),
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(child: Text("Resumo")),
                    Tab(child: Text("Gráfico")),
                    Tab(child: Text("Estatísticas")),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: ValueListenableBuilder(
                          valueListenable: stockInfo,
                          builder: (context, value, child) {
                            return Column(
                              children: [
                                Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 300, maxWidth: 700),
                                  child: Card(
                                      elevation: 1,
                                      child: (value.symbol != null) ? GraphicLineStock(
                                        stockName: value.symbol!,
                                      ): null
                                      
                                      ),
                                ),
                                PanelItemInfo(stockInfoModel: value),
                              ],
                            );
                          }),
                    ),
                    Stack(children: const [Text("Gráfico")]),
                    const Center(
                      child: Text("Estatísticas"),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
