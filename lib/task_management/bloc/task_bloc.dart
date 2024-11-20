import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oaap/task_management/data/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent,TaskState>{
  final FirebaseFirestore store = FirebaseFirestore.instance;
  
  TaskBloc():super(DoNothingState()){
    on<AddTask>(_addTask);
    on<RetrieveTasks>(_retrieveTasks);
  }

  Future<void> _addTask(AddTask event, Emitter<TaskState> emit) async{
    emit(TaskLoadingState());
    try{
      store.collection('Tasks').add({
          'title': event.task.title,
          'description': event.task.description,
          'client': event.task.client,
          'category': event.task.category,
          'dateInitiated': event.task.dateInitiated,
          'dateDue': event.task.dateDue,
          'responsibleUser': event.task.responsibleUser
        }
      );
      emit(const PopUpMessageState(message: 'Task Added successfully.'));
    }catch (e){
      emit(PopUpMessageState(message: 'Error adding task: ${e.toString()}'));
    }
  }

  Future<void> _retrieveTasks(RetrieveTasks event, Emitter<TaskState> emit) async{
    emit(TaskLoadingState());
    try{
      QuerySnapshot snapshot = await store.collection('Tasks').get();

      List<Task> tasks = snapshot.docs.map((doc) {
        return Task.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      emit(FetchedTasks(tasks: tasks));
    }catch (e){
      emit(TaskErrorState(error: e.toString()));
    }
  }

}

//  final String title;
//   final String description;
//   final String client;
//   final String category;
//   final String dateInitiated;
//   final String dateDue;
//   final String responsibleUser;