class Statistics {
  final int productId;
  final String productName;
  final String productMeasurement;
  final num userDaily;
  final int totalUsed;
  final int totalWrittenOff;
  final int total;
  final num userPercent;
  final num writtenOffPercents;

  Statistics({
    required this.productId,
    required this.productName,
    required this.productMeasurement,
    required this.userDaily,
    required this.totalUsed,
    required this.totalWrittenOff,
    required this.total,
    required this.userPercent,
    required this.writtenOffPercents,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      productId: json['productId'],
      productName: json['productName'],
      productMeasurement: json['productMeasurement'],
      userDaily: json['usedDaily'],
      totalUsed: json['totalUsed'],
      totalWrittenOff: json['totalWrittenOff'],
      total: json['total'],
      userPercent: json['usedPercent'],
      writtenOffPercents: json['writtenOffPercent'],
    );
  }
}
