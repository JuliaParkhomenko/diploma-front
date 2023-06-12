import 'package:diploma_frontend/blocs/opt_contract/opt_contract_cubit.dart';
import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/director/pages/add_new_supply_page/helper/opt_helper.dart';
import 'package:diploma_frontend/users/director/pages/add_new_supply_page/widgets/edit_opt_dialog.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:diploma_frontend/widgets/default_table/default_custom_table.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_header.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_item.dart';
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
  final GlobalKey key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    const DefaultTableHeader header = DefaultTableHeader(
      headers: [
        'Warehouse',
        'Product',
        'Price',
        'Amount',
        'Deviation percentage',
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
                  DefaultAddButton(
                    buttonText: 'Add new',
                    onTap: () {},
                  ),
                  const SizedBox(width: 15),
                  DefaultAddButton(
                    isActive: selectedOpt.isNotEmpty,
                    buttonText: 'Optimize',
                    onTap: () {},
                  ),
                  const SizedBox(width: 15),
                  DefaultAddButton(
                    isActive: selectedOpt.isNotEmpty,
                    buttonText: 'Order',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          DefaultCustomTable(
            header: header,
            items: List.generate(
              selectedOpt.length,
              (index) => DefaultTableItem(
                onLongPressed: () {
                  setState(() {
                    selectedOpt.removeAt(index);
                  });
                },
                onTap: () async {
                  await showEditDialog(index);
                },
                items: [
                  selectedOpt[index].application.warehouseName,
                  selectedOpt[index].application.productName,
                  selectedOpt[index].price == null
                      ? ''
                      : selectedOpt[index].price.toString(),
                  selectedOpt[index].application.amount.toString(),
                  '${selectedOpt[index].percentage}%',
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showEditDialog(int index) async {
    final OptContractCubit cubit = BlocProvider.of(context);
    cubit.clear();
    await showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return EditOptDialog(
          onChange: (value) {
            setState(() {
              selectedOpt[index] = value;
            });
          },
          optModel: selectedOpt[index],
        );
      },
    );
  }
}
