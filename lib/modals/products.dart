import 'package:flutter/material.dart';

class Products{
  final String id;
  final String name;
  final double price;
  double quantity;
  final DateTime expireDate;
  final String imageUrl;
  final String description;
  final String supplierId;

  Products({
      @required this.id,
      @required this.name,
      @required this.price,
      @required this.expireDate,
      @required this.imageUrl,
      @required this.description,
      @required this.supplierId,
      @required this.quantity,
  });
}