import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

mixin ManagerPagesList {
  static List<String> generatePageNames(BuildContext context) => [
        'Overview'.tr(context),
        'Stocks'.tr(context),
        'Batches'.tr(context),
        'Reminders'.tr(context),
        'Statistics'.tr(context),
        'Application'.tr(context),
      ];
}
