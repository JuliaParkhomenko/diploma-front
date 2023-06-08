import 'package:diploma_frontend/models/supply_condition.dart';

class ExpiringContract {
  final int id;
  final int supplierId;
  final DateTime endDate;
  final String supplierName;
  final List<SupplyCondition> supplyCondition;

  ExpiringContract({
    required this.id,
    required this.supplierName,
    required this.supplyCondition,
    required this.supplierId,
    required this.endDate,
  });

  factory ExpiringContract.fromJson(Map<String, dynamic> json) {
    return ExpiringContract(
      supplyCondition: json['supplyConditions'].map<SupplyCondition>((e) {
        return SupplyCondition.fromJson(e);
      }).toList(),
      id: json['id'],
      supplierId: json['supplierId'],
      supplierName: json['supplierName'],
      endDate: DateTime.parse(json['endDate']),
    );
  }
}
