part of 'kind_cubit.dart';

@immutable
abstract class KindState {}

class KindInitial extends KindState {}

class KindLoading extends KindState {}

class KindLoaded extends KindState {
  final List<String> kinds;
  //final OrderedBatchesFilter filter;
  KindLoaded(this.kinds /*, this.filter*/);
}

class KindError extends KindState {
  final String error;
  KindError(this.error);
}
