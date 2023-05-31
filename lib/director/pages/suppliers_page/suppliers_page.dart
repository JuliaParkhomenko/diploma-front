import 'package:diploma_frontend/blocs/supplier/supplier_cubit.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:diploma_frontend/director/pages/suppliers_page/widgets/suppliers_table.dart';
import 'package:diploma_frontend/manager/pages/stocks_page/widgets/search_textfield.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuppliersPage extends StatefulWidget {
  const SuppliersPage({super.key});

  @override
  State<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends State<SuppliersPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<SupplierCubit, SupplierState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Container(
          width: size.width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: constants.Colors.managerWarehouseMain.withOpacity(0.6),
          ),
          child: Padding(
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
                    controller: searchController,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.65,
                  width: size.width * 0.72,
                  child: const SuppliersTable(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
