import 'package:diploma_frontend/models/supplier.dart';
import 'package:diploma_frontend/models/supply_condition.dart';
import 'package:diploma_frontend/models/supply_contract.dart';
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

  Future<List<SupplyContract>?> supplierContracts({
    required bool old,
    String productName = '',
    String supplierName = '',
    String maker = '',
  });
}
