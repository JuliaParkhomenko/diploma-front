import 'package:diploma_frontend/enums/action_status.dart';
import 'package:diploma_frontend/models/supplier.dart';
import 'package:diploma_frontend/models/supply_condition.dart';
import 'package:flutter/material.dart';

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
    required BuildContext context,
  });

  Future<List<Supplier>?> all({
    required String name,
  });

  Future<void> edit({
    required int id,
    required String name,
    required String address,
    required String email,
    required String phoneNum,
  });
}
