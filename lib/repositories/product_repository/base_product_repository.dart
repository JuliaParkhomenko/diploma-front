import 'package:diploma_frontend/models/category.dart';
import 'package:diploma_frontend/models/opt_contract_model.dart';
import 'package:diploma_frontend/models/product.dart';

abstract class BaseProductRepository {
  Future<List<Product>?> getProducts();
  Future<List<String>?> getKinds({required int productId});
  Future<void> addCategory({required Category category});
  Future<List<Category>?> getCategories();
  Future<void> addProduct({required Product product});
  Future<List<OptContractModel>?> getContracts({required int productId});
}
