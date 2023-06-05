import 'package:diploma_frontend/models/product.dart';
import 'package:flutter/material.dart';

class ProductsDropdown extends StatefulWidget {
  final String initialValue;
  final Function(int) onChange;
  final List<Product> products;
  const ProductsDropdown({
    super.key,
    required this.initialValue,
    required this.onChange,
    required this.products,
  });

  @override
  State<ProductsDropdown> createState() => _ProductsDropdownState();
}

class _ProductsDropdownState extends State<ProductsDropdown> {
  late String? value = widget.initialValue == '' ? null : widget.initialValue;

  final List<Map<String, String>> products = [];
  @override
  void initState() {
    print(value);
    for (final i in widget.products) {
      products.add({
        'value': i.id.toString(),
        'label': i.name,
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) {
      return Container();
    }
    if (widget.products.length == 1) {
      return Text(widget.products.first.name);
    }
    return Container(
      height: 40,
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
            widget.products.first.name,
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
