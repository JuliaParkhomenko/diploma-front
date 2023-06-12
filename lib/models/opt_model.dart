import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/models/opt_contract_model.dart';

class OptModel {
  final Application application;
  num? price;
  OptContractModel? contract;

  OptModel({
    this.contract,
    required this.application,
    required this.price,
  });
}
