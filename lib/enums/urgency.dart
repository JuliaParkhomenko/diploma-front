import 'package:easy_localization/easy_localization.dart';

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
      default:
        return Urgency.urgently;
    }
  }
}

extension UrgencyToString on Urgency {
  String getUrgency() {
    switch (this) {
      case Urgency.urgently:
        return 'urgently'.tr();
      case Urgency.notUrgent:
        return 'not urgent'.tr();
      default:
        return 'urgently'.tr();
    }
  }
}
