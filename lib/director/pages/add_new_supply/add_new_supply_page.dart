import 'package:diploma_frontend/blocs/supplier/supplier_cubit.dart';
import 'package:diploma_frontend/director/pages/add_new_contract/widgets/suppliers_dropdown.dart';
import 'package:diploma_frontend/manager/pages/ordered_batch_page/widgets/date_picker_textfield.dart';
import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/models/supplier.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

List<Application> chosenApplications = [];

class AddNewSupplyPage extends StatefulWidget {
  const AddNewSupplyPage({super.key});

  @override
  State<AddNewSupplyPage> createState() => _AddNewSupplyPageState();
}

class _AddNewSupplyPageState extends State<AddNewSupplyPage> {
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: constants.Colors.managerWarehouseMain.withOpacity(0.6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Routemaster.of(context).history.back(),
              child: Text(
                '${(chosenApplications == [] ? "Suppliers" : "Applications").tr(context)} > ${'Adding a new supply'.tr(context)}',
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Supplier'.tr(context),
                    ),
                    suppliers(context),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Start date'.tr(context),
                    ),
                    DatePickerTextField(
                      controller: startDate,
                      onDateTimeChanged: (_) {},
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'End date'.tr(context),
                    ),
                    DatePickerTextField(
                      controller: endDate,
                      onDateTimeChanged: (_) {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget suppliers(BuildContext context) {
    return BlocBuilder<SupplierCubit, SupplierState>(
      builder: (context, state) {
        if (state is SupplierInitial) {
          final SupplierCubit cubit = BlocProvider.of(context);
          cubit.fetchSuppliers('');
        }

        if (state is SupplierError) {
          return Center(
            child: Text(state.error),
          );
        }

        if (state is SupplierLoading) {
          return SuppliersDropdown(
            onChange: (_) {},
            products: [
              Supplier.empty(),
              Supplier.empty(),
            ],
          );
        }

        if (state is SupplierLoaded) {
          return SuppliersDropdown(
            onChange: (_) {},
            products: state.suppliers,
          );
        }

        return Container();
      },
    );
  }
}
