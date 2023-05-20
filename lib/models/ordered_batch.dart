class OrderedBatch {
  final int batchId;
  final int productId;
  final String productName;
  final String productMeasurement;
  final String kind;
  final String maker;
  final int amount;
  final DateTime orderDate;

  OrderedBatch({
    required this.batchId,
    required this.productId,
    required this.productName,
    required this.productMeasurement,
    required this.kind,
    required this.maker,
    required this.amount,
    required this.orderDate,
  });

  factory OrderedBatch.fromJson(Map<String, dynamic> json) {
    return OrderedBatch(
      batchId: json['batchId'] as int,
      productId: (json['productId'] as int),
      productName: json['productName'] as String,
      productMeasurement: json['productMeasurement'] as String,
      kind: json['kind'] as String,
      maker: json['maker'] as String,
      amount: json['amount'] as int,
      orderDate: DateTime.parse(json['orderDate'] as String),
    );
  }
}
