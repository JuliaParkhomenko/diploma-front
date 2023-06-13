import 'package:diploma_frontend/models/opt_model.dart';

class OptRequest {
  final int applicationId;
  final int warehouseId;
  final int productId;
  final int? supplyConditionsId;
  final int amount;

  OptRequest({
    required this.applicationId,
    required this.warehouseId,
    required this.productId,
    this.supplyConditionsId,
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

List<OptRequest> fromOptModel(List<OptModel> opts) {
  return opts
      .map<OptRequest>((e) => OptRequest(
            applicationId: e.application.id,
            warehouseId: e.application.warehouseId,
            productId: e.application.productId,
            supplyConditionsId: e.contract?.supplyContractId,
            amount: e.application.amount,
          ))
      .toList();
}
