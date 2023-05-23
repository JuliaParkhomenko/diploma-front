import 'package:diploma_frontend/enums/urgency.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

class UrgencyDropDown extends StatefulWidget {
  final Function(String) onChange;

  const UrgencyDropDown({
    super.key,
    required this.onChange,
  });

  @override
  State<UrgencyDropDown> createState() => _UrgencyDropDownState();
}

class _UrgencyDropDownState extends State<UrgencyDropDown> {
  String? value;
  final List<String> urgency = [Urgency.notUrgent.name, Urgency.urgently.name];
  final List<Map<String, String>> products = [];
  @override
  void initState() {
    for (final i in urgency) {
      products.add({
        'value': i,
        'label': i,
      });
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant UrgencyDropDown oldWidget) {
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
                      e['label']!.tr(context),
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
            'Urgency'.tr(context),
            style: const TextStyle(
              //color: Colors.black87,
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
                    e['label']!.tr(context),
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
