class Optimization {
  final int amount;
  final int conditionId;
  final int cost;
  final String productName;
  final String warehouseName;
  final int price;
  final int? applicationId;
  final int minAmount;
  final int maxAmount;

  Optimization({
    this.applicationId,
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
      applicationId: json['originalOrder'] == null
          ? null
          : json['originalOrder']['applicationId'],
      warehouseName: json['warehouseName'],
      amount: json['amount'],
      conditionId: json['conditions']['id'],
      cost: json['cost'],
      price: json['conditions']['pricePerUnit'],
      productName: json['conditions']['productName'],
      minAmount: json['conditions']['minAmount'],
      maxAmount: json['conditions']['maxAmount'],
    );
  }
}
