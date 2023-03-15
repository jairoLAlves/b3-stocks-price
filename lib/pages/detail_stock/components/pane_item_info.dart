

import 'package:flutter/material.dart';

import '../models/item_info_expansion_panel_model.dart';
import '../../../model/stock_info_model.dart';
import 'info_stock_panel_widget.dart';

class PanelItemInfo extends StatefulWidget {
  final StockInfoModel stockInfoModel;

  const PanelItemInfo({super.key, required this.stockInfoModel});

  @override
  State<PanelItemInfo> createState() => _PanelItemInfoState();
}

class _PanelItemInfoState extends State<PanelItemInfo> {
  final List<Map<String, ValueNotifier<bool>>> listaDeStatus = [
    {"value": ValueNotifier<bool>(true)},
    {"value": ValueNotifier<bool>(false)},
  ];

  List<ItemInfoExpansionPanelModel> get listItemInfoPanel =>
      <ItemInfoExpansionPanelModel>[
        ItemInfoExpansionPanelModel(
          isExpanded: listaDeStatus[0]["value"]?.value ?? false,
          title: "Resumo",
          body: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Fechamento anterior"),
                    Text("${widget.stockInfoModel.regularMarketPreviousClose}"),
          
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
          const Text("Abrir"),
                    Text("${widget.stockInfoModel.regularMarketOpen}"),
                  ],
                ),
             
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
           const Text("Variação do Dia"),
                    Text("${widget.stockInfoModel.regularMarketDayRange}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
           const Text("Variação de 52 semanas"),
                    Text("${widget.stockInfoModel.fiftyTwoWeekHighChange}"),
                  ],
                ),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
          const Text("Volume"),
                    Text("${widget.stockInfoModel.regularMarketVolume}"),
                  ],
                ),

                
                    
                    
                   
                   
                    
                   
               
              ],
            ),
          ),
        ),
        // ItemInfoExpansionPanel(
        //    isExpanded: listaDeStatus[1]["value"]?.value ?? false,
        //   title: "Resumo2",
        //   body: Column(
        //     children: [
        //       Row(children: const []),
        //     ],
        //   ),
        // ),
      ];

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 700,
          
        ),
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(
                    () => listaDeStatus[index]["value"]?.value = !isExpanded);
              },
              children: listItemInfoPanel
                  .map((itemInfoPanel) =>
                      infoStockPanel(itemInfoPanel: itemInfoPanel))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
