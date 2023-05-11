import 'package:diploma_frontend/blocs/localization/localization_cubit.dart';
import 'package:diploma_frontend/my_app.dart';
import 'package:diploma_frontend/services/language_service/language_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageService.init();

  runApp(
    BlocProvider<LocalizationCubit>(
      create: (context) => LocalizationCubit()..getSavedLanguage(),
      child: const MyApp(),
    ),
  );
}
