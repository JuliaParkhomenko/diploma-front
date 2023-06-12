part of 'manager_cubit.dart';

@immutable
abstract class ManagerState {}

class ManagerInitial extends ManagerState {}

class ManagerLoaded extends ManagerState {
  final List<AdminUser> managers;
  ManagerLoaded(this.managers);
}
