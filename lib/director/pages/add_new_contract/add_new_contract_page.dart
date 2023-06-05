import 'package:diploma_frontend/blocs/supplier/supplier_cubit.dart';
import 'package:diploma_frontend/director/pages/add_new_contract/widgets/date_picker_textfield.dart';
import 'package:diploma_frontend/director/pages/add_new_contract/widgets/edit_conditions_dialog.dart';
import 'package:diploma_frontend/director/pages/add_new_contract/widgets/max_amount_textfield.dart';
import 'package:diploma_frontend/director/pages/add_new_contract/widgets/min_amount_textfield.dart';
import 'package:diploma_frontend/director/pages/add_new_contract/widgets/suppliers_dropdown.dart';
import 'package:diploma_frontend/director/pages/add_new_contract/widgets/supply_conditions_table.dart';
import 'package:diploma_frontend/models/supplier.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class AddNewContractPage extends StatefulWidget {
  const AddNewContractPage({super.key});

  @override
  State<AddNewContractPage> createState() => _AddNewContractPageState();
}

class _AddNewContractPageState extends State<AddNewContractPage> {
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController minamountController = TextEditingController();
  final TextEditingController maxamountController = TextEditingController();

  bool update = false;

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
                '${'Active contracts'.tr(context)} > ${'Adding a new contract'.tr(context)}',
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Supplier'.tr(context),
                      style: const TextStyle(
                        color: constants.Colors.subtitleTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    suppliers(context),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start date'.tr(context),
                      style: const TextStyle(
                        color: constants.Colors.subtitleTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    DatePickerTextField(
                      controller: startDate,
                      onDateTimeChanged: (_) {},
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'End date'.tr(context),
                      style: const TextStyle(
                        color: constants.Colors.subtitleTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    DatePickerTextField(
                      controller: endDate,
                      onDateTimeChanged: (_) {},
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Min amount'.tr(context),
                      style: const TextStyle(
                        color: constants.Colors.subtitleTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 42,
                      child: MinAmountTextfield(
                        hintText: 'Amount'.tr(context),
                        controller: minamountController,
                        onChanged: (_) {},
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Max amount'.tr(context),
                      style: const TextStyle(
                        color: constants.Colors.subtitleTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 42,
                      child: MaxAmountTextfield(
                        hintText: 'Amount'.tr(context),
                        controller: maxamountController,
                        onChanged: (_) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Supply conditions'.tr(context),
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
            SupplyConditionsTable(
              update: update,
            ),
            InkWell(
              onTap: () async {
                await showDialog(
                  useRootNavigator: true,
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: EditConditionDialog(
                        product: '',
                        kind: '',
                        maker: '',
                        minBatch: 0,
                        maxBatch: 0,
                        pricePerUnit: 0,
                        dialogName: 'Adding supply condition',
                        onChange: (editedSupplyCondition) {
                          supplyConditions.add(editedSupplyCondition);
                          setState(() {
                            update = true;
                          });
                        },
                      ),
                    );
                  },
                );
              },
              child: const Text('Add new'),
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
            suppliers: [
              Supplier.empty(),
              Supplier.empty(),
            ],
          );
        }

        if (state is SupplierLoaded) {
          return SuppliersDropdown(
            onChange: (_) {},
            suppliers: state.suppliers,
          );
        }

        return Container();
      },
    );
  }
}
