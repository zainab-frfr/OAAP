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

final class EditTask extends TaskEvent{
  final Task task;
  const EditTask({required this.task});
}

final class MarkTaskComplete extends TaskEvent{
  final Task task; 
  const MarkTaskComplete({required this.task});
}