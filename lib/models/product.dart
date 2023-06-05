import 'package:diploma_frontend/models/stock.dart';

class Product {
  final int id;
  final int categoryId;
  final String? category;
  final String name;
  final String measurement;
  final List<Stock> stocks;

  Product({
    required this.id,
    required this.categoryId,
    this.category,
    required this.name,
    required this.measurement,
    required this.stocks,
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

  factory Product.empty() {
    return Product(
      id: -1,
      name: '',
      categoryId: -1,
      measurement: '',
      stocks: [],
    );
  }
}
