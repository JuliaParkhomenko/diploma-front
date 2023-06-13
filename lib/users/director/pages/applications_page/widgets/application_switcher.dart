// ignore_for_file: avoid_positional_boolean_parameters

import 'package:diploma_frontend/services/language_service/app_localization.dart';
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
        Text(
          past ? 'Past'.tr(context) : 'Active'.tr(context),
        ),
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
