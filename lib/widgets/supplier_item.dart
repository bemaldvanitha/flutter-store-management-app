import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class SupplierItem extends StatelessWidget {
  final String name;
  final String email;
  final String number;

  SupplierItem({
    @required this.name,
    @required this.email,
    @required this.number
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purpleAccent[100],Colors.purple[100]],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7
              )
            ]
          ),
          child: Column(
            children: <Widget>[
              Divider(
                color: Colors.black45,
                thickness: 1.2,
              ),
              Container(
                child: Text(
                    name,
                  style: TextStyle(
                    fontFamily: 'Architect',
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: Colors.white
                  ),
                ),
              ),
              Divider(
                color: Colors.black45,
                thickness: 1.2,
              ),
              Container(
                child: Text(
                    email,
                  style: TextStyle(
                      fontFamily: 'Architect',
                      letterSpacing: 1.5,
                      fontSize: 16,
                      color: Colors.white
                  ),
                ),
              ),
              Divider(
                color: Colors.black45,
                thickness: 1.2,
              ),
              Container(
                child: Text(
                    number,
                  style: TextStyle(
                      fontFamily: 'Architect',
                      letterSpacing: 1.5,
                      fontSize: 16,
                      color: Colors.white
                  ),
                ),
              ),
              Divider(
                color: Colors.black45,
                thickness: 1.2,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey.withOpacity(0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                    Icons.email,
                  color: Colors.red,
                ),
                onPressed: (){
                  UrlLauncher.launch('mailto:'+email);
                },
              ),
              IconButton(
                icon: Icon(
                    Icons.phone,
                  color: Colors.red,
                ),
                onPressed: (){
                  UrlLauncher.launch('tel://'+number);
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
