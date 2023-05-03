import 'package:diploma_frontend/models/product.dart';

abstract class BaseProductRepository {
  Future<List<Product>?> getProducts();
}
