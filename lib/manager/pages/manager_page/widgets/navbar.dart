import 'package:diploma_frontend/manager/pages/manager_page/widgets/destination_widget.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:routemaster/routemaster.dart';

class NavBar extends StatefulWidget {
  final Function(int) onIndexChanged;

  const NavBar({
    super.key,
    required this.onIndexChanged,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int warehouseId = 0;

  @override
  Widget build(BuildContext context) {
    final indexedPage = IndexedPage.of(context);
    final Size size = MediaQuery.of(context).size;
    final List<String> pageNames =
        constants.ManagerPagesList.generatePageNames(context);

    return Container(
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
            text: pageNames[0],
            icon: Icons.home,
            pageIndex: 0,
            onIndexChanged: widget.onIndexChanged,
            selectedIndex: indexedPage.index,
            padding: 70,
          ),
          DestinationWidget(
            text: pageNames[1],
            icon: Icons.warehouse,
            pageIndex: 1,
            onIndexChanged: widget.onIndexChanged,
            selectedIndex: indexedPage.index,
            padding: 15,
          ),
          DestinationWidget(
            text: pageNames[2],
            icon: Icons.archive_outlined,
            pageIndex: 2,
            onIndexChanged: widget.onIndexChanged,
            selectedIndex: indexedPage.index,
            padding: 15,
          ),
          DestinationWidget(
            text: pageNames[3],
            icon: Icons.notification_important_outlined,
            pageIndex: 3,
            onIndexChanged: widget.onIndexChanged,
            selectedIndex: indexedPage.index,
            padding: 15,
          ),
          DestinationWidget(
            text: pageNames[4],
            icon: Icons.bar_chart_rounded,
            pageIndex: 4,
            onIndexChanged: widget.onIndexChanged,
            selectedIndex: indexedPage.index,
            padding: 15,
          ),
          DestinationWidget(
            text: pageNames[5],
            icon: Icons.article_outlined,
            pageIndex: 5,
            onIndexChanged: widget.onIndexChanged,
            selectedIndex: indexedPage.index,
            padding: 15,
          ),
          const Expanded(
            child: SizedBox(),
          ),
          DestinationWidget(
            text: 'Log out'.tr(context),
            icon: Icons.logout,
            pageIndex: -1,
            onIndexChanged: widget.onIndexChanged,
            selectedIndex: indexedPage.index,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
