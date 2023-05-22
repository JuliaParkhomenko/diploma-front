import 'package:diploma_frontend/models/product.dart';

abstract class BaseProductRepository {
  Future<List<Product>?> getProducts();
  Future<List<String>?> getKinds({required int productId});
}
