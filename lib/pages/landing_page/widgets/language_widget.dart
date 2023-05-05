import 'package:diploma_frontend/services/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageWidget extends StatefulWidget {
  final Function(Locale) onChange;
  const LanguageWidget({
    super.key,
    required this.onChange,
  });

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  String? value;

  final List<Map<String, String>> languages = [
    {
      'value': 'uk',
      'label': 'UA',
    },
    {
      'value': 'en',
      'label': 'ENG',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: const SizedBox(),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      selectedItemBuilder: (context) {
        return languages
            .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem<String>(
                value: e['value'],
                child: Text(
                  e['label']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList();
      },
      hint: Text(
        context.locale.countryCode! == 'UA' ? 'UA' : 'ENG',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      value: value,
      items: languages
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
          .toList(),
      onChanged: (_) => onChanged(_!),
    );
  }

  void onChanged(String newValue) {
    widget.onChange(
      newValue == 'uk'
          ? ServiceLocator.languageService.supportedLocales[0]
          : ServiceLocator.languageService.supportedLocales[1],
    );
    setState(() {
      value = newValue;
    });
  }
}
