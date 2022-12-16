import 'package:b3_price_stocks/components/graphic_line_stock.dart';
import 'package:b3_price_stocks/model/stock.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jovial_svg/jovial_svg.dart';

class ItemListStocks extends StatelessWidget {
  final Stock stock;
  const ItemListStocks({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
    final Widget netWorkSvg = ScalableImageWidget.fromSISource(
      fit: BoxFit.cover,
      onLoading: (_) =>
          const Center(child: CircularProgressIndicator(color: Colors.amber)),
      si: ScalableImageSource.fromSvgHttpUrl(Uri.parse(stock.logo),
          currentColor: Colors.transparent),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      margin: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 100,
        child: Card(
          elevation: 5,
          color: const Color(0xFFF4F4F4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: 80,
                    child: netWorkSvg,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stock.stock,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              stock.name,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sector',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              stock.sector,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
               Container(
                alignment: Alignment.centerRight,
                // color: Color(0x55000000),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Close:',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          stock.close.toStringAsFixed(3),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change:',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          stock.change.toStringAsFixed(3),
                          style: TextStyle(
                              color: (stock.change < 0)
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Vol:',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          stock.volume.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cap:',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          stock.market_cap.toStringAsFixed(3),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GraphicLineStock(
                  //key: ObjectKey(stock.stock),
                  stockName: stock.stock,
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
