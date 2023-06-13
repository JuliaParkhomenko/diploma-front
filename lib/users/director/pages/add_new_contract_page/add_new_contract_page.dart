// ignore_for_file: use_build_context_synchronously

import 'package:diploma_frontend/blocs/supplier/supplier_cubit.dart';
import 'package:diploma_frontend/blocs/supply_contracts/supply_contracts_cubit.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/date_picker_textfield.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/edit_conditions_dialog.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/max_amount_textfield.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/min_amount_textfield.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/suppliers_dropdown.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/supply_conditions_table.dart';
import 'package:diploma_frontend/models/supplier.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/manager/pages/widgets/info_overlay.dart';
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
  bool update = false;

  int minAmount = 0;
  int maxAmount = 0;

  late final TextEditingController startDate = TextEditingController(
    text: DateTime.now().toIso8601String().substring(0, 10),
  );
  final TextEditingController endDate = TextEditingController(
    text: DateTime.now()
        .add(const Duration(days: 1))
        .toIso8601String()
        .substring(0, 10),
  );

  int supplierId = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    onDateTimeChanged: (_) {
                      startDate.text = _.toIso8601String().substring(0, 10);
                    },
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
                    onDateTimeChanged: (_) {
                      endDate.text = _.toIso8601String().substring(0, 10);
                    },
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
                      onChanged: (_) {
                        minAmount = _;
                      },
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
                      onChanged: (_) {
                        maxAmount = _;
                      },
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
          const Expanded(
            child: SizedBox(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  await showAddDialog();
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    Colors.green.withOpacity(0.7),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(constants.Colors.main),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(),
                    ),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 160,
                  child: Text(
                    'Add conditions'.tr(context),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (supplyConditions.isEmpty) {
                    return showInfoPrikol(
                      'There is no supplyConditions in contract!'.tr(context),
                      context,
                      prikolColor: Colors.red,
                    );
                  }
                  await ServiceLocator.supplierRepository.addcontract(
                    supplierId: supplierId,
                    startDate:
                        DateTime.tryParse(startDate.text) ?? DateTime.now(),
                    endDate: DateTime.tryParse(endDate.text) ??
                        DateTime.now().add(
                          const Duration(days: 1),
                        ),
                    minAmount: minAmount,
                    maxAmount: maxAmount,
                    addSupplyConditions: supplyConditions,
                    context: context,
                  );
                  supplyConditions.clear();
                  final SupplyContractsCubit cubit = BlocProvider.of(context);
                  await cubit.featchContracts(old: false);
                  await Routemaster.of(context).pop();
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    Colors.green.withOpacity(0.7),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      supplyConditions.isEmpty
                          ? const Color.fromARGB(255, 100, 100, 100)
                          : constants.Colors.main),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(),
                    ),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 160,
                  child: Text(
                    'Add contract'.tr(context),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> showAddDialog() async {
    await showDialog(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: EditConditionDialog(
            product: '',
            kind: '',
            maker: '',
            minBatch: 0,
            maxBatch: 0,
            pricePerUnit: 0,
            dialogName: 'Adding contract condition',
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
            onChange: (_) {
              supplierId = _;
            },
            suppliers: state.suppliers,
          );
        }

        return Container();
      },
    );
  }
}
