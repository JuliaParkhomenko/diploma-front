import 'package:diploma_frontend/models/warehouse.dart';
import 'package:diploma_frontend/users/manager/pages/manager_page/widgets/manager_header.dart';
import 'package:diploma_frontend/users/manager/pages/manager_page/widgets/navbar.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

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
        SizedBox(
          height: size.height,
          width: size.width - 140,
          child: Column(
            children: [
              ManagerHeader(
                selectedIndex: indexedPage.index,
                warehouses: widget.list,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: SizedBox(
                  height: size.height - 70,
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
}
