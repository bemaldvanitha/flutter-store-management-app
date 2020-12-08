import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/receive_item.dart';

class ReceiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final receive = Provider.of<StoreProvider>(context).receiveStocks;
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (ctx,index){
            return ReceiveItem(
              id: receive[index].id,
              amount: receive[index].amount,
              date: receive[index].transactionTime,
              prods: receive[index].items,
            );
          },
          itemCount: receive.length,
      ),
    );
  }
}
