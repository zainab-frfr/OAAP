part of 'task_bloc.dart';

sealed class TaskState{
  const TaskState();
}

final class DoNothingState extends TaskState{}

final class TaskLoadingState extends TaskState{}

final class FetchedTasks extends TaskState{
  final List<Task> tasks;
  const FetchedTasks({required this.tasks});
}

final class PopUpMessageState extends TaskState{
  final String message;
  const PopUpMessageState({required this.message});
}

final class TaskErrorState extends TaskState{
  final String error;
  const TaskErrorState({required this.error});
}