import 'package:flutter/material.dart';

class LanguageService {
  static const Locale fallbackLocale = Locale('uk', 'UA');
  static const String path = 'assets/language';

  static const List<Locale> supportedLocales = [
    Locale('uk', 'UA'),
    Locale('en', 'US'),
  ];
}
