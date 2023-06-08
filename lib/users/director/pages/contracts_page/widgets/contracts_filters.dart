import 'package:diploma_frontend/blocs/supply_contracts/supply_contracts_cubit.dart';
import 'package:diploma_frontend/users/manager/pages/stocks_page/widgets/search_textfield.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class ContractsFilters extends StatefulWidget {
  final Function(bool) onChanged;
  final bool old;
  const ContractsFilters({
    super.key,
    required this.old,
    required this.onChanged,
  });

  @override
  State<ContractsFilters> createState() => _ContractsFiltersState();
}

class _ContractsFiltersState extends State<ContractsFilters> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController makerController = TextEditingController();
  String name = '';
  String product = '';
  String maker = '';

  late bool old = widget.old;

  @override
  Widget build(BuildContext context) {
    final SupplyContractsCubit cubit = BlocProvider.of(context);
    return Row(
      children: [
        // SizedBox(
        //   height: 32,
        //   width: 200,
        //   child: SearchTextfield(
        //     hintText: 'Search by supplier name'.tr(context),
        //     onChanged: (value) {
        //       name = value;
        //       cubit.featchContracts(
        //         old: widget.old,
        //         productName: product,
        //         supplierName: name,
        //         maker: maker,
        //       );
        //     },
        //   ),
        // ),
        // const SizedBox(width: 30),
        SizedBox(
          height: 32,
          width: 200,
          child: SearchTextfield(
            hintText: 'Search by product'.tr(context),
            onChanged: (value) {
              product = value;
              cubit.featchContracts(
                old: widget.old,
                productName: product,
                supplierName: name,
                maker: maker,
              );
            },
          ),
        ),
        const SizedBox(width: 30),
        SizedBox(
          height: 32,
          width: 200,
          child: SearchTextfield(
            hintText: 'Search by maker'.tr(context),
            onChanged: (value) {
              maker = value;
              cubit.featchContracts(
                old: widget.old,
                productName: product,
                supplierName: name,
                maker: maker,
              );
            },
          ),
        ),
        const SizedBox(width: 30),
        Row(
          children: [
            Text(old ? 'Past' : 'Active'),
            Switch(
              value: old,
              onChanged: (value) {
                setState(() {
                  old = value;
                });

                widget.onChanged(value);

                cubit.featchContracts(
                  old: value,
                  productName: product,
                  supplierName: name,
                  maker: maker,
                );
              },
            ),
          ],
        ),
        const Expanded(
          child: SizedBox(),
        ),
        DefaultAddButton(
          buttonText: 'Add new',
          onTap: () {
            Routemaster.of(context).push('/contracts/add');
          },
        ),
      ],
    );
  }
}
