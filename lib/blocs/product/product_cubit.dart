import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/product.dart';
import 'package:diploma_frontend/repositories/product_repository/product_repository.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository;
  ProductCubit(this._repository) : super(ProductInitial());

  Future<void> fetchProducts() async {
    try {
      emit(ProductLoading());
      final List<Product>? products = await _repository.getProducts();
      emit(ProductLoaded(products!));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _repository.addProduct(product: product);
      await fetchProducts();
    } catch (_) {}
  }

  void clear() {
    emit(ProductInitial());
  }
}
