import 'package:diploma_frontend/models/warehouse.dart';
import 'package:flutter/material.dart';

class WarehouseDropdown extends StatefulWidget {
  final Function(int) onChange;
  final List<Warehouse> warehouses;
  const WarehouseDropdown({
    super.key,
    required this.onChange,
    required this.warehouses,
  });

  @override
  State<WarehouseDropdown> createState() => _WarehouseDropdownState();
}

class _WarehouseDropdownState extends State<WarehouseDropdown> {
  String? value;

  final List<Map<String, String>> categories = [];
  @override
  void initState() {
    for (final i in widget.warehouses) {
      categories.add({
        'value': i.id.toString(),
        'label': i.name,
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.warehouses.isEmpty) {
      return Container();
    }
    if (widget.warehouses.length == 1) {
      return Text(widget.warehouses.first.name);
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
          hint: Text(
            widget.warehouses.first.name,
            style: const TextStyle(
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
            widget.onChange(int.tryParse(newValue!) ?? 0);
            setState(() {
              value = newValue;
            });
          },
        ),
      ),
    );
  }
}
