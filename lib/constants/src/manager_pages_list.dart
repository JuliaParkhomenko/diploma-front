import 'package:easy_localization/easy_localization.dart';

mixin ManagerPagesList {
  static List<String> get generatePageNames => [
        'Overview'.tr(),
        'Stocks'.tr(),
        'Batches'.tr(),
        'Reminders'.tr(),
        'Statistics'.tr(),
        'Application'.tr(),
      ];
}
