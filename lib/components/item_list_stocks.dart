import 'package:b3_price_stocks/components/graphic_line_stock.dart';
import 'package:b3_price_stocks/model/stock.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jovial_svg/jovial_svg.dart';

class ItemListStocks extends StatefulWidget {
  final Stock stock;
  const ItemListStocks({super.key, required this.stock});

  @override
  State<ItemListStocks> createState() => _ItemListStocksState();
}

class _ItemListStocksState extends State<ItemListStocks> {
  ValueNotifier<bool> isExpandedGhaphic = ValueNotifier<bool>(false);

  ValueNotifier<double> heightGhaphi = ValueNotifier<double>(0);

  void setHeightGhaphi({required double height, required String sinal}) {
    switch (sinal) {
      case '+=':
        setState(() {
          heightGhaphi.value += height;
        });
        break;

      case '-=':
        setState(() {
          heightGhaphi.value -= height;
        });
        break;

      case '=':
        setState(() {
          heightGhaphi.value = height;
        });
        break;
    }
  }

  void expandedGraphic({required double direction}) {
    if (direction < 0) {
      if (heightGhaphi.value > 0) {
        if (heightGhaphi.value == 50) {
          setHeightGhaphi(height: 0, sinal: '=');
        } else {
          setHeightGhaphi(height: 1, sinal: '-=');
        }
      }
    } else if (direction > 0) {
      if (heightGhaphi.value <= 110) {
        if (heightGhaphi.value == 50) {
          setHeightGhaphi(height: 110, sinal: '=');
        } else {
          setHeightGhaphi(height: 1, sinal: '+=');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('reatualizando itemList: ');

    final Widget netWorkSvg = ScalableImageWidget.fromSISource(
      fit: BoxFit.cover,
      onLoading: (_) =>
          const Center(child: CircularProgressIndicator(color: Colors.amber)),
      si: ScalableImageSource.fromSvgHttpUrl(Uri.parse(widget.stock.logo),
          currentColor: Colors.transparent),
    );

    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 10),
      height: 100 + heightGhaphi.value,
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            if (isExpandedGhaphic.value) {
              isExpandedGhaphic.value = !isExpandedGhaphic.value;
              heightGhaphi.value = 0;
            } else {
              isExpandedGhaphic.value = !isExpandedGhaphic.value;
              heightGhaphi.value = 110;
            }
          });
        },
        onVerticalDragStart: (details) {
          isExpandedGhaphic.value = true;
        },
        onVerticalDragUpdate: (details) {
          expandedGraphic(direction: details.delta.direction);
        },
        child: Column(
          children: [
            Card(
              elevation: 5,
              //color: const Color(0xFFF4F4F4),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 70,
                            child: netWorkSvg,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.stock.stock,
                                      style:
                                          Theme.of(context).textTheme.headline6,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sector',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      widget.stock.sector,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      //fim

                      Container(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Close:',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  'Change:',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  'Vol:',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  'Cap:',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.stock.close.toStringAsFixed(3),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  widget.stock.change.toStringAsFixed(3),
                                  style: TextStyle(
                                      color: (widget.stock.change < 0)
                                          ? Colors.red[900]
                                          : Colors.black,
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
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  NumberFormat.compactCurrency(
                                    name: 'R\$ ',
                                    decimalDigits: 3,
                                  ).format(widget.stock.market_cap),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              elevation: 2,
              child: Container(
                height: heightGhaphi.value,
                //width: double.infinity,
                child: isExpandedGhaphic.value
                    ? GraphicLineStock(
                        stockName: widget.stock.stock,
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
