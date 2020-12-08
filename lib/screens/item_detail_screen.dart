import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ItemDetailScreen extends StatefulWidget {
  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<StoreProvider>(context,listen: false).currentProducts.firstWhere((prod){
      if(prod.id == id){
        return true;
      }
      return false;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Hero(
                        child: Image.network(product.imageUrl,fit: BoxFit.fill,),
                        tag: id,
                    )
                ),
                Container(
                  color: Colors.black45,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  child: Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Architect',
                        fontSize: 25,
                      ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'price :-',
                  style: TextStyle(
                    fontFamily: 'Architect',
                    fontSize: 20,
                  ),
                ),
                Text(
                    '\$ '+product.price.toInt().toString(),
                  style: TextStyle(
                    fontFamily: 'Architect',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'quantity :-',
                  style: TextStyle(
                    fontFamily: 'Architect',
                    fontSize: 20,
                  ),
                ),
                Text(
                  product.quantity.toInt().toString(),
                  style: TextStyle(
                    fontFamily: 'Architect',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            product.expireDate == null ? Container() :SizedBox(
              height: 20,
            ),
            product.expireDate == null ? Container() :Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'expired in :-',
                  style: TextStyle(
                    fontFamily: 'Architect',
                    fontSize: 20,
                  ),
                ),
                Text(
                  product.expireDate.toString().substring(0,10),
                  style: TextStyle(
                    fontFamily: 'Architect',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'supplier id :-',
                  style: TextStyle(
                    fontFamily: 'Architect',
                    fontSize: 20,
                  ),
                ),
                Text(
                  product.supplierId,
                  style: TextStyle(
                    fontFamily: 'Architect',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Text(product.description),
            )
          ],
        ),
      ),
    );
  }
}

