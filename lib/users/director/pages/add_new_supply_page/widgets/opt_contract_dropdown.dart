import 'package:diploma_frontend/models/opt_contract_model.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

class OptContractDropdown extends StatefulWidget {
  final Function(OptContractModel) onChange;
  final List<OptContractModel> categories;
  const OptContractDropdown({
    super.key,
    required this.onChange,
    required this.categories,
  });

  @override
  State<OptContractDropdown> createState() => _OptContractDropdownState();
}

class _OptContractDropdownState extends State<OptContractDropdown> {
  String? value;

  late final List<Map<String, String>> categories = List.generate(
      widget.categories.length,
      (i) => {
            'value': widget.categories[i].id.toString(),
            'label':
                '${'Kind'.tr(context)}: ${widget.categories[i].kind}, ${'Maker'.tr(context)}: ${widget.categories[i].maker}, ${'Price'.tr(context)}: ${widget.categories[i].pricePerUnit}, ${'Min amount'.tr(context)}: ${widget.categories[i].minAmount}, ${'Max amount'.tr(context)}: ${widget.categories[i].maxAmount}',
          });

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return Container();
    }
    if (widget.categories.length == 1) {
      final OptContractModel i = widget.categories.first;
      return Text(
        '${'Kind'.tr(context)}: ${i.kind}, ${'Maker'.tr(context)}: ${i.maker}, ${'Price'.tr(context)}: ${i.pricePerUnit}, ${'Min amount'.tr(context)}: ${i.minAmount}, ${'Max amount'.tr(context)}: ${i.maxAmount}',
      );
    }
    return Container(
      height: 42,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<String>(
          focusColor: Colors.white10,
          isExpanded: true,
          underline: const SizedBox(),
          icon: const RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.black,
            ),
          ),
          selectedItemBuilder: (context) {
            return categories
                .map<DropdownMenuItem<String>>(
                  (e) => DropdownMenuItem<String>(
                    value: e['value'],
                    child: Text(
                      e['label']!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                )
                .toList();
          },
          hint: const Text(
            '',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'OpenSans',
            ),
          ),
          value: value,
          items: categories
              .map<DropdownMenuItem<String>>(
                (e) => DropdownMenuItem<String>(
                  value: e['value'],
                  child: Text(
                    e['label']!,
                    style: const TextStyle(
                      //color: Colors.black,
                      fontFamily: 'OpenSans',
                      fontSize: 14,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (newValue) {
            widget.onChange(widget.categories.firstWhere(
                (element) => element.id == (int.tryParse(newValue!) ?? 0)));
            setState(() {
              value = newValue;
            });
          },
        ),
      ),
    );
  }
}
