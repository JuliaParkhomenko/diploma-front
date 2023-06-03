// ignore_for_file: unnecessary_lambdas

class Statistics {
  final double ordered;
  final double used;
  final double writtenOff;
  final List<ChartPoint> orderedList;
  final List<ChartPoint> usedList;
  final List<ChartPoint> writtenOffList;

  Statistics({
    required this.ordered,
    required this.used,
    required this.writtenOff,
    required this.orderedList,
    required this.usedList,
    required this.writtenOffList,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    final orderedList = (json['orderedList'] as List)
        .map((item) => ChartPoint.fromJson(item))
        .toList();

    final usedList = (json['usedList'] as List)
        .map((item) => ChartPoint.fromJson(item))
        .toList();

    final writtenOffList = (json['writtenOffList'] as List)
        .map((item) => ChartPoint.fromJson(item))
        .toList();
    return Statistics(
      ordered: json['ordered'] as double,
      used: json['used'] as double,
      writtenOff: json['writtenOff'] as double,
      orderedList: orderedList,
      usedList: usedList,
      writtenOffList: writtenOffList,
    );
  }
}

class ChartPoint {
  final double amount;
  final DateTime date;

  ChartPoint({
    required this.amount,
    required this.date,
  });

  factory ChartPoint.fromJson(Map<String, dynamic> json) {
    return ChartPoint(
      amount: json['amount'],
      date: DateTime.now(),
    );
  }
}
