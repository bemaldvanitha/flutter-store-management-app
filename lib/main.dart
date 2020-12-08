import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products_provider.dart';
import './screens/store_list_screen.dart';
import './screens/item_detail_screen.dart';
import './screens/recieve_screen.dart';
import './screens/tab_screen.dart';
import './screens/deliver_screen.dart';
import './screens/expired_screen.dart';
import './screens/add_items_screen.dart';
import './providers/cart_provider.dart';
import './screens/reliseItem_screen.dart';
import './providers/supplier_provider.dart';
import './screens/current_supplier_screen.dart';
import './screens/add_supplier.dart';
import './screens/auth_screen.dart';
import './providers/auth_provider.dart';

void main() {
  runApp(StoreApp());
}

class StoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx){
              return Auth();
            },
          ),
          ChangeNotifierProxyProvider<Auth,StoreProvider>(
            create: (ctx){
              return StoreProvider(authToken: null);
            },
            update: (ctx,auth,prevStore){
              return StoreProvider(authToken: auth.token);
            },
          ),
          ChangeNotifierProvider(
            create: (ctx){
              return CartProvider();
            },
          ),
          ChangeNotifierProxyProvider<Auth,SupplierProvider>(
            create: (ctx){
              return SupplierProvider(authToken: null);
            },
            update: (ctx,auth,prevSupplier){
              return SupplierProvider(authToken: auth.token);
            },
          ),
        ],
        child: MaterialApp(
          title: "StoreApp",
          theme: ThemeData(
            primaryColor: Colors.deepOrange[600],
            accentColor: Colors.orangeAccent,
            fontFamily: 'Alice'
          ),
          home: AuthScreen(),
          routes: {
            '/detail': (ctx) => ItemDetailScreen(),
            '/receive': (ctx) => ReceiveScreen(),
            '/deliver': (ctx) => DeliverScreen(),
            '/expired': (ctx) => ExpiredScreen(),
            '/add': (ctx) => AddItemsScreen(),
            '/release': (ctx) => ReleaseItemScreen(),
            '/supplier': (ctx) => CurrentSupplierScreen(),
            '/addSupplier': (ctx) => AddSupplierScreen(),
            '/main': (ctx) => TabScreen(),
          },
        ),
      );
  }
}
