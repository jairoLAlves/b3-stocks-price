import 'package:b3_price_stocks/components/sf_chart_candle.dart';
import 'package:b3_price_stocks/model/stock.dart';
import 'package:b3_price_stocks/routes/routes_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'logo_stock_svg.dart';

class ItemListStocks extends StatefulWidget {
  final Stock stock;
  const ItemListStocks({super.key, required this.stock});

  @override
  State<ItemListStocks> createState() => _ItemListStocksState();
}

class _ItemListStocksState extends State<ItemListStocks> {
  ValueNotifier<bool> isExpandedGraphic = ValueNotifier<bool>(false);
  ValueNotifier<bool> isFullScreenGraphic = ValueNotifier<bool>(false);
  ValueNotifier<double> heightGraphic = ValueNotifier<double>(0);

  void setFullScreenGraphic() {
    setState(() {
      isFullScreenGraphic.value = !isFullScreenGraphic.value;
    });
  }

  void showFullGraphic() {
    setFullScreenGraphic();
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          child: showGraphicWidget(),
        );
      },
    );
  }

  void showGraphic() {
    setState(() {
      isExpandedGraphic.value = !isExpandedGraphic.value;

      if (isExpandedGraphic.value) {
        heightGraphic.value = 146;
      } else {
        heightGraphic.value = 0;
      }
    });
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
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
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

  Widget showGraphicWidget() {
    return isFullScreenGraphic.value
        ? SFChartCandle(
            stockName: widget.stock.stock,
            isExpandedGraphic: isFullScreenGraphic.value,
            fullScreenGraphic: () {
              Navigator.of(context).pop();
              setFullScreenGraphic();
            })
        : SFChartCandle(
            stockName: widget.stock.stock,
            isExpandedGraphic: isFullScreenGraphic.value,
            fullScreenGraphic: () => showFullGraphic(),
          );
  }

  @override
  Widget build(BuildContext context) {
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
                child: Stack(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                RoutesPages.STOCKDETAIL,
                                arguments: widget.stock,
                              );
                            },
                            child: headerItemListStocks(stock: widget.stock),
                          ),

                          // Gráfico card

                          Container(
                            constraints: const BoxConstraints(
                              maxHeight: 300,
                            ),
                            child: ValueListenableBuilder(
                                valueListenable: isExpandedGraphic,
                                builder: (context, value, child) {
                                  return Container(
                                    height: 0,
                                  )
                                      .animate(
                                    target: !value ? 0 : 1,
                                  )
                                      .swap(builder: (_, __) {
                                    return Card(
                                      elevation: 1,
                                      child: showGraphicWidget(),
                                    )
                                        //

                                        .animate()
                                        .scaleY(
                                          duration: 800.ms,
                                          curve: Curves.linear,
                                          begin: 0,
                                          end: 1,
                                        )
                                        .desaturate(
                                          begin: 0.0,
                                          end: 1.0,
                                          duration: 800.ms,
                                        );
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: AnimatedSwitcher(
                          switchInCurve: Curves.linear,
                          switchOutCurve: Curves.bounceIn,
                          duration: 1000.ms,
                          child: InkWell(
                            onTap: showGraphic,
                            child: isExpandedGraphic.value
                                ? const Icon(Icons.insert_chart)
                                : const Icon(Icons.show_chart),
                          )),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
