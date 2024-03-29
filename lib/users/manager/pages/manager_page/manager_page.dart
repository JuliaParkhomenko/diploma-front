import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/users/manager/pages/manager_page/manager_body.dart';
import 'package:diploma_frontend/users/manager/pages/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerPage extends StatelessWidget {
  const ManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.Colors.main,
      body: BlocBuilder<WarehouseCubit, WarehouseState>(
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
            return Center(
              child: Text(state.error),
            );
          }
          if (state is WarehouseLoaded) {
            return ManagerBody(list: state.warehouses);
          }
          return Container();
        },
      ),
    );
  }
}
