part of 'expiring_batches_cubit.dart';

@immutable
abstract class ExpiringBatchesState {}

class ExpiringBatchesInitial extends ExpiringBatchesState {}

class ExpiringBatchesLoading extends ExpiringBatchesState {}

class ExpiringBatchesLoaded extends ExpiringBatchesState {
  final List<ExpiringBatch> expiringBatches;
  ExpiringBatchesLoaded(this.expiringBatches);
}

class ExpiringBatchesError extends ExpiringBatchesState {
  final String error;
  ExpiringBatchesError(this.error);
}
