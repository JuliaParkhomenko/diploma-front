part of 'statistics_cubit.dart';

@immutable
abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final List<Statistics> statistics;
  StatisticsLoaded(this.statistics);
}

class StatisticsError extends StatisticsState {
  final String error;
  StatisticsError(this.error);
}
