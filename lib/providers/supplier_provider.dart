import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../modals/supplier.dart';

class SupplierProvider with ChangeNotifier{
  List<Supplier> supplierList = [
    /*Supplier(
        id: 's1',
        name: 'peter max',
        number: '0714587563',
        email: 'peter@gmail.com'
    ),
    Supplier(
        id: 's2',
        name: 'bemal dvanitha',
        number: '0716897452',
        email: 'bdvidanagamachchi@gmail.com'
    ),
    Supplier(
        id: 's3',
        name: 'chamodi jayodya',
        number: '0717788542',
        email: 'chamo@gmail.com'
    ),
    Supplier(
        id: 's4',
        name: 'peshla madu',
        number: '0775514258',
        email: 'madu@gmail.com'
    ),*/
  ];

  final String authToken;

  SupplierProvider({
    @required this.authToken,
  });

  List<Supplier> get currentSupplier{
    return [...supplierList];
  }

  Future<void> fetchAndSetSupplier() async {
    final url = 'https://storeapp-f3d3b.firebaseio.com/suppliers.json?auth=$authToken';

    try{
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String,dynamic>;
      final List<Supplier> listOfSuppliers = [];

      if(data!= null) {
        data.forEach((key, value) {
          listOfSuppliers.add(Supplier(
              id: key,
              number: value['number'],
              email: value['email'],
              name: value['name']
          ));
        });
      }
      supplierList = listOfSuppliers;
    }catch(err){
      throw err;
    }
  }

  Future<void> addSupplier(Supplier supplier) async {
    final url = 'https://storeapp-f3d3b.firebaseio.com/suppliers.json?auth=$authToken';
    try{
      final response = await http.post(url,body: json.encode({
        'name': supplier.name,
        'number': supplier.number,
        'email': supplier.email
      }));
      supplierList.add(Supplier(
        id: json.decode(response.body)['name'],
        name: supplier.name,
        email: supplier.email,
        number: supplier.number
      ));
    }catch(err){
      throw err;
    }

    notifyListeners();
  }
}