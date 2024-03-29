import 'package:diploma_frontend/enums/urgency.dart';
import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/models/stock.dart';
import 'package:diploma_frontend/models/user_action.dart';
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
    required int manager,
    required int maxFamount,
    required int maxCamount,
    required int maxFridgeAmount,
  });

  Future<List<Warehouse>?> getWarehousesForAdmin();

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

  Future<List<UserAction>?> recentActions({
    required int warehouseId,
  });

  Future<List<Application>?> getApplications({
    String warehouseName = '',
    required bool past,
  });

  Future<void> declineApplications({required List<Application> ids});
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


