part of 'batch_cubit.dart';

@immutable
abstract class BatchState {}

class BatchInitial extends BatchState {}

class BatchLoading extends BatchState {}

class BatchLoaded extends BatchState {
  final Batch batch;
  BatchLoaded(this.batch);
}

class BatchError extends BatchState {
  final String error;
  BatchError(this.error);
}
