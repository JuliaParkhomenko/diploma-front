class SupplyCondition {
  final int id;
  final String productName;
  final String productMeasurement;
  final String kind;
  final String maker;
  final double pricePerUnit;
  final int minAmount;
  final int maxAmount;

  SupplyCondition({
    required this.id,
    required this.productName,
    required this.productMeasurement,
    required this.kind,
    required this.maker,
    required this.pricePerUnit,
    required this.minAmount,
    required this.maxAmount,
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
}
