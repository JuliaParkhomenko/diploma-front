import 'package:diploma_frontend/blocs/batch_supply/batch_supply_cubit.dart';
import 'package:diploma_frontend/blocs/opt_contract/opt_contract_cubit.dart';
import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/models/opt_contract_model.dart';
import 'package:diploma_frontend/models/opt_model.dart';
import 'package:diploma_frontend/models/optimization.dart';
import 'package:diploma_frontend/models/requests/opt_request.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:diploma_frontend/users/director/pages/add_new_supply_page/helper/opt_helper.dart';
import 'package:diploma_frontend/users/director/pages/add_new_supply_page/widgets/add_opt_dialog.dart';
import 'package:diploma_frontend/users/director/pages/add_new_supply_page/widgets/edit_opt_dialog.dart';
import 'package:diploma_frontend/users/manager/pages/widgets/info_overlay.dart';
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
        'Amount',
        'Total cost',
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
                    onTap: () async {
                      await showAddDialog();
                    },
                  ),
                  const SizedBox(width: 15),
                  DefaultAddButton(
                    isActive: selectedOpt.isNotEmpty,
                    buttonText: 'Optimize',
                    onTap: () async {
                      final List<Optimization>? opt = await ServiceLocator
                          .statisticsRepository
                          .optimization(
                        opt: List.generate(
                          selectedOpt.length,
                          (index) {
                            return OptRequest(
                              applicationId: selectedOpt[index].application.id,
                              warehouseId:
                                  selectedOpt[index].application.warehouseId,
                              productId:
                                  selectedOpt[index].application.productId,
                              supplyConditionsId:
                                  selectedOpt[index].contract?.id ?? -1,
                              amount: selectedOpt[index].application.amount,
                            );
                          },
                        ),
                      );
                      if (opt != null) {
                        setState(() {
                          optimizationHelpers = opt;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 15),
                  DefaultAddButton(
                    isActive: selectedOpt.isNotEmpty,
                    buttonText: 'Order',
                    onTap: () async {
                      await ServiceLocator.batchRepository
                          .addBatch(
                            requests: fromOptModel(selectedOpt),
                          )
                          .then((value) => showInfoPrikol(
                                'Batches were successfully ordered',
                                context,
                              ));
                      final BatchSupplyCubit cubit = BlocProvider.of(context);
                      await cubit.featchSupplies();
                      Routemaster.of(context).push('/supplies');
                    },
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
                subItems: selectedOpt[index].contract == null
                    ? null
                    : [
                        selectedOpt[index].contract!.kind,
                        selectedOpt[index].contract!.maker,
                        selectedOpt[index].contract!.pricePerUnit.toString(),
                        selectedOpt[index].contract!.minAmount.toString(),
                        selectedOpt[index].contract!.maxAmount.toString(),
                      ],
                header: selectedOpt[index].contract == null
                    ? null
                    : DefaultTableHeader(
                        color: constants.Colors.label.withOpacity(.2),
                        headers: const [
                          'Kind',
                          'Maker',
                          'Price',
                          'Min amount',
                          'Max amount',
                        ],
                      ),
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
                  selectedOpt[index].application.amount.toString(),
                  (selectedOpt[index].application.amount *
                          (selectedOpt[index].price ?? 0))
                      .toString(),
                ],
              ),
            ),
          ),
          if (optimizationHelpers.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 32),
              child: Text(
                'Recommended optimization',
                style: TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          if (optimizationHelpers.isNotEmpty)
            DefaultCustomTable(
              header: const DefaultTableHeader(
                headers: [
                  'Warehouse',
                  'Product',
                  'Price',
                  'Amount',
                  'Min amount',
                  'Max amount',
                  'Total cost'
                ],
              ),
              items: List.generate(
                optimizationHelpers.length,
                (index) => DefaultTableItem(
                  onTap: () {},
                  items: [
                    optimizationHelpers[index].warehouseName,
                    optimizationHelpers[index].productName,
                    optimizationHelpers[index].price.toString(),
                    optimizationHelpers[index].amount.toString(),
                    optimizationHelpers[index].minAmount.toString(),
                    optimizationHelpers[index].maxAmount.toString(),
                    optimizationHelpers[index].cost.toString(),
                  ],
                ),
              ),
            ),
          if (optimizationHelpers.isNotEmpty)
            Align(
              alignment: Alignment.centerRight,
              child: DefaultAddButton(
                buttonText: 'Apply',
                onTap: () {
                  final List<OptModel> result = [];
                  int i = 0;
                  for (; i < selectedOpt.length; i++) {
                    OptModel opt = selectedOpt[i];
                    opt = OptModel.fromOptimization(
                      opt,
                      optimizationHelpers[i],
                    );
                    result.add(opt);
                    i++;
                  }
                  i--;
                  if (optimizationHelpers.length > i) {
                    for (; i < optimizationHelpers.length; i++) {
                      final Optimization optimization = optimizationHelpers[i];
                      result.add(
                        OptModel(
                          price: optimization.price,
                          contract: OptContractModel(
                            id: optimization.conditionId,
                            supplyContractId: -1,
                            productId: optimization.productId ?? -1,
                            kind: optimization.kind,
                            maker: optimization.maker,
                            pricePerUnit: optimization.price,
                            minAmount: optimization.minAmount,
                            maxAmount: optimization.maxAmount,
                          ),
                          application: Application(
                            id: optimization.applicationId ?? -1,
                            stockId: -1,
                            productId: optimization.productId ?? -1,
                            amount: optimization.amount,
                            productName: optimization.productName,
                            productMeasurement: '',
                            kind: '',
                            urgency: '',
                            note: '',
                            status: '',
                            userId: -1,
                            userName: '',
                            warehouseId: optimization.warehouseId,
                            warehouseName: optimization.warehouseName,
                          ),
                        ),
                      );
                    }
                  }

                  setState(() {
                    selectedOpt = result;
                    optimizationHelpers.clear();
                  });
                },
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

  Future<void> showAddDialog() async {
    final OptContractCubit cubit = BlocProvider.of(context);
    cubit.clear();
    await showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return AddOptDialog(
          onChange: (value) {
            setState(() {
              selectedOpt.add(value);
            });
          },
        );
      },
    );
  }
}
