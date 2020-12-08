import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/recieve_screen.dart';
import '../screens/store_list_screen.dart';
import '../screens/deliver_screen.dart';
import '../widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Store App',textAlign: TextAlign.center,),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.shopping_cart),
                text: 'Current',
              ),
              Tab(
                icon: Icon(Icons.receipt),
                text: 'Receive'
              ),
              Tab(
                icon: Icon(Icons.drive_eta),
                text: 'Deliver',
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_basket),
              onPressed: (){
                Navigator.of(context).pushNamed('/add');
              },
            ),
            IconButton(
              icon: Icon(Icons.library_add),
              onPressed: (){
                Navigator.of(context).pushNamed('/release');
              },
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            StoreListScreen(),
            ReceiveScreen(),
            DeliverScreen(),
          ],
        ),
      ),
    );
  }
}
