part of 'performance_bloc.dart';

sealed class PerformanceState{
  const PerformanceState();
}

final class PerformanceLoadingState extends PerformanceState{}

final class FetchedPerformance extends PerformanceState{
  final Performance performance;
  const FetchedPerformance({required this.performance});
}

final class PerformanceErrorState extends PerformanceState{
  final String error;
  const PerformanceErrorState({required this.error});
}