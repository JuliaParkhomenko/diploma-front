class OptContractModel {
  final int id;
  final int supplyContractId;
  final int productId;
  final String kind;
  final String maker;
  final int pricePerUnit;
  final int minAmount;
  final int maxAmount;

  OptContractModel({
    required this.id,
    required this.supplyContractId,
    required this.productId,
    required this.kind,
    required this.maker,
    required this.pricePerUnit,
    required this.minAmount,
    required this.maxAmount,
  });

  factory OptContractModel.fromJson(Map<String, dynamic> json) {
    return OptContractModel(
      id: json['id'],
      supplyContractId: json['supplyContractId'],
      productId: json['productId'],
      kind: json['kind'],
      maker: json['maker'],
      pricePerUnit: json['pricePerUnit'],
      minAmount: json['minAmount'],
      maxAmount: json['maxAmount'],
    );
  }
}
