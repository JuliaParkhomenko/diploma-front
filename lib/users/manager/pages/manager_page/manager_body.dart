import 'package:diploma_frontend/models/warehouse.dart';
import 'package:diploma_frontend/users/manager/pages/manager_page/widgets/manager_header.dart';
import 'package:diploma_frontend/users/manager/pages/manager_page/widgets/navbar.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class ManagerBody extends StatefulWidget {
  final List<Warehouse> list;
  const ManagerBody({super.key, required this.list});

  @override
  State<ManagerBody> createState() => _ManagerBodyState();
}

class _ManagerBodyState extends State<ManagerBody> {
  @override
  void initState() {
    changeWarehouseId();
    super.initState();
  }

  void changeWarehouseId() {
    if (widget.list.isNotEmpty) {
      ServiceLocator.blocService.changeWarehouseId(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final indexedPage = IndexedPage.of(context);
    final Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //! left-side menu
        NavBar(
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
              ManagerHeader(
                selectedIndex: indexedPage.index,
                warehouses: widget.list,
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
                    color: getColor(indexedPage.index)
                        ? constants.Colors.managerWarehouseMain.withOpacity(0.6)
                        : null,
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
    );
  }

  bool getColor(int index) {
    if (index == 0) {
      return false;
    }

    if (Routemaster.of(context).currentRoute.path.contains('received')) {
      return false;
    }

    return true;
  }
}
