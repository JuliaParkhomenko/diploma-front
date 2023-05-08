part of 'specific_product_cubit.dart';

@immutable
abstract class SpecificProductState {}

class SpecificProductInitial extends SpecificProductState {}

class SpecificProductLoading extends SpecificProductState {}

class SpecificProductLoaded extends SpecificProductState {
  final List<Batch> products;
  SpecificProductLoaded(this.products);
}

class SpecificProductError extends SpecificProductState {
  final String error;
  SpecificProductError(this.error);
}
