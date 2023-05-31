import 'package:diploma_frontend/models/supply_condition.dart';

class SupplyContract {
  final int id;
  final int supplierId;
  final DateTime startDate;
  final DateTime endDate;
  final int minAmount;
  final String supplierName;
  final int maxAmount;
  final List<SupplyCondition> supplyCondition;

  SupplyContract({
    required this.id,
    required this.supplierName,
    required this.supplyCondition,
    required this.supplierId,
    required this.startDate,
    required this.endDate,
    required this.maxAmount,
    required this.minAmount,
  });

  factory SupplyContract.fromJson(Map<String, dynamic> json) {
    return SupplyContract(
      supplyCondition: json['supplyConditions'].map<SupplyCondition>((e) {
        return SupplyCondition.fromJson(e);
      }).toList(),
      id: json['id'],
      supplierId: json['supplierId'],
      supplierName: json['supplierName'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      maxAmount: json['maxAmount'],
      minAmount: json['minAmount'],
    );
  }
}
