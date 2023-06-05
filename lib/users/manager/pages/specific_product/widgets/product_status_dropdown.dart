import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

class ProductStatusDropDown extends StatefulWidget {
  final Function(String) onChange;
  final bool clear;
  final List<String> status;
  const ProductStatusDropDown({
    super.key,
    required this.clear,
    required this.onChange,
    required this.status,
  });

  @override
  State<ProductStatusDropDown> createState() => _ProductStatusDropDownState();
}

class _ProductStatusDropDownState extends State<ProductStatusDropDown> {
  String? value;

  final List<Map<String, String>> products = [];
  @override
  void initState() {
    for (final i in widget.status) {
      products.add({
        'value': i,
        'label': i,
      });
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProductStatusDropDown oldWidget) {
    setState(() {
      value = null;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(),
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
            return products
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
          hint: Text(
            'Status'.tr(context),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'OpenSans',
            ),
          ),
          value: value,
          items: products
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
            widget.onChange(newValue!);
            setState(() {
              value = newValue;
            });
          },
        ),
      ),
    );
  }
}
