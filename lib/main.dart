import 'package:diploma_frontend/my_app.dart';
import 'package:diploma_frontend/services/language_service/language_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: LanguageService.supportedLocales,
      path: LanguageService.path,
      fallbackLocale: LanguageService.fallbackLocale,
      child: const MyApp(),
    ),
  );
}
