import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/users/director/pages/director_page/widgets/director_header.dart';
import 'package:diploma_frontend/users/director/pages/director_page/widgets/navbar.dart';
import 'package:diploma_frontend/users/manager/pages/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class DirectorPage extends StatelessWidget {
  const DirectorPage({super.key});

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
                BlocBuilder<WarehouseCubit, WarehouseState>(
                  builder: (context, state) {
                    if (state is WarehouseInitial) {
                      final WarehouseCubit cubit =
                          BlocProvider.of<WarehouseCubit>(context);
                      cubit.fetchWarehouses();
                    }
                    if (state is WarehouseLoading) {
                      return const LoadingWidget();
                    }
                    if (state is WarehouseError) {
                      const Center(
                        child: Text('Error on server :('),
                      );
                    }
                    if (state is WarehouseLoading) {
                      return DirectorHeader(
                        selectedIndex: indexedPage.index,
                        warehouses: const [],
                      );
                    }
                    if (state is WarehouseLoaded) {
                      return DirectorHeader(
                        selectedIndex: indexedPage.index,
                        warehouses: state.warehouses,
                      );
                    }
                    return Container();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 20,
                    bottom: 10,
                  ),
                  child: showContainer(context)
                      ? Container(
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
                        )
                      : SizedBox(
                          height: size.height - 105,
                          width: size.width,
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

  bool showContainer(BuildContext context) {
    if (Routemaster.of(context).currentRoute.fullPath.contains('overview')) {
      return false;
    } else {
      return true;
    }
  }
}
