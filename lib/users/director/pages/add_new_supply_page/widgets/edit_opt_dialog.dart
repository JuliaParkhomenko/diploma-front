import 'package:diploma_frontend/blocs/opt_contract/opt_contract_cubit.dart';
import 'package:diploma_frontend/models/opt_model.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/dialog_textfield.dart';
import 'package:diploma_frontend/users/director/pages/add_new_supply_page/widgets/opt_contract_dropdown.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class EditOptDialog extends StatefulWidget {
  final OptModel optModel;
  final Function(OptModel) onChange;
  const EditOptDialog({
    super.key,
    required this.onChange,
    required this.optModel,
  });

  @override
  State<EditOptDialog> createState() => _EditOptDialogState();
}

class _EditOptDialogState extends State<EditOptDialog> {
  late OptModel optModel = widget.optModel;

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
                'Editing batch'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              const SizedBox(height: 40),

              // SizedBox(
              //   width: 350,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Flexible(child: Text('Price'.tr(context))),
              //       SizedBox(
              //         width: 200,
              //         height: 42,
              //         child: DialogTextfield(
              //           initialValue: optModel.price == null
              //               ? ''
              //               : optModel.price.toString(),
              //           hintText: 'Price',
              //           onChanged: (value) =>
              //               optModel.price = num.tryParse(value),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //
              //
              SizedBox(
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Deviation Percentage'.tr(context)),
                    SizedBox(
                      width: 200,
                      height: 42,
                      child: DialogTextfield(
                        initialValue: optModel.percentage.toString(),
                        hintText: 'Deviation Percentage',
                        onChanged: (value) =>
                            optModel.percentage = num.tryParse(value) ?? 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              BlocBuilder<OptContractCubit, OptContractState>(
                builder: (context, state) {
                  if (state is OptContractInitial) {
                    final OptContractCubit cubit = BlocProvider.of(context);
                    cubit.fetchContracts(widget.optModel.application.productId);
                  }

                  return state is OptContractLoaded
                      ? SizedBox(
                          height: 42,
                          width: size.width,
                          child: OptContractDropdown(
                            onChange: (value) {
                              setState(() {
                                optModel.price = value.pricePerUnit;
                              });
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
                  buttonText: 'Edit',
                  onTap: () async {
                    widget.onChange(optModel);
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
