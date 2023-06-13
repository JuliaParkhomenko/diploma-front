class Optimization {
  final int amount;
  final int conditionId;
  final int cost;
  final String productName;
  final String warehouseName;
  final int warehouseId;
  final int price;
  final int? applicationId;
  final String kind;
  final int minAmount;
  final int maxAmount;
  final int? productId;
  final String maker;

  Optimization({
    this.applicationId,
    required this.maker,
    this.productId,
    required this.warehouseId,
    required this.kind,
    required this.minAmount,
    required this.maxAmount,
    required this.warehouseName,
    required this.amount,
    required this.conditionId,
    required this.cost,
    required this.productName,
    required this.price,
  });

  factory Optimization.fromJson(Map<String, dynamic> json) {
    return Optimization(
      warehouseId: json['warehouseId'],
      applicationId: json['originalOrder'] == null
          ? null
          : json['originalOrder']['applicationId'],
      maker: json['conditions']['maker'],
      kind: json['conditions']['kind'],
      warehouseName: json['warehouseName'],
      amount: json['amount'],
      conditionId: json['conditions']['id'],
      productId: json['originalOrder'] == null
          ? null
          : json['originalOrder']['productId'],
      cost: json['cost'],
      price: json['conditions']['pricePerUnit'],
      productName: json['conditions']['productName'],
      minAmount: json['conditions']['minAmount'],
      maxAmount: json['conditions']['maxAmount'],
    );
  }
}
