import 'package:flutter/material.dart';

import '../modals/products.dart';

class ReceiveItem extends StatefulWidget {
  final String id;
  final double amount;
  DateTime date;
  final List<Products> prods;

  ReceiveItem({
    @required this.id,
    @required this.amount,
    @required this.date,
    @required this.prods
  });

  @override
  _ReceiveItemState createState() => _ReceiveItemState();
}

class _ReceiveItemState extends State<ReceiveItem> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(widget.amount.toString()),
          subtitle: Text(widget.date.toString().substring(0,10)),
          trailing: Container(
            child: IconButton(
              icon: Icon(Icons.keyboard_arrow_down),
              onPressed: (){
                setState(() {
                  isOpen = !isOpen;
                });
              },
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          height: isOpen ? widget.prods.length.toDouble() * 50 : 0,
          child: ListView(
            children: widget.prods.map((item){
              return Container(
                color: Colors.orangeAccent[100],
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(item.name + '  :-',style: TextStyle(fontFamily: 'Fredoka'),),
                    Text(item.quantity.toInt().toString()+' X '+ 'Rs. ' +item.price.toString()),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
