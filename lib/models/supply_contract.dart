import 'package:diploma_frontend/models/supply_condition.dart';

class SupplyContract {
  final int id;
  final int supplierId;
  final DateTime startDate;
  final DateTime endDate;
  final int minAmount;
  final int maxAmount;
  final List<SupplyCondition> supplyCondition;

  SupplyContract({
    required this.supplyCondition,
    required this.id,
    required this.supplierId,
    required this.startDate,
    required this.endDate,
    required this.maxAmount,
    required this.minAmount,
  });

  factory SupplyContract.fromJson(Map<String, dynamic> json) {
    return SupplyContract(
      supplyCondition: json['supplyCondition'].map((e) {
        return SupplyCondition.fromJson(e);
      }).toList(),
      id: json['id'],
      supplierId: json['supplierId'],
      startDate: json['startDate'].toIso8601String(),
      endDate: json['endDate'].toIso8601String(),
      maxAmount: json['maxAmount'],
      minAmount: json['minAmount'],
    );
  }
}
