import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

enum Urgency {
  urgently,
  notUrgent,
}

extension UrgencyConverter on String {
  Urgency getUrgency() {
    switch (this) {
      case 'urgently':
        return Urgency.urgently;
      case 'not urgent':
        return Urgency.notUrgent;
      case 'notUrgent':
        return Urgency.notUrgent;
      default:
        return Urgency.urgently;
    }
  }
}

extension UrgencyToString on Urgency {
  String getUrgency(BuildContext context) {
    switch (this) {
      case Urgency.urgently:
        return 'urgently'.tr(context);
      case Urgency.notUrgent:
        return 'not urgent'.tr(context);
      default:
        return 'urgently'.tr(context);
    }
  }
}
