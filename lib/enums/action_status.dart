import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

enum ActionStatus {
  ordered,
  recieved,
  used,
  writtenOff,
  sent,
  confirmed,
  canceled,
}

extension ActionStatusConverter on String {
  ActionStatus getActionStatus() {
    switch (this) {
      case 'ordered':
        return ActionStatus.ordered;
      case 'received':
        return ActionStatus.recieved;
      case 'used':
        return ActionStatus.used;
      case 'written off':
        return ActionStatus.writtenOff;
      case 'sent':
        return ActionStatus.sent;
      case 'confirmed':
        return ActionStatus.confirmed;
      case 'canceled':
        return ActionStatus.canceled;
      default:
        return ActionStatus.ordered;
    }
  }
}

extension ActionStatusToString on ActionStatus {
  String getActionStatus(BuildContext context) {
    switch (this) {
      case ActionStatus.ordered:
        return 'ordered'.tr(context);
      case ActionStatus.recieved:
        return 'recieved'.tr(context);
      case ActionStatus.used:
        return 'used'.tr(context);
      case ActionStatus.writtenOff:
        return 'written off'.tr(context);
      case ActionStatus.sent:
        return 'sent'.tr(context);
      case ActionStatus.confirmed:
        return 'confirmed'.tr(context);
      case ActionStatus.canceled:
        return 'canceled'.tr(context);
      default:
        return 'ordered'.tr(context);
    }
  }
}
