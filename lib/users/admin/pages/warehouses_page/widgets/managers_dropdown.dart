import 'package:diploma_frontend/models/admin_user.dart';
import 'package:flutter/material.dart';

class ManagersDropdown extends StatefulWidget {
  final Function(AdminUser) onChange;
  final List<AdminUser> managers;
  const ManagersDropdown({
    super.key,
    required this.onChange,
    required this.managers,
  });

  @override
  State<ManagersDropdown> createState() => _ManagersDropdownState();
}

class _ManagersDropdownState extends State<ManagersDropdown> {
  String? value;

  final List<Map<String, String>> managers = [];
  @override
  void initState() {
    for (final i in widget.managers) {
      managers.add({
        'value': i.id.toString(),
        'label': i.fullName,
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.managers.isEmpty) {
      return Container();
    }
    if (widget.managers.length == 1) {
      return Text(widget.managers.first.fullName);
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
            return managers
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
            widget.managers.first.fullName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'OpenSans',
            ),
          ),
          value: value,
          items: managers
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
            widget.onChange(widget.managers.firstWhere(
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
