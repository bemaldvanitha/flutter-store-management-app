import 'package:flutter/material.dart';

import '../modals/products.dart';

enum TransactionType{
  Receive,
  Send
}

class Transaction{
  final String id;
  final List<Products> items;
  final double amount;
  final DateTime transactionTime;
  final TransactionType transactionType;

  Transaction({
    @required this.id,
    @required this.items,
    @required this.amount,
    @required this.transactionTime,
    @required this.transactionType
  });
}