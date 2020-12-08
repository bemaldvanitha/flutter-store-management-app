import 'package:flutter/material.dart';

class Cart{
  final String productId;
  final String name;
  double quantity;
  final DateTime curDate;

  Cart({
    @required this.productId,
    @required this.name,
    @required this.curDate,
    @required this.quantity,
  });

}