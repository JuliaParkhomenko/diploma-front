import 'package:diploma_frontend/enums/urgency.dart';
import 'package:diploma_frontend/models/stock.dart';
import 'package:diploma_frontend/models/storage.dart';
import 'package:diploma_frontend/models/warehouse.dart';
import 'package:flutter/material.dart';

abstract class BaseWarehouseRepository {
  Future<List<Stock>?> getStockByWarehouse({
    required int id,
    required String productName,
  });

  Future<List<Warehouse>?> getWarehouses();

  Future<int?> add({
    required String name,
    required String address,
    required List<String> managers, //email
    required List<Storage> storages,
  });

  Future<void> assignManager({
    required int warehouseId,
    required String email,
  });

  Future<int?> addAplication({
    required int warehouseId,
    required int productId,
    required int amount,
    required String kind,
    required Urgency urgency,
    required String note,
    required BuildContext context,
  });

  // Future<List<UserAction?>> recentActions({});
}

// ————▄▀▀▀▄░————
// ▄███▀░◐░▄▀▀▀▄░░░░░░
// ░░▄███▀░◐░░░░▌░░░
// ░░░▐░▄▀▀▀▄░░░▌░░░░
// ▄███▀░◐░░░▌░░▌░░░░
// ░░░░▌░░░░░▐▄▄▌░░░░░
// ░░░░▌░░░░▄▀▒▒▀▀▀▀▄
// ░░░▐░░░░▐▒▒▒▒▒▒▒▒▀▀▄
// ░░░▐░░░░▐▄▒▒▒▒▒▒▒▒▒▒▀▄
// ░░░░▀▄░░░░▀▄▒▒▒▒▒▒▒▒▒▒▀▄
// ░░░░░░▀▄▄▄▄▄█▄▄▄▄▄▄▄▄▄▄▄▀▄
// ░░░░░░░░░░░▌▌░▌▌░░░░░
// ░░░░░░░░░░░▌▌░▌▌░░░░░
// ░░░░░░░░░▄▄▌▌▄▌▌░░░░░


