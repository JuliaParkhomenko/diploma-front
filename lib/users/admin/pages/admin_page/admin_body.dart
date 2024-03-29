import 'package:diploma_frontend/users/admin/pages/admin_page/widgets/admin_header.dart';
import 'package:diploma_frontend/users/admin/pages/admin_page/widgets/admin_navbar.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class AdminBody extends StatelessWidget {
  const AdminBody({super.key});

  @override
  Widget build(BuildContext context) {
    final indexedPage = IndexedPage.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: constants.Colors.main,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! left-side menu
          AdminNavBar(
            onIndexChanged: (index) {
              indexedPage.index = index;
            },
          ),
          //! header
          Container(
            margin: const EdgeInsets.only(top: 10, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            height: size.height,
            width: size.width - 185,
            child: Column(
              children: [
                AdminHeader(
                  selectedIndex: indexedPage.index,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 20,
                    bottom: 10,
                  ),
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: constants.Colors.managerWarehouseMain
                          .withOpacity(0.6),
                    ),
                    height: size.height - 105,
                    padding: const EdgeInsets.all(15),
                    child: PageStackNavigator(
                      stack: indexedPage.currentStack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
