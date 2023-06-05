import 'package:diploma_frontend/models/supplier.dart';
import 'package:flutter/material.dart';

class SuppliersDropdown extends StatefulWidget {
  final Function(int) onChange;
  final List<Supplier> suppliers;
  const SuppliersDropdown({
    super.key,
    required this.onChange,
    required this.suppliers,
  });

  @override
  State<SuppliersDropdown> createState() => _SuppliersDropdownState();
}

class _SuppliersDropdownState extends State<SuppliersDropdown> {
  String? value;

  final List<Map<String, String>> products = [];
  @override
  void initState() {
    for (final i in widget.suppliers) {
      products.add({
        'value': i.id.toString(),
        'label': i.name,
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.suppliers.isEmpty) {
      return Container();
    }
    if (widget.suppliers.length == 1) {
      return Text(widget.suppliers.first.name);
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
            widget.suppliers.first.name,
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
            widget.onChange(int.parse(newValue!));
            setState(() {
              value = newValue;
            });
          },
        ),
      ),
    );
  }
}
