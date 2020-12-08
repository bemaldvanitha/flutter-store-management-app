import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../modals/cart.dart';

class CartProvider with ChangeNotifier{
  List<Cart> cartItems = [];

  List<Cart> get cartList{
    return [...cartItems];
  }

  void addCart(Cart cart){

    var index = cartItems.indexWhere((item){
      if(item.productId == cart.productId){
        return true;
      }
      return false;
    });

    if(index != -1){
      cartItems[index].quantity = cartItems[index].quantity + 1;
    }else{
      cartItems.add(cart);
    }

    notifyListeners();
  }

  void clear(){
    cartItems.clear();
    notifyListeners();
  }

}