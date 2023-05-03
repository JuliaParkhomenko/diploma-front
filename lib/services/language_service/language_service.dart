import 'package:flutter/material.dart';

class LanguageService {
  final Locale fallbackLocale = const Locale('uk', 'UA');
  final String path = 'assets/language';

  final List<Locale> supportedLocales = [
    const Locale('uk', 'UA'),
    const Locale('en', 'US'),
  ];
}
