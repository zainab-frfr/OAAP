part of 'task_bloc.dart';

sealed class TaskEvent{
  const TaskEvent();
}

final class AddTask extends TaskEvent{
  final Task task;
  const AddTask({required this.task});
} 

final class RetrieveTasks extends TaskEvent{
  const RetrieveTasks();
}