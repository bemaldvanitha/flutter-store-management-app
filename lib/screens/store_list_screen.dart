import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:storemanagment/providers/products_provider.dart';
import '../widgets/store_item.dart';

class StoreListScreen extends StatefulWidget {
  @override
  _StoreListScreenState createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  bool _isInit = false;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setState(() {
      _isLoading = true;
    });
    Provider.of<StoreProvider>(context).fetchAndSetTransaction().then((_){
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final currentProductList = Provider.of<StoreProvider>(context).currentProducts;
    return Scaffold(
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) :
      Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20
            ),
            itemBuilder: (ctx,index){
              return StoreItem(
                id: currentProductList[index].id,
                name: currentProductList[index].name,
                imageUrl: currentProductList[index].imageUrl,
                price: currentProductList[index].price,
                quantity: currentProductList[index].quantity,
              );
            },
            itemCount: currentProductList.length,
        ),
      ),
    );
  }
}
