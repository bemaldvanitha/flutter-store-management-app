import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:storemanagment/widgets/main_drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/expired_item.dart';
import '../providers/supplier_provider.dart';
import '../modals/supplier.dart';

class ExpiredScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expiredItems = Provider.of<StoreProvider>(context).expiredItem;
    final supplier = Provider.of<SupplierProvider>(context).currentSupplier;

    List<Supplier> informSupplier;

    /*var expiredItemSupplier = expiredItems.forEach((pro) {
      var selSup = supplier.firstWhere((supp){
        if(supp.id == pro.id){
          return true;
        }
        return false;
      });
      informSupplier.add(selSup);
    });*/


    return Scaffold(
      appBar: AppBar(
        title: Text('Expired Items'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){

              },
              icon: Icon(
                  Icons.score,
                color: Colors.white,
              ),
              label: Text(
                  'inform',
                style: TextStyle(
                  color: Colors.white
                ),
              )
          )
        ],
      ),
      drawer: MainDrawer(),
      body: expiredItems == null ? Center(
        child: Text('no expired items'),
      ):ListView.builder(
          itemBuilder: (ctx,index){
            return ExpiredItem(
              id: expiredItems[index].id,
              name: expiredItems[index].name,
              quantity: expiredItems[index].quantity,
              imageUrl: expiredItems[index].imageUrl,
              expireDate: expiredItems[index].expireDate,
              supplierId: expiredItems[index].supplierId,
            );
          },
          itemCount: expiredItems.length,
      ),
    );
  }
}
