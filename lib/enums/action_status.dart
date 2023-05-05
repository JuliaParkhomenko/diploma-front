import 'package:easy_localization/easy_localization.dart';

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
  String getActionStatus() {
    switch (this) {
      case ActionStatus.ordered:
        return 'ordered'.tr();
      case ActionStatus.recieved:
        return 'recieved'.tr();
      case ActionStatus.used:
        return 'used'.tr();
      case ActionStatus.writtenOff:
        return 'written off'.tr();
      case ActionStatus.sent:
        return 'sent'.tr();
      case ActionStatus.confirmed:
        return 'confirmed'.tr();
      case ActionStatus.canceled:
        return 'canceled'.tr();
      default:
        return 'ordered'.tr();
    }
  }
}
