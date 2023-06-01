class Application {
  final int id;
  final int stockId;
  final int amount;
  final String productName;
  final String productMeasurement;
  final String kind;
  final String urgency;
  final String note;
  final String status;
  final int userId;
  final String userName;
  final int warehouseId;
  final String warehouseName;

  Application({
    required this.id,
    required this.stockId,
    required this.amount,
    required this.productName,
    required this.productMeasurement,
    required this.kind,
    required this.urgency,
    required this.note,
    required this.status,
    required this.userId,
    required this.userName,
    required this.warehouseId,
    required this.warehouseName,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      stockId: json['stockId'],
      amount: json['amount'],
      productName: json['productName'],
      productMeasurement: json['productMeasurement'],
      kind: json['kind'],
      urgency: json['urgency'],
      note: json['note'],
      status: json['status'],
      userId: json['userId'],
      userName: json['userName'],
      warehouseId: json['warehouseId'],
      warehouseName: json['warehouseName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stockId': stockId,
      'amount': amount,
      'productName': productName,
      'productMeasurement': productMeasurement,
      'kind': kind,
      'urgency': urgency,
      'note': note,
      'status': status,
      'userId': userId,
      'userName': userName,
      'warehouseId': warehouseId,
      'warehouseName': warehouseName,
    };
  }
}
