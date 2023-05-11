import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static const String _databaseCode = 'locale';

  Future<void> changeLocale(String code) async {
    try {
      await prefs.setString(_databaseCode, code);
    } catch (_) {
      log(_.toString());
    }
  }

  static String getCachedLocale() {
    try {
      final String? languageCode = prefs.getString(_databaseCode);
      if (languageCode != null) {
        return languageCode;
      } else {
        return 'uk';
      }
    } catch (_) {
      return 'uk';
    }
  }
}
