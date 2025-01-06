part of 'performance_bloc.dart';

sealed class PerformanceEvent{
  const PerformanceEvent();
}

final class FetchPerformanceInformation extends PerformanceEvent{
  final String email;
  const FetchPerformanceInformation({required this.email});
} 
