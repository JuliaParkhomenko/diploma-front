import 'package:diploma_frontend/models/stock.dart';

class Product {
  final int id;
  final int categoryId;
  final String? category;
  final String name;
  final String measurement;
  final List<Stock> stocks;
  final List<dynamic>? supplyConditions;

  Product({
    required this.id,
    required this.categoryId,
    this.category,
    required this.name,
    required this.measurement,
    required this.stocks,
    this.supplyConditions,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['categoryId'],
      name: json['name'],
      measurement: json['measurement'],
      stocks: json['stocks'].map<Stock>((e) {
        return Stock.fromJson(e);
      }).toList(),
    );
  }
}
