import 'package:diploma_frontend/blocs/manager/manager_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/admin/pages/warehouses_page/widgets/managers_dropdown.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/dialog_textfield.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class AddWarehouseDialog extends StatefulWidget {
  const AddWarehouseDialog({super.key});

  @override
  State<AddWarehouseDialog> createState() => _AddWarehouseDialogState();
}

class _AddWarehouseDialogState extends State<AddWarehouseDialog> {
  String name = '';
  String address = '';
  num maxFreezerAmount = 0;
  num maxFridgeAmount = 0;
  num maxContainerAmount = 0;
  int manager = 0;

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
                'Adding new warehouse'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text('Name'.tr(context))),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: '',
                            hintText: 'Name',
                            onChanged: (value) => name = value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text('Max amount\n(fridge)'.tr(context))),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: '',
                            hintText: 'Max amount',
                            onChanged: (value) =>
                                maxFridgeAmount = num.tryParse(value) ?? 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //
              const SizedBox(height: 50),
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text('Manager'.tr(context))),
                        BlocBuilder<ManagerCubit, ManagerState>(
                          builder: (context, state) {
                            if (state is ManagerInitial) {
                              final ManagerCubit cubit =
                                  BlocProvider.of(context);
                              cubit.fetchManagers();
                            }

                            if (state is ManagerLoaded) {
                              return SizedBox(
                                width: 200,
                                height: 42,
                                child: ManagersDropdown(
                                  onChange: (value) => manager = value.id,
                                  managers: state.managers,
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text('Max amount\n(freezer)'.tr(context))),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: '',
                            hintText: 'Max amount',
                            onChanged: (value) =>
                                maxFreezerAmount = num.tryParse(value) ?? 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //
              const SizedBox(height: 50),
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text('Address'.tr(context))),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: '',
                            hintText: 'Address',
                            onChanged: (value) => address = value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Max amount\n(container)'.tr(context),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: '',
                            hintText: 'Max amount',
                            onChanged: (value) =>
                                maxContainerAmount = num.tryParse(value) ?? 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Align(
                alignment: Alignment.centerRight,
                child: DefaultAddButton(
                  buttonText: 'Add new',
                  onTap: () async {
                    final WarehouseCubit cubit = BlocProvider.of(context);
                    await cubit
                        .addWarehouse(
                          name: name,
                          manager: manager,
                          address: address,
                          maxCamount: maxContainerAmount,
                          maxFamount: maxFreezerAmount,
                          maxFridgeAmount: maxFridgeAmount,
                        )
                        .then((value) => Navigator.pop(context));
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
