class SupplyCondition {
  final int productId;
  final int pricePerUnit;
  final String kind;
  final String maker;
  final int minAmount;
  final String maxAmount;

  SupplyCondition({
    required this.productId,
    required this.pricePerUnit,
    required this.kind,
    required this.maker,
    required this.minAmount,
    required this.maxAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'pricePerUnit': pricePerUnit,
      'kind': kind,
      'maker': maker,
      'minAmount': minAmount,
      'maxAmount': maxAmount,
    };
  }

  factory SupplyCondition.fromJson(Map<String, dynamic> json) {
    return SupplyCondition(
      productId: json['productId'],
      pricePerUnit: json['pricePerUnit'],
      kind: json['kind'],
      maker: json['maker'],
      minAmount: json['minAmount'],
      maxAmount: json['maxAmount'],
    );
  }
}
