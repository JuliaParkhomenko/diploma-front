import 'package:easy_localization/easy_localization.dart';

enum ActionType {
  batch,
  application,
}

extension ActionTypeConverter on String {
  ActionType getActionType() {
    switch (this) {
      case 'batch':
        return ActionType.batch;
      case 'application':
        return ActionType.application;
      default:
        return ActionType.batch;
    }
  }
}

extension ActionTypeToString on ActionType {
  String getActionType() {
    switch (this) {
      case ActionType.batch:
        return 'batch'.tr();
      case ActionType.application:
        return 'application'.tr();
      default:
        return 'batch'.tr();
    }
  }
}
