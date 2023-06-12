import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/models/supply_contract.dart';

class OptModel {
  final Application application;
  num percentage;
  num? price;
  SupplyContract? contract;

  OptModel({
    this.contract,
    required this.application,
    required this.percentage,
    required this.price,
  });
}
