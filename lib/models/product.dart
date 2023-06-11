import 'package:diploma_frontend/models/category.dart';

class Product {
  final int id;
  final Category category;
  final String name;
  final String measurement;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.measurement,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      category: Category.fromJson(json['category']),
      name: json['name'] as String,
      measurement: json['measurement'] as String,
    );
  }

  factory Product.empty() {
    return Product(
      id: -1,
      category: Category(
        id: -1,
        name: '',
        minTemp: -1,
        maxTemp: -1,
      ),
      name: '',
      measurement: '',
    );
  }
}
