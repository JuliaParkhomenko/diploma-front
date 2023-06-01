import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

mixin DirectorPagesList {
  static List<String> generatePageNames(BuildContext context) => [
        'Overview'.tr(context),
        'Suppliers'.tr(context),
        'Contracts'.tr(context),
        'Supplies'.tr(context),
        'Applications'.tr(context),
        'Statistics'.tr(context),
      ];
}
