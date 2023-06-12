part of 'expired_batches_cubit.dart';

@immutable
abstract class ExpiredBatchesState {}

class ExpiredBatchesInitial extends ExpiredBatchesState {}

class ExpiredBatchesLoading extends ExpiredBatchesState {}

class ExpiredBatchesLoaded extends ExpiredBatchesState {
  final List<ExpiringBatch> expiredBatches;
  ExpiredBatchesLoaded(this.expiredBatches);
}

class ExpiredBatchesError extends ExpiredBatchesState {
  final String error;
  ExpiredBatchesError(this.error);
}
