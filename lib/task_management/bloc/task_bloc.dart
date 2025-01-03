import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oaap/access_management/data/user_model.dart';
import 'package:oaap/authentication/data/curr_user.dart';
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

      User currUser = await CurrentUser().getCurrentUser();
      List<Task> tasks =[];

      if (currUser.role == 'admin' || currUser.role == 'moderator' ){
        
        QuerySnapshot snapshot = await store.collection('Tasks').get();
        tasks = snapshot.docs.map((doc) {
          return Task.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

      }else{ //employee
        // need to retrieve only those tasks jis ki clients and categories ka access ho current employee k pass
        tasks = await getTasksFromFirestore();
      }
      

      emit(FetchedTasks(tasks: tasks));
    }catch (e){
      emit(TaskErrorState(error: e.toString()));
    }
  }

  Future<List<Task>> getTasksFromFirestore() async {
    List<Task> accessibleTasks = [];

    User currUser = await CurrentUser().getCurrentUser();

    try {
      CollectionReference tasks = store.collection('Tasks'); // Fetch all tasks from Firestore
      QuerySnapshot querySnapshot = await tasks.get();

      for (var doc in querySnapshot.docs) { // Iterate through each task document
        String client = doc['client'] as String;
        String category = doc['category'] as String;

        // Check if the current user has access to this client and category
        List<String> usersWithAccess = await getUsersWithAccess(client, category);

        if (usersWithAccess.contains(currUser.email)) {
          // Add task to accessibleTasks list if the user has access
          accessibleTasks.add(Task.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
    } catch (e) {
      // Handle any errors
      debugPrint('Error fetching tasks ${e.toString()}');
    }

    return accessibleTasks;
  }

  Future<List<String>> getUsersWithAccess(String client, String category) async {
    List<String> useremails = [];

    try {
      // Reference to the usersWithAccess sub-collection for the given client and category
      final CollectionReference usersRef = store
          .collection('Clients')
          .doc(client)
          .collection('Categories')
          .doc(category)
          .collection('Access');

      // Fetch all documents in the usersWithAccess sub-collection
      final QuerySnapshot userSnapshot = await usersRef.get();

      // Iterate through each document and add the document ID (email) to the list
      for (var userDoc in userSnapshot.docs) {
        useremails.add(userDoc.id);
      }

      return useremails;
    } catch (e) {
      //print(e);
      return [];
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