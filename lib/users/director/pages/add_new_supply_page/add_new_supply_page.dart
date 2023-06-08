import 'package:diploma_frontend/blocs/supplier/supplier_cubit.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/suppliers_dropdown.dart';
import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/models/supplier.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
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
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
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
          const SizedBox(
            height: 32,
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
              DefaultAddButton(
                buttonText: 'Add new',
                onTap: () async {
                  await showAddDialog();
                },
              ),
            ],
          ),
        ],
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

  Future<void> showAddDialog() async {
    await showDialog(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          /*child: AddSupplyBatchDialog(
            productName: '',
            warehouseName: '',
            price: 0,
            amount: 0,
            deviationPercentage: 0,
            dialogName: 'Adding supply batch',
            onChange: (editedSupplyCondition) {
              supplyConditions.add(editedSupplyCondition);
              setState(() {
                update = true;
              });
            },
          ),*/
        );
      },
    );
  }
}
