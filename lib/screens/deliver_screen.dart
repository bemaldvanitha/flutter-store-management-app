import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/deliver_item.dart';

class DeliverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deliver = Provider.of<StoreProvider>(context).sendStocks;
    return ListView.builder(
        itemBuilder: (ctx,index){
          return DeliverItem(
              id: deliver[index].id,
              amount: deliver[index].amount,
              prods: deliver[index].items,
              date: deliver[index].transactionTime,
          );
        },
        itemCount: deliver.length,
    );
  }
}
