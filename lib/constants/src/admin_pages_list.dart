import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

mixin AdminPagesList {
  static List<String> generatePageNames(BuildContext context) => [
        'Users'.tr(context),
        'Warehouses'.tr(context),
        'Products'.tr(context),
      ];
}
