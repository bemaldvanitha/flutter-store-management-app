import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../modals/products.dart';
import '../modals/transaction.dart';

class StoreProvider with ChangeNotifier{
  List<Transaction> store = [
    /*Transaction(
      id: 't1',
      amount: 650,
      transactionTime: DateTime.now(),
      transactionType: TransactionType.Receive,
      items: [
        Products(
          id: 'p1',
          price: 25,
          quantity: 10,
          name: 'pens',
          description: 'atlas pens',
          expireDate: null,
          supplierId: 's1',
          imageUrl: 'https://cdn.pixabay.com/photo/2016/02/19/10/12/writing-1209121_1280.jpg'
        ),
        Products(
            id: 'p2',
            price: 20,
            quantity: 20,
            name: 'pencil',
            description: 'atlas pencil',
            expireDate: null,
            supplierId: 's1',
            imageUrl: 'https://cdn.pixabay.com/photo/2015/11/04/07/49/color-pencil-1022033_1280.jpg'
        ),
      ]
    ),
    Transaction(
        id: 't2',
        amount: 850,
        transactionTime: DateTime.now(),
        transactionType: TransactionType.Receive,
        items: [
          Products(
              id: 'p3',
              price: 50,
              quantity: 10,
              name: 'gummy bear',
              description: 'sweet gummy bear',
              expireDate: DateTime.now().add(new Duration(days: 40)),
              supplierId: 's2',
              imageUrl: 'https://cdn.pixabay.com/photo/2014/04/07/05/25/gummibarchen-318362_1280.jpg'
          ),
          Products(
              id: 'p4',
              price: 5,
              quantity: 10,
              name: 'tofees',
              description: 'sweet tofees',
              expireDate: DateTime.now().add(new Duration(days: 50)),
              supplierId: 's2',
              imageUrl: 'https://cdn.pixabay.com/photo/2017/01/04/19/41/caramel-1952997_1280.jpg'
          ),
          Products(
              id: 'p5',
              price: 30,
              quantity: 10,
              name: 'choclate',
              description: 'chocklate box',
              expireDate: DateTime.now().add(new Duration(days: 20)),
              supplierId: 's2',
              imageUrl: 'https://cdn.pixabay.com/photo/2017/02/11/14/19/valentines-day-2057745_1280.jpg'
          ),
        ]
    ),
    Transaction(
        id: 't3',
        amount: 7000,
        transactionTime: DateTime.now(),
        transactionType: TransactionType.Receive,
        items: [
          Products(
              id: 'p6',
              price: 500,
              quantity: 10,
              name: 'cake',
              description: 'birthday cake',
              expireDate: DateTime.now().add(new Duration(days: 5)),
              supplierId: 's3',
              imageUrl: 'https://cdn.pixabay.com/photo/2014/06/30/11/40/birthday-cake-380178_1280.jpg'
          ),
          Products(
              id: 'p7',
              price: 200,
              quantity: 10,
              name: 'cup cake',
              description: 'cup cake',
              expireDate: DateTime.now().subtract(new Duration(days: 2)),
              supplierId: 's3',
              imageUrl: 'https://cdn.pixabay.com/photo/2017/09/14/14/33/cupcake-2749204_1280.jpg'
          ),
        ]
    ),
    Transaction(
        id: 't4',
        amount: 50000,
        transactionTime: DateTime.now(),
        transactionType: TransactionType.Receive,
        items: [
          Products(
              id: 'p8',
              price: 2000,
              quantity: 10,
              name: 'teddy bear',
              description: 'nice teddy bear',
              expireDate: null,
              supplierId: 's4',
              imageUrl: 'https://cdn.pixabay.com/photo/2016/03/26/22/22/happy-1281590_1280.jpg'
          ),
          Products(
              id: 'p9',
              price: 3000,
              quantity: 10,
              name: 'teddy bears',
              description: 'cute teddy bear',
              expireDate: null,
              supplierId: 's4',
              imageUrl: 'https://cdn.pixabay.com/photo/2016/11/18/16/16/close-up-1835598_1280.jpg'
          ),
        ]
    ),
    Transaction(
        id: 't5',
        amount: 125,
        transactionTime: DateTime.now(),
        transactionType: TransactionType.Send,
        items: [
          Products(
              id: 'p1',
              price: 25,
              quantity: 4,
              name: 'pens',
              description: 'atlas pens',
              expireDate: null,
              supplierId: null,
              imageUrl: 'https://cdn.pixabay.com/photo/2016/02/19/10/12/writing-1209121_1280.jpg'
          ),
          Products(
              id: 'p2',
              price: 20,
              quantity: 8,
              name: 'pencil',
              description: 'atlas pencil',
              expireDate: null,
              supplierId: null,
              imageUrl: 'https://cdn.pixabay.com/photo/2015/11/04/07/49/color-pencil-1022033_1280.jpg'
          ),
        ]
    ),
    Transaction(
        id: 't6',
        amount: 8000,
        transactionTime: DateTime.now(),
        transactionType: TransactionType.Receive,
        items: [
          Products(
              id: 'p8',
              price: 2000,
              quantity: 2,
              name: 'teddy bear',
              description: 'nice teddy bear',
              expireDate: null,
              supplierId: 's4',
              imageUrl: 'https://cdn.pixabay.com/photo/2016/03/26/22/22/happy-1281590_1280.jpg'
          ),
        ]
    ),*/
  ];

  final String authToken;

  StoreProvider({
    @required this.authToken,
  });

  Future<void> fetchAndSetTransaction() async {
    final url = 'https://storeapp-f3d3b.firebaseio.com/transaction.json?auth=$authToken';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Transaction> listOfTransactions = [];

      // print(data);
      if(data != null){
      data.forEach((key, value) {
        listOfTransactions.add(Transaction(
            id: key,
            transactionTime: DateTime.parse(value['transactionTime']),
            amount: value['amount'],
            transactionType: value['transactionType'] == 'Receive'
                ? TransactionType.Receive
                : TransactionType.Send,
            items: (value['items'] as List<dynamic>).map((pro) =>
                Products(
                    id: pro['id'],
                    name: pro['name'],
                    quantity: pro['quantity'],
                    description: pro['description'],
                    supplierId: pro['supplierId'],
                    imageUrl: pro['imageUrl'],
                    price: pro['price'],
                    expireDate: pro['expireDate'] != null ? DateTime.parse(
                        pro['expireDate']) : null
                )
            ).toList()
        ));
      });
    }
      store = listOfTransactions;
    }catch(err){
      throw err;
    }
  }

  List<Transaction> get receiveStocks{
    List<Transaction> receive= [];

    store.forEach((transaction) {
      if(transaction.transactionType == TransactionType.Receive){
        receive.add(transaction);
      }
    });
    return receive;
  }

  List<Transaction> get sendStocks{
    List<Transaction> send = [];

    store.forEach((transaction) {
      if(transaction.transactionType == TransactionType.Send){
        send.add(transaction);
      }
    });
    return send;
  }

  List<Products> get currentProducts{
    List<Products> current = [];
    store.forEach((transaction) {
      if(transaction.transactionType == TransactionType.Receive) {
        transaction.items.forEach((product) {
          var k = 0;
          current.forEach((nowEle) {
            if(nowEle.id == product.id){
              k = 1;
              var pro = Products(
                id: nowEle.id,
                name: nowEle.name,
                description: nowEle.description,
                expireDate: nowEle.expireDate,
                supplierId: nowEle.supplierId,
                imageUrl: nowEle.imageUrl,
                price: nowEle.price,
                quantity: nowEle.quantity + product.quantity,
              );
              var it = current.indexOf(nowEle);
              current[it] =pro;
            }
          });
          if(k == 0){
            current.add(product);
          }
        });
      }else if(transaction.transactionType == TransactionType.Send){
        transaction.items.forEach((product) {
          current.forEach((nowEle) {
            if(nowEle.id == product.id){
              var pro = Products(
                id: nowEle.id,
                name: nowEle.name,
                description: nowEle.description,
                expireDate: nowEle.expireDate,
                supplierId: nowEle.supplierId,
                imageUrl: nowEle.imageUrl,
                price: nowEle.price,
                quantity: nowEle.quantity - product.quantity,
              );
              var it = current.indexOf(nowEle);
              current[it] =pro;
            }
          });
        });
      }
    });
    return current;
  }

  List<Products> get expiredItem{
    List<Products> expiredProducts = [];
    store.forEach((transaction) {
      transaction.items.forEach((products) {
        if(products.expireDate != null && products.expireDate.isBefore(DateTime.now())){
            expiredProducts.add(products);
        }
      });
    });

    return expiredProducts;
  }

  Future<void> receiveStock(List<Products> itemList) async{
    final url = 'https://storeapp-f3d3b.firebaseio.com/transaction.json?auth=$authToken';
    final timestamp = DateTime.now();

    double amount = 0.0;
    itemList.forEach((prod) {
      amount = amount + prod.quantity * prod.price;
    });

    try{
      final response = await http.post(url,body: json.encode({
        'transactionType': 'Receive',
        'transactionTime': timestamp.toIso8601String(),
        'items': itemList.map((item) => {
          'name': item.name,
          'price': item.price,
          'quantity': item.quantity,
          'expireDate': item.expireDate != null ? item.expireDate.toIso8601String(): null,
          'imageUrl': item.imageUrl,
          'description': item.description,
          'supplierId': item.supplierId,
          'id': item.id,
        }).toList(),
        'amount': amount,
      }));

      var trans = Transaction(
        id: json.decode(response.body)['name'],
        transactionType: TransactionType.Receive,
        transactionTime: timestamp,
        items: itemList,
        amount: amount,
      );

      store.add(trans);
      
    }catch(err){
      throw err;
    }
    
    notifyListeners();
  }

  Future<void> sendStock(List<Products> itemList) async{
    final url = 'https://storeapp-f3d3b.firebaseio.com/transaction.json?auth=$authToken';
    final timeStamp = DateTime.now();

    double amount = 0.0;
    itemList.forEach((prod) {
      amount = amount + prod.quantity * prod.price;
    });

    try{
      final response = await http.post(url,body: json.encode({
        'transactionType': 'Send',
        'amount': amount,
        'transactionTime': timeStamp.toIso8601String(),
        'items': itemList.map((item) => {
          'id': item.id,
          'name': item.name,
          'price': item.price,
          'quantity': item.quantity,
          'expireDate': item.expireDate != null ? item.expireDate.toIso8601String() : null,
          'imageUrl': item.imageUrl,
          'description': item.description,
          'supplierId': item.supplierId
        }).toList(),
      }));

      var trans = Transaction(
          id: json.decode(response.body)['name'],
          transactionType: TransactionType.Send,
          amount: amount,
          items: itemList,
          transactionTime: timeStamp
      );

      store.add(trans);

    }catch(err){
      throw err;
    }

    notifyListeners();
  }


}