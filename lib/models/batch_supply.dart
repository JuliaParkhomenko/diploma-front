class BSupply {
  final int id;
  final int productId;
  final String productName;
  final String productMeasurement;
  final int warehouseId;
  final String warehouseName;
  final String kind;
  final String maker;
  final int amount;

  BSupply({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productMeasurement,
    required this.warehouseId,
    required this.warehouseName,
    required this.kind,
    required this.maker,
    required this.amount,
  });

  factory BSupply.fromJson(Map<String, dynamic> json) {
    return BSupply(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      productMeasurement: json['productMeasurement'],
      warehouseId: json['warehouseId'],
      warehouseName: json['warehouseName'],
      kind: json['kind'],
      maker: json['maker'],
      amount: json['amount'],
    );
  }
}

class BatchSupply {
  final int id;
  final String date;
  final String supplier;
  final int supplierId;
  final List<BSupply> batches;

  BatchSupply({
    required this.id,
    required this.date,
    required this.supplier,
    required this.supplierId,
    required this.batches,
  });

  factory BatchSupply.fromJson(Map<String, dynamic> json) {
    return BatchSupply(
      id: json['id'],
      date: json['date'],
      supplier: json['supplier'],
      supplierId: json['supplierId'],
      batches: List<BSupply>.from(json['batches'].map<BSupply>((e) {
        return BSupply.fromJson(e);
      })),
    );
  }
}
