part of 'user_action_cubit.dart';

@immutable
abstract class UserActionState {}

class UserActionInitial extends UserActionState {}

class UserActionLoading extends UserActionState {}

class UserActionLoaded extends UserActionState {
  final List<UserAction> userActions;
  UserActionLoaded(this.userActions);
}

class UserActionError extends UserActionState {
  final String error;
  UserActionError(this.error);
}
