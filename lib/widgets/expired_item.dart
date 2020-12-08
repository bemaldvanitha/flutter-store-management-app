import 'package:flutter/material.dart';

class ExpiredItem extends StatelessWidget {
  final String id;
  final String name;
  final double quantity;
  final DateTime expireDate;
  final String imageUrl;
  final String supplierId;

  ExpiredItem({
    @required this.id,
    @required this.name,
    @required this.quantity,
    @required this.expireDate,
    @required this.imageUrl,
    @required this.supplierId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7, // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topRight,
                children: <Widget>[
                  Image.network(imageUrl,fit: BoxFit.cover,),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Colors.white.withOpacity(0.8),Colors.grey.withOpacity(0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    ),
                      padding: EdgeInsets.all(15),
                      child: Text(
                          name,
                        style: TextStyle(
                          fontFamily: 'Architect'
                        ),
                      )
                  ),
                ],
            ),
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.purple.withOpacity(0.5),Colors.redAccent.withOpacity(0.5)],
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                    quantity.toInt().toString(),
                  style: TextStyle(
                    fontFamily: 'Architect',
                    fontSize: 20,
                  ),
                ),
                Text(
                    expireDate.toString().substring(0,10),
                  style: TextStyle(
                    fontFamily: 'Architect',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
