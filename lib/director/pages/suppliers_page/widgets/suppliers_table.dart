// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:diploma_frontend/blocs/supplier/supplier_cubit.dart';
import 'package:diploma_frontend/director/pages/suppliers_page/widgets/edit_supplier_dialog.dart';
import 'package:diploma_frontend/models/supplier.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class SuppliersTable extends StatefulWidget {
  const SuppliersTable({
    super.key,
  });

  @override
  State<SuppliersTable> createState() => _SuppliersTableState();
}

class _SuppliersTableState extends State<SuppliersTable> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<SupplierCubit, SupplierState>(
      builder: (BuildContext context, SupplierState state) {
        if (state is SupplierInitial) {
          final SupplierCubit cubit = BlocProvider.of<SupplierCubit>(context);
          cubit.fetchSuppliers('');
        }
        if (state is SupplierLoading) {
          final SupplierCubit cubit = BlocProvider.of<SupplierCubit>(context);
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 60,
              child: getTableHeader(size, state, cubit),
            ),
          );
        }
        if (state is SupplierError) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is SupplierLoaded) {
          final SupplierCubit cubit = BlocProvider.of<SupplierCubit>(context);
          if (state.suppliers.isEmpty) {
            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 60,
                child: getTableHeader(size, state, cubit),
              ),
            );
          }
          return Flexible(
            child: ListView.builder(
              itemCount: state.suppliers.length,
              itemBuilder: (context, index) {
                final Supplier item = state.suppliers[index];

                if (index == 0) {
                  return Column(
                    children: [
                      getTableHeader(size, state, cubit),
                      Container(
                        height: 60,
                        color: constants.Colors.greyTable,
                        child: getItem(item, size),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    height: 60,
                    color: index % 2 != 0
                        ? Colors.white
                        : constants.Colors.greyTable,
                    child: getItem(item, size),
                  );
                }
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget getTitle(
    String title,
    Size size, {
    bool bold = false,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      width: (size.width * 0.72 - 24) / 4,
      //color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'OpenSans',
                color: Colors.black,
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget getItem(Supplier item, Size size) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        fixedSize: MaterialStatePropertyAll(
          Size(size.width * .72, 60),
        ),
      ),
      onPressed: () async {
        await showDialog(
            useRootNavigator: true,
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: EditSupplierDialog(
                  supplierId: item.id,
                  name: item.name,
                  address: item.address,
                  email: item.email,
                  phoneNumber: item.phoneNum,
                ),
              );
            });
      },
      child: Row(
        children: [
          // const SizedBox(
          //   width: 13,
          // ),
          getTitle(item.name, size),
          getTitle(item.address, size),
          getTitle(item.email, size),
          getTitle(item.phoneNum, size),
        ],
      ),
    );
  }

  Widget getTableHeader(Size size, SupplierState state, SupplierCubit cubit) {
    return Container(
      alignment: Alignment.topCenter,
      height: 60,
      color: Colors.white,
      child: Row(
        children: [
          // const SizedBox(
          //   width: 20,
          // ),
          getTitle(
            'Name'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Address'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Email'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Phone number'.tr(context),
            size,
            bold: true,
          ),
        ],
      ),
    );
  }
}
