import 'package:diploma_frontend/models/warehouse.dart';
import 'package:flutter/material.dart';

class WarehouseSelector extends StatefulWidget {
  final Function(int) onChange;
  final List<Warehouse> warehouses;
  const WarehouseSelector({
    super.key,
    required this.onChange,
    required this.warehouses,
  });

  @override
  State<WarehouseSelector> createState() => _WarehouseSelectorState();
}

class _WarehouseSelectorState extends State<WarehouseSelector> {
  String? value;

  final List<Map<String, String>> warehouses = [];
  @override
  void initState() {
    for (final i in widget.warehouses) {
      warehouses.add({
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
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: DropdownButton<String>(
        //dropdownColor: Colors.lightGreen,
        focusColor: Colors.white10,
        underline: const SizedBox(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        selectedItemBuilder: (context) {
          return warehouses
              .map<DropdownMenuItem<String>>(
                (e) => DropdownMenuItem<String>(
                  value: e['value'],
                  child: Text(
                    e['label']!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
            fontWeight: FontWeight.bold,
          ),
        ),
        value: value,
        items: warehouses
            .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem<String>(
                value: e['value'],
                child: Text(
                  e['label']!,
                  style: const TextStyle(
                    //color: Colors.black,
                    fontWeight: FontWeight.bold,
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
    );
  }
}
