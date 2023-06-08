import 'package:diploma_frontend/blocs/supply_contracts/supply_contracts_cubit.dart';
import 'package:diploma_frontend/models/supply_condition.dart';
import 'package:diploma_frontend/models/supply_contract.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class ExpiringContractsTable extends StatefulWidget {
  const ExpiringContractsTable({super.key});

  @override
  State<ExpiringContractsTable> createState() => _ExpiringContractsTableState();
}

class _ExpiringContractsTableState extends State<ExpiringContractsTable> {
  int? selectedId;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<SupplyContractsCubit, SupplyContractsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is SupplyContractsInitial) {
          final SupplyContractsCubit cubit = BlocProvider.of(context);
          cubit.featchContracts(old: false);
        }

        if (state is SupplyContractsLoading) {
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 60,
              child: getTableHeader(size, context),
            ),
          );
        }

        if (state is SupplyContractsLoaded) {
          if (state.contracts.isEmpty) {
            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 60,
                child: getTableHeader(size, context),
              ),
            );
          }

          return Flexible(
            child: ListView.builder(
              itemCount: state.contracts.length,
              itemBuilder: (context, index) {
                final SupplyContract contract = state.contracts[index];

                if (index == 0) {
                  return Column(
                    children: [
                      getTableHeader(size, context),
                      const SizedBox(height: 5),
                      expandableWidget(
                        Container(
                          height: 60,
                          width: size.width,
                          color: selectedId != contract.id
                              ? Colors.white
                              : constants.Colors.greyTable,
                          child: getItem(contract, size, context),
                        ),
                        contract.supplyCondition,
                        size,
                        contract.id,
                      ),
                    ],
                  );
                }

                return expandableWidget(
                  Container(
                    height: 60,
                    width: size.width,
                    color: selectedId != contract.id
                        ? Colors.white
                        : constants.Colors.greyTable,
                    child: getItem(contract, size, context),
                  ),
                  contract.supplyCondition,
                  size,
                  contract.id,
                );
              },
            ),
          );
        }

        if (state is SupplyContractsError) {
          return Center(
            child: Text(state.error),
          );
        }

        return Container();
      },
    );
  }

  Widget expandableWidget(
    Widget widget,
    List<SupplyCondition> conditions,
    Size size,
    int spIndex,
  ) {
    return Column(
      children: [
        widget,
        if (selectedId == spIndex) const SizedBox(height: 10),
        if (selectedId == spIndex)
          SizedBox(
            width: size.width - 1,
            height: (conditions.length * 60) + 60,
            child: ListView.builder(
              itemCount: conditions.length,
              itemBuilder: (context, index) {
                final SupplyCondition condition = conditions[index];
                if (index == 0) {
                  return SizedBox(
                    width: size.width - 1,
                    child: Column(
                      children: [
                        getSubTableHeader(size, context),
                        SizedBox(
                          width: size.width - 1,
                          child: getCondition(condition, size, context),
                        ),
                      ],
                    ),
                  );
                }
                return getCondition(condition, size, context);
              },
            ),
          ),
        if (selectedId == spIndex) const SizedBox(height: 10),
      ],
    );
  }

  Widget getTableHeader(Size size, BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 60,
      color: constants.Colors.greyTable,
      child: Row(
        children: [
          getTitle(
            'Supplier name'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Start date'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'End date'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Min amount'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Max amount'.tr(context),
            size,
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget getSubTableHeader(Size size, BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 60,
      color: Colors.white,
      width: size.width - 10,
      child: Row(
        children: [
          getTitle(
            'Name'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Kind'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Maker'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Min amount'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Max amount'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Price per unit'.tr(context),
            size,
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget getCondition(SupplyCondition item, Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          fixedSize: MaterialStatePropertyAll(
            Size(size.width * .72, 60),
          ),
          backgroundColor: const MaterialStatePropertyAll(
            Color(0xfff8a636),
          ),
        ),
        onPressed: () async {},
        child: Row(
          children: [
            getTitle(item.productName, size),
            getTitle(item.kind, size),
            getTitle(item.maker, size),
            getTitle('${item.minAmount} ${item.productMeasurement.tr(context)}',
                size),
            getTitle('${item.maxAmount} ${item.productMeasurement.tr(context)}',
                size),
            getTitle(item.pricePerUnit.toString(), size),
          ],
        ),
      ),
    );
  }

  Widget getItem(SupplyContract item, Size size, BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        fixedSize: MaterialStatePropertyAll(
          Size(size.width * .72, 60),
        ),
      ),
      onPressed: () async {
        if (selectedId == item.id) {
          setState(() {
            selectedId = null;
          });
        } else {
          setState(() {
            selectedId = item.id;
          });
        }
      },
      child: Row(
        children: [
          getTitle(item.supplierName, size),
          getTitle(item.startDate.toString().substring(0, 10), size),
          getTitle(item.endDate.toString().substring(0, 10), size),
          getTitle(item.minAmount.toString(), size),
          getTitle(item.maxAmount.toString(), size),
        ],
      ),
    );
  }

  Widget getTitle(
    String title,
    Size size, {
    bool bold = false,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      width: (size.width * 0.72 + 12 /*- 24*/) / 5,
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
}
