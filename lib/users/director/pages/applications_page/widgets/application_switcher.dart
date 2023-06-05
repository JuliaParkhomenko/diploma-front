import 'package:flutter/material.dart';

class ApplicationSwitcher extends StatefulWidget {
  final Function(bool) onChanged;
  const ApplicationSwitcher({super.key, required this.onChanged});

  @override
  State<ApplicationSwitcher> createState() => _ApplicationSwitcherState();
}

class _ApplicationSwitcherState extends State<ApplicationSwitcher> {
  bool past = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(past ? 'Past' : 'Active'),
        Switch(
          value: past,
          onChanged: (value) {
            widget.onChanged(value);
            setState(() {
              past = value;
            });
          },
        ),
      ],
    );
  }
}
