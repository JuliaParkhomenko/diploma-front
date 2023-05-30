part of 'supplier_cubit.dart';

@immutable
abstract class SupplierState {}

class SupplierInitial extends SupplierState {}

class SupplierLoading extends SupplierState {}

class SupplierLoaded extends SupplierState {
  final List<Supplier> suppliers;

  SupplierLoaded(this.suppliers);
}

class SupplierError extends SupplierState {
  final String error;
  SupplierError(this.error);
}
