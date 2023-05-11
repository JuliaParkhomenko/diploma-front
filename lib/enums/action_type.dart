import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

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
  String getActionType(BuildContext context) {
    switch (this) {
      case ActionType.batch:
        return 'batch'.tr(context);
      case ActionType.application:
        return 'application'.tr(context);
      default:
        return 'batch'.tr(context);
    }
  }
}
