part of 'ordered_batches_cubit.dart';

@immutable
abstract class OrderedBatchesState {}

class OrderedBatchesInitial extends OrderedBatchesState {}

class OrderedBatchesLoading extends OrderedBatchesState {}

class OrderedBatchesLoaded extends OrderedBatchesState {
  final List<OrderedBatch> orderedBatches;
  //final OrderedBatchesFilter filter;
  OrderedBatchesLoaded(this.orderedBatches /*, this.filter*/);
}

class OrderedBatchesError extends OrderedBatchesState {
  final String error;
  OrderedBatchesError(this.error);
}
