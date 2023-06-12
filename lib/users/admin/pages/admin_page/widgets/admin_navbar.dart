import 'package:diploma_frontend/users/director/pages/director_page/widgets/destination_widget.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:routemaster/routemaster.dart';

class AdminNavBar extends StatefulWidget {
  final Function(int) onIndexChanged;

  const AdminNavBar({
    super.key,
    required this.onIndexChanged,
  });

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
  //int warehouseId = 0;

  @override
  Widget build(BuildContext context) {
    final indexedPage = IndexedPage.of(context);
    final Size size = MediaQuery.of(context).size;
    final List<String> pageNames =
        constants.AdminPagesList.generatePageNames(context);

    return Container(
      height: size.height,
      width: 170,
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
            icon: Icons.perm_contact_cal_outlined,
            pageIndex: 1,
            onIndexChanged: widget.onIndexChanged,
            selectedIndex: indexedPage.index,
            padding: 15,
          ),
          DestinationWidget(
            text: pageNames[2],
            icon: Icons.file_copy_outlined,
            pageIndex: 2,
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
