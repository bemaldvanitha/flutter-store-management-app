import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../providers/supplier_provider.dart';
import '../widgets/supplier_item.dart';

class CurrentSupplierScreen extends StatefulWidget {
  @override
  _CurrentSupplierScreenState createState() => _CurrentSupplierScreenState();
}

class _CurrentSupplierScreenState extends State<CurrentSupplierScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<SupplierProvider>(context).fetchAndSetSupplier().then((_){
      setState(() {
        _isLoading = false;
      });
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var supplier = Provider.of<SupplierProvider>(context).currentSupplier;
    return Scaffold(
      appBar: AppBar(
        title: Text('Suppliers'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed('/addSupplier');
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      backgroundColor: Colors.yellow[100],
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) :Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: ListView.builder(
            itemBuilder: (ctx,index){
              return SupplierItem(
                name: supplier[index].name,
                email: supplier[index].email,
                number: supplier[index].number,
              );
            },
            itemCount: supplier.length,
        ),
      ),
    );
  }
}
