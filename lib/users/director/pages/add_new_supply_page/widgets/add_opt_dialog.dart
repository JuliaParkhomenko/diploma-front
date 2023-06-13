import 'package:diploma_frontend/blocs/opt_contract/opt_contract_cubit.dart';
import 'package:diploma_frontend/blocs/product/product_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/models/application.dart';
import 'package:diploma_frontend/models/opt_contract_model.dart';
import 'package:diploma_frontend/models/opt_model.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/dialog_textfield.dart';
import 'package:diploma_frontend/users/director/pages/add_new_supply_page/widgets/opt_contract_dropdown.dart';
import 'package:diploma_frontend/users/director/pages/add_new_supply_page/widgets/warehouse_dropdown.dart';
import 'package:diploma_frontend/users/manager/pages/application_page/widgets/product_dropdown.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOptDialog extends StatefulWidget {
  final Function(OptModel) onChange;
  const AddOptDialog({
    super.key,
    required this.onChange,
  });

  @override
  State<AddOptDialog> createState() => _AddOptDialogState();
}

class _AddOptDialogState extends State<AddOptDialog> {
  int? productId;
  OptContractModel? optContractModel;
  int amount = 0;
  String productName = '';
  int warehouseId = 0;
  String warehouseName = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: constants.Colors.mainButton,
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        width: size.width * 0.55,
        height: size.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add batch'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Warehouse'.tr(context)),
                        SizedBox(
                          height: 42,
                          width: 200,
                          child: BlocBuilder<WarehouseCubit, WarehouseState>(
                            builder: (context, state) {
                              if (state is WarehouseInitial) {
                                final WarehouseCubit cubit =
                                    BlocProvider.of(context);
                                cubit.fetchWarehouses();
                              }

                              return state is WarehouseLoaded
                                  ? WarehouseDropdown(
                                      onChange: (value) {
                                        warehouseId = value;
                                        warehouseName = state.warehouses
                                            .firstWhere((element) =>
                                                element.id == value)
                                            .name;
                                      },
                                      warehouses: state.warehouses,
                                    )
                                  : Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Product'),
                        SizedBox(
                          height: 42,
                          width: 200,
                          child: BlocBuilder<ProductCubit, ProductState>(
                            builder: (context, state) {
                              if (state is ProductInitial) {
                                final ProductCubit cubit =
                                    BlocProvider.of(context);
                                cubit.fetchProducts();
                              }

                              return state is ProductLoaded
                                  ? ProductDropdown(
                                      onChange: (value) {
                                        setState(() {
                                          productId = value;
                                        });
                                        productName = state.products
                                            .firstWhere((element) =>
                                                element.id == value)
                                            .name;
                                        final OptContractCubit cubit =
                                            BlocProvider.of(context);
                                        cubit.fetchContracts(value);
                                      },
                                      products: state.products,
                                    )
                                  : Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount'.tr(context)),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: '',
                            hintText: 'Amount',
                            onChanged: (value) {
                              amount = int.tryParse(value) ?? 0;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 400,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              if (productId != null)
                Center(
                  child: Text(
                    'Select supply condition'.tr(context),
                    style: const TextStyle(
                      color: constants.Colors.subtitleTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (productId != null)
                BlocBuilder<OptContractCubit, OptContractState>(
                  builder: (context, state) {
                    return state is OptContractLoaded
                        ? SizedBox(
                            height: 42,
                            width: size.width,
                            child: OptContractDropdown(
                              onChange: (value) {
                                optContractModel = value;
                              },
                              categories: state.contracts,
                            ),
                          )
                        : Container();
                  },
                ),
              const SizedBox(height: 80),
              Align(
                alignment: Alignment.centerRight,
                child: DefaultAddButton(
                  buttonText: 'Add',
                  onTap: () async {
                    widget.onChange(
                      OptModel(
                        application: Application(
                          amount: amount,
                          id: -1,
                          status: '',
                          stockId: -1,
                          productId: productId ?? 1,
                          productName: productName,
                          productMeasurement: '',
                          kind: optContractModel?.kind ?? '',
                          note: '',
                          urgency: '',
                          userId: -1,
                          userName: '',
                          warehouseId: warehouseId,
                          warehouseName: warehouseName,
                        ),
                        price: optContractModel?.pricePerUnit ?? 0,
                        contract: optContractModel,
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
