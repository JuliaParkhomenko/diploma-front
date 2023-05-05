import 'package:diploma_frontend/enums/action_status.dart';
import 'package:diploma_frontend/enums/action_type.dart';
import 'package:diploma_frontend/enums/role.dart';

class UserAction {
  final int userId;
  final Role userRole;
  final String userFullName;
  final ActionType type;
  final ActionStatus action;
  final int targetId;
  final int productId;
  final String productName;
  final String productMeasurement;
  final int amount;
  final DateTime date;

  UserAction({
    required this.userId,
    required this.userRole,
    required this.userFullName,
    required this.type,
    required this.action,
    required this.targetId,
    required this.productId,
    required this.productName,
    required this.productMeasurement,
    required this.amount,
    required this.date,
  });

  factory UserAction.fromJson(Map<String, dynamic> json) {
    return UserAction(
      userId: json['userId'] as int,
      userRole: (json['userRole'] as String).getRole(),
      userFullName: json['userFullName'] as String,
      type: (json['type'] as String).getActionType(),
      action: (json['action'] as String).getActionStatus(),
      targetId: json['targetId'] as int,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      productMeasurement: json['productMeasurement'] as String,
      amount: json['amount'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userRole': userRole,
      'userFullName': userFullName,
      'type': type,
      'action': action,
      'targetId': targetId,
      'productId': productId,
      'productName': productName,
      'productMeasurement': productMeasurement,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}
