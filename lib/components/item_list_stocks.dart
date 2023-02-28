import 'package:b3_price_stocks/components/graphic_line_stock.dart';
import 'package:b3_price_stocks/model/stock.dart';
import 'package:b3_price_stocks/routes/routes_pages.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../model/choice_chip_range_date_model.dart';
import '../providers/media_query_provider.dart';
import '../providers/stocks_provider.dart';
import '../util/enums.dart';
import '../util/utils.dart';
import 'package:provider/provider.dart';

import 'logo_stock_svg.dart';

class ItemListStocks extends StatefulWidget {
  final Stock stock;
  const ItemListStocks({super.key, required this.stock});

  @override
  State<ItemListStocks> createState() => _ItemListStocksState();
}

class _ItemListStocksState extends State<ItemListStocks> {
  ValueNotifier<bool> isExpandedGhaphic = ValueNotifier<bool>(false);
  ValueNotifier<double> heightGhaphi = ValueNotifier<double>(0);

  showGraphic() {
    setState(() {
      isExpandedGhaphic.value = !isExpandedGhaphic.value;

      if (isExpandedGhaphic.value) {
        heightGhaphi.value = 146;
      } else {
        heightGhaphi.value = 0;
      }
    });
  }

  Widget headerItemListStocks({
    required Stock stock,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 2,
              child: Container(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
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
        Text('Sector'),
        Text(stock.sector),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          padding: EdgeInsets.all(4),
          child: Card(
              elevation: 2,
              //color: const Color(0x01000000),
              child: Container(
                margin: EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              RoutesPages.STOCKDETAIL,
                              arguments: widget.stock,
                            );
                          },
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceBetween,

                            //spacing: 8,
                            children: [
                              Container(
                                child:
                                    headerItemListStocks(stock: widget.stock),
                              ),

                              //prices and graphicButtom

                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Close:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            Text(
                                              'Change:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            Text(
                                              'Vol:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            Text(
                                              'Cap:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          // crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              widget.stock.close
                                                  .toStringAsFixed(3),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Text(
                                              widget.stock.change
                                                  .toStringAsFixed(3),
                                              style: TextStyle(
                                                  color:
                                                      (widget.stock.change < 0)
                                                          ? Colors.red[900]
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onSurface,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.fontStyle,
                                                  fontSize: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.fontSize),
                                            ),
                                            Text(
                                              widget.stock.volume.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Text(
                                              NumberFormat.compactCurrency(
                                                name: 'R\$ ',
                                                decimalDigits: 3,
                                              ).format(widget.stock.market_cap),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ValueListenableBuilder(
                            valueListenable: isExpandedGhaphic,
                            builder: (context, value, child) {
                              return Container()
                                  .animate(
                                target: !value ? 0 : 1,
                              )

                                  //
                                  .swap(builder: (_, __) {
                                return Card(
                                        elevation: 1,
                                        child: GraphicLineStock(
                                          stockName: widget.stock.stock,
                                        ))
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

                        // AnimatedContainer(
                        //   duration: const Duration(milliseconds: 500),
                        //   curve: Curves.bounceInOut,
                        //   height: heightGhaphi.value,
                        //   child: isExpandedGhaphic.value
                        //       ? Card(
                        //           elevation: 1,
                        //           child: GraphicLineStock(
                        //             stockName: widget.stock.stock,
                        //           ))
                        //       : Container(),
                        // ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: AnimatedSwitcher(
                          switchInCurve: Curves.linear,
                          switchOutCurve: Curves.bounceIn,

                          duration: 1000.ms,
                          child: InkWell(
                            onTap: showGraphic,
                            child: isExpandedGhaphic.value
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
