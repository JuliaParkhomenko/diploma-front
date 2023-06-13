import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/models/opt_contract_model.dart';
import 'package:diploma_frontend/models/optimization.dart';

class OptModel {
  final Application application;
  num? price;
  OptContractModel? contract;

  OptModel({
    this.contract,
    required this.application,
    required this.price,
  });

  factory OptModel.fromOptimization(OptModel opt, Optimization optimization) {
    return OptModel(
      contract: OptContractModel(
        id: 0,
        supplyContractId: opt.contract?.id ?? 0,
        productId: opt.application.productId,
        kind: opt.application.kind,
        maker: optimization.maker,
        pricePerUnit: optimization.price,
        minAmount: optimization.minAmount,
        maxAmount: optimization.maxAmount,
      ),
      application: Application(
        amount: optimization.amount,
        warehouseId: optimization.warehouseId,
        warehouseName: optimization.warehouseName,
        urgency: '',
        userId: -1,
        id: optimization.applicationId ?? 0,
        kind: '',
        note: '',
        productId: opt.application.productId,
        productMeasurement: '',
        productName: opt.application.productName,
        status: '',
        stockId: 0,
        userName: '',
      ),
      price: optimization.price,
    );
  }
}
