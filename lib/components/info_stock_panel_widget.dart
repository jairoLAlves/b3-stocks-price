
import 'package:flutter/material.dart';

import '../model/item_info_expansion_panel_model.dart';

ExpansionPanel infoStockPanel({
  required ItemInfoExpansionPanelModel itemInfoPanel,
}) {
  return ExpansionPanel(
    canTapOnHeader: true,
    headerBuilder: (BuildContext context, bool isExpanded) {
      return ListTile(
        title: Text(itemInfoPanel.title),
      );
    },
    body: itemInfoPanel.body,
    isExpanded: itemInfoPanel.isExpanded,
  );
}