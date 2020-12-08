import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/add_form.dart';
import '../providers/products_provider.dart';
import '../modals/transaction.dart';
import '../modals/products.dart';

class AddItemsScreen extends StatefulWidget {
  @override
  _AddItemsScreenState createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  var amount = 1;
  List<Products> _received = [];

  void _addProducts(Products products){
    _received.add(products);
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    final products = Provider.of<StoreProvider>(context);

    void _addToTransaction() async {
      setState(() {
         _isLoading = true;
      });

      await products.receiveStock(_received);

      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('received items'),
        actions: <Widget>[
           _received.isEmpty ? Container():
           FlatButton.icon(
              onPressed: () => _addToTransaction(),
              icon: Icon(Icons.save),
              label: Text('save')
          ),
        ],
      ),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
          itemBuilder: (ctx,index){
            return AddForm(addProduct: _addProducts,);
          },
          itemCount: amount,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            amount = amount +1;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
