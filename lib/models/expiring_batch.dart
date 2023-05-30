class ExpiringBatch {
  final int batchId;
  final int productId;
  final String productName;
  final DateTime expirationDate;

  ExpiringBatch({
    required this.batchId,
    required this.productId,
    required this.productName,
    required this.expirationDate,
  });

  factory ExpiringBatch.fromJson(Map<String, dynamic> json) {
    return ExpiringBatch(
      batchId: json['batchId'] as int,
      productId: (json['productId'] as int),
      productName: json['productName'] as String,
      expirationDate: DateTime.parse(json['expirationDate'] as String),
    );
  }
}
