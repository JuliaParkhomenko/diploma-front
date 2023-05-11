import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale? locale;
  AppLocalization({this.locale});

  static AppLocalization? of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalDelegate();

  static const String _path = 'assets/language/';

  late Map<String, String> _localStrings;

  Future<void> loadJsonFiles() async {
    final String encodedString =
        await rootBundle.loadString('$_path${locale!.languageCode}.json');

    final Map<String, dynamic> jsonMap = jsonDecode(encodedString);

    _localStrings = jsonMap.map(
      (key, value) => MapEntry(
        key,
        value.toString(),
      ),
    );
  }

  String translate(String key) {
    return _localStrings[key] ?? key;
  }
}

class _AppLocalDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'uk'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    final AppLocalization appLocal = AppLocalization(locale: locale);
    await appLocal.loadJsonFiles();
    return appLocal;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return true;
  }
}

extension TranslateString on String {
  String tr(BuildContext context) {
    return AppLocalization.of(context)!.translate(this);
  }
}
