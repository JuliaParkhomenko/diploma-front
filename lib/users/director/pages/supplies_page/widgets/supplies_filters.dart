import 'package:diploma_frontend/blocs/batch_supply/batch_supply_cubit.dart';
import 'package:diploma_frontend/users/manager/pages/stocks_page/widgets/search_textfield.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class SuppliesFilters extends StatefulWidget {
  const SuppliesFilters({
    super.key,
  });

  @override
  State<SuppliesFilters> createState() => _SuppliesFiltersState();
}

class _SuppliesFiltersState extends State<SuppliesFilters> {
  final TextEditingController productController = TextEditingController();
  final TextEditingController warehouseController = TextEditingController();
  String product = '';
  String warehouse = '';

  @override
  Widget build(BuildContext context) {
    final BatchSupplyCubit cubit = BlocProvider.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 32),
      child: Row(
        children: [
          SizedBox(
            height: 32,
            width: 200,
            child: SearchTextfield(
              hintText: 'Search by product'.tr(context),
              onChanged: (value) {
                product = value;
                cubit.featchSupplies(
                  productName: product,
                  warehouseName: warehouse,
                );
              },
            ),
          ),
          const SizedBox(width: 30),
          SizedBox(
            height: 32,
            width: 200,
            child: SearchTextfield(
              hintText: 'Search by warehouse'.tr(context),
              onChanged: (value) {
                warehouse = value;
                cubit.featchSupplies(
                  productName: product,
                  warehouseName: warehouse,
                );
              },
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          DefaultAddButton(
            buttonText: 'Add new',
            onTap: () {
              Routemaster.of(context).push('/supplies/add');
            },
          ),
        ],
      ),
    );
  }
}
