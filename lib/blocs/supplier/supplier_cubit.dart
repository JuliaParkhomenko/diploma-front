import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/models/supplier.dart';
import 'package:diploma_frontend/repositories/supplier_repository/supplier_repository.dart';
import 'package:meta/meta.dart';

part 'supplier_state.dart';

class SupplierCubit extends Cubit<SupplierState> {
  final SupplierRepository _repository;
  SupplierCubit(this._repository) : super(SupplierInitial());

  Future<void> fetchSuppliers(String name) async {
    try {
      emit(SupplierLoading());
      final List<Supplier>? suppliers = await _repository.all(name: name);
      emit(SupplierLoaded(suppliers!));
    } catch (e) {
      emit(SupplierError(e.toString()));
    }
  }

  void clear() {
    emit(SupplierInitial());
  }
}
