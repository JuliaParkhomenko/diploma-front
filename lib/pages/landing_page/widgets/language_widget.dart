import 'package:diploma_frontend/services/language_service/language_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
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
  String? value;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
      hint: Text(
        context.locale.countryCode! == 'UA' ? 'UA' : 'ENG',
        style: TextStyle(
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
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (newValue) {
        setState(() {
          if (newValue != null) {
            value = newValue;
            print(value);
            EasyLocalization.of(context)!.setLocale(
              value == 'uk'
                  ? LanguageService.supportedLocales[0]
                  : LanguageService.supportedLocales[1],
            );
            // context.setLocale(
            //   value == 'uk'
            //       ? LanguageService.supportedLocales[0]
            //       : LanguageService.supportedLocales[1],
            //   //Locale('en', 'US'),
            // );
          }
        });
        setState(() {});
      },
    );
  }
}
