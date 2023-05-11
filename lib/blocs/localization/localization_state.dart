part of 'localization_cubit.dart';

@immutable
abstract class LocalizationState {}

class LocalizationInitial extends LocalizationState {}

class ChangeLocalState extends LocalizationState {
  final Locale locale;
  ChangeLocalState(this.locale);
}
