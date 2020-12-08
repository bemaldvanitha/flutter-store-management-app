import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../modals/cart.dart';

class StoreItem extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final double quantity;
  final String imageUrl;

  StoreItem({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.imageUrl,
    @required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context,listen: false);
    return Column(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: (){
              Navigator.of(context).pushNamed('/detail',arguments: id);
            },
            splashColor: Colors.black45,
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                Container(
                  width: 170,
                  height: 200,
                    child: Hero(
                        child: FadeInImage(
                          placeholder: AssetImage('assests/images/box.png'),
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.fill,
                        ),
                        tag: id,
                    ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      color: Colors.black.withOpacity(0.3),
                      child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Architect',
                            color: Colors.white
                          ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        color: Colors.black.withOpacity(0.3),
                        child: Text(
                            quantity.toInt().toString(),
                          textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Architect',
                              color: Colors.white
                            ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[100].withOpacity(0.3),Colors.grey[500].withOpacity(0.3)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft
            )
          ),
          child: InkWell(
            onTap: (){
              var cartItem = new Cart(name: name,curDate: DateTime.now(),productId: id,quantity: 1);
              cart.addCart(cartItem);
            },
            child: Icon(
                Icons.add_shopping_cart,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
