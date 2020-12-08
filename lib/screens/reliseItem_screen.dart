import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../modals/products.dart';

class ReleaseItemScreen extends StatefulWidget {
  @override
  _ReleaseItemScreenState createState() => _ReleaseItemScreenState();
}

class _ReleaseItemScreenState extends State<ReleaseItemScreen> {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<CartProvider>(context).cartList;
    var storePro = Provider.of<CartProvider>(context);
    var product = Provider.of<StoreProvider>(context);
    bool _isLoading = false;

    void addToStore() async {
      setState(() {
        _isLoading = true;
      });

      List<Products> list = [];
      var pro = product.currentProducts;

      store.forEach((cartItem) {
        var newItem = product.currentProducts.firstWhere((item){
          if(item.id == cartItem.productId){
            return true;
          }
          return false;
        });

        var it = new Products(
            id: newItem.id,
            name: newItem.name,
            price: newItem.price,
            expireDate: newItem.expireDate,
            imageUrl: newItem.imageUrl,
            description: newItem.description,
            supplierId: newItem.supplierId,
            quantity: cartItem.quantity
        );
        list.add(it);
      });

      await product.sendStock(list);

      storePro.clear();

      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Release Items'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              storePro.clear();
            },
          ),
          IconButton(
            icon: Icon(Icons.forward),
            onPressed: store.isEmpty ? null : addToStore,
          )
        ],
      ),
      body: store.isEmpty ?
        Center(child: Text('No Items'),) :
        _isLoading ?
          Center(
            child: CircularProgressIndicator(),
          ) :
        ListView.builder(
          itemBuilder: (ctx,index){
            return Container(
              decoration: BoxDecoration(
                color: Colors.orange[100],
                border: Border.all(color: Colors.grey,width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Text(
                        store[index].name,
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        letterSpacing: 2
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                        store[index].quantity.toInt().toString(),
                      style: TextStyle(
                          fontFamily: 'Fredoka'
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                        store[index].curDate.toString().substring(0,10),
                      style: TextStyle(
                          fontFamily: 'Fredoka'
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        itemCount: store.length,
      ),
    );
  }
}
