import 'package:diploma_frontend/blocs/supplier/supplier_cubit.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:diploma_frontend/models/supplier.dart';
import 'package:diploma_frontend/users/director/pages/suppliers_page/widgets/edit_supplier_dialog.dart';
import 'package:diploma_frontend/users/director/pages/suppliers_page/widgets/suppliers_table.dart';
import 'package:diploma_frontend/users/manager/pages/stocks_page/widgets/search_textfield.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/utils/open_default_dialog.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_header.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuppliersPage extends StatelessWidget {
  const SuppliersPage({super.key});

  static const DefaultTableHeader _header = DefaultTableHeader(
    headers: [
      'Name',
      'Address',
      'Email',
      'Phone number',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suppliers'.tr(context),
            style: const TextStyle(
              color: constants.Colors.subtitleTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 200,
            height: 32,
            child: SearchTextfield(
              hintText: 'Search by name or address'.tr(context),
              onChanged: (value) async {
                final SupplierCubit cubit =
                    BlocProvider.of<SupplierCubit>(context);
                await cubit.fetchSuppliers(value);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<SupplierCubit, SupplierState>(
            builder: (context, state) {
              final SupplierCubit cubit =
                  BlocProvider.of<SupplierCubit>(context);
              if (state is SupplierInitial) {
                cubit.fetchSuppliers('');
              }

              return state is SupplierLoaded
                  ? SuppliersTable(
                      items: List.generate(
                        state.suppliers.length,
                        (index) {
                          final Supplier item = state.suppliers[index];
                          return DefaultTableItem(
                            onTap: () async {
                              await openDefaultDialog(
                                EditSupplierDialog(
                                  supplierId: item.id,
                                  name: item.name,
                                  address: item.address,
                                  email: item.email,
                                  phoneNumber: item.phoneNum,
                                ),
                                context,
                              );
                            },
                            items: [
                              item.name,
                              item.address,
                              item.email,
                              item.phoneNum,
                            ],
                          );
                        },
                      ),
                      header: _header,
                    )
                  : _header;
            },
          ),
        ],
      ),
    );
  }
}
