import 'package:flutter/material.dart';

class Stock {
  final int id;
  final int productId;
  final String productName;
  final double amount;
  final double ordered;

  Stock({
    required this.id,
    required this.productId,
    required this.productName,
    required this.amount,
    required this.ordered,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      amount: json['amount'].toDouble(),
      ordered: json['ordered'].toDouble(),
    );
  }

  double get total => amount + ordered;
}
