import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.redAccent[100],
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
                'Stock app',
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('Stocks'),
            onTap: (){
              Navigator.of(context).pushNamed('/main');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.new_releases),
            title: Text('Expired'),
            onTap: (){
              Navigator.of(context).pushNamed('/expired');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Supplier'),
            onTap: (){
              Navigator.of(context).pushNamed('/supplier');
            },
          )
        ],
      ),
    );
  }
}
