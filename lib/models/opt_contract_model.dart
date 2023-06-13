class OptContractModel {
  int id;
  int supplyContractId;
  int productId;
  String kind;
  String maker;
  int pricePerUnit;
  int minAmount;
  int maxAmount;

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
