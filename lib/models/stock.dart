class Stock {
  final int id;
  final int productId;
  final String productName;
  final double amount;
  final double ordered;
  final String measurement;

  Stock({
    required this.id,
    required this.productId,
    required this.measurement,
    required this.productName,
    required this.amount,
    required this.ordered,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      measurement: json['measurement'],
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      amount: json['amount'].toDouble(),
      ordered: json['ordered'].toDouble(),
    );
  }

  String get total => '${amount + ordered} $measurement';
  String get amountText => '$amount $measurement';
  String get orderedText => '$ordered $measurement';
}
