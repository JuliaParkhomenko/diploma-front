import 'package:diploma_frontend/enums/action_status.dart';
import 'package:diploma_frontend/models/supply.dart';
import 'package:diploma_frontend/models/supply_condition.dart';

abstract class BaseSupplierRepository {
  Future<int?> add({
    required String name,
    required String address,
    required String email,
    required String phoneNum,
  });

  Future<int?> addcontract({
    required int supplierId,
    required ActionStatus status,
    required DateTime startDate,
    required DateTime endDate,
    required int minAmount,
    required int maxAmount,
    required List<SupplyCondition> addSupplyConditions,
  });

  Future<List<Supply>?> all();
}
