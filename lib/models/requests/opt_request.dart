class OptRequest {
  final int applicationId;
  final int warehouseId;
  final int productId;
  final int supplyConditionsId;
  final int amount;

  OptRequest({
    required this.applicationId,
    required this.warehouseId,
    required this.productId,
    required this.supplyConditionsId,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'applicationId': applicationId,
      'warehouseId': warehouseId,
      'productId': productId,
      'supplyConditionsId': supplyConditionsId,
      'amount': amount,
    };
  }
}
