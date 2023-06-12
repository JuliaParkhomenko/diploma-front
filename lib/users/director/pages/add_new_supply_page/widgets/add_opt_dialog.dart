import 'package:diploma_frontend/blocs/opt_contract/opt_contract_cubit.dart';
import 'package:diploma_frontend/models/opt_model.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/director/pages/add_new_supply_page/widgets/opt_contract_dropdown.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditOptDialog extends StatefulWidget {
  final OptModel optModel;
  final Function(OptModel) onChange;
  const AddEditOptDialog({
    super.key,
    required this.onChange,
    required this.optModel,
  });

  @override
  State<AddEditOptDialog> createState() => _AddEditOptDialogState();
}

class _AddEditOptDialogState extends State<AddEditOptDialog> {
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
                'Add batch'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              const SizedBox(height: 40),
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
                                optModel.contract = value;
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
                  buttonText: 'Add',
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
