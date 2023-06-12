import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/admin/pages/warehouses_page/widgets/add_warehouse_dialog.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:diploma_frontend/widgets/default_table/default_custom_table.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_header.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_item.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class WarehousesPage extends StatelessWidget {
  const WarehousesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const DefaultTableHeader header = DefaultTableHeader(
      headers: [
        'Id',
        'Name',
        'Address',
        'Manager',
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Warehouses'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              DefaultAddButton(
                buttonText: 'Add warehouse',
                onTap: () async => _openAddDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 30),
          BlocBuilder<WarehouseCubit, WarehouseState>(
            builder: (context, state) {
              if (state is WarehouseInitial) {
                final WarehouseCubit cubit = BlocProvider.of(context);
                cubit.fetchWarehousesForAdmin();
              }

              return state is WarehouseLoaded
                  ? DefaultCustomTable(
                      header: header,
                      items: List<DefaultTableItem>.generate(
                        state.warehouses.length,
                        (index) => DefaultTableItem(
                          onTap: () {},
                          items: [
                            state.warehouses[index].id.toString(),
                            state.warehouses[index].name,
                            state.warehouses[index].address,
                            state.warehouses[index].manager.toString(),
                          ],
                        ),
                      ),
                    )
                  : header;
            },
          ),
        ],
      ),
    );
  }

  Future<void> _openAddDialog(BuildContext context) async {
    await showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return const AddWarehouseDialog();
      },
    );
  }
}
