import 'package:diploma_frontend/enums/role.dart';
import 'package:flutter/material.dart';

class RoleDropDown extends StatefulWidget {
  final Function(Role) onChange;
  const RoleDropDown({
    super.key,
    required this.onChange,
  });

  @override
  State<RoleDropDown> createState() => _RoleDropDownState();
}

class _RoleDropDownState extends State<RoleDropDown> {
  String? value;

  final List<Map<String, String>> roles = [];
  @override
  void initState() {
    for (final i in [Role.admin, Role.director, Role.manager]) {
      roles.add({
        'value': i.getName(),
        'label': i.getName(),
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            return roles
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
            roles.first.entries.first.value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'OpenSans',
            ),
          ),
          value: value,
          items: roles
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
            widget.onChange(newValue!.getRole());
            setState(() {
              value = newValue;
            });
          },
        ),
      ),
    );
  }
}
