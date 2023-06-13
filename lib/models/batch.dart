// ignore_for_file: prefer_null_aware_operators

import 'package:diploma_frontend/enums/action_status.dart';
import 'package:diploma_frontend/models/batch_audit.dart';
import 'package:flutter/material.dart';

class Batch {
  final int id;
  final String kind;
  final String maker;
  final ActionStatus status;
  final int amount;
  final DateTime productionDate;
  final DateTime expirationDate;
  final DateTime? notificationDate;
  final List<BatchAudit>? batchAudit;

  Batch({
    required this.id,
    this.batchAudit,
    required this.kind,
    required this.maker,
    required this.status,
    required this.amount,
    required this.productionDate,
    required this.expirationDate,
    this.notificationDate,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      batchAudit: json['batchAudit'] != null
          ? json['batchAudit'].map<BatchAudit>((e) {
              return BatchAudit.fromJson(e);
            }).toList()
          : null,
      id: json['id'] as int,
      kind: json['kind'] as String,
      maker: json['maker'] as String,
      status: (json['status'] as String).getActionStatus(),
      amount: json['amount'] as int,
      productionDate: DateTime.parse(json['productionDate'] as String),
      expirationDate: DateTime.parse(json['expirationDate'] as String),
      notificationDate: json['notificationDate'] != null
          ? DateTime.parse(json['notificationDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson(BuildContext context) {
    return {
      'id': id,
      'kind': kind,
      'maker': maker,
      'status': status.getActionStatus(context),
      'amount': amount,
      'productionDate': productionDate.toIso8601String(),
      'expirationDate': expirationDate.toIso8601String(),
    };
  }
}
