part of 'application_cubit.dart';

@immutable
abstract class ApplicationState {}

class ApplicationInitial extends ApplicationState {}

class ApplicationLoading extends ApplicationState {}

class ApplicationLoaded extends ApplicationState {
  final List<Application> applications;
  ApplicationLoaded(this.applications);
}

class ApplicationError extends ApplicationState {
  final String error;
  ApplicationError(this.error);
}
