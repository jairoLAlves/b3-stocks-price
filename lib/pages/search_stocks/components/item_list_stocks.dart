// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import 'package:b3_price_stocks/model/stock.dart';
import 'package:b3_price_stocks/routes/routes_pages.dart';

import '../../../components/graphics/sf_chart_candle.dart';
import '../../../components/widgets/logo_stock_svg.dart';
import '../controller/item_list_stock_controller.dart';

class ItemListStocks extends StatefulWidget {
  final Stock stock;
  const ItemListStocks({
    Key? key,
    required this.stock,
  }) : super(key: key);

  @override
  State<ItemListStocks> createState() => _ItemListStocksState();
}

class _ItemListStocksState extends State<ItemListStocks> {
  late ItemListStockController stockController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    stockController = ItemListStockController(widget.stock);
  }

  Widget headerItemListStocks({
    required Stock stock,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  /*  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground),
                    borderRadius: BorderRadius.circular(8),
                  ), */
                  elevation: 5,
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      // borderRadius: const BorderRadius.all(Radius.circular(0)),
                      child: LogoStockSvg(stock.logo),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.stock,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      stock.name,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sector',
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    stock.sector,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        // const Flexible(
        //   flex: 1,
        //   child: SizedBox(),
        // ),
        Flexible(
          //flex: 4,
          child: Card(
            elevation: 1,
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                children: [
                  textItemListStocks(
                    context: context,
                    txt1: 'Close:',
                    txt2: widget.stock.close.toStringAsFixed(3),
                  ),
                  textItemListStocks(
                      context: context,
                      txt1: 'Change:',
                      txt2: widget.stock.change.toStringAsFixed(3),
                      style: TextStyle(
                          color: (widget.stock.change < 0)
                              ? Colors.red[900]
                              : Theme.of(context).colorScheme.onSurface,
                          fontStyle: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.fontStyle,
                          fontSize: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.fontSize)),
                  textItemListStocks(
                    context: context,
                    txt1: 'Vol:',
                    txt2: widget.stock.volume.toString(),
                  ),
                  textItemListStocks(
                    context: context,
                    txt1: 'Cap:',
                    txt2: NumberFormat.compactCurrency(
                      name: 'R\$ ',
                      decimalDigits: 3,
                    ).format(widget.stock.market_cap),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textItemListStocks(
      {required BuildContext context,
      required String txt1,
      required String txt2,
      TextStyle? style}) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            txt1,
            style: Theme.of(context).textTheme.titleMedium,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            txt2,
            style: style ?? Theme.of(context).textTheme.bodyLarge,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("ItemListStocks")
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          padding: const EdgeInsets.all(4),
          child: Card(
              elevation: 2,
              //color: const Color(0x01000000),
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RoutesPages.stockDetail,
                            arguments: widget.stock,
                          );
                        },
                        child: headerItemListStocks(stock: widget.stock),
                      ),

                      // Gráfico card

                      Column(children: [
                        Container(
                          constraints: const BoxConstraints(
                            maxHeight: 300,
                          ),
                          child: ValueListenableBuilder(
                              valueListenable:
                                  stockController.isExpandedGraphic,
                              builder: (context, value, child) {
                                return !value
                                    ? Container(
                                        height: 0,
                                      )
                                    : Card(
                                        elevation: 1,
                                        child: SFChartCandle(
                                          stockController,
                                          key: widget.key,
                                        ),
                                      );
                              }),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface,
                              borderRadius: BorderRadius.circular(25)),
                          padding: const EdgeInsets.all(4),
                          child: ValueListenableBuilder<bool>(
                            valueListenable: stockController.isExpandedGraphic,
                            builder: (context, value, child) =>
                                AnimatedSwitcher(
                                    switchInCurve: Curves.linear,
                                    switchOutCurve: Curves.bounceIn,
                                    duration: 1000.ms,
                                    child: InkWell(
                                      onTap: stockController.showGraphic,
                                      child: value
                                          ? Icon(
                                              Icons.close_rounded,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                            )
                                          : Icon(
                                              Icons.show_chart_outlined,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                            ),
                                    )),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
