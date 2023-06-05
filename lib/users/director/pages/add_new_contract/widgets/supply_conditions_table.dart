// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:diploma_frontend/users/director/pages/add_new_contract/widgets/edit_conditions_dialog.dart';
import 'package:diploma_frontend/models/supply_condition.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

List<SupplyCondition> supplyConditions = [
  SupplyCondition(
      id: 5,
      productName: 'Картопля',
      productMeasurement: 'кг',
      kind: 'kind',
      maker: 'maker',
      pricePerUnit: 15,
      minAmount: 25,
      maxAmount: 100),
  SupplyCondition(
      id: 7,
      productName: 'Борошно',
      productMeasurement: 'кг',
      kind: 'kind',
      maker: 'maker',
      pricePerUnit: 27,
      minAmount: 30,
      maxAmount: 150)
];

class SupplyConditionsTable extends StatefulWidget {
  final bool update;
  const SupplyConditionsTable({
    super.key,
    required this.update,
  });

  @override
  State<SupplyConditionsTable> createState() => _SupplyConditionsTableState();
}

class _SupplyConditionsTableState extends State<SupplyConditionsTable> {
  @override
  void didUpdateWidget(covariant SupplyConditionsTable oldWidget) {
    setState(() {
      supplyConditions;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (supplyConditions.isEmpty) {
      return Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 60,
          child: getTableHeader(size),
        ),
      );
    }
    return Flexible(
      child: ListView.builder(
        itemCount: supplyConditions.length,
        itemBuilder: (context, index) {
          final SupplyCondition item = supplyConditions[index];

          if (index == 0) {
            return Column(
              children: [
                getTableHeader(size),
                Container(
                  width: size.width,
                  height: 60,
                  color: constants.Colors.greyTable,
                  child: getItem(item, size, index),
                ),
              ],
            );
          } else {
            return Container(
              height: 60,
              color: index % 2 != 0 ? Colors.white : constants.Colors.greyTable,
              child: getItem(item, size, index),
            );
          }
        },
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
      width: (size.width * 0.72 - 24) / 6,
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

  Widget getItem(SupplyCondition item, Size size, int index) {
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
                child: EditConditionDialog(
                  product: item.productName,
                  kind: item.kind,
                  maker: item.maker,
                  minBatch: item.minAmount,
                  maxBatch: item.maxAmount,
                  pricePerUnit: item.pricePerUnit,
                  dialogName: 'Editing supply condition',
                  onChange: (SupplyCondition editedSupplyCondition) {
                    setState(() {
                      supplyConditions[index] = editedSupplyCondition;
                    });
                  },
                ),
              );
            });
      },
      child: Row(
        children: [
          // const SizedBox(
          //   width: 13,
          // ),
          getTitle(item.productName, size),
          getTitle(item.kind, size),
          getTitle(item.maker, size),
          getTitle(item.pricePerUnit.toString(), size),
          getTitle(item.minAmount.toString(), size),
          getTitle(item.maxAmount.toString(), size),
        ],
      ),
    );
  }

  Widget getTableHeader(Size size) {
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
            'Product'.tr(context),
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
            'Price per unit'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Min amount batch'.tr(context),
            size,
            bold: true,
          ),
          getTitle(
            'Max amount batch'.tr(context),
            size,
            bold: true,
          ),
        ],
      ),
    );
  }
}
