class SupplyCondition {
  final int id;
  final String productName;
  final String productMeasurement;
  final String kind;
  final String maker;
  final double pricePerUnit;
  final double minAmount;
  final double maxAmount;
  final int productId;

  SupplyCondition({
    required this.id,
    required this.productName,
    required this.productMeasurement,
    required this.kind,
    required this.maker,
    required this.pricePerUnit,
    required this.minAmount,
    required this.maxAmount,
    this.productId = -1,
  });

  factory SupplyCondition.fromJson(Map<String, dynamic> json) {
    return SupplyCondition(
      id: json['id'],
      productName: json['productName'],
      productMeasurement: json['productMeasurement'],
      kind: json['kind'],
      maker: json['maker'],
      pricePerUnit: json['pricePerUnit'],
      minAmount: json['minAmount'],
      maxAmount: json['maxAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'productMeasurement': productMeasurement,
      'kind': kind,
      'maker': maker,
      'pricePerUnit': pricePerUnit,
      'minAmount': minAmount,
      'maxAmount': maxAmount,
    };
  }

  Map<String, dynamic> newConditionsToJson() {
    return {
      'productId': productId,
      'kind': kind,
      'maker': maker,
      'pricePerUnit': pricePerUnit,
      'minAmount': minAmount,
      'maxAmount': maxAmount,
    };
  }

  //  factory SupplyCondition.empty() {
  //   return SupplyCondition(id: -1, productName: '', productMeasurement: '', kind: '', maker: '', pricePerUnit: -1, minAmount: -1, maxAmount: -1, );
  // }
}
