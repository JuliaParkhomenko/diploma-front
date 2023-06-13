import 'package:diploma_frontend/blocs/batch_supply/batch_supply_cubit.dart';
import 'package:diploma_frontend/models/batch_supply.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class SuppliesTable extends StatefulWidget {
  final Function(int?) onSelected;
  const SuppliesTable({
    super.key,
    required this.onSelected,
  });

  @override
  State<SuppliesTable> createState() => _SuppliesTableState();
}

class _SuppliesTableState extends State<SuppliesTable> {
  @override
  void initState() {
    final BatchSupplyCubit cubit = BlocProvider.of(context);
    cubit.featchSupplies();
    super.initState();
  }

  int? selectedId;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<BatchSupplyCubit, BatchSupplyState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is BatchSupplyInitial) {
          final BatchSupplyCubit cubit = BlocProvider.of(context);
          cubit.featchSupplies();
        }

        if (state is BatchSupplyLoading) {
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 60,
              child: getTableHeader(size, context),
            ),
          );
        }

        if (state is BatchSupplyLoaded) {
          if (state.supplies.isEmpty) {
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
              itemCount: state.supplies.length,
              itemBuilder: (context, index) {
                final BatchSupply contract = state.supplies[index];

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
                        contract.batches,
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
                  contract.batches,
                  size,
                  contract.id,
                );
              },
            ),
          );
        }

        if (state is BatchSupplyError) {
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
    List<BSupply> conditions,
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
                final BSupply condition = conditions[index];
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
            'Supply №'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Supply date'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Supplier'.tr(context),
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
      width: size.width,
      child: Row(
        children: [
          getTitle(
            'Product name'.tr(context),
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
            'Amount'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Warehouse name'.tr(context),
            size,
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget getCondition(BSupply item, Size size, BuildContext context) {
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
            getTitle(
                '${item.amount} ${item.productMeasurement.tr(context)}', size),
            getTitle(item.warehouseName, size),
          ],
        ),
      ),
    );
  }

  Widget getItem(BatchSupply item, Size size, BuildContext context) {
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
            widget.onSelected(null);
            selectedId = null;
          });
        } else {
          setState(() {
            widget.onSelected(item.id);
            selectedId = item.id;
          });
        }
      },
      child: Row(
        children: [
          getTitle(item.id.toString(), size),
          getTitle(item.date.substring(0, 10), size),
          getTitle(item.supplier, size),
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
      width: (size.width * 0.72 - 24) / 5,
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
