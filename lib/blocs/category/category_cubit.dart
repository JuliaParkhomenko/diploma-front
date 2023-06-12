import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/category.dart';
import 'package:diploma_frontend/repositories/product_repository/product_repository.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ProductRepository _repository;
  CategoryCubit(this._repository) : super(CategoryInitial());

  void clear() {
    emit(CategoryInitial());
  }

  Future<void> fetchCategories() async {
    try {
      emit(CategoryLoading());
      final List<Category>? categories = await _repository.getCategories();
      emit(CategoryLoaded(categories!));
    } catch (error) {
      emit(CategoryError(error.toString()));
    }
  }
}
