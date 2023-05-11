import 'package:bloc/bloc.dart';
import 'package:diploma_frontend/services/language_service/language_service.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  Future<void> getSavedLanguage() async {
    final String cachedLocale = LanguageService.getCachedLocale();
    emit(ChangeLocalState(Locale(cachedLocale)));
  }

  Future<void> changeLanguage(String code) async {
    await ServiceLocator.languageService.changeLocale(code);
    emit(ChangeLocalState(Locale(code)));
  }
}
