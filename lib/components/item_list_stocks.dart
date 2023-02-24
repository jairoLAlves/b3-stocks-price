import 'package:b3_price_stocks/components/graphic_line_stock.dart';
import 'package:b3_price_stocks/model/stock.dart';
import 'package:b3_price_stocks/routes/routes_pages.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jovial_svg/jovial_svg.dart';

import '../model/choice_chip_range_date_model.dart';
import '../providers/media_query_provider.dart';
import '../providers/stocks_provider.dart';
import '../util/enums.dart';
import '../util/utils.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 600,
          padding: EdgeInsets.all(4),
          child: Card(
              elevation: 2,
              //color: const Color(0xFFd3d3d3),
              child: Container(
                margin: EdgeInsets.all(1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        spacing: 8,
                        children: [
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 200,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  child: Hero(
                                      tag: '{${widget.stock.id}}',
                                      child: getNetWorkSvg(widget.stock.logo)),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.stock.stock,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            widget.stock.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Sector',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                          Text(
                                            widget.stock.sector,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //prices and graphicButtom

                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 160,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                          widget.stock.close.toStringAsFixed(3),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        Text(
                                          widget.stock.change
                                              .toStringAsFixed(3),
                                          style: TextStyle(
                                              color: (widget.stock.change < 0)
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
                                AnimatedSwitcher(
                                    duration: const Duration(seconds: 1),
                                    child: InkWell(
                                      onTap: showGraphic,
                                      child: isExpandedGhaphic.value
                                          ? const Icon(Icons.insert_chart)
                                          : const Icon(Icons.show_chart),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 450,
                      ),
                      child: AnimatedContainer(
                        curve: Curves.bounceOut,
                        duration: const Duration(milliseconds: 1000),
                        height: heightGhaphi.value,
                        child: Card(
                          elevation: 2,
                          child: isExpandedGhaphic.value
                              ? Column(
                                  children: [
                                    GraphicLineStock(
                                      stockName: widget.stock.stock,
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
