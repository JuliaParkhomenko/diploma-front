import 'package:diploma_frontend/blocs/localization/localization_cubit.dart';
import 'package:diploma_frontend/services/language_service/language_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({
    super.key,
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
        LanguageService.getCachedLocale() == 'ua' ? 'UA' : 'ENG',
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

  Future<void> onChanged(String newValue) async {
    await BlocProvider.of<LocalizationCubit>(context).changeLanguage(newValue);

    setState(() {
      value = newValue;
    });
  }
}
