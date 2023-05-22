import 'package:flutter/material.dart';

class KindDropdown extends StatefulWidget {
  final Function(int) onChange;
  final List<String> kinds;
  const KindDropdown({
    super.key,
    required this.onChange,
    required this.kinds,
  });

  @override
  State<KindDropdown> createState() => _KindDropdownState();
}

class _KindDropdownState extends State<KindDropdown> {
  String? value;

  final List<Map<String, String>> kinds = [];
  @override
  void initState() {
    if (widget.kinds.isEmpty || widget.kinds.first == '') {
      return;
    }
    widget.kinds.insert(0, '');
    for (final i in widget.kinds) {
      kinds.add({
        'value': i,
        'label': i,
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.kinds.isEmpty) {
      return Container();
    }
    if (widget.kinds.length == 1) {
      return Text(widget.kinds.first);
    }
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
            return kinds
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
            widget.kinds.first,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'OpenSans',
            ),
          ),
          value: value,
          items: kinds
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

// ————▄▀▀▀▄░————
// ▄███▀░◐░▄▀▀▀▄░░░░░░
// ░░▄███▀░◐░░░░▌░░░
// ░░░▐░▄▀▀▀▄░░░▌░░░░
// ▄███▀░◐░░░▌░░▌░░░░
// ░░░░▌░░░░░▐▄▄▌░░░░░
// ░░░░▌░░░░▄▀▒▒▀▀▀▀▄
// ░░░▐░░░░▐▒▒▒▒▒▒▒▒▀▀▄
// ░░░▐░░░░▐▄▒▒▒▒▒▒▒▒▒▒▀▄
// ░░░░▀▄░░░░▀▄▒▒▒▒▒▒▒▒▒▒▀▄
// ░░░░░░▀▄▄▄▄▄█▄▄▄▄▄▄▄▄▄▄▄▀▄
// ░░░░░░░░░░░▌▌░▌▌░░░░░
// ░░░░░░░░░░░▌▌░▌▌░░░░░
// ░░░░░░░░░▄▄▌▌▄▌▌░░░░░
