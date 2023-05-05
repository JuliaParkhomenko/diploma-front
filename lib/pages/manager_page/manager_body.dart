import 'package:diploma_frontend/models/warehouse.dart';
import 'package:diploma_frontend/pages/manager_page/widgets/destination_page.dart';
import 'package:diploma_frontend/pages/manager_page/widgets/destination_widget.dart';
import 'package:diploma_frontend/pages/manager_page/widgets/manager_header.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class ManagerBody extends StatefulWidget {
  final List<Warehouse> list;
  const ManagerBody({super.key, required this.list});

  @override
  State<ManagerBody> createState() => _ManagerBodyState();
}

class _ManagerBodyState extends State<ManagerBody> {
  //! page index
  int selectedIndex = 5;
  int warehouseId = 0;

  @override
  void initState() {
    changeWarehouseId();
    super.initState();
  }

  void changeWarehouseId() {
    if (widget.list.isNotEmpty) {
      setState(() {
        warehouseId = widget.list.first.id;
      });
      ServiceLocator.blocService.changeWarehouseId(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //! left-side menu
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
              DestinationWidget(
                text: constants.ManagerPagesList.generatePageNames[0],
                icon: Icons.home,
                pageIndex: 0,
                onIndexChanged: onIndexChanged,
                selectedIndex: selectedIndex,
                padding: 70,
              ),
              DestinationWidget(
                text: constants.ManagerPagesList.generatePageNames[1],
                icon: Icons.warehouse,
                pageIndex: 1,
                onIndexChanged: onIndexChanged,
                selectedIndex: selectedIndex,
                padding: 15,
              ),
              DestinationWidget(
                text: constants.ManagerPagesList.generatePageNames[2],
                icon: Icons.archive_outlined,
                pageIndex: 2,
                onIndexChanged: onIndexChanged,
                selectedIndex: selectedIndex,
                padding: 15,
              ),
              DestinationWidget(
                text: constants.ManagerPagesList.generatePageNames[3],
                icon: Icons.notification_important_outlined,
                pageIndex: 3,
                onIndexChanged: onIndexChanged,
                selectedIndex: selectedIndex,
                padding: 15,
              ),
              DestinationWidget(
                text: constants.ManagerPagesList.generatePageNames[4],
                icon: Icons.bar_chart_rounded,
                pageIndex: 4,
                onIndexChanged: onIndexChanged,
                selectedIndex: selectedIndex,
                padding: 15,
              ),
              DestinationWidget(
                text: constants.ManagerPagesList.generatePageNames[5],
                icon: Icons.article_outlined,
                pageIndex: 5,
                onIndexChanged: onIndexChanged,
                selectedIndex: selectedIndex,
                padding: 15,
              ),
              const Expanded(
                child: SizedBox(),
              ),
              DestinationWidget(
                text: 'Log out'.tr(),
                icon: Icons.logout,
                pageIndex: -1,
                onIndexChanged: onIndexChanged,
                selectedIndex: selectedIndex,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
        //! header
        SizedBox(
          height: size.height,
          width: size.width - 140,
          child: Column(
            children: [
              ManagerHeader(
                onLanguageChanged: (_) => changeLanguage(),
                selectedIndex: selectedIndex,
                warehouses: widget.list,
                onWarehouseChanged: onWarehouseChanged,
              ),
              DestinationPage(
                warehouseId: warehouseId,
                index: selectedIndex,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onWarehouseChanged(int id) {
    setState(() {
      warehouseId = id;
    });
    ServiceLocator.blocService.changeWarehouseId(context);
  }

  void onIndexChanged(int index) {
    if (!mounted) {
      return;
    }
    setState(() {
      selectedIndex = index;
    });
  }

  void changeLanguage() {
    setState(() {
      context.setLocale(
        context.locale == ServiceLocator.languageService.supportedLocales[0]
            ? ServiceLocator.languageService.supportedLocales[1]
            : ServiceLocator.languageService.supportedLocales[0],
      );
    });
  }
}
