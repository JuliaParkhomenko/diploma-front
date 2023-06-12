class ExpiringBatch {
  final int batchId;
  final int productId;
  final String productName;
  final DateTime expirationDate;
  final double amount;
  final String measurement;

  ExpiringBatch({
    required this.batchId,
    required this.productId,
    required this.productName,
    required this.expirationDate,
    required this.amount,
    required this.measurement,
  });

  factory ExpiringBatch.fromJson(Map<String, dynamic> json) {
    return ExpiringBatch(
      batchId: json['batchId'] as int,
      productId: (json['productId'] as int),
      productName: json['productName'] as String,
      measurement: json['measurement'] as String,
      amount: json['amount'] as double,
      expirationDate: DateTime.parse(json['expirationDate'] as String),
    );
  }
}
