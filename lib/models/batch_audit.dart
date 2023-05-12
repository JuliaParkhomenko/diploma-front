class BatchAudit {
  final int id;
  final double amount;
  final double remaining;
  final String reason;
  final DateTime date;

  BatchAudit({
    required this.id,
    required this.amount,
    required this.remaining,
    required this.reason,
    required this.date,
  });

  BatchAudit.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        amount = json['amount'],
        remaining = json['remaining'],
        reason = json['reason'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'remaining': remaining,
        'reason': reason,
        'date': date.toIso8601String(),
      };
}
