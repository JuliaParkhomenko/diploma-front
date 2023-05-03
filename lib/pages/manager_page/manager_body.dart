import 'package:diploma_frontend/models/warehouse.dart';
import 'package:diploma_frontend/pages/application_page/application_page.dart';
import 'package:diploma_frontend/pages/batches_page/batches_page.dart';
import 'package:diploma_frontend/pages/overview_page/overview_page.dart';
import 'package:diploma_frontend/pages/reminders_page/reminders_page.dart';
import 'package:diploma_frontend/pages/statistics_page/statistics_page.dart';
import 'package:diploma_frontend/pages/warehouse_page/warehouse_page.dart';
import 'package:diploma_frontend/pages/widgets/warehouse_selector.dart';
import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/bloc_cleaner.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:diploma_frontend/services/language_service/language_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_svg/flutter_svg.dart';

class ManagerBody extends StatefulWidget {
  final List<Warehouse> list;
  const ManagerBody({super.key, required this.list});

  @override
  State<ManagerBody> createState() => _ManagerBodyState();
}

class _ManagerBodyState extends State<ManagerBody> {
  @override
  void initState() {
    if (widget.list.isNotEmpty) {
      setState(() {
        warehouseId = widget.list.first.id;
      });
      BlocCleaner().changeWarehouseId(context);
    }
    super.initState();
  }

  int selectedIndex = 1;
  int warehouseId = 0;
  Widget pages(int index, BuildContext context) {
    final List<Widget> result = [
      const OverviewPage(),
      WarehousePage(
        update: context.locale == LanguageService.fallbackLocale,
        warehouseId: warehouseId,
      ),
      const BatchesPage(),
      const RemindersPage(),
      const StatisticsPage(),
      const ApplicationPage(),
    ];

    return result[index];
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<String> pageNames = [
      'Overview'.tr(),
      'Warehouse'.tr(),
      'Batches'.tr(),
      'Reminders'.tr(),
      'Statistics'.tr(),
      'Application'.tr(),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: size.height,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: constants.Colors.main.withOpacity(0.85),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Image.asset(
                'assets/images/pngwing.com.png',
                height: 70,
                width: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 70,
                ),
                child: getDestination(
                  'Overview'.tr(),
                  const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 30,
                  ),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: getDestination(
                  'Warehouse'.tr(),
                  const Icon(
                    Icons.warehouse,
                    color: Colors.white,
                    size: 30,
                  ),
                  1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: getDestination(
                  'Batches'.tr(),
                  const Icon(
                    Icons.archive_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: getDestination(
                  'Reminders'.tr(),
                  const Icon(
                    Icons.notification_important_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: getDestination(
                  'Statistics'.tr(),
                  const Icon(
                    Icons.bar_chart_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: getDestination(
                  'Application'.tr(),
                  const Icon(
                    Icons.article_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  5,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: getDestination(
                  'Log out'.tr(),
                  const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  ),
                  -1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height,
          width: size.width - 140,
          child: Column(
            children: [
              SizedBox(
                height: 70,
                width: size.width - 140,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        pageNames[selectedIndex],
                        style: const TextStyle(
                          color: constants.Colors.main,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(
                        height: 1,
                      ),
                    ),
                    WarehouseSelector(
                      onChange: (_) {
                        setState(() {
                          warehouseId = _;
                        });
                        BlocCleaner().changeWarehouseId(context);
                      },
                      warehouses: widget.list,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          context.setLocale(
                            context.locale ==
                                    LanguageService.supportedLocales[0]
                                ? LanguageService.supportedLocales[1]
                                : LanguageService.supportedLocales[0],
                          );
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: SizedBox(
                          height: 20,
                          width: 30,
                          child: context.locale ==
                                  LanguageService.supportedLocales[0]
                              ? SvgPicture.asset(
                                  'assets/images/ukraine-flag-icon.svg',
                                  fit: BoxFit.fill,
                                )
                              : SvgPicture.asset(
                                  'assets/images/england-flag-icon.svg',
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: constants.Colors.notificationShape,
                      ),
                      child: const Icon(
                        Icons.notifications_none_outlined,
                        size: 28,
                        color: Color.fromARGB(200, 62, 62, 62),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(200, 62, 62, 62),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 34,
                        color: constants.Colors.mainButtonBorder,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: SizedBox(
                  height: size.height - 70,
                  child: pages(selectedIndex, context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getDestination(String text, Icon icon, int index) {
    return InkWell(
      onTap: () async {
        if (index == -1) {
          final Database db = Database();
          await db.clear();
          // ignore: use_build_context_synchronously
          await Provider.of<AppStateService>(context, listen: false).logIn();
        }
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: 50,
        decoration: selectedIndex == index
            ? BoxDecoration(
                color: Colors.white.withOpacity(.2),
                borderRadius: BorderRadius.circular(17),
              )
            : null,
        width: 140,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: icon,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: index == selectedIndex ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
