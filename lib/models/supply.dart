import 'package:diploma_frontend/models/supply_contract.dart';

class Supply {
  final int id;
  final String name;
  final String address;
  final String email;
  final String phoneNum;
  final List<SupplyContract> supplyContract;

  Supply({
    required this.supplyContract,
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNum,
  });

  factory Supply.fromJson(Map<String, dynamic> json) {
    return Supply(
      supplyContract: json['supplyContract'].map((e) {
        return SupplyContract.fromJson(e);
      }).toList(),
      id: json['id'],
      name: json['name'],
      address: json['address'],
      email: json['email'],
      phoneNum: json['phoneNum'],
    );
  }
}
